Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103F1CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 16:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZAIB-0006fL-Pk; Mon, 15 Jun 2026 12:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZAIA-0006du-39
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 12:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZAI8-0002Kv-O3
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 12:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781541363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qEyy+zLspp68V/bV3Lx3JmL20jBo4NCfsOvahpmGszU=;
 b=PbQ9nZrSRzXMRvY9HwgLHp40+s2ZEB6ikOyRVFWpSAvRjkYrBC34w8us/UQjYSzlZPl3Nd
 D/XRE4xOoF7a5echNhfDhTmMuKjvbQ4Qeoah4F8NK1O7RGhbf869XdoD+3Mgz558eydfn6
 urFGY5D3x5USV5pA+6j3Hvhj/dQSb9w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-nmPCxQ14O7G0mKs3WhdwnA-1; Mon, 15 Jun 2026 12:36:02 -0400
X-MC-Unique: nmPCxQ14O7G0mKs3WhdwnA-1
X-Mimecast-MFC-AGG-ID: nmPCxQ14O7G0mKs3WhdwnA_1781541361
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45efa7755faso1467924f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781541361; x=1782146161; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qEyy+zLspp68V/bV3Lx3JmL20jBo4NCfsOvahpmGszU=;
 b=TVIYHjViDnNxcUd1ljCj2G4/H9U6cwrvX9fC0zNUjxHEQ2ate0/fygUA4PwcCalUVj
 kX+ytuN73RzGet5obgOvscEw7pBt8/vw5yE7idMGn6tuh84Sln6SabD70H+SGulBjiTS
 1X7D9+RP4AxQoMjQ95qVODg0jCzC4NfoHtO8oAns8JQCbUwdXEGhjoF7NrxGNr1Ix0tj
 QdzePOfeZZ9ZU/nA7AeiZr2WcDVz8GGv8cRLrTuueu5BmsC4RjVsYd1FzVnagvasMx0v
 39dzIFfHGs+oFna0ho5pN29CXEw7valExxxZcTU9gUL4iCD+n1lkdZFyzmBtiaz2d7Wb
 3EXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781541361; x=1782146161;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qEyy+zLspp68V/bV3Lx3JmL20jBo4NCfsOvahpmGszU=;
 b=l+jl96EMoFXBzSWgWRYGSLfO90qLwCiwDbsz8WfZ7Otzamg50lUGxJ1+TZvlHUUg4P
 LPXdyoB4IFh7U8QM+Fx8m4QiCCYSOWYL64WfS9Y8cneQCdlskrBJs8+367falv2WHz18
 5jWq/LdXxVV/opL2MxWxG+gTOSpJAWQI11RPo5yGLh1STO2BxAxfLgXPgTds2Xuu0zuG
 ZEM69z17x4FRVIerL8jrCwadYJYcbZMXnc2hVu7mN3x2BSS9TtH8nrPvYEqKv11ckl8i
 k70Ni2SWxhmE9HuT8EdUyd/ectNQelCvy9EWbACjUaEiZSS65rAsfemjJF4UjDLosFhC
 dQlw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8NbCzfVFDxy6x/F2QTghMN6741TG4Q+GwTOCiGBUHDfJAzE4x4dP6k835EIuVngEGnofJMWcKtWvp5@nongnu.org
X-Gm-Message-State: AOJu0Yzos52OqBQ5Fx0WPhY6DFyVKZZgmUhq3+BXtVHKmztVmY1HJfJK
 +uU9QE/amyV7K6UcwWS7Qy4pTrywam2MNlseLd3jESGaIlq7W8x6hT4fPTi6zsR5qWhHxPqtzvg
 KeZZe1EE43MjenUTWRcJ5RXYJCAVIhjNUFxYf+lsXwW1FpSO0tjk29zTO
X-Gm-Gg: Acq92OEbd3ec1soEYcqsfZVTZ2AeF1RumXClIJGm4BmRkSmEFdjrTFchbMwDQuFCGq5
 rIP//18eskL8w2BPC+H56YUoyEuhORewGPHHwiNWDBs6zy+o3VDm5A/L5MNqr8WZ0QxrbaNGbkr
 ixceEnvex/qQ46nWsgcu4aOFKmww98gjOD7wDC+itEH+sIdhm1AP+TceJwMrlXgV8rRcwWls6gU
 ieHiyE6yU+uC4o57nhbjQfBh2Qo8Q4x7KVtYlNKZA17tKlJMiYAvEyS+MYJDIBfhst2FqWiSclt
 5k9p4X5haJJn1A88Q2rLY33k5+t5yAjPRA62bXWOmsLZfMsLlpHJi+OATfHTDLuvoSRcFZMaIAX
 qo/a4Xif7xvKnqUCGkq5YDTmol+dKKrBA4mStUM2s4Dw=
