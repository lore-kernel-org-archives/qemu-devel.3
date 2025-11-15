Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75928CEB2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 07:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKB7l-00066v-2U; Sat, 15 Nov 2025 02:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKB7e-00064E-P6
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 02:55:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKB7c-0005sh-Pf
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 02:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763193298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xp8haX/tSUvRQBNPQ4sbb/FavjG8GzUVdNoTi4U72J8=;
 b=GTNIk12h8Uyr4gvZgINDzPe1X6J4ybASVIV6lHRwlWsCFJodwkaSBGpIYmuLbAjrG/8ekN
 vBvn+2lraPewaMDkS5hx9q8XGCuc9qF9/lMLQOZtyNtRCN7EsxFdc8Go3y7/16TW/kgPa0
 UBBWpt4w4fqDYicXMwWkYho2DIUIJZ4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-cTu2F7mEOV2yYWeYil_Yvw-1; Sat, 15 Nov 2025 02:54:56 -0500
X-MC-Unique: cTu2F7mEOV2yYWeYil_Yvw-1
X-Mimecast-MFC-AGG-ID: cTu2F7mEOV2yYWeYil_Yvw_1763193296
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b2ad29140so1289653f8f.0
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 23:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763193295; x=1763798095; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xp8haX/tSUvRQBNPQ4sbb/FavjG8GzUVdNoTi4U72J8=;
 b=Y7bM6ZcbBL50opKsVesoLCfaw5QOHj8j3WW52W4ZP7lvNQqgGrPAQMxhZNpQWLFkaa
 o1LDHU/Zz4o0rCSRHHyzLAL+XFgsWUvDqzM09Epa0xdQ4L3BMkEuZawsN4zorvKV4p7Q
 43i+JBfO6yj4np/mMcxsP571ULopS50GCR8wYVpo2miy+ZYmhnympCI4x9amLoccwPys
 tK01eXB7p7Yb9WYve7+UFDFzs6bU6dqnD+A4+p1EH14Wiu+Q2Tkk3cUbDeok3h3DUt+G
 eN7f7idOZh/mwpu8m+Qn0MOtx3p0TeYczrPtHNIDWucBbtzy2/M8eKv63LpkMv7/wuJe
 2j8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763193295; x=1763798095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xp8haX/tSUvRQBNPQ4sbb/FavjG8GzUVdNoTi4U72J8=;
 b=OZT28ezDIU5u4Z8Xdne6rAY+JzCDImDfdnPq7VypwPGT6279qZKHEwp5lEt7xHp4LQ
 W5jq22fMko4JvoSKnpUKzpvdizHgQ5tqHz4ZqoVK5qsMWC1dUGFaFkfPAUhmrNQrCVeo
 sfJw/eO1rgucRaJnOGiSmBK1ExznPihU9F0fbyIpJJQPQ41izwqB8OIeOP00WuoV48No
 w1grCEb37tUwHtS5cc322BnlLVkAdZfww/mrer8aPrep1IMypkXbqfX9DgnxHY9MuzFs
 1XgJxrGNfaz4c/b7zm8f4VRSWW3wfNxrJOzddEcZEf3Ovv6PCwXS3QXtOF4crsj/q8oc
 wd8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqDIJmganLsgqBgGDqTjA8naiqBGEOnOq2/CQNAcfqS5Z2VsWm4uhK2DWWVot1dYXfK4WlGaonQM8f@nongnu.org
X-Gm-Message-State: AOJu0YzIeL61U5p01D9pdZGrWHYE1LxHgTjFV9wfuU1hNmnoX3A7KH3f
 FvBDNLllhm7GpPiU/dY+k7piIb85ln1FnyyQMbf29NFNxsYpvN+qWtdD30Ak9Ey18WES88x87TF
 Z64ascm6h1ZSL21NqVjA85CMY7kF/MXY/Rfit57p4qr9qcfaajW72j3R2T/hDWg5nWYo9rWQo2o
 pKWkMuoVgqrIQiPS0iCVlGADTq4VpqzbQ=
X-Gm-Gg: ASbGnctUva81s1VRkyO6nTNc0o6m1LW8xytM5KWbAdEx7HEEPEcZRQ4rocniF+60NrL
 cZ2ebhrnDySZfnx1e+MJ49GepWklyWDV+c7Ev7RQYfcjSwgnCAfhyckqg/3+meuG/uQo8mgDa81
 C2jdkJ9Mj5jn69W92AyxTMyrT/fwEHFbU4KuYt7c+NrpS1UmQGMVC6tjTXgFP2hwpVyRjb/irXt
 +npDdPi77sh6pTVNZh7YS3FdAJB5H6jvXnLAZ0kZjMxZcQhDEeH3/3rtR5W
X-Received: by 2002:a05:6000:26c8:b0:42b:3ee9:4773 with SMTP id
 ffacd0b85a97d-42b59323452mr5157736f8f.7.1763193295701; 
 Fri, 14 Nov 2025 23:54:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGj7D+5kJ2aA+4PRB0jCFxjIF3rwQgW/Ma3S4bH/iglxpZ99WlZw0lQ/IWT7sjVuspa/y2vSZ28AFtBSrJzC18=
