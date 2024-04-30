Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08690C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 17:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1r9n-0005r6-DM; Tue, 30 Apr 2024 13:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s1r9l-0005qW-QK
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s1r9j-0004Tl-CH
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714497638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rlf9Mz6Rgd4hHRcVKo7FIGejjXysvi4n5fo8I6S7vis=;
 b=DeCqL0wmU1cT+5MNgWbQY0eI6BnZ00nogiLRuairXbq81pgUSK6tUaQ7RVBIgJ9vNR9OHw
 bhaQ+6uMY6djYqzJYFrULvoAxjY8QUkA+r3fVDGvCg+Xb7irNWA2iNcBkt8yHFbbSV9Htj
 YzzC4XNpUAcy1lreELRjcmZOOUCETLs=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-lrrHyHCMNam2uxUT8okC5A-1; Tue, 30 Apr 2024 13:20:36 -0400
X-MC-Unique: lrrHyHCMNam2uxUT8okC5A-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dc6dbdcfd39so12476398276.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 10:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714497636; x=1715102436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rlf9Mz6Rgd4hHRcVKo7FIGejjXysvi4n5fo8I6S7vis=;
 b=VX9gKnKtcDqUUVONp3j03wvgrFsUIC5kwa223YYkSB3WUIVEnZNwQSNU2L2hTanSyR
 v0s2NPsIA+Nb4zVGbPyik23uBklqk74qHK1kY2SJ8DCN7u0PsUAJFbv5qvQcX1NqaQpA
 ZA17g87TLP+Ierbm8QCNhGrcIBt1dBrB6GrWo0NhtyZpzgk1ZfUGOacW7tQLYAMLRixS
 Gd4JqZZak33xvrGi6miOSw2S2g5Ucc0aWa5QdrR7jwlXg8M1y4ZOJNSNq22o1E+idYUA
 P/2Z9PQxQCBG+pa08ztnYj+UrdjDIeExvdxBaw5cTdbWTI/snks966eEnf+EvRSbLPXO
 TP+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5A3my2nXuGwRXSfD108HQ8WUvMWZEdCzc8O6CfZ2G9XmxtIJWthC+qzFVI5yxy5b2ZtVHrRmKQHrltOwRYQ4xEtNu8B8=
X-Gm-Message-State: AOJu0Yyy244AifT4sZ0LjJOciYLcqL0qR+lpaRGDFJxUdg41ara8/jL7
 jNQ1/KHg9ZQnaTpKR7c4/o6WLrmS1NbxvY6tgrVep/jcEX3Hjn8sMKvxaYw/fC85N/2f2922VhG
 XT13kgutBPoDUwvtZQqIx7NB8AJgbutJNSVS9P2eLUEZgS50LM2katzi8iQqdrFBcPg3hkFreWD
 UE48Wy3gVbBFNuN+NYQq+cB8eulB8=
X-Received: by 2002:a5b:50b:0:b0:de5:4b29:b733 with SMTP id
 o11-20020a5b050b000000b00de54b29b733mr239191ybp.24.1714497635957; 
 Tue, 30 Apr 2024 10:20:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXEQcDaHZQysMgXbnxmJFB70LFnSIIkx9AaQLbeWGF3jiEv2BqRZDHUboiNa0ciMxyc/RJlXIt++rj0L7FeX4=
X-Received: by 2002:a5b:50b:0:b0:de5:4b29:b733 with SMTP id
 o11-20020a5b050b000000b00de54b29b733mr239173ybp.24.1714497635622; Tue, 30 Apr
 2024 10:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240410100345.389462-1-eperezma@redhat.com>
 <20240410100345.389462-2-eperezma@redhat.com>
 <558124df-be44-47ae-85b9-0f282fc3889c@oracle.com>
 <CAJaqyWeE3kfgN5Y0=Kj6oCOFwg0H-gQEr4g3TM+3_+5N7mfd=A@mail.gmail.com>
 <450d0da1-3d11-428b-bd89-d09a2964cdb1@oracle.com>
 <CAJaqyWfXNQJQdTcJ9V-mSUrMs9up7rpAMwyK-qB3BuJwbUw+5w@mail.gmail.com>
 <f2dcbc76-f90f-4abe-b5c3-f159befd07bd@oracle.com>
 <CAJaqyWeSrwVt6imakpccieqN_3C85JcOZuj=FR+Xnmr7FKFaAw@mail.gmail.com>
 <9f347cd6-8c18-4253-8a5f-efae08230a62@oracle.com>
 <CAJaqyWeyfPp5bh9iZrkwZshoStEHZ85P6t4TcEdmR5sDYhG4ug@mail.gmail.com>
 <f6c63253-57bf-4e7a-8178-667a577784d5@oracle.com>
