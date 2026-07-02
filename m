Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF46C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfD9K-00047j-Do; Thu, 02 Jul 2026 04:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wfD9G-00044l-MG
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 04:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wfD9F-0002zF-10
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 04:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782982311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0VTNqaA4ajIcpQS4Pj7inIBwhrRYkjIoYROFLbuuNq8=;
 b=K96KvcX/oV6h18UfJGPmpMU09LTACw5OyIDz1YY3nF1v3HUxQbIM0j9OJ5sAt/BSbo0/AF
 qz8zLuE1RVw9tn2IBUq+LOE3b6GhQE1EZLreDouKPImu7UMKAzfZZv/VdlGu2owE9uFI3H
 dmygEUEnmDVrKUTBNEx1dB0OSkYEEUY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-EMA3kRTQNz2aO8_olP90fw-1; Thu, 02 Jul 2026 04:51:48 -0400
X-MC-Unique: EMA3kRTQNz2aO8_olP90fw-1
X-Mimecast-MFC-AGG-ID: EMA3kRTQNz2aO8_olP90fw_1782982307
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4731a357b0aso1589930f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 01:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782982307; cv=none;
 d=google.com; s=arc-20260327;
 b=YKRIkldfe9lwyQhHKTpZ6MIOiVrdWSZljLnwrKPpl/zOcuL5hHBkDuedi6P7P1fS3q
 OuUTB+3r1d6QJYd/LVHrQeYGRoo9jQTSNuG2OZ4ydijE1WyhpUnPL6nYbDb9GzSz06r1
 nd58SUkTdEbT2/1i6qwBm8hTAAyFBHHZxuev2eSd3kdHKVLxJUZ3RYj0ow62l0nP5s/k
 xnefDVH5kMbUjtlcxrSJbnlOt/V3uZj2Uv4cfUnP2J1ecBh3Q0lxlL+0MoFaoIs0IM5/
 yD9BAFfS/W0oIAYsqdVC2JP5EG9SSgG1o1dsPrA69anrmpO8JpNf0oZMc6GQDG+8sh1G
 DmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0VTNqaA4ajIcpQS4Pj7inIBwhrRYkjIoYROFLbuuNq8=;
 fh=Y6ZVa2DAQ7N99Yz30qJegDSPM58qw0hum3KbRozMzY4=;
 b=MLZenPUI9tDX/qYDqrrEfPiEsWBnGrroNvyC2Zt3BtH5s/vvEnXzYcDfJFHykDY4HU
 fFf5QtZhH5X4oz7Gx/WVvrMqOsmuefUxXzW9sHhkHneYLiJjZ4/jCF4ELe0ePUDeNXC3
 yu8QClpYSNAXN2emyIbDM+yWNd5zFR41HUKVEi7WLNVzlAzxV480gO5E5S9jH350ACta
 Nt+wG8KKraZZCQI4TpUd4xQtX5Co6sNVHdiCoJtCA0pSD0X1lo6LQnQ4QE9gkWuwFabs
 BI6GVh/qrcLIE+LtCKCqcYVpnybATAKTPF1/JbwSNCMa/FfaKAZksv1hkAOmt47j7Uog
 59Mw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782982307; x=1783587107; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0VTNqaA4ajIcpQS4Pj7inIBwhrRYkjIoYROFLbuuNq8=;
 b=HNUBAz2sWzrMcIfCL6pLp/PwY6aVi4mjE8XI2R8TOhKZ0HoNVvDC4+T/FU07YdMTMP
 bEYNxDhSL/bSYJW9lD+T6wpftGwar9AWsxLiIcTjrOtvKDIXpxuNtWFe4+ryq1jq+wiB
 4btBi+FNSkwfGyuZzPaDpuB9ZSB0xIdBHXA8MqKI7eAFXM3F4sMMtUqx9NTv2baid/yl
 oZOb42hdwgzttv3UK9zz1TyXOFoT+s1FJG/Rc4T7HaVQxZpy6Eggys1lawn7gFShqIqL
 roc4/Mdd4nd9Yp2MaCxJr4EsCawbXZ/UYX7TnoHY88jHV8e8Lt0UAhZspgI8bUJNW6wp
 cIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782982307; x=1783587107;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0VTNqaA4ajIcpQS4Pj7inIBwhrRYkjIoYROFLbuuNq8=;
 b=KFN9V3CNoF5WpEfjuFWM96898U0giFxUPx52zP+TwMwUqid2FV/IbcmYBN9pgx6dmG
 DCnrWlnA9kmW6qe/gs4b7CnRP/S0wvHn134+cXvHYoe1gJWEElkMg98VYKAe6Ag1W+91
 kTNZA6K/pwWfvSNjposrq89xuV0F/uyieJg2K/9Cb3EaYPZHNeWW+gqh3Bt2eCeMB/2o
 GD6PPEYciS8Gluu0nAf3l1ZGf5U9BTT01l/UJpISmGRY4kR32NSLJEfYOUfqzV8s7Inf
 ys6m9Dqp5UVofafaIhu/wCFWXd0G6o4jqZ2+yi6h9EB66LrluhYx1eF91lP8g1NU3EZj
 l0qw==
