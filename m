Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D3BC27C77
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 05:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ4tu-0006RB-Gz; Mon, 17 Jun 2024 01:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenyzha@redhat.com>)
 id 1sJ4ts-0006Qo-9K
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 01:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenyzha@redhat.com>)
 id 1sJ4tp-0002Dj-Lr
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 01:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718602043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aS3vDlpG5JAr0kUzKjXG6xA9B7QpFmkY+r7SXcqM/V4=;
 b=e4sTdkKfXDzyKOTLwZSqHLA3gufMcgeFvvmefRoXvu+RLuDTz2uiizFBOVNGEXEdAS9cuM
 w0weE346I6UV++K9P+Ia73GPKzHYYUTJGXynnls8l6Q8FtezX+IL/XlnAH0guV7CaYcDPR
 4oCcsnvDFuiJEwxTQDC3yiBeNmZsUww=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-v96KCQHYMs-Zwd-QCdu6MQ-1; Mon, 17 Jun 2024 01:27:22 -0400
X-MC-Unique: v96KCQHYMs-Zwd-QCdu6MQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6e37310ebaso149365766b.1
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 22:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718602041; x=1719206841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aS3vDlpG5JAr0kUzKjXG6xA9B7QpFmkY+r7SXcqM/V4=;
 b=XnailiuUQFJR2OnMeuUxfm8bEM9SzYdTzq9FRZU14z2ru7DYG7bzrPE8Q6zRvQc7hX
 weA9fOGYy/OteQFl5fQEmm9yu3V6HEm2X7oppjxK6k6/KPXBswS27MO2kZMa2LFUGid5
 rFTxGd46y/7BubCRvjpnfSyXw9SBrZBDn8eJY18hxpQ7h1gPkW8IiguTaJhGvkO1CnpM
 LfMGnJI7DFoAa1V9qlr6yRqBzcogjmcow2wR3iggWv7KXMToXMRNweCVYhCzdM5mBgBi
 oeiaO8w/f2kziezqxgKgK+NYN1Q+j49SrIvfsZkCEz1088YBPmsfGZ9fkdUrrs9Ydog6
 2F/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF1x5R0ChwWydqjxmlO5s6fSbZiPn85nYgZ+sn7gS7jLxweqe6HXOicT32qqaImNyUjB3vf1yx1/dlrG0rC9hGlYtsu50=
X-Gm-Message-State: AOJu0YxzlJ2xUn5KJ4fEpRhzdjA4homsKaS8C5x5rpq42YkKV8Ui/orX
 sMPrQzzuYPkyo3AwyLe2MOpap/8UHOp40aHmvHs/luwEVKo02Y7uTTVq+yqQJq+KK5r5UTZF0mn
 vli5LtDZT2OEHrPfHt0MFULgYC4ENHbpLLp+URTj73XY9ErAXI0AaJR118VxG/MVPGqboS9ZCiC
 /8YpGeOUa/qi+kYbu9XQKSUbHT+zU=
X-Received: by 2002:a17:906:b44:b0:a6f:1e88:37c1 with SMTP id
 a640c23a62f3a-a6f60d41c02mr569092766b.45.1718602040829; 
 Sun, 16 Jun 2024 22:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMVZg9KUbBKxVURrO7d0Rv8mWhRpzg3fVh3nqrBPaolwgw8HNvgIcjA8DKaSoq0GUSWdeGIplmdePCMX4KgIk=
X-Received: by 2002:a17:906:b44:b0:a6f:1e88:37c1 with SMTP id
 a640c23a62f3a-a6f60d41c02mr569090666b.45.1718602040445; Sun, 16 Jun 2024
 22:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240612020506.307793-1-zhenyzha@redhat.com>
 <69649622-e52c-4d24-809b-3d8a97786a69@linaro.org>
 <CAFEAcA9wEjONgLfTObNYwJbwn5Gs1BDJiDivc9PEwmfOeZW6ww@mail.gmail.com>
 <8d7e111b-4f74-4a67-b01b-2af5ce009a06@linaro.org>
 <ed3df37e-fddd-465c-8ae9-1c5791966995@arm.com>
