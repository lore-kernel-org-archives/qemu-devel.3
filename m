Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D802C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 18:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1ryB-00017O-9O; Tue, 30 Apr 2024 14:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s1ry8-00016v-8T
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 14:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s1ry0-0007fx-M8
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 14:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714500752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AVaXW8yRlp2IhwH7eX17FIBnfKcjLIws9LdVButtgQM=;
 b=A8stoUKWkD00ezQ/D3Ns1vlKi5AitlrzHvJd1IepAEBiampiYBaVo3XEIttojm2KzYCpDG
 VwotWbd52J2DSIR52Nsfn6QpblLeWG2qyf/6ILWtjC0J7mAqnWgrBswfrWywA+fD68jdFf
 AqpSa9J+ug1pvXDFe7SfwNtoeU1/PXE=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-hi2APD0UMNOB5LH4qomBhg-1; Tue, 30 Apr 2024 14:12:31 -0400
X-MC-Unique: hi2APD0UMNOB5LH4qomBhg-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-de54be7066bso10751068276.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 11:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714500750; x=1715105550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AVaXW8yRlp2IhwH7eX17FIBnfKcjLIws9LdVButtgQM=;
 b=NxXDPYHmC/sRk/l0WSfE7eOJ4F/RieJ/jw+tPP6GB7noWcaSkt2yj14d7kKKByV+WK
 vh9lg9c7Nwr54wXdXW+qcjbYxWNO3GT6YmoZ/qD7sghmVSrAFj388cyCzmI7uqhJOTot
 8x34Q30jUuNNhVWdXO/lrGIXjb9aG7kblCe43Q4h9W7IhxTa7qNIxD6FTFq0TZjzc3QY
 rheO6/IC1SYe0sD6ihbPiYe8X16rlU+gQTDkEa89hPzC8ghIeXSfKw2OZb1pjRFSRwd2
 E6PK1RKpKXWjdefzTJAMhYsRK42/zOm+QyicpqpiLK5h0kKVYl0DEsm61zffdcyZ1iLT
 gf6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUnzdUnxHSSGyhhvMDxgpmLK54sDpVO0+s1Q4yu1UzkRdr1Xo0Lj5Lw/5FjtJCD7KEYnjuOIileEendbhae7qYMeuoGKY=
X-Gm-Message-State: AOJu0Yxo0X8XTh1B7C8ZgzxGsG4GVxAxV6NIp3JSOFpjkPmNiC6Ur6PO
 6rZDrx8M6jU0m5EGVM2Miie/kgGwAd05b2LfC28fZPkqnkYaLwLm2QeMEE0hnyD/BXaE8Zi+KX9
 w1lJNraDnycEeTlapCFP1gwsTPcxSoQK0jY6tEjW0zQMEBs3fBhK8QJ6jxY+jlJYB+NLNwti1rz
 j2EiGuge3eUJqVqtLAC3J9US4VQt4=
X-Received: by 2002:a25:84cc:0:b0:de6:197b:ff89 with SMTP id
 x12-20020a2584cc000000b00de6197bff89mr329122ybm.64.1714500750497; 
 Tue, 30 Apr 2024 11:12:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWEOV9LXdflde4itVTWAkcwWW6dQNpjIHFrQvfes9ZxMrupNaNJVu4mDHJ5cXjeuUnq3tAiI3gD3oZqexD/O8=
X-Received: by 2002:a25:84cc:0:b0:de6:197b:ff89 with SMTP id
 x12-20020a2584cc000000b00de6197bff89mr329090ybm.64.1714500750162; Tue, 30 Apr
 2024 11:12:30 -0700 (PDT)
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
 <1e1cbe99-65e8-4292-b19b-8e054f5b1fca@oracle.com>
