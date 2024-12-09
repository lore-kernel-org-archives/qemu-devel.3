Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AAFE77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 06:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKXFM-0006xs-Im; Mon, 09 Dec 2024 01:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tKXFK-0006xh-KH
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:27:54 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tKXFC-0002Zq-QF
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:27:53 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-725c86bbae7so1808463b3a.3
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 22:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1733725665; x=1734330465;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y/5Br297somceWuy6VuF5PtVQLTbUm2Rmwh1uzvv5SQ=;
 b=DnthsHIs0yZkABPeyp9a0nxeAakjJoEVVrmKJt2wSN3p32xm+Av2tdVv72mxnaKfEX
 PV1uJXd2LJdfMpU7SObtj2YeRQpu/4GMR8K1PeQU3dQ+W05WZYfeuvn7rAiX2sDnxR9E
 RFznHnvsgYIGxWEyXIJwEf16NEgcD6MHYQFu7jBNfKRa/Y5I4I96/U2y6SCpPzs/tQOk
 0cG7Ig76ZYnVN5KjBS1fiGGekXcpTP15+VwvghyVY24umJmYQTpM6/kOFuoosl6J7RyA
 wNEni0OvMdzGMQ0T/OHUHDYkC5yxE8LtAOr/rJCMXDvG28AVdShSUSETHK7dwkgDAqaq
 6RRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733725665; x=1734330465;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/5Br297somceWuy6VuF5PtVQLTbUm2Rmwh1uzvv5SQ=;
 b=rPabR5DY8CXh8edfc8Pg8Uf7WDb4uSi8IMHWnwIjKLUdxUGOgPmiVxjY/Vtg2nxa35
 9w/hGdarOziMENQnwjsNeC6lEbKzjeP2lvH7qA6hGiGnr0IjJ8X19WPFIM758HOxpZcl
 nlLQqpyuJ2gS3CstHk+tRhKmyBPwsd3JsTqS1qRinFfgxknldj2wSAdRisHKfEimCxBK
 exQSQUrMnFA/DIbp+O+6yNAhdimfRLr/UsATmLToG69XETGOc9Yt+jaqMY5HXpT75VFw
 IGdCANPjfXk4aHOmpynQySbAwUzBW+qzsQhdRrdBFbGPAo9F+7jFH3yUljGq+mZTeJ2W
 cHOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU92fvFVANO7+LuqkXEoPH4fkSWMrx85kwSeREx7tulzOivKPjhoLaECwYXGBlStGc7trsMh5KdPLAK@nongnu.org
X-Gm-Message-State: AOJu0YyOpvTJhqsHcYQmXiHCj0aDY8dqV7txPfd6dD3VCm52ueyyt6eN
 qKZJcVvKoMBn5noKRUUHkumKudnK4ehZB3oG8e87UiUxnWZ/AaxE6EbMOY4vnpEslX1t8szXUco
 sSXE=
X-Gm-Gg: ASbGncvDug8eB+d0DnP87zfzSuc5UjesYRhiF8YkgP9UQ6UvBrpBOEWHdvFKnSOsD28
 MOMLMl1t+pC7gbTspovYZvloiSMpDUmPNAPoZwdIeCx0J0EHhE0A1E6Qw+EHkFgu43Hh3xiGZXV
 dPGn4dVKQgg7eycwUb0pxbvJlYSdXNim7Q2JF8JjcZQkSaaKLmKSCMZd/yX4NPoqi5AuxLbNWdT
 W6UF8g5eMSPWhF0eMteMDq7++sGo/X/eLqNRSoZPtTsQ/l+Sd2er5OOAw==
X-Google-Smtp-Source: AGHT+IHwHf1FIF5uQZlh1F3m3XrjWA/Cj/R9Q/WDhVgtO8w+zCyulC41XKuwCaEO7RCKSrYpmjP5AQ==
X-Received: by 2002:a05:6a21:33a1:b0:1e0:d6d5:39a7 with SMTP id
 adf61e73a8af0-1e18712300amr17068236637.33.1733725664923; 
 Sun, 08 Dec 2024 22:27:44 -0800 (PST)
Received: from [133.11.54.81] ([133.11.54.81])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd4ec342b2sm961875a12.70.2024.12.08.22.27.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Dec 2024 22:27:44 -0800 (PST)
Message-ID: <beafac8b-761b-439b-87ec-b77f4f794647@daynix.com>
Date: Mon, 9 Dec 2024 15:27:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] hw/usb/hcd-xhci-pci: Moves msi/msix properties from
 NEC to superclass
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, thuth@redhat.com,
 zhao1.liu@intel.com, imammedo@redhat.com
References: <20241208191646.64857-1-phil@philjordan.eu>
 <20241208191646.64857-3-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241208191646.64857-3-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
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

Let's drop -s from the "Moves" in the subject:
hw/usb/hcd-xhci-pci: Move msi/msix properties from NEC to superclass

It is a more popular patch style and makes consistent with other patches.

On 2024/12/09 4:16, Phil Dennis-Jordan wrote:
> The NEC XHCI controller exposes the underlying PCI device's msi and
> msix properties, but the superclass and thus the qemu-xhci device do
> not. There does not seem to be any obvious reason for this limitation.
> This change moves these properties to the superclass so they are
> exposed by both PCI XHCI device variants.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   hw/usb/hcd-xhci-nec.c | 2 --
>   hw/usb/hcd-xhci-pci.c | 7 +++++++
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
> index 0c063b3697d..408bf065e5a 100644
> --- a/hw/usb/hcd-xhci-nec.c
> +++ b/hw/usb/hcd-xhci-nec.c
> @@ -39,8 +39,6 @@ struct XHCINecState {
>   };
>   
>   static Property nec_xhci_properties[] = {
> -    DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
> -    DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
>       DEFINE_PROP_UINT32("intrs", XHCINecState, intrs, XHCI_MAXINTRS),
>       DEFINE_PROP_UINT32("slots", XHCINecState, slots, XHCI_MAXSLOTS),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
> index 376635e889b..0278b0fbce2 100644
> --- a/hw/usb/hcd-xhci-pci.c
> +++ b/hw/usb/hcd-xhci-pci.c
> @@ -197,6 +197,12 @@ static void xhci_instance_init(Object *obj)
>       qdev_alias_all_properties(DEVICE(&s->xhci), obj);
>   }
>   
> +static Property xhci_pci_properties[] = {
> +    DEFINE_PROP_ON_OFF_AUTO("msi", XHCIPciState, msi, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO("msix", XHCIPciState, msix, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>   static void xhci_class_init(ObjectClass *klass, void *data)
>   {
>       PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> @@ -208,6 +214,7 @@ static void xhci_class_init(ObjectClass *klass, void *data)
>       k->realize      = usb_xhci_pci_realize;
>       k->exit         = usb_xhci_pci_exit;
>       k->class_id     = PCI_CLASS_SERIAL_USB;
> +    device_class_set_props(dc, xhci_pci_properties);
>   }
>   
>   static const TypeInfo xhci_pci_info = {