In-Reply-To: <ed3df37e-fddd-465c-8ae9-1c5791966995@arm.com>
From: Zhenyu Zhang <zhenyzha@redhat.com>
Date: Mon, 17 Jun 2024 13:26:44 +0800
Message-ID: <CAJFLiBLt4ig0XpDScq0M1EAPo1PEvZNiumf9kKMOErSE_OJ_cQ@mail.gmail.com>
Subject: Re: [PATCH v3] hw/arm/virt: Avoid unexpected warning from Linux guest
 on host with Fujitsu CPUs
To: Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, 
 gshan@redhat.com, eauger@redhat.com, sebott@redhat.com, cohuck@redhat.com, 
 ddutile@redhat.com, shahuang@redhat.com, qemu-riscv <qemu-riscv@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Song Gao <gaosong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=zhenyzha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 13, 2024 at 1:48=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2024-06-12 1:50 pm, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 12/6/24 14:48, Peter Maydell wrote:
> >> On Wed, 12 Jun 2024 at 13:33, Philippe Mathieu-Daud=C3=A9
> >> <philmd@linaro.org> wrote:
> >>>
> >>> Hi Zhenyu,
> >>>
Hello Philippe,

> >>> On 12/6/24 04:05, Zhenyu Zhang wrote:
> >>>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >>>> index 3c93c0c0a6..3cefac6d43 100644
> >>>> --- a/hw/arm/virt.c
> >>>> +++ b/hw/arm/virt.c
> >>>> @@ -271,6 +271,17 @@ static void create_fdt(VirtMachineState *vms)
> >>>>        qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
> >>>>        qemu_fdt_setprop_string(fdt, "/", "model", "linux,dummy-virt"=
);
> >>>>
> >>>> +    /*
> >>>> +     * For QEMU, all DMA is coherent. Advertising this in the root
> >>>> node
> >>>> +     * has two benefits:
> >>>> +     *
> >>>> +     * - It avoids potential bugs where we forget to mark a DMA
> >>>> +     *   capable device as being dma-coherent
> >>>> +     * - It avoids spurious warnings from the Linux kernel about
> >>>> +     *   devices which can't do DMA at all
> >>>> +     */
> >>>> +    qemu_fdt_setprop(fdt, "/", "dma-coherent", NULL, 0);
> >>>
> >>> OK, but why restrict that to the Aarch64 virt machine?
> >>> Shouldn't advertise this generically in create_device_tree()?
> >>> Or otherwise at least in the other virt machines?
> >>
> >> create_device_tree() creates an empty device tree, not one
> >> with stuff in it. It seems reasonable to me for this property
> >> on the root to be set in the same place we set other properties
> >> of the root node.
> >
> > OK. Still the question about other virt machines remains
> > unanswered :)
>
>  From the DT consumer point of view, the interpretation and assumptions
> around coherency *are* generally architecture- or platform-specific. For
> instance on RISC-V, many platforms want to assume coherency by default
> (and potentially use "dma-noncoherent" to mark individual devices that
> aren't), while others may still want to do the opposite and use
> "dma-coherent" in the same manner as Arm and AArch64. Neither property
> existed back in ePAPR, so typical PowerPC systems wouldn't even be
> looking and will just make their own assumptions by other means.
>
As Robin's comment says, each platform wants to assume coherency
by default may be different. Adding it to all virt machines may
introduce new risks. Currently, the issue is only valid on Fujitsu CPUs
where the cache line size is 256 bytes, meaning the combination of
kvm+virt-platform is needed to trigger the warning. So I'd be inclined
to add this "dma-coherent" property for the "virt" platform first
and advertise the property to other platforms if we hit the issue
on those platforms.

Thanks,
Zhenyu