X-Gm-Message-State: AOJu0Yxig8MN8cTno1CIYeHLHt1DU4jBQxKn7BjY1fIirfgrAgGCBB4w
 LiPE+UfqDw0Y34Ceo0gJ1avRgspWA+BMUXpncU97J/W/rG/yja3dN7gRagbNzX4F3qm4NyLR7dh
 brw2EEBmAM0cZupnVjA+VT2y5It/oY/LUUKVZHkgnpkyUyr2lUBRIlvEkniWVZiBFcDKXR8dZ9U
 bfJX5KZxhy/uY5jJpYtt+qIDETsDTck+w=
X-Gm-Gg: AfdE7clLISLqaKAZOlniyHcfNJtDQxD8byAQ0BHsnmQIgBSIkaJDTXGhp0AWAWhAQkX
 lzbD2rrtuNJAfujn6FLkEaK4hmzA1sxYrIoXzuLYS+2IO20Ly5Su9KfBKs9tOdzVXO3jZTSDuZe
 ScSJrAx7ubFJNeMSRDSXWfRefV1mazlSRMdaPfRj8W5/J5n0cfKt/epTZHFIXq9ueKVwlawtbVL
 aN3oj1y8v4NH1I74UdQH9kWv+OFcuBiG85q+APzfFUeu4iD+3cazQ04NDr8yuPilzuts/8=
X-Received: by 2002:a05:600c:4e4c:b0:492:465c:56f6 with SMTP id
 5b1f17b1804b1-493c3cd54f8mr66454185e9.10.1782982307379; 
 Thu, 02 Jul 2026 01:51:47 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4c:b0:492:465c:56f6 with SMTP id
 5b1f17b1804b1-493c3cd54f8mr66453785e9.10.1782982307011; Thu, 02 Jul 2026
 01:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
 <CABgObfbgqcSYekjGkuDCUibQc8j4iyGPbajU_-VdPsGkLZgiLQ@mail.gmail.com>
 <akUyiNahX3LnFPhn@example.com>
In-Reply-To: <akUyiNahX3LnFPhn@example.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 2 Jul 2026 10:51:35 +0200
X-Gm-Features: AVVi8CfbPsbO0qo7bnOyACHfWKy3dpeYKB2b9AIggUBu2K0dLoNnzm6KIHnuSi0
Message-ID: <CABgObfbQTUOaiMYApABTettYa0D3WasGs1NjQrWvo4tmAZpazg@mail.gmail.com>
Subject: Re: [PATCH 16/34] target/i386/mshv: migrate LAPIC state
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <liuwe@microsoft.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000cf05b06559ceb79"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000000cf05b06559ceb79
Content-Type: text/plain; charset="UTF-8"

Il mer 1 lug 2026, 17:30 Magnus Kulke <magnuskulke@linux.microsoft.com> ha
scritto:

