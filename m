Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5632C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 08:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYiWi-0004ug-Fu; Tue, 30 Jul 2024 04:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYiWg-0004u8-Ps
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:48:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYiWd-0007tM-Hc
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722329286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lmMultHKc5k4n8dw+2fuZYH3CGBaA35Ht4l5DI2oKuo=;
 b=Cg0VMb31E8OhtvSXqpPVFT4bnZbcUgzQuhvqfsSOg2rDqjI+WCns9gtCcNgqq8KTS6heex
 Yc3r6sIFVApvSZJ8vxQ1DTQVAsRXmpIVKQ/a5OnafGhbwdqL/ZeGt09UONPUwwwYXcNjOT
 HG8Bw+zS/mkmdMDAgFnBG5cF77biloU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-8dgtLQeOPaC5eEjFMn2ypQ-1; Tue, 30 Jul 2024 04:48:03 -0400
X-MC-Unique: 8dgtLQeOPaC5eEjFMn2ypQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2cb5d93c529so4253452a91.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 01:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722329283; x=1722934083;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lmMultHKc5k4n8dw+2fuZYH3CGBaA35Ht4l5DI2oKuo=;
 b=lUHg6BmzsdAwu28I6v3X9SBKK+0aNKc6k2ZsIVquKEetL3JWVhebh06U8U+lACAxQr
 FNk2/cTaqMECxwxhZ6zWNCV7oUE6MewQR9/0+r+1LiCiMFeRS56RwXvtDcx+jbyo6HhU
 mYf93P5WY8kOcKZdDfzdLWpkqzc04MMa4DsdWjkK4sB1FYKF7FVp8BpGnrz6NoOs2C+X
 i3kJamyfZYbMJEf/g25wpfgyQLHADUellt9IoJPnGVh+WJ8gQ7Vbd1DD+NfjhcIhgvlX
 TKgIlVCSF/RK/GgfySL/mBQzPWj5usA/zqcg7nh0TetNjQHdYvVarA11vSF7Bx0pVqf5
 dAIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYcsRY8v4jgiTJQDT0B2W3XZLPnVv7Y7ChxMHT6wb2s3GSu9Os8sGnZI3C4/2LmFC3LTF6jwbff/WV/sTUHrQ2eYiu4IY=
X-Gm-Message-State: AOJu0YxkUdRCs8LxweDf5Xm7izN/L/dNhxP/gZf+h2Sg+dq+LI414pUv
 wKAfuOwSMKTOlxl7MPRyqXQ6qe/+3rZ6PLiGb+GScOdAWY5Xmt6MSn81hhPKpo49uhlIGsPOCne
 XT2Xi2lEa8e7eeSLkes3vPBvuVP/L2qpfVYG/YLP8U44WNde7Lo/r7jdqENWrcCdVF/Ogfxp+hy
 2nMwZsGVgGdpfAFRPPm4/eAsQ/jEI=
X-Received: by 2002:a17:90b:270b:b0:2cd:3445:f87b with SMTP id
 98e67ed59e1d1-2cf7e5c12damr7992258a91.29.1722329282462; 
 Tue, 30 Jul 2024 01:48:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaJbEIwz0hK8oDc6XzJ+Y0sW29vA6jLQq1V8mDEQfLu1vT7UMzQ8XlYFYnjJUvSNeeX7T5udUH2g2zgryIti4=
