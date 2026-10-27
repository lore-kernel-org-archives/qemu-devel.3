Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA93606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L4fj5jGd;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=T6EMIsJv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLj67-0007qu-5P; Tue, 27 Oct 2026 11:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLj5m-0007pn-8o
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:28:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xLj5b-0002Wd-QF
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793114870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vO335+XqSaMPiYB2isxssJwWJ8cU1Oq46q4+NvIyoWM=;
 b=L4fj5jGdi4v0KhKsJ4uWwRVa1F/aPvRq+cbNE0mt7CIs+MYjbrfcwD2l5VmfHlN2eAAPSS
 L7ei9YK6TVf4K30UISMWMS2/Ap4zBVZEAqTiavfJcwygb80NXewzj3LQrNp9SNMQqT4UKU
 mqPe8XBcOI/ygnvhMwdWRuNQF0DNuBE=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-c0s5lEhxN4Gx8dV5AMPuig-1; Tue, 27 Oct 2026 11:27:48 -0400
X-MC-Unique: c0s5lEhxN4Gx8dV5AMPuig-1
X-Mimecast-MFC-AGG-ID: c0s5lEhxN4Gx8dV5AMPuig_1793114867
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so11195236eec.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 08:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793114867; cv=none;
 d=google.com; s=arc-20260327;
 b=qKgvJXtN54IOw+rVirnxUTSwWAwZzBXlEPj5hNAkMZcg6jukF6Pq1Qz9HpJdHE3LL8
 peS8uRN8LIvzVJUBqv7Y1vySqRT/yr8cUQGAFFHsFSGPcJE8uRl1sCQqDgvp+PNJa+BE
 IMNhrwN666HrKs9IDznNLIBcEYroUzr7hsT5sM1a6b7PrY4FYeTfU/8PqYeEjLhITh6+
 /oqShbNp3Oea9uUzStv1HC18QVVighabn0rK2JtGw23WWmjnOVwRc6byAdWVk2N8Qoks
 QqxjMNIaFfRcektGVZrfkOuhBZnj1oRxaNa5B0vIkt12yCeOtv7GZlyJ+rpIV9P4d78M
 /xMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vO335+XqSaMPiYB2isxssJwWJ8cU1Oq46q4+NvIyoWM=;
 fh=7+TMJ2Yg423AStOeItkvWjwS2P6hzHITMCZ8X7RwWFE=;
 b=QMmjdPQnakNs3fsBSeFIa9+AcKesEvp2hPglkGFmwe+2Jee1OxdK3LY14SI3EZZm+P
 BnHwPZqjyNtTn9oCLO9n9/mHXEvZJmEtWwpH0CSiOzELt/UP7oSitJmzJuzCVm7gZ+YC
 GMuTKDxHUOo/d2umjZ3TLloRHxZdDlfHUFDg87IM1dBhbZJ3bhLWJFMHCiLxK+KR6xu0
 oUUkBzhQI+3v3eRubsbyVe6cc+fHd5+9HFQJr97BXELr6u+CVya1+cBp934cdOFupd/9
 Wq0kIy0/IuWggH3jed6Fx3uJ6Mx2Nzp6Ijs63RHM70eV3FDjqyE0WlmQev8sRMc/YeO8
 Ma4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793114867; x=1793719667; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vO335+XqSaMPiYB2isxssJwWJ8cU1Oq46q4+NvIyoWM=;
 b=T6EMIsJvyOeai/a34gmFc+Hvw20n8I8UooDbIKB6BQ/tNAIYlq2vAcioE8PDCtOPRv
 Ua8bQksLd5xBEab1wVlHinzcS5QQo3oCRHU6GBRbuZy67rxC/t5zMjRQ2Mca5TNvjj4m
 7xcig0FJ262trstaQfLIt+UpYFyyAZyVJ8ZNgujcc+uLBtrej7siLW+4nbVKvQs1Qx/d
 ZCSb2mnHbwpL6ZY6f2GXyNm1oQCnLA96th+0oRcO7adn3C/0PpGlCVA41Hq7kDimzrO3
 riEmpc6lBrJ9oYWvjcxcj69k/XgBysrGoB5HvTqbHwPwj+Am1ffxYTBHNhXXCshC9qjp
 I7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793114867; x=1793719667;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vO335+XqSaMPiYB2isxssJwWJ8cU1Oq46q4+NvIyoWM=;
 b=mYoKvmWhpa/oqu/KkiP1fX3Ia0+wkea3H7WctZQUwi4VzIIASJrcdIzhlZLYsYCj1z
 StiRmiFcJQ4fye/m9+XFqoLeQs28Ont3Wb0s7em5hg80gNPqEuSawzbe18KonHb3Hyu0
 DUYuiJcFW7om76WxLHTpIdBkPe3Xc21YA+GVfHUFBMvsZmCtRhdYBnXuR770t6zJGaSA
 cMrpTYq655lJhhy0nMr1DXQD+ZKqO4Bih828RUygDhyCJUrJAljnRlMYGqVaqJnjJ7/+
 Wx8fznVLpJQDHULkuAdPThFdlq56V6cge0uja66WGu0xUK2w+l3pSehBbqMmHLZqqx4q
 mUBQ==
X-Gm-Message-State: AFq9FYKP4LlnZLvxqvsCSfCx2yeY9Zymzj+qEZo0GrTme/am0Y2/cPBS
 i+v1EWadM35pY8xtkxdk9raPmGLSaaH4eszwoHC84k9g6g/L1iJS2KJp1Lt/a5A8Xun6Z74fytd
 Ah7DqqQyHfj00NCdgoCINDKD/aQZmh+7vwcHzDbo3i+pox4/2YHnGMbN5ds+A/ludLlLFG+z7lA
 lU9GYynQpt9T809b3RYCz4EvDLWT92RzA=
X-Gm-Gg: AYBFou1O17QX7gyR5aHXBJKHoR6BNl+m8X1sVqlhfzZwVVqQEYNuUUXGTc72ZR5NtWj
 mIFhoQ+9H2T/6nNTlxvwqXalGa/0y/U9YjHxvKJyhDtBKcBRbBOR2+9CE6g2TKJzk2Tp/uk5tsP
 LWQjEkMT1BL+MEI791vEOqO5ITZu5pakpaDD2eix7NFiqhdxqUugakXDhwonI935dVRz7ORXcCT
 u0TqvYwEufiJgG+lA==
X-Received: by 2002:a05:7301:d183:b0:369:d8e1:7bb6 with SMTP id
 5a478bee46e88-369e84dd32fmr16447519eec.25.1793114867008; 
 Tue, 27 Oct 2026 08:27:47 -0700 (PDT)