> On Fri, Jun 26, 2026 at 09:27:20AM +0200, Paolo Bonzini wrote:
> > Il ven 17 apr 2026, 12:57 Magnus Kulke <magnuskulke@linux.microsoft.com>
> ha
> > scritto:
> >
> > > +#ifdef CONFIG_MSHV
> >
> > + VMSTATE_BUFFER(hv_lapic_state, APICCommonState),
> >
> > +#endif
> >
> >
> > This breaks migration across releases for everyone else, and also across
> > builds that have different --enable-mshv. Compile-time defines are almost
> > always wrong in VMState definitions.
> >
> >      DeviceState *vapic;
> > >      hwaddr vapic_paddr; /* note: persistence via kvmvapic */
> > >      uint32_t extended_log_dest;
> > > +
> > > +#ifdef CONFIG_MSHV
> > > +    uint8_t hv_lapic_state[sizeof(struct
> > > hv_local_interrupt_controller_state)];
> > > +#endif
> > >
> >
> > No, this is called common for a reason. You need to implement a subclass
> > and handle migration in there.
> >
>
> makes sense. I think I found a way to put the additional fields into a
> subclass.


What are the additional fields that aren't covered (i.e. cannot be copied
from hv_lapic_state to the struct and back) by the common APIC state?

Paolo

the apic_id is semantic, so we cannot use the auto-wiring
> dc->vmds state, but APIC_COMMON is doing the same. I'll send a revised
> patch
> soon.
>
> thanks,
>
> magnus
>
>

--0000000000000cf05b06559ceb79
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 1 lug 2026, 17:30 Magnus =
Kulke &lt;<a href=3D"mailto:magnuskulke@linux.microsoft.com">magnuskulke@li=
nux.microsoft.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Fri, Jun 26, 2026 at 09:27:20AM +0200, Paolo Bonzi=
ni wrote:<br>
&gt; Il ven 17 apr 2026, 12:57 Magnus Kulke &lt;<a href=3D"mailto:magnuskul=
ke@linux.microsoft.com" target=3D"_blank" rel=3D"noreferrer">magnuskulke@li=
nux.microsoft.com</a>&gt; ha<br>
&gt; scritto:<br>
&gt; <br>
&gt; &gt; +#ifdef CONFIG_MSHV<br>
&gt; <br>
&gt; + VMSTATE_BUFFER(hv_lapic_state, APICCommonState),<br>
&gt; <br>
&gt; +#endif<br>
&gt; <br>
&gt; <br>
&gt; This breaks migration across releases for everyone else, and also acro=
ss<br>
&gt; builds that have different --enable-mshv. Compile-time defines are alm=
ost<br>
&gt; always wrong in VMState definitions.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 DeviceState *vapic;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 hwaddr vapic_paddr; /* note: persistence via =
kvmvapic */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint32_t extended_log_dest;<br>
&gt; &gt; +<br>
&gt; &gt; +#ifdef CONFIG_MSHV<br>
&gt; &gt; +=C2=A0 =C2=A0 uint8_t hv_lapic_state[sizeof(struct<br>
&gt; &gt; hv_local_interrupt_controller_state)];<br>
&gt; &gt; +#endif<br>
&gt; &gt;<br>
&gt; <br>
&gt; No, this is called common for a reason. You need to implement a subcla=
ss<br>
&gt; and handle migration in there.<br>
&gt; <br>
<br>
makes sense. I think I found a way to put the additional fields into a<br>
subclass.</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">What are the additional fields that aren&#39;t covered (i.e. cannot be=
 copied from hv_lapic_state to the struct and back) by the common APIC stat=
e?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote=
_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">the apic_id i=
s semantic, so we cannot use the auto-wiring<br>
dc-&gt;vmds state, but APIC_COMMON is doing the same. I&#39;ll send a revis=
ed patch<br>
soon.<br>
<br>
thanks,<br>
<br>
magnus<br>
<br>
</blockquote></div></div></div>

--0000000000000cf05b06559ceb79--


