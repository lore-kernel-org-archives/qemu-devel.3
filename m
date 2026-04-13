Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0752CEBFD0A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCBe6-00043h-Sq; Mon, 13 Apr 2026 03:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wCBe5-00043N-Fw
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 03:23:45 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wCBe4-0001oP-22
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 03:23:45 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c742b9b7727so1282950a12.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 00:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776065022; x=1776669822; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CM/BJEM0oQPnOgDJn2yySGpUjQTzbucI18FpRefJ+2c=;
 b=QhCB8wVoq2u1Zcqzq2Q01iDQHXiWMdwCjlt68+1uIJu8z6f4PiiQ90LTk2/h60lx1r
 mcH1hKqYpFvR/EUoGTHrH62opY3B7FvWoETWwyJfRG6cVpcj4Xr3sZf3rN1N0Uv1FGkX
 xveaLKtHy/zg/KuaN+wi/4pmj+unn7WBieRN2DyASsdWuyZzSHgeJIzRAse9C+5Bg9f/
 8w3I2y56pgLgaCb6Iu+1vop830Bt8IgoHijMVrtmAwEb3W5erGWUM2cHiR6bFe65fV48
 +zBtQDA9iGLX83hAzdAOqZekpbuJhPKMKKP6qLQAlyVkqwP+x2cIeLV6gEiHLG5Qxvkm
 urRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776065022; x=1776669822;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CM/BJEM0oQPnOgDJn2yySGpUjQTzbucI18FpRefJ+2c=;
 b=q2XrCI4VYKaq+kkY6fBIG/fJHiap326Y5d+YyETGYcZmRdFRfWfM33uKwJBGxPewP6
 5Ku2GxSysmwiM9dxEBwXnrLfbDw+FDfmRsbJmKkjk+2WMgP+Y8WRj8L3+0cmBEDeNObW
 4aoONYVP4Buvz/YlFX/e7UtmJ1r2kWwL5/SxfWeGOsC3bLXyzuaJWmx6vcj9gv5UW8m8
 YCCh8YeK3fYMFPiRgoFWStiUDd7MT8m99FXZwh5by4rvxwtsbpRv14SvRfJcxYJawyeI
 DK3msnQ3/KZrd6fYTUIEYbWfQQHmmi5uNKl1/FvEcNV/MsB1XQYf0LMLcm6ra1C8lx82
 jKsA==
X-Gm-Message-State: AOJu0YxmYnISpHTyZa4+46Nr1bAZxWTujZ+F3MxZXgEOb/rtFhkaA8V4
 kNrtB4IIpaLrrQaoAmv4zaflHaz0+rY2zq9tQ4tEPqbrH0kijeA6+Avt
X-Gm-Gg: AeBDieviGT2wrO9ngfBVgM3/E7hWhe98eGxLxL+FV7Ue/6ZqhJvyqnMo3knY9mWtSiU
 sHTGV5FRTLdc2T83Lr7nTqNQzOVpGHbXogDumX/zU3AcdjEhC+zv6pCCIAGS0Tjqt+guIM4Kixs
 LqBjZbi7gsmJm9tq0Gbswipvp2HyJBGEBCJNPHjyPX+VO02sMcCma7m55wstx9gEmQG1m6HaDcq
 k0xTxFByusVVg+mK87NAfn/jWimIi7hZ3K7lFvwOMQsg4QStbTwOQf+HEb2Jo4Lde3U9SqKAZBj
 IzPHRTroPqIhE7QfHTLlC3OufcGDhvSMXJyeHdGrRFKVPWi2mxLb0Bd2CJ8FXp0b7hgx6jyEVMH
 fRjKJz64IPdLPje9rzpoqdJm3SrmqNn9ojLA57AyIxjQV0xbRwOPDBVk4uTuncyMxOdHyEHX+bD
 QpieNQU9v2Uk4prWqyKboXuDwCUVw=
