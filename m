Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6D2C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 19:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNcsg-0007NA-SO; Fri, 06 Jun 2025 15:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNcsf-0007Mh-8j
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:37:33 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNcsX-0006Xa-Uu
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:37:32 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-74800b81f1bso2040809b3a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749238644; x=1749843444; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/Jp+ZmHZi5JCiUXvLUvDXRKSUfFO3Yl8SYrgOARBxt0=;
 b=daHqQu4ybgguUtwj5VXLHWnEZV2PN9+mqxomJAA5P1NSeFdKeN64WN3b3MvL++V0u0
 WYvsUNODXXKO4zhdjIFvGQIEg4coBLdomFNuzIi2ROBll67E2t586teLOPKvgle5wr8e
 MTcgIM1HBEm7Dav/MHaRCmi5Yjd8wgjuY57/R61DDamjczU2BBCEUMtLw6Z88VR3ZluX
 k9ZaZLjaoCDCSdb+H99fWJXMcLiWsQ3sxkEMS7e99LkpcBfXffI5KBnqGZTL26bdN4Hp
 g8c+HRQ6ziM1vYfp6dEN5805PMrwqIjazqqrr74ustr32ofRZW9YS1TxiCwWrN8Byl/2
 y4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749238644; x=1749843444;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Jp+ZmHZi5JCiUXvLUvDXRKSUfFO3Yl8SYrgOARBxt0=;
 b=aJOBHMZzm+09CYg0SPC0x3Ic/oDEZ7H58303XeRNY0V3dsPKdMRwUNWifc/X9a4Pq4
 ldhx4VkM+xYBf2IKUInEUczern3bjAx/eH80ztPTy2xwOir/1Y/IwJvCUf7xBHuN1ZrY
 9s3+5CmnVzEbmP83WY9WuaoQteZ1vSWBuFAwcfgTQ2LqNqSis8xoF90//kAoO/CIxJch
 aSZUXF8RkFGqPRpQwQVORcZBeJHDjXnhOzc0RQ6jCns6qyEAjMVn23TmebX1YkhAb9Xe
 v81eVEMEgb/N7GYY1Ra+58qDxaAdxW2cE9lwoHDocy/WydwChHCoB4XJOctA61whxg/w
 CaGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXynA8maWnKJhQAg6ab/hQ37juGW/y1NmyO/sYexbg7z0EIcsVgxMlOEibpjC4YF77qn3w+lUXCMjdg@nongnu.org
X-Gm-Message-State: AOJu0YysogXYAxLbE8KdkBac52La81sfoWmcKDRHIgX+h3dYozwiA9J0
 0NFs/psmVD+OYT4dgGY5BOUHpN1obVv4RHMChvzt2KcZq3YgANVBabXP
X-Gm-Gg: ASbGncuuuJ9WRLuCCi3SSA9Mk5hDS2/HHMZDR9P1L5hL5B38eGPilTOjd40nPaakxjC
 139oAmjSS3Nhh3ub8O0ZQz67ABgG4JB8ALdfuBItrRJoDQWa7igzHJ/VY27oqD8lgWwHAk3DSXf
 2ySU5Bl/Pab1qLA0OkFO3Q944qrts7axSj3ykicJmjX0+kVrvWkeSm/5n0gurBHdUtv76Yaq1ok
 HTdQ1IXMjQV2HPhVSR+732IGwhlQTW3Mw9j22aln2KFkcHVYvB1l4yDwXCl2odwJvra1XGYf5Vu
 vlZpzHDQCS76ZDJbW9lMPVBao7lXWw8ZOoUaOLAslRUZcUyeCye3U3Zts0quT9Jy7qqtwU/8PbC
 o6y06Q2LkCx+v
X-Google-Smtp-Source: AGHT+IGGrpMX4eZ8myDehK2P4WTu+9wq9+Cnj/ct+GvCo4Qd6LZ+zhGTokm9xiJA51HFXf0P4wZt+A==
X-Received: by 2002:a05:6a00:488b:b0:748:2eb7:8cc7 with SMTP id
 d2e1a72fcca58-7482eb793b6mr3073279b3a.21.1749238639431; 
 Fri, 06 Jun 2025 12:37:19 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b083abcsm1695664b3a.92.2025.06.06.12.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 12:37:19 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 6 Jun 2025 19:37:17 +0000
To: Fan Ni <nifan.cxl@gmail.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [QEMU PATCH v3 9/9] cxl-mailbox-utils: 0x5605 - FMAPI Initiate
 DC Release
Message-ID: <aENDbaFuj4df46eA@deb-101020-bm01.eng.stellus.in>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
 <20250605234227.970187-10-anisa.su887@gmail.com>
 <aEM25yCeErixfi0l@debian> <aEM4AXOJLMq7nqZp@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEM4AXOJLMq7nqZp@debian>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Jun 06, 2025 at 11:48:33AM -0700, Fan Ni wrote:
