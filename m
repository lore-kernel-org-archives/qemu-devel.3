Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981F2C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 08:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvBJs-0005rV-Ol; Thu, 20 Mar 2025 04:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1tvBJp-0005rA-LQ
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 04:32:01 -0400
Received: from mail.8bytes.org ([85.214.250.239])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1tvBJn-0005vK-Lb
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 04:32:01 -0400
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id C805D46439;
 Thu, 20 Mar 2025 09:31:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1742459514;
 bh=2jUMTDyC9nhzpelpiou1rrlJVdGk1ZcYh5dziWlZ6Xg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bzEOy22o3p2kFdTvab9sBnFFvO0ektZ6L6pqavXDXXQaRTcnNQphMX5nvUJShMehr
 N2J2yKRJx5vwhmWMAKGC2tteL6p/3bKbhpwTTRptqS1Y2IQKu4HWRjOJJwgKRxkyfr
 8zxQ4TnFXP0JDoO2pfNDsw6IiJAdYl2NYlHVy858syqwXqem9G2M8RXBO24jFw+SMb
 3GgKiEsMuv8bXguYnjFKGNQ6v2AfafReAQYnL+zfRrqmqTf4RMEWk76P3BR2r7cetL
 LbChUp/eC/yvalvGe0U2RsSg6uu33MJAPapkAs+GzdFLBzUizj1pw3kBlWLhWUI4x/
 DAvun6ewpXbPA==
Date: Thu, 20 Mar 2025 09:31:52 +0100
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: Gerd Hoffman <kraxel@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <Z9vSeF67fNazkxBh@8bytes.org>
References: <sxavsa2i4drnei4kmy6pd4uekk3xaa43njd47jtogar7ui7qm7@n73chaex5ms2>
 <Z9LeILiEU5GfEHrl@8bytes.org>
 <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
 <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
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

(Excuse my delayed reply, still suffering from some flu or whatever...)

On Mon, Mar 17, 2025 at 10:56:04AM +0100, Gerd Hoffman wrote:
> Yep.  But we have to sort the details.
> 
>  (1) How we are going to load kernel + initrd in case the firmware is
>      igvm?  Just update the igvm to also include linux kernel and
>      initrd (see parallel reply from Jörg)?  If so, how does the
>      launched firmware find the kernel + initrd?
>      While digging around in the igvm spec I've seen there is the
>      concept of 'parameters'.  Can this be used to pass on the memory
>      location of kernel + initrd + cmdline?  Maybe the kernel hashes too?

The find the locations of the kernel, initrd, cmdline, ... I think IGVM
parameters, either directly or (preferably indirectly) are a good
solution. By "indirectly" I mean to put these regions on a separate and
measured page which also contains the region hashes.

This allows to put these regions as unmeasured memory into the IGVM and
speed up launching on some platforms.

>  (2) Will the igvm be generated on the fly from FUKI data?  Or should
>      the distros ship igvm images with firmware + kernel + initrd?

My preference would be that distros ship the tooling and components to
build IGVM files and build them during kernel update. If a distro comes
up with a generic initrd+cmdline it can also ship pre-built IGVM files.

From that IGVM-file the tooling can also extract expected measurements
and place them on some trusted verifier (e.g. remote or TPM).

>  (3) How we are going to handle uki add-ons?
> 
>  (4) Do we want keep the region list?  Or declare that igvm should be
>      used in case a single region is not enough?  Or even go all-in and
>      use IGVM exclusively?

No strong opinion here, but I just want to mention again that by
allowing a workflow with a pre-defined setup order for CVMs, the
implemented order in QEMU/KVM can not be changed afterwards without
breaking measurements for users.

Regards,

	Joerg

