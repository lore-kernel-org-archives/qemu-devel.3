Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685CBC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weD75-0006EQ-GR; Mon, 29 Jun 2026 10:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weD72-0006Dt-I6
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:37:29 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weD6w-0002MK-6e
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:37:24 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6626b5ace23so2516863d50.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 07:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782743840; cv=none;
 d=google.com; s=arc-20260327;
 b=HrLT2WUPF5t154XEfusqmYfL84KXk/sTq3La9XQARSlJv+6VohWtF3/GTG0+rR7ieV
 OjUWdOdl5bGqUOwFC0INAUJo/7uwdjZhvngjBJb3118m9GPaJyTUtA+4mSHI7qpiGBNN
 mdpRXBCnWeP15E74PQEAct0Dy63IsUTob0Xd4kRPHZNrM4MmfIzi3QpJzd8xZJCJxQ7/
 WHNXGdRpdF1f6waVxI/Wz3zIZ4LPNpPDg8P9MO+92ihudZThM/6fw46r5CWsn/Bwk/OG
 bLWWYDrdnxf0fKnw6U2VbrBfm9WKWczp1lz4ETZDIMZLRl9lN8Y56qeXZhrNcDsPW8nP
 TKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xlPH9m/FMS/iTLyriDfHfVmzTRkTQoZqThAVzFKtFl0=;
 fh=roDjFKv19ZllecJyRRgQ4fMQOxy44Ax9FITRP8Icy8I=;
 b=m+hGq3lgbBGeMG+0lUHpHyHHnBeavD+1mwdDtlv1qXEDD3EnR1tMxHwuSv3sIBBmsl
 4hnPTYqM1tIwmaJpHJdJtKHWWljm6xKyKOtC6TQryW7siqGLRykoyW0RIGGGM+jBUImp
 /him36tO/OC2g3GKYzf5qnsAQ7zekipWJ4emm84SoyCGMgzIouUORCDCCVtLl/3LNYPl
 4MwAEDe+x2iBOp5kmJ9tJyB2uNnmHSc7hHcFKfMLK6dnVZPd5u1ZEDQRhgwCtiQeq2eL
 SF6/YOrQQr4NDRGCwdRS3RQrbn+ZxyZEDtvEMWb4pp5PR3qke6LmvLGXcHcSsXoZ2L1S
 /BKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782743840; x=1783348640; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xlPH9m/FMS/iTLyriDfHfVmzTRkTQoZqThAVzFKtFl0=;
 b=bLl32QCmgbqNNY4GldT6rIgvh+0uIpDSeBKIitJs04PCcr2AfBVElbzC78lrBDaeyH
 JH7BUhQg5qLBSbNN0ANoCrgP7oepqne2tV9Pv5FrYJp/Xvk3MdrC9R6EnB7+MTfo9VqF
 MABEG7VkqLN6/y5RkuzYTAOkGxq+8O/Awi9P13wscvzt1wr6UdztboZiP5LnW9TnHOcf
 69VFhbzFsOKuf4zllIZsG/AhqD9ZAe0EZzIlYUBL+yvW8LhYqwogAylQsVpNLFXuPZGK
 nv9cLm6gUpmnAxvhMpvhApJSApx5YyYO/Ao1dWga6gIMU3bT6noitg0JJs58dFJ7Pr/U
 V3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782743840; x=1783348640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlPH9m/FMS/iTLyriDfHfVmzTRkTQoZqThAVzFKtFl0=;
 b=ci+xwX9JwqSH6/dWBgR/0Pf5j6xouygdrZRP6u+re5e/yQt8QAkhhqxyalBWZw7sPZ
 imKKD8902oP84t+sRecb0R+n7hwQ/Wy0oHfK3f0sjpXISrjHTX4BF6ZfseOR/fbmaT6a
 zrlZbwC8czydu0klrQGDxmAeT3OgqXfrEha87QwaWg0U9Itjx7oV/CBda4P/u8GrqacU
 Dx7MmdenrHx/cpKETAnxM5jPDgrFwIxRv6Q54HIaUrH5q0qhpWL4Mcv4YHpsDWkAUULd
 fV+8fPcbhsfFZpwF1JJEVIKOFxTa8RJK2QmvFrh+7HHJpw/suCP9ZXAsTIXu5TDHuVN6
 bfSw==
X-Gm-Message-State: AOJu0YzvUqCMP1ydlodZ6ck3AhnFdiAHQYCiVwqMkamBYQW+0CPs1o5i
 Xb9fTHsj6YnFb/9avwvlBBxUFhv2OeNOm5cz0RCFhJWBS/ssbryJfBe7Vdd95MNRQnBEkxbH50U
 6mzBTCEfvZ2Rn7ckgfFwQZVWH4XyI8PTJ9oBn/5lWag==
