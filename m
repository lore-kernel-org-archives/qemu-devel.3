Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F21C55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 07:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrsYM-0007Hd-3i; Thu, 06 Aug 2026 03:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wrsYK-0007HM-3k
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 03:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wrsYH-0000MT-FZ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 03:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786001403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QNejaSIWBZNfTuOHttAiP26fu4xugauwvIKyS0NtTCM=;
 b=Ur8h0zzZDUoBYPytI6td7dMW48FxM57f42dVtfV+6Gdlmo/TPRCzA5jqWCtCyf9FuwANmz
 h1uMvrd0WWME1I5g2OqQ8ehIfF6m3IpgZGFInd8NVjrQ7ckKKC7gMeZ1oi7XIijSFPRJl/
 UFIJD3/fvaNlmwLuOv1Y75X4eZoiOCE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-SrtazKVuM7q8xOSRlkuJmg-1; Thu, 06 Aug 2026 03:30:02 -0400
X-MC-Unique: SrtazKVuM7q8xOSRlkuJmg-1
X-Mimecast-MFC-AGG-ID: SrtazKVuM7q8xOSRlkuJmg_1786001401
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e5a616d07so1969475a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 00:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786001401; x=1786606201; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QNejaSIWBZNfTuOHttAiP26fu4xugauwvIKyS0NtTCM=;
 b=G1LhwGgk9OYkf+yzVTyi7eYRh9NhpVxJBIKXkPdEJ1sYEeU7Y7VTBVo9Ktz11hi+gS
 6iPZUM1Yr23kANNzkOW7qD69+6RcQjXnpiw9q292mwQlLEDIvpxVydijwirCQCf07vwu
 /c+VcGEIS2qbVGlDS/R2WowbYXosjWvskk7JOeeTm/alq4Zyaz+DGA6KVgYYRVQ9YFw9
 wE76go6aGnwrZOgDGQh98chFifNrOjGQagzVayPV/a/SG4UfuLIMau75DeCt1+l/Ga8/
 j/z9cwuQteu/0Y2uvk0F5RaoSkCxjpwExUKg95gxA+Nz2XcmRysPVBGspwmspB9O75WU
 y/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786001401; x=1786606201;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QNejaSIWBZNfTuOHttAiP26fu4xugauwvIKyS0NtTCM=;
 b=edLpoRDarO6etZY0CNAL07qk9PAGQomKQUQg4UngKyDddriYpqmVDdv8ms6C34A+WH
 NIPn6+Oh2sTqDDkG09Iy/QXNMZOFuVZ1+HjX6+i2uqfk0Q+OTKdg3H76FLkwPxPS3nWj
 ZQDP0gQXmujNc0oyGpUVptKqE/Pg7+h3sDOdeFt3++kcFA4YL6nY//r45MsAW3oylNlO
 KO8rrmPCaR61UkXwAB0WrbNgHRvnGjzFqu8Hd1Gp6hOwneBjBGT5soMOoJpFMbV4QHft
 TIU1cGdD2hDLhPDOEX2/DEDPLJWDagLymFakKFL0cNWXaHTsLFbHCEB/ZatYaNOwuDVN
 pNqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrynLEWCFEU6K6aGMjvYDk0cmpjcdvvOhTgBhvFO9OKb/CqhWZNx5krvTrkw2VUMjBlqf9y4TteTsIP@nongnu.org
X-Gm-Message-State: AOJu0YxPc+y+lxo3tMBYR50RAsbh1aAa/eYR1S1f+QcgfoCjKtXvYZfa
 56EAnRilFkwCDqu3UHO+jXNdHCliGcBaw4BwNgC7D/kayZVmWoZrEJ+tPl8Vkce1mD9MDYrNWOJ
 w9iZYYPhrxXa6afmyAbGIUKdUvmuHsmsYdtw3v8b5GBa9aWmlGUc8XMJ5
X-Gm-Gg: AR+sD13uQ9qusjeh00YmHDSxytryngHj0Zga8L0rEjUIA5nuPmHVil99I63p7FkCDUQ
 89eSs2WUlHVr3WPRfIPc9pVkudJSy6jbHu3NNe12PTkJwfuF62NTZ9nf07hm8ihHoMNo+qOfOyu
 qfg+5MtlnsMbcF9HOWlkypFcVr7FOIJ5nMLWp8cnWmbnLK6R2vOyDYaZKRdzeZ08WwDB48yW4vJ
 Y9yWV229e0cLCaXyNvDajumVy9eWS9GN3uDXbCEFvPDMshKsOGlYnOk8lw/+EZRfiL9wFK1BVy5
 AMgJGW0AtVUAH8+EXQhswU0yKTwaWvaTQAG9cBW8X9N+gSMqPdAhJMdV+LOkSTh+7NiVANwgKFt
 uD2NUo7ShOPceKblHi33HXrwEhj13/Mw284nFnmL9MwiVmvTUVLqgPg==
