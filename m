Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6685C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 16:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wds7X-0002v6-1w; Sun, 28 Jun 2026 12:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <k.kahurani@gmail.com>)
 id 1wdriQ-0007YM-Ew
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 11:46:38 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <k.kahurani@gmail.com>)
 id 1wdriO-0008HL-IO
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 11:46:38 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-44856d185bcso757862fac.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 08:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782661595; cv=none;
 d=google.com; s=arc-20260327;
 b=YEhIwb/rNZlYxk9Lybz8PQr5WDhK2xP/x8LF1tCvirRJfSLhqLItSrfCkN52rGrG8y
 sV50dbQGwreGVR7RdlPychxqc7Np0VdZ5ybWTSevvm9JvHlXu7i7h07eM7tGudPV+ZgL
 9Akvqt6VyZN336gReodOl8BtDJx2/SQW7LMC+JjMsNmsAui9MoA37kY7jW4fxzhVjv3Y
 UuuIJewfMdMpOsgmy2VFGYcsIhTwUEk+8xzJAgms3o6AW3r+T5QfPyRcN45D9D2W4c9o
 UKKemX2TdwKvwS7sIFgBb7WibPL7f9CGgRSul9+sF+fzMNQ8thtN/BZKGIDp17fgw69l
 fr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TwK/D+sxvlgb/lYLKarrnyvpZOyu6UoNhP89AnfQs5Y=;
 fh=nbLTHbLAAofBXQ3VtxScTn/oztbvPUsF+2jQ8DfEAmI=;
 b=D37J5cUSjAkLf42NxzcsuEueQ9xOUtqjEpSh0CHHFuhtfB35PiVMC2+DvMnK8zPZbO
 YZ/6KCYK82/ygUZ6yVkXRP70XceUpTGexC1H/yAAzCA9g9lOxDq+9o5xEBDJvrGadOKY
 pSfZfwot2nu6XHv4iJjo9NElT2IPxJPl4Ys+ko+a9sACRTgcF4ntu8gEuoBA9PuoXyoG
 EI+DJ34ScyfRVnhTqNszf5ZKXCcC/mRYRgZYyvh3vMc6HHI1Lybt8RontFgjMqFjelUN
 3nwL7MpF2p01eQvPa89decxBobf6i0Ab2uhVpbp0oUSTQbR1nTbR2i01QiYGqWledgJc
 QJaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782661595; x=1783266395; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TwK/D+sxvlgb/lYLKarrnyvpZOyu6UoNhP89AnfQs5Y=;
 b=kZ1FC4NYQy65SMIPMA+baeXw3t8jM4zy/0WWf+zexYCLRMMnEwl37dnzGjbWFDdjVD
 MHvotSy7IX6MDeUxHcI+gl5x/hvSXAi8SvFq2ID+J+Rqr1J7gDRXK6I0YKw+ku9cSb3x
 +Jx9YG3GhDoOdgMgi1JWr8JhyYlbTSceg5qEtYtZhoGTXri7otQrnbxjqOJFKRKNdDDf
 c1fMg6tbrl9HkcFHaQTKoovAbyGhAFe0tvDxeo28VpPIFn55C12Z0zTjEDU7S7FY6c2Q
 53dOs3BHsrVvK7PKsHCJhRAt5BK0axn7qXBx6U5T1jM/qcSb6xD/7FbSbOZm7vcJB5mo
 lZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782661595; x=1783266395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TwK/D+sxvlgb/lYLKarrnyvpZOyu6UoNhP89AnfQs5Y=;
 b=jUX8V82p4hU8w9QgBNCgB7FHXKQ3DBOKXFyXbCxwEeYG5FpSGAwnmgw8Rs+jNrBFI/
 by3WNKZsSDC6yVQHL5G55u2ih6mfGTAujnDMBNfG1yT7tioTecY6uFISxUq+lh8oSmme
 qThONXYIe255jEu/3FlXLNabEBwwFqBtZUWjuybuGDvRBkzbzSWA9oFszi2xZD1ExJF8
 d96U38LXecNpzbi0wiAYblYShb37YbwkpTlHYBW5mG64YmIGJo6l54KCRKZb0pl+BmV5
 Du/OBD1fwAGnHbGNSQlVUKSFTgR1a1iVc83BFUejOpXHDlfWJ9ctF5fjCI3nwJVYPLwy
 BQSg==
X-Forwarded-Encrypted: i=1;
 AHgh+RomoqgNu9L6h1vio2MOyJZAz1Sed1dw591jpc2Yd26vXB3qL18PqdYA4QJOWcFN+S2aNE1ppMnEEiu7@nongnu.org
