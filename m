Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9F4C55173
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 14:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqAgT-0002lO-T7; Sat, 01 Aug 2026 10:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wqAgR-0002lA-W6
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 10:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wqAgQ-00007N-ED
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 10:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785594445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AEDiss7v5hywQsRiV7e+mny86DFU9oKZ3mJyY4+Dhj4=;
 b=Sb39Tf4ihSCL0qyepY1j9WQ7OEEmztSt0ptPvUFEtctrnj5YZ5Cks+6ZCdT0YiyKAVum5U
 n64UaCL5Shf1AFl9Czq2P/wyEHnd/tFwdiR0Pzh5I0dZdvT++z5ddvW/c386ItIaGiNoNE
 dBmAC40Tl+/dudzv6CwFnZQ0TWhpkeg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-oY8rV8X6Mfu8h3Jic6kZ2Q-1; Sat, 01 Aug 2026 10:27:23 -0400
X-MC-Unique: oY8rV8X6Mfu8h3Jic6kZ2Q-1
X-Mimecast-MFC-AGG-ID: oY8rV8X6Mfu8h3Jic6kZ2Q_1785594443
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso21123781cf.0
 for <qemu-devel@nongnu.org>; Sat, 01 Aug 2026 07:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785594443; cv=none;
 d=google.com; s=arc-20260327;
 b=rZ9Aa31/wBEycrNo8XTrdrKUfuP0U0PWkzlQjdiu+UnH6P6Xi/3MgAHLQlt2AaaWle
 uW6lw2xC8QotjCqbIZ5bC5TliEJVHfT1cBVTKTaMkIfVhTD7n51lY5ucNQi4nWsqZf2x
 yNk4D5sql7f4D9hbp22pEuqaiXFoTkz+zLohcJ5hqk4ELwYANcllYA4X7rZKCqD1luFn
 fPbsGaiIJWmcbRRQkDrbROlntV3VGdM6JRZAPFPtgfsifjQ0g47ObU9zvSYVQM9tbR77
 YGUskCRb2hriehXFTi9XJnUSlT681GqZr/QR9nqXFHs0VPnTEZ4cbUUIY6EVKlrPWz/1
 K1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AEDiss7v5hywQsRiV7e+mny86DFU9oKZ3mJyY4+Dhj4=;
 fh=/vFPt1WOqDtGnuZ1zNtjTxFRrwWEWJEPy1Tq6oWgiw8=;
 b=IumrBXBGrOT8FsfHJvjExC6kgJ6c83lxdGLjpOEUqalWAAKMGJY0htuKhvWltM3Igp
 3aCGt/0f2Zv0VR26qnux+UDu5xJqp0a6OVPQX47+i68SqNHCCYP5MtRZp9p/n6mhvd0q
 XZUT6nqX2YUhikDGf8WrvWDQBwpqSeHvF7au3T0SlXf2DJrKFvN5igIqB2rOfeS5lORl
 m+pMTt2WWAOAMlItM3mD3PtCiTKM37Wxdu82UsSPiOU44piWPbIW9RF+nj2gY6VHMJaf
 akZjJN2sAJ5YlfSKtQChyFvMGUtNfsqYU/gwkcfZCQ4TYbC86C1vTCRr5OKVrOZwenMn
 oxDg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785594443; x=1786199243; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AEDiss7v5hywQsRiV7e+mny86DFU9oKZ3mJyY4+Dhj4=;
 b=CXCskKKr3EZCv2rz7HQjE8XfZbaeTx/c7jOZDFuKYEzxMFgDDfd06fgDarzHiEa7re
 t5ecF2+iw7V58KvfAo9WkfDb/TMEyJbgfK+3r3DcxT75C/RaoUaGUpAKjYVUvJHRerHe
 bzXGDLnbfwzI5m+ScBpIayAocCRKcwzezuy/A4gnzNgzUMmxvcTXbBymydly/mYJVWUK
 sElnu8R/zsq6TE7SHDjY2P8L+Jt3oQcSVAFw9QFMgoCGu1zL0S7WxAc4puFStjih+rll
 8m1tGqdlLtvJUT5S4oBs7BgAlsbLEvi7oIoFPiu63Ai0wEp50r/DvWnDN4+s0dfQV8iU
 5m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785594443; x=1786199243;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AEDiss7v5hywQsRiV7e+mny86DFU9oKZ3mJyY4+Dhj4=;
 b=IZKU9cEIDVfZncKcpRKmHVozUqH0ApFcvd4YfFXNRb+yxndRS6iepnKU2H4KSH8F9d
 4yBrFktQYdK9yYGhLSbZ9+k+lKAQI+iIyfhFCOs1FNSeNGOEdj2gTErhXfYqFdE0RhE9
 m4NEpslgojXJwDe2dKV78hGsaz2+Yl36lnIJl3pckK8qBj12tgIWmQ+zeAMkUQB4Tik4
 JecWi2ov8Atp7eT028tNITCmxbQ/hZ1crGf5099uf3sHcenUu+ptSIYPMDCl4DzXzJX/
 aNbM8Fcuy8Z1H5WhrK9AFYvvU6b0MXzykKE+Z/RUmRgo69o2BhEuB9HHyJHrA81KOHOF
 rm0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoWhh9kND/i8kxab+2C+Kkos0J+XFv5nLAwC3E6rZSDydqyEKQ866kYw6bDIEa24kk5Wgy83POw81Tb@nongnu.org
