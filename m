Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9ADFCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbgBa-00035T-CP; Mon, 22 Jun 2026 11:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbgBX-00034i-RX
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:03:39 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbgBW-0006ip-5m
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:03:39 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6611669cd16so5286566d50.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 08:03:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782140617; cv=none;
 d=google.com; s=arc-20240605;
 b=L1zMstjGYvI5z7TvibjKqEI/GHZybKD1SCy35GvCiBX91XTojCQzCyKL1RGbyKvv/n
 1QZPaBf5yhPq4PUaPx5YZ2Qs0c+vBZCbFa21EJKfKF5CKP+DdRlV3KDCT+LuCQj1/cuU
 T8vXwlb1iofdSuYRVyG95Pp+pL6SjsPyCtjQ4sb6vRjdP4O2guOFmsDG2YDnAWkl6PtT
 Ux/KGw+O6LX02u8FkVoJnmkMrhMcIkChTw7NNOCIsFvJV+3fu5kYZAuxs4lCt/Or/8OC
 FCcHaMM/QhHWpx0TJ7lAX8r77t0RgYoN5w+bD57jxeL7JTA3ntSj6CadXieIZwDmHMkO
 EPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q4Lr2K+6hPd+Y5R8dq2T8k4o7xzymXFw93GLqalDIiU=;
 fh=PL4FqJaAQ7b6hhllp3nxBx3tfHIEzzJZmMdGdAndIvc=;
 b=cqhXwT6TND91j+9bzdDoT9hZAzLWGU4xnju32hooBzGGgrUypJrewjYcs8xnna3H+u
 hG1RoV5IRVBuh+q4Ls5bYMPfMt1/r8YLG+i9cI4kM9QfOYAMnFndPZVe75XRYCYByVXE
 j+y9IY4sKy0xJzUpx3ViQN9/e/CgiTTbPNpawYQ2gjaV2FUlNHZUE936E7KgPglCwgbv
 /B6HPbvOhUs23k1bic2zXuYwNQXSWRi4AC6zFmVNLyYpNTQad6Mx+rQOqlvYldn0sWOj
 U+dICxOSsI4Ye68LRdmIN9nfIzKflXAULZMk8z4BdlTwtkoLJYPbRKPdbDTPOLkNuRRL
 lXPQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782140617; x=1782745417; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q4Lr2K+6hPd+Y5R8dq2T8k4o7xzymXFw93GLqalDIiU=;
 b=qEsAQlytd0PXUgRyXNcgrln2pCd7Id/eDRDQsa3Uk/InJypBktQ+dwIBwzuLVAGcwy
 l6kbfAsSA+WIoOgf3CtlJmWXVTZ3GKel1zBoCgql4uJXiUGYjfkwfsZFBiPBvPYtKikv
 747ogMF0YQ3GIBo9ItGvgiGIBG29FmeS0VnBl9EolK3WKyYYWHaQ2HU217+9kc7YjCVO
 D1PVpmdDTgDyjhch7RlA/YCngTjq6MD55rh0b78j1LwylUFtp+5qj8tT/I7TCVj3K3B9
 nVPsIGC2/9rwkX8Kk9nmhYBuhoAV2ZcbhAe9N47aPWHVZQImeEUxtK4wGAB7Y4rY/Kyj
 p3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782140617; x=1782745417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4Lr2K+6hPd+Y5R8dq2T8k4o7xzymXFw93GLqalDIiU=;
 b=jaoHd8JbRkvjxXltUgc2gHvu3K8jSK4iR+KpwHJ3H7Gh5W59DRPCQoFdZy9zFA2Qc6
 tqVLUWtjLCWyvd9o3yc612cVzKUUq1IBU3q9XZi8Cni6n/2vjuihiCTZ3k3ugtIAWjVe
 SlX3jb4sQX6MwAAyc+dbZC2eS+HaCa4kljUdXGH1PXy2NO0zbRtLunUdIW5Al2lbQX0m
 nRs81glh6CK6TpMiyjoomsnUq49cgX/9BdW6D5ttjXStnyWNb/rTD91W/2e6ldAALhIl
 CNysVOS780kiaxtS9YsTwQ3hxL/wWD3jJw+WyCnO172Ei6W7cguKONP8Knuk2a/BBQY0
 CkYw==
X-Gm-Message-State: AOJu0Yx0vijRY8ALHr6+T4SbGvE+s+tp2PQkabSsWH4yX2yensqvO6OP
 KXrX8ufQ6T10vwBs3rQrak8mWSTQsI7b/SoJiY6+G0KSv/6DhLMnukt3TiF8GvXYV9ObqEfMM1u
 S+Knpd5g7dC1NCiBQNpuGQk4hF1ioFdOAsIr+CDr/tA==
