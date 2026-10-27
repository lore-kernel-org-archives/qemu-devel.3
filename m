Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3345F606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bClvwq/p;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=e1hqIa5B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLij0-0000rd-4w; Tue, 27 Oct 2026 11:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xLiiw-0000qX-Gx
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:04:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xLiiq-00008K-Jp
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793113457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cs8OZ7ZJMieaI5iZpEZmZL+ZZ7ElGT8S0fd9AruYFtc=;
 b=bClvwq/piONXTVYFd15/NbC4MkIn8hGz08qiKhmMCSUW0L1elZ9fwe/myPyV5DQ1P0xfbJ
 zlnK4mmW3Ko/zM5P56TBEeDvonu4aj9E8+oEZ1uxw7zTYJ6soJt7H+1bTM1Z5K5KOBExTP
 hqwhmX6nx6JlWWoMzXf07z3ZPdkceUM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-pnUtRg79MuCO6gCHq06Svw-1; Tue, 27 Oct 2026 11:04:15 -0400
X-MC-Unique: pnUtRg79MuCO6gCHq06Svw-1
X-Mimecast-MFC-AGG-ID: pnUtRg79MuCO6gCHq06Svw_1793113454
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd6532dbd7bso17162a12.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 08:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793113454; cv=none;
 d=google.com; s=arc-20260327;
 b=pXQclBC8cA3zXK0iiydiDTJu/3Yrl3x7j+SUHKBVUtM+75om+eEd6Frc3houItgl7G
 b9UdbS/S51Px2/slRiOxpPcfl8eH7SO668IvLEFBHlahzcIV7AAdMv733/c44tS/2/7R
 vAXSphz63HTKIp2dXcuS7cazQdNUeRAGsuKv6Mtew2DYs3rK03XDQqpJ8ZIK1Ln4E07E
 DXADn9YGWxXWake2m5AelLdcHAxiCWhGLoIOvJnh2mERUdvSdec87HIREjSQRU8FOp9H
 W3tugsLuqQ/cAAY3I/rOr0qYi6UB5I41pWO+3rMVw+kcE9RIt006+BK5VWaLY9PIH2hv
 Sdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Cs8OZ7ZJMieaI5iZpEZmZL+ZZ7ElGT8S0fd9AruYFtc=;
 fh=lv1jp0rZoXFpgS5FCXRaUShFSVzzdgfMsu2eaYmK1a4=;
 b=UH9Wm/k5lprHcQmYiL9wArRb35piFvxWJEZJEAEQVp0H261GaBJRL4vSnl4Wo/y9qa
 2KAJh0c6NRZq/8eA+S3RCV2ItJy8QTSCch+fou6vjiLjLMlbjoBC01kdfkYVY9ImPzyC
 rgCXKOAcbBMCkEPC3Hp7gEx/ncp3MkwlW+0vd+twSTQ7KEI94W+LH7qmG0ZKo0MWPbj9
 2M9g5ddk9bljpA03OB/92KAqGsuGm4dQK8W1yDoRJlp67JtTDPOUb0c6AeA3+gwyHR8+
 lhGX0wNucQfKQvh8ycLMi3kCfpzCn6B/I6kWP5P08BGRUbg81r+wiH9CgHANvt9b5wx4
 Q98A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793113454; x=1793718254; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Cs8OZ7ZJMieaI5iZpEZmZL+ZZ7ElGT8S0fd9AruYFtc=;
 b=e1hqIa5Bi4YVyDr6sT6uXCjiXde2AeDr1eW4vxHSQHoh2LQ02FjzCSIvw9Rr+5ndUg
 KsP2Ze4Z8NtcqPN3UyMbkl6uQpj6TTMIllc5qLJ62FMFk90CR6YopXqGJxuEKlBcrlyY
 A+xqJIrfg8dzYu5liDgJaRe4aXewAh6Tza0sf/4gYJm9zhZDYMhDvM/eeQnix1ZxN5IA
 oZDb9I2Vc7R4ZAMdxYKd/MZrq9HROsFNs0wWKv6T/KWqXiyznnkbtNhSMkdQRU5JgCdp
 DxOoi6sLkGpqiKlbDGeZSG0fGyvEJaYC60MifY4m59A9BCeU8f9UxPLEQD/8jDic9YGo
 9PRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793113454; x=1793718254;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cs8OZ7ZJMieaI5iZpEZmZL+ZZ7ElGT8S0fd9AruYFtc=;
 b=rohZsF5OfeZg56GjJ339bif8Matez7eEZfOWMmxORR2ECdvsPsMM2CWrTVR6OrIb2u
 sDg5eDNIb71wMT2vV9S3DgRJ9knhQAujIkyHr21hcpyRR/I9+t4tMnA5twRdv3wBZX8h
 H63tZgvwvDGYOmHtSvDbNTArkHFHeOMhCgFGh7t1dNNSeEnd/kcjdjbBbi5mnQaEa0m5
 SeiuhqbrlBgaG6tF6f1KGWU6MSR97t094JSp2RcmmTK1smufi7tCHghSZX6uHwGU2izD
 C0B2dxceEzxyug2OVWr+OLXVdGVyfOXPZCx53jUbdtZiggav7O6933nX0kr0GHGG4NPe
 I3xg==
