Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EBECCD184
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cEg-00024H-1i; Wed, 08 Oct 2025 18:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cDO-0001L4-HJ
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:56 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCX-0007QF-OC
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:51 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-781206cce18so395801b3a.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960798; x=1760565598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTKzFsxEh1g5nw3IQ5A0hf1nPRnygZE/fIp9mQ9w54I=;
 b=GFvsDmLEDnGfNvHJhv0EHDb2PRi09SVMM0btE8Vk1G5MhmwIKbPxTavUjma9OilddO
 27vdYz6pVKX7r3vvmQIBVwW11NQ23y1+t1TUNRB15jJqX998fm/af6nFw5Uw6qV0LfuL
 0dPnh385r+rZDuReOZKUGVTysAyWalphZKNjObkEe84VsfDLgtIIuyHY1hqD4WBDaeOt
 j3QYcsTMF1OXdd9p1o6KNBqHb2tQ+W1XEYdPwIeocp+XrHpVaPUI6CUJGJQb6s3dvK1L
 sHoJSuo9g3UNYUKM7zt6u3kxMOagRRNJPioYGnpAUM6OI1JxU/1l0WuUdXIJufGenvyB
 N//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960798; x=1760565598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTKzFsxEh1g5nw3IQ5A0hf1nPRnygZE/fIp9mQ9w54I=;
 b=hp/WeWT9R4vKBMWPXdwe31KBE2zncY7lORIr4akQ6StBGN9oZtltWEPRWQjKioKfJQ
 Rz5sRqBT98bnp22Sz5F5ubNtB5xGjciGLQo07sCADKYDF/hb07NWT+tmVGl+se/kgIGK
 pK/O4BfOF49RHjxAcrU60+QnCIj58nTf8Stf+KzQuHq48iXn4nTRM2R/gRBmJxZ5F50Y
 lKZSsCnFfFvRGhv0bHOeiWoUmQsvWjfPsC5p8D8I1D2V3MWRVq2LEo0xgtFg+FZZy53b
 WNFniZF+LuF3vTL0AGSBG8Zfje+bcfbGBRdGEPUR0Pr1/oFvVrWDwAPg7rGu5Vv71uWL
 +jIw==
X-Gm-Message-State: AOJu0YzDj8fkjH2Fp5tm847zfUa3PbkfM+EF/UwF/E6eG7c7ZBatH17i
 31IH1mbFU1R5qfYHyWfeyWt5NfKOAnhe7zMmmwJ4j+DschvGEzygxaard9pWvrtZb5IL0r5HshO
 RzOB4pCk=
X-Gm-Gg: ASbGncvzbZ8x6gZpliVop65r9BrJxAgSiWO4N0hP7VV8nzOIky3LrReMQAuSez63+lc
 vd6y6q++h55jbUQNeQZCq++peG/8bn0fiT4ZmIgW6twXNrG+tjP0m4DNbuIYq7aRiGFrbnYwMo2
 vhTyzv3uwG4zwjSt89MXaf4rNAVmHiqhKCAuSspdbrCEe0RFtpeFeJLHVe4VY5sZPXEvhjjfJpe
 /Z3Ynoju8XT4BqfNmNKXrlQblVqaHs4zV45w8qE2vdbhfTa3MV5yltjB0tSJcwyqEL0ClWkz2nj
 +rts7VxQPZNLrQVIsfCBZbn3r4IQjdyuFXH0kbthWoD1YUmNH+GkwgQhVGPVLrRTATjPqH70dDe
 GC9iqy9nl2N7o9WzOt8jGBva/Z8mnRxnKQYifAVSWJfmIzSkGWOyUyhxz
X-Google-Smtp-Source: AGHT+IGPElA6LyKGONa2uJy2l1RySpApELCF5vOSTiV5b5YbzEOMxqdgnMKg6XQnysJoXGAxldVX/w==
X-Received: by 2002:a05:6a00:14d0:b0:77e:d2f7:f307 with SMTP id
 d2e1a72fcca58-79398c9763fmr6093297b3a.9.1759960797592; 
 Wed, 08 Oct 2025 14:59:57 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 65/73] linux-user/aarch64: Release gcs stack on thread exit
Date: Wed,  8 Oct 2025 14:56:05 -0700
Message-ID: <20251008215613.300150-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index dffe6c2016..47a6b58cf5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9429,6 +9429,12 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                              FUTEX_WAKE, INT_MAX, NULL, NULL, 0);
             }
 
+#ifdef TARGET_AARCH64
+            if (ts->gcs_base) {
+                target_munmap(ts->gcs_base, ts->gcs_size);
+            }
+#endif
+
             object_unparent(OBJECT(cpu));
             object_unref(OBJECT(cpu));
             /*
-- 
2.43.0


