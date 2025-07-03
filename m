Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96BAC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 04:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXBS6-0000Aq-Dl; Thu, 03 Jul 2025 00:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uXBS3-0000AU-P2
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 00:21:36 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uXBRz-00067r-MO
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 00:21:34 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-74b54cead6cso890485b3a.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 21:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751516488; x=1752121288; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fIDvlsSqSOw663I1UGN4vr15Etm6Ryjr1eAaJmR2aMo=;
 b=gRk6UuuqbB1Ydhbu/FYgICGno5KvawOLWOcdBbCtHoIL0tkiwI2hWrB1iWSjrlGYJo
 Bmtvjj1yYFbwUB1hPaUlWJg3zmFeyz/gW8EwqNDMzTfQXkHO6K+COEKg9fIT1lWXbZeU
 6MdGTsEMJM9GmVXUsezrzuxHk+vV4XWYynZ1IBehwt+L/PRYpe2Rmz4gPAysp048uhTx
 gDs4nH2S7XwX6rngVg0TFqdx2nUbxCntYWzIjpcBZp3SMYCxPKOFc06s8ZFnp174xLJC
 ZjTEVz0j0AZ9e9QQ6bYtoj2v00vFZ3yNUf8s9zpP2zRX80KI1DY2Hpegjmpz3EyNWNmu
 dRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751516488; x=1752121288;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIDvlsSqSOw663I1UGN4vr15Etm6Ryjr1eAaJmR2aMo=;
 b=SXUczEEN0xb3QUGQgpI9WvDqeK1Rt1RxD7bUPtnLimI+3fBdg5nu+fvm8UmWciu7Sp
 Qut6YOklrMWeI+dug6h6tBDovrn4UeYjVSdRRIZGQTU+gyoEJYzhD8zTnIrYcv5knVkp
 ezy0xu0fzE8sG9/8dCuShyJoBf329ijP5c6EVKY67hGVeLm+g8Gp6xvgxnbx2T/OYG7/
 VF9IR2zbIJm+Dz6v09YngF/CV+YJbVQmgYoOvVdtgxaLDmNe05FYGoAkLxTtp6PKGBvg
 LTanP5A4GU6ch9wEw+SUxNKPUSlBtLNU/mig8BbxXuMaF45qmJ4FzsDtQk8e/XRF7Hgu
 vi0g==
X-Gm-Message-State: AOJu0YyUfUl//dIU8hmHmAGlYMOu+93I6UDGRyIKVmPsAa20si/4VoOs
 n2JnPa9mbAJRUfChaU4EKYO9yhqUaFORLkBNyWs+R4rHSATLC3fTUWO1
X-Gm-Gg: ASbGncs44mWpWzF7fiog/lahh7zCSezhgXQ1K0cOui1qBhzF1hOH7n3qYgq4XOV6SDq
 8LCtvfTx8MoBt/ErR+cY/sDdXn6LXYe5EvlrCO+GcNjluQAcThQeGVAEEnQc8nNU0ZY9uLLKXhd
 l6mKc0kA+J7Jablj38D9UhuYUGkcLskS0KuX4ueMaiRYs3loak/gr/8JdzXn1ZsYEElnn+lSfg6
 oD0vzDZFMUxJ+kIE30lR9hOKNeHJVqIXEKLJNtUH4oJP7pa0s7OM5s+ZqhdcoD6G9XEmQmQj448
 uyqjqu/CxUq6lsvGyvQgWjndN4P/2IQ2JqbbT2FjpetLZ2WAxIgQ6E5CVXEpruCnyg==
X-Google-Smtp-Source: AGHT+IGlupmibsI0pDmwjQl9fWAcuiv3qmPcB8r84N+pV87Txa7MPZdLwiYlKauTpNkaB3moTPSiYg==
X-Received: by 2002:a05:6a20:9d91:b0:20a:bde0:beb9 with SMTP id
 adf61e73a8af0-224096f882amr3187133637.1.1751516488205; 
 Wed, 02 Jul 2025 21:21:28 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b34e31da5f2sm14115461a12.58.2025.07.02.21.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 21:21:27 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 3 Jul 2025 04:21:25 +0000
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
 dave@stgolabs.net, alok.a.tiwari@oracle.com,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH v4 10/10] cxl-mailbox-utils: 0x5605 - FMAPI Initiate
 DC Release
Message-ID: <aGYFRdm7SEGbE6pu@smc-140338-bm01>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
 <20250626222743.1766404-11-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626222743.1766404-11-anisa.su887@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42b.google.com
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

On Thu, Jun 26, 2025 at 10:23:33PM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
Minor comments inline ...

>  hw/cxl/cxl-mailbox-utils.c | 79 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 787eeaa7b9..87f9535d46 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -123,6 +123,7 @@ enum {
>          #define SET_DC_REGION_CONFIG        0x2
>          #define GET_DC_REGION_EXTENT_LIST   0x3
>          #define INITIATE_DC_ADD             0x4
> +        #define INITIATE_DC_RELEASE         0x5
>  };
>  
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
> @@ -3638,6 +3639,77 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
>      }
>  }
>  
> +#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x0F
> +#define CXL_FORCED_REMOVAL_MASK (1 << 4)
> +/* CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h) */

/* CXL r3.2 Section 7.6.7.6.6: Initiate Dynamic Capacity Release (Opcode 5605h) */

Fan

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
> +    int i, rc;
> +
> +    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
> +        case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE: {
> +            CXLDCExtentList updated_list;
> +            uint32_t updated_list_size;
> +            g_autofree CXLUpdateDCExtentListInPl *list =
> +                g_malloc0(sizeof(*list) +
> +                    in->ext_count * sizeof(*list->updated_entries));
> +
> +            convert_raw_extents(in->extents, list, in->ext_count);
> +            rc = cxl_detect_malformed_extent_list(ct3d, list);
> +            if (rc) {
> +                return rc;
> +            }
> +
> +            /* Fail with Invalid PA if an extent is pending and Forced Removal
> +             * flag not set
> +             */
> +            if (!(in->flags & CXL_FORCED_REMOVAL_MASK)) {
> +                for (i = 0; i < in->ext_count; i++) {
> +                    CXLDCExtentRaw ext = in->extents[i];
> +                    /* Check requested extents don't overlap with pending extents. */
> +                    if (cxl_extent_groups_overlaps_dpa_range(&ct3d->dc.extents_pending,
> +                                                             ext.start_dpa, ext.len)) {
> +                        return CXL_MBOX_INVALID_PA;
> +                    }
> +                }
> +            }
> +
> +            rc = cxl_dc_extent_release_dry_run(ct3d,
> +                                               list,
> +                                               &updated_list,
> +                                               &updated_list_size);
> +            if (rc) {
> +                return rc;
> +            }
> +            cxl_create_dc_event_records_for_extents(ct3d,
> +                                                    DC_EVENT_RELEASE_CAPACITY,
> +                                                    in->extents,
> +                                                    in->ext_count);
> +            return CXL_MBOX_SUCCESS;
> +        }
> +        default: {
> +            qemu_log_mask(LOG_UNIMP,
> +                "CXL extent removal policy not supported.\n");
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +    }
> +}
> +
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
>          cmd_infostat_bg_op_abort, 0, 0 },
> @@ -3772,6 +3844,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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

-- 
Fan Ni (From gmail)

