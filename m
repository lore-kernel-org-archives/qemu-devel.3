Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63B0FF60CF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7TRV-0000I8-SM; Tue, 31 Mar 2026 03:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w7TRT-0000FT-DM
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 03:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w7TRR-0004hS-Tm
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 03:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774941792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oGqvxFrCHQhPRVvg2/nTeTzkGPG1yQGLoMtmeeb+uww=;
 b=cQ0nMRMpfqf0XeP6jsc7iWavLd+fAjaIm6rEP1PuT9rG5AWfloQa8mRB3IPBzWEGuJURe5
 OkTLYYYHDoPjNeU6WTeTP9hd1UheFI4HBvHFZ+VVd4VWIOeeQjlyEmzKzYdbczg67h1Kt6
 Zq91fzd7cdAawUKEXm5USsoNlO5vhSI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-1MOxj0Y3MXqKWR9iooHB0A-1; Tue, 31 Mar 2026 03:23:10 -0400
X-MC-Unique: 1MOxj0Y3MXqKWR9iooHB0A-1
X-Mimecast-MFC-AGG-ID: 1MOxj0Y3MXqKWR9iooHB0A_1774941790
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89c4ec516e5so34078426d6.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 00:23:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774941790; cv=none;
 d=google.com; s=arc-20240605;
 b=FIOz5zDDdGHIM+uUip60bm3VYiiyPGbZKHYLORJTjZcHZ/mhqg6sDPY2Mx7wZ0cvqG
 +UmAUpOnqckIQ+Qdf0X+C4ri1MvlQ8mWTlvm/NJwYHYIWnVaf+w4SV9jdqxj41dDOXhl
 tmZ1NpYugT2exE7Joe3tt9T2h3AohVO8DCZ7Dm79Kj/85UMsmGA0drO5/fQum97Ckfxe
 aZ+8C9lV3QyXWiYLntsna0DCCLTgcYWynPTQhFET4LTd/5QgvO1d11mGCyLLHIH7YNw3
 C4Sh4HDmw4Yp171C0VF3/J2byPtu6SDKGh+6ejh9XwkRCtJe7Vfp1ZUvt7i/i48mj2u5
 JDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oGqvxFrCHQhPRVvg2/nTeTzkGPG1yQGLoMtmeeb+uww=;
 fh=YzVzZac5nUsTO3j4AGg/t3YXDhF/6BMOK+V8bJUtQIE=;
 b=X5t93PelfOSPVQkEWbByOOEtgdKddJwZFbYWMbkHujciQ19ZOwaFZelWkoI32p/57x
 0YKC6N/rnlEFTjXtCGCus5RO0c4nrMobDA6wIcd5xccyGwtEarUIg18n2CERtpeNVmsq
 oEA3X88GXbDTfoeXVFgHSfG6oky4uX6r6a1iCnLxn2DBivOlYy2GDHemnAEfV+OzdlKR
 k15MEgSWaDDpcfRlpB28HxTTuNeAsl7g5KBMJpkVZDzpxxYXQrLZh/u95EzVCEefPwp+
 yrPXFbK8bMRVhCYhZISdOg6yFp50XEMURHRmd09P5Al3eVsrpOcLGiDjIHAYPm77SY/H
 Qcbw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774941790; x=1775546590; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oGqvxFrCHQhPRVvg2/nTeTzkGPG1yQGLoMtmeeb+uww=;
 b=gbnuYepp/SncNzMACBne2tjpivLCwSpRlOiFeSQ+16xfyEuY559p3g00bCjxvvMehY
 4qRM/Kz+qa8kQ1uHCh9MWOSa1AjWKTpAgMHtUn8oF/p3tV1EDMWcpkxolw4BcsBOjiyb
 UOiURdxQYnAtsZ9EwY2IQce1V9ByUxXJx25e1Doh7De7gZ/4kRyUwRLlnPWsl0uW9Q/O
 yY8LJ3YwMN6DmT/7L65KptmVXaLNbGxiP8KcqRkAHYGq1Cyy3TtN5v0y8MPPnvwscLRY
 3/S/W1twzvag1jGX7+AJU9ASPCORVbdabRpIS1HmKIO5EQWOgMYBQm4YlTOG0guKjWch
 ivVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774941790; x=1775546590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oGqvxFrCHQhPRVvg2/nTeTzkGPG1yQGLoMtmeeb+uww=;
 b=UUtK7401VHWhmRqDF76VzgwkE5+7Mo0QRrVfld+IP6iurE0mWKlnxyvw37AuaDCiyT
 58h0u6aawOl4K0ui4aEvPNEBxvucL5HKVuOTJjoh7e2Er5FonvxnUwP2dUdyMIQOEGLP
 ATcjpRnq+NZaXmOCi4cXR7y4dA1M8XevnHFvPJe9ezSxdN4Zuq2QMM/muldv8BXE22YS
 2ELQyX3ITlK0VBFfluyvvZeqWWfm09wNrOramHxCA+D60pF+WcRvJImXA4ILjObr+oXt
 l+p/sfS9812hJzJTuOik3tEvTIaSsPisPsP1o1dPVnVP+/4elnrt4LzbveaSbDx8d3kB
 ryNQ==