X-Gm-Gg: AfdE7clMGAnR6mmKtMyFKYAABu9NSDUIgvWJtLCGs95nLotuR8vELWIaeA8DbX0bQ5H
 HYtPyvFEmvU3iMDrcIKYmAHW3scrBrYrREyx5gV8zpzryGza2ZlHhvUSNea/azvFiVLwSrEKgnc
 NeDZkIbLD4tGBV+X8kT0RIqw/jlJytFys0ZNNnpi+2OkF7lHWzCgSIDF9+S8qDrkaJoN7cJdBeI
 Wcg4wlOSIoiIoCm9P6bciDmMhTUmIacMwcYj7oA5cdoFwA+/WQoHlXCh/QtS2WWqwkagSXWVgJ5
 fyOtgD3uJEywOles6PqWVAXjonWuZHzvrq65rwWnlvHkWpzGzpzcu796MICu0fMpmp8=
X-Received: by 2002:a05:690e:1242:b0:65c:74c2:31c6 with SMTP id
 956f58d0204a3-6648754c4f2mr12707486d50.5.1782743840240; Mon, 29 Jun 2026
 07:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260626101748.1728079-1-pbonzini@redhat.com>
 <20260626101748.1728079-31-pbonzini@redhat.com>
In-Reply-To: <20260626101748.1728079-31-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2026 15:37:08 +0100
X-Gm-Features: AVVi8CcN0E1u4aQt4iPllWAmtbJmDOEJvqAzNMmXSQaaARLX0T4YXOr5lMn3Zqc
Message-ID: <CAFEAcA_v4guR1-MchVKoM_tQxW-ECWAvRLLY9MR7qMC0XjOcFA@mail.gmail.com>
Subject: Re: [PULL 30/45] target/i386/mshv: migrate MSRs
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Fri, 26 Jun 2026 at 11:22, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Magnus Kulke <magnuskulke@linux.microsoft.com>
>
> In this change the we rewrite the existing MSR logic to make MSRs
> migratable:
>
> - we map them on existing QEMU fields in the CPU. A table and a macro
>   MSHV_ENV_FIELD is used to associate a HV register name to the their msr
>   index and their offset in the cpu state struct. The list is not
>   exhaustive and will be extended in follow-up commits.
> - mshv_set/get_msrs() fns are called in the arch_load/store_vcpu_state()
>   fns. they use use generic registers ioctl's and map the input/output
>   via load/store_to/from_env() from/to the hv register content to the
>   cpu state representation.
> - init_msrs() has been moved from mshv-vcpu to the msr source file
> - we need to perform some filtering of MSR because before writing and
>   reading, because the hvcalls will fail if the partition doesn't
>   support a given MSRs.
> - Some MSRs are partition-wide and so we will only write the to on the
>   BSP.
>
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20260417105618.3621-21-magnuskulke@linux.microsoft.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hi; Coverity complains about use of an uninitialized struct
field in this commit (CID 1660875):

> +int mshv_get_msrs(CPUState *cpu)
> +{
> +    int ret = 0;
> +    size_t n_assocs = ARRAY_SIZE(msr_env_map);
> +    struct hv_register_assoc assocs[ARRAY_SIZE(msr_env_map)];

This array has no initializer, so the elements start out
with no initialized fields.

> +    size_t i, j;
> +    uint32_t name;
> +
> +    set_hv_name_in_assocs(assocs, n_assocs);

This function call (as its name suggests) sets the "name" field
in each element of the array, but no other fields.

> +
> +    /* Filter out MSRs that cannot be read */
> +    for (i = 0, j = 0; i < n_assocs; i++) {
> +        name = assocs[i].name;
> +
> +        if (!msr_supported(name)) {
> +            continue;
> +        }
> +
> +        if (j != i) {
> +            assocs[j] = assocs[i];

Here we do a full structure copy, which accesses (copying)
the uninitialized fields in assocs[i] ("reserved1", "reserved2",
"value").

Either the function should ensure it's initializing all
the fields, or else if we know and expect only the "name"
field to be initialized we should copy only the "name"
field, not the whole struct.

> +        }
> +        j++;
> +    }
> +    n_assocs = j;
> +
> +    ret = mshv_get_generic_regs(cpu, assocs, n_assocs);
> +    if (ret < 0) {
> +        error_report("Failed to get MSRs");
> +        return -errno;
> +    }
> +
> +    store_in_env(cpu, assocs, n_assocs);
> +
> +    return 0;
> +}

thanks
-- PMM

