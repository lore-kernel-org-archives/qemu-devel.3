Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6A8C88E70
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x65pf-0006DA-0d; Mon, 14 Sep 2026 08:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x65pC-0005q5-2Z
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 08:30:27 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x65p6-0004GW-If
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 08:30:16 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e4ab20f4bso1392360d50.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:30:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789389011; cv=none;
 d=google.com; s=arc-20260327;
 b=J7mSSeCjtFaZK4aSTFj6eYw2hRaekninSK+5auylRGGAAFrxkGQFypksV5771TnV1G
 VtRL7zCvDCpwlyARWeYoehRw3bXibjmB+IBUoJ3nTCdjsmu4ByrUk5Ci4+Erf4GXged0
 zejm7y/2IGY25nr72fsF2v3dKfpgCpGDN4Cg2NwZYkd/XSA2bfyLKIbWqy6kPE7YnT76
 tObQAlvKOK63Qm5R9jaGivhlRbkIQEpDr1+VMpDXZ+nYKIYm1eVcfolJSBdTc8PX5SlR
 UCWtUlSYBw8Qma7urn2ZvjtHrGqyT7j5i8MgbLfx2kGQdYM6wX6lZhwcRu/I1HMgnfaK
 NNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xaB4jayHXGBrFcs8fKIQFqymEASlJUqyJ2gx4sFjLvY=;
 fh=yWloI4x5GUzoz1Q5XLZmz6iISAvASOoYSEEdao9lxU4=;
 b=BlfBCN+cbDerr+qslyWrTjPSx37eTqs+mwvlh+HDtSXBbUl2K21I7sl3yP9lro4fUd
 Y8RyjJpyzRtuRuMWoz4z4TLwse1OLvDDktlyN8U5oOp9ImQXy1Kc0+mxx2jdnhuAmaU0
 cZXFaK3Ffc7Ly3PYqlRKhgRw4N2BmgCc9isW5OcWOD3aQeYHZ1VCHREYUp44nbSB8ObM
 74xDFutebN3HSRGrXjnM0EJin7yvaNny+MxqZ7CxJuftsK2a9mKFIdelKquqznrCDCUS
 QSKLIP8mGrTOpt8GnE9+nV/LTdKznZnKXJqgcvuSXontEZnkG02EnTzPYzUGVRBh8suU
 wBtA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789389011; x=1789993811; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xaB4jayHXGBrFcs8fKIQFqymEASlJUqyJ2gx4sFjLvY=;
 b=sK6vx94oKQ+R7y+B0rDgT+NNhSSxfM7jrT3rMgGHC0bcD3QoXMxA+m9SoE0/8KNz48
 mA4sGv511EmLAwZnN5G8OcnHMXneaA6nEnRYA+IDZ3m8pozNKJvY11qBD2sewcrJmSNz
 oYW4F7K/7+z2DcNYEo1M8uePh74YsSV4/75KPsvG7d5oEi/tJYRYnRqWSWLwPj7hsicY
 kcUtLEDynIQItraJArguFiX95EwCSPXzDx6CzlcVQ2f3qIkrBaZxibEPwqoMKgFcAmqu
 8WG2f5CjOQFvPmPQqK/23zMcWtXQTFtPMcPTACtAivuWHlWJ11DLUnPkysZJw05V4Z0P
 b02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789389011; x=1789993811;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xaB4jayHXGBrFcs8fKIQFqymEASlJUqyJ2gx4sFjLvY=;
 b=qRUPFc8dk5R6iKFEO0xVsLUym6EX+3u7u3HG0e58h5yb9yHt1ZRS/ZT4QXS7FqCWRN
 EsaArP9LA2HNBMuwdSeqHJnKv33ypRwUBhFiu38meaKR0iIQtpLY5c1s8wCvkXQG1Oxc
 s/MlKKCAPIPDeTxsSrZCOg79IbL5LzEo2JemCoZKbLFwRVvAsFp36HY0HsPpe7q+goOq
 v1lh5cjicRJNj61ifuzTqTpyKlAWpR9fmt2CQu0rkX21ahaYjcOsOmwS/cLoND++i6te
 Ozo1plPDB4OlY73BisKBcZfxUH0f5qGumU1zlQRxkdrx8xG8QJBT6QJUUEy2dVohsIn5
 jizg==
X-Gm-Message-State: AFuF++n+3TyivM+Xlrh25Y1TIld4YDsyt5MXg8N5j2ifZtWESIk1wFeb
 LUo+o9vI1Zilq48slkFX2ABn9GTJPC5qqCV7WvbNHKvfA9ornzfmrJ4MP+zOjJevR9gGBRSvLRH
 PoQqc4MCuJGqJfMJr7EwRjzPsfrrSdrljJ/mv4r885A==
X-Gm-Gg: AYBFou0Ja0cDLJOw6bPN7VamvwN/vo6cr2WnlkBAylFFOIK4j574y6Xxqly6Z8hgNvF
 C2VJr/lQpE6LoFQgH32PQFgJcHcJAJBqzxSV4XArG+g/nLenX+SOLX90vOMSjRzfVZ01FTIEOeW
 GedG1z0prGMAyipT6CcRo+LE0lGYwdbZaW+NHz7K++bv3oJCZVSeUoFRbd4uzAkq8wmoryzhyJN
 Jv5bamVTafcKNbKFEfduK/0l4n63FBq0OrvK69JaeXrOXg5OiVkKK7nelx78BZjyjQT6Hn9mAq3
 IZwZ5tKNFVMGUrF24K3xJuGpodTPektU1NaAMeVjMdEbzc3vsz9DUIyCbu63cE56aMN7DsEg30b
 YpwUcFnUPm46Yv0JkHiB8L+RMP7xf32G15rxUUyc=
