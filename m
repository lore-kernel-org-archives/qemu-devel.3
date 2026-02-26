Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EB8FD45F1
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 00:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvP1I-0008Hl-Bk; Wed, 25 Feb 2026 19:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vvP1G-0008HG-LL
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 19:14:18 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1vvP1D-0003Bo-JX
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 19:14:18 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fLsPP1sFjzHnGfD;
 Thu, 26 Feb 2026 08:13:29 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 1E20C40571;
 Thu, 26 Feb 2026 08:14:12 +0800 (CST)
Received: from localhost (10.47.75.67) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Feb
 2026 00:14:10 +0000
Date: Thu, 26 Feb 2026 00:14:05 +0000
To: Gregory Price <gourry@gourry.net>
CC: <qemu-devel@nongnu.org>, <anisa.su887@gmail.com>, <armbru@redhat.com>,
 <david@kernel.org>, <imammedo@redhat.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <lizhijian@fujitsu.com>, <mst@redhat.com>,
 <nifan.cxl@gmail.com>, <peterx@redhat.com>, <philmd@linaro.org>,
 <ppbonzini@redhat.com>, <venkataravis@micron.com>,
 <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH v5 3/3] hw/cxl: Add a performant (and correct) path for
 the non interleaved cases
Message-ID: <20260226001405.00005b6b.alireza.sanaee@huawei.com>
In-Reply-To: <aZ9c0yYcvKf5a0j7@gourry-fedora-PF4VCD3F>
References: <20260225180718.480-1-alireza.sanaee@huawei.com>
 <20260225180718.480-4-alireza.sanaee@huawei.com>
 <aZ9c0yYcvKf5a0j7@gourry-fedora-PF4VCD3F>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.67]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 25 Feb 2026 15:34:27 -0500
Gregory Price <gourry@gourry.net> wrote:

Hi Gregory,

> On Wed, Feb 25, 2026 at 06:07:18PM +0000, Alireza Sanaee via qemu development wrote:
> > +static void cxl_fmws_direct_passthrough_remove(CXLType3Dev *ct3d,
> > +                                               uint64_t decoder_base,
> > +                                               unsigned int idx)
> > +{
> > +    CXLFixedWindow *owner_fw = ct3d->direct_mr_fw[idx];
> > +    MemoryRegion *direct_mr = &ct3d->direct_mr[idx];
> > +
> > +    if (!owner_fw) {
> > +        return;
> > +    }
> > +
> > +    if (!memory_region_is_mapped(direct_mr)) {
> > +        return;
> > +    }
> > +
> > +    if (cxl_cfmws_find_device(owner_fw, decoder_base, false)) {
> > +        return;
> > +    }
> > +
> > +    memory_region_del_subregion(&owner_fw->mr, direct_mr);
> > +    ct3d->direct_mr_fw[idx] = NULL;
> > +}
> > +  
> 
> kreview flagged this, seems reasonable given other examples in the tree
> 
> The other commits looked ok, I'll try to get around to testing this soon.
> 
> ~Gregory
> 
> ---
> 
> Reported-by: kreview-8842242
> 
> The alias parameters (target MR, offset, size) are all guest-controlled
> and can change between cycles -- the guest can reprogram DPA skip, decoder
> size, or decoder base before recommitting.  There is no API to change the
> alias target (mr->alias) after init, so an init-once approach would not
> work here.
> 
> The VGA chain4_alias in hw/display/vga.c handles the same situation
> (embedded MR alias rebuilt with different parameters on guest register
> writes) using object_unparent():
> 
>     vga_update_memory_access() {
>         memory_region_del_subregion(s->legacy_address_space, &s->chain4_alias);
>         object_unparent(OBJECT(&s->chain4_alias));
>         ...
>         memory_region_init_alias(&s->chain4_alias, ...);
>         memory_region_add_subregion_overlap(..., &s->chain4_alias, 2);
>     }
> 
> Adding object_unparent() in remove() should fix this:
> 
>     memory_region_del_subregion(&owner_fw->mr, direct_mr);
>     object_unparent(OBJECT(direct_mr));
>     ct3d->direct_mr_fw[idx] = NULL;
> 

This was actually my question as well, but I tested with a scenario in which I 
created a region with its alias. Then I torn down that region so that the alias 
goes away, and finally reinitialized the same region to reuse the deleted alias 
object. It worked, but still it does not mean it is correct. I can send another 
revision using unparent API.

