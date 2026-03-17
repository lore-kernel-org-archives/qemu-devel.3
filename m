Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5C7FD877F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2VgF-0000V1-QY; Tue, 17 Mar 2026 10:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w2Vfv-0000U6-FN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w2Vfr-0001sQ-F1
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773758734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m5QxvNc0X7PIdGuF0nPbR+urwGLbkHnejshNiU4jKc4=;
 b=Shvn/AZJfJZWmt+HpsyXn2Aky/2oKhIIYGF/1skduq7+brlR1+z5NGBrez20DcbZKsJvXB
 y5uxYY0RKMWCOEjRegcPJ6906Dd+ZkHgmSQCz4h6rSGx1vEZV3cG8elkWfKZsCK20NOWjo
 FT9Ua+uwQVzArhHS8ct89cmNHLN8BDA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-nTW57w3BOoOrdkuQT_fRdw-1; Tue, 17 Mar 2026 10:45:32 -0400
X-MC-Unique: nTW57w3BOoOrdkuQT_fRdw-1
X-Mimecast-MFC-AGG-ID: nTW57w3BOoOrdkuQT_fRdw_1773758732
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cb0595def4so658529285a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 07:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773758732; cv=none;
 d=google.com; s=arc-20240605;
 b=a1PQujKTHTrtETXWTSLozBGS3fEUpH7V8fObWyElHPZU3GhJYnjDJl8H0Vun+orf3u
 59LjEKsMVftJwkcwAmeKrH8t2iPQkbhuUCkehKVGqDP65TLunVhEb7vpeDweGTEXHOhy
 mwHV2MjIZ4m/Y2IYawSA8smY8JtcVN+emuAn2O7xPGgLNiYlQhnJcOR+N/nNnvnvEb3a
 awBLNewDsEKT7aEK5yoXRCHQzrgPJxvAzZpW7ZLPBz3XdswqNYM17FlRPtXNAnqKpUib
 GCVEvj9bXXvtG/qoJj4fGkUmasrPfE0OQBpyNudZHhVw8bB4pp7hSOM8HidRePxrO3Ux
 L/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=m5QxvNc0X7PIdGuF0nPbR+urwGLbkHnejshNiU4jKc4=;
 fh=4ybDjlvWUDWK6AkB9qSA77YtvCYTERJYCwCqGuxGtmw=;
 b=gDhmMnISKkS/gHCX12rtHIKYGEtFcDtHX4xXerriUEQQ40mcfy4Cl0OGRV1pTkal4b
 12wJqfMu63m1C/veTa6pmXbafcP7D60cjWqhY1FeTaNE1sp0971cSO1Uk3g+XK3m4/Sj
 0qgDhckWWrr4zwS0ay/kSTxSZcr4zYQU13epV1p6af7qAJjfCuXUgvQ8WkoiaiAWcQ19
 9whIEWdaD3yyJ8fP6pOw/GpAvvDVvwxOmnSGlXXuZKe4rf4h8Y3vJX/YbGEzm0n/Y1oz
 07jlKpgV1zdjgU1znmHnFSzXEf1qG1Z/ys9nGJvcYK8uJAUrXucBQqYmGrRFx5dn+1b5
 QRnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773758732; x=1774363532; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m5QxvNc0X7PIdGuF0nPbR+urwGLbkHnejshNiU4jKc4=;
 b=e4DuoSctTseMQwIrHheN3tWZmmgO7Kw9dRDHag0ma6BPnQv4//qxq+0picJ4LZdJMf
 sBLw78K3f/epn9Q05VFwzlmUSEheuzOuMmIiqqzVji0+1dVRCNKxq9Wog9Xnnhlk+tUm
 Efoc4HzO6OpILeSLHAqAObthFgX0kU3a01FC9bb8JlAntxDp2vMSS7jk04SfEi++T1MM
 8q8jUgC7P7HRPpTwYSLMZqoPFqI+Y1dIE7hgHmEqehUf3ytk1azl+OgLlPhpLlwdLzUa
 s6ky5JS/Bqf8hpUJHp9CiRRAQ6/B+YmSLvXP/wrJHXQhHHAyGPOwC6pNSLvuR6Qb21EC
 huGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773758732; x=1774363532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5QxvNc0X7PIdGuF0nPbR+urwGLbkHnejshNiU4jKc4=;
 b=ngy5rpuRx6EhEFXIWs6aA4iP1c8kpPg+OeS6uu+VxClWMJLh7mzdCPEHGcNrChyvJI
 VKmZrHIJmNSl2yFx2NpFTdYZsUhUxmMPAAheF/fbpfT/AHLCB5+zJ2oOt2IaKfip6D+h
 726b17IF4o1Cyp/EZ5hzy+rjyRer8rXZynR9jZNR379kQjSWyEeWvvH36DSUMTvWwZoX
 gYCXcwneAuaIrQkEOtW1e4jYyydf6FmYYCeScPomyNV317sL8twK63Sh+zGmLn5LhxQ/
 PDAljM6mEgriGSLDe1hVFgo7KQGiNgwzI9ejID23ABkeR7Gv4B7126so5ccuVaZC04dO
 Afng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqJu35QYQEWDnGEBpRap28YyjXcuZxjoDNxdPd17y8uyI0r+Z39QzzRA6kZL0Sgiv5CyJCEhrgD6GQ@nongnu.org