X-Received: by 2002:a17:90b:270b:b0:2cd:3445:f87b with SMTP id
 98e67ed59e1d1-2cf7e5c12damr7992237a91.29.1722329281764; Tue, 30 Jul 2024
 01:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240410100345.389462-1-eperezma@redhat.com>
 <CACGkMEtZEe=ONRcrmm5TNdcxkJx=p4m24VD0yx5w0u+Rn854hQ@mail.gmail.com>
 <CAJaqyWdoCYFEEQdwZiCxzaX6HuJE-0QWctJ4WBnOd97zDwbPnw@mail.gmail.com>
 <CACGkMEu328ksfMDtJheH+sdTdV4E=pJFEa5Zco2_ecskubCAGg@mail.gmail.com>
 <CAJaqyWdZFUw8H7_2Jw3j9JxLj9+3p53QZg=DF3o4OgWJYC-SaQ@mail.gmail.com>
 <CACGkMEvdBDFvwvqb_7YXqiPd-ax4Xw7e0BLBhCt_uD6-Uf+DgA@mail.gmail.com>
 <CAJaqyWdA_6Mx3mkcobmBjB5NDJt3tyqTJv2JijF0agnnBFxQxw@mail.gmail.com>
 <CACGkMEv7wukFdXrA--DzA7U7VYWQq6UAVmi-0=pTAOuJ1nc_7Q@mail.gmail.com>
 <CAJaqyWdtdfbQi4PrbC-ASRo7dHsT7Nw3dmw66K9D9ZeoqyV=ng@mail.gmail.com>
 <CACGkMEs=-teddtO4ctLdJiwm2gu3sZrKOww-TC+5o2_19Sph4w@mail.gmail.com>
 <CAJaqyWeKfVXYj61sgvFrUTpOgy0k-zsLoR4JePEo0Q8XuXYbmA@mail.gmail.com>
 <CACGkMEt+TLqpbw2N4m7Ez4edTBztRUxiAt6=NLuFR3c7F7Z_jA@mail.gmail.com>
 <CAJaqyWc18UeBHeQSoAFF1u1nkjaAfj0Y85pgSHbhV8xxExjcgg@mail.gmail.com>
 <CACGkMEtrPAMb-ZN7AAE8cjEzjZY1Hnm29J7PhUYgwv26=YcdQw@mail.gmail.com>
 <84374c5a-d937-4cb5-aafb-45ad75e2d837@oracle.com>
 <CAJaqyWfekhhG+5Zp4eddpp-2N=SjUL+7zs+YqS5xx6eWxa-PqQ@mail.gmail.com>
In-Reply-To: <CAJaqyWfekhhG+5Zp4eddpp-2N=SjUL+7zs+YqS5xx6eWxa-PqQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jul 2024 16:47:50 +0800
Message-ID: <CACGkMEvYSBZpVG2x6q_viekods+QWrjoCETQcsgnHM+Ng4NWGw@mail.gmail.com>
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org, 
 Si-Wei Liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 29, 2024 at 6:05=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Jul 24, 2024 at 7:00=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle=
