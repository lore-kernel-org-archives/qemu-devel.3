Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8233C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 20:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKjwN-0002tP-Vv; Thu, 29 May 2025 16:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKjwL-0002t7-Tq
 for qemu-devel@nongnu.org; Thu, 29 May 2025 16:33:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKjwJ-0007Nt-Om
 for qemu-devel@nongnu.org; Thu, 29 May 2025 16:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748550802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FRFChHGHkjphMsMC9NKxNS8XDU5AZopIMIdFGdbP0DE=;
 b=Vjsf5KvnuGbQ78dcLqhw9wcEEn1xJZ4+wEUZw82pVK3EfA7bL1p162/lv14OI8CEksDHaL
 WWBd+bn5BTinwKkU9Eumye6XUl9KxidD1uVd4zWm2BsA5kkYCXwp67edT8Z382wliTZTEH
 u5xw2PgRKGcZOxtMomLfeDM3OyLvkK4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99--N2Ga1LsMyupr2HKip1rtA-1; Thu, 29 May 2025 16:33:20 -0400
X-MC-Unique: -N2Ga1LsMyupr2HKip1rtA-1
X-Mimecast-MFC-AGG-ID: -N2Ga1LsMyupr2HKip1rtA_1748550800
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450d50eacafso3711865e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 13:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748550799; x=1749155599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRFChHGHkjphMsMC9NKxNS8XDU5AZopIMIdFGdbP0DE=;
 b=I5dSPVADzbu65tKEobauEZt6d9SChdw1I/H6QelqaC/lelZEFFIOwj7Kf7awOC78Xy
 3Ieo+Tq7i5vJ12/xYCFmnzXCvtqHu6fOVxwytXOGGzDsHeXSMs8wubQzoPVDqL6YdAcJ
 Fk1tehRbW083ap+27eXjtY9Il7UlfPOXJ/vECKICyZmSqj1svFCV2qVmXe8bbvbLw8Yv
 c0IUoWWHnQTrFv9eXr6o90fhR4s67ylzLfH/Xz8b6IEhupHP55NcAP+bT1AoTZkF6YOb
 0vGjNbTJsSks+VwfitexOoW8bkKqZeJ/MihgKvcpNOclvBi16BM69bOR0JJTxuIe4jIN
 x/qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdYISNTR98h1lpRuBY45Ha7AZiiwpMWg54ZBZauk9thx/0hsXapmFi+z0TS/86KEX8oX/wRqs8j3Wi@nongnu.org
X-Gm-Message-State: AOJu0Yx/xZ1Srf16fHnEd/GqmL1HcL3PT8y93+eWygs4SDKSfxup5h/0
 kv8klMZEvItgERSq5i4Xck+Ge8aZvgZG+S7yZMYu14BrdXfE9P9FOH379gCYLFobevq0vG1cYVg
 p92/pEJbuysOUXBiQCB2G/TCmvOdmWTKktkh8Zp6u5oRQQ0iS9lYWn/CE
X-Gm-Gg: ASbGncu8WL95RXdu9jVTmEWmwYLmiB9zzhuG6BSWlEqG1HlE+EOooIkF/ALQcMkaN1a
 IWa42jSCHhDgq0xl4IrDxj+q1B7ZGYA/DY3lJscMGiukS9JkSb269QNg0d2drxACZaA2SzJtkL2
 1Ft0cpDsc3OxLMLtIXNx5g3Wi/eFOyxzvZB7tMjFebyuSJuy1I1B71CaGpZ9ZSB7978ENizqjfD
 jhjt0+novyGRMR0cgdcj02wW/IbreGasIFgXysL/RXK1kar1T0D3ok3whiAst5oVBIG7q4k2Pfk
 OaAPog==
X-Received: by 2002:a05:600c:8207:b0:450:b240:aaab with SMTP id
 5b1f17b1804b1-450d64fc49dmr10017685e9.8.1748550799502; 
 Thu, 29 May 2025 13:33:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVANfC6zXEO4Pj5gSskTNeC86LnC/iZUQBlehWnwqIx8OGGArfsSRXfL8Ug7ZKe80bt8GWrA==
X-Received: by 2002:a05:600c:8207:b0:450:b240:aaab with SMTP id
 5b1f17b1804b1-450d64fc49dmr10017515e9.8.1748550798983; 
 Thu, 29 May 2025 13:33:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450cfbf40f0sm28703375e9.3.2025.05.29.13.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 13:33:18 -0700 (PDT)
Date: Thu, 29 May 2025 16:33:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, anisa.su887@gmail.com, gourry@gourry.net,
 fan.ni@samsung.com
Subject: Re: [Qemu PATCH v2] hw/cxl: fix DC extent capacity tracking
Message-ID: <20250529163303-mutt-send-email-mst@kernel.org>
References: <20250529163925.2916725-1-nifan.cxl@gmail.com>
 <20250529180734.00001197@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529180734.00001197@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, May 29, 2025 at 06:07:34PM +0100, Jonathan Cameron wrote:
> On Thu, 29 May 2025 16:34:25 +0000
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Per cxl r3.2 Section 9.13.3.3, extent capacity tracking should include
> > extents in different states including added, pending, etc.
> > 
> > Before the change, for the in-device extent number tracking purpose, we only
> > have "total_extent_count" defined, which only tracks the number of
> > extents accepted. However, we need to track number of extents in other
> > states also, for now it is extents pending-to-add.
> > 
> > To fix that, we introduce a new counter for dynamic capacity
> > "nr_extents_accepted" which explicitly tracks number of the extents
> > accepted by the hosts, and fix "total_extent_count" to include
> > both accepted and pending extents counting.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Thanks.  Michael, would you mind picking this up directly if
> you are happy with it?