X-Gm-Message-State: AOJu0YxYIkKYcXSb3vfg/8g9IYMRD6+anmVos7EckxbGd5PoVwAudrwp
 RJC7+KXWL3QjbX0tjk0qtfGTP9CifHTIj/p+fTMSZdnUugweP1hyXt9eyp7CVOqgehrUT3I7w3W
 EaWBBGnnSFjS6Yy6C+SqY8bj1BBNDkZN8zc3I9YChIlblEV0NILqKqG5HqgpJJVr90G2VeYpL2Q
 rLD1/iFstP+heifUcaQB9VCpXfgCnV6vM=
X-Gm-Gg: ATEYQzwhxYz/sGT0ACtE3p/3H9AQ0gBQDlpBXklf0rRN9sxxuV++6ghQJb8GqMCCYVb
 WnnVDQY3fvfN9kL4OlkS7+d+19rHnwMHc/ue71bLZaDhg7LXijkDqnV+OikunTICmxz3Qv9bNu9
 I6uyS8Bt/lwqjX84p3Dg0PWOvixHO8rlKPqjBL4U91d8sILI1kgkrH1WVUo3iPHEp68LQyAqIX7
 mlhIToe
X-Received: by 2002:a05:620a:4089:b0:8cd:8ce4:c0ad with SMTP id
 af79cd13be357-8cde14e9b7cmr429504785a.22.1773758731859; 
 Tue, 17 Mar 2026 07:45:31 -0700 (PDT)
X-Received: by 2002:a05:620a:4089:b0:8cd:8ce4:c0ad with SMTP id
 af79cd13be357-8cde14e9b7cmr429499385a.22.1773758731294; Tue, 17 Mar 2026
 07:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260316123144.1758888-1-eashurov@redhat.com>
 <CAPMcbCr1XmSnHG_KUvDekU=OzKWhuD7=PjHcxB6VmCYrZCqY4Q@mail.gmail.com>
 <ablh_gd57v3vGP6m@redhat.com>
In-Reply-To: <ablh_gd57v3vGP6m@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 17 Mar 2026 16:45:20 +0200
X-Gm-Features: AaiRm52fTb9gs0zB6adrqmfe9baNwNBLKnqLNCuZdKo3GLcqTLRvnZmsJqt2lXc
Message-ID: <CAPMcbCoEL-a_TxCaJO7y7mkPNGR9us-N8mHTQRM=iGiJxTek+w@mail.gmail.com>
Subject: Re: [PATCH v1] qga: add guest-get-windows-security-info command
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Elizabeth Ashurov <eashurov@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000018b2be064d39635b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
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