X-Gm-Message-State: AOJu0YydgiXuzOoZpcpoCxKPu9L7RBSqn5+PfmXYpy0uFUQRs8lNncRy
 JXR4ckIO1Yj8OFF1nmL3kIMYzyOca8+ocbDPhR2mdEoFmHjl22GbUJ86dpy6rseJmnd1lNqltzY
 2WX/AaYaVsbkjUWTZkFFKRK5TaEB2s+aGiwcyP/KjcnXV/78mjSn35HudsBgEt76/OVOM/k7eQ5
 FcB7+WDCMbibA1iGEnAnx4lOFRRikdE6A=
X-Gm-Gg: ATEYQzwq5E+K+am5sk5Z55X9FP05zV9OvYKX0ZjCntw/k6hCnKYkuU9EM5CHDEnm2h7
 cx4v3KgvrwRHZ0rjazvsqh20pHZsGTLCots8dgp7A4NicQXxA9EzLlE7w9G4RLS8kALj/hjj9Xy
 9j+z2BpE4Q0GDRI35nZnRtlRRuxpOZkVnY9QsZnUu9aRzb/ir3ub6bnz4ILSXiaFH7FHxbNL4c7
 wA57yfA
X-Received: by 2002:a05:6214:2689:b0:89c:e7b9:56d4 with SMTP id
 6a1803df08f44-89ce8d03ed5mr219383116d6.9.1774941790313; 
 Tue, 31 Mar 2026 00:23:10 -0700 (PDT)
X-Received: by 2002:a05:6214:2689:b0:89c:e7b9:56d4 with SMTP id
 6a1803df08f44-89ce8d03ed5mr219382916d6.9.1774941789801; Tue, 31 Mar 2026
 00:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260330113906.168002-1-kkostiuk@redhat.com>
 <9d9706b5-372c-4627-b361-ef53a8417b73@redhat.com>
In-Reply-To: <9d9706b5-372c-4627-b361-ef53a8417b73@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 31 Mar 2026 10:22:59 +0300
X-Gm-Features: AQROBzBnDNLb4ZNpJKazxN4clzGreyUWq89VtTanUQ7Uf1nB5sfdm6QYwwFXgQ8
Message-ID: <CAPMcbCo2QmnRxj2U3N9izauoU3v3QpQO81MZLu9P-75a7+LoSA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Misc QGA changes to allow building with Windows Clang
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Yan Vugenfirer <yvugenfi@redhat.com>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000e0e2c1064e4cd61b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000e0e2c1064e4cd61b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 10:01=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:

> On 3/30/26 13:38, Kostiantyn Kostiuk wrote:
> > Kostiantyn Kostiuk (7):
> >    qga/win: Use swprintf instead of snwprintf
> >    qga/meson: Remove unused lib stdc++
> >    qga/meson: Use windows.compile_resources instead of custom_target
> >    qga/meson: Allow to use MSVC message compiler 'mc'
> >    qga/vss: Use MAX_PATH instead of PATH_MAX
> >    qga/vss: Remove unused undefs
> >    qga/vss: Drop unused define uuid(x)
>
> What is missing after these?
>
>
If I am not mistaken, the next patches

- Remove getopt from qga
- support clang-cl and lld-link with 128bit
- use __try1 only if it is defined
- add compatibility header with missing types/includes


Thanks,
>
> Paolo
>
>

--000000000000e0e2c1064e4cd61b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 31,=
 2026 at 10:01=E2=80=AFAM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redh=
at.com">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">On 3/30/26 13:38, Kostiantyn Kostiuk wrote:<br>
&gt; Kostiantyn Kostiuk (7):<br>
&gt;=C2=A0 =C2=A0 qga/win: Use swprintf instead of snwprintf<br>
&gt;=C2=A0 =C2=A0 qga/meson: Remove unused lib stdc++<br>
&gt;=C2=A0 =C2=A0 qga/meson: Use windows.compile_resources instead of custo=
m_target<br>
&gt;=C2=A0 =C2=A0 qga/meson: Allow to use MSVC message compiler &#39;mc&#39=
;<br>
&gt;=C2=A0 =C2=A0 qga/vss: Use MAX_PATH instead of PATH_MAX<br>
&gt;=C2=A0 =C2=A0 qga/vss: Remove unused undefs<br>
&gt;=C2=A0 =C2=A0 qga/vss: Drop unused define uuid(x)<br>
<br>
What is missing after these?<br>
<br></blockquote><div><br></div><div>If I am not mistaken, the next patches=
</div><div><br></div><div>- Remove getopt from qga<br></div><div>- support =
clang-cl and=C2=A0lld-link with 128bit<br>- use __try1 only if it is define=
d<br></div><div>- add compatibility header with missing types/includes</div=
><div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
Thanks,<br>
<br>
Paolo<br>
<br>
</blockquote></div></div>

--000000000000e0e2c1064e4cd61b--


