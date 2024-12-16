Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD416E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN28y-0007Iu-Kj; Sun, 15 Dec 2024 22:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28u-0007HA-Nk
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:36 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28t-0005zI-0c
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:36 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-71e17ab806bso2057922a34.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321094; x=1734925894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8Da/WqYqvOtbbG4N3/jUJ/9lxe1TiWeaeAujQBtwkcw=;
 b=knjJb8GgFmD7b4C1KDJdKvlONh5F9Mr3FZt3Zt7DolGFt+9me7S35jaM4+/bw11yOp
 YbivJncxMVbJG0ZZb3/07zUtIPz8AsAL7Njth31avtQLQ+dWJBlH27jJPXL/d/YRvrLZ
 rILcxWzsUY54e7OYlIca6RFmOnbnaE/SL7mLAGVufT4QtdQ1K15xokVmt5I9nPCsUneA
 TErlCoPmmrLLY9rJI/nsaG2vFpbyVmRCo96U72N91vWtwXMCDZb6vDKU3gSC98IQ/FLW
 ls7NFnD8FyaF0Su5DMpwERE3/1RRk4R2HHyOBZBfCXlHWPIv6nfhTSJIdnuO3OknZJon
 brUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321094; x=1734925894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Da/WqYqvOtbbG4N3/jUJ/9lxe1TiWeaeAujQBtwkcw=;
 b=wnVaBbp4w/FguodMDz87TTJLWUIAKFT7jAWmMVIcXTKDQfGkVtbOts1z11EAhCInU8
 PL5e63fV450Om1LRbK84uA9cvFYfYWYZv7aAv12Rs9tOPmwwMNifPvgjrFAjAewN5S6Q
 Twd2fSBvcEKC8HisOmPdlX/jyzVINh2JCTdlOGQo/imUwJEVxDc+VIH1YbsgMak4+a1W
 yWM4yqZA9K4g9z/FasqHg/iajAVQHOcPBReTLguHL/GvQnZRdesLMYln9wqaD5JYHUSD
 2e+ysWUCL1yk7ZFJ/R0Igad2pTwgnY2S826kA4b+CEfiCSMp0F6Yz+5N+BdaUxms8UcG
 5kdA==
X-Gm-Message-State: AOJu0YymmsHcCfkbeHI7PRC4/YahsF19rnOoSnJBodq/JkqJWbCz8Ukp
 I3k/ZBaRDTLi/8x2hLu0fKkGt/lpX/DkvMZUdG/IupQcIR8Ti2V0DJS4d0U8VktRKNavCWOi9o9
 JljL5lzvb
X-Gm-Gg: ASbGnct+KDj0G78VD/cKb2OVPJVMlL3U+27sK3zKWvF81BjHUJH1lblRuw3yRTvSRPX
 WixupYlwBI4db3NEGnA3sO0pJhIGtYh0KtKopMFSkIPzReQBrvrZh5eDoY8yg07wrpNQUxaEW3U
 ePQmxNo1A7K6TIv2dIsNDYiO58rnyCZkhsi5VdsUiY8ZXavWf4fXmOr+cOPPFdzWkXLxl7H3FBR
 i1zb0nuQNq6hGZ979jludK9UzgyQpVFhQJHR6trgaIMUFbMnrl3oug42z3Sco6SALCczRfM1n1W
 h22TfmRpQZ/xwA1zE5NKRe5oXDGvCXVhSlnoY7Coj2c=
X-Google-Smtp-Source: AGHT+IHy7mIZg14xaDlGU4haWv91NuFgnMCzHVt6ch8h97+sT0izczieC6CuwMJpAY7IG01U91A/Ow==
X-Received: by 2002:a05:6830:6505:b0:717:fe7d:a19e with SMTP id
 46e09a7af769-71e3b878156mr5565772a34.11.1734321093949; 
 Sun, 15 Dec 2024 19:51:33 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/24] hw/s390x: Remove empty Property lists
Date: Sun, 15 Dec 2024 21:50:53 -0600
Message-ID: <20241216035109.3486070-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/s390x/3270-ccw.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
index 69e6783ade..3a8930dfd1 100644
--- a/hw/s390x/3270-ccw.c
+++ b/hw/s390x/3270-ccw.c
@@ -150,15 +150,10 @@ out_err:
     g_free(sch);
 }
 
-static Property emulated_ccw_3270_properties[] = {
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void emulated_ccw_3270_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_props(dc, emulated_ccw_3270_properties);
     dc->realize = emulated_ccw_3270_realize;
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
-- 
2.43.0


