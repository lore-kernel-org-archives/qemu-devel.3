Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28DBD59F6C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 19:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8m90-0000QO-PD; Wed, 06 Nov 2024 14:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8m8y-0000QE-Ja
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 14:56:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8m8u-00042s-3U
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 14:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730922996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qvX0+iM3PaxIIRBJI27mOc3LdbKkukEVlqiHmVVKWnM=;
 b=YJf06Ih0epdaxvvEQmUIgjaUlPavrlWEUjvl7SXndb2vCdfmKouwacFbZSHq8IAc500Dwa
 xC9Fba4kSMJZ6sBwCOTCuNb4IpsJ999t3M7BCp27wQ8zVc1Fqo09gNRdJIFhCHmrr/9+yg
 Rg9j/EXRQy4ZL3mV87EiX0vl5vw03F8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-xVkDRF1vOx-lnJ7VzSM8Tg-1; Wed, 06 Nov 2024 14:56:34 -0500
X-MC-Unique: xVkDRF1vOx-lnJ7VzSM8Tg-1
X-Mimecast-MFC-AGG-ID: xVkDRF1vOx-lnJ7VzSM8Tg
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-431518ae047so6955575e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 11:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730922993; x=1731527793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qvX0+iM3PaxIIRBJI27mOc3LdbKkukEVlqiHmVVKWnM=;
 b=tTa6tpvLb/cEnVtmQ9+oK9yjqHQma2jdsr5LFs4vaMyJ1zMic6FCH5CaZoAUwuc+da
 XIBydLlJMGTXxju/v+IeJRHGBUv3gyWzBDsjqUucR08SVwPbEACo3SXMTwY9VrpER64W
 74HFiySgJ0Anq2hBV7f+KQkJIJmYz+6hnnrqA75rRJddEwOmDNNmKKEimxmumX+8tQxI
 j4iHnz1Tj8LAERATR38WOAxwQhQ1q28jHr4eqPyO/R9jefQM2ZiPIMzQvch5e1Q0up5C
 pClUFqS7wS7jMbtpRQaCDZ7/U3k2abXss3CuosFYzQlSaQn+IXXm6BQUlh5xBwCHppzH
 x2/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiIV1vWNnMfLolfhYE9ne9SE+Ei51f2JGgnbpRgfOsp1po7AhqTzxusiYDnzAJdJYD2Q4/SXoEvc3U@nongnu.org
X-Gm-Message-State: AOJu0YzIPfsBxPT5tLfviVsx5B/rNb0dwOywHRbwFX7HE38J/v9VtMdZ
 e3Je8LwMzLIj38g51y1uUVVZYa4pT/ndl93D9ti5rexHR/JcrxHxlc+5Yzwvq8znJobqF3/tdgT
 G0beUg/nsYrC0bJZX8FpRHASSlfvzFKdBaHlWMUuVTFW7JEUsOF21k5Im7xDoodBDeYn2vQ5j3n
 26aKWvIRgCypK0yZYFYB69nNMg3sk=
X-Received: by 2002:a05:6000:1548:b0:37d:2e74:2eea with SMTP id
 ffacd0b85a97d-381ec725051mr352373f8f.5.1730922993693; 
 Wed, 06 Nov 2024 11:56:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH03pyLq0IyvydH7/dbvspKMduF5xcbd7g+QP2i4rs79AHTNwi5AS7PlUdnTiGVLcbtBIU9v9xTVqSQugMLb5M=
X-Received: by 2002:a05:6000:1548:b0:37d:2e74:2eea with SMTP id
 ffacd0b85a97d-381ec725051mr352354f8f.5.1730922993341; Wed, 06 Nov 2024
 11:56:33 -0800 (PST)
MIME-Version: 1.0
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-46-xiaoyao.li@intel.com>
 <8cd78103-5f49-4cbd-814d-a03a82a59231@redhat.com>
 <e5d02d7f-a989-4484-b0c1-3d7ac804ec73@intel.com>
 <a90e29a6-0e07-46a3-8dfc-658e02af9856@redhat.com>
 <35233d1f-eb6c-4882-abd6-884c1f559e12@intel.com>
In-Reply-To: <35233d1f-eb6c-4882-abd6-884c1f559e12@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 6 Nov 2024 20:56:21 +0100
Message-ID: <CABgObfYKjuhRrF1vz==UDaKAP4UHG0pyF5kgSzk1YXqs5XUv0w@mail.gmail.com>
Subject: Re: [PATCH v6 45/60] i386/tdx: Don't get/put guest state for TDX VMs
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 kvm <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000026f93b062643ea6b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000026f93b062643ea6b
Content-Type: text/plain; charset="UTF-8"

Il mer 6 nov 2024, 14:57 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:

> 8<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -457,7 +457,9 @@ int kvm_create_vcpu(CPUState *cpu)
>
>       cpu->kvm_fd = kvm_fd;
>       cpu->kvm_state = s;
> -    cpu->vcpu_dirty = true;
> +    if (!s->guest_state_protected) {
> +        cpu->vcpu_dirty = true;
> +    }
>

Yes, that works.

Paolo

      cpu->dirty_pages = 0;
>       cpu->throttle_us_per_full = 0;
>
> > Paolo
> >
>
>

--00000000000026f93b062643ea6b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 6 nov 2024, 14:57 Xiaoyao Li &lt;<a href=3D"mai=
lto:xiaoyao.li@intel.com">xiaoyao.li@intel.com</a>&gt; ha scritto:</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
8&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&l=
t;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;<br>
--- a/accel/kvm/kvm-all.c<br>
+++ b/accel/kvm/kvm-all.c<br>
@@ -457,7 +457,9 @@ int kvm_create_vcpu(CPUState *cpu)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 cpu-&gt;kvm_fd =3D kvm_fd;<br>
=C2=A0 =C2=A0 =C2=A0 cpu-&gt;kvm_state =3D s;<br>
-=C2=A0 =C2=A0 cpu-&gt;vcpu_dirty =3D true;<br>
+=C2=A0 =C2=A0 if (!s-&gt;guest_state_protected) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;vcpu_dirty =3D true;<br>
+=C2=A0 =C2=A0 }<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Yes, that works.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 cpu-&gt;dirty_pages =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 cpu-&gt;throttle_us_per_full =3D 0;<br>
<br>
&gt; Paolo<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--00000000000026f93b062643ea6b--


