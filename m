Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98B1D3E773
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 21:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8R4T-0001r8-AJ; Tue, 05 Nov 2024 16:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8R4Q-0001qj-S5
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:26:39 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8R4P-0000RA-4E
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:26:38 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c9634c9160so6751606a12.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 13:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730841994; x=1731446794; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UdNLloDLb/Io6eaUpvjIqDGO3DcJ/wOSSM+0y5erWoM=;
 b=ZV4O0moqFy9g9F2jL9IXe7IzeMTX5WU5k3HCjDaD/Xd1yMeocK6FSse9ltAYZp0eRU
 O2K/JoNsVQg8wSKEEbjnQsaacU5G+7CtfCCRKWWGikwyosgl+5TNAbH/JYYGg8jXAumR
 z19XKva2OvGdkr3t3V7U6xRVw4Fb0bZ3SLTfCy0XoLI3oXtz0pAWmkCPNUIYDKZALGZS
 fOk2qAWOZdkwbkyKMObkWyi85NTMwOc7W2mq195npkQ+JlnmTOOvaeqEldCQv65fxrxO
 jX4RMXb1icxex44p4kzUjZM7B+Y0uYMAq62nH8aXbsMKMYgiCOtTAn2FWuFDHXnLChas
 ggNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730841994; x=1731446794;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UdNLloDLb/Io6eaUpvjIqDGO3DcJ/wOSSM+0y5erWoM=;
 b=cLZ0ern5/CLrW6m+SGRQMR3mSYX/BfqJOi27R1zKpZNhjPV/9tZ4e6F0VbSfI8nIuw
 korG6NBmwyDRDayHaDTnHsVLAGSA0/TWS44Fwo/g5+YL++tnAWRjQje0rGKzwqL5oxkj
 o7ME3kiDeA6GdWbOqUTOy6fY8Lhls3tJ0jD+i9haTaKGGVQz4jU4WYj0+jmLmIkHPJx9
 Tgj93VkJTmaBhFtA0+pLLoQgWF0hM6WT/pTcO0doNzUsa8h9GB292EjUE8btnPdIMwth
 z751Ijq/YFBMAxdTGbKBEH7XR4BbFGEaiv+U+FvS38HJQVCPo9TBTUKJiFjFEEFgNH1i
 2/Vw==
X-Gm-Message-State: AOJu0YyX/NQxiuA/BBH8Q7XYyZGnyOiBm8X2hweKlJjVyOOb2VwMSXeX
 veepO+4rRVyqr8i/O3IyCd6JEeqYdkPrSefUMVmvFo0h3GM7NOEhRUfv/wDX62Obz9DgBvy3QJ6
 l0LjW4ler9VtsDbZaqMlLE/zZvaM7i3YCwl9ajIzT9piRkW6i
X-Google-Smtp-Source: AGHT+IGa/cHSuMebJ4OKXgjqMET+NY/togWHY1R/nPodTr6SrNYSaiS6UlSmaeOTiRnBPzPtByGe5gfPlKSV2/iV/x0=
X-Received: by 2002:a05:6402:3202:b0:5c4:14fe:971e with SMTP id
 4fb4d7f45d1cf-5cbbf920567mr26698322a12.23.1730841993931; Tue, 05 Nov 2024
 13:26:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730754238.git.mst@redhat.com>
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 21:26:22 +0000
Message-ID: <CAFEAcA8zg0fY3vJ5ee2oSuMLQ6AZwLHyfT7JXnKCDEg=Zhvf3A@mail.gmail.com>
Subject: Re: [PULL 00/65] virtio,pc,pci: features, fixes, cleanups
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 4 Nov 2024 at 21:05, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 92ec7805190313c9e628f8fc4eb4f932c15247bd:
>
>   Merge tag 'pull-riscv-to-apply-20241031-1' of https://github.com/alistair23/qemu into staging (2024-10-31 16:34:25 +0000)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 096d96e7be7071aa805c4e70ef51da0b99b6a8fc:
>
>   intel_iommu: Add missed reserved bit check for IEC descriptor (2024-11-04 16:03:25 -0500)
>
> ----------------------------------------------------------------
> virtio,pc,pci: features, fixes, cleanups
>
> CXL now can use Generic Port Affinity Structures.
> CXL now allows control of link speed and width
> vhost-user-blk now supports live resize, by means of
> a new device-sync-config command
> amd iommu now supports interrupt remapping
> pcie devices now report extended tag field support
> intel_iommu dropped support for Transient Mapping, to match VTD spec
> arch agnostic ACPI infrastructure for vCPU Hotplug
>
> Fixes, cleanups all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>



Applied to target-arm.next, thanks.

-- PMM

