Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C776E74AD1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZh3-0001bp-DJ; Tue, 03 Dec 2024 15:40:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgd-0001LU-2h
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:40:00 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZga-0003B7-VH
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:39:58 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-29e61fcc3d2so2551078fac.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733258395; x=1733863195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VtJU01uIPGdmdncl+3eL+uuul8VbLmsEdgS8yMmO9ow=;
 b=VbhBZIMAD/9Q6LJbcateQyqFgJJcYmArYdsGIRKYMX4smux/tHs3e6f9wBcdmGJ/mH
 i0LMp8xypiszFbkdi2F4/t/B8j3eEeZHYmqwAgPc3ZGbynFWAapWHrwwyx7PoVONHUWg
 StAQwfAKpPE8R2jhDFsF/3X6mXmJSmuU/S0DFsF9wHDjmUjtWGDLx/D5R+YDufduK1l8
 evZ7SqofsAOXr3CgiPgj3l6beOylWkmbGTVHfaNlaU7E8C45P7praVaUTd8dPQFO6miq
 LtfHcnxwqgY6anexMJUgd+4h05FceI+afHxNuGXX05yM0Quh1SY9vbKTuwRfj7ZeuOa/
 ArGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733258395; x=1733863195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VtJU01uIPGdmdncl+3eL+uuul8VbLmsEdgS8yMmO9ow=;
 b=bkiVeUdsFW6wkphJZEQrG2uSoS2rNO6cqAJD+m+yVWvHYA4ZRJ6jdzcEEDwjBtiIij
 vYo0IpfsBOiMpgFAjjYKAenMEJwytLGtMM7Ybo+qo/MT16RiHBNKspimDgfFYlR4O/x+
 SDBZbWyA44SQIuyZ6IHcAQucc3E1fwzg4nlsyAMMUvO9Exw/6UXi9rUdMX+esRwMTQmc
 xFndwD2DxV/EMvvcHl1JBgror7+c2AtLcbnvy4Xi/bOYBeeRu4WjR/lGJqk2vDGwVlpD
 3kunL/WfX4QETOk4MXKMvVMzOpaM/av9bI6rsVKW8cHZQ0edJpYorg4if1V75xRNAljC
 SYjA==
X-Gm-Message-State: AOJu0YyWZE1+3/LbQRROaJaylWAVRvmUrF8Mtra7EXfnFJn+l94/nEaq
 vOPUldwhI6ngCiJI81vKWuzE5Dqufg7hL2tXzBn6Gtg+n4DobqFu10jcfgIQ8jXUChq+hQZ8rgP
 A2SM=
X-Gm-Gg: ASbGncu0xL2LjRxX1bbo8IKITudx8WaFBjZAPfGEX+aSwjThu27tyo6t6NeazrlZNws
 e6yO4/sTMaPoWl+TowvRgcYclKW2Cj7kIbcE4L9vK/6kSJ1F+fYC6HJ8wk2aCMTV2lhhLR7YRgu
 eKWR2nMVFIDIYCKslU0KwMIZSgF58Uu76N5Md1WaiAKLOMO50x5xKGngQ/FxtoUmJp8tN2LeUAA
 QmL+5Rph9jKiNH1oZB0njNSvV5aEvD1GFdpV/tNpsPmHJHfOA8Qc6AMSX7XOPW9gfWbDzwfXEzx
 tICCfhqtczStROAbEb+Tr+bSFfTn/0BjRTc3
X-Google-Smtp-Source: AGHT+IGKfv25Si/v1HbhMq25gnbOpgjiiCcSQRK37M2u77qAl/UUYV07Y0m6oHKfAOjDw649ocJwrg==
X-Received: by 2002:a05:6870:4944:b0:29d:c5e8:e41f with SMTP id
 586e51a60fabf-29e88576409mr4735052fac.5.1733258395680; 
 Tue, 03 Dec 2024 12:39:55 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e3ae09f25sm2684018fac.49.2024.12.03.12.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 12:39:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 05/11] softfloat: Pad array size in pick_nan_muladd
Date: Tue,  3 Dec 2024 14:39:42 -0600
Message-ID: <20241203203949.483774-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203203949.483774-1-richard.henderson@linaro.org>
References: <20241203203949.483774-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

While all indices into val[] should be in [0-2], the mask
applied is two bits.  To help static analysis see there is
no possibility of read beyond the end of the array, pad the
array to 4 entries, with the final being (implicitly) NULL.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 77f16ac158..06cfc6abb5 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -100,7 +100,7 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
         }
         ret = c;
     } else {
-        FloatPartsN *val[3] = { a, b, c };
+        FloatPartsN *val[R_3NAN_1ST_MASK + 1] = { a, b, c };
         Float3NaNPropRule rule = s->float_3nan_prop_rule;
 
         assert(rule != float_3nan_prop_none);
-- 
2.43.0


