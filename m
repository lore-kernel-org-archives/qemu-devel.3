Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D77FD7F6F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 10:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvvDC-00030y-Je; Fri, 27 Feb 2026 05:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vvvD9-00030f-TK
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:36:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vvvD7-000054-Dh
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 05:36:43 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fMl983R1GzJ468g;
 Fri, 27 Feb 2026 18:35:56 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id CFB4740569;
 Fri, 27 Feb 2026 18:36:22 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Feb
 2026 10:36:21 +0000
Date: Fri, 27 Feb 2026 10:36:20 +0000
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: Gregory Price <gourry@gourry.net>, <qemu-devel@nongnu.org>,
 <anisa.su887@gmail.com>, <armbru@redhat.com>, <david@kernel.org>,
 <imammedo@redhat.com>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
 <mst@redhat.com>, <nifan.cxl@gmail.com>, <peterx@redhat.com>,
 <philmd@linaro.org>, <ppbonzini@redhat.com>, <venkataravis@micron.com>,
 <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH v5 3/3] hw/cxl: Add a performant (and correct) path for
 the non interleaved cases
Message-ID: <20260227103620.0000612b@huawei.com>
In-Reply-To: <20260226001405.00005b6b.alireza.sanaee@huawei.com>
References: <20260225180718.480-1-alireza.sanaee@huawei.com>
 <20260225180718.480-4-alireza.sanaee@huawei.com>
 <aZ9c0yYcvKf5a0j7@gourry-fedora-PF4VCD3F>
 <20260226001405.00005b6b.alireza.sanaee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 26 Feb 2026 00:14:05 +0000
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> On Wed, 25 Feb 2026 15:34:27 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> Hi Gregory,
> 
> > On Wed, Feb 25, 2026 at 06:07:18PM +0000, Alireza Sanaee via qemu development wrote:  
> > > +static void cxl_fmws_direct_passthrough_remove(CXLType3Dev *ct3d,
> > > +                                               uint64_t decoder_base,
> > > +                                               unsigned int idx)
> > > +{
> > > +    CXLFixedWindow *owner_fw = ct3d->direct_mr_fw[idx];
> > > +    MemoryRegion *direct_mr = &ct3d->direct_mr[idx];
> > > +
> > > +    if (!owner_fw) {
> > > +        return;
> > > +    }
> > > +
> > > +    if (!memory_region_is_mapped(direct_mr)) {
> > > +        return;
> > > +    }
> > > +
> > > +    if (cxl_cfmws_find_device(owner_fw, decoder_base, false)) {
> > > +        return;
> > > +    }
> > > +
> > > +    memory_region_del_subregion(&owner_fw->mr, direct_mr);
> > > +    ct3d->direct_mr_fw[idx] = NULL;
> > > +}
> > > +    
> > 
> > kreview flagged this, seems reasonable given other examples in the tree
> > 
> > The other commits looked ok, I'll try to get around to testing this soon.
> > 
> > ~Gregory
> > 
> > ---
> > 
> > Reported-by: kreview-8842242
> > 
> > The alias parameters (target MR, offset, size) are all guest-controlled
> > and can change between cycles -- the guest can reprogram DPA skip, decoder
> > size, or decoder base before recommitting.  There is no API to change the
> > alias target (mr->alias) after init, so an init-once approach would not
> > work here.
> > 
> > The VGA chain4_alias in hw/display/vga.c handles the same situation
> > (embedded MR alias rebuilt with different parameters on guest register
> > writes) using object_unparent():
> > 
> >     vga_update_memory_access() {
> >         memory_region_del_subregion(s->legacy_address_space, &s->chain4_alias);
> >         object_unparent(OBJECT(&s->chain4_alias));
> >         ...
> >         memory_region_init_alias(&s->chain4_alias, ...);
> >         memory_region_add_subregion_overlap(..., &s->chain4_alias, 2);
> >     }
> > 
> > Adding object_unparent() in remove() should fix this:
> > 
> >     memory_region_del_subregion(&owner_fw->mr, direct_mr);
> >     object_unparent(OBJECT(direct_mr));
> >     ct3d->direct_mr_fw[idx] = NULL;
> >   
> 
> This was actually my question as well, but I tested with a scenario in which I 
> created a region with its alias. Then I torn down that region so that the alias 
> goes away, and finally reinitialized the same region to reuse the deleted alias 
> object. It worked, but still it does not mean it is correct. I can send another 
> revision using unparent API.

It is more elegant (and keeps the introspection stuff reporting correctly)
to unparent the object on delete. To test this you'd need to bring it up in a different
cfmws so the parent changes.  So this is good feedback.

There is a secondary issue that around the HBM decoder registers being modified at random
points that don't make sense from an OS flow point of view, but which could lead to
mismatch.  For that one we'd need to snapshot the decoders at commit time and use
that snapshot as the valid settings.

Note that form a spec viewpoint I think it's undefined what happens if the OS messes
with these registers at inappropriate moments.  Snap shot should be a valid 
implementation choice though.

Given we aren't currently that defensive against the OS doing crazy things I don't
mind pushing that snapshot thing to a follow up patch.  Maybe merge into this once
it's ready.

Jonathan



