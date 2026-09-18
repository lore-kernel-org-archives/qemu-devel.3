Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B480C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YZm-0005vS-97; Fri, 18 Sep 2026 09:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1x7YZk-0005vJ-DM
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1x7YZi-0000gP-ME
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789737860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y03CptqPpMz1qV88YXGt1sI6qsry1H9sngOkjjJV1H4=;
 b=isCSG1Wl93vv9OyjHhfQBMX1VZpP6dTjGf6cvYc9krzXy+ZfaGr9XKBwejosslcNOS7Qiw
 ocLWlkC3q0BJlYE8rlA64Xm8aG/BEIPYpLG3yTeGsuy+aC8Hz0u0njDKUGRMwmgi4oIVj6
 YIWQJMUwo7raiWFhBQ5WR7IupwzZrbU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-SDl8Y-96NRix85NgrPSypA-1; Fri,
 18 Sep 2026 09:24:14 -0400
X-MC-Unique: SDl8Y-96NRix85NgrPSypA-1
X-Mimecast-MFC-AGG-ID: SDl8Y-96NRix85NgrPSypA_1789737852
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28AC11955F28; Fri, 18 Sep 2026 13:24:12 +0000 (UTC)
Received: from nucbdw.ghoffman.csb.home.kraxel.org
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 136FC1956047; Fri, 18 Sep 2026 13:24:11 +0000 (UTC)
Received: by nucbdw.ghoffman.csb.home.kraxel.org (Postfix, from userid 11758)
 id BEB1A407754F; Fri, 18 Sep 2026 15:24:08 +0200 (CEST)
Date: Fri, 18 Sep 2026 15:24:08 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: devel@edk2.groups.io, gaoliming@byosoft.com.cn, 
 ardb+tianocore@kernel.org, sami.mujawar@arm.com, jiewen.yao@intel.com, 
 qemu-devel@nongnu.org, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com
Subject: Re: [PATCH 0/3] MdeModulePkg, ArmVirtPkg, OvmfPkg: fixed PCI BAR
 placement
Message-ID: <aq06JQWs6KszJI9w@nucbdw.ghoffman.csb.home.kraxel.org>
References: <20260916192408.928411-1-tdave@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916192408.928411-1-tdave@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ghoffman@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

  Hi,

> The series was tested together with the QEMU companion patches on the
> AArch64 virt machine across a range of PCIe topologies: emulated devices,
> VFIO passthrough devices, PCIe switches, single and multiple fixed-BAR
> endpoints under a shared root port, and fixed BARs behind nested bridges.

Given this is active for both aarch64 and x86_64:  Any testing with OVMF
on x86_64?

Overall this looks good to me.  edk2 has switched to github PRs, so
please open a PR there.  edk2 has a policy that patches should not touch
multiple packages, so patch #2 should be split into two for ArmVirtPkg
and OvmfPkg.

take care,
  Gerd