X-Gm-Message-State: AFq9FYIce4IuEw0VFe/xUoEeacyh/HL96synOeKbMw22wjwKf01LZSqD
 looy4LXGkHN7OSCAIddjSQQA9I4lM0Y+iK5XZ0pzMH+bA2axLre2cx/J++nIV7NJj+r6XOb5ECq
 5utwTaPMJm70+UbA8/HrXNo+1vQOZrN572FSDjhtsxrU0rC2WWJrY4JlQMXCJ50zamyioNJLam0
 +CWcUoEch1ScqRB/xnfCQPxgomLeUcyxE=
X-Gm-Gg: AYBFou2/1rTnZd6Cf67Klx/iSF/suGGXoen5NH8X7UD66fk5VCFv8/kdfJIpxeIiiew
 n+y7Ap8AxaTH+QLwyGCblC6wum/F3vvf6OY65PGJw9SNDqTq4GXOo2iC6UvEJeXuiajGZxcajWL
 NQJNbuwl/ydlrN89/D+3N1gjTAETGWmlv1ocpG0o2LhprRaMOoaojBsCHk802S4jo07gtYB4rKq
 qJ7iJfT4MlbZkSv8tsvdGsNjV1nSpAamzBVZiYeBPd7fkVh5QL6odlaWvpLNWhQHw4sBcn6Bq1U
 6g==
X-Received: by 2002:a17:90b:4d8c:b0:3ab:e588:c295 with SMTP id
 98e67ed59e1d1-3adead4fb47mr7895404a91.42.1793113452627; 
 Tue, 27 Oct 2026 08:04:12 -0700 (PDT)
X-Received: by 2002:a17:90b:4d8c:b0:3ab:e588:c295 with SMTP id
 98e67ed59e1d1-3adead4fb47mr7895367a91.42.1793113451965; Tue, 27 Oct 2026
 08:04:11 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027133049.2522944-2-marcandre.lureau@redhat.com>
 <CAPMcbCr=gsBr9Wnw1rK+4HEcTwdCxOinKqeC=0yE1ZUa-hwHWw@mail.gmail.com>
 <CAJ+F1CLHzMuGW_m9kkU2r3YW-Vv1eQAYQ3YkJSfKm_QsoZbQWQ@mail.gmail.com>
 <CAPMcbCqG9sEHaeEeiPV7TnN4fVbKdKsUCXTXvejdArPjXEkzRg@mail.gmail.com>
In-Reply-To: <CAPMcbCqG9sEHaeEeiPV7TnN4fVbKdKsUCXTXvejdArPjXEkzRg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Oct 2026 19:04:00 +0400
X-Gm-Features: AclHuK9xl2hTAi7UlCnq0IhhM8CGrOGrCiZp0db1gIHej59dbt9mO6WffFrDVMg
Message-ID: <CAMxuvazUb78qP6X8YV13+8ggYpgdFu3=7OnDiwN3De+Xcd7jNg@mail.gmail.com>
Subject: Re: [PATCH] qga/vss: fix provider handling of snapshots
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, gillian.anton@cohesity.com, qemu-stable@nongnu.org, 
 Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Tue, Oct 27, 2026 at 6:56=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redhat=
