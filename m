Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB835C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 17:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tduOq-0002Qy-GA; Fri, 31 Jan 2025 12:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tduOn-0002IB-Nv
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:01:45 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tduOl-0003UD-U9
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:01:45 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so26668775e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 09:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738342902; x=1738947702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lWSvsMYuQBKZpDDyRMNVEYMjFioDTfag2YV+tpjd9iE=;
 b=jbu2u4Fn0pV8VAJOgr5E3NfyrbN0cDBNzbzMRmxM8HsNaTz8kKKwzCPAaSVCE3hIdw
 oCrf5oTO5lrSBLJSDAehSJmmTDh087ywBlM0bnaccclC1oitJGoehVnJC7oWj4mnRSpW
 fMsRTq4Lk/rWVtCiZYAy9x1II6uBtgIYLy3lg77qkK01TTlnaCzvFnjBZiD+pdZkntVj
 vZ/jNk7FXLMLStCMJp0Mh8MfG5tQndCv6V8Qm1mEhyK2iI4cOD6Lei1YC0n5hG9ro1/9
 z48w078LO1BA9LfK/GkEOCfy9RJhr2B+8jhHX41efdhJCjzXO1c2jpzo6gJ7MGmnQGfr
 lYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738342902; x=1738947702;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lWSvsMYuQBKZpDDyRMNVEYMjFioDTfag2YV+tpjd9iE=;
 b=fAWIOGIAL5nukeNj+cHgwPn+6z/3YvG1LvMpuycrgbAvAFJ+WRklpkKBy/x0ouBPDf
 YWJJoEpZly6l2+4+gqNjZD8cuyJTG7+QaRxZF/3HuQzhor2iP2KMUV3t3EY9noxc1SMo
 YwDLtDZbE4WIbLhoC4Y7kUL0bbGpxyDvVheYutsZ76gCj7TR1gFHaOWhNnuBhAma2nYG
 ZdLBftLW9gvp4PYH+gP96fKyhXUHJ2/alC0NQG10ZpaOfxps6+9Qaw9x5aVYTT2yEmAX
 xJBMrTAOcOqun3vwxYF5jY+o5BB8HoOIlBFC/YD52Yq8paU73je6olVJdezh6QtToZvR
 tAtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8IMdPt7TkzmpSBYRKKHGXFd2mgIaH1F233yKqp4lrsM3nPhdkXBWgTFJyZ52nPg2O5Vt1lyEBb6XY@nongnu.org
X-Gm-Message-State: AOJu0Yy80f6V8PF3nzuZHWtFxaUaZ8ciG4D0PPGF0tZTrkMpmMoiq3zD
 iSn1ZSdyviXh+Nf/ukXTRGT/2zix1JtCNrIenmDhl/1M2FYVA/0cLCOGMIBN6o4=
X-Gm-Gg: ASbGncsQ2eHT+aWBVMMz17vO2729mEKaSMbTo0VCI0zdOU2wAg4VpDi06jV1AVEAeEi
 ZmHSYvITYhlMGiK58H91mPh4IzF4xL/7243U/tN8Ywj2auzIlZ4Y512Ip2c6MaGLxGTkHB/zb5M
 yjVosLo9yFeV4X2NlsDu4VKKAoQCqywLzm53B6jB5xXdFNG5sTf8/N4vsYcFDmaT9OWo23usUuW
 eEtcat3GLzB3QRu11tvGLcMFRt7En9pYWIJPDKXw4kmVvOH/jcBGDLZ9peBjSY3xLf+31X4f/5o
 1KcbdSfqD9mQK8hKQAhSuSRwPlIQUsGG+InDA+pJ/0AIRHV+UNGiLzQV5Yw=
X-Google-Smtp-Source: AGHT+IGtIMI3lnXKNwevh/BEqSEnZyCteULqwXLPBv+caEMiSTSIBaVKOvUErNiMhrbInbU7AyxjUw==
X-Received: by 2002:a5d:64ae:0:b0:38c:5bc1:1f03 with SMTP id
 ffacd0b85a97d-38c5bc12134mr7269906f8f.7.1738342900563; 
 Fri, 31 Jan 2025 09:01:40 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23de35csm60496715e9.10.2025.01.31.09.01.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 09:01:39 -0800 (PST)
Message-ID: <cca5ed6b-1066-46c4-9640-0db8e1cc4b63@linaro.org>
Date: Fri, 31 Jan 2025 18:01:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] hw/sd: QOMify omap-mmc, remove legacy APIs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250128104519.3981448-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/1/25 11:45, Peter Maydell wrote:
> This series QOMifies the omap-mmc device. The main reason for
> this is that this device is now the only remaining in-tree
> user of the legacy SD APIs defined in sdcard_legacy.h.
> The first 8 patches QOMify the device and do some minor
> cleanup on it. Patches 9 to 11 then remove the unused
> legacy APIs, deleting sdcard_legacy.h entirely. This includes
> letting us get rid of the me_no_qdev_me_kill_mammoth_with_rocks
> codepaths in sd.c.

Thanks for this long due cleanup!

Series queued squashing:

-- >8 --
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index d31456ad236..bbe7b971bbe 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -71,3 +71,2 @@ typedef struct OMAPMMCState {
      int cdet_enable;
-    int cdet_state;
      qemu_irq cdet;
@@ -611,9 +610,4 @@ static void omap_mmc_initfn(Object *obj)
      qdev_init_gpio_out_named(DEVICE(obj), &s->dma_rx_gpio, "dma-rx", 1);
-}

-static void omap_mmc_realize(DeviceState *dev, Error **errp)
-{
-    OMAPMMCState *s = OMAP_MMC(dev);
-
-    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS, dev, "sd-bus");
+    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS, DEVICE(obj), 
"sd-bus");
  }
@@ -622,3 +616,2 @@ static void omap_mmc_class_init(ObjectClass *oc, 
void *data)
  {
-    DeviceClass *dc = DEVICE_CLASS(oc);
      ResettableClass *rc = RESETTABLE_CLASS(oc);
@@ -626,3 +619,2 @@ static void omap_mmc_class_init(ObjectClass *oc, 
void *data)
      rc->phases.hold = omap_mmc_reset_hold;
-    dc->realize = omap_mmc_realize;
  }
---

