Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06617103E171
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 12:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2qBm-0003Ms-4x; Wed, 18 Mar 2026 08:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1w2qBj-0003Mg-SR
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 08:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1w2qBf-0004Gt-JR
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 08:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773837585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gxfKXaSfciQ9SX5cYZt1VefRRc/I4yK8mJFzGnYRwGk=;
 b=covRzWy+1z18TDpXSHPqqvnKoyIEtYZFp1kLT7keiYm9SjhblK6cFjw8mFDB/w/ZEl/HFd
 NQzOE9DVPPxOvt6HR9jt8tkgBrtbF8VQ41TGqoTtEdk36EtrzEqwztOqUEZL42A30AkKj+
 mQZqd5V6AavzKjF3rqS0ftBewT7/5q8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-kAYIkjvROBmh-BuWH2AmiA-1; Wed, 18 Mar 2026 08:38:36 -0400
X-MC-Unique: kAYIkjvROBmh-BuWH2AmiA-1
X-Mimecast-MFC-AGG-ID: kAYIkjvROBmh-BuWH2AmiA_1773837514
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-38bd5d21ebfso7308801fa.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 05:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773837514; cv=none;
 d=google.com; s=arc-20240605;
 b=dcr2XgbP4+Ots0UawfD0mns6BEuM/7qHTzQ1lOEpjGSRNH+VOyeIk3Ijbo0F9CaYvx
 PU9TRMY7lHZ34OXxQTzvsOgnYyS0RDt49zhiRFC3VllEAToI0VALvEBmwZBxd+thISNb
 72WB1oQOYmuG1dj/gnvd7he+egLhVwMy5Xco5NUWSHq33GUQhfTcW5KqWkKoBAv+nIDw
 zGcyVhsKgT4LUdHTIfy8L8vNnQ7AgQveEa9zrCUXF0ksxzzLd0XqP3maRMIJ5WB8ClRg
 ej3J0JwQhzu0dzeocu8JYdYvrGqQ19ASf30LL9m1A8T0zKOoaoz05MjhGPHw5ZdrH7B5
 BJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gxfKXaSfciQ9SX5cYZt1VefRRc/I4yK8mJFzGnYRwGk=;
 fh=vvDBlctUNPQXbwEXY1OBm1eIPEe0du0LCFKxyhiyG5Q=;
 b=VGVyDPoGweMks/IlozAwLlyJ2LFkpyjXInYAfIekvwPSROcqq9o0AQ7JluXLnqaC8o
 UwqOlOhC21v4nBN0Eekr+++sxoDRlTRCu66+gWDySqa2llkM60UL898bg8aGtqJ2JP+c
 tyuQ2Xeov8mPgKOSDbbMjcDrb0rBaZXaHNOTHzhl4Q2f+0f1ZcNJxo9teeQqSnDubId9
 vhMOsfVNabZu3RDK+HEELRkuvRiVfuQrGKmYiRhOZ48yzeIDoZWGhG+RGx3FefmfcXco
 4cpBAqNILQiu9QCf8CzKzmXMz/A8bzobD7mFuO0CcuTfN1jRN/CJlE0rNV9dU5Zn6dlR
 SUKg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773837514; x=1774442314; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gxfKXaSfciQ9SX5cYZt1VefRRc/I4yK8mJFzGnYRwGk=;
 b=XKS0WNBSKLm8L61ZxO/2PIUPPqTz2I+Ov0lIJJNU2XSo+75zT2SlkjOKiSzlNy5Gm/
 Lc0Lss2eI66iPSRLTWYN3/7OVRthlRn8HnHRqIPloB2pzK+jXCQBXTMc8UiBRIA1UvcG
 jdVJEsC46PMQbhu56Lg7PwFOgYHmH3P7OAAI4PTzAZDKO1jJ7InCvMkqGTYqgiTcdpGk
 FiGeotnqhynTXDD+IVWFVY5lHgjAFj7LRjAdGX16g9Ps2013CCJAovk23Ro7QOpbc/5X
 RzGAmNsmWc3+a60SxTwfNKAXLf0TTvtwQeLdtLGxqm41MRqKU2PORtXBggKIkGAVzhpf
 yjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773837514; x=1774442314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gxfKXaSfciQ9SX5cYZt1VefRRc/I4yK8mJFzGnYRwGk=;
 b=k23hxm+23RFqXDI1uKzcZfnnZAVSMg2FG+rQkByl4mpPx6t6hhQegn77PByxonxTny
 k94qwVzqhz+kL5XlIeBQLTNMKToKVaO5g5BSt7bczpHgEljpIqq3+RAshXtM/IHpXDRD
 YHVbx9S7wX48BJtlSmrxElg7WM25XR9VciAhsS7VFK2xcvAC5CjPw+AFN5LMmzwpew/B
 b+3eTVTa1rjbcK+MV9+/hA91MEs4GJRVZ7oi5TZwjPJPKSRy8RcUtnfikPpTF7dLrXx6
 zICa8pk9RcPVm9YIZrD/HdaSB2K0dHQoXsS4dUMnL2yZex7ozMS0bKpJs3dBPk0mVX/V
 5PfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULkXVoGxa54XL+m0qrZn1dbaeRT8clijdd2TR6OCRDTFKokISFj1BadEKnSCRsrvot++1A8BCL39mv@nongnu.org
