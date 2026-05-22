Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AC0CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY2G-00083K-U2; Fri, 22 May 2026 18:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1H-0006kN-3X
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:05 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1C-0002dI-UQ
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:02 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2bd2051167eso37658205ad.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487617; x=1780092417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NYnhgOtc22ps1dbE8uAHDywGG6G9iAb2JOADAM47v90=;
 b=ScH34XSh4jamSrWNXtusVUtZEF5+FWnq/73/+cEVqsTGwqWsjw9VnjZO9BMZGcTbIU
 gvwFRL+uXiNZ3QIgbxgDFySMlXgRNg6kWsyzH82Ou0EiN11HuMlYQCuPIjM6F0/6OM5X
 FFMCZTNbFWtsol77Ge4/1P2u1lz1fb8xkyWSborVYJ0speevOoSaGvmppqxoWtYXEdUX
 nyStZA/NmGZPjq33m8UdGV4BjfmwvxHNKIgzOTPlQxSYSMBq5WaRTgCzg3WCio/BO3m6
 7SrtBm5r7f98dBRqW+sjDtCX5DjTiRInvIu45KVCs2/BdTwXe9errQxV/81bdYbqRHGP
 lT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487617; x=1780092417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NYnhgOtc22ps1dbE8uAHDywGG6G9iAb2JOADAM47v90=;
 b=IVdurheAMQqMMsS0k/CMpz50k9eNTCLooCddh6qn+mU73SZT4jqaFCJyPNK7Xjc6Xo
 xMKIoGXkypCyL7dDGxvfLsz4Xj/ST14TQXeAh4MBdLExOYBUhRLe7E0TQtrY7DJHVRZd
 LgIBXakoS2L3PfDswIVLPFAQ9Laa8s2VwH7wLCTF5B1KZrFmOc4jmKSt6mjHLFUo4JTK
 ofAMVweHmqusSoHqR6nT3zTtRG7lRJMzghziOOqzlLVzCzMoMfQrL25BCRYbxrAD3tJi
 sRVW8jem6gwkxPx3Mc7PeCuCUdBNQOI+kaKqKKZSx1d7vwV5mGPO207XR/GA/64h2lgT
 rLEQ==
X-Gm-Message-State: AOJu0YxRSXBRRgrl7ZpGABISkIqVAauDJ6nYiWduQxrg1oPMEVykfMJ1
 lmPCEPLTk8SQ68iCp5qxMuDEsLA9l96mG+2oSDEXXSAcPDEJJp6G4VKSD6R3YJGwLy8P7pcsg0x
 V4UYM
X-Gm-Gg: Acq92OF+rJd6mxm8L4XstMKuHnhNwn1unEPcZSEBb2EDteT/lTx+8r6KyGUnce7hidA
 GD/hZHH9CLfwQHbdvV8upJDXhByYyDvlaW4ne/7dqQrQwKeNTD9BKIP1YsscWZGEHsjsGF+2rt5
 UyPXm/Zu67SNuMgnokOUlKMQ9ttxtDElsR72GPpA7LwLlNyzRrMF2UY2jdoHfeIGIEYwevc0oG3
 UwrGayra2K7wtyMNwyAGJMZ/Apb0Jtuz+AZPsF0o02/aB9gJp9mX1zh3HK7QbKJHbvl390xHkqB
 danhg2ve6bYyZMjMGvAftVaxnI+Bszd2L7nuLcsbz6Ca/f9EYO+utPgwGzu9FAcdsDnqwfbF+vq
 Hn3vrlCeukaIqhMx0lFH5LmXH+F3sAl9eqHbTAa58bb/82IAAx7zT4dU6jzN4Z/jPckZDQM/pBW
 JiaYGtT5W4XS1WcQujqi4HCoKnd0YmY8HaEf3wE3w=
X-Received: by 2002:a17:903:19e7:b0:2b2:67ca:5ff9 with SMTP id
 d9443c01a7336-2beb026f4c4mr60082155ad.0.1779487616499; 
 Fri, 22 May 2026 15:06:56 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm27835745ad.21.2026.05.22.15.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:06:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 51/64] target/arm: Implement FMLALL{BB,BT,TB,TT} for SVE
Date: Fri, 22 May 2026 15:02:53 -0700
Message-ID: <20260522220306.235200-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 3 +++
 target/arm/tcg/sve.decode      | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index dc2484847e..f74e888580 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8387,3 +8387,6 @@ static bool do_fmla_fp8(DisasContext *s, arg_rxx *a, gen_helper_gvec_3_ptr *fn)
 
 TRANS(FMLAL_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_hb)
 TRANS(FMLAL_idx_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
+
+TRANS(FMLALL_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
+TRANS(FMLALL_idx_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 71ec09393c..06bbd7fa63 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1868,6 +1868,8 @@ BFMLSLT_zzzw    01100100 11 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
 FMLAL_hb        01100100 10 1 rm:5 100 idxn:1 10 rn:5 rd:5 &rxx idxm=0
 
+FMLALL_sb       01100100 00 1 rm:5 10 idxn:2  10 rn:5 rd:5 &rxx idxm=0
+
 ### SVE2 floating-point dot-product
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
@@ -1887,6 +1889,9 @@ BFMLSLT_zzxw    01100100 11 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
 FMLAL_idx_hb    01100100 idxn:1 01 .. rm:3 0101 .. rn:5 rd:5 \
                 &rxx idxm=%index4_19_10
 
+FMLALL_idx_sb   01100100 idxn:2  1 .. rm:3 1100 .. rn:5 rd:5 \
+                &rxx idxm=%index4_19_10
+
 ### SVE2 floating-point dot-product (indexed)
 
 FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
-- 
2.43.0


