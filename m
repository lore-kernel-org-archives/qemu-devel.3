Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83BAC61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 17:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNauO-0007DL-Ps; Fri, 06 Jun 2025 13:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNauD-0007BM-Eu
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 13:31:03 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNau8-0000Sb-Fj
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 13:30:59 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-742c035f2afso1831102b3a.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 10:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749231054; x=1749835854; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CxdNKgrqZ4mlo4Y16FRnlcHMC/6R6WSdYbc8k3t07Ig=;
 b=Gn2dyqifHKBCGYMb5/e/fSM8WYcsmb+1pHGeJbnnA8csF/YyXsl7TZGgr6rHN0+W8M
 bjfpIq+DP4E0KQgOJv4gn1QLVVFbCgXHYJAZfGKTuBzbx9u53V0w3wuGWM3GhVBMnWfr
 xCM6JQCOCzySrEuOXdiCTdNwE7udyFkDVxuZY4RBGorg/hHx8m05eVclPVptiBIdYcFS
 zbdx/xuDJKAUuR+DgPlPJORICsyGhDRUhuVqVE9MSeuD0nW9Ns75iyfXn3zw4XFTqtmk
 RUdm+nkafWKvsLp7xgIzcWGUF5xXeuc2v2L7jpELL4w6tV72b/8I7k7Pusno/heod6Pc
 QEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749231054; x=1749835854;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CxdNKgrqZ4mlo4Y16FRnlcHMC/6R6WSdYbc8k3t07Ig=;
 b=MJmXAll83wkmRWiPCWYsEJhcLnd4jAiJ/Ds+bmK/8MZ08nUoJcFutcvpLr8rR5VoZn
 c3H9LETw+xXQvatrkNTUXr4N9HPpgftHsYJpqcxUDhMF2Xzg60TKn8DiTKfBE05kcobR
 7j2ex3KKa1DTEk4grzi7zD6kZIK/i9EGpMBclmHLfvVcem9zXQ3V2SXVH6uD0Y1cgKkP
 psGqpbEdDwHjJlhzcRy4rOKzWMUMU9CX2tPaUMGD8XP7m6s5WHf5ZPoEMqHBZG2HvRwE
 HBCUpAKK/VJfoPEIAcqAbbvlNgdaBOvT1UquvrQYGU6k4K/9iAjFNv3ehadilR1z9vx0
 /AMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgxl6INLS71dlYLUHOgk4bKUykhMBweJ0ILpBhE/6TklWm0ph1oceWIznmEtp7aViKXuZZHEl24lpn@nongnu.org
X-Gm-Message-State: AOJu0Yyqxd4Jo83euxJUODUWqh2nYl+QmIq2WKvUARCe/lngunDzqzKF
 PntYOAzTH6aF5ihsoEErfcK4jgJr+HZRoFTPtPcCJV+dQCGYVbfW+Yyj
X-Gm-Gg: ASbGncvy+Hx1VuW6/1rWWSTUmtPA0rnCYDTL4iqPzOPPOLf8z5I0Rjby6yZeY7M1WQr
 lZBJL9S9dyBRYjfz2gHmviP2MbUAwqAg67e+Jo3NLe8/dh7gnVXh4UH38vb9ENyAgAYWRRU3nx+
 GlDwxG22W2bVdsoo/6MSA49EivxPwkKOqMwA6NK67EkzSY4SQPLkRw1rpKNcs8/kCtLxm5yvetn
 qT+Iq5mLgsVRKyPSdc12KCMsOla2DTKl0odqTer+Ggn1ZdIsQRwbuXzhdGSXGjRv+Xm1VvZfX76
 cuuwisvfsHvFQNkjVJqdt696tNkMr2iJcoFOikYe+bPgLnnqf+WtKxv0bC2IKmIQblM9mzxQsca
 0Uw==
X-Google-Smtp-Source: AGHT+IFOzMA5Cqnh+K6VMneGojR2gXXdnew3bx5tBfjGhADyY6uKkwBXeWQzURg0+3lzGnsa85lbJA==
X-Received: by 2002:a17:90b:4990:b0:2fa:157e:c790 with SMTP id
 98e67ed59e1d1-31346b0411emr5629239a91.5.1749231053576; 
 Fri, 06 Jun 2025 10:30:53 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31349fdfe58sm1562497a91.38.2025.06.06.10.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 10:30:53 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 6 Jun 2025 17:30:51 +0000
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org
Subject: Re: [QEMU PATCH v3 8/9] cxl-mailbox-utils: 0x5604 - FMAPI Initiate
 DC Add
