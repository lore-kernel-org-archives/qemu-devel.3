Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE6AC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 16:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQGT-000281-01; Tue, 20 May 2025 12:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHQGP-00026j-Dz
 for qemu-devel@nongnu.org; Tue, 20 May 2025 12:56:25 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHQGN-0007jc-Lv
 for qemu-devel@nongnu.org; Tue, 20 May 2025 12:56:25 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30ecc762cb7so2574609a91.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747760182; x=1748364982; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/vRLMitreON+vFW++48y7TglTchdWWbvnyq6iT67lMY=;
 b=hFjSgQ0+9tnY8pOZDuMGuD6ag56t4DFqa1ZFOH5XFTMWiSWZvDpyaWzUWwtYeS4fCf
 s5Zktaj3bDPdRr+69OrmyHNM5D4olIJPQG5oj9uN/kw9FjS4d5h9//un8pT5bjHBmqNX
 zAkODrGF8fmUeiy2NjwaB/m62+69OJW990vQNyIp1O6VRy38Tx4SvqCSW0QREjwctGS4
 FkPZ7llpIZTg5YzdmNuCXpwH4uq9IpI44FqTZSbxSqglTrbqRMZ//6t8f8q0URe8wNHS
 kJ7d1N7KJbOh9XDRQETWkPBAT75PbdfJhciS8wRt3tsOUiFV1iz9QSyx2ZDiMFPVn4w4
 A4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747760182; x=1748364982;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/vRLMitreON+vFW++48y7TglTchdWWbvnyq6iT67lMY=;
 b=JdqyRtwd9SSVHOibw21TSp3vUBBgqHYay/XPEn9T9dZXGaYhvZuoIh4LcewEbQKYvY
 Bmp8WXBq11nM6UZaUJH+xrvwW1x6bAs+Zf6uhEULH3r8Y0NvpNd9Rih8iFe7fNxhMfdL
 gsLdhXGDYsAO27TNBcZHe8XHm6i9m9fvCa1CIc8heFVPlBQOk3oGm2ceUAWd2qSJ56Nu
 9D2hB04DFldOYClS8293wm2ALpfPNOvwckRql87lA/Q4xL+l3O2jMn2kwdbYXzdSklYe
 EzgbovhyQ+D4fbcYPvK8oDacE69W0vEh7wItBaotWs4h6WV9fE09+ev8HiNXGyoPZ427
 hsBw==
X-Gm-Message-State: AOJu0YziLOCkfZtCx2dG+b7pkBIP3hws2oMEwr8x2G3NjMVvOPdzN14L
 UqnSnSVvcXtqAI32cRe73g1T/G49eljWL77sB8Z72JHd9nvbDP7UeKO5
X-Gm-Gg: ASbGncsWJWWA7nA8VVJl7YiDISm79BPqYfvYYIZ/8iTrtczunHGm6SjupUxmgplUW2M
 bf3CNOH5cY0/+WM8PpeeMK2F7bGUaRt7Vgd0zINkvte+L2IuTOzzLi7F6byyw8f41MuJUFNsT9E
 CgWp4WJxs1wOS7sEJxxFUTtWl2nRB8UbXHxMbFKYrcXv0J0lp946lop7ddPB1wYbRqTTzZ0ei1n
 R1ve/nGl/OIgztZ8suF9AUroDPtFaQ4Th8/NqP5VzhQZ7W7o/zsUKMBdUkyu2JbC4MDKCsB0tq+
 KAayzldizeJiexwVjAeNOo/QPURGOm8VeshvI78nXQ==
X-Google-Smtp-Source: AGHT+IEldrYyfqRchNLhtdk3Ea5E8njSYxDDAnkx44QFrecfD06Y3xlMc2io0rTCgfTnWFsUuD9VUg==
X-Received: by 2002:a17:90b:3e8e:b0:2fa:1e56:5d82 with SMTP id
 98e67ed59e1d1-30e7e87f02amr25553357a91.17.1747760181771; 
 Tue, 20 May 2025 09:56:21 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f365d460fsm1928556a91.23.2025.05.20.09.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 09:56:21 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 20 May 2025 09:56:18 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 06/10] hw/cxl_type3: Add DC Region bitmap lock
Message-ID: <aCy0MoOUEwFj8HQ4@lg>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-7-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508001754.122180-7-anisa.su887@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pj1-x1032.google.com
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

On Thu, May 08, 2025 at 12:01:02AM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> Add a lock on the bitmap of each CXLDCRegion in preparation for the next
> patch which implements FMAPI Set DC Region Configuration. This command
> can modify the block size, which means the region's bitmap must be updated
> accordingly.
> 
> The lock becomes necessary when commands that add/release extents
> (meaning they update the bitmap too) are enabled on a different CCI than
> the CCI on which the FMAPI commands are enabled. 

read/write access also need to touch the blk_bitmap to ensure the range
to access is backed by DC blocks through ct3_test_region_block_backed().

Otherwise,


Reviewed-by: Fan Ni <fan.ni@samsung.com>




> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/mem/cxl_type3.c          | 4 ++++
>  include/hw/cxl/cxl_device.h | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 6ad48f55ce..b5b3df5edf 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -824,6 +824,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
>          };
>          ct3d->dc.total_capacity += region->len;
>          region->blk_bitmap = bitmap_new(region->len / region->block_size);
> +        qemu_mutex_init(&region->bitmap_lock);
>      }
>      QTAILQ_INIT(&ct3d->dc.extents);
>      QTAILQ_INIT(&ct3d->dc.extents_pending);
> @@ -1176,6 +1177,7 @@ void ct3_set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>          return;
>      }
>  
> +    QEMU_LOCK_GUARD(&region->bitmap_lock);
>      bitmap_set(region->blk_bitmap, (dpa - region->base) / region->block_size,
>                 len / region->block_size);
>  }
> @@ -1202,6 +1204,7 @@ bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>       * if bits between [dpa, dpa + len) are all 1s, meaning the DPA range is
>       * backed with DC extents, return true; else return false.
>       */
> +    QEMU_LOCK_GUARD(&region->bitmap_lock);
>      return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;
>  }
>  
> @@ -1223,6 +1226,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>  
>      nr = (dpa - region->base) / region->block_size;
>      nbits = len / region->block_size;
> +    QEMU_LOCK_GUARD(&region->bitmap_lock);
>      bitmap_clear(region->blk_bitmap, nr, nbits);
>  }
>  
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index cbcc1bc9f5..9cfd9c5a9f 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -618,6 +618,7 @@ typedef struct CXLDCRegion {
>      uint8_t flags;
>      unsigned long *blk_bitmap;
>      uint64_t supported_blk_size_bitmask;
> +    QemuMutex bitmap_lock;
>      /* Following bools make up dsmas flags, as defined in the CDAT */
>      bool nonvolatile;
>      bool sharable;
> -- 
> 2.47.2
> 

-- 
Fan Ni

