Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5731C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 11:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfFtR-0002Rc-Bm; Thu, 02 Jul 2026 07:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wfFtL-0002RH-GX
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 07:47:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wfFtJ-0004n0-FU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 07:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782992855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hk1/fi4v816xHNT4Er8YyKQhCLuEm4cycLCAjYyei+4=;
 b=F10bsmcgbj4jtAP0IammIVkC8UkEpUMQXp5E8dDHgg+syTEN7trItqSBS0k5dJRZO17V3Y
 kU7IWsR3iQS9U6Mb0QPoeuBlOihDZBm1QOgVJF3jQz00n/uKi6y6NNiDt/wKVheSYF1Zpn
 Fm7LVo4idTpiUUsTHESpcz6kwZfry9k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-yfrrzmjsNSWcs7rqgN8Wjg-1; Thu, 02 Jul 2026 07:47:34 -0400
X-MC-Unique: yfrrzmjsNSWcs7rqgN8Wjg-1
X-Mimecast-MFC-AGG-ID: yfrrzmjsNSWcs7rqgN8Wjg_1782992853
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493c619bb52so4280015e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 04:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782992853; cv=none;
 d=google.com; s=arc-20260327;
 b=g9ANMFrGPpOzGq7BmH2cb7VR3+gQCjp6+2TjC65ZLqAp5e9MfQRGjbprNjT7E/u7HY
 trwLr0Ceyn5JluK7paiyT3ssl4TQIN5SMiBUJ4rBdQcjnHkB4s+AfVamDLr+gbn2scKC
 ajYpDCD0aMiTkr98+c26LvaoRnKoKoTYgVTFpEltGCG9hK3mZzzlQWr/0VPcLabxo5A7
 VvxbbokUfnXaUhYP4Rtg3ILYpl/bAsUxX98cbbmRBuflspSlAjcbQx00ss+RhwPxqMIs
 AfDosRf19ve1BdOV299g63C6kNC638D2F2XHZfDfFYdszkuh0Ju/3cLAnPcZpCZxyFdY
 Wu2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Hk1/fi4v816xHNT4Er8YyKQhCLuEm4cycLCAjYyei+4=;
 fh=Y6ZVa2DAQ7N99Yz30qJegDSPM58qw0hum3KbRozMzY4=;
 b=kbDgcipviaXc1CQaa5n/nbwxzOhEAXNx5S6R+nILZ3U+zX8VIGiYdJRMQ8+fJ2nrkW
 tJgfki6R7aEXj0HS6gUaXl9bDAhblaV/CbbRsYAQaqBkUcqykuJnrx7TfmhUx532/Np0
 +RSX/yxfaX0J8aTvzJnmMWayH06EFfNSCGnwYkOAKjO2oOVHnEH9G0nGtz2dj/slD/8R
 yMPVwmlrCl0zTspQLCLHzaVoUuSrjP7QlGCcKxCFFbVGCUAluF4+8qQK6rWl+Umo5SZF
 XVynQLV2FwUM28YsCdRlgg3mQk8EYwDQlYxg6mjdiCfljtojK8F6boRrxUZ5C5gVY9vF
 Pm5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782992853; x=1783597653; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hk1/fi4v816xHNT4Er8YyKQhCLuEm4cycLCAjYyei+4=;
 b=g759HszUf3i9GBuiSlfIFTEzBgkf07eMeU3T+wi+OMve0HYyYauEAjV7mxkVUaP8BA
 TzblyXv2796Z/lATCa2Q9kfxKZHJWH9GgsGDo3BKfOPmrtYW9xdCRJjZ3ccx8mLEVIuu
 wp42DwftQO8eZ912k5hJkrlwtrLmvhdq13bdc2l6Xz0BdXq2hsZKBTK7KJooG4i0kWEl
 zOD209iHUQYsBb/akxsp4igShXuh4XUGxDOuquKBVgEARxEgN5K2BKfZplHqhyRncZaU
 1LIpcEMWvhdy7nWeiF6mwwQWUCqGQbmLFPD8Anqm2FD0lEyRa8xdTPwuII7dstZ8IE0E
 x7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782992853; x=1783597653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hk1/fi4v816xHNT4Er8YyKQhCLuEm4cycLCAjYyei+4=;
 b=qdhy9wUZpu2rhvjv3TJsST+pCgIpWhd4g4W73O4L+unKDXUJwCb3A7KBneWOInz+um
 7LD6oKnxLrmj/6AHhNtdxsYSD3wsKBh+fDWuexnG0XKrwWGHdgJhVwxa2fsnbt4/51r9
 VQjwe5W/xp8/PYSx5VxKKYVtIr3N0rwtd6MAdxrDwiIIuQlg2YjTTlkIZjwVUvl1jGSv
 PR3ZAg9j/AiVKyHzlBhRlHn8rhpAyup4JNqKp8ZWzytLjbcnZLs5ADOiz0mkBT0yen5w
 1n7qa+m3iAsxaqF9faplgEbsaeuWiqBCHpZ6r1vArrA6lj837UwNrNfyhlifndvsAl4s
 u6qQ==