In-Reply-To: <f6c63253-57bf-4e7a-8178-667a577784d5@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 30 Apr 2024 19:19:59 +0200
Message-ID: <CAJaqyWdheH4MoHMOQjPmbOpODswE53w09LkfeaDNWdys3qUFLw@mail.gmail.com>
Subject: Re: [RFC 1/2] iova_tree: add an id member to DMAMap
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 30, 2024 at 7:55=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 4/29/2024 1:14 AM, Eugenio Perez Martin wrote:
> > On Thu, Apr 25, 2024 at 7:44=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >> On 4/24/2024 12:33 AM, Eugenio Perez Martin wrote:
> >>> On Wed, Apr 24, 2024 at 12:21=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracl=
e.com> wrote:
> >>>>
> >>>> On 4/22/2024 1:49 AM, Eugenio Perez Martin wrote:
> >>>>> On Sat, Apr 20, 2024 at 1:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@orac=
le.com> wrote:
> >>>>>> On 4/19/2024 1:29 AM, Eugenio Perez Martin wrote:
> >>>>>>> On Thu, Apr 18, 2024 at 10:46=E2=80=AFPM Si-Wei Liu <si-wei.liu@o=
racle.com> wrote:
> >>>>>>>> On 4/10/2024 3:03 AM, Eugenio P=C3=A9rez wrote:
> >>>>>>>>> IOVA tree is also used to track the mappings of virtio-net shad=
ow
> >>>>>>>>> virtqueue.  This mappings may not match with the GPA->HVA ones.
> >>>>>>>>>
> >>>>>>>>> This causes a problem when overlapped regions (different GPA bu=
t same
> >>>>>>>>> translated HVA) exists in the tree, as looking them by HVA will=
 return
