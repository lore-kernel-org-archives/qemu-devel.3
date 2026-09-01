Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EFDC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1QJI-00064g-4I; Tue, 01 Sep 2026 11:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1QJG-000647-Rs
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:22:02 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1QJF-0008OS-8i
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 11:22:02 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-86162c086f8so20327437b3.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 08:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788276120; cv=none;
 d=google.com; s=arc-20260327;
 b=ITRUxcKU2EPIN9RObFGCfeYz//IBAWMzStnUTDEH7PBVMdUuFu1+NvrD6W27EEiCEx
 +uH/3WKVShlB2LV+aJFcsdA4gVDTrf2J2GAz+LI2d6ANagCzvm2bKKb6ZRXk9nwkMewV
 ILlWGyuVppJUgABmZw4qZZxYYWb2MRyYEtO9OhAbgzxUZKVHVltZr0+CknIBXNFKaJTF
 LWcV5z+M5kbXFqjm1qgeGxmomObZhy8oXy5Jd4OwuMm7l9BUe6qwRJT6t5q60CDEDn7q
 nagkklJCS/9urRd+EqJUoZbVo5iUoGyTzFPKiHw8Y63SEZ/kMtduTKPGqc89L38oeX+v
 mT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NPTGdcFSJhaCrmSR24FP951+qs5BMX8kS9irH5bhNYk=;
 fh=vx6WqBV7ZkFr5+0c5croOznQhRJT596ekVEWV1sovE8=;
 b=ooIU1y1me1/9mdeB+a75bDkkCBZEIkGztvRVPAtKFNI2YFRorSN++tsdgkN9qZXmtd
 m/bzZFi/Kqrt93BpP1rKW+YTIjTGT2GgvQqDEx6VXDElsz1gK2h3AFCRAa/Snz0cYyXE
 4jAw8jDTp1zTgfo7tKVg0y6vyWTjucl+oMmzxaJ+GYPEtPyoNNIh0iaCtx/pedk8q3mX
 6Vu/eW+6IgphAcjbEJVVn7CU7mcAhjNMaiKKV+sCSJxCpqIer12AT+DaMVc7PQ8VVTEG
 +uJLzPZqQHLSb41GWVJWPjK1otXEyo5LBkdf1y57XFvuThSs3T7teaBXS7EgFGwuruYL
 1Uhw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788276120; x=1788880920; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NPTGdcFSJhaCrmSR24FP951+qs5BMX8kS9irH5bhNYk=;
 b=Ps8BY5rrKskk+lDsgG5t3S3QF4C2RDVx7HCwGLy00Q1cdxulAD/UjQvFkM6UcfS1TK
 4PX7psLWtr1D3VnZvFrtEK5wDUHnf5G4U6aKTavE85IvqV+OrLEO/rGE7wv7ngVZh+lD
 LkWsEeJmpUF1edcy2KZwMR13c8Vv2zmgyekt9KnP9w4Jo/AQLu7UE4Z5UQMXDh/UpPS/
 csrn18K8WUWk3zRmgL4FLuL+8IDQteGhtYCEPse6tf6unKXiBoR7adjIm9nGM0Zg0xJN
 IHGZ6LDMkHPyk2uhdXzBBWCnzeU3l3xXzZRtsjYf7OSJ1+DPlEQlTXk5ocs94MybT+ZS
 pgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788276120; x=1788880920;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NPTGdcFSJhaCrmSR24FP951+qs5BMX8kS9irH5bhNYk=;
 b=gbURVrYu4zZ/7cB1NRpmkMwswNlQnTwSZu6lxed4JLE/sFpEA0WSdeXYfnj5RBLH9I
 1NIZ3ooc/OYg5OuLOcJOd4jhrSDExFGU2jTFCMhJ1psjZN1EUPnAQMnKtTly4ptSySSt
 ixm7g1YS0EGLhUWR6x8PIcJnsZwigipBHxnFh5aQLmqqgJDYzqkKooMHabNK0xb/mI/g
 EuojR+NQMZ3QXImlS9TniQPeu83AdyB/1040YOZAAjw9cPNSDDrKyaMWlVsbddhc3BTf
 lluzYfZvQrUlSznpaNHu35K+rFM0I7mt7WcUhG9bBAduoPiQhV3tUXelCBhPY0Oezx+s
 kVnQ==
X-Gm-Message-State: AFuF++m37oxpZTSxfVxAi4CjHBYX/ROw6+DirQWhcGXkWZAvQyu1zV10
 5/ovbz600Xho9PqGfl0ZmXkhxqaQW2PmY8OJXePbkpUW4nn0rwSeTfkbATH3A57t0I20LYNa+H5
 xe+aFSg6Uq5iZLQqsPeciyr4EDj6p+loPMHIMjxQw3O0cS0lBMxKUVK0=
