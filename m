Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F020FF8864
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHT4V-0008W1-G5; Mon, 27 Apr 2026 17:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHT4H-0008Vb-LW
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:00:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHT4F-0003F0-Tq
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 17:00:37 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso117949425e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 14:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777323634; x=1777928434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DYOX651bc3RSeFdNZ47ZeEcG4O1z6jjFeOzs3eJ6CHM=;
 b=XXj2Ga0JSHE6GPrCKeYt+E5BbuMsp0P3VjS7A/gYLFtM4G4geVXbDBo2waG/K88xsc
 qlMhW+4kVI1nXyuZwUA/PXkZykTUG+4WhGpkueyin3DX3yISGxfIclYQ4Ft5min4fU17
 2TJpCxo6kRDPEzM7TO8k8bXEN+A7fjtADwJyfwoknj6lRnfCr24gsL81H1H/0vHBDGVI
 6wmxiMHprx+CkcN6s74Do0C4vxWgrWxoAIS3JBuiKzO6oXCyGHvqSZQfOdfehYiyw2F8
 zvm4qWO9hzt3hZYRnMPm+f+yArtLvJCjxSBSL2jhJ4Fl8NkEIK9iASFkzaxLt8z/9pG3
 CB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777323634; x=1777928434;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DYOX651bc3RSeFdNZ47ZeEcG4O1z6jjFeOzs3eJ6CHM=;
 b=Tkt5jON5H2IJOmXQKGXPPiSdRd7dgf8Af3+VOXTApdNB7ePZf+lO/9lbjF4dDflCdi
 P4SRqYM/GXpFnJ/MbcJicHL/f7v0zthhs/yamFf9+gajXh96DJTqGP/b7mBQqOSEXkFG
 XNOrbu/4lf3MdnyoHtib7drn8z09ikhAcqDrUEbBNK1xJArjkaEuRGj2fpL2mtivA40R
 NuUcFgryP8gePx038YFHMSDZfX13YMGNzAFsmRNQ0t5a08eqKS6oQZ4Kgg9iyh3Iks1y
 tLi9T6dvgdHBSrGLrqqparTpA83zrmQ5EKDyq/a+zkmPAf0IqvoZRQyCc9Dl1E/F4sTg
 EZ1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+tVhw9zqqrA7w7nUuVYvCxq91XGF2DsosRbt4Ew5NDUNvIHdsWWnQSQqiq0DaxaIqZ+203aDgdZpjx@nongnu.org
X-Gm-Message-State: AOJu0YyhcoIwV+VSDJvxGu4ET8YcNKTIdkkN1KhQguQn1oYLF9AA6qTF
 uWYY/wtJc2SplEk1QaLwf86WfEbVgA1ReKwwgF94zcbd3Yk8MgU0Ua2tKEJ9pQLUgMc=
X-Gm-Gg: AeBDievhFM9mSiFp53LhglgGWdiiGEa1E6lUa4Odz/3qI/OkpPyKuzgMwx1fyIBLG2O
 9oxGxzMZyShz1g1mT/zVdQB3elwxYBa2REC74Fls5II5z9Fgqp1A44r7yVWjr9OpMg0ntJN9EZ7
 p/Z+MUeiUxI/+hiDBQuGT5thdbJgiEB0vW2fsV5PjfyGiP6UxHahrL7/iJVCBZaEVwrOzON6Suy
 1W85wJByhe5hVH14ysGpNei3a6j6TTrdVWetm7wpaWVAb80ya9pG8ctvgQotQ+rm+E8e7CjcCWf
 SJ0PfucO5AB5Q6OsjaqzYgqifyYHNJWb+IqcgdkLm7Tb9a93zbp3h+CgpZksb1LXKNDY2icRdli
 ELrM1QHRN5oqUz3qxN8n63eA2PZEUsyoHLcPpS/QzAD19Lysey2BoBdmUTsGwIFjuz1FbjOL6JM
 SoNvCtsqYyKJRGtqDeFD8p2jebo/WKr8nK2h4GUxgOzJS37JI7HTG7L6BZ3u5lATsllxAt7izr8
 Mi8
X-Received: by 2002:a05:600d:10:b0:488:90ac:8f71 with SMTP id
 5b1f17b1804b1-48a77aedaf1mr3031585e9.5.1777323633894; 
 Mon, 27 Apr 2026 14:00:33 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a775f56fcsm3613645e9.25.2026.04.27.14.00.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 14:00:33 -0700 (PDT)
Message-ID: <d48730e4-2034-4245-a671-9d2dbd72b1a3@linaro.org>
Date: Mon, 27 Apr 2026 23:00:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/41] hw/pci-host/i440fx: handle NULL bus in pci-hole64
 getters
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-4-c413f3605311@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260427-qom-tests-v1-4-c413f3605311@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 27/4/26 21:42, Marc-André Lureau wrote:
> When called on an unrealized i440FX host bridge (e.g. from
> qmp_qom_list_properties), h->bus is NULL since the root bus is only
> created during realize. Guard against this in both
> pci_hole64_start and pci_hole64_end getters, reporting an error.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/pci-host/i440fx.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> index e7d638b296c..6952094510d 100644
> --- a/hw/pci-host/i440fx.c
> +++ b/hw/pci-host/i440fx.c
> @@ -189,8 +189,14 @@ static void i440fx_pcihost_get_pci_hole64_start(Object *obj, Visitor *v,
>                                                   const char *name,
>                                                   void *opaque, Error **errp)
>   {
> -    uint64_t hole64_start = i440fx_pcihost_get_pci_hole64_start_value(obj);
> +    PCIHostState *h = PCI_HOST_BRIDGE(obj);
> +    uint64_t hole64_start;
>   
> +    if (!h->bus) {
> +        error_setg(errp, "bus not realized");

"PCI host bridge not realized"?

But calling a getter at this point is a programming error IMHO.

> +        return;
> +    }
> +    hole64_start = i440fx_pcihost_get_pci_hole64_start_value(obj);
>       visit_type_uint64(v, name, &hole64_start, errp);
>   }