X-Gm-Message-State: AOJu0YzFYRTfYvFmcRf4ZHLQj8Uem20efljMyKlOfSMvDS6ILzUBBode
 D2aZ9hcfUSxmuECCUUNe1kCIZq6OF9Adz1TbPNuu4jJuoN9dK1r2QMxTBSMU3//dc/9hh7IZ2eE
 ISg0pxvI96lvUENAAPhgBGbXe86zwkeS97Ghzl+X4Vrssy98dJpKCWcRYLL8eEf+o1Ik3eYUKMf
 Ycrm2EbCS4R9P+STs4FblnK9QM1kxPrtE=
X-Gm-Gg: ATEYQzxa6RjgyL9iJl5gBPeZKyWhcUs5k2nAdopKnW4WlGeKXxpwQcjDDLBJ2tf2JMt
 r4bvUzWFs3b2jxdLVHEOsQE+k383dgAyqK3CDMjT2bNAzRK9IiRr0EhDsembpdXgWHCcL++uN8V
 /95zdugX9/uBnXFdymk1+HDzRmvdgzHo3paMLDN9G2ht0zQ0gbJWzS2iRQE7S/gTPhfcbqFXSn7
 UiVyOL8T57j26QbKDMkHUXk4oK9YJtegmKUV4yw4ThJs4Pp7sMR5ZwxW80BZa/sQ+YfXzNm
X-Received: by 2002:a05:651c:f02:b0:38a:6acb:ea92 with SMTP id
 38308e7fff4ca-38bd5850551mr12878651fa.20.1773837514226; 
 Wed, 18 Mar 2026 05:38:34 -0700 (PDT)
X-Received: by 2002:a05:651c:f02:b0:38a:6acb:ea92 with SMTP id
 38308e7fff4ca-38bd5850551mr12878481fa.20.1773837513548; Wed, 18 Mar 2026
 05:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260316123144.1758888-1-eashurov@redhat.com>
 <CAPMcbCr1XmSnHG_KUvDekU=OzKWhuD7=PjHcxB6VmCYrZCqY4Q@mail.gmail.com>
 <ablh_gd57v3vGP6m@redhat.com>
 <CAPMcbCoEL-a_TxCaJO7y7mkPNGR9us-N8mHTQRM=iGiJxTek+w@mail.gmail.com>
 <ablsEcXwDIPlMzZb@redhat.com>
 <CAPMcbCohY6Oy8xp7iwf_ftzu_LD-PzPw9_HarXBAhE0J9CFjRQ@mail.gmail.com>
In-Reply-To: <CAPMcbCohY6Oy8xp7iwf_ftzu_LD-PzPw9_HarXBAhE0J9CFjRQ@mail.gmail.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Wed, 18 Mar 2026 14:38:16 +0200
X-Gm-Features: AaiRm50kII1lmMcZO5tGN8_TMx_c1CBot8mK5gdylSnzetQHVKFfK4afcEIFjuE
Message-ID: <CAGoVJZw+H=jvZ3a2L+fqN4cOuNCJVeXx6uPX_7-_sxH26TU+Gg@mail.gmail.com>
Subject: Re: [PATCH v1] qga: add guest-get-windows-security-info command
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Elizabeth Ashurov <eashurov@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e27941064d4bba3a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000e27941064d4bba3a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 6:35=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redhat=
.com>
wrote:

