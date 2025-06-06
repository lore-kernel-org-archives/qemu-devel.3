Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B421C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 18:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNc7O-0000ZC-J8; Fri, 06 Jun 2025 14:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uNc7L-0000Z0-Fv
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 14:48:40 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uNc7J-00016r-QH
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 14:48:39 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-742c27df0daso2332137b3a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749235716; x=1749840516; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4XzwZXcFFnUPpq5lmaEWt4YpLE6Y/sVwaVTV0zUmG5U=;
 b=YkjgHzHlL6tHimjPg2ssTFPxOj1QG4rqIrWbwX3M2H64oXkcmCvNm/GBukZxnoeoSd
 lWEJvXSh3HF3D9zX0FjU6p53/9SqgU4vz1PWa0Z89mup8lKAqMygdARw/hV0raJlyMY5
 DQBl2Jp+bQEf2Jcksxs/YEEFgYrElDnGxVnYRoQEy9KmDHnoPDlTbC9STmw76UliSwVZ
 H4oa5KZ5QlFUHDKrTdy3wYZ1y89mv+4GIH96cdf1+GPJgDNk/33Cj2Qy8WY1QEH8qzn6
 fEclT4ZYmD2vdKHp6+o3FCq1o4AvX62x9mx8wbhESUPzEwCnQDfhVwowOmInis2pSkwu
 iDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749235716; x=1749840516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4XzwZXcFFnUPpq5lmaEWt4YpLE6Y/sVwaVTV0zUmG5U=;
 b=kDOOCOIeEJhCQl1ndwjNq4L6C+VKYDHs3KBCbHmfb1E9USxlhK4J4citJrGXWWVyln
 CydVSwVJq5jWlaCRE1NU+1bkeux+YAFNCWjvtoBGsNmZPrKsOoMwJJaaaAaiwwB+EKeg
 SGWSsNJw5DDJVG2UtHVf8MDye/0CTs/kUJlzi6NmaF/aiXL3BhbS++4nooWU+uQtDCd6
 wPa1DzFU52u3OkLsrySRwuKdCyO2llfK9tVXIyPYcMK6Ne01a1/L9NwQfmWDApcxwQke
 AzKnY/qkGpaY8oqwMPfCyR8ByA+cj/uBIYQ5yDpGcsmXqJJRlN3tmD2m64ipQVd6NdXs
 NAag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPU6uwVqWpOeNAJn/J/uILvvIgQ+KSfjvq7NwAXnKgmgWeun033pqlJ10ueWCZqy3lN+2o0VuPs8Wt@nongnu.org
X-Gm-Message-State: AOJu0YxvHeR7V7VPDL7YzRVPFuyKM8DdawcJJekYONutN/Zlesk7sJp+
 AkvyMKxN7nj1PCu/WkT5/MrnS+eZrqjdN1PgfkB/5Z5otkfgHuCGXcQv
X-Gm-Gg: ASbGnctmA2b/bCMR45Wtkof0KkRWXLFAuFKG9TCAX3LJPb2ROX0UzvAnB8eBZjgUcKn
 uc9gLmYPleqDYpgWOsit886pPiTVQJ5Ly84UfKWiMKfPQGs9dv4LVnRMTjxG0Oz//c9KHV10fY2
 rMEYjTfTvwbnNLgxr4pcSfcCuhmjVCuf0KQuk10w7rurDVlxTR7zCW5KWf25qz0iaSOTeBNkNR/
 Uehnn7eNdK2yAzwWJgJu+cslaFuuQc6hUa8biiawXMljgtdFgHhg/94DgVrN5aOc3KUmI7/8h+w
 mYwqRWDqfBHkn3kDgsudptS+137rIzCkNuVx0NeyKqaIIQ==
X-Google-Smtp-Source: AGHT+IG7V6H7umOyHTIJ1kyAYCca9dapZ1XD5673yteXoMhB/jDmMw8PnzXl7Ms6He6T8s7GJJdUog==
X-Received: by 2002:a05:6a20:9191:b0:21c:faa4:9ab9 with SMTP id
 adf61e73a8af0-21ee25489a7mr6168623637.22.1749235716004; 
 Fri, 06 Jun 2025 11:48:36 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0e9efasm1643162b3a.147.2025.06.06.11.48.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 11:48:35 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 6 Jun 2025 11:48:33 -0700
