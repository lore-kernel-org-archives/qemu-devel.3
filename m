Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6421CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 10:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tu8-0000Ny-Gl; Wed, 01 Oct 2025 06:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v3ttx-0000Mp-9M; Wed, 01 Oct 2025 06:17:39 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v3ttn-0007eM-7t; Wed, 01 Oct 2025 06:17:36 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 591AH1gf074113
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 1 Oct 2025 19:17:01 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=WwGyfgOJRc3n2UMskAdT1Pa5qqQWF/3sFrvAYIy670w=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1759313822; v=1;
 b=SbmZI8atgDgdJg8eDGxaYrWpb8RMnvBhbl/XPXUG40JgHHeqwoCVyJ2lG5WOvdzM
 uV2XfuPnrvYns/NUMIcG1Wlufk5DIZoeSSYrnEx9eQj3HkSbRqUCBJvHxvM3GM6G
 5uKFsiZ0gXYThF/bBV/QcUpQ4QyfoYQJ2KtskthuyX1ASiyLeVVAuTcIzBh3v66I
 yyWsQIwcrcuEO7gRiSw1C2AnppkhM9FI2a/vsI4brgJMbdKeJPnUWmo4guYOJAzK
 9FDyndIhURpZERtDn1D5sa+5uzPhb8zesI+aXiw8nOHoM2RDe5or0wFU649VSGsX
 TWVAUzT9EOULDhwdtVqpuQ==
Message-ID: <39ad8109-d24c-4379-9622-3876cc233743@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 1 Oct 2025 19:17:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pcie_sriov: make pcie_sriov_pf_exit() safe on non-SR-IOV
 devices
To: Michael Tokarev <mjt@tls.msk.ru>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Qing Wang <qinwang@redhat.com>,
 qemu-stable@nongnu.org
References: <20250924155153.579495-1-stefanha@redhat.com>
 <20250924175146.GA6015@fedora>
 <118e759d-026b-46d4-8b13-5eddb3e971f7@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <118e759d-026b-46d4-8b13-5eddb3e971f7@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/09/27 22:58, Michael Tokarev wrote:
> On 24.09.2025 20:51, Stefan Hajnoczi wrote:
>> On Wed, Sep 24, 2025 at 11:51:53AM -0400, Stefan Hajnoczi wrote:
>>> Commit 3f9cfaa92c96 ("virtio-pci: Implement SR-IOV PF") added an
>>> unconditional call from virtio_pci_exit() to pcie_sriov_pf_exit().
>>>
>>> pcie_sriov_pf_exit() reads from the SR-IOV Capability in Configuration
>>> Space:
>>>
>>>    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
>>>    ...
>>>    unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
>>>                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>
>>> This results in undefined behavior when dev->exp.sriov_cap is 0 because
>>> this is not an SR-IOV device. For example, unparent_vfs() segfaults when
>>> total_vfs happens to be non-zero.
>>>
>>> Fix this by returning early from pcie_sriov_pf_exit() when
>>> dev->exp.sriov_cap is 0 because this is not an SR-IOV device.
>>>
>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Reported-by: Qing Wang <qinwang@redhat.com>
>>> Buglink: https://issues.redhat.com/browse/RHEL-116443
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>   hw/pci/pcie_sriov.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> CCing qemu-stable
> 
> Ping?  Can we apply this to the master branch, so I can pick it
> up for the stable series?

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

I also think it should have:

Fixes: cab1398a60eb ("pcie_sriov: Reuse SR-IOV VF device instances")

Regards,
Akihiko Odaki