X-Gm-Message-State: AOJu0YxbpYnK5T+eJlOpmHwjgICmwqcyMEu+QGpkMV938MfV/FEf4n+J
 hcIwQEcjILfJdcRPVZUbhz5/lFnei/JkL/Arkc4Q7F241iIGr193p/YsosqIKlODiJ+AIK3BEYa
 qmz3akkcvhth5uUsTuCMVaUWgDNmihDrDc5PMC9Dk5ABMGhRTAD6BKt4swkb9vBvH2TlnS18Zkb
 4hIg1y3lrY0z6emvXYxJxT75cHGhmfUYI=
X-Gm-Gg: AR+sD10Jq6rvf223njiXN/HL7dHhOFoJICA8kbNkL2CQhvNnn0BfbIeKBAbAkHabjk6
 vWFG3H8dQtmKCt11SpeDTnXAvXWAG2ib4lrukIuQrVn1mBej0bS1Fp+FbnqJpK6di4/thqes/Ao
 +Wm+7Hhy5/Xe8uAI0MnMyoEWY+Ns/msxA3s5O64M9d6Y4VM4nEAc+eIXmoRkE4TryenYvEWnOMf
 NUwJ/0GOl8NXCVc/yQ=
X-Received: by 2002:ac8:5cc6:0:b0:51c:b6d:740b with SMTP id
 d75a77b69052e-52b56796939mr81392671cf.34.1785594443066; 
 Sat, 01 Aug 2026 07:27:23 -0700 (PDT)
X-Received: by 2002:ac8:5cc6:0:b0:51c:b6d:740b with SMTP id
 d75a77b69052e-52b56796939mr81392241cf.34.1785594442645; Sat, 01 Aug 2026
 07:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260730071254.80695-1-anisinha@redhat.com>
 <20260730071254.80695-3-anisinha@redhat.com>
 <96ad911f-6f07-4616-b911-617dde2f12de@csgraf.de>
 <C1C5D784-4C75-4FE6-BEEA-F879C73E0D7B@redhat.com>