--00000000000018b2be064d39635b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 4:15=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Tue, Mar 17, 2026 at 04:07:59PM +0200, Kostiantyn Kostiuk wrote:
> > On Mon, Mar 16, 2026 at 2:32=E2=80=AFPM Elizabeth Ashurov <eashurov@red=
hat.com>
> > wrote:
> >
> > > Add a new Windows-only QGA command to retrieve Windows security
> > > features status including VBS, Secure Boot, and TPM information
> > > from the guest.
> > >
> > > The implementation queries Win32_DeviceGuard and Win32_Tpm via
> > > WMI, and reads the SecureBoot UEFI variable through
> > > GetFirmwareEnvironmentVariable().
> > >
> > > Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
> > > ---
> > >  qga/commands-win32.c | 404 +++++++++++++++++++++++++++++++++++++++++=
++
> > >  qga/qapi-schema.json |  56 ++++++
> > >  2 files changed, 460 insertions(+)
>
> snip
>
> > > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > > index c57bc9a02f..f54fdf942f 100644
> > > --- a/qga/qapi-schema.json
> > > +++ b/qga/qapi-schema.json
> > > @@ -1952,3 +1952,59 @@
> > >    'returns': ['GuestNetworkRoute'],
> > >    'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
> > >  }
> > > +
> > > +##
> > > +# @GuestWindowsSecurityInfo:
> > > +#
> > > +# Windows security features status.
> > > +#
> > > +# @vbs-status: VirtualizationBasedSecurityStatus
> > > +#
> > > +# @available-security-properties: AvailableSecurityProperties
> > > +#
> > > +# @code-integrity-policy-enforcement-status:
> > > +#     CodeIntegrityPolicyEnforcementStatus
> > > +#
> > > +# @required-security-properties: RequiredSecurityProperties
> > > +#
> > > +# @security-services-configured: SecurityServicesConfigured
> > > +#
> > > +# @security-services-running: SecurityServicesRunning
> > > +#
> > > +# @usr-cfg-code-integrity-policy-enforcement-status:
> > > +#     UsermodeCodeIntegrityPolicyEnforcementStatus
> > > +#
> > > +# @secure-boot: Whether UEFI Secure Boot is enabled
> > > +#
> > > +# @tpm-present: Whether a TPM device is present
> > > +#
> > > +# @tpm-version: TPM specification version string (e.g. "2.0")
> > > +#
> > > +# Since: 10.3
> > > +##
> > > +{ 'struct': 'GuestWindowsSecurityInfo',
> > > +  'data': {
> > > +      'vbs-status': 'int',
> > > +      '*available-security-properties': ['int'],
> > > +      '*code-integrity-policy-enforcement-status': 'int',
> > > +      '*required-security-properties': ['int'],
> > > +      '*security-services-configured': ['int'],
> > > +      '*security-services-running': ['int'],
> > > +      '*usr-cfg-code-integrity-policy-enforcement-status': 'int',
> > > +      'secure-boot': 'bool',
> > > +      'tpm-present': 'bool',
> > > +      '*tpm-version': 'str' },
> > > +  'if': 'CONFIG_WIN32' }
> > >
> > >
> > Let's make this more generic
> > command guest-get-security-info
> > use 'union' to describe OS specific option like VBS
> > { 'tmp_present': false, 'secure_boot': true, 'os': { 'type': 'windows',
> > 'vbs': false, .... } }
> >
> > make tmp_present, secure_boot, vbs_status optiononal
> > missing =3D unknown - as we can have it unimplemented for some POSIX/BS=
D
> OSes
> >
> > vbs_status is Win10+ only feature, so it can be unknown for Win8
>
> I wonder if a new command is justifiable / needed.
>
> Should we consider returning more info with 'guest-get-osinfo' ? It
> is slightly different from the info returned there currently, but
> at the same time reasonably in scope in the sense that it is
> essentially reporting a set of OS "feature flags". They happen to
> be security related in this case, but we could have other feature
> flags we want to report too in future.
>

guest-get-security-info can fail due to WMI issue. If we merge this into
guest-get-osinfo,
it means guest-get-osinfo will fail just because of a Windows component
error. Sounds bad.
Currently, guest-get-osinfo uses a very stable API.

Best Regards,
Kostiantyn Kostiuk.


>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--00000000000018b2be064d39635b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 17,=
 2026 at 4:15=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berr=