>
>
>
>
> On Tue, Mar 17, 2026 at 4:58=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com>
> wrote:
>
>> On Tue, Mar 17, 2026 at 04:45:20PM +0200, Kostiantyn Kostiuk wrote:
>> > On Tue, Mar 17, 2026 at 4:15=E2=80=AFPM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com
>> >
>> > wrote:
>> >
>> > > On Tue, Mar 17, 2026 at 04:07:59PM +0200, Kostiantyn Kostiuk wrote:
>> > > > On Mon, Mar 16, 2026 at 2:32=E2=80=AFPM Elizabeth Ashurov <
>> eashurov@redhat.com>
>> > > > wrote:
>> > > >
>> > > > > Add a new Windows-only QGA command to retrieve Windows security
>> > > > > features status including VBS, Secure Boot, and TPM information
>> > > > > from the guest.
>> > > > >
>> > > > > The implementation queries Win32_DeviceGuard and Win32_Tpm via
>> > > > > WMI, and reads the SecureBoot UEFI variable through
>> > > > > GetFirmwareEnvironmentVariable().
>> > > > >
>> > > > > Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
>> > > > > ---
>> > > > >  qga/commands-win32.c | 404
>> +++++++++++++++++++++++++++++++++++++++++++
>> > > > >  qga/qapi-schema.json |  56 ++++++
>> > > > >  2 files changed, 460 insertions(+)
>> > >
>> > > snip
>> > >
>> > > > > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>> > > > > index c57bc9a02f..f54fdf942f 100644
>> > > > > --- a/qga/qapi-schema.json
>> > > > > +++ b/qga/qapi-schema.json
>> > > > > @@ -1952,3 +1952,59 @@
>> > > > >    'returns': ['GuestNetworkRoute'],
>> > > > >    'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
>> > > > >  }
>> > > > > +
>> > > > > +##
>> > > > > +# @GuestWindowsSecurityInfo:
>> > > > > +#
>> > > > > +# Windows security features status.
>> > > > > +#
>> > > > > +# @vbs-status: VirtualizationBasedSecurityStatus
>> > > > > +#
>> > > > > +# @available-security-properties: AvailableSecurityProperties
>> > > > > +#
>> > > > > +# @code-integrity-policy-enforcement-status:
>> > > > > +#     CodeIntegrityPolicyEnforcementStatus
>> > > > > +#
>> > > > > +# @required-security-properties: RequiredSecurityProperties
>> > > > > +#
>> > > > > +# @security-services-configured: SecurityServicesConfigured
>> > > > > +#
>> > > > > +# @security-services-running: SecurityServicesRunning
>> > > > > +#
>> > > > > +# @usr-cfg-code-integrity-policy-enforcement-status:
>> > > > > +#     UsermodeCodeIntegrityPolicyEnforcementStatus
>> > > > > +#
>> > > > > +# @secure-boot: Whether UEFI Secure Boot is enabled
>> > > > > +#
>> > > > > +# @tpm-present: Whether a TPM device is present
>> > > > > +#
>> > > > > +# @tpm-version: TPM specification version string (e.g. "2.0")
>> > > > > +#
>> > > > > +# Since: 10.3
>> > > > > +##
>> > > > > +{ 'struct': 'GuestWindowsSecurityInfo',
>> > > > > +  'data': {
>> > > > > +      'vbs-status': 'int',
>> > > > > +      '*available-security-properties': ['int'],
>> > > > > +      '*code-integrity-policy-enforcement-status': 'int',
>> > > > > +      '*required-security-properties': ['int'],
>> > > > > +      '*security-services-configured': ['int'],
>> > > > > +      '*security-services-running': ['int'],
>> > > > > +      '*usr-cfg-code-integrity-policy-enforcement-status': 'int=
',
>> > > > > +      'secure-boot': 'bool',
>> > > > > +      'tpm-present': 'bool',
>> > > > > +      '*tpm-version': 'str' },
>> > > > > +  'if': 'CONFIG_WIN32' }
>> > > > >
>> > > > >
>> > > > Let's make this more generic
>> > > > command guest-get-security-info
>> > > > use 'union' to describe OS specific option like VBS
>> > > > { 'tmp_present': false, 'secure_boot': true, 'os': { 'type':
>> 'windows',
>> > > > 'vbs': false, .... } }
>> > > >
>> > > > make tmp_present, secure_boot, vbs_status optiononal
>> > > > missing =3D unknown - as we can have it unimplemented for some
>> POSIX/BSD
>> > > OSes
>> > > >
>> > > > vbs_status is Win10+ only feature, so it can be unknown for Win8
>> > >
>> > > I wonder if a new command is justifiable / needed.
>> > >
>> > > Should we consider returning more info with 'guest-get-osinfo' ? It
>> > > is slightly different from the info returned there currently, but
>> > > at the same time reasonably in scope in the sense that it is
>> > > essentially reporting a set of OS "feature flags". They happen to
>> > > be security related in this case, but we could have other feature
>> > > flags we want to report too in future.
>> > >
>> >
>> > guest-get-security-info can fail due to WMI issue. If we merge this in=
to
>> > guest-get-osinfo,
>> > it means guest-get-osinfo will fail just because of a Windows componen=
t
>> > error. Sounds bad.
>>
>> In what scenarios would WMI fail, and should we treat that as non-fatal
>> regardless ? ie indicate that the information is unavailable - that
>> already appears to be done for the TPM feature, but not the other
>> security features.
>>
>
>
How the managment layer will distingiush between the failure and old guest
agent that cannot return any data?

