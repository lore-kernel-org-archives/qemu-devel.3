Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C01ACD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 16:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZAK7-0007f7-1p; Mon, 15 Jun 2026 12:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZAK0-0007cx-GU
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 12:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZAJy-0002rw-Qm
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 12:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781541478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fecMLN8qk73l4MP5eNwYdUBSx3kL69t/+/AyUSRaICA=;
 b=HTB+CcQWV6y/vALCsT47HQVleG1ffGCjOY9iuTVKKiBMl6I8l2erR6KSkbUyQb8VzyC/4L
 b9/U6kq/+ybyVYvw8KaI+xL6vOjydpiL1bEdQboRVMOhjbJBeZ8r5ghQL14IQXW6dcgCwN
 l5INSCJSmvkm0Mhz7fziCAU2K5wQ4co=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-23hrRMVkNf6otRmp_vVcSQ-1; Mon, 15 Jun 2026 12:37:55 -0400
X-MC-Unique: 23hrRMVkNf6otRmp_vVcSQ-1
X-Mimecast-MFC-AGG-ID: 23hrRMVkNf6otRmp_vVcSQ_1781541474
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a767b782so21831365e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 09:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781541474; x=1782146274; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fecMLN8qk73l4MP5eNwYdUBSx3kL69t/+/AyUSRaICA=;
 b=AgO40WE5IQHqyvObMxGN9mlA4OUOVXJix3ivlfFq36BBHtpRKjAdRF1fz5VnBNZnz9
 8xeo4X5KbFBILW1XJzMk0O2fyz8O2jKbtBEuvnF/FU+jaA2LLxX2NvCUFDn6HfwLNwem
 IZet+VEUIL4iBq1AOljYbsPfuzYEdvhWgTwfnbUGBt+6PnpUnTRPXTzL+WpRlktHjSas
 /FLNMVV3z88DOFxyctISM+jlE+sGxCyPZT1qDTrAsvIdoRBzKW1akcPL4lIu8gSneCme
 Zt5BM2KSh+JeOfAUrrjpF9koGjMOwJo5ENwgoGMXHlXu1bYnEk1tRasW+USypsCKPNHV
 a1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781541474; x=1782146274;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fecMLN8qk73l4MP5eNwYdUBSx3kL69t/+/AyUSRaICA=;
 b=pvg/nGpNAX1UlqM1RG7BgHKuQtLYGig+0fGfNPuY85E6xIHe+5uMGi/3Fzktcn9kiW
 VlX3C6IQsI699IildiNH3s4+c/Kgz6wv5nvF/ynokJ78+1AS5DB4BJRPzt5ejNqzNhek
 AAO57+kQ8XGpuIiGG3FrQHh1gldKqXVoKqUqWKVh4rY54y8LsR/6qOjVPbMFPwtCHCcq
 pJuT5CT5RadNmMBxWfPdPmFpMP8uIUD/q+pK2TK9qaC4DnUDhL3IwSPPGD9Alscg4NRA
 TBwXyvfvNrVRYVL6/Qeup3rJdMo6NJl0ddMi74jTO4u+lEeBrWRegtXq/p9Swb0fzwzy
 DfBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LNtGn58c9P+VrcKmfM16sGQTTjH/gNWhPDD52voTuy6nE5oLD/TEyoHWfwSJw/3rXjwkMDlaB1qG0@nongnu.org
X-Gm-Message-State: AOJu0Yzkmx7SxvdPIB+1tdqQ8hW+JaSBtYRnF1mER9dRowyStX97Mot4
 PXD9A8xp8yCpKJPVtp1CKU70W4yYjg/pmp37TEQTNf1E/+Vva6x3egds1jm0XOiK4WN11wxpkK6
 0jLZ3ulUAzr4IdYOxOdYSeruCjjt5q7KYbrYGe0oRQCZOuOy/bTXLo66P
X-Gm-Gg: Acq92OGzN+uMT8LApxk8rLMyHDmvPSTvwfEfHFMOwnMYq4cfJubOuhGrSz/S/bsLWw2
 +sbNn7ig4VG+s7LPuCpETUqu9/Qg9NFcwPYnIOy81I6amojXEVhrVVZCW8mD4PpfnEjIr2oJfP5
 4thK7WAK84qKQirmrQV3evETO7PGik+mHV6OX4E2EYdcJ8DRJT8EAUBjA3k3n2ALAHy9hwu/tVK
 TwL4NGyd6EVOAvcyeZVW/QJUAosg4fDITkULPmtqLYyCH4kiklgTXOu+PbcsqMvKZXzkW35aV2+
 16sixitxnn3WvI4gCuTyMICnkapd7mWAkEE2pNJ+SYW75nSDoE0wjDJ1Fdgo2mXB8kUZ2ficDCB
 qDtxIkxbGAd+9ojPuyFJqnNsxf1K9xcdCLByzxoOu2SU=
