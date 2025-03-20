Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787E9C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 12:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvEqI-00026O-0R; Thu, 20 Mar 2025 08:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1tvEqG-00026D-LZ
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:17:44 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1tvEqE-0005Rg-Er
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 08:17:44 -0400
Received: by linux.microsoft.com (Postfix, from userid 1219)
 id 408402116B34; Thu, 20 Mar 2025 05:17:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 408402116B34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1742473059;
 bh=wHXdCxm5HCr0q8DbzSLrCpiLNzNr2yDR86+dEqwoIeA=;
 h=Date:From:To:Cc:Subject:From;
 b=A+FCMVeTjPKbjlbtDLBismxP3aWcVcuJUbcn50mxLfq6PuYZXOHa13Z3p2YGLziQl
 x2JHPkI6tmwaeGOLik180kGUFb232qaR+psr83+p/yOg/nhVgu3muZ90ATjgu1ZpW1
 4+QeFsaImYKUsLra2pzrxXExT4rzP+RuTn97Xb6E=
Date: Thu, 20 Mar 2025 05:17:39 -0700
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: magnuskulke@microsoft.com, liuwe@linux.microsoft.com,
 liuwe@microsoft.com, wei.liu@kernel.org
Subject: ANN: working on an accelerator for MSHV
Message-ID: <20250320121739.GA14189@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Hi all, 

We would like to informally announce an effort we started at Microsoft to
expose the Microsoft Hypervisor (MSHV) as an alternative accelerator in Qemu on
Linux hosts. L1 VMs that have been launched on Azure or HyperV will be able to
use a /dev/mshv device to accelerate the operation of L2 (nested) VMs. The
support for this device is currently being contributed to the kernel:

https://lore.kernel.org/linux-hyperv/1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com/T/#t

+-------------+ +----------------+ +--------------+
|             | |                | |              |
| Azure Host  | | L1 Linux Dom0  | | L2 Guest VM  |
|             | |                | |              |
|     OS      | |                | |              |
|             | | +------------+ | |              |
|             | | |  Qemu VMM  | | |              |
|             | | +------------+ | |              |
|             | | +------------+ | |              |
|             | | |   Kernel   | | |              |
|             | | +-----+------+ | |              |
|             | +-------|--------+ +--------------+
|             | +-------v-------------------------+
|             | |    Microsoft Hypervisor (L1)    |
+-------------+ +-------+-------------------------+
                        |
+-----------------------v-------------------------+
|            Microsoft Hypervisor (L0)            |
+-------------------------------------------------+

+-------------------------------------------------+
|                                                 |
|                    Hardware                     |
|                                                 |
+-------------------------------------------------+

Please find an early snapshot of our work at this location:  

http://github.com/MSRSSP/qemu-mshv/tree/mshv (some build instructions can be
found in ./accel/mshv/rust/README.md)

Please note, this is a PoC which is outsourcing the majority of logic to
to a library version of the Cloud-Hypervisor VMM and several MSHV-specific
rust-vmm crates. This was done as a feasibility study since Cloud-Hypervisor
already supports MSHV as an accelerator technology (in addition to KVM). As
such it doesn't tie in with the Rust infrastructure that exists in Qemu today.
We are currently in the process of porting MSHV-related logic from
Cloud-Hypervisor to the Qemu code base, which would be what we aim to upstream.

In the mean time, for reference you might still want to look at the provided
PoC sources. We expect the self-contained Qemu port to be functionally
equivalent (in the early revision). However, please note that you would need
the aforementioned kernel patches on the Host if you would want to test the
accelerator.

We hope to be able to reuse the existing x86 instruction decoder/emulator that
already exists in the in Qemu's HVF accelerator (porting the emu from
Cloud-Hypervisor would be redundant). A colleagues has sent a patch that
attempts to generalize the emulator:

https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg01967.html

We hope to be able to send an early version of our port as a formal RFC patch
set soon and look forward to feedback!

thx,

Magnus

