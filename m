Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139BAE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbEl-0007td-6Q; Tue, 17 Dec 2024 12:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEg-0007rq-AL
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:19:54 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEW-00068g-0l
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:19:54 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so27798835e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455981; x=1735060781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dwa35LLkmv8iDK28O9YyGE+GvD3JdAOZsdGwZZf/LYg=;
 b=npyIEQ2+PkhDp/wQKQcnMJuWuyA3QCTxQ9KGAd3eCoXsrGaqxH3QX9POcWprfJrGtz
 pv4NtR6/q2pwTL0gAeRU+0fgnkiAaNrW+2l1la7iheg6yskITcT6IRgGMCvNgQHLo71f
 1M8uVNUES4j+45rxDqpPYMFJODRsshLtVUWmsYvfCmVfl6CySqQh4V0fR/vKCLeAUgok
 O+YBcl8T9aYqoQDnI1XBkQ9QNXxnSg7uEETEtbwIlre2/VdPImZgmS/AHkx5brKAVWVv
 1ODNdj48cRIVlc8dqJKn67k6n0kZFmtNt3066iOt8uKPi1XMHO+WpmL1cKj+CC91SiDF
 ggig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455981; x=1735060781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dwa35LLkmv8iDK28O9YyGE+GvD3JdAOZsdGwZZf/LYg=;
 b=tnB+fekfkm+2iPcgg9kjYCKM5wVWmqiOqRKo1jkGecl10MGCB2wlZO0Jq2/4xIGaJR
 qXlA+dCfDw4MpdQ+tV9oMgbHkrmMZxvDeqzvek9xMSfaNBtzJc1G6wgWa8MHI8kkki8g
 3MR1vd+KlRHxxBJhnJSouVENRKJBjBVxpAS1tRj4UM47I0TkNn3kunjQOn4YYMvNEWbl
 VDoFwXGYCRsIrl+l/7321g1RvT7tKWVEuEkBM5qhO9QUqMQsIttdFz7OXLMosxHGsnea
 LTweSR+Y4Qi/zL1qEoyxbjGd9pJGf21T3sNWHJliR2wOg8qnKeoFaTo9iv0cVCKrS1aE
 NhWQ==
X-Gm-Message-State: AOJu0YzM7a/bdgwPCI3N0jwEGCIRkXALzNZfqTzShwr9dwYUY6azig14
 xI+uoCFbTpaFvnd5lfmBuPvglX+FQX1lbtdahZ/KHgmzI7adtFryZKOp4HDQ9i2nl+y3mCI+ZPs
 G
X-Gm-Gg: ASbGncs5T6C+Ze+0E8FCLgD9LBu2OY/vpe+Cuk1iwnHoTuyRSqHmg5UU+9nvrfJB7jI
 zMy6uLkhifbjuppTI4hkJJ93mhx40XPFiW6+jjDC58JZT+B2Ei/tvS3/hDQGMVf+RrS5dNgqkft
 S5G9jxQvlTnDYRohKvuU+1Rz7A72nug0K3+0cbPn+PZuUyQsYrrgEsxXuY937QqhxkutehadWfK
 S3sNwjXvDwqWgnK4zZbVBTWIL3oyIkZbHwtcxGgqzPdsSOPcuL8vR7FHCzykTE=
X-Google-Smtp-Source: AGHT+IFxh3gfvHI+E1B55LjVoKYOs0RDmTsf+7gEjYgAEws8TbMic2IKWr/NqxASdwG7webNSWsimw==
X-Received: by 2002:a05:600c:3491:b0:435:b064:7dce with SMTP id
 5b1f17b1804b1-4362aa66f9fmr176100025e9.18.1734455980955; 
 Tue, 17 Dec 2024 09:19:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/19] target/arm: remove redundant code
Date: Tue, 17 Dec 2024 17:19:19 +0000
Message-Id: <20241217171937.3899947-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Denis Rastyogin <gerben@altlinux.org>

This call is redundant as it only retrieves a value that is not used further.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241212120618.518369-1-gerben@altlinux.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp_helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 5a19af509c3..df4ff464792 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1099,8 +1099,6 @@ float64 HELPER(rintd)(float64 x, void *fp_status)
 
     ret = float64_round_to_int(x, fp_status);
 
-    new_flags = get_float_exception_flags(fp_status);
-
     /* Suppress any inexact exceptions the conversion produced */
     if (!(old_flags & float_flag_inexact)) {
         new_flags = get_float_exception_flags(fp_status);
-- 
2.34.1


