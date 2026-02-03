Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4692EE87823
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnFKj-000201-Tn; Tue, 03 Feb 2026 07:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vnFKM-0001sQ-8l
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:16:18 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vnFKJ-0003JM-Jo
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:16:17 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 613CF1Ek088794
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Feb 2026 21:16:06 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=d3dyI2BSUdJ4p7ETf9KIFMPQ6QF3mvWL6z0fqUOULhc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1770120967; v=1;
 b=vPPgHYwBMvzsa3FUjwEN4lyhTvv/qFJ+s2mOLGjZH9yMV992nQ7xqI1LQdxnXd61
 Txi/Cvp/B8ArPZi1jkASDbuJ6h4RtT6zvWqNs/CXPDKuju8B+5u5hMO4q1Th6hhh
 s7izbT3QzjbpOyAveiMZx/Cd5JR7RogUCZkBdejAZkguweIA0FrNhui6V8a1wCxK
 dmrXF+JI4bV3HgaBZ/Zcj4luS8Osb8vQ0iWE9FIeaP0+wos6RRReiRRa0eqt04cP
 VIX0Iyro6ysqWrfWwISeZKJhG3L0nRsDIN8pgV1K0Lt8fbjhU2VR3tls6HUQrEew
 BCHPGt2DcZxYZ8lrgMW3lA==
Message-ID: <6f4dbff4-4623-488a-9810-ef081d08f09c@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 3 Feb 2026 21:15:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260203073200.848183-1-vivek.kasireddy@intel.com>
 <20260203073200.848183-3-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260203073200.848183-3-vivek.kasireddy@intel.com>
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

On 2026/02/03 16:30, Vivek Kasireddy wrote:
> If the Guest provides a DMA address that is associated with a ram
> device (such as a VFIO PCI device region and not its system memory),
> then we can obtain the hva (host virtual address) by invoking
> address_space_translate() followed by memory_region_get_ram_ptr().
> 
> We cannot use dma_memory_map() because for memory regions that do
> not support direct access, it would create bounce buffers instead
> of returning the actual hva, which is not desirable here. And, since
> VFIO device regions are not considered directly accessible (because
> they are mostly MMIO based), virtio-gpu cannot invoke dma_memory_map()
> to obtain the hva in this case.
> 
> Therefore, in order to handle addresses associated with VFIO devices,
> we need to use the address_space_translate() API to first identify
> the right memory region and the appropriate offset within that
> region and then use memory_region_get_ram_ptr() to get the hva.
> This approach also works for addresses associated with the system
> memory region.
> 
> Note that, although we take an explicit reference on the memory
> region, we would still rely on dma_memory_unmap() to drop that
> reference when the dma mapping is eventually unmapped.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