.com> wrote:
> >
> >
> >
> > On 5/13/24 11:56 PM, Jason Wang wrote:
> > > On Mon, May 13, 2024 at 5:58=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > >>
> > >> On Mon, May 13, 2024 at 10:28=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > >>>
> > >>> On Mon, May 13, 2024 at 2:28=E2=80=AFPM Eugenio Perez Martin
> > >>> <eperezma@redhat.com> wrote:
> > >>>>
> > >>>> On Sat, May 11, 2024 at 6:07=E2=80=AFAM Jason Wang <jasowang@redha=
t.com> wrote:
> > >>>>>
> > >>>>> On Fri, May 10, 2024 at 3:16=E2=80=AFPM Eugenio Perez Martin
> > >>>>> <eperezma@redhat.com> wrote:
> > >>>>>>
> > >>>>>> On Fri, May 10, 2024 at 6:29=E2=80=AFAM Jason Wang <jasowang@red=
hat.com> wrote:
> > >>>>>>>
> > >>>>>>> On Thu, May 9, 2024 at 3:10=E2=80=AFPM Eugenio Perez Martin <ep=
erezma@redhat.com> wrote:
> > >>>>>>>>
> > >>>>>>>> On Thu, May 9, 2024 at 8:27=E2=80=AFAM Jason Wang <jasowang@re=
dhat.com> wrote:
> > >>>>>>>>>
> > >>>>>>>>> On Thu, May 9, 2024 at 1:16=E2=80=AFAM Eugenio Perez Martin <=
eperezma@redhat.com> wrote:
> > >>>>>>>>>>
> > >>>>>>>>>> On Wed, May 8, 2024 at 4:29=E2=80=AFAM Jason Wang <jasowang@=
redhat.com> wrote:
> > >>>>>>>>>>>
> > >>>>>>>>>>> On Tue, May 7, 2024 at 6:57=E2=80=AFPM Eugenio Perez Martin=
 <eperezma@redhat.com> wrote:
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> On Tue, May 7, 2024 at 9:29=E2=80=AFAM Jason Wang <jasowan=
g@redhat.com> wrote:
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> On Fri, Apr 12, 2024 at 3:56=E2=80=AFPM Eugenio Perez Mar=
tin
> > >>>>>>>>>>>>> <eperezma@redhat.com> wrote:
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> On Fri, Apr 12, 2024 at 8:47=E2=80=AFAM Jason Wang <jaso=
wang@redhat.com> wrote:
> > >>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>> On Wed, Apr 10, 2024 at 6:03=E2=80=AFPM Eugenio P=C3=A9=
rez <eperezma@redhat.com> wrote:
> > >>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>> The guest may have overlapped memory regions, where di=
fferent GPA leads
> > >>>>>>>>>>>>>>>> to the same HVA.  This causes a problem when overlappe=
d regions
> > >>>>>>>>>>>>>>>> (different GPA but same translated HVA) exists in the =
tree, as looking
> > >>>>>>>>>>>>>>>> them by HVA will return them twice.
> > >>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>> I think I don't understand if there's any side effect f=
or shadow virtqueue?
> > >>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> My bad, I totally forgot to put a reference to where thi=
s comes from.
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> Si-Wei found that during initialization this sequences o=
f maps /
> > >>>>>>>>>>>>>> unmaps happens [1]:
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> HVA                    GPA                IOVA
> > >>>>>>>>>>>>>> --------------------------------------------------------=
-----------------------------------------------------------------
> > >>>>>>>>>>>>>> Map
> > >>>>>>>>>>>>>> [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0=
x1000, 0x80000000)
> > >>>>>>>>>>>>>> [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080=
000000)
> > >>>>>>>>>>>>>> [0x80001000, 0x2000001000)
> > >>>>>>>>>>>>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0=
000)
> > >>>>>>>>>>>>>> [0x2000001000, 0x2000021000)
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> Unmap
> > >>>>>>>>>>>>>> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0=
000) [0x1000,
> > >>>>>>>>>>>>>> 0x20000) ???
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> The third HVA range is contained in the first one, but e=
xposed under a
> > >>>>>>>>>>>>>> different GVA (aliased). This is not "flattened" by QEMU=
, as GPA does
> > >>>>>>>>>>>>>> not overlap, only HVA.
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> At the third chunk unmap, the current algorithm finds th=
e first chunk,
> > >>>>>>>>>>>>>> not the second one. This series is the way to tell the d=
ifference at
> > >>>>>>>>>>>>>> unmap time.
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> [1] https://urldefense.com/v3/__https://lists.nongnu.org=
/archive/html/qemu-devel/2024-04/msg00079.html__;!!ACWV5N9M2RV99hQ!MXbGSFHV=
bqRf0rzyWamOdnBLHP0FUh3r3BnTvGe6Mn5VzXTsajVp3BB7VqlklkRCr5aKazC5xxTCScuR_BY=
$
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> Thanks!
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> Ok, I was wondering if we need to store GPA(GIOVA) to HVA=
 mappings in
> > >>>>>>>>>>>>> the iova tree to solve this issue completely. Then there =
won't be
> > >>>>>>>>>>>>> aliasing issues.
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> I'm ok to explore that route but this has another problem.=
 Both SVQ
> > >>>>>>>>>>>> vrings and CVQ buffers also need to be addressable by Vhos=
tIOVATree,
> > >>>>>>>>>>>> and they do not have GPA.
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> At this moment vhost_svq_translate_addr is able to handle =
this
> > >>>>>>>>>>>> transparently as we translate vaddr to SVQ IOVA. How can w=
e store
> > >>>>>>>>>>>> these new entries? Maybe a (hwaddr)-1 GPA to signal it has=
 no GPA and
> > >>>>>>>>>>>> then a list to go through other entries (SVQ vaddr and CVQ=
 buffers).