X-Received: by 2002:a7b:cb87:0:b0:491:a220:6e48 with SMTP id
 5b1f17b1804b1-491a2206e91mr129253685e9.32.1781541474145; 
 Mon, 15 Jun 2026 09:37:54 -0700 (PDT)
X-Received: by 2002:a7b:cb87:0:b0:491:a220:6e48 with SMTP id
 5b1f17b1804b1-491a2206e91mr129253085e9.32.1781541473620; 
 Mon, 15 Jun 2026 09:37:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea961f18sm281397045e9.2.2026.06.15.09.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 09:37:53 -0700 (PDT)
Date: Mon, 15 Jun 2026 12:37:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, alex@shazbot.org,
 peter.maydell@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org,
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <20260615123633-mutt-send-email-mst@kernel.org>
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <93fb3b41-1543-4e3b-922b-043b774f57bf@linaro.org>
 <20260615123354-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615123354-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 15, 2026 at 12:36:00PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 15, 2026 at 08:17:14AM -0700, Richard Henderson wrote:
> > On 6/15/26 03:01, Gavin Shan wrote:
> > > +void qemu_ram_copy(void *dest, const void *src, size_t n)
> > > +{
> > > +    if (HOST_UNALIGNED_MMIO_OK) {
> > > +        switch (n) {
> > > +        case 1:
> > > +            __builtin_memcpy(dest, src, 1);
> > > +            break;
> > > +        case 2:
> > > +            __builtin_memcpy(dest, src, 2);
> > > +            break;
> > > +        case 4:
> > > +            __builtin_memcpy(dest, src, 4);
> > > +            break;
> > > +        case 8:
> > > +            __builtin_memcpy(dest, src, 8);
> > > +            break;
> > > +        default:
> > > +            memcpy(dest, src, n);
> > > +        }
> > > +    } else {
> > > +        uintptr_t test, lsb;
> > > +
> > > +        do {
> > > +            test = (uintptr_t)dest | n;
> > > +            lsb = test & -test;
> > > +            switch (lsb) {
> > 
> > Either assert n != 0 to start, or use while not do/while.
> > Because the body of the loop won't handle n == 0 correctly.

I think n!=0 performs better than a loop. Worth checking
asm though.

> > > +            case 1:
> > > +                *(uint8_t *)dest = *(uint8_t *)src;
> > > +                src += 1;
> > > +                dest += 1;
> > > +                n -= 1;
> > > +                break;
> > > +            case 2:
> > > +                *(uint16_t *)dest = *(uint16_t *)src;
> > > +                src += 2;
> > > +                dest += 2;
> > > +                n -= 2;
> > > +                break;
> > > +            case 4:
> > > +                *(uint32_t *)dest = *(uint32_t *)src;
> > > +                src += 4;
> > > +                dest += 4;
> > > +                n -= 4;
> > > +                break;
> > > +            default:
> > > +                *(uint64_t *)dest = *(uint64_t *)src;
> > > +                src += 8;
> > > +                dest += 8;
> > > +                n -= 8;
> > 
> > Use qatomic_set for the stores.
> 
> 
> Won't this do things like locked on x86?

Hmm I didn't check. It's relaxed - so no locked. Fine by me.

> 
> 
> > 
> > src is not aligned, so except for case 1, you need ld{uw,l,q}_he_p.
> 
> These just map back to memcpy. What is the point?
> 
> > > +void qemu_ram_move(void *dest, const void *src, size_t n)
> > > +{
> > > +    if (HOST_UNALIGNED_MMIO_OK) {
> > > +        switch (n) {
> > > +        case 1:
> > > +            __builtin_memmove(dest, src, 1);
> > > +            break;
> > > +        case 2:
> > > +            __builtin_memmove(dest, src, 2);
> > > +            break;
> > > +        case 4:
> > > +            __builtin_memmove(dest, src, 4);
> > > +            break;
> > > +        case 8:
> > > +            __builtin_memmove(dest, src, 8);
> > > +            break;
> > > +        default:
> > > +            memmove(dest, src, n);
> > > +        }
> > > +    } else {
> > > +        qemu_ram_copy(dest, src, n);
> > > +    }
> > > +}
> > 
> > The qemu_ram_copy implementation above does not work with overlapping blocks.
> 
> IIUC copy is not supposed to. this is what move is for.
> 
> > 
> > r~