.com> wrote:
>
>
>
>
> On Tue, Oct 27, 2026 at 4:02=E2=80=AFPM Marc-Andr=C3=A9 Lureau <marcandre=
.lureau@redhat.com> wrote:
>>
>> Hi
>>
>> On Tue, Oct 27, 2026 at 5:54=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@red=
hat.com> wrote:
>> >
>> >
>> >
>> > On Tue, Oct 27, 2026 at 3:31=E2=80=AFPM <marcandre.lureau@redhat.com> =
wrote:
>> >>
>> >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >>
>> >> Since commit 374f4676788c, the provider's GetSnapshotProperties()
>> >> returns S_OK for any snapshot ID without filling in the properties.  =
VSS
>> >> consults every registered provider when a requester looks up a snapsh=
ot,
>> >> so lookups of snapshots owned by other providers now succeed with an
>> >> all-zero VSS_SNAPSHOT_PROP. Backup software relying on it fails, e.g.
>> >> Veeam: "Original volume name is not specified for the shadow (shadow
>> >> volume id: '{00000000-0000-0000-0000-000000000000}')".
>> >>
>> >> Simply reverting is not an option: 374f4676788c switched to S_OK beca=
use
>> >> returning VSS_E_OBJECT_NOT_FOUND unconditionally broke qemu-ga's own
>> >> snapshot sets. The provider must answer for its own snapshots only. I=
t
>> >> does not create real shadow copies, but it does take part in the
>> >> snapshot set during qemu-ga fsfreeze cycles. Remember the snapshot ID=
s
>> >> received in BeginPrepareSnapshot(), return their
>> >> (minimal) properties, and return VSS_E_OBJECT_NOT_FOUND for anything
>> >> else.
>> >>
>> >> Entries are dropped when VSS deletes the snapshots or the set, or whe=
n
>> >> the set is aborted (AbortSnapshots()).
>> >>
>> >> COM+ may hand out several CQGAVssProvider instances (and serve severa=
l
>> >> client processes), so this registry is module-global. It is per-proce=
ss
>> >> by design and safe because the COM+ application is hosted by a single=
 NT
