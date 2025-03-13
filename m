Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DB2C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfW0-0007mU-HY; Thu, 13 Mar 2025 06:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1tsfVy-0007lF-1Y
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:10:10 -0400
Received: from mail.8bytes.org ([85.214.250.239])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1tsfVt-00014K-5g
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:10:07 -0400
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 3DCD245709;
 Thu, 13 Mar 2025 11:10:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1741860603;
 bh=aOwIyDZIRMBqM/ui3eQLqIacYLvR+ojEZS0MMN7Raik=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g/aqzEhnpjt3F6iRliQqOf0fBqnR9lbTuKgfzFXn3ST9WQhJZyHAqVO9RQO7rAEFO
 4X4l+1wm+DLI70TvQQkcFqO4X3trQXqzgaGqEUs5N3IAKkBCMIN1CLe6N6Cml0XDTV
 0CcEqZMWYZ3N/WV8PiBeqqo8BdNJ9qPKHIMLP+jF5zKciiY9EtF58mrHTBoyExYfVH
 KUKkVBuajnyHDC+S7KRuNCdsjxvYZ+v4H2mK49PNfKOKWNROvzssF+cdVXNyNQKBwK
 p4v5R6SV54BAXCjvgGYG4HHs2YvxjkFnUUvsQNkdCLOtFbcgyHvRJ9nYshsojffJY9
 816qU7sYnWYUg==
Date: Thu, 13 Mar 2025 11:10:02 +0100
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
Message-ID: <Z9Ku-o8zJUWgXoYE@8bytes.org>
References: <20250214153443.159889-1-anisinha@redhat.com>
 <Z9KfMPKr9Tsz-psi@8bytes.org>
 <CAK3XEhNHoLvK7zSb1ZYeaz_BCCU2bv+d5qguKaadaWqT55YqKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK3XEhNHoLvK7zSb1ZYeaz_BCCU2bv+d5qguKaadaWqT55YqKQ@mail.gmail.com>
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

On Thu, Mar 13, 2025 at 03:07:42PM +0530, Ani Sinha wrote:
> The state before reset is the state that uses stock firmware from the
> hyperscaler. The state after reset is a fresh new state that uses the
> "trusted and known firmware" from the end user. So the launch
> measurements would not match between the state before reset and the
> state after reset and there is no guarantee that there would be
> "predictable launch measurements" across the reset.

Right, I understand that the state before and after reset will have
different launch measurements, that is expected when booting with a
different firmware :)

> What we do guarantee is that after reset, the launch measurements that
> include the "trusted and known firmware" (whatever that is, not
> necessarily edk2), is understood and expected. If you were to
> calculate offline the measurements that include this "trusted and
> known firmware" using the same order of setup calls as the target
> system and then derive the launch digest, it should match that of what
> the hardware would produce in the target.

The devil lies in "same order of setup calls". Without a way to define
this order through the vmfwupdate interface there is a lot of implicit
knowledge required about how KVM/QEMU setup the TEE context to calculate
the expected after-reset launch measurement. Even worse, the exact way
this setup is done then becomes ABI, because any change in this process
will lead to a different launch measurement.

Some examples of initial memory layout calls which influence the launch
measurment:

	1) Launch VMSA(s) (SEV-SNP only, though I believe on TDX the
	   initial register state can also be changed to some
	   degree).
	2) Pre-Validated/Accepted memory regions (TDX and SEV-SNP). This
	   is especially important, as different FWs have different
	   requirements on what memory is pre-validated, zeroed, etc.
	3) Zero-pages, measured and unmeasured (TDX and SEV-SNP).
	4) Position of the CPUID page, secrets page, and id-blob
	   (SEV-SNP).
	5) Pre-populated data (TDX and SEV-SNP).

If I understand the vmfwupdate interface correctly, and please let me
know if I am wrong here, it only allows to specify a call for part 5) of
the above list. Some of the other parts can be specified in architecture
dependent ways in the FW image itself, but not all of them.

So the question is, is the plan to hardcode everything else (including
the order of calls) and make the behavior ABI?

Regards,

	Joerg