In-Reply-To: <C1C5D784-4C75-4FE6-BEEA-F879C73E0D7B@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Sat, 1 Aug 2026 19:57:11 +0530
X-Gm-Features: AUfX_mzMK5oC_-_AdkEdo8GSvdOWF_kEiDdBnHjdH5QwewGtaN-429-Noz7PEnA
Message-ID: <CAK3XEhPmh0jtSK=zZ5SjBzT6c_P6J7JW2B42k5cJzOK-vyOkKg@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] igvm: track memory regions
To: Alexander Graf <agraf@csgraf.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Alexander Graf <graf@amazon.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Sat, Aug 1, 2026 at 5:58=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wrot=
e:
>
>
>
> > On 31 Jul 2026, at 3:28=E2=80=AFPM, Alexander Graf <agraf@csgraf.de> wr=
ote:
> >
> >
> > On 30.07.26 09:12, Ani Sinha wrote:
> >> From: Gerd Hoffmann <kraxel@redhat.com>
> >>
> >> Memory regions added by the current IGVM needs to be tracked so that t=
hey can be
> >> freed when a new IGVM is loaded.
> >>
> >> Reviewed-by: Ani Sinha <anisinha@redhat.com>
> >> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >> ---
> >>  backends/igvm-cfg.c            |  1 +
> >>  backends/igvm.c                | 20 ++++++++++++--------
> >>  include/system/igvm-internal.h |  6 ++++++
> >>  3 files changed, 19 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
> >> index e1f09855f6..38438a7b1e 100644
> >> --- a/backends/igvm-cfg.c
> >> +++ b/backends/igvm-cfg.c
> >> @@ -65,6 +65,7 @@ static void igvm_complete(UserCreatable *uc, Error *=
*errp)
> >>      IgvmCfg *igvm =3D IGVM_CFG(uc);
> >>        igvm->file =3D qigvm_file_init(igvm->filename, errp);
> >> +    QTAILQ_INIT(&igvm->memory_regions);
> >>  }
> >>    OBJECT_DEFINE_TYPE_WITH_INTERFACES(IgvmCfg, igvm_cfg, IGVM_CFG, OBJ=
ECT,
> >> diff --git a/backends/igvm.c b/backends/igvm.c
> >> index 534032fed8..9e7c90d386 100644
> >> --- a/backends/igvm.c
> >> +++ b/backends/igvm.c
> >> @@ -220,7 +220,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint=
64_t addr, uint64_t size,
> >>                                    int region_identifier, Error **errp=
)
> >>  {
> >>      ERRP_GUARD();
> >> -    MemoryRegion *igvm_pages =3D NULL;
> >> +    IgvmMemoryRegion *imr =3D NULL;
> >>      Int128 gpa_region_size;
> >>      MemoryRegionSection mrs =3D
> >>          memory_region_find(get_system_memory(), addr, size);
> >> @@ -254,23 +254,27 @@ static void *qigvm_prepare_memory(QIgvm *ctx, ui=
nt64_t addr, uint64_t size,
> >>           */
> >>          g_autofree char *region_name =3D
> >>              g_strdup_printf("igvm.%X", region_identifier);
> >> -        igvm_pages =3D g_new0(MemoryRegion, 1);
> >> +        imr =3D g_new0(IgvmMemoryRegion, 1);
> >> +        imr->mr =3D g_new0(MemoryRegion, 1);
> >>          if (ctx->machine_state->cgs &&
> >>              ctx->machine_state->cgs->require_guest_memfd) {
> >> -            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
> >> +            if (!memory_region_init_ram_guest_memfd(imr->mr, NULL,
> >
> >
> > Please make sure to track them with owner set to OBJECT(ctx->machine_st=
ate).
>
> This will not work as the owner will have to be of TYPE_DEVICE not of TYP=
E_MACHINE.

Looking closer, these memory regions are subregions of system_mmeory.
system_memory is initialized with owner as NULL in memory_map_init().

memory_region_finalize() says .,,

Here it is possible that the MR has:
mr->container set, which means this MR is a subregion of a
     container MR. In this case they must share the same owner as the
     container (otherwise the container should have kept a refcount
     of this MR's owner).

 And then there is this assertion:

/* Must share the owner; see above comments */
        assert(mr->container->owner =3D=3D mr->owner);

So i think the owner should be NULL.

I think that means we should garbage collect system_memory and its sub-regi=
ons?

> > Without owner, reference counting is disabled and we end up leaking mem=
ory regions on cleanup you introduce in patch 3 later.
> >
> >
> > Alex
>
>


