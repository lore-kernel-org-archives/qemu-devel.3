Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934E1C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrz3-0004Hx-4X; Tue, 28 Jan 2025 15:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcry8-0002RE-P3
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:59 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcry7-0001fm-7y
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:56 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so67932275e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095232; x=1738700032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j6tDi/0gdkSymZHmT9r4SyePYRft7mgyt/Vt8slcogI=;
 b=O+EWv3k1wG34J1YzrUdp9KiM93WPXwtQxp/TfBEkPsI05sm8E454lSj1y4lkQ5PgZT
 LDVo8vt6hareON1RMgdwIfmxLOt0WPMZMBEQ5GV/9ja0FFgXfQcLMVZ64z+RZa4HUSz+
 lbzm8W2cgoDk0RRJBonM5obOp4wUOn3EcFn1cNN0dn7GqUI/iktQFSSlvCLKPilmCH7i
 VAv+zbDUoHbQ7PUIG9Ijv26o8JJS811oREZxebeEJHSNtVqPd+7LMqCDSeGcTO8P5ZWh
 /wDet5j9NXbfLCXZOcJpIat5PBlhgK6NsENjld03nJjtenMuX2GwRAZJIr3f3A0iN+xp
 OI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095232; x=1738700032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6tDi/0gdkSymZHmT9r4SyePYRft7mgyt/Vt8slcogI=;
 b=VvOW8uyZIl5tG8Hf8m6vXhWBja/TrvVUvJCHWMw0vpxSQXWRVQ+0cg/f/KpnxXgd+x
 DXlat+s9kAqJqdjWGfeQndTMqm9LipmDG35n4PJy3dViCr5m+rTLv4JYgHaObBpVXnc6
 2n8MJ6TGv9c9FVoJc5aUgB10M0R8ZdiQ56MAFwipPBgRky6HK+WS58GNkG2HJDx7C6lL
 SoRbAiYtjASq1rAxjqQi0UfFMzaTizTsIMV017+A4nysN/kfDz0RZwwC0y7HeVqY2GVC
 YUg8WSf3t9JofBVrKEsSEYwlxA9U1r4DzestnBQ1dI3WTmq/PYVn0H0weyPE7J/Glcnw
 wLFQ==
X-Gm-Message-State: AOJu0YxdGnO7B8HSM4WMjVWuI6cPmRRU+cQmymIfp7ql41zUf1nrOc9t
 IXCXSE4bfmek5GLEfSRzigSg6UQIt6YDRbO9KiwPA6Y/SPQsJ24K4rnBvg2AlNvmdK0WuIukz+w
 q
X-Gm-Gg: ASbGncuKCVv/uwjQ+zleQp0ga1Ao1EoYVhm2XkkdVt3n/P+SDGqpiTqHFBBFDB/iQ+T
 SiEPTYeRZAC/vQzqLxokr4w8t7s9DhJTsOxLgy5Il1Mj5omO97KAd/OdPA1AfMrWIDhjp4qgSUd
 AxcZ0XhIjTFa69CZBDJiayXPDlHD+LZ5Eg7WSZJL0P6UDnn/O8Wa51IbXQxpYZ+eilG9WQ00O12
 3M8MdpS4MTM4/kk/ZnPEScHoxI5BcqNpDVSlP1hkHi1f5UBLJik8R1TvFEtzo8OUpaJ97mnP6aD
 Qi9LqYDtvifuYLAs4rctGw==
X-Google-Smtp-Source: AGHT+IF76rrCxaolD14gANYf3IcGKEEI+IZ8vZSG22BVoEmIXrCy9X5Uietm1NuCX7CU6IhOkp9OxQ==
X-Received: by 2002:a05:600c:3c82:b0:430:57e8:3c7e with SMTP id
 5b1f17b1804b1-438dc4251f2mr2485665e9.28.1738095232359; 
 Tue, 28 Jan 2025 12:13:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/36] fpu: Fix a comment in softfloat-types.h
Date: Tue, 28 Jan 2025 20:13:11 +0000
Message-Id: <20250128201314.44038-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In softfloat-types.h a comment documents that if the float_status
field flush_to_zero is set then we flush denormalised results to 0
and set the inexact flag.  This isn't correct: the status flag that
we set when flush_to_zero causes us to flush an output to zero is
float_flag_output_denormal_flushed.

Correct the comment.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-22-peter.maydell@linaro.org
---
 include/fpu/softfloat-types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index c35fdaa5ae1..616c290145f 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -302,7 +302,7 @@ typedef struct float_status {
     Float3NaNPropRule float_3nan_prop_rule;
     FloatInfZeroNaNRule float_infzeronan_rule;
     bool tininess_before_rounding;
-    /* should denormalised results go to zero and set the inexact flag? */
+    /* should denormalised results go to zero and set output_denormal_flushed? */
     bool flush_to_zero;
     /* should denormalised inputs go to zero and set input_denormal_flushed? */
     bool flush_inputs_to_zero;
-- 
2.34.1