> On Fri, Jun 06, 2025 at 11:43:51AM -0700, Fan Ni wrote:
> > On Thu, Jun 05, 2025 at 11:42:23PM +0000, anisa.su887@gmail.com wrote:
> > > From: Anisa Su <anisa.su@samsung.com>
> > > 
> > > FM DCD Managment command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6
> > > 
> > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > 
> > See below ..
> > 
> > > ---
> > >  hw/cxl/cxl-mailbox-utils.c | 62 ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 62 insertions(+)
> > > 
> > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > index 7ee5be00bc..6c57e0deac 100644
> > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > @@ -124,6 +124,7 @@ enum {
> > >          #define SET_DC_REGION_CONFIG        0x2
> > >          #define GET_DC_REGION_EXTENT_LIST   0x3
> > >          #define INITIATE_DC_ADD             0x4
> > > +        #define INITIATE_DC_RELEASE         0x5
> > >  };
> > >  
> > >  /* CCI Message Format CXL r3.1 Figure 7-19 */
> > > @@ -3685,6 +3686,60 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> > >      return CXL_MBOX_SUCCESS;
> > >  }
> > >  
> > > +#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x7
> > > +/* CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h) */
> > > +static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
> > > +                                             uint8_t *payload_in,
> > > +                                             size_t len_in,
> > > +                                             uint8_t *payload_out,
> > > +                                             size_t *len_out,
> > > +                                             CXLCCI *cci)
> > > +{
> > > +    struct {
> > > +        uint16_t host_id;
> > > +        uint8_t flags;
> > > +        uint8_t reg_num;
> > > +        uint64_t length;
> > > +        uint8_t tag[0x10];
> > > +        uint32_t ext_count;
> > > +        CXLDCExtentRaw extents[];
> > > +    } QEMU_PACKED *in = (void *)payload_in;
> > > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > > +    CXLUpdateDCExtentListInPl *list;
> > > +    CXLDCExtentList updated_list;
> > > +    uint32_t updated_list_size;
> > > +    int rc;
> > > +
> > > +    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
> > > +    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
> > > +        list = calloc(1, (sizeof(*list) +
> > > +                          in->ext_count * sizeof(*list->updated_entries)));
> > 
> > Use g_malloc() and free with g_free();
> > 
> > > +        convert_raw_extents(in->extents, list, in->ext_count);
> > > +        rc = cxl_detect_malformed_extent_list(ct3d, list);
> > > +        if (rc) {
> > > +            return rc;
> > > +        }
> > > +        rc = cxl_dc_extent_release_dry_run(ct3d,
> > > +                                           list,
> > > +                                           &updated_list,
> > > +                                           &updated_list_size);
> > 
> > This seems not right.
> > this is only fm issue dc release request, not host release dc extents to device.
> > So we should follow what we did in the qmp_cxl_process_dynamic_capacity_prescriptive()
> > for release case.
> > 
> > One thing that I can see that making the workflow is different is that, we check
> > the extent list with the pending list to make sure fm is not trying to remove
> > non-accepted extents, but the host release extent workflow does not need to do
> > that as it is filtered out in the first place when fm sends the request if it is
> > from FM.
> > I have to admit, existing qmp interface can be improved to remove some condition
> > checks as they are kind of duplicate.
> > For example, if an extent is still pending, it will not be set in the bitmap, so
> > we can still tigger the error if it happens by removing the pending list check.
> > One justification is that the error message is different for a non-existing
> > extent and a pending extent, which is useful for a dmp interface.
> > 
> > 
> > Also, the case to detect exhausted resouces is not different, FM can request to
> 
> s/is not different/is different/
> I am not sure what I was thinking..
> 
> Fan
I'm confused though because in the 3.2 spec it says "The command shall fail with
Resources Exhausted if the Extent List would cause the device to exceed its
extent or tag tracking ability" (Section 7.6.7.6.6).

The only way that releasing an extent can cause the number of extents to
increase is if the middle section of an existing extent is released,
which is why I used cxl_dc_extent_release_dry_run(), since it already
detects that case.

Anisa
> > release a lot of extents, but what the host actually does can be a
> > subset or
> > none.
> > 
> > Fan
> > 
> > > +        if (rc) {
> > > +            return rc;
> > > +        }
> > > +        cxl_mbox_create_dc_event_records_for_extents(ct3d,
> > > +                                                     DC_EVENT_RELEASE_CAPACITY,
> > > +                                                     in->extents,
> > > +                                                     in->ext_count);
> > > +        return CXL_MBOX_SUCCESS;
> > > +    default:
> > > +        qemu_log_mask(LOG_UNIMP,
> > > +            "CXL extent selection policy not supported.\n");
> > > +        return CXL_MBOX_INVALID_INPUT;
> > > +    }
> > > +
> > > +    return CXL_MBOX_SUCCESS;
> > > +}
> > > +
> > >  static const struct cxl_cmd cxl_cmd_set[256][256] = {
> > >      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
> > >          cmd_infostat_bg_op_abort, 0, 0 },
> > > @@ -3819,6 +3874,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> > >          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > >          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > >          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> > > +    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
> > > +        cmd_fm_initiate_dc_release, ~0,
> > > +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> > > +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> > > +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> > > +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> > > +         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> > >  };
> > >  
> > >  /*
> > > -- 
> > > 2.47.2
> > > 