X-Received: by 2002:a05:7301:d183:b0:369:d8e1:7bb6 with SMTP id
 5a478bee46e88-369e84dd32fmr16447473eec.25.1793114866024; Tue, 27 Oct 2026
 08:27:46 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027133049.2522944-2-marcandre.lureau@redhat.com>
 <CAPMcbCr=gsBr9Wnw1rK+4HEcTwdCxOinKqeC=0yE1ZUa-hwHWw@mail.gmail.com>
 <CAJ+F1CLHzMuGW_m9kkU2r3YW-Vv1eQAYQ3YkJSfKm_QsoZbQWQ@mail.gmail.com>
 <CAPMcbCqG9sEHaeEeiPV7TnN4fVbKdKsUCXTXvejdArPjXEkzRg@mail.gmail.com>
 <CAMxuvazUb78qP6X8YV13+8ggYpgdFu3=7OnDiwN3De+Xcd7jNg@mail.gmail.com>
In-Reply-To: <CAMxuvazUb78qP6X8YV13+8ggYpgdFu3=7OnDiwN3De+Xcd7jNg@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 27 Oct 2026 17:27:33 +0200
X-Gm-Features: AclHuK-E3S0Y0gVV44_O2k_tMgik1gZoUEUpvJupUJ00ztT61Fr9SjWzGzcLRYM
Message-ID: <CAPMcbCpHCcHW7K70bOC5F1LPq-Cokbnd=FUd-wxwWQr=2qdJMA@mail.gmail.com>
Subject: Re: [PATCH] qga/vss: fix provider handling of snapshots
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, gillian.anton@cohesity.com, qemu-stable@nongnu.org, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000a19c7e065ed416d9"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000a19c7e065ed416d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 5:04=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Hi
>
> On Tue, Oct 27, 2026 at 6:56=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redh=
at.com>
> wrote:
> >
> >
> >
> >
> > On Tue, Oct 27, 2026 at 4:02=E2=80=AFPM Marc-Andr=C3=A9 Lureau <
> marcandre.lureau@redhat.com> wrote:
> >>
> >> Hi
> >>
> >> On Tue, Oct 27, 2026 at 5:54=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@r=
edhat.com>
> wrote:
> >> >
> >> >
> >> >
> >> > On Tue, Oct 27, 2026 at 3:31=E2=80=AFPM <marcandre.lureau@redhat.com=
> wrote:
> >> >>
> >> >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> >>
> >> >> Since commit 374f4676788c, the provider's GetSnapshotProperties()
> >> >> returns S_OK for any snapshot ID without filling in the properties.
> VSS
> >> >> consults every registered provider when a requester looks up a
> snapshot,
> >> >> so lookups of snapshots owned by other providers now succeed with a=
n
> >> >> all-zero VSS_SNAPSHOT_PROP. Backup software relying on it fails, e.=
g.
> >> >> Veeam: "Original volume name is not specified for the shadow (shado=
w
> >> >> volume id: '{00000000-0000-0000-0000-000000000000}')".
> >> >>
> >> >> Simply reverting is not an option: 374f4676788c switched to S_OK
> because
> >> >> returning VSS_E_OBJECT_NOT_FOUND unconditionally broke qemu-ga's ow=
n
> >> >> snapshot sets. The provider must answer for its own snapshots only.
> It
> >> >> does not create real shadow copies, but it does take part in the
> >> >> snapshot set during qemu-ga fsfreeze cycles. Remember the snapshot
> IDs
> >> >> received in BeginPrepareSnapshot(), return their
> >> >> (minimal) properties, and return VSS_E_OBJECT_NOT_FOUND for anythin=
g
> >> >> else.
> >> >>
> >> >> Entries are dropped when VSS deletes the snapshots or the set, or
> when
> >> >> the set is aborted (AbortSnapshots()).
> >> >>
> >> >> COM+ may hand out several CQGAVssProvider instances (and serve
> several
> >> >> client processes), so this registry is module-global. It is
> per-process
> >> >> by design and safe because the COM+ application is hosted by a
> single NT
> >> >> service (see CreateServiceForApplication() in install.cpp): COM+
> forbids
> >> >> pooling and recycling for service-hosted applications, so exactly o=
ne
> >> >> surrogate process ever hosts the provider.
> >> >>
> >> >> On the requester side, the snapshot set is created in the persisten=
t
> >> >> VSS_CTX_APP_ROLLBACK context, so VSS keeps it after the freeze/thaw
> >> >> cycle and may keep querying providers about it. The provider regist=
ry
> >> >> does not outlive the cycle (requester_thaw() stops the hosting
> service,
> >> >> and the provider process with it), so later queries would get "not
> >> >> found" for a set VSS still believes exists. Make requester_thaw()
> delete
> >> >> the snapshot set explicitly at the end of the cycle, whatever its
> >> >> outcome (including BackupComplete() failure and aborted snapshot
> sets).
> >> >> A failure to delete is only logged, since the guest filesystems hav=
e
> >> >> already been thawed.
> >> >>
> >> >> Cc: qemu-stable@nongnu.org
> >> >> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4584
> >> >> Buglink: https://redhat.atlassian.net/browse/RHEL-250662
> >> >> Fixes: 374f4676788c ("qga: Fix VSS provider GetSnapshotProperties
> return value")
> >> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> >> ---
> >> >>  qga/vss-win32/install.cpp   |   1 +
> >> >>  qga/vss-win32/provider.cpp  | 153
> +++++++++++++++++++++++++++++++++++-
> >> >>  qga/vss-win32/requester.cpp |  26 ++++++
> >> >>  3 files changed, 179 insertions(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> >> >> index 09d94edd4f53..3b58dc840520 100644
> >> >> --- a/qga/vss-win32/install.cpp
> >> >> +++ b/qga/vss-win32/install.cpp
> >> >> @@ -331,6 +331,7 @@ STDAPI COMRegister(void)
> >> >>      chk(put_Value(pObj, L"Authentication",
>  short(6)));
> >> >>      chk(put_Value(pObj, L"AuthenticationCapability",
>  short(2)));
> >> >>      chk(put_Value(pObj, L"ImpersonationLevel",
>  short(2)));
> >> >> +    /* NT-service-hosted apps have ConcurrentApps=3D1 enforced */
> >> >>      chk(pApps->SaveChanges(&n));
> >> >>
> >> >>      /* The app should be deleted if something fails after
> SaveChanges */
> >> >> diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cp=
p
> >> >> index 1c8eb236e57f..ad2f3ee763e6 100644
> >> >> --- a/qga/vss-win32/provider.cpp
> >> >> +++ b/qga/vss-win32/provider.cpp
> >> >> @@ -11,6 +11,11 @@
> >> >>   */
> >> >>
> >> >>  #include "qemu/osdep.h"
> >> >> +
> >> >> +#include <vector>
> >> >> +#include <algorithm>
> >> >> +#include <string>
> >> >> +
> >> >>  #include "vss-common.h"
> >> >>  #include "vss-debug.h"
> >> >>  #ifdef HAVE_VSS_SDK
> >> >> @@ -138,6 +143,123 @@ STDMETHODIMP
> CQGAVSSEnumObject::Clone(IVssEnumObject **ppenum)
> >> >>      return E_NOTIMPL;
> >> >>  }
> >> >>
> >> >> +/* Registry of the snapshot IDs for this provider */
> >> >> +class QGAVssSnapshotRegistry
> >> >> +{
> >> >> +public:
> >> >> +    bool Track(VSS_ID set_id, VSS_ID snapshot_id,
> >> >> +               VSS_PWSZ volume_name, LONG context);
> >> >> +    HRESULT GetProperties(VSS_ID snapshot_id, VSS_SNAPSHOT_PROP
> *prop) const;
> >> >> +    LONG RemoveSet(VSS_ID set_id); /* returns how many were remove=
d
> */
> >> >> +    bool Remove(VSS_ID snapshot_id);
> >> >> +
> >> >> +private:
> >> >> +    struct Entry {
> >> >> +        VSS_ID set_id;
> >> >> +        VSS_ID snapshot_id;
> >> >> +        std::wstring volume_name;
> >> >> +        LONG context;
> >> >> +    };
> >> >> +
> >> >> +    std::vector<Entry> m_entries;
> >> >> +    mutable SRWLOCK m_lock =3D SRWLOCK_INIT;
> >> >> +};
> >> >> +
> >> >> +static QGAVssSnapshotRegistry qga_vss_registry;
> >> >> +
> >> >> +bool QGAVssSnapshotRegistry::Track(VSS_ID set_id, VSS_ID
> snapshot_id,
> >> >> +                                   VSS_PWSZ volume_name, LONG
> context)
> >> >> +{
> >> >> +    bool ok;
> >> >> +
> >> >> +    AcquireSRWLockExclusive(&m_lock);
> >> >> +    try {
> >> >> +        m_entries.push_back(Entry { set_id, snapshot_id,
> volume_name,
> >> >> +                                    context });
> >> >> +        ok =3D true;
> >> >> +    } catch (...) {
> >> >> +        ok =3D false;
> >> >> +    }
> >> >> +    ReleaseSRWLockExclusive(&m_lock);
> >> >> +    return ok;
> >> >> +}
> >> >> +
> >> >> +HRESULT QGAVssSnapshotRegistry::GetProperties(VSS_ID snapshot_id,
> >> >> +                                              VSS_SNAPSHOT_PROP
> *prop) const
> >> >> +{
> >> >> +    HRESULT hr =3D S_OK;
> >> >> +
> >> >> +    AcquireSRWLockShared(&m_lock);
> >> >> +    auto it =3D std::find_if(m_entries.begin(), m_entries.end(),
> >> >> +        [&](const Entry &e) {
> >> >> +            return IsEqualGUID(e.snapshot_id, snapshot_id);
> >> >> +        });
> >> >> +    if (it =3D=3D m_entries.end()) {
> >> >> +        hr =3D VSS_E_OBJECT_NOT_FOUND;
> >> >> +        goto out;
> >> >> +    }
> >> >> +
> >> >> +    {
> >> >> +        const Entry &e =3D *it;
> >> >> +        size_t len =3D (e.volume_name.size() + 1) * sizeof(WCHAR);
> >> >> +        VSS_PWSZ volume =3D (VSS_PWSZ)CoTaskMemAlloc(len);
> >> >
> >> >
> >> > I'm afraid of this part. We allocate memory but don't call
> CoTaskMemFree.
> >> > This function is called from
> IVssBackupComponents::GetSnapshotProperties
> >> > From
> https://learn.microsoft.com/en-us/windows/win32/api/vsbackup/nf-vsbackup-=
ivssbackupcomponents-getsnapshotproperties
> >> > "When the structure is no longer needed, the software provider is
> responsible for freeing these strings by calling the
> VssFreeSnapshotProperties function."
> >> >
> >> > So we allocate memory but don't free it with
> VssFreeSnapshotProperties or CoTaskMemFree.
> >>
> >> I also wondered, but this is apparently what is expected:
> >>
> >>
> https://github.com/MicrosoftDocs/sdk-api/blob/docs/sdk-api-src/content/vs=
s/ns-vss-vss_object_prop.md
> >>
> >>
> >> A requester obtains VSS_OBJECT_PROP structures by using
> >> IVssEnumObject::Next to iterate over the list of objects returned by a
> >> call to IVssBackupComponents::Query.
> >>
> > Yes, but there is nothing about cleaning memory
> >
> >
> >>
> >> As its members are filled by a COM interface, prior to deleting the
> >> property structures VSS_SNAPSHOT_PROP and VSS_PROVIDER_PROP, the
> >> memory they contain must be released by calling CoTaskMemFree for
> >> every string and byte array value contained in each structure.
> >>
> >> In the case of VSS_SNAPSHOT_PROP, this can be done manually, or the
> >> utility function VssFreeSnapshotProperties can be used.
> >>
> > but we don't store the pointers
>
> I don't follow you.
>
>
> https://learn.microsoft.com/en-us/windows/win32/api/vsprov/nf-vsprov-ivss=
softwaresnapshotprovider-getsnapshotproperties
>
> "All members are required except m_pwszExposedName and
> m_pwszExposedPath, which the provider can set to NULL. The provider
> allocates memory for all string members that it sets in the structure.
> When the structure is no longer needed, the caller is responsible for
> freeing these strings by calling the VssFreeSnapshotProperties
> function."
>
> So it looks like we should actually fill the other fields too
>
>
I love MSFT docs.

Ok, let me test this.


> >
> >>
> >>
> >> >
> >> >> +
> >> >> +        if (!volume) {
> >> >> +            hr =3D E_OUTOFMEMORY;
> >> >> +            goto out;
> >> >> +        }
> >> >> +        memcpy(volume, e.volume_name.c_str(), len);
> >> >> +
> >> >> +        /* not a real snapshot: no device object, exposure or
> timestamp */
> >> >> +        memset(prop, 0, sizeof(*prop));
> >> >> +        prop->m_SnapshotId =3D e.snapshot_id;
> >> >> +        prop->m_SnapshotSetId =3D e.set_id;
> >> >> +        prop->m_lSnapshotsCount =3D std::count_if(m_entries.begin(=
),
> >> >> +            m_entries.end(), [&](const Entry &o) {
> >> >> +                return IsEqualGUID(o.set_id, e.set_id);
> >> >> +            });
> >> >> +        prop->m_pwszOriginalVolumeName =3D volume;
> >> >> +        prop->m_ProviderId =3D g_gProviderId;
> >> >> +        prop->m_lSnapshotAttributes =3D e.context;
> >> >> +        prop->m_eStatus =3D VSS_SS_CREATED;
> >> >> +    }
> >> >> +
> >> >> +out:
> >> >> +    ReleaseSRWLockShared(&m_lock);
> >> >> +    return hr;
> >> >> +}
> >> >> +
> >> >> +LONG QGAVssSnapshotRegistry::RemoveSet(VSS_ID set_id)
> >> >> +{
> >> >> +    LONG removed;
> >> >> +
> >> >> +    AcquireSRWLockExclusive(&m_lock);
> >> >> +    auto it =3D std::remove_if(m_entries.begin(), m_entries.end(),
> >> >> +        [&](const Entry &e) {
> >> >> +            return IsEqualGUID(e.set_id, set_id);
> >> >> +        });
> >> >> +    removed =3D m_entries.end() - it;
> >> >> +    m_entries.erase(it, m_entries.end());
> >> >> +    ReleaseSRWLockExclusive(&m_lock);
> >> >> +    return removed;
> >> >> +}
> >> >> +
> >> >> +bool QGAVssSnapshotRegistry::Remove(VSS_ID snapshot_id)
> >> >> +{
> >> >> +    bool found;
> >> >> +
> >> >> +    AcquireSRWLockExclusive(&m_lock);
> >> >> +    auto it =3D std::find_if(m_entries.begin(), m_entries.end(),
> >> >> +        [&](const Entry &e) {
> >> >> +            return IsEqualGUID(e.snapshot_id, snapshot_id);
> >> >> +        });
> >> >> +    found =3D it !=3D m_entries.end();
> >> >> +    if (found) {
> >> >> +        m_entries.erase(it);
> >> >> +    }
> >> >> +    ReleaseSRWLockExclusive(&m_lock);
> >> >> +    return found;
> >> >> +}
> >> >>
> >> >>  /* QGAVssProvider */
> >> >>
> >> >> @@ -266,7 +388,7 @@ STDMETHODIMP CQGAVssProvider::SetContext(LONG
> lContext)
> >> >>  STDMETHODIMP CQGAVssProvider::GetSnapshotProperties(
> >> >>      VSS_ID SnapshotId, VSS_SNAPSHOT_PROP *pProp)
> >> >>  {
> >> >> -    return S_OK;
> >> >> +    return qga_vss_registry.GetProperties(SnapshotId, pProp);
> >> >>  }
> >> >>
> >> >>  STDMETHODIMP CQGAVssProvider::Query(
> >> >> @@ -286,6 +408,27 @@ STDMETHODIMP CQGAVssProvider::DeleteSnapshots(
> >> >>      VSS_ID SourceObjectId, VSS_OBJECT_TYPE eSourceObjectType,
> >> >>      BOOL bForceDelete, LONG *plDeletedSnapshots, VSS_ID
> *pNondeletedSnapshotID)
> >> >>  {
> >> >> +    LONG deleted =3D 0;
> >> >> +
> >> >> +    switch (eSourceObjectType) {
> >> >> +    case VSS_OBJECT_SNAPSHOT:
> >> >> +        if (qga_vss_registry.Remove(SourceObjectId)) {
> >> >> +            deleted =3D 1;
> >> >> +        }
> >> >> +        break;
> >> >> +    case VSS_OBJECT_SNAPSHOT_SET:
> >> >> +        deleted =3D qga_vss_registry.RemoveSet(SourceObjectId);
> >> >> +        break;
> >> >> +    default:
> >> >> +        break;
> >> >> +    }
> >> >> +
> >> >> +    if (deleted > 0) {
> >> >> +        *plDeletedSnapshots =3D deleted;
> >> >> +        *pNondeletedSnapshotID =3D GUID_NULL;
> >> >> +        return S_OK;
> >> >> +    }
> >> >> +
> >> >>      *plDeletedSnapshots =3D 0;
> >> >>      *pNondeletedSnapshotID =3D SourceObjectId;
> >> >>      return S_OK;
> >> >> @@ -295,6 +438,13 @@ STDMETHODIMP
> CQGAVssProvider::BeginPrepareSnapshot(
> >> >>      VSS_ID SnapshotSetId, VSS_ID SnapshotId,
> >> >>      VSS_PWSZ pwszVolumeName, LONG lNewContext)
> >> >>  {
> >> >> +    if (!pwszVolumeName) {
> >> >> +        return E_INVALIDARG;
> >> >> +    }
> >> >> +    if (!qga_vss_registry.Track(SnapshotSetId, SnapshotId,
> >> >> +                                pwszVolumeName, lNewContext)) {
> >> >> +        return E_OUTOFMEMORY;
> >> >> +    }
> >> >>      return S_OK;
> >> >>  }
> >> >>
> >> >> @@ -411,6 +561,7 @@ STDMETHODIMP
> CQGAVssProvider::PostFinalCommitSnapshots(VSS_ID SnapshotSetId)
> >> >>
> >> >>  STDMETHODIMP CQGAVssProvider::AbortSnapshots(VSS_ID SnapshotSetId)
> >> >>  {
> >> >> +    qga_vss_registry.RemoveSet(SnapshotSetId);
> >> >>      return S_OK;
> >> >>  }
> >> >>
> >> >> diff --git a/qga/vss-win32/requester.cpp
> b/qga/vss-win32/requester.cpp
> >> >> index 1b0155c691ef..565eefcfb283 100644
> >> >> --- a/qga/vss-win32/requester.cpp
> >> >> +++ b/qga/vss-win32/requester.cpp
> >> >> @@ -52,6 +52,7 @@ static t_VssFreeSnapshotProperties
> pVssFreeSnapshotProperties;
> >> >>  static struct QGAVSSContext {
> >> >>      IVssBackupComponents *pVssbc;  /* VSS requester interface */
> >> >>      IVssAsync *pAsyncSnapshot;     /* async info of VSS snapshot
> operation */
> >> >> +    VSS_ID idSnapshotSet;          /* snapshot set created for thi=
s
> cycle */
> >> >>      HANDLE hEventFrozen;           /* notify fs/writer freeze from
> provider */
> >> >>      HANDLE hEventThaw;             /* request provider to thaw */
> >> >>      HANDLE hEventTimeout;          /* notify timeout in provider *=
/
> >> >> @@ -116,6 +117,7 @@ static void requester_cleanup(void)
> >> >>          vss_ctx.pVssbc->Release();
> >> >>          vss_ctx.pVssbc =3D NULL;
> >> >>      }
> >> >> +    vss_ctx.idSnapshotSet =3D GUID_NULL;
> >> >>      vss_ctx.cFrozenVols =3D 0;
> >> >>      qga_debug_end;
> >> >>  }
> >> >> @@ -446,6 +448,7 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
> >> >>          err_set(errset, hr, "failed to start snapshot set");
> >> >>          goto out;
> >> >>      }
> >> >> +    vss_ctx.idSnapshotSet =3D guidSnapshotSet;
> >> >>
> >> >>      if (mountpoints) {
> >> >>          PWCHAR volume_name_wchar;
> >> >> @@ -680,6 +683,29 @@ void requester_thaw(int *num_vols, void
> *mountpints, ErrorSet *errset)
> >> >>          err_set(errset, hr, "failed to do snapshot set");
> >> >>      }
> >> >>
> >> >> +    /*
> >> >> +     * The snapshot set is created in VSS_CTX_APP_ROLLBACK context=
,
> so
> >> >> +     * it is persistent: if it was committed, VSS keeps it (and
> keeps
> >> >> +     * querying providers about it) until it is explicitly deleted=
.
> The
> >> >> +     * freeze/thaw cycle is over whatever the outcome above, so
> delete
> >> >> +     * it now. Failure is not fatal here, only log it.
> >> >> +     */
> >> >> +    {
> >> >> +        LONG lDeletedSnapshots =3D 0;
> >> >> +        VSS_ID idNonDeletedSnapshot;
> >> >> +        HRESULT hrDelete;
> >> >> +
> >> >> +        hrDelete =3D
> vss_ctx.pVssbc->DeleteSnapshots(vss_ctx.idSnapshotSet,
> >> >> +
>  VSS_OBJECT_SNAPSHOT_SET,
> >> >> +                                                   TRUE,
> >> >> +
>  &lDeletedSnapshots,
> >> >> +
>  &idNonDeletedSnapshot);
> >> >> +        if (FAILED(hrDelete)) {
> >> >> +            qga_debug("failed to delete snapshot set after thaw,"
> >> >> +                      " hr=3D0x%08lx", hrDelete);
> >> >> +        }
> >> >> +    }
> >> >> +
> >> >>      if (err_is_set(errset)) {
> >> >>          vss_ctx.pVssbc->AbortBackup();
> >> >>      }
> >> >> --
> >> >> 2.56.0.116.g6de20f6092dc
> >> >>
> >>
>
>

--000000000000a19c7e065ed416d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><div><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><br></div></div></div>=
<br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"=
ltr" class=3D"gmail_attr">On Tue, Oct 27, 2026 at 5:04=E2=80=AFPM Marc-Andr=
=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.=
lureau@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Hi<br>
<br>
On Tue, Oct 27, 2026 at 6:56=E2=80=AFPM Kostiantyn Kostiuk &lt;<a href=3D"m=
ailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt; wr=
ote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Oct 27, 2026 at 4:02=E2=80=AFPM Marc-Andr=C3=A9 Lureau &lt;<a =
href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">marcandre.lur=
eau@redhat.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Oct 27, 2026 at 5:54=E2=80=AFPM Kostiantyn Kostiuk &lt;<a =
href=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</=
a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; On Tue, Oct 27, 2026 at 3:31=E2=80=AFPM &lt;<a href=3D"mailto=
:marcandre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com=
</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcan=
dre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt=
;<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Since commit 374f4676788c, the provider&#39;s GetSnapshot=
Properties()<br>
&gt;&gt; &gt;&gt; returns S_OK for any snapshot ID without filling in the p=
roperties.=C2=A0 VSS<br>
&gt;&gt; &gt;&gt; consults every registered provider when a requester looks=
 up a snapshot,<br>
&gt;&gt; &gt;&gt; so lookups of snapshots owned by other providers now succ=
eed with an<br>
&gt;&gt; &gt;&gt; all-zero VSS_SNAPSHOT_PROP. Backup software relying on it=
 fails, e.g.<br>
&gt;&gt; &gt;&gt; Veeam: &quot;Original volume name is not specified for th=
e shadow (shadow<br>
&gt;&gt; &gt;&gt; volume id: &#39;{00000000-0000-0000-0000-000000000000}&#3=
9;)&quot;.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Simply reverting is not an option: 374f4676788c switched =
to S_OK because<br>
&gt;&gt; &gt;&gt; returning VSS_E_OBJECT_NOT_FOUND unconditionally broke qe=
mu-ga&#39;s own<br>
&gt;&gt; &gt;&gt; snapshot sets. The provider must answer for its own snaps=
hots only. It<br>
&gt;&gt; &gt;&gt; does not create real shadow copies, but it does take part=
 in the<br>
&gt;&gt; &gt;&gt; snapshot set during qemu-ga fsfreeze cycles. Remember the=
 snapshot IDs<br>
&gt;&gt; &gt;&gt; received in BeginPrepareSnapshot(), return their<br>
&gt;&gt; &gt;&gt; (minimal) properties, and return VSS_E_OBJECT_NOT_FOUND f=
or anything<br>
&gt;&gt; &gt;&gt; else.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Entries are dropped when VSS deletes the snapshots or the=
 set, or when<br>
&gt;&gt; &gt;&gt; the set is aborted (AbortSnapshots()).<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; COM+ may hand out several CQGAVssProvider instances (and =
serve several<br>
&gt;&gt; &gt;&gt; client processes), so this registry is module-global. It =
is per-process<br>
&gt;&gt; &gt;&gt; by design and safe because the COM+ application is hosted=
 by a single NT<br>
&gt;&gt; &gt;&gt; service (see CreateServiceForApplication() in install.cpp=
): COM+ forbids<br>
&gt;&gt; &gt;&gt; pooling and recycling for service-hosted applications, so=
 exactly one<br>
&gt;&gt; &gt;&gt; surrogate process ever hosts the provider.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; On the requester side, the snapshot set is created in the=
 persistent<br>
&gt;&gt; &gt;&gt; VSS_CTX_APP_ROLLBACK context, so VSS keeps it after the f=
reeze/thaw<br>
&gt;&gt; &gt;&gt; cycle and may keep querying providers about it. The provi=
der registry<br>
&gt;&gt; &gt;&gt; does not outlive the cycle (requester_thaw() stops the ho=
sting service,<br>
&gt;&gt; &gt;&gt; and the provider process with it), so later queries would=
 get &quot;not<br>
&gt;&gt; &gt;&gt; found&quot; for a set VSS still believes exists. Make req=
uester_thaw() delete<br>
&gt;&gt; &gt;&gt; the snapshot set explicitly at the end of the cycle, what=
ever its<br>
&gt;&gt; &gt;&gt; outcome (including BackupComplete() failure and aborted s=
napshot sets).<br>
&gt;&gt; &gt;&gt; A failure to delete is only logged, since the guest files=
ystems have<br>
&gt;&gt; &gt;&gt; already been thawed.<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_=
blank">qemu-stable@nongnu.org</a><br>
&gt;&gt; &gt;&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu=
/-/work_items/4584" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com=
/qemu-project/qemu/-/work_items/4584</a><br>
&gt;&gt; &gt;&gt; Buglink: <a href=3D"https://redhat.atlassian.net/browse/R=
HEL-250662" rel=3D"noreferrer" target=3D"_blank">https://redhat.atlassian.n=
et/browse/RHEL-250662</a><br>
&gt;&gt; &gt;&gt; Fixes: 374f4676788c (&quot;qga: Fix VSS provider GetSnaps=
hotProperties return value&quot;)<br>
&gt;&gt; &gt;&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mail=
to:marcandre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.c=
om</a>&gt;<br>
&gt;&gt; &gt;&gt; ---<br>
&gt;&gt; &gt;&gt;=C2=A0 qga/vss-win32/install.cpp=C2=A0 =C2=A0|=C2=A0 =C2=
=A01 +<br>
&gt;&gt; &gt;&gt;=C2=A0 qga/vss-win32/provider.cpp=C2=A0 | 153 ++++++++++++=
+++++++++++++++++++++++-<br>
&gt;&gt; &gt;&gt;=C2=A0 qga/vss-win32/requester.cpp |=C2=A0 26 ++++++<br>
&gt;&gt; &gt;&gt;=C2=A0 3 files changed, 179 insertions(+), 1 deletion(-)<b=
r>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/in=
stall.cpp<br>
&gt;&gt; &gt;&gt; index 09d94edd4f53..3b58dc840520 100644<br>
&gt;&gt; &gt;&gt; --- a/qga/vss-win32/install.cpp<br>
&gt;&gt; &gt;&gt; +++ b/qga/vss-win32/install.cpp<br>
&gt;&gt; &gt;&gt; @@ -331,6 +331,7 @@ STDAPI COMRegister(void)<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 chk(put_Value(pObj, L&quot;Authentica=
tion&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sh=
ort(6)));<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 chk(put_Value(pObj, L&quot;Authentica=
tionCapability&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0short(2)));<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 chk(put_Value(pObj, L&quot;Impersonat=
ionLevel&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0short(2)));<=
br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 /* NT-service-hosted apps have ConcurrentA=
pps=3D1 enforced */<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 chk(pApps-&gt;SaveChanges(&amp;n));<b=
r>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 /* The app should be deleted if somet=
hing fails after SaveChanges */<br>
&gt;&gt; &gt;&gt; diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/p=
rovider.cpp<br>
&gt;&gt; &gt;&gt; index 1c8eb236e57f..ad2f3ee763e6 100644<br>
&gt;&gt; &gt;&gt; --- a/qga/vss-win32/provider.cpp<br>
&gt;&gt; &gt;&gt; +++ b/qga/vss-win32/provider.cpp<br>
&gt;&gt; &gt;&gt; @@ -11,6 +11,11 @@<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0*/<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +#include &lt;vector&gt;<br>
&gt;&gt; &gt;&gt; +#include &lt;algorithm&gt;<br>
&gt;&gt; &gt;&gt; +#include &lt;string&gt;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt;=C2=A0 #include &quot;vss-common.h&quot;<br>
&gt;&gt; &gt;&gt;=C2=A0 #include &quot;vss-debug.h&quot;<br>
&gt;&gt; &gt;&gt;=C2=A0 #ifdef HAVE_VSS_SDK<br>
&gt;&gt; &gt;&gt; @@ -138,6 +143,123 @@ STDMETHODIMP CQGAVSSEnumObject::Clo=
ne(IVssEnumObject **ppenum)<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 return E_NOTIMPL;<br>
&gt;&gt; &gt;&gt;=C2=A0 }<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; +/* Registry of the snapshot IDs for this provider */<br>
&gt;&gt; &gt;&gt; +class QGAVssSnapshotRegistry<br>
&gt;&gt; &gt;&gt; +{<br>
&gt;&gt; &gt;&gt; +public:<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 bool Track(VSS_ID set_id, VSS_ID snapshot_=
id,<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0V=
SS_PWSZ volume_name, LONG context);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 HRESULT GetProperties(VSS_ID snapshot_id, =
VSS_SNAPSHOT_PROP *prop) const;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 LONG RemoveSet(VSS_ID set_id); /* returns =
how many were removed */<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 bool Remove(VSS_ID snapshot_id);<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +private:<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 struct Entry {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VSS_ID set_id;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VSS_ID snapshot_id;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 std::wstring volume_name;<br=
>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LONG context;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 };<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 std::vector&lt;Entry&gt; m_entries;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 mutable SRWLOCK m_lock =3D SRWLOCK_INIT;<b=
r>
&gt;&gt; &gt;&gt; +};<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +static QGAVssSnapshotRegistry qga_vss_registry;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +bool QGAVssSnapshotRegistry::Track(VSS_ID set_id, VSS_ID=
 snapshot_id,<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VSS_PW=
SZ volume_name, LONG context)<br>
&gt;&gt; &gt;&gt; +{<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 bool ok;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 AcquireSRWLockExclusive(&amp;m_lock);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 try {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 m_entries.push_back(Entry { =
set_id, snapshot_id, volume_name,<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 conte=
xt });<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok =3D true;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 } catch (...) {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ok =3D false;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 ReleaseSRWLockExclusive(&amp;m_lock);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 return ok;<br>
&gt;&gt; &gt;&gt; +}<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +HRESULT QGAVssSnapshotRegistry::GetProperties(VSS_ID sna=
pshot_id,<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VSS_SNAPSHOT_PROP *prop) const<br>
&gt;&gt; &gt;&gt; +{<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 HRESULT hr =3D S_OK;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 AcquireSRWLockShared(&amp;m_lock);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 auto it =3D std::find_if(m_entries.begin()=
, m_entries.end(),<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&amp;](const Entry &amp;e) =
{<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IsEqual=
GUID(e.snapshot_id, snapshot_id);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 if (it =3D=3D m_entries.end()) {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D VSS_E_OBJECT_NOT_FOUN=
D;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const Entry &amp;e =3D *it;<=
br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len =3D (e.volume_nam=
e.size() + 1) * sizeof(WCHAR);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VSS_PWSZ volume =3D (VSS_PWS=
Z)CoTaskMemAlloc(len);<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I&#39;m afraid of this part. We allocate memory but don&#39;t=
 call CoTaskMemFree.<br>
&gt;&gt; &gt; This function is called from IVssBackupComponents::GetSnapsho=
tProperties<br>
&gt;&gt; &gt; From <a href=3D"https://learn.microsoft.com/en-us/windows/win=
32/api/vsbackup/nf-vsbackup-ivssbackupcomponents-getsnapshotproperties" rel=
=3D"noreferrer" target=3D"_blank">https://learn.microsoft.com/en-us/windows=
/win32/api/vsbackup/nf-vsbackup-ivssbackupcomponents-getsnapshotproperties<=
/a><br>
&gt;&gt; &gt; &quot;When the structure is no longer needed, the software pr=
ovider is responsible for freeing these strings by calling the VssFreeSnaps=
hotProperties function.&quot;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; So we allocate memory but don&#39;t free it with VssFreeSnaps=
hotProperties or CoTaskMemFree.<br>
&gt;&gt;<br>
&gt;&gt; I also wondered, but this is apparently what is expected:<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://github.com/MicrosoftDocs/sdk-api/blob/docs/sdk-=
api-src/content/vss/ns-vss-vss_object_prop.md" rel=3D"noreferrer" target=3D=
"_blank">https://github.com/MicrosoftDocs/sdk-api/blob/docs/sdk-api-src/con=
tent/vss/ns-vss-vss_object_prop.md</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; A requester obtains VSS_OBJECT_PROP structures by using<br>
&gt;&gt; IVssEnumObject::Next to iterate over the list of objects returned =
by a<br>
&gt;&gt; call to IVssBackupComponents::Query.<br>
&gt;&gt;<br>
&gt; Yes, but there is nothing about cleaning memory<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; As its members are filled by a COM interface, prior to deleting th=
e<br>
&gt;&gt; property structures VSS_SNAPSHOT_PROP and VSS_PROVIDER_PROP, the<b=
r>
&gt;&gt; memory they contain must be released by calling CoTaskMemFree for<=
br>
&gt;&gt; every string and byte array value contained in each structure.<br>
&gt;&gt;<br>
&gt;&gt; In the case of VSS_SNAPSHOT_PROP, this can be done manually, or th=
e<br>
&gt;&gt; utility function VssFreeSnapshotProperties can be used.<br>
&gt;&gt;<br>
&gt; but we don&#39;t store the pointers<br>
<br>
I don&#39;t follow you.<br>
<br>
<a href=3D"https://learn.microsoft.com/en-us/windows/win32/api/vsprov/nf-vs=
prov-ivsssoftwaresnapshotprovider-getsnapshotproperties" rel=3D"noreferrer"=
 target=3D"_blank">https://learn.microsoft.com/en-us/windows/win32/api/vspr=
ov/nf-vsprov-ivsssoftwaresnapshotprovider-getsnapshotproperties</a><br>
<br>
&quot;All members are required except m_pwszExposedName and<br>
m_pwszExposedPath, which the provider can set to NULL. The provider<br>
allocates memory for all string members that it sets in the structure.<br>
When the structure is no longer needed, the caller is responsible for<br>
freeing these strings by calling the VssFreeSnapshotProperties<br>
function.&quot;<br>
<br>
So it looks like we should actually fill the other fields too<br>
<br></blockquote><div><br></div><div>I love MSFT docs.=C2=A0<br></div><div>=
<br></div><div>Ok, let me test this.=C2=A0</div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!volume) {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D E_OUTOF=
MEMORY;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(volume, e.volume_name=
.c_str(), len);<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* not a real snapshot: no d=
evice object, exposure or timestamp */<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(prop, 0, sizeof(*prop=
));<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_SnapshotId =3D e.=
snapshot_id;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_SnapshotSetId =3D=
 e.set_id;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_lSnapshotsCount =
=3D std::count_if(m_entries.begin(),<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m_entries.end(=
), [&amp;](const Entry &amp;o) {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
return IsEqualGUID(o.set_id, e.set_id);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_pwszOriginalVolum=
eName =3D volume;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_ProviderId =3D g_=
gProviderId;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_lSnapshotAttribut=
es =3D e.context;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prop-&gt;m_eStatus =3D VSS_S=
S_CREATED;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +out:<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 ReleaseSRWLockShared(&amp;m_lock);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 return hr;<br>
&gt;&gt; &gt;&gt; +}<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +LONG QGAVssSnapshotRegistry::RemoveSet(VSS_ID set_id)<br=
>
&gt;&gt; &gt;&gt; +{<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 LONG removed;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 AcquireSRWLockExclusive(&amp;m_lock);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 auto it =3D std::remove_if(m_entries.begin=
(), m_entries.end(),<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&amp;](const Entry &amp;e) =
{<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IsEqual=
GUID(e.set_id, set_id);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 removed =3D m_entries.end() - it;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 m_entries.erase(it, m_entries.end());<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 ReleaseSRWLockExclusive(&amp;m_lock);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 return removed;<br>
&gt;&gt; &gt;&gt; +}<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +bool QGAVssSnapshotRegistry::Remove(VSS_ID snapshot_id)<=
br>
&gt;&gt; &gt;&gt; +{<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 bool found;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 AcquireSRWLockExclusive(&amp;m_lock);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 auto it =3D std::find_if(m_entries.begin()=
, m_entries.end(),<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 [&amp;](const Entry &amp;e) =
{<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IsEqual=
GUID(e.snapshot_id, snapshot_id);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 });<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 found =3D it !=3D m_entries.end();<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 if (found) {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 m_entries.erase(it);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 ReleaseSRWLockExclusive(&amp;m_lock);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 return found;<br>
&gt;&gt; &gt;&gt; +}<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 /* QGAVssProvider */<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; @@ -266,7 +388,7 @@ STDMETHODIMP CQGAVssProvider::SetCont=
ext(LONG lContext)<br>
&gt;&gt; &gt;&gt;=C2=A0 STDMETHODIMP CQGAVssProvider::GetSnapshotProperties=
(<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 VSS_ID SnapshotId, VSS_SNAPSHOT_PROP =
*pProp)<br>
&gt;&gt; &gt;&gt;=C2=A0 {<br>
&gt;&gt; &gt;&gt; -=C2=A0 =C2=A0 return S_OK;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 return qga_vss_registry.GetProperties(Snap=
shotId, pProp);<br>
&gt;&gt; &gt;&gt;=C2=A0 }<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 STDMETHODIMP CQGAVssProvider::Query(<br>
&gt;&gt; &gt;&gt; @@ -286,6 +408,27 @@ STDMETHODIMP CQGAVssProvider::Delete=
Snapshots(<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 VSS_ID SourceObjectId, VSS_OBJECT_TYP=
E eSourceObjectType,<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 BOOL bForceDelete, LONG *plDeletedSna=
pshots, VSS_ID *pNondeletedSnapshotID)<br>
&gt;&gt; &gt;&gt;=C2=A0 {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 LONG deleted =3D 0;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 switch (eSourceObjectType) {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 case VSS_OBJECT_SNAPSHOT:<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qga_vss_registry.Remove(=
SourceObjectId)) {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 deleted =3D 1;=
<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 case VSS_OBJECT_SNAPSHOT_SET:<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 deleted =3D qga_vss_registry=
.RemoveSet(SourceObjectId);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 default:<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 if (deleted &gt; 0) {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *plDeletedSnapshots =3D dele=
ted;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 *pNondeletedSnapshotID =3D G=
UID_NULL;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return S_OK;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 *plDeletedSnapshots =3D 0;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 *pNondeletedSnapshotID =3D SourceObje=
ctId;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 return S_OK;<br>
&gt;&gt; &gt;&gt; @@ -295,6 +438,13 @@ STDMETHODIMP CQGAVssProvider::BeginP=
repareSnapshot(<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 VSS_ID SnapshotSetId, VSS_ID Snapshot=
Id,<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 VSS_PWSZ pwszVolumeName, LONG lNewCon=
text)<br>
&gt;&gt; &gt;&gt;=C2=A0 {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 if (!pwszVolumeName) {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return E_INVALIDARG;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 if (!qga_vss_registry.Track(SnapshotSetId,=
 SnapshotId,<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pwszVolumeName, lNe=
wContext)) {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return E_OUTOFMEMORY;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 return S_OK;<br>
&gt;&gt; &gt;&gt;=C2=A0 }<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; @@ -411,6 +561,7 @@ STDMETHODIMP CQGAVssProvider::PostFin=
alCommitSnapshots(VSS_ID SnapshotSetId)<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 STDMETHODIMP CQGAVssProvider::AbortSnapshots(VSS_ID=
 SnapshotSetId)<br>
&gt;&gt; &gt;&gt;=C2=A0 {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 qga_vss_registry.RemoveSet(SnapshotSetId);=
<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 return S_OK;<br>
&gt;&gt; &gt;&gt;=C2=A0 }<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/=
requester.cpp<br>
&gt;&gt; &gt;&gt; index 1b0155c691ef..565eefcfb283 100644<br>
&gt;&gt; &gt;&gt; --- a/qga/vss-win32/requester.cpp<br>
&gt;&gt; &gt;&gt; +++ b/qga/vss-win32/requester.cpp<br>
&gt;&gt; &gt;&gt; @@ -52,6 +52,7 @@ static t_VssFreeSnapshotProperties pVss=
FreeSnapshotProperties;<br>
&gt;&gt; &gt;&gt;=C2=A0 static struct QGAVSSContext {<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 IVssBackupComponents *pVssbc;=C2=A0 /=
* VSS requester interface */<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 IVssAsync *pAsyncSnapshot;=C2=A0 =C2=
=A0 =C2=A0/* async info of VSS snapshot operation */<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 VSS_ID idSnapshotSet;=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* snapshot set created for this cycle */<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 HANDLE hEventFrozen;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* notify fs/writer freeze from provider */<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 HANDLE hEventThaw;=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* request provider to thaw */<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 HANDLE hEventTimeout;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* notify timeout in provider */<br>
&gt;&gt; &gt;&gt; @@ -116,6 +117,7 @@ static void requester_cleanup(void)<b=
r>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vss_ctx.pVssbc-&gt;Rele=
ase();<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vss_ctx.pVssbc =3D NULL=
;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 vss_ctx.idSnapshotSet =3D GUID_NULL;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 vss_ctx.cFrozenVols =3D 0;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 qga_debug_end;<br>
&gt;&gt; &gt;&gt;=C2=A0 }<br>
&gt;&gt; &gt;&gt; @@ -446,6 +448,7 @@ void requester_freeze(int *num_vols, =
void *mountpoints, ErrorSet *errset)<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err_set(errset, hr, &qu=
ot;failed to start snapshot set&quot;);<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 vss_ctx.idSnapshotSet =3D guidSnapshotSet;=
<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (mountpoints) {<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PWCHAR volume_name_wcha=
r;<br>
&gt;&gt; &gt;&gt; @@ -680,6 +683,29 @@ void requester_thaw(int *num_vols, v=
oid *mountpints, ErrorSet *errset)<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err_set(errset, hr, &qu=
ot;failed to do snapshot set&quot;);<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 /*<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0* The snapshot set is created in VSS=
_CTX_APP_ROLLBACK context, so<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0* it is persistent: if it was commit=
ted, VSS keeps it (and keeps<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0* querying providers about it) until=
 it is explicitly deleted. The<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0* freeze/thaw cycle is over whatever=
 the outcome above, so delete<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0* it now. Failure is not fatal here,=
 only log it.<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LONG lDeletedSnapshots =3D 0=
;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VSS_ID idNonDeletedSnapshot;=
<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 HRESULT hrDelete;<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 hrDelete =3D vss_ctx.pVssbc-=
&gt;DeleteSnapshots(vss_ctx.idSnapshotSet,<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VSS_OBJECT_SNAPSHOT_SET=
,<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TRUE,<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;lDeletedSnapshots,=
<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;idNonDeletedSnapsh=
ot);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FAILED(hrDelete)) {<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qga_debug(&quo=
t;failed to delete snapshot set after thaw,&quot;<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot; hr=3D0x%08lx&quot;, hrDelete);<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;&gt; +<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (err_is_set(errset)) {<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vss_ctx.pVssbc-&gt;Abor=
tBackup();<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; &gt;&gt; --<br>
&gt;&gt; &gt;&gt; 2.56.0.116.g6de20f6092dc<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt;<br>
<br>
</blockquote></div></div>

--000000000000a19c7e065ed416d9--


