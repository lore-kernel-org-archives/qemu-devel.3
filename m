Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1FCCFD377
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqGq-0002HV-Ng; Tue, 25 Nov 2025 05:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqGX-0002FC-30
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:27:26 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqGS-0005eo-DL
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:27:19 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so44601105e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 02:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764066433; x=1764671233; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bm82jX7XCCW7aCI+a8dons42tFjRYTNRDP+rtZdOHPw=;
 b=Gh+ALzyjAGOVA995lfe7aToEiFZtmMYh7OCaa83Ht88oLCIH9lxYPNmIkEeW5iW0Iu
 lmF1TH8WDBpAVTE+BFUSk/5U4Abk8EBJenzFI6zd2VDo7kBHfvrftsdXr5qj3huOYyzG
 jeKI2B78I43nXmqWHQDq8P0CD547wijyy8tjh8WbbzRfD+mMYtsu+k6YHHaf4Rd6Bets
 imfDSeUqfEE0fKHbr0R0t2N0aYVLEsGskhhDNylDH4U06YeqxeET+oW7RYrJ+XnhUlsb
 4dl4hUB0mpj1Tej8jeFYo90xoCorR4Q6dc3JZFlJwbVHAKmE2dmB/fLW+oBhKiy/fFOH
 auww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764066433; x=1764671233;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bm82jX7XCCW7aCI+a8dons42tFjRYTNRDP+rtZdOHPw=;
 b=hcGXyt1iyMf77K28G+AUq9guUaNH7pi7hna8cA6cWjJyp6D3E6F4yyumvSkhew9UAu
 I74Qq2nIURjpLeTsGV8tBptnFFUKPy7HifhPKQO+s1ygZ2gY8ot7ji1cYRrmlwunWG+X
 ySaCrZMOPudHoU7/qawrlmFgMv8WrxmhcH3/iqL8YBOl/qbQnIQgswP97poVt07/Puvk
 sdRtRKHbBCplmS+n3Vypm01VMipWsiJXjAqwCpf+miewycxgmHX6eIeYJ7uRNC0B6pzy
 eI4ms4zF5p3vIHbJJ7uCnocoxTKgw4QQmvIE5YjM/MRRe399VRivjEOq4OGfLaACbFtF
 i4ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIdwlYErKF7cFsRdPZmqutOGYh3aS/x4f52Ja2sYlGTNNY7SpI/XG8lkjYuTa9zmuEWdldiwFdfvkP@nongnu.org
X-Gm-Message-State: AOJu0YywVahVvytVxFX2EQuO9KfTeewsE7Xu4EJoBgrmFgmyyZn/CcmX
 BZAhHkUycmbOAYX1E8ZfNqRIKxx8SWkiKsOBp3bLEoTfd6aBOzsArUNix7j6rwmYmu0=
X-Gm-Gg: ASbGncuHtbduo1ZSL6MlfKuPR9lBCVO7QgDiXQco5Dpe3ViHX6WKGfkKQ8pxg/aMv+X
 Qs0ngTD405RKWbSn1GOlf15ncffQweiWmpVk8SmDw+Hc9kNqm9yLQZRJNb/Ms25F6QKnNGIPPLM
 UKzAi2RO3gnzQIRAPpy9LN1l/GIig2MZgToSxezX+gsRRFfjjO7ms7ei6Tdj/52KPeMQDVjxIp7
 lxI9a0XInWHZ+6YCfrbTmClL5X/lmcBn0Eyf5EXlIfVUkeAaMhGhVJnE6bvSc/bkciPFYS4hfxv
 5n5Egh2Gd8ZxxAMS+BeSG+umZrZSf5hrryfhioWWXzkDJMNOm/+EYXcwStBnMSNLKGgXyVkohpn
 6Nw1Z6pl44GFopgWcV0q4PMHH4nC6Dpu6KVT7z8aViBOjQrqPloeNKdvM3fvgLweC4ikqMf9Abl
 QccvpDLxzPYOkh5/gVpA6xfXVOTIXHrrNXT0k1z+xUIS0koLHoYcaI8Q==
X-Google-Smtp-Source: AGHT+IGhbYTeSSFuslMqXUGJgEAmx4PJmp7EyajaFZpq/LfxEIoU4Z6Qn9frxs4dE4HLknKn1jcfKg==
X-Received: by 2002:a05:600c:3b1a:b0:477:55ce:f3bc with SMTP id
 5b1f17b1804b1-47904b12f1dmr17118695e9.19.1764066432928; 
 Tue, 25 Nov 2025 02:27:12 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf1df392sm246300905e9.1.2025.11.25.02.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 02:27:12 -0800 (PST)
Message-ID: <79407b6c-1161-4b08-877b-e215d2058a5d@linaro.org>
Date: Tue, 25 Nov 2025 11:27:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] hw/usb: Convert to qemu_create() for a better
 error message
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, zhenwei.pi@linux.dev, alistair.francis@wdc.com,
 stefanb@linux.vnet.ibm.com, kwolf@redhat.com, hreitz@redhat.com,
 sw@weilnetz.de, qemu_oss@crudebyte.com, groug@kaod.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, kraxel@redhat.com,
 shentey@gmail.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 sgarzare@redhat.com, pbonzini@redhat.com, fam@euphon.net, alex@shazbot.org,
 clg@redhat.com, peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 dave@treblig.org, jasowang@redhat.com, samuel.thibault@ens-lyon.org,
 michael.roth@amd.com, kkostiuk@redhat.com, zhao1.liu@intel.com,
 mtosatti@redhat.com, rathc@linux.ibm.com, palmer@dabbelt.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, marcandre.lureau@redhat.com,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org
References: <20251121121438.1249498-1-armbru@redhat.com>
 <20251121121438.1249498-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121121438.1249498-3-armbru@redhat.com>
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

Hi Markus,

On 21/11/25 13:14, Markus Armbruster wrote:
> The error message changes from
> 
>      open FILENAME failed
> 
> to
> 
>      Could not create 'FILENAME': REASON
> 
> where REASON is the value of strerror(errno).
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/usb/bus.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index 8dd2ce415e..714e33989f 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -259,10 +259,9 @@ static void usb_qdev_realize(DeviceState *qdev, Error **errp)
>       }
>   
>       if (dev->pcap_filename) {
> -        int fd = qemu_open_old(dev->pcap_filename,
> -                               O_CREAT | O_WRONLY | O_TRUNC | O_BINARY, 0666);
> +        int fd = qemu_create(dev->pcap_filename,
> +                             O_WRONLY | O_TRUNC | O_BINARY, 0666, errp);
>           if (fd < 0) {
> -            error_setg(errp, "open %s failed", dev->pcap_filename);
>               usb_qdev_unrealize(qdev);

OK, but why not update usb_qdev_realize() in the same patch?

>               return;
>           }

Similarly, I don't get why you updated this (and the following patch),
without also doing the similar:

  - qemu_chr_open_pipe()

  - qmp_chardev_open_file_source() and qmp_screendump()

  - s390_qmp_dump_skeys()

Anyhow, for this patch:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