sure

>   It is an esoteric corner case but
> we should emulate resource exhaustion for tracking extents correctly.
> 
> I don't have many fixes queued up at the moment to make it worth
> me bundling them up into a little series.  There is just this one
> and the one for Register Locator capability size I posted
> earlier today (Fan can you take a look at that one?)
> 
> > ---
> > v2:
> > 1) No functional changes;
> > 2) Rebased the code to ToT of master branch;
> > 3) Picked up tag;
> > 
> > v1:
> > https://lore.kernel.org/linux-cxl/20250520195741.789841-1-nifan.cxl@gmail.com/
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 26 ++++++++++++++++++--------
> >  hw/mem/cxl_type3.c          |  1 +
> >  include/hw/cxl/cxl_device.h |  3 ++-
> >  3 files changed, 21 insertions(+), 9 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 299f232f26..0b615ea37a 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -2750,7 +2750,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
> >      uint16_t out_pl_len, size;
> >      CXLDCExtent *ent;
> >  
> > -    if (start_extent_id > ct3d->dc.total_extent_count) {
> > +    if (start_extent_id > ct3d->dc.nr_extents_accepted) {
> >          return CXL_MBOX_INVALID_INPUT;
> >      }
> >  
> > @@ -2761,7 +2761,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
> >      out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> >  
> >      stl_le_p(&out->count, record_count);
> > -    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
> > +    stl_le_p(&out->total_extents, ct3d->dc.nr_extents_accepted);
> >      stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
> >  
> >      if (record_count > 0) {
> > @@ -2883,16 +2883,20 @@ void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
> >      QTAILQ_INSERT_TAIL(list, group, node);
> >  }
> >  
> > -void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
> > +uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list)
> >  {
> >      CXLDCExtent *ent, *ent_next;
> >      CXLDCExtentGroup *group = QTAILQ_FIRST(list);
> > +    uint32_t extents_deleted = 0;
> >  
> >      QTAILQ_REMOVE(list, group, node);
> >      QTAILQ_FOREACH_SAFE(ent, &group->list, node, ent_next) {
> >          cxl_remove_extent_from_extent_list(&group->list, ent);
> > +        extents_deleted++;
> >      }
> >      g_free(group);
> > +
> > +    return extents_deleted;
> >  }
> >  
> >  /*
> > @@ -3011,7 +3015,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> >      CXLUpdateDCExtentListInPl *in = (void *)payload_in;
> >      CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> >      CXLDCExtentList *extent_list = &ct3d->dc.extents;
> > -    uint32_t i;
> > +    uint32_t i, num;
> >      uint64_t dpa, len;
> >      CXLRetCode ret;
> >  
> > @@ -3020,7 +3024,8 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> >      }
> >  
> >      if (in->num_entries_updated == 0) {
> > -        cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> > +        num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> > +        ct3d->dc.total_extent_count -= num;
> >          return CXL_MBOX_SUCCESS;
> >      }
> >  
> > @@ -3051,10 +3056,12 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> >  
> >          cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> >          ct3d->dc.total_extent_count += 1;
> > +        ct3d->dc.nr_extents_accepted += 1;
> >          ct3_set_region_block_backed(ct3d, dpa, len);
> >      }
> >      /* Remove the first extent group in the pending list */
> > -    cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> > +    num = cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);
> > +    ct3d->dc.total_extent_count -= num;
> >  
> >      return CXL_MBOX_SUCCESS;
> >  }
> > @@ -3160,7 +3167,7 @@ free_and_exit:
> >          }
> >          *updated_list_size = 0;
> >      } else {
> > -        *updated_list_size = ct3d->dc.total_extent_count + cnt_delta;
> > +        *updated_list_size = ct3d->dc.nr_extents_accepted + cnt_delta;
> >      }
> >  
> >      return ret;
> > @@ -3222,7 +3229,10 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
> >          ct3_set_region_block_backed(ct3d, ent->start_dpa, ent->len);
> >          cxl_remove_extent_from_extent_list(&updated_list, ent);
> >      }
> > -    ct3d->dc.total_extent_count = updated_list_size;
> > +    ct3d->dc.total_extent_count += (updated_list_size -
> > +                                    ct3d->dc.nr_extents_accepted);
> > +
> > +    ct3d->dc.nr_extents_accepted = updated_list_size;
> >  
> >      return CXL_MBOX_SUCCESS;
> >  }
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 94e7274912..f283178d88 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -2076,6 +2076,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
> >      }
> >      if (group) {
> >          cxl_extent_group_list_insert_tail(&dcd->dc.extents_pending, group);
> > +        dcd->dc.total_extent_count += num_extents;
> >      }
> >  
> >      /*
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index ed6cd50c67..a151e19da8 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -618,6 +618,7 @@ struct CXLType3Dev {
> >          CXLDCExtentList extents;
> >          CXLDCExtentGroupList extents_pending;
> >          uint32_t total_extent_count;
> > +        uint32_t nr_extents_accepted;
> >          uint32_t ext_list_gen_seq;
> >  
> >          uint8_t num_regions; /* 0-8 regions */
> > @@ -696,7 +697,7 @@ CXLDCExtentGroup *cxl_insert_extent_to_extent_group(CXLDCExtentGroup *group,
> >                                                      uint16_t shared_seq);
> >  void cxl_extent_group_list_insert_tail(CXLDCExtentGroupList *list,
> >                                         CXLDCExtentGroup *group);
> > -void cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
> > +uint32_t cxl_extent_group_list_delete_front(CXLDCExtentGroupList *list);
> >  void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> >                                   uint64_t len);
> >  void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,