To: Fan Ni <nifan.cxl@gmail.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v3 9/9] cxl-mailbox-utils: 0x5605 - FMAPI Initiate
 DC Release
Message-ID: <aEM4AXOJLMq7nqZp@debian>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
 <20250605234227.970187-10-anisa.su887@gmail.com>
 <aEM25yCeErixfi0l@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEM25yCeErixfi0l@debian>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42a.google.com
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

On Fri, Jun 06, 2025 at 11:43:51AM -0700, Fan Ni wrote:
> On Thu, Jun 05, 2025 at 11:42:23PM +0000, anisa.su887@gmail.com wrote:
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > FM DCD Managment command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> 
> See below ..
> 
> > ---
> >  hw/cxl/cxl-mailbox-utils.c | 62 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 7ee5be00bc..6c57e0deac 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -124,6 +124,7 @@ enum {
> >          #define SET_DC_REGION_CONFIG        0x2
> >          #define GET_DC_REGION_EXTENT_LIST   0x3
> >          #define INITIATE_DC_ADD             0x4
> > +        #define INITIATE_DC_RELEASE         0x5
> >  };
> >  
> >  /* CCI Message Format CXL r3.1 Figure 7-19 */
> > @@ -3685,6 +3686,60 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> >  
> > +#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x7
> > +/* CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h) */
> > +static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
> > +                                             uint8_t *payload_in,
> > +                                             size_t len_in,
> > +                                             uint8_t *payload_out,
> > +                                             size_t *len_out,
> > +                                             CXLCCI *cci)
> > +{
> > +    struct {
> > +        uint16_t host_id;
> > +        uint8_t flags;
> > +        uint8_t reg_num;
> > +        uint64_t length;
> > +        uint8_t tag[0x10];
> > +        uint32_t ext_count;
> > +        CXLDCExtentRaw extents[];
> > +    } QEMU_PACKED *in = (void *)payload_in;
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    CXLUpdateDCExtentListInPl *list;
> > +    CXLDCExtentList updated_list;
> > +    uint32_t updated_list_size;
> > +    int rc;
> > +
> > +    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
> > +    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
> > +        list = calloc(1, (sizeof(*list) +
> > +                          in->ext_count * sizeof(*list->updated_entries)));
> 
> Use g_malloc() and free with g_free();
> 
> > +        convert_raw_extents(in->extents, list, in->ext_count);
> > +        rc = cxl_detect_malformed_extent_list(ct3d, list);
> > +        if (rc) {
> > +            return rc;
> > +        }
> > +        rc = cxl_dc_extent_release_dry_run(ct3d,
> > +                                           list,
> > +                                           &updated_list,
> > +                                           &updated_list_size);
> 
> This seems not right.
> this is only fm issue dc release request, not host release dc extents to device.
> So we should follow what we did in the qmp_cxl_process_dynamic_capacity_prescriptive()
> for release case.
> 
> One thing that I can see that making the workflow is different is that, we check
> the extent list with the pending list to make sure fm is not trying to remove
> non-accepted extents, but the host release extent workflow does not need to do
> that as it is filtered out in the first place when fm sends the request if it is
> from FM.
> I have to admit, existing qmp interface can be improved to remove some condition
> checks as they are kind of duplicate.
> For example, if an extent is still pending, it will not be set in the bitmap, so
> we can still tigger the error if it happens by removing the pending list check.
> One justification is that the error message is different for a non-existing
> extent and a pending extent, which is useful for a dmp interface.
> 
> 
> Also, the case to detect exhausted resouces is not different, FM can request to

s/is not different/is different/
I am not sure what I was thinking..

Fan
> release a lot of extents, but what the host actually does can be a subset or
> none.
> 
> Fan
> 
> > +        if (rc) {
> > +            return rc;
> > +        }
> > +        cxl_mbox_create_dc_event_records_for_extents(ct3d,
> > +                                                     DC_EVENT_RELEASE_CAPACITY,
> > +                                                     in->extents,
> > +                                                     in->ext_count);
> > +        return CXL_MBOX_SUCCESS;
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP,
> > +            "CXL extent selection policy not supported.\n");
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
> >          cmd_infostat_bg_op_abort, 0, 0 },
> > @@ -3819,6 +3874,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> >          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> >          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> >          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> > +    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
> > +        cmd_fm_initiate_dc_release, ~0,
> > +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> > +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> > +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > +         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> >  };
> >  
> >  /*
> > -- 
> > 2.47.2
> > 