X-Gm-Gg: AfdE7ckN44hCqPGzHyil0h/pZRTyFbi8CF3yQlGM3JfPqtoXI7Ou+l4FoHOtdMInUf2
 kTVnmjL6KWOxC5nm5/Q8Mon/QmB2Q6RZ5TnbXg7LBfuAlwq8Me1HXE+PJShfIDCLKhLWyAZ+fQk
 gPKzXorJaYX8FD2yixxD1g3wBqiBfTc9o6BSPtn9dDu0CfztS3n3MTy5HrIdUqnicrKbmTgSH6r
 zLMko1ECy7B9IVtmiafbOgKPj5daiO02OdTEUqyklr7Bt3FPL/Aby+61CYsdQ2U5yZMYihWZVhS
 MODR97u/kJ2AKgBIGACzldniuH50+Il1x5XdOHD8sSz26BxRQ+J6lXzT
X-Received: by 2002:a05:690e:12cd:b0:660:446b:7aad with SMTP id
 956f58d0204a3-662fffb397cmr11964367d50.57.1782140616133; Mon, 22 Jun 2026
 08:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1781463125.git.mst@redhat.com>
 <786550e2d38a92e90c13eb9d57e3a72d7ab38d51.1781463125.git.mst@redhat.com>
In-Reply-To: <786550e2d38a92e90c13eb9d57e3a72d7ab38d51.1781463125.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2026 16:03:24 +0100
X-Gm-Features: AVVi8CetrJCB2lPBrNpd2Xo8UDzxMfXI5XVE079WoZtxkf8uFIenWJWt8MABaag
Message-ID: <CAFEAcA9ykhWZWDhtAonpRnc=LYDwN5S-vqO4cUdtx8AemcPhfg@mail.gmail.com>
Subject: Re: [PULL 063/106] amd_iommu: Follow root pointer before page walk
 and use 1-based levels
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
 qemu-stable@nongnu.org, David Hoppenbrouwers <qemu@demindiro.com>, 
 Sairaj Kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Sun, 14 Jun 2026 at 20:08, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>
> DTE[Mode] and PTE NextLevel encode page table levels as 1-based values, but
> fetch_pte() currently uses a 0-based level counter, making the logic
> harder to follow and requiring conversions between DTE mode and level.
>
> Switch the page table walk logic to use 1-based level accounting in
> fetch_pte() and the relevant macro helpers. To further simplify the page
> walking loop, split the root page table access from the walk i.e. rework
> fetch_pte() to follow the DTE Page Table Root Pointer and retrieve the top
> level pagetable entry before entering the loop, then iterate only over the
> PDE/PTE entries.
>
> The reworked algorithm fixes a page walk bug where the page size was
> calculated for the next level before checking if the current PTE was already
> a leaf/hugepage. That caused hugepage mappings to be reported as 4K pages,
> leading to performance degradation and failures in some setups.

Hi; Coverity flags up an issue with this commit. It won't have any
practical consequences, but it does show that there's something we
could clean up.

> +/*
> + * Validate DTE fields and extract permissions and top level data required to
> + * initiate the page table walk.
> + *
> + * On success, returns 0 and stores:
> + *   - top_level: highest page-table level encoded in DTE[Mode]
> + *   - dte_perms: effective permissions from the DTE
> + *
> + * On failure, returns -AMDVI_FR_PT_ROOT_INV. This includes cases where:
> + *   - DTE permissions disallow read AND write
> + *   - DTE[Mode] is invalid for translation
> + *   - IOVA exceeds the address width supported by DTE[Mode]
> + * In all such cases a page walk must be aborted.
> + */
> +static uint64_t amdvi_get_top_pt_level_and_perms(hwaddr address, uint64_t dte,
> +                                                 uint8_t *top_level,
> +                                                 IOMMUAccessFlags *dte_perms)

This function returns 0 on success, or a small negative number on
failure. But we have typed it as returning uint64_t.

> @@ -662,40 +708,49 @@ static uint64_t large_pte_page_size(uint64_t pte)
>  static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
>                            uint64_t *pte, hwaddr *page_size)
>  {
> -    IOMMUAccessFlags perms = amdvi_get_perms(dte);
> -
> -    uint8_t level, mode;
>      uint64_t pte_addr;
> +    uint8_t pt_level, next_pt_level;
> +    IOMMUAccessFlags perms;
> +    int ret;
>
> -    *pte = dte;
>      *page_size = 0;
>
> -    if (perms == IOMMU_NONE) {
> +    /*
> +     * Verify the DTE is properly configured before page walk, and extract
> +     * top pagetable level and permissions.
> +     */
> +    ret = amdvi_get_top_pt_level_and_perms(address, dte, &pt_level, &perms);

At the callsite we take that uint64_t return value and put it into
an "int" local variable. That potentially overflows. (In practice
none of the values actually returned will overflow.)

> +    if (ret < 0) {
> +        return ret;

Then we return that 'int' value from this function, which extends
it back out to uint64_t again.

> +    }

Since all of fetch_pte()'s callers put its return value into an 'int'
local variable, and fetch_pte() is the only function that calls
amdvi_get_top_pt_level_and_perms(), I think the right fix here is
to make both amdvi_get_top_pt_level_and_perms() and fetch_pte()
return "int" instead of "uint64_t". Then the type matches what the
return variable is (0 on success, small negative on failure) and
also the type of the variable that all the callers put it into.

thanks
-- PMM