X-Received: by 2002:a05:690e:4144:b0:66f:a8e8:7140 with SMTP id
 956f58d0204a3-6714dfc8c48mr544563d50.5.1789389010550; Mon, 14 Sep 2026
 05:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260911190431.4085464-1-mochs@nvidia.com>
In-Reply-To: <20260911190431.4085464-1-mochs@nvidia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 13:29:57 +0100
X-Gm-Features: AcwNN1WOiXE_oktjBoPZtdQqXfXYDSgHqopiisfxgXafVRax5LaVH0Swm566Biw
Message-ID: <CAFEAcA9ve3sdSEJ6vPts80phhfjV9BpW+Nx6cJOwH3aYQ3zafA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
To: "Matthew R. Ochs" <mochs@nvidia.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>, 
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 11 Sept 2026 at 20:04, Matthew R. Ochs <mochs@nvidia.com> wrote:
>
> With CMDQV enabled, resetting a guest after it enables VINTF invokes
> the VINTF page0 unmap path. The resulting crash is intermittent and
> has been observed on the RCU reclaim thread as:
>
>   reboot: Restarting system
>   double free or corruption (!prev)
>   ...
>   #5 address_space_dispatch_free
>   #6 flatview_destroy
>   #7 call_rcu_thread
>
> FlatViews retain raw MemoryRegion pointers and release their references
> asynchronously through RCU. The VINTF page0 unmap path removes the
> subregion and immediately unparents and frees it. An old FlatView can
> then access the freed region during teardown, resulting in a
> use-after-free and heap corruption.
>
> Embed the VINTF page0 MemoryRegion in Tegra241CMDQV and add it only
> once. Use memory_region_set_enabled() as the guest enables and disables
> VINTF. New FlatViews omit the disabled region, while old views continue
> to reference valid storage.
>
> Keeping the region initialized across VINTF disable and reset is safe
> because the vIOMMU association and its VINTF page0 mmap remain stable
> once the guest CMDQ has been initialized. QEMU blocks hot-unplug of the
> device that established the association, so later hot-adds reuse it
> instead of associating the initialized guest CMDQ with a different host
> SMMUv3. The CMDQV free_viommu path is therefore only invoked while
> unwinding initial allocation, before guest CMDQ initialization.
>
> Fixes: 5965b81ce283 ("hw/arm/tegra241-cmdqv: Use mmap'd host VINTF page0 for virtual VINTF page0")
> Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
> ---
> v2:
> - Use memory_region_is_mapped() instead of an explicit initialization
>   flag, as suggested by Shameer.
> - Link to v1: https://lore.kernel.org/all/20260903184710.2052780-1-mochs@nvidia.com/
>
> Reproducer:
>
> Start an Arm virt guest with one passed-through device behind an
> accelerated SMMUv3 configured with cmdqv=on. Add an HMP monitor socket:
>
>   -monitor unix:/tmp/qmon.sock,server,nowait
>
> The failure can be made reliable without an ASan build by starting QEMU
> with glibc freed-memory poisoning enabled:
>
>   GLIBC_TUNABLES=glibc.malloc.tcache_count=0 \
>   MALLOC_PERTURB_=165 \
>   MALLOC_CHECK_=3 \
>   qemu-system-aarch64 <options>
>
> Wait until "info mtree" shows the VINTF page0 region, then reset the
> guest through the monitor:
>
>   printf 'system_reset\n' | timeout 5 nc -N -U /tmp/qmon.sock
>
> With the unpatched binary, QEMU crashed on the first reset with SIGSEGV.
> The core showed object_unref() called from address_space_dispatch_free()
> with the object pointer set to 0xa5a5a5a5a5a5a5a5.
>
> Testing:
>
>   Unpatched, one CMDQV instance: SIGSEGV on first reset
>   Patched, one CMDQV instance:   100/100 resets completed successfully
>   Patched, four CMDQV instances: 100/100 resets completed successfully
>
>  hw/arm/tegra241-cmdqv.c | 21 +++++++++++----------
>  hw/arm/tegra241-cmdqv.h |  2 +-
>  2 files changed, 12 insertions(+), 11 deletions(-)


>  static void tegra241_cmdqv_guest_map_vintf_page0(Tegra241CMDQV *cmdqv)
>  {
>      char *name;
>
> -    if (cmdqv->mr_vintf_page0) {
> +    if (memory_region_is_mapped(&cmdqv->mr_vintf_page0)) {

Here we call memory_region_mapped() on mr_vintf_page0...

> +        memory_region_set_enabled(&cmdqv->mr_vintf_page0, true);
>          return;
>      }
>
>      name = g_strdup_printf("%s vintf-page0",
>                             memory_region_name(&cmdqv->mmio_cmdqv));
> -    cmdqv->mr_vintf_page0 = g_malloc0(sizeof(*cmdqv->mr_vintf_page0));
> -    memory_region_init_ram_device_ptr(cmdqv->mr_vintf_page0,
> +    memory_region_init_ram_device_ptr(&cmdqv->mr_vintf_page0,
>                                        memory_region_owner(&cmdqv->mmio_cmdqv),
>                                        name, VINTF_PAGE_SIZE,
>                                        cmdqv->vintf_page0);

...but we don't actually initialize the MemoryRegion until here.

I don't think you should assume that memory_region_* functions
will do anything sensible on a zeroed-out lump of memory.

thanks
-- PMM

