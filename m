Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46DDC61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 18:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNc2r-0008AK-W9; Fri, 06 Jun 2025 14:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uNc2o-0008A6-4y
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 14:43:58 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uNc2l-0000kB-Gv
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 14:43:57 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22d95f0dda4so31325365ad.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 11:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749235434; x=1749840234; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mhv/7vS6onvDQS4kU+erZtxBqbLvtfmSsjoBZc0m6TY=;
 b=LtMxU7q70vC6JAKmonU4oZgJ6UI9H+dkG9KS1hORkj5L8WUWHdERkJMwSVsE7RO2S1
 Rr5O92+uXB+qPZVA+G+ne4uG9p+SXXh6ZI6SViNIoYFSyGLjNi/1UjJ/RoSTI6pyKOZD
 5fiemezOA/3X/Ich9C6cd/gfu7HEgPDFAlS97KO4wwCnhgARhnEwE43LPZyT7n3lN3Nr
 59tlre619OT6yERVj3gd8+7wgbYXQkfHwEnsFr0ipH9lwsqLAKeMtP/eULMyS8CLQcDZ
 Qg/ohKhLBUF77/6eX4qVw2hAFZ6jG8l5WPVg64cmpt4GvPwbOC9076j6/jxZ2dsKKdWJ
 t2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749235434; x=1749840234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mhv/7vS6onvDQS4kU+erZtxBqbLvtfmSsjoBZc0m6TY=;
 b=ZIQeKA1l6wRFvvd0zxi602M/hgGfWD5Oh0+AewdC7ILupL7EZNvoM+WZKQ3Kbc0boR
 0mHTqsG9SxyOIkUsmoul7QyjEy/Zq23oGpVYDrd3hB4d4pdm1hlhB9uoghTszJ9RD/Gm
 9FB62Srh65GWr65m/KxaAqVVxSBg5vXohcxJIH8hsj7w2aJ/JzyM3J7xnDfe3+pXRWas
 TBL4KAuDzhOJq3vmJDv+y/ALMUafCv/Er06xlHoP1OT5E9uzMZppKuQNLq9vcVwd/9+M
 PahOgw3VXqfgXBjh8LBclvJOfvgcyIz5lbAYour+D+gsudrOT0R4kAAKvQnkJoWSMNMB
 7Rxg==
X-Gm-Message-State: AOJu0Yy7n8SnVCidU5CllkdIoFf44swwb50OhUDy4285YT3SUHj29f06
 Pe8e4LW62QKEToeSGxmcyGzoOrcIW5W59/tWceOxk4109vllhPOatH58tY/mRQ==
X-Gm-Gg: ASbGncv1sfFT3WdznEI23qb7BkXo3dFVLmQG8q8cXd59c6LgdXIPvOi/wD5CmLr5FCp
 Ba7d1AasIH6zyZySRnn+Mc5RRXNSfNk/dQHmkSHaXZejoymoZFlD9Q2sbElzEbrg40Vx0v0TNtM
 Ppbi++xjcVHp3e4jDAtWLAxKESrEv9wGp2upxEOwVtnxKg9gjDQ4ZuS1N0EBTzLTZUizqETMK9q
 qSamEdxmnEYMAvWE2hSYzaXuaqTzME/NfpJ6PuEGsl9XBQD3XVIBXl616kYq/4IeLV9MAsHj5yR
 UgQbS5FBggmvEvguVYM70mmUehK3Cf36YiJ5kyJNqXCAPg==
X-Google-Smtp-Source: AGHT+IHIN9GBxzwrNzoZfcy0V1hXqGtfx43t6qLxVC2WhfNFmXSFsrzjCVgmUj8VZLBUHn0L75ParQ==
X-Received: by 2002:a17:902:f54f:b0:234:8ec1:4ad3 with SMTP id
 d9443c01a7336-23601d71b8bmr68810945ad.40.1749235434045; 
 Fri, 06 Jun 2025 11:43:54 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:5e33:e006:dcd5:852d])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2f5ef88914sm1487793a12.33.2025.06.06.11.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 11:43:53 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 6 Jun 2025 11:43:51 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v3 9/9] cxl-mailbox-utils: 0x5605 - FMAPI Initiate
 DC Release
Message-ID: <aEM25yCeErixfi0l@debian>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
 <20250605234227.970187-10-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605234227.970187-10-anisa.su887@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x630.google.com
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

On Thu, Jun 05, 2025 at 11:42:23PM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Managment command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>

See below ..

> ---
>  hw/cxl/cxl-mailbox-utils.c | 62 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 7ee5be00bc..6c57e0deac 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -124,6 +124,7 @@ enum {
>          #define SET_DC_REGION_CONFIG        0x2
>          #define GET_DC_REGION_EXTENT_LIST   0x3
>          #define INITIATE_DC_ADD             0x4
> +        #define INITIATE_DC_RELEASE         0x5
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3685,6 +3686,60 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x7
> +/* CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h) */
> +static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLCCI *cci)
> +{
> +    struct {
> +        uint16_t host_id;
> +        uint8_t flags;
> +        uint8_t reg_num;
> +        uint64_t length;
> +        uint8_t tag[0x10];
> +        uint32_t ext_count;
> +        CXLDCExtentRaw extents[];
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLUpdateDCExtentListInPl *list;
> +    CXLDCExtentList updated_list;
> +    uint32_t updated_list_size;
> +    int rc;
> +
> +    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
> +    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
> +        list = calloc(1, (sizeof(*list) +
> +                          in->ext_count * sizeof(*list->updated_entries)));

Use g_malloc() and free with g_free();

> +        convert_raw_extents(in->extents, list, in->ext_count);
> +        rc = cxl_detect_malformed_extent_list(ct3d, list);
> +        if (rc) {
> +            return rc;
> +        }
> +        rc = cxl_dc_extent_release_dry_run(ct3d,
> +                                           list,
> +                                           &updated_list,
> +                                           &updated_list_size);

This seems not right.
this is only fm issue dc release request, not host release dc extents to device.
So we should follow what we did in the qmp_cxl_process_dynamic_capacity_prescriptive()
for release case.

One thing that I can see that making the workflow is different is that, we check
the extent list with the pending list to make sure fm is not trying to remove
non-accepted extents, but the host release extent workflow does not need to do
that as it is filtered out in the first place when fm sends the request if it is
from FM.
I have to admit, existing qmp interface can be improved to remove some condition
checks as they are kind of duplicate.
For example, if an extent is still pending, it will not be set in the bitmap, so
we can still tigger the error if it happens by removing the pending list check.
One justification is that the error message is different for a non-existing
extent and a pending extent, which is useful for a dmp interface.


Also, the case to detect exhausted resouces is not different, FM can request to
release a lot of extents, but what the host actually does can be a subset or
none.

Fan

> +        if (rc) {
> +            return rc;
> +        }
> +        cxl_mbox_create_dc_event_records_for_extents(ct3d,
> +                                                     DC_EVENT_RELEASE_CAPACITY,
> +                                                     in->extents,
> +                                                     in->ext_count);
> +        return CXL_MBOX_SUCCESS;
> +    default:
> +        qemu_log_mask(LOG_UNIMP,
> +            "CXL extent selection policy not supported.\n");
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3819,6 +3874,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
>          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
>          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
>          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
> +    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
> +        cmd_fm_initiate_dc_release, ~0,
> +        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
> +         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
> +         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
> +         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
>  };
>  
>  /*
> -- 
> 2.47.2
> 