> > >>>>>>>>>>>
> > >>>>>>>>>>> This seems to be tricky.
> > >>>>>>>>>>>
> > >>>>>>>>>>> As discussed, it could be another iova tree.
> > >>>>>>>>>>>
> > >>>>>>>>>>
> > >>>>>>>>>> Yes but there are many ways to add another IOVATree. Let me =
expand & recap.
> > >>>>>>>>>>
> > >>>>>>>>>> Option 1 is to simply add another iova tree to VhostShadowVi=
rtqueue.
> > >>>>>>>>>> Let's call it gpa_iova_tree, as opposed to the current iova_=
tree that
> > >>>>>>>>>> translates from vaddr to SVQ IOVA. To know which one to use =
is easy at
> > >>>>>>>>>> adding or removing, like in the memory listener, but how to =
know at
> > >>>>>>>>>> vhost_svq_translate_addr?
> > >>>>>>>>>
> > >>>>>>>>> Then we won't use virtqueue_pop() at all, we need a SVQ versi=
on of
> > >>>>>>>>> virtqueue_pop() to translate GPA to SVQ IOVA directly?
> > >>>>>>>>>
> > >>>>>>>>
> > >>>>>>>> The problem is not virtqueue_pop, that's out of the
> > >>>>>>>> vhost_svq_translate_addr. The problem is the need of adding
> > >>>>>>>> conditionals / complexity in all the callers of
> > >>>>>>>>
> > >>>>>>>>>>
> > >>>>>>>>>> The easiest way for me is to rely on memory_region_from_host=
(). When
> > >>>>>>>>>> vaddr is from the guest, it returns a valid MemoryRegion. Wh=
en it is
> > >>>>>>>>>> not, it returns NULL. I'm not sure if this is a valid use ca=
se, it
> > >>>>>>>>>> just worked in my tests so far.
> > >>>>>>>>>>
> > >>>>>>>>>> Now we have the second problem: The GPA values of the region=
s of the
> > >>>>>>>>>> two IOVA tree must be unique. We need to be able to find una=
llocated
> > >>>>>>>>>> regions in SVQ IOVA. At this moment there is only one IOVATr=
ee, so
> > >>>>>>>>>> this is done easily by vhost_iova_tree_map_alloc. But it is =
very
> > >>>>>>>>>> complicated with two trees.
> > >>>>>>>>>
> > >>>>>>>>> Would it be simpler if we decouple the IOVA allocator? For ex=
ample, we
> > >>>>>>>>> can have a dedicated gtree to track the allocated IOVA ranges=
. It is
> > >>>>>>>>> shared by both
> > >>>>>>>>>
> > >>>>>>>>> 1) Guest memory (GPA)
> > >>>>>>>>> 2) SVQ virtqueue and buffers
> > >>>>>>>>>
> > >>>>>>>>> And another gtree to track the GPA to IOVA.
> > >>>>>>>>>
> > >>>>>>>>> The SVQ code could use either
> > >>>>>>>>>
> > >>>>>>>>> 1) one linear mappings that contains both SVQ virtqueue and b=
uffers
> > >>>>>>>>>
> > >>>>>>>>> or
> > >>>>>>>>>
> > >>>>>>>>> 2) dynamic IOVA allocation/deallocation helpers
> > >>>>>>>>>
> > >>>>>>>>> So we don't actually need the third gtree for SVQ HVA -> SVQ =
IOVA?
> > >>>>>>>>>
> > >>>>>>>>
> > >>>>>>>> That's possible, but that scatters the IOVA handling code inst=
ead of
> > >>>>>>>> keeping it self-contained in VhostIOVATree.
> > >>>>>>>
> > >>>>>>> To me, the IOVA range/allocation is orthogonal to how IOVA is u=
sed.
> > >>>>>>>
> > >>>>>>> An example is the iova allocator in the kernel.
> > >>>>>>>
> > >>>>>>> Note that there's an even simpler IOVA "allocator" in NVME pass=
through
> > >>>>>>> code, not sure it is useful here though (haven't had a deep loo=
k at
> > >>>>>>> that).
> > >>>>>>>
> > >>>>>>
> > >>>>>> I don't know enough about them to have an opinion. I keep seeing=
 the