Best regards,
Yan.


> Simple WMI fail - disable WMI service
> From my experience - WMI DB was broken after 3rd-party software
> installation / after Windows Update
>
> >should we treat that as non-fatal regardless ?
>
> I am open to discussion.
>
>
>> With regards,
>> Daniel
>> --
>> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :=
|
>> |: https://libvirt.org          ~~          https://entangle-photo.org :=
|
>> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :=
|
>>
>>

--000000000000e27941064d4bba3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 17,=
 2026 at 6:35=E2=80=AFPM Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@=
redhat.com">kkostiuk@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><div><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><br></div></div></div>=
<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Tue, Mar 17, 2026 at 4:58=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a =
href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-c=
olor:rgb(204,204,204);padding-left:1ex">On Tue, Mar 17, 2026 at 04:45:20PM =
+0200, Kostiantyn Kostiuk wrote:<br>
&gt; On Tue, Mar 17, 2026 at 4:15=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a=
 href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com<=
/a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Tue, Mar 17, 2026 at 04:07:59PM +0200, Kostiantyn Kostiuk wrot=
e:<br>
&gt; &gt; &gt; On Mon, Mar 16, 2026 at 2:32=E2=80=AFPM Elizabeth Ashurov &l=
t;<a href=3D"mailto:eashurov@redhat.com" target=3D"_blank">eashurov@redhat.=
com</a>&gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Add a new Windows-only QGA command to retrieve Windows =
security<br>
&gt; &gt; &gt; &gt; features status including VBS, Secure Boot, and TPM inf=
ormation<br>
&gt; &gt; &gt; &gt; from the guest.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; The implementation queries Win32_DeviceGuard and Win32_=
Tpm via<br>
&gt; &gt; &gt; &gt; WMI, and reads the SecureBoot UEFI variable through<br>
&gt; &gt; &gt; &gt; GetFirmwareEnvironmentVariable().<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Elizabeth Ashurov &lt;<a href=3D"mailto:=
eashurov@redhat.com" target=3D"_blank">eashurov@redhat.com</a>&gt;<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt;=C2=A0 qga/commands-win32.c | 404 ++++++++++++++++++++++=
+++++++++++++++++++++<br>
&gt; &gt; &gt; &gt;=C2=A0 qga/qapi-schema.json |=C2=A0 56 ++++++<br>
&gt; &gt; &gt; &gt;=C2=A0 2 files changed, 460 insertions(+)<br>
&gt; &gt;<br>
&gt; &gt; snip<br>
&gt; &gt;<br>
&gt; &gt; &gt; &gt; diff --git a/qga/qapi-schema.json b/qga/qapi-schema.jso=
n<br>
&gt; &gt; &gt; &gt; index c57bc9a02f..f54fdf942f 100644<br>
&gt; &gt; &gt; &gt; --- a/qga/qapi-schema.json<br>
&gt; &gt; &gt; &gt; +++ b/qga/qapi-schema.json<br>
&gt; &gt; &gt; &gt; @@ -1952,3 +1952,59 @@<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 &#39;returns&#39;: [&#39;GuestNetworkRoute=
&#39;],<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFI=
G_LINUX&#39;, &#39;CONFIG_WIN32&#39;] }<br>
&gt; &gt; &gt; &gt;=C2=A0 }<br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +##<br>
&gt; &gt; &gt; &gt; +# @GuestWindowsSecurityInfo:<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# Windows security features status.<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @vbs-status: VirtualizationBasedSecurityStatus<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @available-security-properties: AvailableSecurityPro=
perties<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @code-integrity-policy-enforcement-status:<br>
&gt; &gt; &gt; &gt; +#=C2=A0 =C2=A0 =C2=A0CodeIntegrityPolicyEnforcementSta=
tus<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @required-security-properties: RequiredSecurityPrope=
rties<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @security-services-configured: SecurityServicesConfi=
gured<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @security-services-running: SecurityServicesRunning<=
br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @usr-cfg-code-integrity-policy-enforcement-status:<b=
r>
&gt; &gt; &gt; &gt; +#=C2=A0 =C2=A0 =C2=A0UsermodeCodeIntegrityPolicyEnforc=
ementStatus<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @secure-boot: Whether UEFI Secure Boot is enabled<br=
>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @tpm-present: Whether a TPM device is present<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# @tpm-version: TPM specification version string (e.g.=
 &quot;2.0&quot;)<br>