X-Gm-Message-State: AOJu0YyAbfOdWddsbrsBOI3TdEh/Cx42u6JF85Jen1K4PVtB99ISdXow
 IlGyC8A8AjoHV6+c97AQABN3/nj+MQzot2y/h1+L/V+Lb5gm7tXfMY/32UHB7Osjke6/fyjEmco
 4wpnvOlUPMDK6DB0YmUXYIiev8lxrvo0=
X-Gm-Gg: AfdE7clhIEvzVWvv6SH3Cqz/QW6iMocKSq9Xbb+GiSvQbFmNscnjn3hkVENEKe7jYxk
 ImJMk3nqO+Om0cFZrL80jCwfOV3tTOJszzf0hjRNHI8wjVfRmGtyopCL23Qn1MlKjtyzhIdDjmc
 FfrmKk0bqjvrdnzzpO33/7/QyuC8kAMRB9KPEFzuzIJYvsVNQGZk5wFoSW01x4Pky//CNxOST7l
 aHAPDmdw1jPvr0AzSK9M2aMpm1ljdJpwBoAE3TpBbRRiZj+8uMIpb9541Zd5QheeNYAvK/xVzI4
 Dfcgk1BSKQP9RvYQMk1Jh2z53HSiDYA6/Bu8
X-Received: by 2002:a05:6870:658e:b0:448:5591:15d9 with SMTP id
 586e51a60fabf-448559126f7mr4849762fac.37.1782661594757; Sun, 28 Jun 2026
 08:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260628154051.232214-1-megia.oscar@gmail.com>
In-Reply-To: <20260628154051.232214-1-megia.oscar@gmail.com>
From: David Kahurani <k.kahurani@gmail.com>
Date: Sun, 28 Jun 2026 18:46:23 +0300
X-Gm-Features: AVVi8CeTf6DizADkLm61AypxDKstCAaBxgLYQTdLkrxOaMXxh3_00Jp7bzgcmN8
Message-ID: <CAAZOf24EO8Aiu=nOzzKCPBzgwvJ+Kw=PaWNyOPP4L1A8PfduMg@mail.gmail.com>
Subject: Re: [PATCH v2] Memory leak error in qxl unbind
To: =?UTF-8?B?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel-mentees@lists.linux.dev, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=k.kahurani@gmail.com; helo=mail-oa1-x32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 28 Jun 2026 12:12:34 -0400
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