In-Reply-To: <1e1cbe99-65e8-4292-b19b-8e054f5b1fca@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 30 Apr 2024 20:11:54 +0200
Message-ID: <CAJaqyWeGUM+HZM1-SdQfXmw_xw_tVq9Nns+EH_M8jbOQatXWTw@mail.gmail.com>
Subject: Re: [RFC 1/2] iova_tree: add an id member to DMAMap
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>, 
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Apr 29, 2024 at 1:19=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 4/29/24 4:14 AM, Eugenio Perez Martin wrote:
> > On Thu, Apr 25, 2024 at 7:44=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >>
> >> On 4/24/2024 12:33 AM, Eugenio Perez Martin wrote:
> >>> On Wed, Apr 24, 2024 at 12:21=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracl=
e.com> wrote:
> >>>>
> >>>>
> >>>> On 4/22/2024 1:49 AM, Eugenio Perez Martin wrote:
> >>>>> On Sat, Apr 20, 2024 at 1:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@orac=
le.com> wrote:
> >>>>>>
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
> >>>> https://urldefense.com/v3/__https://github.com/GNOME/glib/blob/main/=
glib/gtree.c*L1115__;Iw!!ACWV5N9M2RV99hQ!Ng2rLfRd9tLyNTNocW50Mf5AcxSt0uF0wO=
dv120djff-z_iAdbujYK-jMi5UC1DZLxb1yLUv2vV0j3wJo8o$
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
> >>>
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
> >>>
> >>> I'll send the new series by today, thank you for finding these issues=
!
> >> Thanks! In case you don't have bandwidth to add back reverse IOVA tree=
,
> >> Jonah (cc'ed) may have interest in looking into it.
> >>
> >
> > Actually, yes. I've tried to solve it using:
> > memory_region_get_ram_ptr -> It's hard to get this pointer to work
> > without messing a lot with IOVATree.
> > memory_region_find -> I'm totally unable to make it return sections
> > that make sense
> > flatview_for_each_range -> It does not return the same
> > MemoryRegionsection as the listener, not sure why.
> >
> > The only advance I have is that memory_region_from_host is able to
> > tell if the vaddr is from the guest or not.
> >
> > So I'm convinced there must be a way to do it with the memory
> > subsystem, but I think the best way to do it ATM is to store a
> > parallel tree with GPA-> SVQ IOVA translations. At removal time, if we
> > find the entry in this new tree, we can directly remove it by GPA. If
> > not, assume it is a host-only address like SVQ vrings, and remove by
> > iterating on vaddr as we do now. It is guaranteed the guest does not
> > translate to that vaddr and that that vaddr is unique in the tree
> > anyway.
> >
> > Does it sound reasonable? Jonah, would you be interested in moving this=
 forward?
> >
> > Thanks!
> >
>
> Sure, I'd be more than happy to work on this stuff! I can probably get
> started on this either today or tomorrow.
>
> Si-Wei mentioned something about these "reverse IOVATree" patches that
> were dropped;

The patches implementing the reverse IOVA tree were never created /
posted, just in case you try to look for them.


> is this relevant to what you're asking here? Is it
> something I should base my work off of?
>

So these patches work ok for adding and removing maps. We assign ids,
which is the gpa of the memory region that the listener receives. The
bad news is that SVQ also needs this id to look for the right
translation at vhost_svq_translate_addr, so this series is not
complete. You can find the
vhost_iova_tree_find_iova()->iova_tree_find_iova() call there.

The easiest solution is the reverse IOVA tree of HVA -> SVQ IOVA. It
is also the less elegant and (potentially) the less performant, as it
includes duplicating information that QEMU already has, and a
potentially linear search.

David Hildenbrand (CCed) proposed to try iterating through RAMBlocks.
I guess qemu_ram_block_from_host() could return a block where
block->offset is the id of the map?

It would be great to try this approach. If you don't have the bandwith
for this, going directly for the reverse iova tree is also a valid
solution.

Thanks!

> If there's any other relevant information about this issue that you
> think I should know, let me know. I'll start digging into this ASAP and
> will reach out if I need any guidance. :)
>
> Jonah
>
> >> -Siwei
> >>
> >>
> >>>
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
> >>
> >
>