> > >>>>>> drawback of needing to synchronize both allocation & adding in a=
ll the
> > >>>>>> places we want to modify the IOVATree. At this moment, these are=
 the
> > >>>>>> vhost-vdpa memory listener, the SVQ vring creation and removal, =
and
> > >>>>>> net CVQ buffers. But it may be more in the future.
> > >>>>>>
> > >>>>>> What are the advantages of keeping these separated that justifie=
s
> > >>>>>> needing to synchronize in all these places, compared with keepin=
g them
> > >>>>>> synchronized in VhostIOVATree?
> > >>>>>
> > >>>>> It doesn't need to be synchronized.
> > >>>>>
> > >>>>> Assuming guest and SVQ shares IOVA range. IOVA only needs to trac=
k
> > >>>>> which part of the range has been used.
> > >>>>>
> > >>>>
> > >>>> Not sure if I follow, that is what I mean with "synchronized".
> > >>>
> > >>> Oh right.
> > >>>
> > >>>>
> > >>>>> This simplifies things, we can store GPA->IOVA mappings and SVQ -=
>
> > >>>>> IOVA mappings separately.
> > >>>>>
> > >>>>
> > >>>> Sorry, I still cannot see the whole picture :).
> > >>>>
> > >>>> Let's assume we have all the GPA mapped to specific IOVA regions, =
so
> > >>>> we have the first IOVA tree (GPA -> IOVA) filled. Now we enable SV=
Q
> > >>>> because of the migration. How can we know where we can place SVQ
> > >>>> vrings without having them synchronized?
> > >>>
> > >>> Just allocating a new IOVA range for SVQ?
> > >>>
> > >>>>
> > >>>> At this moment we're using a tree. The tree nature of the current =
SVQ
> > >>>> IOVA -> VA makes all nodes ordered so it is more or less easy to l=
ook
> > >>>> for holes.
> > >>>
> > >>> Yes, iova allocate could still be implemented via a tree.
> > >>>
> > >>>>
> > >>>> Now your proposal uses the SVQ IOVA as tree values. Should we iter=
ate
> > >>>> over all of them, order them, of the two trees, and then look for
> > >>>> holes there?
> > >>>
> > >>> Let me clarify, correct me if I was wrong:
> > >>>
> > >>> 1) IOVA allocator is still implemented via a tree, we just don't ne=
ed
> > >>> to store how the IOVA is used
> > >>> 2) A dedicated GPA -> IOVA tree, updated via listeners and is used =
in
> > >>> the datapath SVQ translation
> > >>> 3) A linear mapping or another SVQ -> IOVA tree used for SVQ
> > >>>
> > >>
> > >> Ok, so the part I was missing is that now we have 3 whole trees, wit=
h
> > >> somehow redundant information :).
> > >
> > > Somehow, it decouples the IOVA usage out of the IOVA allocator. This
> > > might be simple as guests and SVQ may try to share a single IOVA
> > > address space.
> > >
> >
> > I'm working on implementing your three suggestions above but I'm a bit
> > confused with some of the wording and I was hoping you could clarify
> > some of it for me when you get the chance.
> >
> > ---
> > For your first suggestion (1) you mention decoupling the IOVA allocator
> > and "don't need to store how the IOVA is used."
> >
> > By this, do you mean to not save the IOVA->HVA mapping and instead only
> > save the allocated IOVA ranges?

Yes.

> > In other words, are you suggesting to
> > create a dedicated "IOVA->IOVA" tree like:
> >
> > struct VhostIOVATree {
> >      uint64_t iova_first;
> >      uint64_t iova_last;
> >      IOVATree *iova_map;
> > };

It could be this or other. I think the point is the allocator is only
used for IOVA allocation but it doesn't have any information about the
mapping.

> >
> > Where the mapping might look something like (where translated_addr is
> > given some kind of 0 value):
> >
> > iova_region =3D (DMAMap) {
> >      .iova =3D iova_first,
> >      .translated_addr =3D 0,
> >      .size =3D region_size - 1,
> >      .perm =3D IOMMU_ACCESS_FLAG(true, section->readonly),
> > };
> >
> > Also, if this is what you mean by decoupling the IOVA allocator, what
> > happens to the IOVA->HVA tree?