X-Gm-Gg: AYBFou0LqZyB+eTKhmyLz1pG7p7yyo4ArjQl1Gty5CPh378UQ9Kh4A47ljvSSkJQ3d9
 /5zEmVnO5UKMKwEfa5k6yej0dok/VahiBapgXYDe9J4W2UKDJj8ZxvDVy9aEQXuvE0KKfgCQ5eK
 KSItIjQ5RBoxrmfILOci6RbnyVuermf6XJN9iAQ0g/K0+0FEuVdBTahKRdX2g2OqjdiGbhi8IQu
 w1wwp7iRkBxhtIAwjVCBQ8Z8HaUFIjXjCfvvuJ7jZedYFQ8tygXvkvHAO+amZYA60A8R6jQ6mf0
 MZC4dRLiMp30BgQnnfzlQ4k9K73sl9pSyD7SPqKlReR7biJY1HdAEgj3OxRxlARojbzGrs8Pso9
 99UXKD8vDuqXuUv9CMpWv9uE3FfWpJtf6LOS+AJ4=
X-Received: by 2002:a05:690c:a7dc:b0:80e:dc2:873b with SMTP id
 00721157ae682-8694d0f26c1mr25481777b3.16.1788276119819; Tue, 01 Sep 2026
 08:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-9-richard.henderson@linaro.org>
In-Reply-To: <20260815203730.1468365-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2026 16:21:47 +0100
X-Gm-Features: AcwNN1XgVCv_F9f-hV547-VZRoptUeYrotU46yMTkTDPrOiyTTR_lcVQRovmu5g
Message-ID: <CAFEAcA_S-bbWV6aSJp+LaQVPD3c1v4mrHoM-ZWs-meY=M8nFXw@mail.gmail.com>
Subject: Re: [RFC PATCH 08/18] accel/tcg: Replace size with first/last in
 probe_access_flags
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 15 Aug 2026 at 21:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/accel/tcg/probe.h        | 24 +++++++++++++++++-------
>  accel/tcg/cputlb.c               | 15 ++++++++-------
>  accel/tcg/user-exec.c            |  7 +++++--
>  semihosting/uaccess.c            | 10 ++++------
>  target/arm/tcg/sve_helper.c      |  5 ++++-
>  target/riscv/tcg/op_helper.c     |  4 ++--
>  target/riscv/tcg/vector_helper.c | 21 ++++++++++++---------
>  target/s390x/tcg/mem_helper.c    |  4 ++--
>  8 files changed, 54 insertions(+), 36 deletions(-)
>
> diff --git a/include/accel/tcg/probe.h b/include/accel/tcg/probe.h
> index e3068a79de..06faf1269d 100644
> --- a/include/accel/tcg/probe.h
> +++ b/include/accel/tcg/probe.h
> @@ -49,23 +49,33 @@ static inline void *probe_read(CPUArchState *env, vaddr addr, int size,
>  /**
>   * probe_access_flags:
>   * @env: CPUArchState
> - * @addr: guest virtual address to look up
> - * @size: size of the access
> + * @addr: virtual address
> + * @first: beginning of virtual address range
> + * @last: end of virtual address range
>   * @access_type: read, write or execute permission
>   * @mmu_idx: MMU index to use for lookup
>   * @nonfault: suppress the fault
>   * @phost: return value for host address
>   * @retaddr: return address for unwinding
>   *
> - * Similar to probe_access, loosely returning the TLB_FLAGS_MASK for
> - * the page, and storing the host address for RAM in @phost.
> + * Probe an access for [@first, @last], where @addr is somewhere
> + * in that range.  Normally @addr == @first, but some targets have
> + * accesses which are forcibly aligned after an initial fault for an
> + * inaccessible page (e.g. Arm DC_ZVA, where [@first, @last] will be
> + * the bounds of the cacheline containing @addr).
> + *
> + * If the access does not satisfy @access_type:
> + *   - if @nonfault is false, raise an exception at @addr
> + *   - otherwise return TLB_INVALID_MASK.
> + *
> + * Otherwise, return the TLB_FLAGS_MASK for the page, and set @phost:
> + *   - host address for @addr, if direct host accesses are allowed,
> + *   - otherwise NULL.
>   *
> - * If @nonfault is set, do not raise an exception but return TLB_INVALID_MASK.
>   * Do not handle watchpoints, but include TLB_WATCHPOINT in the returned flags.
>   * Do handle clean pages, so exclude TLB_NOTDIRY from the returned flags.
> - * For simplicity, all "mmio-like" flags are folded to TLB_MMIO.
>   */

We should mention in here somewhere that it's a bug in the caller if
first/last aren't on the same page (and we assert that).

> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index b7b3805a6d..87f2196bc7 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c

I don't understand the code in these riscv vector functions well
enough to have been able to check whether we have "calculation of
'last' might wrap around to 0" issues here. The other changes
in this patch look OK on that front.

-- PMM