X-Received: by 2002:a5d:59ad:0:b0:460:3234:77d5 with SMTP id
 ffacd0b85a97d-46074b946d4mr15994341f8f.43.1781541360700; 
 Mon, 15 Jun 2026 09:36:00 -0700 (PDT)
X-Received: by 2002:a5d:59ad:0:b0:460:3234:77d5 with SMTP id
 ffacd0b85a97d-46074b946d4mr15994293f8f.43.1781541360131; 
 Mon, 15 Jun 2026 09:36:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c4240sm33039078f8f.27.2026.06.15.09.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 09:35:59 -0700 (PDT)
Date: Mon, 15 Jun 2026 12:35:55 -0400
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
Message-ID: <20260615123354-mutt-send-email-mst@kernel.org>
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <93fb3b41-1543-4e3b-922b-043b774f57bf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93fb3b41-1543-4e3b-922b-043b774f57bf@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jun 15, 2026 at 08:17:14AM -0700, Richard Henderson wrote:
> On 6/15/26 03:01, Gavin Shan wrote:
> > +void qemu_ram_copy(void *dest, const void *src, size_t n)
> > +{
> > +    if (HOST_UNALIGNED_MMIO_OK) {
> > +        switch (n) {
> > +        case 1:
> > +            __builtin_memcpy(dest, src, 1);
> > +            break;
> > +        case 2:
> > +            __builtin_memcpy(dest, src, 2);
> > +            break;
> > +        case 4:
> > +            __builtin_memcpy(dest, src, 4);
> > +            break;
> > +        case 8:
> > +            __builtin_memcpy(dest, src, 8);
> > +            break;
> > +        default:
> > +            memcpy(dest, src, n);
> > +        }
> > +    } else {
> > +        uintptr_t test, lsb;
> > +
> > +        do {
> > +            test = (uintptr_t)dest | n;
> > +            lsb = test & -test;
> > +            switch (lsb) {
> 
> Either assert n != 0 to start, or use while not do/while.
> Because the body of the loop won't handle n == 0 correctly.
> 
> > +            case 1:
> > +                *(uint8_t *)dest = *(uint8_t *)src;
> > +                src += 1;
> > +                dest += 1;
> > +                n -= 1;
> > +                break;
> > +            case 2:
> > +                *(uint16_t *)dest = *(uint16_t *)src;
> > +                src += 2;
> > +                dest += 2;
> > +                n -= 2;
> > +                break;
> > +            case 4:
> > +                *(uint32_t *)dest = *(uint32_t *)src;
> > +                src += 4;
> > +                dest += 4;
> > +                n -= 4;
> > +                break;
> > +            default:
> > +                *(uint64_t *)dest = *(uint64_t *)src;
> > +                src += 8;
> > +                dest += 8;
> > +                n -= 8;
> 
> Use qatomic_set for the stores.


Won't this do things like locked on x86?



> 
> src is not aligned, so except for case 1, you need ld{uw,l,q}_he_p.

These just map back to memcpy. What is the point?

> > +void qemu_ram_move(void *dest, const void *src, size_t n)
> > +{
> > +    if (HOST_UNALIGNED_MMIO_OK) {
> > +        switch (n) {
> > +        case 1:
> > +            __builtin_memmove(dest, src, 1);
> > +            break;
> > +        case 2:
> > +            __builtin_memmove(dest, src, 2);
> > +            break;
> > +        case 4:
> > +            __builtin_memmove(dest, src, 4);
> > +            break;
> > +        case 8:
> > +            __builtin_memmove(dest, src, 8);
> > +            break;
> > +        default:
> > +            memmove(dest, src, n);
> > +        }
> > +    } else {
> > +        qemu_ram_copy(dest, src, n);
> > +    }
> > +}
> 
> The qemu_ram_copy implementation above does not work with overlapping blocks.

IIUC copy is not supposed to. this is what move is for.

> 
> r~


