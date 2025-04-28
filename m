Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1045EC369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 20:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9VIN-0002E9-9s; Mon, 28 Apr 2025 16:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1u9VIE-0002Dk-RG
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:41:36 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1u9VIC-0005wy-Rl
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:41:34 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7c07cd527e4so573813185a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 13:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745872890; x=1746477690; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i3y1FOUgVsX87EjiOelwWpjlR6C+c3ULMgqt0TDK/U4=;
 b=Xc7nfAMDajD0yubg1bkug5OzjIID3YkhXbvFldHNFYdW9WHoq0M9phAmC5/QvGVLSc
 zibW9djw8litnrqSTZkFK5PARDUYzpGifA2ELwvE1Mh4ByrAidlArWp4e060VWnW88yr
 3PalRp3fS3t6t3JWEG1Cq2AGO7Ag9bAoNLdquW2IXbg+/YLzapvCBddE3cg83eJei/M+
 1IyLnJK6wSidaohI0YbRw67XuRCZ23mk1DZo8LEH4Wf3Wtcq6zLuCmWxdSdw+T8+wAe6
 yIF26adlnlGSnc8twFTxtdaRYQ4zl/Ug5GPKBiOInEZJ1J0/gVOJlbRkAkcp48m/tGE6
 cWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745872890; x=1746477690;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3y1FOUgVsX87EjiOelwWpjlR6C+c3ULMgqt0TDK/U4=;
 b=D0+DMFKQym7Z4DIi5osLPMEIMfZTqLjYnKkYBPxBQRSrFAyGuKaUZS83NP6xyP3aTr
 O7LdcizguSTjM8bJmMq37lHts+R51KGkUAZ5k98Fv/IRwQIL8DRz/p3/pt7NrhC39wMF
 sa/YrIIDQli7mIQUAKQy8ceAg4lZ+5Dg2IFXDmR7Djm6FJkuaJ1NMtpruzMff/c1ME11
 xV1XhB1Nn7V5spr+G3twUzdb0sVCUntslZYo3fRBut3Km+QQzmaurl/Lc18Dg00rgwO/
 RapaMR57FcFnV66biD8iRv2GqDHOQaNz85K0YeyO4H0j1372apbEHSG8Ni2yjNdfO1gr
 OTJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGCFMr20FGDNlNOddcqY4Wj4SrlBvZry+RWBQf4B8qTdpUCzfT4F6IPgEltG1LTyykb9+EnF1XInoz@nongnu.org
X-Gm-Message-State: AOJu0YyIGr5dYoAil/YzAH86QMQ1B3aAc/1vF7nYaaqPOmKySTLV8wQa
 9swQoBfr+S6+/k4LieMhZY5ipK92f3py0cl7gGQfvnsIq+68QIIe
X-Gm-Gg: ASbGncsq3kSb0tJoQeqibGXVO9DsvzHiZpUlHsfSTQIpW62MaSVk0j0V68B7gXbbuKi
 Prh2DH6ugb7KD+1EwOe/IdMVXNwe9p++hDQhQmwRnxLlaBxD3iiqKAJLaOrsIioIX4nLyfHHOXu
 QoEx8Ec/HhqzyQMVgSG8alEdJdWzZTl0R3NeO/x0RvOeFbE2oX5Z5iCql5efVolqkcq1iKsypno
 nsUWbYNTYjAUCD+YJS7tRbkR25FQHVdIt1W+1mGD9mvAw1j2De683y9Y8NsexLdgBt30vn38bSJ
 PH1/OypQw5je1PGqdXAlElqI/FYZGaUhJ6weoGIeL8PdogA=
X-Google-Smtp-Source: AGHT+IHNqNM0/K7R18Z+/wdJ5hnZgIUYtFZ42eZb2MV9sb2ddzPiGZ7AhaalPTbFX8922hmIw3OrhA==
X-Received: by 2002:a05:620a:17a3:b0:7c9:5ec2:a82c with SMTP id
 af79cd13be357-7cabe664730mr90461185a.53.1745872889935; 
 Mon, 28 Apr 2025 13:41:29 -0700 (PDT)
Received: from debian ([2607:fb90:37e2:c851:8e4d:2d6e:a358:8db0])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958e9fbcasm662133685a.99.2025.04.28.13.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 13:41:29 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 28 Apr 2025 13:41:24 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 8/9] cxl-mailbox-utils: 0x5604 -  FMAPI Initiate DC Add
Message-ID: <aA_n9NMY8CxLNtr-@debian>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-9-anisa.su887@gmail.com>
 <20250424121959.0000042d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424121959.0000042d@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=nifan.cxl@gmail.com; helo=mail-qk1-x730.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 24, 2025 at 12:19:59PM +0100, Jonathan Cameron wrote:
> On Mon, 17 Mar 2025 16:31:35 +0000
> anisa.su887@gmail.com wrote:
> 
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > ---
...
> > +            CXL_NUM_EXTENTS_SUPPORTED) {
> > +            return CXL_MBOX_RESOURCES_EXHAUSTED;
> > +        }
> > +        rc = cxl_mbox_dc_prescriptive_sanity_check(ct3d,
> > +                                                   in->host_id,
> > +                                                   in->ext_count,
> > +                                                   in->extents,
> > +                                                   DC_EVENT_ADD_CAPACITY);
> > +        if (rc) {
> > +            return rc;
> > +        }
> > +
> > +        /* Prepare extents for Event Record */
> > +        event_rec_exts = g_new0(CXLDCExtentRaw, in->ext_count);
> > +        for (i = 0; i < in->ext_count; i++) {
> > +            ext = in->extents[i];
> > +            event_rec_exts[i].start_dpa = ext.start_dpa;
> > +            event_rec_exts[i].len = ext.len;
> > +            memset(event_rec_exts[i].tag, 0, 0x10);
> > +            event_rec_exts[i].shared_seq = 0;
> > +
> > +            /* Check requested extents do not overlap with pending extents. */
> > +            if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> > +                                                     ext.start_dpa, ext.len)) {
> > +                return CXL_MBOX_INVALID_EXTENT_LIST;
> > +            }

The logic here seems not right. We need to have a separate pass to ensure all
the extents are valid, meaning aligned and no overlap themselves, AND no overlap
with accepted as well as pending extents. There should be no early error exit
like above when inserting into pending extent group.

> > +
> > +            /* Create extent group to add to pending list. */
> > +            group = cxl_insert_extent_to_extent_group(group,
> > +                                                      event_rec_exts[i].start_dpa,
> > +                                                      event_rec_exts[i].len,
> > +                                                      event_rec_exts[i].tag,
> > +                                                      event_rec_exts[i].shared_seq);
> > +        }
> > +
> > +        /* Add requested extents to pending list. */
> > +        if (group) {
> > +            cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
> > +        }
> > +
> > +        /* Create event record and insert to event log */
> > +        cxl_mbox_dc_event_create_record_hdr(ct3d, &event_rec.hdr);
> > +        event_rec.type = DC_EVENT_ADD_CAPACITY;
> > +        /* FIXME: for now, validity flag is cleared */
> 
> This stuff is probably all valid.  If we can return remaining extents though we might
> as well.
> 
> > +        event_rec.validity_flags = 0;
> > +        /* FIXME: Currently only support 1 host */
> > +        event_rec.host_id = 0;
> > +        /* updated_region_id only valid for DC_EVENT_REGION_CONFIG_UPDATED */
> > +        event_rec.updated_region_id = 0;
> 
> The event_rec is zeroed anyway so probably just don't set this at all
> and no need for the comment.
> 
> > +        for (i = 0; i < in->ext_count; i++) {
> 
> Why can't we combine this with the earlier loop and avoid the
> need for separate storage of extents in event_rec_exts?

As long as we make sure all the extents are valid, we should be able to do it
in one pass.

Fan
> 
> > +            memcpy(&event_rec.dynamic_capacity_extent,
> > +                   &event_rec_exts[i],
> > +                   sizeof(CXLDCExtentRaw));
> > +
> > +            event_rec.flags = 0;
> > +            if (i < in->ext_count - 1) {
> > +                /* Set "More" flag */
> > +                event_rec.flags |= BIT(0);
> > +            }
> > +
> > +            if (cxl_event_insert(&ct3d->cxl_dstate,
> > +                                 CXL_EVENT_TYPE_DYNAMIC_CAP,
> > +                                 (CXLEventRecordRaw *)&event_rec)) {
> > +                cxl_event_irq_assert(ct3d);
> > +            }
> > +        }
> > +
> > +        return CXL_MBOX_SUCCESS;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "CXL extent selection policy not supported.\n");
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
> >          cmd_infostat_bg_op_abort, 0, 0 },
> > @@ -3804,6 +3970,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> >           CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
> >      [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
> >          cmd_fm_get_dc_region_extent_list, 12, 0},
> > +    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
> > +        cmd_fm_initiate_dc_add, ~0,
> > +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> > +        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> > +        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > +        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > +        CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
> >  };
> >  
> >  /*
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index b742b2bb8d..ccc619fe10 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -1982,8 +1982,8 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
> >   * the list.
> >   * Return value: return true if has overlaps; otherwise, return false
> >   */
> > -static bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> > -                                           uint64_t dpa, uint64_t len)
> > +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> > +                                    uint64_t dpa, uint64_t len)
> >  {
> >      CXLDCExtent *ent;
> >      Range range1, range2;
> > @@ -2028,8 +2028,8 @@ bool cxl_extents_contains_dpa_range(CXLDCExtentList *list,
> >      return false;
> >  }
> >  
> > -static bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> > -                                                 uint64_t dpa, uint64_t len)
> > +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> > +                                          uint64_t dpa, uint64_t len)
> >  {
> >      CXLDCExtentGroup *group;
> >  
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 217003a29d..1d5831a0b6 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -809,4 +809,8 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> >  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
> >                               const QemuUUID *uuid, uint32_t flags,
> >                               uint8_t length, uint64_t timestamp);
> > +bool cxl_extents_overlaps_dpa_range(CXLDCExtentList *list,
> > +                                    uint64_t dpa, uint64_t len);
> > +bool cxl_extent_groups_overlaps_dpa_range(CXLDCExtentGroupList *list,
> > +                                          uint64_t dpa, uint64_t len);
> >  #endif
> 