X-Received: by 2002:a05:6a20:9188:b0:39c:4e62:b843 with SMTP id
 adf61e73a8af0-39fe44a0722mr10972178637.10.1776065021903; 
 Mon, 13 Apr 2026 00:23:41 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79219c6306sm8983043a12.15.2026.04.13.00.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 00:23:41 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 4/5] hw/ufs: Add UFS Write Booster Support
To: Jaemyung Lee <ldc.jml@gmail.com>
Cc: qemu-devel@nongnu.org, Jeuk Kim <jeuk20.kim@samsung.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Jaemyung Lee <jaemyung.lee@samsung.com>
In-Reply-To: <20260410-write_booster-v5-4-d44e1a0e191c@samsung.com>
References: <20260410-write_booster-v5-0-d44e1a0e191c@samsung.com>
 <20260410-write_booster-v5-4-d44e1a0e191c@samsung.com>
Date: Mon, 13 Apr 2026 16:23:21 +0900
Message-Id: <177606500173.194535.11048393004211826936.b4-review@b4>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 10 Apr 2026 14:57:17 +0900, Jaemyung Lee <ldc.jml@gmail.com> wrote:
> diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
> index 3f3c9589ce..b4ec91d6b8 100644
> --- a/hw/ufs/lu.c
> +++ b/hw/ufs/lu.c
> @@ -58,13 +58,108 @@ static void ufs_build_scsi_response_upiu(UfsRequest *req, uint8_t *sense,
> [ ... skip 20 lines ... ]
> +    }
> +
> +    return (group_number == UFS_WB_GROUP_NUMBER_PINNED);
> +}
> +
> +#define UFS_WB_TOTAL_WRITTEN_DIV (1000 * 1000) /* 10MB */

It is still not 10MiB.

>
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index c504a0d7e3..78bd3e4a05 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -1238,6 +1249,31 @@ static inline uint8_t ufs_read_device_temp(UfsHc *u)
> [ ... skip 13 lines ... ]
> +    return value;
> +}
> +
> +static inline uint32_t ufs_wb_read_resize_status(UfsHc *u)
> +{
> +    uint32_t value = u->attributes.wb_buffer_flush_status;

It should be attributes.wb_buffer_resize_status, not
attributes.wb_buffer_flush_status.

> @@ -1383,6 +1443,27 @@ static QueryRespCode ufs_write_attr_value(UfsHc *u, uint8_t idn, uint32_t value)
> [ ... skip 18 lines ... ]
> +    case UFS_QUERY_ATTR_IDN_PINNED_WB_NUM_ALLOC_UNITS:
> +        ufs_wb_pinned_max_size(u, value);
> +        break;
> +    case UFS_QUERY_ATTR_IDN_NON_PINNED_WB_MIN_NUM_ALLOC_UNITS:
> +        ufs_wb_pinned_min_size(u, value);
> +        break;

I think these WB alloc-unit attributes are missing the UFS 4.1 range check.
For `dMaxFIFOSizeForWriteBoosterPartialFlushMode`, UFS 4.1 explicitly says 
the value shall not be greater than `dNumSharedWriteBoosterBufferAllocUnits`
or `dLUNumWriteBoosterBufferAllocUnits`;
otherwise the attribute must remain unchanged and the Query Response must be
`Invalid VALUE` (13.4.18.7.2, p.424).

> @@ -1801,9 +1882,177 @@ static void ufs_sendback_req(void *opaque)
> [ ... skip 68 lines ... ]
> +        }
> +
> +        break;
> +    case UFS_WB_FLUSH_IN_PROGRESS:
> +        if (!u->flags.wb_buffer_flush_en) {
> +            u->attributes.wb_buffer_flush_status = UFS_WB_FLUSH_FAILED;

Shouldn't it be UFS_WB_FLUSH_SUSPENDED?

-- 
Jeuk Kim <jeuk20.kim@samsung.com>