We will have two structures:

1) IOVA domain (in charge of IOVA range allocation/deallocation)
2) How the IOVA is used, e.g an IOVA->HVA tree

> Are we no longer saving these mappings in
> > a tree?
> >
> > ---
> > In your second suggestion (2) with a dedicated GPA->IOVA tree, were you
> > thinking something like this? Just adding on to VhostIOVATree here:
> >
> > struct VhostIOVATree {
> >      uint64_t iova_first;
> >      uint64_t iova_last;
> >      IOVATree *iova_map;
> >      IOVATree *gpa_map;
> > };

I'd split the mappings if it's possible.

> >
> > Where the mapping might look something like:
> >
> > gpa_region =3D (DMAMap) {
> >      .iova =3D iova_first,
> >      .translated_addr =3D gpa_first,
> >      .size =3D region_size - 1,
> >      .perm =3D IOMMU_ACCESS_FLAG(true, section->readonly),
> > };
> >
> > Also, when you say "used in the datapath SVQ translation", we still nee=
d
> > to build the GPA->IOVA tree when vhost_vdpa_listener_region_add() is
> > called, right?

Right.

> >
> > ---
> > Lastly, in your third suggestion (3) you mention implementing a
> > SVQ->IOVA tree, making the total number of IOVATrees/GTrees 3: one for
> > just IOVAs, one for GPA->IOVA, and the last one for SVQ->IOVA. E.g.
> >
> > struct VhostIOVATree {
> >      uint64_t iova_first;
> >      uint64_t iova_last;
> >      IOVATree *iova_map;
> >      IOVATree *gpa_map;
> >      IOVATree *svq_map;
> > };
> >
> > ---
> >
> > Let me know if I'm understanding this correctly. If I am, this would
> > require a pretty good amount of refactoring on the IOVA allocation,
> > searching, destroying, etc. code to account for these new trees.
> >
>
> Ok I think I understand your previous question better, sorry for the dela=
y :).
>
> If I'm not wrong, Jason did not enumerate these as alternatives but as
> part of the same solution. Jason please correct me if I'm wrong here.
>
> His solution is composed of three trees:
> 1) One for the IOVA allocations, so we know where to allocate new ranges
> 2) One of the GPA -> SVQ IOVA translations.
> 3) Another one for SVQ vrings translations.
>

Exactly.

> In my opinion to use GPA this is problematic as we force all of the
> callers to know if the address we want to translate comes from the
> guest or not. Current code does now know it, as
> vhost_svq_translate_addr is called to translate both buffer dataplane
> addresses and control virtqueue buffers, which are also shadowed.  To
> transmit that information to the caller code would require either
> duplicate functions, to add a boolean, etc, as it is in a different
> layer (net specific net/vhost-vdpa.c vs generic
> hw/virtio/vhost-shadow-virtqueue.c).
>
> In my opinion is easier to keep just two trees (or similar structs):
> 1) One for the IOVA allocations, so we know where to allocate new
> ranges. We don't actually need to store the translations here.
> 2) One for HVA -> SVQ IOVA translations.
>
> This way we can accommodate both SVQ vrings, CVQ buffers, and guest
> memory buffers, all on the second tree, and take care of the HVA
> duplications.

Probably, but how to take care of HVA duplications (I may miss the
context, sorry)?

Thanks

>
> Thanks!
>
> > Thanks Jason!
> >
> > >>
> > >> In some sense this is simpler than trying to get all the information
> > >> from only two trees. On the bad side, all SVQ calls that allocate so=
me
> > >> region need to remember to add to one of the two other threes. That =
is
> > >> what I mean by synchronized. But sure, we can go that way.
> > >
> > > Just a suggestion, if it turns out to complicate the issue, I'm fine
> > > to go the other way.
> > >
> > > Thanks
> > >
> > >>
> > >>> Thanks
> > >>>
> > >>>>
> > >>>>> Thanks
> > >>>>>
> > >>>>>>
> > >>>>>> Thanks!
> > >>>>>>
> > >>>>>
> > >>>>
> > >>>
> > >>
> > >>
> > >
> >
>