ange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Tue, Mar 17, 2026 at 04:07:59PM +020=
0, Kostiantyn Kostiuk wrote:<br>
&gt; On Mon, Mar 16, 2026 at 2:32=E2=80=AFPM Elizabeth Ashurov &lt;<a href=
=3D"mailto:eashurov@redhat.com" target=3D"_blank">eashurov@redhat.com</a>&g=
t;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; Add a new Windows-only QGA command to retrieve Windows security<b=
r>
&gt; &gt; features status including VBS, Secure Boot, and TPM information<b=
r>
&gt; &gt; from the guest.<br>
&gt; &gt;<br>
&gt; &gt; The implementation queries Win32_DeviceGuard and Win32_Tpm via<br=
>
&gt; &gt; WMI, and reads the SecureBoot UEFI variable through<br>
&gt; &gt; GetFirmwareEnvironmentVariable().<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@r=
edhat.com" target=3D"_blank">eashurov@redhat.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 qga/commands-win32.c | 404 ++++++++++++++++++++++++++++++++=
+++++++++++<br>
&gt; &gt;=C2=A0 qga/qapi-schema.json |=C2=A0 56 ++++++<br>
&gt; &gt;=C2=A0 2 files changed, 460 insertions(+)<br>
<br>
snip<br>
<br>
&gt; &gt; diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
&gt; &gt; index c57bc9a02f..f54fdf942f 100644<br>
&gt; &gt; --- a/qga/qapi-schema.json<br>
&gt; &gt; +++ b/qga/qapi-schema.json<br>
&gt; &gt; @@ -1952,3 +1952,59 @@<br>
&gt; &gt;=C2=A0 =C2=A0 &#39;returns&#39;: [&#39;GuestNetworkRoute&#39;],<br=
>
&gt; &gt;=C2=A0 =C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_LINUX&#3=
9;, &#39;CONFIG_WIN32&#39;] }<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +##<br>
&gt; &gt; +# @GuestWindowsSecurityInfo:<br>
&gt; &gt; +#<br>
&gt; &gt; +# Windows security features status.<br>
&gt; &gt; +#<br>
&gt; &gt; +# @vbs-status: VirtualizationBasedSecurityStatus<br>
&gt; &gt; +#<br>
&gt; &gt; +# @available-security-properties: AvailableSecurityProperties<br=
>
&gt; &gt; +#<br>
&gt; &gt; +# @code-integrity-policy-enforcement-status:<br>
&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0CodeIntegrityPolicyEnforcementStatus<br>
&gt; &gt; +#<br>
&gt; &gt; +# @required-security-properties: RequiredSecurityProperties<br>
&gt; &gt; +#<br>
&gt; &gt; +# @security-services-configured: SecurityServicesConfigured<br>
&gt; &gt; +#<br>
&gt; &gt; +# @security-services-running: SecurityServicesRunning<br>
&gt; &gt; +#<br>
&gt; &gt; +# @usr-cfg-code-integrity-policy-enforcement-status:<br>
&gt; &gt; +#=C2=A0 =C2=A0 =C2=A0UsermodeCodeIntegrityPolicyEnforcementStatu=
s<br>
&gt; &gt; +#<br>
&gt; &gt; +# @secure-boot: Whether UEFI Secure Boot is enabled<br>
&gt; &gt; +#<br>
&gt; &gt; +# @tpm-present: Whether a TPM device is present<br>
&gt; &gt; +#<br>
&gt; &gt; +# @tpm-version: TPM specification version string (e.g. &quot;2.0=
&quot;)<br>
&gt; &gt; +#<br>
&gt; &gt; +# Since: 10.3<br>
&gt; &gt; +##<br>
&gt; &gt; +{ &#39;struct&#39;: &#39;GuestWindowsSecurityInfo&#39;,<br>
&gt; &gt; +=C2=A0 &#39;data&#39;: {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;vbs-status&#39;: &#39;int&#39;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*available-security-properties&#39;: [=
&#39;int&#39;],<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*code-integrity-policy-enforcement-sta=
tus&#39;: &#39;int&#39;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*required-security-properties&#39;: [&=
#39;int&#39;],<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*security-services-configured&#39;: [&=
#39;int&#39;],<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*security-services-running&#39;: [&#39=
;int&#39;],<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*usr-cfg-code-integrity-policy-enforce=
ment-status&#39;: &#39;int&#39;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;secure-boot&#39;: &#39;bool&#39;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;tpm-present&#39;: &#39;bool&#39;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*tpm-version&#39;: &#39;str&#39; },<br=
>
&gt; &gt; +=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; Let&#39;s make this more generic<br>
&gt; command guest-get-security-info<br>
&gt; use &#39;union&#39; to describe OS specific option like VBS<br>
&gt; { &#39;tmp_present&#39;: false, &#39;secure_boot&#39;: true, &#39;os&#=
39;: { &#39;type&#39;: &#39;windows&#39;,<br>
&gt; &#39;vbs&#39;: false, .... } }<br>
&gt; <br>
&gt; make tmp_present, secure_boot, vbs_status optiononal<br>
&gt; missing =3D unknown - as we can have it unimplemented for some POSIX/B=
SD OSes<br>
&gt; <br>
&gt; vbs_status is Win10+ only feature, so it can be unknown for Win8<br>
<br>
I wonder if a new command is justifiable / needed.<br>
<br>
Should we consider returning more info with &#39;guest-get-osinfo&#39; ? It=
<br>
is slightly different from the info returned there currently, but<br>
at the same time reasonably in scope in the sense that it is<br>
essentially reporting a set of OS &quot;feature flags&quot;. They happen to=
<br>
be security related in this case, but we could have other feature<br>
flags we want to report too in future.<br></blockquote><div><br></div><div>=
guest-get-security-info can fail due to WMI issue. If we merge this into gu=
est-get-osinfo,<br></div><div>it means=C2=A0guest-get-osinfo will fail just=
 because=C2=A0of a Windows component error. Sounds bad.<br></div><div>Curre=
ntly,=C2=A0guest-get-osinfo uses=C2=A0a very stable API.=C2=A0</div><div><d=
iv><br clear=3D"all"></div><div><div dir=3D"ltr" class=3D"gmail_signature">=
<div dir=3D"ltr"><div>Best Regards,</div><div>Kostiantyn Kostiuk.</div></di=
v></div></div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
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

--00000000000018b2be064d39635b--


