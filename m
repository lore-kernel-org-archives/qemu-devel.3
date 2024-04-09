Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A66CD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 15:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruDBR-0004cZ-MP; Tue, 09 Apr 2024 11:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ruDBP-0004bt-JI
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 11:14:47 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ruDBL-0000fb-Vn
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 11:14:47 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VDTs30xhvz6K6cM;
 Tue,  9 Apr 2024 23:09:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 291E6140DB0;
 Tue,  9 Apr 2024 23:14:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 9 Apr
 2024 16:14:28 +0100
Date: Tue, 9 Apr 2024 16:14:27 +0100
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
CC: <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Leif Lindholm
 <quic_llindhol@quicinc.com>, Ard Biesheuvel <ardb+tianocore@kernel.org>,
 Xiong Yining <xiongyining1480@phytium.com.cn>, Chen Baozi
 <chenbaozi@phytium.com.cn>
Subject: Re: How to use pxb-pcie in correct way?
Message-ID: <20240409161427.00001b1c@Huawei.com>
In-Reply-To: <8b9b96e1-faaa-4866-aeb9-c439d5f83139@linaro.org>
References: <8b9b96e1-faaa-4866-aeb9-c439d5f83139@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 8 Apr 2024 13:58:00 +0200
Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org> wrote:

> For quite a while I am experimenting with PCI Express setup on SBSA-Ref 
> system. And finally decided to write.
> 
> We want to play with NUMA setup and "pxb-pcie" can be assigned to NUMA 
> node other than cpu0 one. But adding it makes other cards dissapear...
> 
> When I boot sbsa-ref I have plain PCIe setup:
> 
> (qemu) info pci
>    Bus  0, device   0, function 0:
>      Host bridge: PCI device 1b36:0008
>        PCI subsystem 1af4:1100
>        id ""
>    Bus  0, device   1, function 0:
>      Ethernet controller: PCI device 8086:10d3
>        PCI subsystem 8086:0000
>        IRQ 255, pin A
>        BAR0: 32 bit memory at 0xffffffffffffffff [0x0001fffe].
>        BAR1: 32 bit memory at 0xffffffffffffffff [0x0001fffe].
>        BAR2: I/O at 0xffffffffffffffff [0x001e].
>        BAR3: 32 bit memory at 0xffffffffffffffff [0x00003ffe].
>        BAR6: 32 bit memory at 0xffffffffffffffff [0x0003fffe].
>        id ""
>    Bus  0, device   2, function 0:
>      Display controller: PCI device 1234:1111
>        PCI subsystem 1af4:1100
>        BAR0: 32 bit prefetchable memory at 0x80000000 [0x80ffffff].
>        BAR2: 32 bit memory at 0x81084000 [0x81084fff].
>        BAR6: 32 bit memory at 0xffffffffffffffff [0x00007ffe].
>        id ""
> 
> Adding extra PCIe card works fine - both just "igb" and "igb" with 
> "pcie-root-port".
> 
> But adding "pcie-root-port" + "igb" and then "pxb-pcie" makes "igb" 
> dissapear:
> 
> ../code/qemu/build/qemu-system-aarch64
> -monitor telnet::45454,server,nowait
> -serial stdio
> -device pcie-root-port,id=ULyWl,slot=0,chassis=0
> -device igb,bus=ULyWl
> -device pxb-pcie,bus_nr=1

That's setting the base bus number to 1.  Very likely to clash with the bus
number for the bus below the root port.

Set it to bu_nr=128 or something like that.

There is no sanity checking for PXBs because the bus enumeration is
an EDK2 problem in general - short of enumerating the buses in QEMU
there isn't a way for it to tell.

J