> >>>>>>>>> them twice.  To solve this, create an id member so we can assig=
n unique
> >>>>>>>>> identifiers (GPA) to the maps.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >>>>>>>>> ---
> >>>>>>>>>       include/qemu/iova-tree.h | 5 +++--
> >>>>>>>>>       util/iova-tree.c         | 3 ++-
> >>>>>>>>>       2 files changed, 5 insertions(+), 3 deletions(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.=
h
> >>>>>>>>> index 2a10a7052e..34ee230e7d 100644
> >>>>>>>>> --- a/include/qemu/iova-tree.h
> >>>>>>>>> +++ b/include/qemu/iova-tree.h
> >>>>>>>>> @@ -36,6 +36,7 @@ typedef struct DMAMap {
> >>>>>>>>>           hwaddr iova;
> >>>>>>>>>           hwaddr translated_addr;
> >>>>>>>>>           hwaddr size;                /* Inclusive */
> >>>>>>>>> +    uint64_t id;
> >>>>>>>>>           IOMMUAccessFlags perm;
> >>>>>>>>>       } QEMU_PACKED DMAMap;
> >>>>>>>>>       typedef gboolean (*iova_tree_iterator)(DMAMap *map);
> >>>>>>>>> @@ -100,8 +101,8 @@ const DMAMap *iova_tree_find(const IOVATree=
 *tree, const DMAMap *map);
> >>>>>>>>>        * @map: the mapping to search
> >>>>>>>>>        *
> >>>>>>>>>        * Search for a mapping in the iova tree that translated_=
addr overlaps with the
> >>>>>>>>> - * mapping range specified.  Only the first found mapping will=
 be
> >>>>>>>>> - * returned.
> >>>>>>>>> + * mapping range specified and map->id is equal.  Only the fir=
st found
> >>>>>>>>> + * mapping will be returned.
> >>>>>>>>>        *
> >>>>>>>>>        * Return: DMAMap pointer if found, or NULL if not found.=
  Note that
> >>>>>>>>>        * the returned DMAMap pointer is maintained internally. =
 User should
> >>>>>>>>> diff --git a/util/iova-tree.c b/util/iova-tree.c
> >>>>>>>>> index 536789797e..0863e0a3b8 100644
> >>>>>>>>> --- a/util/iova-tree.c
> >>>>>>>>> +++ b/util/iova-tree.c
> >>>>>>>>> @@ -97,7 +97,8 @@ static gboolean iova_tree_find_address_iterat=
or(gpointer key, gpointer value,
> >>>>>>>>>
> >>>>>>>>>           needle =3D args->needle;
> >>>>>>>>>           if (map->translated_addr + map->size < needle->transl=
ated_addr ||
> >>>>>>>>> -        needle->translated_addr + needle->size < map->translat=
ed_addr) {
> >>>>>>>>> +        needle->translated_addr + needle->size < map->translat=
ed_addr ||
> >>>>>>>>> +        needle->id !=3D map->id) {
> >>>>>>>> It looks this iterator can also be invoked by SVQ from
> >>>>>>>> vhost_svq_translate_addr() -> iova_tree_find_iova(), where guest=
 GPA
> >>>>>>>> space will be searched on without passing in the ID (GPA), and e=
xact
> >>>>>>>> match for the same GPA range is not actually needed unlike the m=
apping
> >>>>>>>> removal case. Could we create an API variant, for the SVQ lookup=
 case
> >>>>>>>> specifically? Or alternatively, add a special flag, say skip_id_=
match to
> >>>>>>>> DMAMap, and the id match check may look like below:
> >>>>>>>>
> >>>>>>>> (!needle->skip_id_match && needle->id !=3D map->id)
> >>>>>>>>
> >>>>>>>> I think vhost_svq_translate_addr() could just call the API varia=
nt or
> >>>>>>>> pass DMAmap with skip_id_match set to true to svq_iova_tree_find=
_iova().
> >>>>>>>>
> >>>>>>> I think you're totally right. But I'd really like to not complica=
te
> >>>>>>> the API of the iova_tree more.
> >>>>>>>
> >>>>>>> I think we can look for the hwaddr using memory_region_from_host =
and
> >>>>>>> then get the hwaddr. It is another lookup though...
> >>>>>> Yeah, that will be another means of doing translation without havi=
ng to
> >>>>>> complicate the API around iova_tree. I wonder how the lookup throu=
gh
> >>>>>> memory_region_from_host() may perform compared to the iova tree on=
e, the
> >>>>>> former looks to be an O(N) linear search on a linked list while th=
e
> >>>>>> latter would be roughly O(log N) on an AVL tree?
> >>>>> Even worse, as the reverse lookup (from QEMU vaddr to SVQ IOVA) is
> >>>>> linear too. It is not even ordered.
> >>>> Oh Sorry, I misread the code and I should look for g_tree_foreach ()
> >>>> instead of g_tree_search_node(). So the former is indeed linear
> >>>> iteration, but it looks to be ordered?
> >>>>
> >>>> https://github.com/GNOME/glib/blob/main/glib/gtree.c#L1115
> >>> The GPA / IOVA are ordered but we're looking by QEMU's vaddr.
> >>>
> >>> If we have these translations:
> >>> [0x1000, 0x2000] -> [0x10000, 0x11000]
> >>> [0x2000, 0x3000] -> [0x6000, 0x7000]
> >>>
> >>> We will see them in this order, so we cannot stop the search at the f=
irst node.
> >> Yeah, reverse lookup is unordered indeed, anyway.
> >>
> >>>>> But apart from this detail you're right, I have the same concerns w=
ith
> >>>>> this solution too. If we see a hard performance regression we could=
 go
> >>>>> to more complicated solutions, like maintaining a reverse IOVATree =
in
> >>>>> vhost-iova-tree too. First RFCs of SVQ did that actually.
> >>>> Agreed, yeap we can use memory_region_from_host for now.  Any reason=
 why
> >>>> reverse IOVATree was dropped, lack of users? But now we have one!
> >>>>
> >>> No, it is just simplicity. We already have an user in the hot patch i=
n
> >>> the master branch, vhost_svq_vring_write_descs. But I never profiled
> >>> enough to find if it is a bottleneck or not to be honest.
> >> Right, without vIOMMU or a lot of virtqueues / mappings, it's hard to
> >> profile and see the difference.
> >>> I'll send the new series by today, thank you for finding these issues=
!
> >> Thanks! In case you don't have bandwidth to add back reverse IOVA tree=
,
> >> Jonah (cc'ed) may have interest in looking into it.
> >>
> > Actually, yes. I've tried to solve it using:
> > memory_region_get_ram_ptr -> It's hard to get this pointer to work
> > without messing a lot with IOVATree.
> > memory_region_find -> I'm totally unable to make it return sections
> > that make sense
> > flatview_for_each_range -> It does not return the same
> > MemoryRegionsection as the listener, not sure why.
> Ouch, thank you for the summary of attempts that were done earlier.
> > The only advance I have is that memory_region_from_host is able to
> > tell if the vaddr is from the guest or not.
> Hmmm, then it won't be too useful without a direct means to identifying
> the exact memory region associated with the iova that is being mapped.
> And, this additional indirection seems introduce a tiny bit of more
> latency in the reverse lookup routine (should not be a scalability issue
> though if it's a linear search)?
>

I didn't measure, but I guess yes it might. OTOH these structs may be
cached because virtqueue_pop just looked for them.

> > So I'm convinced there must be a way to do it with the memory
> > subsystem, but I think the best way to do it ATM is to store a
> > parallel tree with GPA-> SVQ IOVA translations. At removal time, if we
> > find the entry in this new tree, we can directly remove it by GPA. If
> > not, assume it is a host-only address like SVQ vrings, and remove by
> > iterating on vaddr as we do now.
> Yeah, this could work I think. On the other hand, given that we are now
> trying to improve it, I wonder if possible to come up with a fast
> version for the SVQ (host-only address) case without having to look up
> twice? SVQ callers should be able to tell apart from the guest case
> where GPA -> IOVA translation doesn't exist? Or just maintain a parallel
> tree with HVA -> IOVA translations for SVQ reverse lookup only? I feel
> SVQ mappings may be worth a separate fast lookup path - unlike guest
> mappings, the insertion, lookup and removal for SVQ mappings seem
> unavoidable during the migration downtime path.
>

I think the ideal order is the opposite actually. So:
1) Try for the NIC to support _F_VRING_ASID, no translation needed by QEMU
2) Try reverse lookup from HVA to GPA. Since dataplane should fit
this, we should test this first
3) Look in SVQ host-only entries (SVQ, current shadow CVQ). It is the
control VQ, speed is not so important.

Overlapping regions may return the wrong SVQ IOVA though. We should
take extra care to make sure these are correctly handled. I mean,
there are valid translations in the tree unless the driver is buggy,
just may need to span many translations.

> >   It is guaranteed the guest does not
> > translate to that vaddr and that that vaddr is unique in the tree
> > anyway.
> >
> > Does it sound reasonable? Jonah, would you be interested in moving this=
 forward?
> My thought would be that the reverse IOVA tree stuff can be added as a
> follow-up optimization right after for extended scalability, but for now
> as the interim, we may still need some form of simple fix, so as to
> quickly unblock the other dependent work built on top of this one and
> the early pinning series [1]. With it said, I'm completely fine if
> performing the reverse lookup through linear tree walk e.g.
> g_tree_foreach(), that should suffice small VM configs with just a
> couple of queues and limited number of memory regions. Going forward, to
> address the scalability bottleneck, Jonah could just replace the
> corresponding API call with the one built on top of reverse IOVA tree (I
> presume the use of these iova tree APIs is kind of internal that only
> limits to SVQ and vhost-vdpa subsystems) once he gets there, and then
> eliminate the other API variants that will no longer be in use. What do
> you think about this idea / plan?
>

Yeah it makes sense to me. Hopefully we can even get rid of the id member.

> Thanks,
> -Siwei
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00079.htm=
l
>
> >
> > Thanks!
> >
> >> -Siwei
> >>
> >>
> >>>> Thanks,
> >>>> -Siwei
> >>>>> Thanks!
> >>>>>
> >>>>>> Of course,
> >>>>>> memory_region_from_host() won't search out of the guest memory spa=
ce for
> >>>>>> sure. As this could be on the hot data path I have a little bit
> >>>>>> hesitance over the potential cost or performance regression this c=
hange
> >>>>>> could bring in, but maybe I'm overthinking it too much...
> >>>>>>
> >>>>>> Thanks,
> >>>>>> -Siwei
> >>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> -Siwei
> >>>>>>>>>               return false;
> >>>>>>>>>           }
> >>>>>>>>>
>