&gt; &gt; &gt; &gt; +#<br>
&gt; &gt; &gt; &gt; +# Since: 10.3<br>
&gt; &gt; &gt; &gt; +##<br>
&gt; &gt; &gt; &gt; +{ &#39;struct&#39;: &#39;GuestWindowsSecurityInfo&#39;=
,<br>
&gt; &gt; &gt; &gt; +=C2=A0 &#39;data&#39;: {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;vbs-status&#39;: &#39;int&#3=
9;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*available-security-properti=
es&#39;: [&#39;int&#39;],<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*code-integrity-policy-enfor=
cement-status&#39;: &#39;int&#39;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*required-security-propertie=
s&#39;: [&#39;int&#39;],<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*security-services-configure=
d&#39;: [&#39;int&#39;],<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*security-services-running&#=
39;: [&#39;int&#39;],<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*usr-cfg-code-integrity-poli=
cy-enforcement-status&#39;: &#39;int&#39;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;secure-boot&#39;: &#39;bool&=
#39;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;tpm-present&#39;: &#39;bool&=
#39;,<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*tpm-version&#39;: &#39;str&=
#39; },<br>
&gt; &gt; &gt; &gt; +=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; Let&#39;s make this more generic<br>
&gt; &gt; &gt; command guest-get-security-info<br>
&gt; &gt; &gt; use &#39;union&#39; to describe OS specific option like VBS<=
br>
&gt; &gt; &gt; { &#39;tmp_present&#39;: false, &#39;secure_boot&#39;: true,=
 &#39;os&#39;: { &#39;type&#39;: &#39;windows&#39;,<br>
&gt; &gt; &gt; &#39;vbs&#39;: false, .... } }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; make tmp_present, secure_boot, vbs_status optiononal<br>
&gt; &gt; &gt; missing =3D unknown - as we can have it unimplemented for so=
me POSIX/BSD<br>
&gt; &gt; OSes<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; vbs_status is Win10+ only feature, so it can be unknown for =
Win8<br>
&gt; &gt;<br>
&gt; &gt; I wonder if a new command is justifiable / needed.<br>
&gt; &gt;<br>
&gt; &gt; Should we consider returning more info with &#39;guest-get-osinfo=
&#39; ? It<br>
&gt; &gt; is slightly different from the info returned there currently, but=
<br>
&gt; &gt; at the same time reasonably in scope in the sense that it is<br>
&gt; &gt; essentially reporting a set of OS &quot;feature flags&quot;. They=
 happen to<br>
&gt; &gt; be security related in this case, but we could have other feature=
<br>
&gt; &gt; flags we want to report too in future.<br>
&gt; &gt;<br>
&gt; <br>
&gt; guest-get-security-info can fail due to WMI issue. If we merge this in=
to<br>
&gt; guest-get-osinfo,<br>
&gt; it means guest-get-osinfo will fail just because of a Windows componen=
t<br>
&gt; error. Sounds bad.<br>
<br>
In what scenarios would WMI fail, and should we treat that as non-fatal<br>
regardless ? ie indicate that the information is unavailable - that<br>
already appears to be done for the TPM feature, but not the other<br>
security features.<br></blockquote><div><br></div></div></div></blockquote>=
<div><br></div><div>How the managment layer will distingiush between the fa=
ilure and old guest agent that cannot return any data?</div><div><br></div>=
<div>Best regards,</div><div>Yan.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
<div dir=3D"ltr"><div class=3D"gmail_quote"><div></div><div>Simple WMI fail=
 - disable WMI service<br></div><div>From my experience - WMI DB was broken=
 after 3rd-party software installation / after Windows Update<br><br>&gt;sh=
ould we treat that as non-fatal=C2=A0regardless ?</div><div><br></div><div>=
I am open to discussion.=C2=A0</div><div><br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-le=
ft-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer" target=3D=
"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"noreferrer"=
 target=3D"_blank">https://entangle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer" target=3D"_=
blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =C2=A0 <a hre=
f=3D"https://fstop138.berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div></div>
</blockquote></div></div>

--000000000000e27941064d4bba3a--