X-Received: by 2002:a17:90b:224e:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-3903c5c443dmr10995579a91.16.1786001401107; 
 Thu, 06 Aug 2026 00:30:01 -0700 (PDT)
X-Received: by 2002:a17:90b:224e:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-3903c5c443dmr10995228a91.16.1786001395721; 
 Thu, 06 Aug 2026 00:29:55 -0700 (PDT)
Received: from smtpclient.apple ([106.219.133.98])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-140f744adb2sm6567922c88.2.2026.08.06.00.29.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Aug 2026 00:29:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v3 2/9] igvm: track memory regions
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CAK3XEhPmh0jtSK=zZ5SjBzT6c_P6J7JW2B42k5cJzOK-vyOkKg@mail.gmail.com>
Date: Thu, 6 Aug 2026 12:59:41 +0530
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Alexander Graf <graf@amazon.com>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDBE831E-F919-4E1F-802B-64D34D20634A@redhat.com>
References: <20260730071254.80695-1-anisinha@redhat.com>
 <20260730071254.80695-3-anisinha@redhat.com>
 <96ad911f-6f07-4616-b911-617dde2f12de@csgraf.de>
 <C1C5D784-4C75-4FE6-BEEA-F879C73E0D7B@redhat.com>
 <CAK3XEhPmh0jtSK=zZ5SjBzT6c_P6J7JW2B42k5cJzOK-vyOkKg@mail.gmail.com>