On Sun, Jun 28, 2026 at 6:41=E2=80=AFPM =C3=93scar Meg=C3=ADa L=C3=B3pez <m=
egia.oscar@gmail.com> wrote:
>
> I discovered OOM after run script below around two hours in my computer:
>
> while :; do
>     echo [pci qxl id] > /sys/bus/pci/drivers/qxl/unbind
>     echo [pci qxl id] > /sys/bus/pci/drivers/qxl/bind
> done
>
> If you run 10000 times above script kmemleak does not report any
> memory leak, but if you run above script about two hours several
> OOM ocurs and at the end kernel panic.
>
> The OOM isn't just a simple leak; it's a refcount corruption that renders
> the list_lru fix dead code after the first mid-init failure.
>
> Here's the chain:
>
> Bug 1: ttm_global_init ignores ttm_pool_mgr_init() return
> If shrinker_alloc() fails under memory pressure, ttm_pool_mgr_init
> returns -ENOMEM with pool types already initialized (64 list_lru_init
> calls done). ttm_global_init ignored this and returned 0, leaving orphane=
d
> pool types with a NULL mm_shrinker.
>
> Fix: Check ret from ttm_pool_mgr_init; if non-zero, goto out cleans up
> refcount + debugfs.
>
> Bug 2: ttm_pool_mgr_init leaks pool types on shrinker_alloc failure
> If shrinker_alloc fails after all 64 pool types were list_lru_init'd,
> the function returned -ENOMEM without undoing them. With Bug 1 now
> triggering proper error handling, this undo is necessary.
>
> Fix: err_shrinker: label that finalizes + destroys all 64 pool types
> before returning.
>
> You must apply the patch from the link "[PATCH v2] drm/qxl: fix
> use-after-free to qxl_irq_handler in PCI mode" before testing.
> If you don't apply this patch, you will get a UAF error when running
> the script above.
>
> Assisted-by: OpenCode:1.17.8-Big Pickle
> Link: https://lore.kernel.org/virtualization/20260627105445.89827-2-megia=
.oscar@gmail.com/T/#u
> Signed-off-by: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>
> ---
>  drivers/gpu/drm/ttm/ttm_device.c |  5 ++++-
>  drivers/gpu/drm/ttm/ttm_pool.c   | 37 ++++++++++++++++++++++++++------
>  include/drm/ttm/ttm_pool.h       |  2 ++
>  3 files changed, 37 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_d=
evice.c
> index d3bfb9a696a7..c880a0430363 100644
> --- a/drivers/gpu/drm/ttm/ttm_device.c
> +++ b/drivers/gpu/drm/ttm/ttm_device.c
> @@ -96,7 +96,10 @@ static int ttm_global_init(void)
>                 >> PAGE_SHIFT;
>         num_dma32 =3D min(num_dma32, 2UL << (30 - PAGE_SHIFT));
>
> -       ttm_pool_mgr_init(num_pages);
> +       ret =3D ttm_pool_mgr_init(num_pages);
> +       if (ret)
> +               goto out;
> +
>         ttm_tt_mgr_init(num_pages, num_dma32);
>
>         glob->dummy_read_page =3D alloc_page(__GFP_ZERO | GFP_DMA32 |
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 278bbe7a11ad..e0c82804a07d 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -1198,6 +1198,17 @@ void ttm_pool_fini(struct ttm_pool *pool)
>          * that no shrinker is concurrently freeing pages from the pool.
>          */
>         ttm_pool_synchronize_shrinkers();
> +
> +       for (i =3D 0; i < TTM_NUM_CACHING_TYPES; ++i) {
> +               for (j =3D 0; j < NR_PAGE_ORDERS; ++j) {
> +                       struct ttm_pool_type *pt;
> +
> +                       pt =3D ttm_pool_select_type(pool, i, j);
> +                       if (pt !=3D &pool->caching[i].orders[j])
> +                               continue;
> +                       list_lru_destroy(&pt->pages);
> +               }
> +       }
>  }
>  EXPORT_SYMBOL(ttm_pool_fini);
>
> @@ -1386,6 +1397,7 @@ static inline u64 ttm_get_node_memory_size(int nid)
>  int ttm_pool_mgr_init(unsigned long num_pages)
>  {
>         unsigned int i;
> +       int ret =3D 0;
>
>         int nid;
>         for_each_node(nid) {
> @@ -1423,8 +1435,10 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>  #endif
>
>         mm_shrinker =3D shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool=
");
> -       if (!mm_shrinker)
> -               return -ENOMEM;
> +       if (!mm_shrinker) {
> +               ret =3D -ENOMEM;
> +               goto err_shrinker;
> +       }
>
>         mm_shrinker->count_objects =3D ttm_pool_shrinker_count;
>         mm_shrinker->scan_objects =3D ttm_pool_shrinker_scan;
> @@ -1434,6 +1448,10 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>         shrinker_register(mm_shrinker);
>
>         return 0;
> +
> +err_shrinker:
> +       ttm_pool_type_fini_and_list_lru_destroy();
> +       return ret;
>  }
>
>  /**
> @@ -1442,17 +1460,24 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>   * Cleanup the global pools and unregister the MM shrinker.
>   */
>  void ttm_pool_mgr_fini(void)
> +{
> +       shrinker_free(mm_shrinker);
> +       ttm_pool_type_fini_and_list_lru_destroy();
> +       WARN_ON(!list_empty(&shrinker_list));
> +}
> +
> +void ttm_pool_type_fini_and_list_lru_destroy(void)
>  {
>         unsigned int i;
>
>         for (i =3D 0; i < NR_PAGE_ORDERS; ++i) {
>                 ttm_pool_type_fini(&global_write_combined[i]);
> +               list_lru_destroy(&global_write_combined[i].pages);
>                 ttm_pool_type_fini(&global_uncached[i]);
> -
> +               list_lru_destroy(&global_uncached[i].pages);
>                 ttm_pool_type_fini(&global_dma32_write_combined[i]);
> +               list_lru_destroy(&global_dma32_write_combined[i].pages);
>                 ttm_pool_type_fini(&global_dma32_uncached[i]);
> +               list_lru_destroy(&global_dma32_uncached[i].pages);
>         }
> -
> -       shrinker_free(mm_shrinker);
> -       WARN_ON(!list_empty(&shrinker_list));
>  }
> diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
> index 26ee592e1994..bda8e816a206 100644
> --- a/include/drm/ttm/ttm_pool.h
> +++ b/include/drm/ttm/ttm_pool.h
> @@ -97,4 +97,6 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, s=
truct ttm_tt *tt,
>  int ttm_pool_mgr_init(unsigned long num_pages);
>  void ttm_pool_mgr_fini(void);
>
> +void ttm_pool_type_fini_and_list_lru_destroy(void);
> +
>  #endif
> --
> 2.54.0
>
>

This bug is specific so Qemu, so...

