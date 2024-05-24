Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A07C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 17:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAYcf-0001MG-Bq; Fri, 24 May 2024 13:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <julien@xen.org>)
 id 1sAYcb-0001Kt-Nl; Fri, 24 May 2024 13:22:26 -0400
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <julien@xen.org>)
 id 1sAYcX-0001bN-Ah; Fri, 24 May 2024 13:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
 s=20200302mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID;
 bh=p+cSGY0JtnJyEyyDIOldXHvk2CiVm4l7H2fIuwcCo6I=; b=Dts3otviMrYN5n5Bx9niYxPt6+
 coOU8MRVCysjtZkkoKTFds26H1DhBleim6dxjZdgXCfvIYRlVwC6B4nONm4QBCLW5jYKJLYi6OzSP
 9/2KApw+XGA5WmJeQOKdpvDUgcP7/mrl1YMh4TijH/uJIEDdgqinS9TYrSX5JnzDcjzY=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.92)
 (envelope-from <julien@xen.org>)
 id 1sAYcR-00009l-6i; Fri, 24 May 2024 17:22:15 +0000
Received: from gw1.octic.net ([88.97.20.152] helo=[10.0.0.211])
 by xenbits.xenproject.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <julien@xen.org>)
 id 1sAYcQ-0004oz-Vf; Fri, 24 May 2024 17:22:15 +0000
Message-ID: <0b40423d-cf19-46a0-a86f-aefc5c7b02b1@xen.org>
Date: Fri, 24 May 2024 18:22:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 18/18] hw/arm/virt: Set SMMU OAS based on CPU
 PARANGE
Content-Language: en-GB
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 eric.auger@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-19-smostafa@google.com>
From: Julien Grall <julien@xen.org>
In-Reply-To: <20240429032403.74910-19-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=104.130.215.37; envelope-from=julien@xen.org;
 helo=mail.xenproject.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

Hi Mostafa,

On 29/04/2024 04:24, Mostafa Saleh wrote:
> Use the new SMMU property to make the SMMU OAS match the CPU PARANGE.
> That's according to SMMU manual ARM IHI 0070F.b: >      6.3.6 SMMU_IDR5, OAS must match the system physical address size.

> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>   hw/arm/virt.c      | 14 ++++++++++++--
>   target/arm/cpu.h   |  2 ++
>   target/arm/cpu64.c |  5 +++++

When trying to build qemu-system-arm, I get the following error:

[1/3028] Generating subprojects/dtc/version_gen.h with a custom command
[2/3028] Generating qemu-version.h with a custom command (wrapped by 
meson to capture output)
[3/3021] Linking target qemu-system-aarch64
[4/3021] Linking target qemu-system-arm
FAILED: qemu-system-arm
clang -m64 -mcx16 @qemu-system-arm.rsp
libqemu-arm-softmmu.fa.p/hw_arm_virt.c.o: In function `get_system_oas':
/home/jgrall/works/oss/qemu/build/../hw/arm/virt.c:259: undefined 
reference to `cpu_arm_get_oas'
clang-11: error: linker command failed with exit code 1 (use -v to see 
invocation)
ninja: build stopped: subcommand failed.
make: *** [run-ninja] Error 1

I think you need to provide cpu_arm_get_oas() also for 32-bit arm (I 
guess it is implemented in target/arm/cpu.c).

Cheers,

-- 
Julien Grall