To: Alexander Graf <agraf@csgraf.de>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 1 Aug 2026, at 7:57=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
> On Sat, Aug 1, 2026 at 5:58=E2=80=AFPM Ani Sinha <anisinha@redhat.com> =
wrote:
>>=20
>>=20
>>=20
>>> On 31 Jul 2026, at 3:28=E2=80=AFPM, Alexander Graf <agraf@csgraf.de> =
wrote:
>>>=20
>>>=20
>>> On 30.07.26 09:12, Ani Sinha wrote:
>>>> From: Gerd Hoffmann <kraxel@redhat.com>
>>>>=20
>>>> Memory regions added by the current IGVM needs to be tracked so =
that they can be
>>>> freed when a new IGVM is loaded.
>>>>=20
>>>> Reviewed-by: Ani Sinha <anisinha@redhat.com>
>>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>>> ---
>>>> backends/igvm-cfg.c            |  1 +
>>>> backends/igvm.c                | 20 ++++++++++++--------
>>>> include/system/igvm-internal.h |  6 ++++++
>>>> 3 files changed, 19 insertions(+), 8 deletions(-)
>>>>=20
>>>> diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
>>>> index e1f09855f6..38438a7b1e 100644
>>>> --- a/backends/igvm-cfg.c
>>>> +++ b/backends/igvm-cfg.c
>>>> @@ -65,6 +65,7 @@ static void igvm_complete(UserCreatable *uc, =
Error **errp)
>>>>     IgvmCfg *igvm =3D IGVM_CFG(uc);
>>>>       igvm->file =3D qigvm_file_init(igvm->filename, errp);
>>>> +    QTAILQ_INIT(&igvm->memory_regions);
>>>> }
>>>>   OBJECT_DEFINE_TYPE_WITH_INTERFACES(IgvmCfg, igvm_cfg, IGVM_CFG, =
OBJECT,
>>>> diff --git a/backends/igvm.c b/backends/igvm.c
>>>> index 534032fed8..9e7c90d386 100644
>>>> --- a/backends/igvm.c
>>>> +++ b/backends/igvm.c
>>>> @@ -220,7 +220,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, =
uint64_t addr, uint64_t size,
>>>>                                   int region_identifier, Error =
**errp)
>>>> {
>>>>     ERRP_GUARD();
>>>> -    MemoryRegion *igvm_pages =3D NULL;
>>>> +    IgvmMemoryRegion *imr =3D NULL;
>>>>     Int128 gpa_region_size;
>>>>     MemoryRegionSection mrs =3D
>>>>         memory_region_find(get_system_memory(), addr, size);
>>>> @@ -254,23 +254,27 @@ static void *qigvm_prepare_memory(QIgvm *ctx, =
uint64_t addr, uint64_t size,
>>>>          */
>>>>         g_autofree char *region_name =3D
>>>>             g_strdup_printf("igvm.%X", region_identifier);
>>>> -        igvm_pages =3D g_new0(MemoryRegion, 1);
>>>> +        imr =3D g_new0(IgvmMemoryRegion, 1);
>>>> +        imr->mr =3D g_new0(MemoryRegion, 1);
>>>>         if (ctx->machine_state->cgs &&
>>>>             ctx->machine_state->cgs->require_guest_memfd) {
>>>> -            if (!memory_region_init_ram_guest_memfd(igvm_pages, =
NULL,
>>>> +            if (!memory_region_init_ram_guest_memfd(imr->mr, NULL,
>>>=20
>>>=20
>>> Please make sure to track them with owner set to =
OBJECT(ctx->machine_state).
>>=20
>> This will not work as the owner will have to be of TYPE_DEVICE not of =
TYPE_MACHINE.
>=20
> Looking closer, these memory regions are subregions of system_mmeory.
> system_memory is initialized with owner as NULL in memory_map_init().
>=20
> memory_region_finalize() says .,,
>=20
> Here it is possible that the MR has:
> mr->container set, which means this MR is a subregion of a
>     container MR. In this case they must share the same owner as the
>     container (otherwise the container should have kept a refcount
>     of this MR's owner).
>=20
> And then there is this assertion:
>=20
> /* Must share the owner; see above comments */
>        assert(mr->container->owner =3D=3D mr->owner);
>=20
> So i think the owner should be NULL.
>=20
> I think that means we should garbage collect system_memory and its =
sub-regions?

I looked at this deeply and I believe this change triggers the mr =
cleanup:

diff --git a/backends/igvm.c b/backends/igvm.c
index da09e6195c..44cf74dfc6 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -1124,11 +1124,9 @@ void qigvm_cleanup_memory(IgvmCfg *cfg)
         memory_region_del_subregion(get_system_memory(), imr->mr);
         vmstate_unregister_ram(imr->mr, NULL);
         QTAILQ_REMOVE(&cfg->memory_regions, imr, next);
-        /*
-         * imr->mr will be freed when all references to the memory
-         * region are dropped. Freeing it here will cause memory
-         * corruption.
-         */
+        /* this triggers MemoryRegion cleanup */
+        object_unparent(OBJECT(imr->mr));
+        imr->mr =3D NULL;
         g_free(imr);
     }
 }


Using added tracing, I see the following in the log:

$ grep igvm /tmp/qemu-debug.log=20
qigvm_cleanup_memory freeing mr igvm.23B
memory_region_finalize mr name igvm.23B
qigvm_cleanup_memory freeing mr igvm.23B
memory_region_finalize mr name igvm.23B


So the mr which is cleaned up in qigvm_cleanup_memory() is actually =
freed and there is no memory leak.

The cleanup triggered by object_unparent() has the following call chain =
as seen in debugger:

#0  memory_region_finalize (obj=3D0x55ef77ebbc30) at =
/workspace/qemu-ani/include/system/memory.h:41
#1  0x000055ef6b195261 in object_deinit (obj=3D<optimized out>, =
type=3D<optimized out>) at ../qom/object.c:655
#2  object_finalize (data=3D0x55ef77ebbc30) at ../qom/object.c:669
#3  object_unref (objptr=3D0x55ef77ebbc30) at ../qom/object.c:1324
#4  0x000055ef6b19385a in object_property_del_child (obj=3D0x55ef774fb900,=
 child=3D0x55ef77ebbc30) at ../qom/object.c:629
#5  0x000055ef6b1944d1 in object_unparent (obj=3D<optimized out>) at =
../qom/object.c:648
#6  0x000055ef6ad46c0e in qigvm_cleanup_memory =
(cfg=3Dcfg@entry=3D0x55ef77506d80) at ../backends/igvm.c:1128
#7  0x000055ef6ad44c2b in igvm_reset_hold (obj=3D<optimized out>, =
type=3DRESET_TYPE_COLD) at ../backends/igvm-cfg.c:56

(gdb) n
memory_region_finalize (obj=3D<optimized out>) at =
../system/memory.c:1733
1733        trace_memory_region_finalize(mr->name);
(gdb) p mr->name
$1 =3D 0x55ef7766dfa0 "igvm.23B"
(gdb)



>=20
>>> Without owner, reference counting is disabled and we end up leaking =
memory regions on cleanup you introduce in patch 3 later.
>>>=20
>>>=20
>>> Alex



