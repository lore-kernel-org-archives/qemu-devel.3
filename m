Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46908CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 01:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urRKs-00032m-RA; Wed, 27 Aug 2025 21:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1urRKp-00032P-Ug
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 21:21:52 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1urRKm-00066j-HE
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 21:21:51 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 57S1LTRR007800
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 28 Aug 2025 10:21:29 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=48nzBvMG5dwiKBAmOYm7PdmNzQy63EvBLBKRo2Foxqw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1756344089; v=1;
 b=EIbezIFfY0Ss5MGF6oZITwBKIGtesj8SIXZ+f65R1fyPa47Il5t88DLDbyHhcbXm
 dcIB778zYPxcjiszWpfrb6asNOujkqX/WQhvRgtmSJLBK+0DOTqnQN2Uq0A3AREo
 tCIF/R1b9tWwq62rSQj+df6flMFRDZFau8RSSmu9l7eBkPgoNz/gESLcK0iv6X8N
 /0zPBTcsCOYx4UOPCPQo1w5GmSTsZitO4xciXzf0PYw5pFg7Cg7uIUvMjfjiHR/3
 yB/JU6yrIJ2gFrNQB1ncQ7Q56fdxcbg7Pj9LcyS6d+bASL+o0Bl1uQvAqkPM62yy
 PBNcsOPzGuYoafkHTfxW5w==
Message-ID: <3a5b6c93-f32a-4824-ae1a-942de415ef58@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 28 Aug 2025 10:21:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pcie_sriov: Fix broken MMIO accesses from SR-IOV VFs
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "sriram.yagnaraman@ericsson.com" <sriram.yagnaraman@ericsson.com>,
 DAMIEN BERGAMINI <damien.bergamini@eviden.com>
References: <20250820083953.439635-1-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250820083953.439635-1-clement.mathieu--drif@eviden.com>
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

On 2025/08/20 17:41, CLEMENT MATHIEU--DRIF wrote:
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
> To fix this, a type parameter is added to pcie_sriov_vf_register_bar()
> to indicate the BAR type. It should be set to the same value as in the
> pcie_sriov_pf_init_vf_bar() call.

Thank you for debugging and proposing a fix.

There is no point of keeping pcie_sriov_vf_register_bar() though as it 
will be essentially identical with pci_register_bar(). It can be simply 
removed and replaced with pci_register_bar().

Regards,
Akihiko Odaki