X-Gm-Message-State: AOJu0Yx5qsYFzs6Kso2WK3dnKoHURIS9aYC/UR3Ba7omSTJRevSo7Ti0
 rL/LOQucFbx+/4IyKbH6ypBc+4uaE/CQmAd6nl6ZLiPbaq50JnlsS082Hxwkh9lkd2XIKZRxlyk
 1Rb2fIt3HDRMCa5m6Eo0qSUO7j6YVpoTxg4xEV8op5us85/IZjfVdJkhIyxtoM59p+/1lnfpBmR
 fiPdcjh4osjFOlB/0zY17D7CHJUvZlQ88=
X-Gm-Gg: AfdE7ckdhCAQZyqb/81EwbvoH+3FjyqXRitid0vdObBqUOg6v5PHtSTXajtQB5/OcEk
 QDj+EmEj4f+092kYjp8yP5ZDj3ltMBGNagEjKs7D5MqdWKTeAbByyPDkKThYUTCXclFDGbA2OcK
 hQBGZFDsmpBzPcBtq43DOY6TxiQnuhl2Zx6c3tXzPj6G9IFh3A04tn+RC7E1nbOvKuOKew84x/0
 rrYOpN492zG1QaN2hF7jBk4WEA1IzNCfqgpg4KZy2cf+vRaBpxRLfCKjYhx82loBb054+k=
X-Received: by 2002:a05:600d:c:b0:493:b771:ddf9 with SMTP id
 5b1f17b1804b1-493c2b3d048mr62931145e9.1.1782992852840; 
 Thu, 02 Jul 2026 04:47:32 -0700 (PDT)
X-Received: by 2002:a05:600d:c:b0:493:b771:ddf9 with SMTP id
 5b1f17b1804b1-493c2b3d048mr62930775e9.1.1782992852384; Thu, 02 Jul 2026
 04:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
 <CABgObfbgqcSYekjGkuDCUibQc8j4iyGPbajU_-VdPsGkLZgiLQ@mail.gmail.com>
 <akUyiNahX3LnFPhn@example.com>
 <CABgObfbQTUOaiMYApABTettYa0D3WasGs1NjQrWvo4tmAZpazg@mail.gmail.com>
 <akY0Gpd/GHj3Pdun@example.com>
In-Reply-To: <akY0Gpd/GHj3Pdun@example.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 2 Jul 2026 13:47:19 +0200
X-Gm-Features: AVVi8Cc2s61FEbQmgi8z_ERaskybzwxwfFN9DsS31joGbGHLz47vv9qWDOuRJj0
Message-ID: <CABgObfZhNwXLG9ip=CnEiVb=p24etvxeodbjG5=Di4hOKvYF8Q@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="0000000000009a968c06559f5f8b"
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

--0000000000009a968c06559f5f8b
Content-Type: text/plain; charset="UTF-8"

Il gio 2 lug 2026, 11:49 Magnus Kulke <magnuskulke@linux.microsoft.com> ha
scritto:

> On Thu, Jul 02, 2026 at 10:51:35AM +0200, Paolo Bonzini wrote:
>
> > What are the additional fields that aren't covered (i.e. cannot be copied
> > from hv_lapic_state to the struct and back) by the common APIC state?
> >
>
> that would be those:
>
>     uint32_t apic_version;
>     uint32_t apic_lvt_lint0;
>     uint32_t apic_lvt_lint1;
>     uint32_t apic_lvt_cmci;
>     uint32_t apic_error_status;
>     uint32_t apic_counter_value;
>     uint32_t apic_remote_read;
>
> Reference struct is this: hv_local_interrupt_controller_state
>
> https://gitlab.com/qemu/qemu/-/blob/master/include/hw/hyperv/hvgdk_mini.h


For anything that's new but part of the standard APIC you can place them in
common APIC state, just making migration state part of a subsection.

Notably we have to do this for lvt_lint0+1. We cannot use the respective
> fields in the common APIC state, because writing to those has a side effect
> in QEMU: If unmasked, it will trigger a chain of events,
>
> pic_irq_request() => apic_accept_pic_intr() => apic_deliver_pic_intr()
>
> For MSHV (and WHPX afaiu) we're currently not able to trigger legacy
> interrupts from userspace in this fashion.


What is the issue? The interrupt won't be triggered either if you use a
separate field, or if you use the normal one.

For LINT1, can you not inject an NMI either?

Thanks,

Paolo

Hence we roundtrip
> lint0/lint1 in a dedicated mshv struct.


> best,
>
> magnus
>
>

--0000000000009a968c06559f5f8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 2 lug 2026, 11:49 Magnus =
Kulke &lt;<a href=3D"mailto:magnuskulke@linux.microsoft.com">magnuskulke@li=
nux.microsoft.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Thu, Jul 02, 2026 at 10:51:35AM +0200, Paolo Bonzi=
ni wrote:<br>
<br>
&gt; What are the additional fields that aren&#39;t covered (i.e. cannot be=
 copied<br>
&gt; from hv_lapic_state to the struct and back) by the common APIC state?<=
br>
&gt;<br>
<br>
that would be those:<br>
<br>
=C2=A0 =C2=A0 uint32_t apic_version;<br>
=C2=A0 =C2=A0 uint32_t apic_lvt_lint0;<br>
=C2=A0 =C2=A0 uint32_t apic_lvt_lint1;<br>
=C2=A0 =C2=A0 uint32_t apic_lvt_cmci;<br>
=C2=A0 =C2=A0 uint32_t apic_error_status;<br>
=C2=A0 =C2=A0 uint32_t apic_counter_value;<br>
=C2=A0 =C2=A0 uint32_t apic_remote_read;<br>
<br>
Reference struct is this: hv_local_interrupt_controller_state<br>
<br>
<a href=3D"https://gitlab.com/qemu/qemu/-/blob/master/include/hw/hyperv/hvg=
dk_mini.h" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.c=
om/qemu/qemu/-/blob/master/include/hw/hyperv/hvgdk_mini.h</a></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">For anything that&=
#39;s new but part of the standard APIC you can place them in common APIC s=
tate, just making migration state part of a subsection.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_conta=
iner"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Notably we have to =
do this for lvt_lint0+1. We cannot use the respective<br>
fields in the common APIC state, because writing to those has a side effect=
<br>
in QEMU: If unmasked, it will trigger a chain of events,<br>
<br>
pic_irq_request() =3D&gt; apic_accept_pic_intr() =3D&gt; apic_deliver_pic_i=
ntr()<br>
<br>
For MSHV (and WHPX afaiu) we&#39;re currently not able to trigger legacy<br=
>
interrupts from userspace in this fashion.</blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">What is the issue? The interrupt won&=
#39;t be triggered either if you use a separate field, or if you use the no=
rmal one.</div><div dir=3D"auto"><br></div><div dir=3D"auto">For LINT1, can=
 you not inject an NMI either?</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Thanks,</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote g=
mail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"> He=
nce we roundtrip<br>
lint0/lint1 in a dedicated mshv struct.</blockquote></div></div><div dir=3D=
"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
best,<br>
<br>
magnus<br>
<br>
</blockquote></div></div></div>

--0000000000009a968c06559f5f8b--


