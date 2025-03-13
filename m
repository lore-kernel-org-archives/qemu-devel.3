Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5B6C282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 15:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tskfB-0004wl-Pb; Thu, 13 Mar 2025 11:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1tskf9-0004wI-6G
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:39:59 -0400
Received: from mail.8bytes.org ([85.214.250.239])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1tskf7-0004aI-Hy
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:39:58 -0400
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 119D14550C;
 Thu, 13 Mar 2025 16:39:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1741880395;
 bh=/1trWfMSL3RwQVf9Fp4HqMBC31Nmb8n71JNlDfGwX/Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lk2X8zTspJ23ZUHnAO9MSqwldBnBdPAvaFzQ5e8YhnixyFqxMxBbbhwb193Og1pPJ
 Vi9CeB5aCSmYw+OXPoJkHw8I9L+eiSkCaUhFcn/2TlBqvNufqyfIy8UEbI5xTcVvQY
 2aQzuaWdoZAI5sydUuzvpkpHLdF4RiySV95aalbKYu3ZEebA35UEJyDPSuZsNjcLkk
 wd8Vgv4TCLmwUcF6qZTsc4oO5bxzRZlwlPhJf1xxVmDxNyakkpDw9ispu887bAbYoY
 Zd0WgiEB9agXCykVtxf0Z4DqzllbKI2HNKN6/CVQF42iMZsN+8WKIFYJq/ac84XGiW
 Pq9YTf4SnVBqg==
Date: Thu, 13 Mar 2025 16:39:53 +0100
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: Ani Sinha <anisinha@redhat.com>
Cc: Alex Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
Message-ID: <Z9L8SYW8ObyoDMLy@8bytes.org>
References: <20250214153443.159889-1-anisinha@redhat.com>
 <Z9KfMPKr9Tsz-psi@8bytes.org>
 <CAK3XEhNHoLvK7zSb1ZYeaz_BCCU2bv+d5qguKaadaWqT55YqKQ@mail.gmail.com>
 <Z9Ku-o8zJUWgXoYE@8bytes.org>
 <CAK3XEhOnhpzSg3F2C+PEvjgPKH7Yc9MqyoL8qJJGcbGXign34A@mail.gmail.com>
 <Z9K6nrGwnyob9tED@8bytes.org>
 <CAK3XEhNDnX1+W9jZ_MZaSYKHBwS-dCUbjhPVav7Q1OxaAzJ73Q@mail.gmail.com>
 <Z9LBD_FnO2Gi2vMK@8bytes.org>
 <CAK3XEhMa3Bvy42ErqAhf9vE+oUH1ZkHhv8JZRv1BpyfdejYMYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK3XEhMa3Bvy42ErqAhf9vE+oUH1ZkHhv8JZRv1BpyfdejYMYQ@mail.gmail.com>
Received-SPF: pass client-ip=85.214.250.239; envelope-from=joro@8bytes.org;
 helo=mail.8bytes.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Mar 13, 2025 at 08:23:44PM +0530, Ani Sinha wrote:
> Note that even with this approach where the hypervisor *thinks* it's
> dealing with a real firmware, you can imagine a small rust based
> firmware image that is loaded by the guest in the firmware region.
> This tiny firmware then jumps to a well known address (chosen by the
> guest) where IGVM is loaded and then starts executing the IGVM
> instructions.

Yes, but this way the predictable launch measurement property of IGVM
is lost, as the measurement only contains hashes for the actions
which happened before the VM was finalized and launched by the VMM. The
SEV policy can also not be changed anymore when the guest is running.

Anyway, I think it doesn't matter much whether the IGVM is parsed in
guest context or by QEMU, as long as the resulting measurement is the
same as if the file was loaded at initial VM launch.

Given that QEMU will hopefully get IGVM backend support soon, there is
some value and saved effort in just passing the IGVM data to the VMM via
the vmfwupdate interface and let QEMU do the rest.

Regards,

	Joerg


