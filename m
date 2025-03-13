Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3484EC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 11:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsgI7-0008Bh-Oz; Thu, 13 Mar 2025 06:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1tsgI2-0008BB-Dl
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:59:50 -0400
Received: from mail.8bytes.org ([85.214.250.239])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1tsgHy-0006oW-9X
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:59:49 -0400
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id E42FC457A1;
 Thu, 13 Mar 2025 11:59:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1741863584;
 bh=O+anp+GrNPNP5CbIcz0QGEIZywgdj82Xshnlk6isQww=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=89jFkwWkNVsRSt8yYTBtxnCUTuYl4lk7wvu3qoJL6TxpnG4O0Tf6ySlf6/UVNjnZK
 KaM4dzEHmzSQbHQxBq02GAoqo2EcalZ5tXDCe+dQCf1V0nPQEQpUfUn5DCRMJ6n2/I
 UwqZBD7Fp71+B59hDBcHf1Nvf+NodcvAMQ15i5uuhQBsbx2layi+hTdsUM1ysTN44r
 ROOyIEFvJD58eUkqMzh0+/eVA4Ge+78oFchAcvhjDdGPDIEfzwLOcUhOVHi3wzFfL2
 GQhkzP0cE+rThCiE7XBKPFO+VCgea0srwb1sXakdWah8rbBqQDS6z+s8+LJXa+uPrj
 Ckp6PHOer3S5Q==
Date: Thu, 13 Mar 2025 11:59:42 +0100
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
Message-ID: <Z9K6nrGwnyob9tED@8bytes.org>
References: <20250214153443.159889-1-anisinha@redhat.com>
 <Z9KfMPKr9Tsz-psi@8bytes.org>
 <CAK3XEhNHoLvK7zSb1ZYeaz_BCCU2bv+d5qguKaadaWqT55YqKQ@mail.gmail.com>
 <Z9Ku-o8zJUWgXoYE@8bytes.org>
 <CAK3XEhOnhpzSg3F2C+PEvjgPKH7Yc9MqyoL8qJJGcbGXign34A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK3XEhOnhpzSg3F2C+PEvjgPKH7Yc9MqyoL8qJJGcbGXign34A@mail.gmail.com>
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

Hi Ani,

Don't get me wrong, I really like the general idea of vmfwupdate as
a way to implement BYOFW, and for non-confidential VMs it is great. I
just think the interface design is not well suited for confidential VMs
yet and want to discuss how to change that.

On Thu, Mar 13, 2025 at 04:02:11PM +0530, Ani Sinha wrote:
> Forgive my ignorance, today none of the hyperscalers use IGVM to
> define this. How then the expected launch measurement is derived?

There is at least one Hyperscaler which uses IGVM, another implemented
support for it in their hypervisor (although not for a BYOFW feature,
yet). In my view this problem is still widely being worked on today by
the CSPs. If you are lucky, and since the firmware is provided by the
CSP as well, they publish expected launch measurments for each of their
coco platforms.

> Our vmfwupdate interface does not make any attempt to define this in
> any way or make this an ABI. Its intentionally open ended. It's really
> up to the guest to set this up any way they wish. This is the same
> when the guest provides the igvm file that defines the above.

Without a way to supply user-defined setup steps of a confidential VM
the host-VMM has to hardcode them. And that hardcoded behavior becomes
ABI implicitly, because any change to this behavior will also change the
actual launch measurements, potentially breaking existing users.

This happened in the past already when KVM decided to hardcode a
different set of SEV-Features by enabling Debug-Swap. I strongly believe
that with KVM/QEMU we should work in a direction which makes those
breakages unlikely in the future.

Regards,

	Joerg