>> >> service (see CreateServiceForApplication() in install.cpp): COM+ forb=
ids
>> >> pooling and recycling for service-hosted applications, so exactly one
>> >> surrogate process ever hosts the provider.
>> >>
>> >> On the requester side, the snapshot set is created in the persistent
>> >> VSS_CTX_APP_ROLLBACK context, so VSS keeps it after the freeze/thaw
>> >> cycle and may keep querying providers about it. The provider registry
>> >> does not outlive the cycle (requester_thaw() stops the hosting servic=
e,
>> >> and the provider process with it), so later queries would get "not
>> >> found" for a set VSS still believes exists. Make requester_thaw() del=
ete
>> >> the snapshot set explicitly at the end of the cycle, whatever its
>> >> outcome (including BackupComplete() failure and aborted snapshot sets=
).
>> >> A failure to delete is only logged, since the guest filesystems have
>> >> already been thawed.
>> >>
>> >> Cc: qemu-stable@nongnu.org
>> >> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4584
>> >> Buglink: https://redhat.atlassian.net/browse/RHEL-250662
>> >> Fixes: 374f4676788c ("qga: Fix VSS provider GetSnapshotProperties ret=
urn value")
>> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >> ---
>> >>  qga/vss-win32/install.cpp   |   1 +
>> >>  qga/vss-win32/provider.cpp  | 153 ++++++++++++++++++++++++++++++++++=
+-
>> >>  qga/vss-win32/requester.cpp |  26 ++++++
>> >>  3 files changed, 179 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
>> >> index 09d94edd4f53..3b58dc840520 100644
>> >> --- a/qga/vss-win32/install.cpp
>> >> +++ b/qga/vss-win32/install.cpp
>> >> @@ -331,6 +331,7 @@ STDAPI COMRegister(void)
>> >>      chk(put_Value(pObj, L"Authentication",                 short(6))=
);
>> >>      chk(put_Value(pObj, L"AuthenticationCapability",       short(2))=
);
>> >>      chk(put_Value(pObj, L"ImpersonationLevel",             short(2))=
);
>> >> +    /* NT-service-hosted apps have ConcurrentApps=3D1 enforced */
>> >>      chk(pApps->SaveChanges(&n));
>> >>
>> >>      /* The app should be deleted if something fails after SaveChange=
s */
>> >> diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
>> >> index 1c8eb236e57f..ad2f3ee763e6 100644
>> >> --- a/qga/vss-win32/provider.cpp
>> >> +++ b/qga/vss-win32/provider.cpp
>> >> @@ -11,6 +11,11 @@
>> >>   */
>> >>
>> >>  #include "qemu/osdep.h"
>> >> +
>> >> +#include <vector>
>> >> +#include <algorithm>
>> >> +#include <string>
>> >> +
>> >>  #include "vss-common.h"
>> >>  #include "vss-debug.h"
>> >>  #ifdef HAVE_VSS_SDK
>> >> @@ -138,6 +143,123 @@ STDMETHODIMP CQGAVSSEnumObject::Clone(IVssEnumO=
bject **ppenum)
>> >>      return E_NOTIMPL;
>> >>  }
>> >>
>> >> +/* Registry of the snapshot IDs for this provider */
>> >> +class QGAVssSnapshotRegistry
>> >> +{
>> >> +public:
>> >> +    bool Track(VSS_ID set_id, VSS_ID snapshot_id,
>> >> +               VSS_PWSZ volume_name, LONG context);
>> >> +    HRESULT GetProperties(VSS_ID snapshot_id, VSS_SNAPSHOT_PROP *pro=
p) const;
>> >> +    LONG RemoveSet(VSS_ID set_id); /* returns how many were removed =
*/
>> >> +    bool Remove(VSS_ID snapshot_id);
>> >> +
>> >> +private:
>> >> +    struct Entry {
>> >> +        VSS_ID set_id;
>> >> +        VSS_ID snapshot_id;
>> >> +        std::wstring volume_name;
>> >> +        LONG context;
>> >> +    };
>> >> +
>> >> +    std::vector<Entry> m_entries;
>> >> +    mutable SRWLOCK m_lock =3D SRWLOCK_INIT;
>> >> +};
>> >> +
>> >> +static QGAVssSnapshotRegistry qga_vss_registry;
>> >> +
>> >> +bool QGAVssSnapshotRegistry::Track(VSS_ID set_id, VSS_ID snapshot_id=
,
>> >> +                                   VSS_PWSZ volume_name, LONG contex=
t)
>> >> +{
>> >> +    bool ok;
>> >> +
>> >> +    AcquireSRWLockExclusive(&m_lock);
>> >> +    try {
>> >> +        m_entries.push_back(Entry { set_id, snapshot_id, volume_name=
,
>> >> +                                    context });
>> >> +        ok =3D true;
>> >> +    } catch (...) {
>> >> +        ok =3D false;
>> >> +    }
>> >> +    ReleaseSRWLockExclusive(&m_lock);
>> >> +    return ok;
>> >> +}
>> >> +
>> >> +HRESULT QGAVssSnapshotRegistry::GetProperties(VSS_ID snapshot_id,
>> >> +                                              VSS_SNAPSHOT_PROP *pro=
p) const
>> >> +{
>> >> +    HRESULT hr =3D S_OK;
>> >> +
>> >> +    AcquireSRWLockShared(&m_lock);
>> >> +    auto it =3D std::find_if(m_entries.begin(), m_entries.end(),
>> >> +        [&](const Entry &e) {
>> >> +            return IsEqualGUID(e.snapshot_id, snapshot_id);
>> >> +        });
>> >> +    if (it =3D=3D m_entries.end()) {
>> >> +        hr =3D VSS_E_OBJECT_NOT_FOUND;
>> >> +        goto out;
>> >> +    }
>> >> +
>> >> +    {
>> >> +        const Entry &e =3D *it;
>> >> +        size_t len =3D (e.volume_name.size() + 1) * sizeof(WCHAR);
>> >> +        VSS_PWSZ volume =3D (VSS_PWSZ)CoTaskMemAlloc(len);
>> >
>> >
>> > I'm afraid of this part. We allocate memory but don't call CoTaskMemFr=
ee.
>> > This function is called from IVssBackupComponents::GetSnapshotProperti=
es
>> > From https://learn.microsoft.com/en-us/windows/win32/api/vsbackup/nf-v=
sbackup-ivssbackupcomponents-getsnapshotproperties
>> > "When the structure is no longer needed, the software provider is resp=
onsible for freeing these strings by calling the VssFreeSnapshotProperties =
function."
>> >
>> > So we allocate memory but don't free it with VssFreeSnapshotProperties=
 or CoTaskMemFree.
>>
>> I also wondered, but this is apparently what is expected:
>>
>> https://github.com/MicrosoftDocs/sdk-api/blob/docs/sdk-api-src/content/v=
ss/ns-vss-vss_object_prop.md
>>
>>
>> A requester obtains VSS_OBJECT_PROP structures by using
>> IVssEnumObject::Next to iterate over the list of objects returned by a
>> call to IVssBackupComponents::Query.
>>
> Yes, but there is nothing about cleaning memory
>
>
>>
>> As its members are filled by a COM interface, prior to deleting the
>> property structures VSS_SNAPSHOT_PROP and VSS_PROVIDER_PROP, the
>> memory they contain must be released by calling CoTaskMemFree for
>> every string and byte array value contained in each structure.
>>
>> In the case of VSS_SNAPSHOT_PROP, this can be done manually, or the
>> utility function VssFreeSnapshotProperties can be used.
>>
> but we don't store the pointers

I don't follow you.

https://learn.microsoft.com/en-us/windows/win32/api/vsprov/nf-vsprov-ivssso=
ftwaresnapshotprovider-getsnapshotproperties

"All members are required except m_pwszExposedName and
m_pwszExposedPath, which the provider can set to NULL. The provider
allocates memory for all string members that it sets in the structure.
When the structure is no longer needed, the caller is responsible for
freeing these strings by calling the VssFreeSnapshotProperties
function."

So it looks like we should actually fill the other fields too

>
>>
>>
>> >
>> >> +
>> >> +        if (!volume) {
>> >> +            hr =3D E_OUTOFMEMORY;
>> >> +            goto out;
>> >> +        }
>> >> +        memcpy(volume, e.volume_name.c_str(), len);
>> >> +
>> >> +        /* not a real snapshot: no device object, exposure or timest=
amp */
>> >> +        memset(prop, 0, sizeof(*prop));
>> >> +        prop->m_SnapshotId =3D e.snapshot_id;
>> >> +        prop->m_SnapshotSetId =3D e.set_id;
>> >> +        prop->m_lSnapshotsCount =3D std::count_if(m_entries.begin(),
>> >> +            m_entries.end(), [&](const Entry &o) {
>> >> +                return IsEqualGUID(o.set_id, e.set_id);
>> >> +            });
>> >> +        prop->m_pwszOriginalVolumeName =3D volume;
>> >> +        prop->m_ProviderId =3D g_gProviderId;
>> >> +        prop->m_lSnapshotAttributes =3D e.context;
>> >> +        prop->m_eStatus =3D VSS_SS_CREATED;
>> >> +    }
>> >> +
>> >> +out:
>> >> +    ReleaseSRWLockShared(&m_lock);
>> >> +    return hr;
>> >> +}
>> >> +
>> >> +LONG QGAVssSnapshotRegistry::RemoveSet(VSS_ID set_id)
>> >> +{
>> >> +    LONG removed;
>> >> +
>> >> +    AcquireSRWLockExclusive(&m_lock);
>> >> +    auto it =3D std::remove_if(m_entries.begin(), m_entries.end(),
>> >> +        [&](const Entry &e) {
>> >> +            return IsEqualGUID(e.set_id, set_id);
>> >> +        });
>> >> +    removed =3D m_entries.end() - it;
>> >> +    m_entries.erase(it, m_entries.end());
>> >> +    ReleaseSRWLockExclusive(&m_lock);
>> >> +    return removed;
>> >> +}
>> >> +
>> >> +bool QGAVssSnapshotRegistry::Remove(VSS_ID snapshot_id)
>> >> +{
>> >> +    bool found;
>> >> +
>> >> +    AcquireSRWLockExclusive(&m_lock);
>> >> +    auto it =3D std::find_if(m_entries.begin(), m_entries.end(),
>> >> +        [&](const Entry &e) {
>> >> +            return IsEqualGUID(e.snapshot_id, snapshot_id);
>> >> +        });
>> >> +    found =3D it !=3D m_entries.end();
>> >> +    if (found) {
>> >> +        m_entries.erase(it);
>> >> +    }
>> >> +    ReleaseSRWLockExclusive(&m_lock);
>> >> +    return found;
>> >> +}
>> >>
>> >>  /* QGAVssProvider */
>> >>
>> >> @@ -266,7 +388,7 @@ STDMETHODIMP CQGAVssProvider::SetContext(LONG lCo=
ntext)
>> >>  STDMETHODIMP CQGAVssProvider::GetSnapshotProperties(
>> >>      VSS_ID SnapshotId, VSS_SNAPSHOT_PROP *pProp)
>> >>  {
>> >> -    return S_OK;
>> >> +    return qga_vss_registry.GetProperties(SnapshotId, pProp);
>> >>  }
>> >>
>> >>  STDMETHODIMP CQGAVssProvider::Query(
>> >> @@ -286,6 +408,27 @@ STDMETHODIMP CQGAVssProvider::DeleteSnapshots(
>> >>      VSS_ID SourceObjectId, VSS_OBJECT_TYPE eSourceObjectType,
>> >>      BOOL bForceDelete, LONG *plDeletedSnapshots, VSS_ID *pNondeleted=
SnapshotID)
>> >>  {
>> >> +    LONG deleted =3D 0;
>> >> +
>> >> +    switch (eSourceObjectType) {
>> >> +    case VSS_OBJECT_SNAPSHOT:
>> >> +        if (qga_vss_registry.Remove(SourceObjectId)) {
>> >> +            deleted =3D 1;
>> >> +        }
>> >> +        break;
>> >> +    case VSS_OBJECT_SNAPSHOT_SET:
>> >> +        deleted =3D qga_vss_registry.RemoveSet(SourceObjectId);
>> >> +        break;
>> >> +    default:
>> >> +        break;
>> >> +    }
>> >> +
>> >> +    if (deleted > 0) {
>> >> +        *plDeletedSnapshots =3D deleted;
>> >> +        *pNondeletedSnapshotID =3D GUID_NULL;
>> >> +        return S_OK;
>> >> +    }
>> >> +
>> >>      *plDeletedSnapshots =3D 0;
>> >>      *pNondeletedSnapshotID =3D SourceObjectId;
>> >>      return S_OK;
>> >> @@ -295,6 +438,13 @@ STDMETHODIMP CQGAVssProvider::BeginPrepareSnapsh=
ot(
>> >>      VSS_ID SnapshotSetId, VSS_ID SnapshotId,
>> >>      VSS_PWSZ pwszVolumeName, LONG lNewContext)
>> >>  {
>> >> +    if (!pwszVolumeName) {
>> >> +        return E_INVALIDARG;
>> >> +    }
>> >> +    if (!qga_vss_registry.Track(SnapshotSetId, SnapshotId,
>> >> +                                pwszVolumeName, lNewContext)) {
>> >> +        return E_OUTOFMEMORY;
>> >> +    }
>> >>      return S_OK;
>> >>  }
>> >>
>> >> @@ -411,6 +561,7 @@ STDMETHODIMP CQGAVssProvider::PostFinalCommitSnap=
shots(VSS_ID SnapshotSetId)
>> >>
>> >>  STDMETHODIMP CQGAVssProvider::AbortSnapshots(VSS_ID SnapshotSetId)
>> >>  {
>> >> +    qga_vss_registry.RemoveSet(SnapshotSetId);
>> >>      return S_OK;
>> >>  }
>> >>
>> >> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cp=
p
>> >> index 1b0155c691ef..565eefcfb283 100644
>> >> --- a/qga/vss-win32/requester.cpp
>> >> +++ b/qga/vss-win32/requester.cpp
>> >> @@ -52,6 +52,7 @@ static t_VssFreeSnapshotProperties pVssFreeSnapshot=
Properties;
>> >>  static struct QGAVSSContext {
>> >>      IVssBackupComponents *pVssbc;  /* VSS requester interface */
>> >>      IVssAsync *pAsyncSnapshot;     /* async info of VSS snapshot ope=
ration */
>> >> +    VSS_ID idSnapshotSet;          /* snapshot set created for this =
cycle */
>> >>      HANDLE hEventFrozen;           /* notify fs/writer freeze from p=
rovider */
>> >>      HANDLE hEventThaw;             /* request provider to thaw */
>> >>      HANDLE hEventTimeout;          /* notify timeout in provider */
>> >> @@ -116,6 +117,7 @@ static void requester_cleanup(void)
>> >>          vss_ctx.pVssbc->Release();
>> >>          vss_ctx.pVssbc =3D NULL;
>> >>      }
>> >> +    vss_ctx.idSnapshotSet =3D GUID_NULL;
>> >>      vss_ctx.cFrozenVols =3D 0;
>> >>      qga_debug_end;
>> >>  }
>> >> @@ -446,6 +448,7 @@ void requester_freeze(int *num_vols, void *mountp=
oints, ErrorSet *errset)
>> >>          err_set(errset, hr, "failed to start snapshot set");
>> >>          goto out;
>> >>      }
>> >> +    vss_ctx.idSnapshotSet =3D guidSnapshotSet;
>> >>
>> >>      if (mountpoints) {
>> >>          PWCHAR volume_name_wchar;
>> >> @@ -680,6 +683,29 @@ void requester_thaw(int *num_vols, void *mountpi=
nts, ErrorSet *errset)
>> >>          err_set(errset, hr, "failed to do snapshot set");
>> >>      }
>> >>
>> >> +    /*
>> >> +     * The snapshot set is created in VSS_CTX_APP_ROLLBACK context, =
so
>> >> +     * it is persistent: if it was committed, VSS keeps it (and keep=
s
>> >> +     * querying providers about it) until it is explicitly deleted. =
The
>> >> +     * freeze/thaw cycle is over whatever the outcome above, so dele=
te
>> >> +     * it now. Failure is not fatal here, only log it.
>> >> +     */
>> >> +    {
>> >> +        LONG lDeletedSnapshots =3D 0;
>> >> +        VSS_ID idNonDeletedSnapshot;
>> >> +        HRESULT hrDelete;
>> >> +
>> >> +        hrDelete =3D vss_ctx.pVssbc->DeleteSnapshots(vss_ctx.idSnaps=
hotSet,
>> >> +                                                   VSS_OBJECT_SNAPSH=
OT_SET,
>> >> +                                                   TRUE,
>> >> +                                                   &lDeletedSnapshot=
s,
>> >> +                                                   &idNonDeletedSnap=
shot);
>> >> +        if (FAILED(hrDelete)) {
>> >> +            qga_debug("failed to delete snapshot set after thaw,"
>> >> +                      " hr=3D0x%08lx", hrDelete);
>> >> +        }
>> >> +    }
>> >> +
>> >>      if (err_is_set(errset)) {
>> >>          vss_ctx.pVssbc->AbortBackup();
>> >>      }
>> >> --
>> >> 2.56.0.116.g6de20f6092dc
>> >>
>>


