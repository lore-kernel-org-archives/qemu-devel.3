Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D72CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 14:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBDBp-0002xC-QJ; Tue, 21 Oct 2025 10:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBDBn-0002wk-LR
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:18:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBDBj-0002Nv-W5
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:18:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-475c1f433d8so2623895e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 07:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761056282; x=1761661082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ABz4jLJ287ZKpFUuvwLcoRtiXmZCAH5H8jWLrJQ0S9Y=;
 b=fekEJrR9gr2LLX9GJ2LluRCgzEq7+4MhvPh06hJYmGUWUhFD5kgNYfY2xg9k8sxdtP
 doHezVmAzs6eP2++S3bRAq2rLDv4WVB1qOLGXdff9V0TgrXA8SC019aGYZYy6Te9dDBP
 UaQjnLyFn9ERO91jCfepaTRWO5FLcpvdgzSW8KHYacWqmOhi+KdOtOjiSq+8rt1tWJss
 WFzsswG0DoULue8IBEY0ta8Oa6biWqIx1+K2rA7VEP/IPNQmD/db5tjYISeUZKc3WGZt
 h/xFOjHnx+ilyvtSwVR6g7lcY83AuBxTbXxUU0woUxb0Mz5S0hc6FIDX7pWBFhb7855K
 717A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761056282; x=1761661082;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ABz4jLJ287ZKpFUuvwLcoRtiXmZCAH5H8jWLrJQ0S9Y=;
 b=hLnjOAIwqPVDyIoGn2mUK15UGd79iWM+bn0nhn2si83PkyGnwAmRtO9glIR7lSdV53
 7mVdyCMcPoFLJTwoRGoI8iWvR20cxvoSz170JBtJgZtkEqu4UprScTIsz9refbyNJ8BB
 28wM4/BDtcTQ4S8uqky9l8LOWj/71Zs3QVX78I738dm1IHL2VK7WVUIOuPzTjn0h/lB/
 jGQZkwjDDVlFeR5j0o1rRRpU92EYbGwGsw6ORb7aQkKziaSSuV4s6D8QtJ86wS8Lkly/
 u1VsYHU7LxoW5dr8sjBhd774spPNQlSl/6m3J3tH7sV6/JRmXDdU4sRDreHNbUPfxQYH
 i1pw==
X-Gm-Message-State: AOJu0YxlxhZkf81siWQmI9j7d7JAst6UnE2mC4o6dND7pHX2cGBljEBZ
 wvV0fleo06k+Jju0NkEwrsSa11bZjdN1nrlBQiS+f3jYuruQZab1dgTSeyTrik6vcO4=
X-Gm-Gg: ASbGncuYZIw1dFmmvqgqk43GN2cfCMBMb+T2ftteM7ue+l54oeuf7ao8jcVxnVzgrS0
 5xEHBrt1HTv6w1gm+0vEv++Z554aJ7T0SC0LCTxziNkoVtxM/6ZV/ZnKX+YFF5n2N4wT24go2iw
 yHBuDuKUF2p3u+Mrhg7F3Cz8qF6Z7lgBqSloPO+xLDARh5t7uMdC3KjUE6awLiKtcMUbj5/Tdkz
 OhebHNaRpcsyHyDvegVAT0AL3pgKxAk0tKVDoym1SBduxGZTEbXDx08vt6k5DzvQrIMKVPSSrVT
 laUVY2TXgAjFJXIIyd0vs8W73QcCA4e4V0K51shzPIX78+P8MfsNt8UIIN96ON5iMDbXJJ/Hpj6
 SQPtYKrCq5tHO+Nm1SPN0HZ8+MF2xoniacyCmeIwjqxlWw2auNwn1ZK9ljDzrxLW6a6FTSeeQoW
 UwmnqwGep9niRo
X-Google-Smtp-Source: AGHT+IFn1NGxSejIQQHbIFh2Pgaz79SK5BWedaQ+JKzcc0SqABZ1v8snQEpGUyq5uuq/H6U2T600Tg==
X-Received: by 2002:a05:600c:34d0:b0:471:1717:409 with SMTP id
 5b1f17b1804b1-471179071b4mr110768795e9.23.1761056282294; 
 Tue, 21 Oct 2025 07:18:02 -0700 (PDT)
Received: from [192.168.69.221] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496c2c9dasm17773245e9.4.2025.10.21.07.17.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 07:17:59 -0700 (PDT)
Message-ID: <b1846b59-081d-46ca-bc65-e6ca26a5e158@linaro.org>
Date: Tue, 21 Oct 2025 16:17:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/audio: Remove intel_hda_and_codec_init()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251021131825.99390-1-philmd@linaro.org>
 <20251021131825.99390-3-philmd@linaro.org>
 <CAMxuvaxTYZTzWr85io2whE+soM8Ji58uV-BbfE8B9kpLzdFMwA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAMxuvaxTYZTzWr85io2whE+soM8Ji58uV-BbfE8B9kpLzdFMwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 21/10/25 15:24, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Oct 21, 2025 at 5:18 PM Philippe Mathieu-Daudé 
> <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> 
>     `-soundhw hda` was removed in commit 039a68373c4 ("introduce -audio
>     as a replacement for -soundhw").
> 
> 
> Sorry, that "hda" (= intel-hda + hda-duplex) short form is used by -audio.

Yes, it was deprecated for 2 releases but we missed to remove it
in commit 039a68373c4:

-- >8 --
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index bc77e3d8c9d..f38117057b9 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1311,17 +1311,16 @@ static const TypeInfo hda_codec_device_type_info = {
   * create intel hda controller with codec attached to it,
   * so '-soundhw hda' works.
   */
-static int intel_hda_and_codec_init(PCIBus *bus)
+static int intel_hda_and_codec_init(PCIBus *bus, const char *audiodev)
  {
      DeviceState *controller;
      BusState *hdabus;
      DeviceState *codec;

-    warn_report("'-soundhw hda' is deprecated, "
-                "please use '-device intel-hda -device hda-duplex' 
instead");
      controller = DEVICE(pci_create_simple(bus, -1, "intel-hda"));
      hdabus = QLIST_FIRST(&controller->child_bus);
      codec = qdev_new("hda-duplex");
+    qdev_prop_set_string(codec, "audiodev", audiodev);
      qdev_realize_and_unref(codec, hdabus, &error_fatal);
      return 0;
  }
---

Users should be now using "-device intel-hda -device hda-duplex"
instead of "-audio hda".