Message-ID: <aEMly5F8kdziHWzO@deb-101020-bm01.eng.stellus.in>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
 <20250605234227.970187-9-anisa.su887@gmail.com>
 <09aea84f-8c3f-4321-879d-35c8956b3573@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09aea84f-8c3f-4321-879d-35c8956b3573@oracle.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Jun 06, 2025 at 06:12:19PM +0530, ALOK TIWARI wrote:
> 
> 
> On 06-06-2025 05:12, anisa.su887@gmail.com wrote:
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > ---
> >   hw/cxl/cxl-mailbox-utils.c  | 152 ++++++++++++++++++++++++++++++++++++
> >   hw/mem/cxl_type3.c          |   8 +-
> >   include/hw/cxl/cxl_device.h |   4 +
> >   3 files changed, 160 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 004e502b22..7ee5be00bc 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -123,6 +123,7 @@ enum {
> >           #define GET_HOST_DC_REGION_CONFIG   0x1
> >           #define SET_DC_REGION_CONFIG        0x2
> >           #define GET_DC_REGION_EXTENT_LIST   0x3
> > +        #define INITIATE_DC_ADD             0x4
> >   };
> >   /* CCI Message Format CXL r3.1 Figure 7-19 */
> > @@ -3540,6 +3541,150 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
> >       return CXL_MBOX_SUCCESS;
> >   }
> > +static void cxl_mbox_dc_add_to_pending(CXLType3Dev *ct3d,
> > +                                       uint32_t ext_count,
> > +                                       CXLDCExtentRaw extents[])
> > +{
> > +    CXLDCExtentGroup *group = NULL;
> > +    int i;
> > +
> > +    for (i = 0; i < ext_count; i++) {
> > +        group = cxl_insert_extent_to_extent_group(group,
> > +                                                  extents[i].start_dpa,
> > +                                                  extents[i].len,
> > +                                                  extents[i].tag,
> > +                                                  extents[i].shared_seq);
> > +    }
> > +
> > +    cxl_extent_group_list_insert_tail(&ct3d->dc.extents_pending, group);
> > +    ct3d->dc.total_extent_count += ext_count;
> > +}
> > +
> > +static void cxl_mbox_create_dc_event_records_for_extents(CXLType3Dev *ct3d,
> > +                                                         CXLDCEventType type,
> > +                                                         CXLDCExtentRaw extents[],
> > +                                                         uint32_t ext_count)
> > +{
> > +    CXLEventDynamicCapacity event_rec = {};
> > +    int i;
> > +
> > +    cxl_assign_event_header(&event_rec.hdr,
> > +                            &dynamic_capacity_uuid,
> > +                            (1 << CXL_EVENT_TYPE_INFO),
> > +                            sizeof(event_rec),
> > +                            cxl_device_get_timestamp(&ct3d->cxl_dstate));
> > +    event_rec.type = type;
> > +    event_rec.validity_flags = 1;
> > +    event_rec.host_id = 0;
> > +    event_rec.updated_region_id = 0;
> > +    event_rec.extents_avail = CXL_NUM_EXTENTS_SUPPORTED -
> > +                              ct3d->dc.total_extent_count;
> > +
> > +    for (i = 0; i < ext_count; i++) {
> > +        memcpy(&event_rec.dynamic_capacity_extent,
> > +               &extents[i],
> > +               sizeof(CXLDCExtentRaw));
> > +        event_rec.flags = 0;
> > +        if (i < ext_count - 1) {
> > +            /* Set "More" flag */
> > +            event_rec.flags |= BIT(0);
> > +        }
> > +
> > +        if (cxl_event_insert(&ct3d->cxl_dstate,
> > +                             CXL_EVENT_TYPE_DYNAMIC_CAP,
> > +                             (CXLEventRecordRaw *)&event_rec)) {
> > +            cxl_event_irq_assert(ct3d);
> > +        }
> > +    }
> > +}
> > +
> > +/*
> > + * Helper function to convert CXLDCExtentRaw to CXLUpdateDCExtentListInPl
> > + * in order to reuse cxl_detect_malformed_extent_list() functin which accepts
> 
> typo functin
> 
> > + * CXLUpdateDCExtentListInPl as a parameter.
> > + */
> > +static void convert_raw_extents(CXLDCExtentRaw raw_extents[],
> > +                                CXLUpdateDCExtentListInPl *extent_list,
> > +                                int count)
> > +{
> > +    int i;
> > +
> > +    extent_list->num_entries_updated = count;
> > +
> > +    for (i = 0; i < count; i++) {
> > +        extent_list->updated_entries[i].start_dpa = raw_extents[i].start_dpa;
> > +        extent_list->updated_entries[i].len = raw_extents[i].len;
> > +    }
> > +}
> > +
> > +/* CXL r3.2 Section 7.6.7.6.5 Initiate Dynamic Capacity Add (Opcode 5604h) */
> > +static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> > +                                         uint8_t *payload_in,
> > +                                         size_t len_in,
> > +                                         uint8_t *payload_out,
> > +                                         size_t *len_out,
> > +                                         CXLCCI *cci)
> > +{
> > +    struct {
> > +        uint16_t host_id;
> > +        uint8_t selection_policy;
> > +        uint8_t reg_num;
> > +        uint64_t length;
> > +        uint8_t tag[0x10];
> > +        uint32_t ext_count;
> > +        CXLDCExtentRaw extents[];
> > +    } QEMU_PACKED *in = (void *)payload_in;
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    CXLUpdateDCExtentListInPl *list;
> > +    int i, rc;
> > +
> > +    switch (in->selection_policy) {
> > +    case CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE:
> > +        /* Adding extents exceeds device's extent tracking ability. */
> > +        if (in->ext_count + ct3d->dc.total_extent_count >
> > +            CXL_NUM_EXTENTS_SUPPORTED) {
> > +            return CXL_MBOX_RESOURCES_EXHAUSTED;
> > +        }
> > +
> > +        list = calloc(1, (sizeof(*list) +
> > +                          in->ext_count * sizeof(*list->updated_entries)));
> > +        convert_raw_extents(in->extents, list, in->ext_count);
> > +        rc = cxl_detect_malformed_extent_list(ct3d, list);
> > +
> > +        for (i = 0; i < in->ext_count; i++) {
> > +            CXLDCExtentRaw ext = in->extents[i];
> > +             /* Check requested extents do not overlap with pending extents. */
> > +            if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> > +                                                     ext.start_dpa, ext.len)) {
> > +                return CXL_MBOX_INVALID_EXTENT_LIST;
> > +            }
> > +            /* Check requested extents do not overlap with existing extents. */
> > +            if (cxl_extents_overlaps_dpa_range(&ct3d->dc.extents,
> > +                                               ext.start_dpa, ext.len)) {
> > +                return CXL_MBOX_INVALID_EXTENT_LIST;
> > +            }
> > +        }
> > +
> > +        if (rc) {
> > +            return rc;
> 
> is list free not require ?
> 
oh yeah it's definitely required :( that was dumb of me, same for the
next patch.

Thanks for catching that!
-Anisa
> > +        }
> > +
> > +        cxl_mbox_dc_add_to_pending(ct3d, in->ext_count, in->extents);
> > +        cxl_mbox_create_dc_event_records_for_extents(ct3d,
> > +                                                     DC_EVENT_ADD_CAPACITY,
> > +                                                     in->extents,
> > +                                                     in->ext_count);
> > +
> > +        return CXL_MBOX_SUCCESS;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP,
> > +                      "CXL extent selection policy not supported.\n");
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    return CXL_MBOX_SUCCESS;
> 
> CXL_MBOX_SUCCESS, this is unreachable
> 
> > +}
> > +
> >   static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >       [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
> >           cmd_infostat_bg_op_abort, 0, 0 },
> > @@ -3667,6 +3812,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> >            CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> >       [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
> >           cmd_fm_get_dc_region_extent_list, 12, 0 },
> > +    [FMAPI_DCD_MGMT][INITIATE_DC_ADD] = { "INIT_DC_ADD",
> > +        cmd_fm_initiate_dc_add, ~0,
> > +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> > +        CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> > +        CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > +        CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > +        CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> >   };
> 
> 
> Thanks,
> Alok

