Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192F9CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 06:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utK5D-0001mr-N1; Tue, 02 Sep 2025 02:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1utK53-0001cY-0E
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 02:01:23 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1utK4z-0003hi-V1
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 02:01:20 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58260sXl001097
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 2 Sep 2025 15:00:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=7X9tGd+f2CrwF0lwbzTCSzdhJGImRG3QT20nmSE0/sg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1756792854; v=1;
 b=XTIJTfbRMEyjG9xY0TtS4ibqgm6WcNNA8KJFWBjgYf+YqTaUTEOCqTRDOwbWCZ7E
 4WoldnO7FblhbPSfH/qo1VCAU/vqCmZh9ajotcPcwEnKvlM0imKQwK5ndl8+O/KJ
 8U46UcR5rwWV32ohY2ZGNnUvOk9gFIyApvKw/8tQoA+MpCsXKcdG1cGk4nr4Wu4a
 IF4CHzlPCzUCniisaX0QVlbwSj+gco1AxzjRS7GrjyUf1EwVMkXAjKSrV+I5NOZS
 BiEdXFjHj3af8cAiclhn/SEhLbfCVCwPI/7G9tWbWqkzmurAtsdTn/wvslEcF63q
 UsapJ+a29KAVYqH/wT7xXA==
Message-ID: <ce0ab80a-aa8f-4cdf-a564-cd9fe9625566@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 2 Sep 2025 15:00:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pcie_sriov: Fix broken MMIO accesses from SR-IOV VFs
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "sriram.yagnaraman@ericsson.com" <sriram.yagnaraman@ericsson.com>,
 DAMIEN BERGAMINI <damien.bergamini@eviden.com>
References: <20250901151314.1038020-1-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250901151314.1038020-1-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/09/02 0:14, CLEMENT MATHIEU--DRIF wrote:
> From: Damien Bergamini <damien.bergamini@eviden.com>
> 
> Starting with commit cab1398a60eb, SR-IOV VFs are realized as soon as
> pcie_sriov_pf_init() is called.  Because pcie_sriov_pf_init() must be
> called before pcie_sriov_pf_init_vf_bar(), the VF BARs types won't be
> known when the VF realize function calls pcie_sriov_vf_register_bar().
> 
> This breaks the memory regions of the VFs (for instance with igbvf):
> 
> $ lspci
> ...
>      Region 0: Memory at 281a00000 (64-bit, prefetchable) [virtual] [size=16K]
>      Region 3: Memory at 281a20000 (64-bit, prefetchable) [virtual] [size=16K]
> 
> $ info mtree
> ...
> address-space: pci_bridge_pci_mem
>    0000000000000000-ffffffffffffffff (prio 0, i/o): pci_bridge_pci
>      0000000081a00000-0000000081a03fff (prio 1, i/o): igbvf-mmio
>      0000000081a20000-0000000081a23fff (prio 1, i/o): igbvf-msix
> 
> and causes MMIO accesses to fail:
> 
>      Invalid write at addr 0x281A01520, size 4, region '(null)', reason: rejected
>      Invalid read at addr 0x281A00C40, size 4, region '(null)', reason: rejected
> 
> To fix this, VF BARs are now registered with pci_register_bar() which
> has a type parameter and pcie_sriov_vf_register_bar() is removed.
> 
> Fixes: cab1398a60eb ("pcie_sriov: Reuse SR-IOV VF device instances")
> Signed-off-by: Damien Bergamini <damien.bergamini@eviden.com>
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

