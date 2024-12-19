Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9658E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJKD-0005SP-Qq; Thu, 19 Dec 2024 11:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOJFa-0001op-9X
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:19:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tOJFX-0003qU-LP
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 11:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734625182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EGqG8eofY0QYFV4VZnkq3s9w1HpOkxUlQP+WE2YUKnk=;
 b=INOke80+u0+ozYxH6/BZ6df57Kv5+9+95F4hUoeMjhqkbFoqzrZmaV3Bcvj3G+O+x0o+0Q
 zv3CA4Onoxet3RULojC6KAhi++0fTY8anXhZHSEHXNwAMtRVef/6FRYw9sV+XCorjkYcgF
 r1FQeE8ttgNCHaxcHtqbNIb+ekYAm4M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-4sM4N9XYP0OfxnQ8uz3G6g-1; Thu, 19 Dec 2024 11:19:40 -0500
X-MC-Unique: 4sM4N9XYP0OfxnQ8uz3G6g-1
X-Mimecast-MFC-AGG-ID: 4sM4N9XYP0OfxnQ8uz3G6g
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa68203d288so66817666b.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 08:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734625179; x=1735229979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EGqG8eofY0QYFV4VZnkq3s9w1HpOkxUlQP+WE2YUKnk=;
 b=RGwiE1i6WiHVZyZVYU4xKt/pb7lLLgNG4jqyLc4YmrxttZKoIncNyOegXLRpSjzfO4
 qGtAxK3+8JFzopf9BetJHoHncYLrM6+ezYoUASSGRTg/s+SsPuHY8lg+fgEO5sht7wQ9
 hi29B9DwoLwPWXuda+2JuCAMQtvS1etBw+yVhmc6dfGXx1hdBtET3hOwHIfs5d8scU9q
 10cySpna4Uh3cN2H7YUlKc6gNbn/dOT4GuIHXSfAhSg4WmO63IkACfESBBPXtFuaGO8d
 4b9tsz+HSFUtklH+EA2GK4wVPoKa/qVrJzde5GzUy5c1ldDIL3cFzPK42u5FHV9Zw/zG
 AlHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYcqr1QEJCIJwWrHSlLW2vSTin28wrQ7N7Z0pYsN1ZRDnuPzBM+XmxpCS5BJNMo1dEBPwvPmgAL4F0@nongnu.org
X-Gm-Message-State: AOJu0YyKk2nn2e4MIO3G8LlBYVe6kU9DS2EGXaVzgRmsX7HJR4DQzTZM
 KkRUPGAty12IskLBPkAlLN11J+9qN5Ynjw8uuMhP2VVs6ti+hsRwc1WZP4S23ZfOnHJzlM5Rhy5
 kI41whQh7v4KazohHycgjOYMZQnsPMaXHoIA3G3D0BkRs0fZzv6rB5b13mnLa5ijb+B/S1qQuPZ
 RQX1+DM4YtzVF9a4gNEBdDuFswzoQ=
X-Gm-Gg: ASbGnct54LMDLxSgniQN8YxVKjaF4ecAQNX0NFfJzriAEL2KICwOUSfT104CSZdyNSx
 0gAfRp0g++VvX9dhgVw93GBYmALEoN21vTpWtGtg=
X-Received: by 2002:a17:907:72c7:b0:aab:d4f0:c598 with SMTP id
 a640c23a62f3a-aabf478a5d0mr732261066b.27.1734625179493; 
 Thu, 19 Dec 2024 08:19:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRCVSsKbNuzxvwV6fK2Xf/kPDAbHHv69iAXol4T5wT0zDOzuJuXfJXZwmDdNpIS3H02IrKi1Ay/fYk2tpVQzI=
X-Received: by 2002:a17:907:72c7:b0:aab:d4f0:c598 with SMTP id
 a640c23a62f3a-aabf478a5d0mr732258066b.27.1734625179079; Thu, 19 Dec 2024
 08:19:39 -0800 (PST)
MIME-Version: 1.0
References: <20241219153857.57450-1-philmd@linaro.org>
 <Z2RCaZrwjYSM3NpV@redhat.com>
In-Reply-To: <Z2RCaZrwjYSM3NpV@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 19 Dec 2024 21:49:26 +0530
Message-ID: <CAK3XEhNVb8pcUrZD=cYEC_Y5bO_hdPHizde2K=Keqdgo7+xxpw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] hw/misc/vmcoreinfo: Convert from QDev to plain
 Object
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="0000000000009e2a5b0629a1e5f6"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

--0000000000009e2a5b0629a1e5f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Dec, 2024, 9:27 pm Daniel P. Berrang=C3=A9, <berrange@redhat.com=
>
wrote:

> On Thu, Dec 19, 2024 at 04:38:47PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > No reason for vmcoreinfo to be based on QDev, since it
> > doesn't use any QDev API. Demote to plain Object.
>
> I'm not especially convinced by that rationale, at least in the short
> term[1].
>
> As a user of QEMU, I would tend to view -device  as being the way to
> create devices that are visible to the guest, and -object as being
> for dealing with host backends.
>
> vmcoreinfo is quite an unusal device, in that if only exists as a
> fwcfg field, but that's an internal impl detail from a user's POV,
> and it is still a guest visible device type.
>
> So while it may not leverage QDev API, I still feel it is more of
> a fit for -device, than -object.


+1 to this.

Is there any functional benefit
> to moving it to -object, that outweighs the disruption ?


>

--0000000000009e2a5b0629a1e5f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 19 Dec, 2024, 9:27 pm Da=
niel P. Berrang=C3=A9, &lt;<a href=3D"mailto:berrange@redhat.com">berrange@=
redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Thu, =
Dec 19, 2024 at 04:38:47PM +0100, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; No reason for vmcoreinfo to be based on QDev, since it<br>
&gt; doesn&#39;t use any QDev API. Demote to plain Object.<br>
<br>
I&#39;m not especially convinced by that rationale, at least in the short<b=
r>
term[1].<br>
<br>
As a user of QEMU, I would tend to view -device=C2=A0 as being the way to<b=
r>
create devices that are visible to the guest, and -object as being<br>
for dealing with host backends.<br>
<br>
vmcoreinfo is quite an unusal device, in that if only exists as a<br>
fwcfg field, but that&#39;s an internal impl detail from a user&#39;s POV,<=
br>
and it is still a guest visible device type.<br>
<br>
So while it may not leverage QDev API, I still feel it is more of<br>
a fit for -device, than -object.=C2=A0</blockquote></div></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">+1 to this.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex"> Is there any functional benefit<br>
to moving it to -object, that outweighs the disruption ?</blockquote></div>=
</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><br>
</blockquote></div></div></div>

--0000000000009e2a5b0629a1e5f6--