X-Received: by 2002:a05:6000:26c8:b0:42b:3ee9:4773 with SMTP id
 ffacd0b85a97d-42b59323452mr5157713f8f.7.1763193295290; Fri, 14 Nov 2025
 23:54:55 -0800 (PST)
MIME-Version: 1.0
References: <20251113051937.4017675-1-zhao1.liu@intel.com>
 <20251113051937.4017675-11-zhao1.liu@intel.com>
 <12e93226-b70d-4c9c-bf8a-db7e0e05b585@redhat.com> <aRayIQYzGkUK4Emv@intel.com>
In-Reply-To: <aRayIQYzGkUK4Emv@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 15 Nov 2025 08:54:43 +0100
X-Gm-Features: AWmQ_blE2W28576FQu2SZVsBU9ciw0W2eOIn596d4q0mPkoXjOhw_kFHu9ZYO08
Message-ID: <CABgObfZtmYkFAL9pFtqpoxUDi0OXPX3Dgfxmbk6bX_bx7dGztw@mail.gmail.com>
Subject: Re: [PATCH 10/22] rust/hpet: Abstract HPETTimerRegisters struct
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 "open list:Rust-related patc..." <qemu-rust@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000000954e806439d6e0a"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000000954e806439d6e0a
Content-Type: text/plain; charset="UTF-8"

Il ven 14 nov 2025, 05:15 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> Yes, this will reduce BQL context in lockless IO a lot. And I'll based
> on your patch to extract HPETTimer from BqlRefCell.
>
> > Preserving the old migration format can then be solved in two ways:
> >
> > 1) with a handwritten ToMigrationStateShared implementation for
> > HPETTimer (and marking the tn_regs array as #[migration_state(omit)])
>
> Yes, compared with 2), I also this is the better choice, which looks
> more common and could be an good example for other device.
>
> > 2) by also adding num_timers_save and the timer's expiration to
> > HPETRegisters and HPETTimerRegisters, respectively.
> >
> > I think I prefer the former, but I haven't written the code so it's
> > not my choice. :)
>

Yes, it is much better.

> @@ -181,6 +181,9 @@ fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
> >  #[repr(C)]
> >  #[derive(Debug, Default, ToMigrationState)]
> >  pub struct HPETTimerRegisters {
> > +    // Only needed for migration
> > +    index: u8,
>
> I didn't get the point why we need to migrate this "index" instead of
> HPETTimer::index?
>

Just because it's still migrating HPETTimerRegisters, but yes it's not
necessary with the custom ToMigrationStateShared, as you write below.

Paolo


> Anyway, if we continue to keep index in HPETTimerRegisters, we can make
> it have usize type with a "#[migration_state(try_into(u8))]" property.
>
> If we just HPETTimer::index for migration, I think it's possible to do
> type convertion in handwritten ToMigrationStateShared.
>
> Thanks,
> Zhao
>
>

--0000000000000954e806439d6e0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 14 nov 2025, 05:15 Zhao L=
iu &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Yes, =
this will reduce BQL context in lockless IO a lot. And I&#39;ll based<br>
on your patch to extract HPETTimer from BqlRefCell.<br>
<br>
&gt; Preserving the old migration format can then be solved in two ways:<br=
>
&gt; <br>
&gt; 1) with a handwritten ToMigrationStateShared implementation for<br>
&gt; HPETTimer (and marking the tn_regs array as #[migration_state(omit)])<=
br>
<br>
Yes, compared with 2), I also this is the better choice, which looks<br>
more common and could be an good example for other device.<br>
<br>
&gt; 2) by also adding num_timers_save and the timer&#39;s expiration to<br=
>
&gt; HPETRegisters and HPETTimerRegisters, respectively.<br>
&gt; <br>
&gt; I think I prefer the former, but I haven&#39;t written the code so it&=
#39;s<br>
&gt; not my choice. :)<br></blockquote></div></div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Yes, it is much better.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">&gt; @@ -181,6 +181,9 @@ fn t=
imer_handler(timer_cell: &amp;BqlRefCell&lt;HPETTimer&gt;) {<br>
&gt;=C2=A0 #[repr(C)]<br>
&gt;=C2=A0 #[derive(Debug, Default, ToMigrationState)]<br>
&gt;=C2=A0 pub struct HPETTimerRegisters {<br>
&gt; +=C2=A0 =C2=A0 // Only needed for migration<br>
&gt; +=C2=A0 =C2=A0 index: u8,<br>
<br>
I didn&#39;t get the point why we need to migrate this &quot;index&quot; in=
stead of<br>
HPETTimer::index?<br></blockquote></div></div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Just because it&#39;s still migrating HPETTimerRegisters, =
but yes it&#39;s not necessary with the custom ToMigrationStateShared, as y=
ou write below.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote =
gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Anyway, if we continue to keep index in HPETTimerRegisters, we can make<br>
it have usize type with a &quot;#[migration_state(try_into(u8))]&quot; prop=
erty.<br>
<br>
If we just HPETTimer::index for migration, I think it&#39;s possible to do<=
br>
type convertion in handwritten ToMigrationStateShared.<br>
<br>
Thanks,<br>
Zhao<br>
<br>
</blockquote></div></div></div>

--0000000000000954e806439d6e0a--


