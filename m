Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D63C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsmWC-00074E-Oc; Thu, 13 Mar 2025 13:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1tsmWA-0006zJ-Gd
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:38:50 -0400
Received: from mail.8bytes.org ([2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1tsmW7-0002HQ-Um
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:38:49 -0400
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id CE89B45A4C;
 Thu, 13 Mar 2025 18:38:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1741887525;
 bh=YUeM/40fQ1tR6LGx3H65nVXG0WendEqURUQ96QWS/tY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E9UDFEWyZvZQC+Mf9lVwpOi2VJDChKP6iZ/gpK7az3wv3ZOQNw6gdHOgvQTHbmnxJ
 MIfJZNTOuGVMrRcUE62bvzDizFuUgma5NEWHT0FAtNjngXjnJP/TTSH5RFfpB2tVqz
 LQh3pU2rNGY2UmSZT7aCx9lX9PtTW/Pl09v4fZR5IKBmMH4XEU3NuD8W2vhXAI8RGM
 aCyKZ/WFeDJbXV6fqOpo2hnGQ2geN9UqgAv1p8KjX0vI8CY5BKQaZAjZDtnN6qMt7b
 3mJ8sSRbuEcBIOodPMpfE0jQOyWmAzFYhFXYiElydwqy9eAxBs5W+gXteIWyUuFyhX
 9tqjNmpPg1zMQ==
Date: Thu, 13 Mar 2025 18:38:44 +0100
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: Alexander Graf <graf@amazon.com>
Cc: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <Z9MYJEG5RtTTXfpa@8bytes.org>
References: <Z9KfMPKr9Tsz-psi@8bytes.org>
 <CAK3XEhNHoLvK7zSb1ZYeaz_BCCU2bv+d5qguKaadaWqT55YqKQ@mail.gmail.com>
 <Z9Ku-o8zJUWgXoYE@8bytes.org>
 <CAK3XEhOnhpzSg3F2C+PEvjgPKH7Yc9MqyoL8qJJGcbGXign34A@mail.gmail.com>
 <Z9K6nrGwnyob9tED@8bytes.org>
 <CAK3XEhNDnX1+W9jZ_MZaSYKHBwS-dCUbjhPVav7Q1OxaAzJ73Q@mail.gmail.com>
 <Z9LBD_FnO2Gi2vMK@8bytes.org>
 <CAK3XEhMa3Bvy42ErqAhf9vE+oUH1ZkHhv8JZRv1BpyfdejYMYQ@mail.gmail.com>
 <Z9L8SYW8ObyoDMLy@8bytes.org>
 <b91881ee-69cb-46dc-82ff-b9781f480096@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b91881ee-69cb-46dc-82ff-b9781f480096@amazon.com>
Received-SPF: pass client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051;
 envelope-from=joro@8bytes.org; helo=mail.8bytes.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hey Alex,

On Thu, Mar 13, 2025 at 05:30:30PM +0100, Alexander Graf wrote:
> I have a few concerns with IGVM:
> 
> 1) Parsing is non-trivial. Parsing them in QEMU may open security issues.

There is an IGVM parsing library under MIT license and written in Rust
with C-bindings. The currently proposed IGVM support patches for
QEMU also make of it as well as (I believe) the implementations in the
two other hypervisors I am aware of.

That it's written in Rust is no guarantee that there are no issues, but
certain classes of common security bugs should already be avoided by
that.

> 2) Their data structures are tied to the target CPU structures like VMSA
> which FWIW are not fully owned by QEMU, are they?

Yes, those data structures are aligned with what the hardware consumes.
That makes it a lot easier to pre-calculate the launch-measurements, as
the tooling just needs to hash what is in the file without constructing
the hardware representation first.

Not sure what you mean by "owned by QEMU", all data in the IGVM file is
at least _consumed_ by QEMU and KVM to build the initial memory image of
the CVM. Once the CVM is launched all of the data belongs to the guest.

> 3) I don't want to allocate a bounce buffer for an IGVM in the hypervisor.
> So we would need to ensure that the memory allocated by the loader for the
> IGVM does not overlap any memory the IGVM wants to consume. If the loader
> considers the IGVM as opaque, that is difficult to achieve.

Right, I think that is a reasonable constraint that should be built into
the vmfwupdate protocol. The placement of the file in guest memory must
not overlap with any memory region that is deployed by the file. That
saves QEMU from the copying and allocating the space on the host side.

Regards,

	Joerg

