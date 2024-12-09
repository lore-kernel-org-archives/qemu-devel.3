Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2673AE77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 06:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKXEL-0006MS-AB; Mon, 09 Dec 2024 01:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tKXEJ-0006MI-Cj
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:26:51 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tKXEH-0002VD-Me
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:26:51 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21654fdd5daso3790165ad.1
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 22:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1733725608; x=1734330408;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eLmpaBBARj329c7M5Xk/S6pYF7fz3IsMV7SNdg4PeHA=;
 b=RUKBrDhYHUyjT4yKq/VmmrqBHyUqsIwmsXw+70NGkh7cSf1djfOI3VmvxBc0vI1DSU
 /ZRmd8izdV5rkp114FKUBJGQDOHE4tFzBq8nOFUitK3JGriDXa684oTCOJx/oNytZUtF
 PfWk3WbjWmnJ9NKpMpY/zVFU7EqRDwNSP9W/FxDjpDBqJ7mgc77BTHHn0rW4oGo7unOr
 QvWDjabJ5S4/aLcUsCqi/+txiNu1HyGHhYFFbNHVRzJSlDs8TeQi18fOMN6KJ3//9qMu
 f8/a9o1AA9ZfnFI4R4zDjCpJsDLP+eOFTkRYlNM9b7fzGNmOT5sxbh0vgjK+g/APQCdK
 A11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733725608; x=1734330408;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eLmpaBBARj329c7M5Xk/S6pYF7fz3IsMV7SNdg4PeHA=;
 b=FM/bT4CBv90J7o+WsZ11zxsxXUO5lTe0XtA8zFS3UFvFzsDAkqZVxF5bQ3xmfrcGdE
 1avVk6ZX9bFL6mMnsoOw6EIpZ7wJyn1FjuK/Js3dDMZDOxI5Qe2f7tgEi/jawoOL7j4M
 n9ptWrffDmgarFyG35Wl2i+X+YaBFpu0/RuBxuLp2BzpxUiIUlI3VRTXp5qUM9c54O9h
 cAGAtxPaw8CMotYbNhk03B0tQrSQ4t+jUfYZk5Mesus+JdAEkugnnPAsSD9blscGyN/a
 UP3fbnJytG67tKroItyPV3hK7a6P49jixUAT6T+s1VVD2hGU/rbMMR7AMPenEdM8YS1u
 ZlXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyhjdtQ9wDxBt4vwfu7RRq0gn+QePNDvSC7XOILjtohX7zraKBK/S5RJBQFlegO8tcdgP+tyWlj8ye@nongnu.org
X-Gm-Message-State: AOJu0YyylKhDY9/qmeuWTmXD7n9u4xCCVhz5Ydj9DwPPdznhz0DnYhfw
 oNzgY46sXc3vAtWLhP0ViBg938SNyz2qVxWj7Ouf2Ow2dIpyVYM9kTgAl5xyQtM=
X-Gm-Gg: ASbGncvWsIDAi3xrvqVSUmISuVyIJc442KY1i2YB5cEgAlkoPTT+nIvot5AAwQBtcX2
 7JYAX7iP1wxGDQtrNvezgzojLijbdiduOECYYFS6iio+llvrbGqXUWjiIP75fU18dRLXIkjZDQ8
 ApTO11Wf/CAKknmmvgwO2lpWM3NaWKmZ9BvzihymaqfX49dTLjqRhoc+xIKFvcjlzyzhq0SUun6
 UVdEcMfm7vlyuvqKEiMrHi9W8D+qOSvsqcMXYr12yFgMN8CJ3IWeCjTYw==
X-Google-Smtp-Source: AGHT+IF4D12F2yZay8lSmJbMc9hdsR5Dfs8rvW+QNycv351EfYxMhs0G3IsqJfhE7nyiYL2D5x1TCw==
X-Received: by 2002:a17:903:240a:b0:215:b33b:e26d with SMTP id
 d9443c01a7336-21614d5057bmr161560225ad.21.1733725608035; 
 Sun, 08 Dec 2024 22:26:48 -0800 (PST)
Received: from [133.11.54.81] ([133.11.54.81])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2161ad52f58sm46939095ad.55.2024.12.08.22.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Dec 2024 22:26:47 -0800 (PST)
Message-ID: <df6847f5-11d0-4c69-bfac-ec2281279841@daynix.com>
Date: Mon, 9 Dec 2024 15:26:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] hw/vmapple: XHCI controller's interrupt mapping
 workaround for macOS
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com
References: <20241208191646.64857-1-phil@philjordan.eu>
 <20241208191646.64857-7-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241208191646.64857-7-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/12/09 4:16, Phil Dennis-Jordan wrote:
> This change enables the new conditional interrupt mapping support
> property on the vmapple machine type's integrated XHCI controller.
> The macOS guest driver attempts to use event rings 1 and 2 on the XHCI
> controller, despite there being only one (PCI pin) interrupt channel
> available. With conditional interrupt mapping enabled, the XHCI
> controller will only schedule events on interrupter 0 in PCI pin mode
> or when only a single MSI vector is active.

I think docs/system/arm/vmapple.rst also needs to be updated.

> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   hw/vmapple/vmapple.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
> index f607981bc40..156ea33ae79 100644
> --- a/hw/vmapple/vmapple.c
> +++ b/hw/vmapple/vmapple.c
> @@ -453,6 +453,13 @@ static void create_pcie(VMAppleMachineState *vms)
>       }
>   
>       usb_controller = qdev_new(TYPE_QEMU_XHCI);
> +    /*
> +     * macOS XHCI driver attempts to schedule events onto even rings 1 & 2
> +     * even when (as here) there is no MSI-X support on this PCIe bus. Disabling
> +     * interrupter mapping in the XHCI controller works around the problem.
> +     */
> +    object_property_set_bool(OBJECT(usb_controller),
> +                             "conditional-intr-mapping", true, &error_fatal);

Use compat_props to change the global default for this machine.

By the way, this unconditionally adds xHCI and USB devices, but that 
should be avoided so that users can customize the configuration. Use 
defaults_enabled() as a condition.

Regards,
Akihiko Odaki

>       qdev_realize_and_unref(usb_controller, BUS(pci->bus), &error_fatal);
>   
>       usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,


