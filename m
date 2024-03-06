Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664D8C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhrFm-0004ui-3a; Wed, 06 Mar 2024 08:24:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhrFk-0004uU-DP
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:24:12 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhrFh-0000wS-NW
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:24:12 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TqY1G6v5Tz6K5pL;
 Wed,  6 Mar 2024 21:19:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 9AE8B140DB0;
 Wed,  6 Mar 2024 21:24:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 13:24:01 +0000
Date: Wed, 6 Mar 2024 13:23:59 +0000
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>, Robert Richter
 <rrichter@amd.com>, Terry Bowman <Terry.Bowman@amd.com>,
 <dan.williams@intel.com>
Subject: Enabling internal errors for VH CXL devices: [was: Re: Questions
 about CXL RAS injection test in qemu]
Message-ID: <20240306132359.00001956@Huawei.com>
In-Reply-To: <20240306112707.3116081-1-wangyuquan1236@phytium.com.cn>
References: <20240306112707.3116081-1-wangyuquan1236@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 6 Mar 2024 19:27:07 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> Hello, Jonathan
> 
> Recently I met some problems on CXL RAS tests. 
> 
> I tried to use "cxl-inject-uncorrectable-errors" and "cxl-inject-correctable-error"
> qmp to inject CXL errors, however, there was no any kernel printing information in 
> my qemu machine. And the qmp connection was unstable that made the machine 
> always "terminating on signal 2".

The qmp connection being unstable is odd - might be related to the CXL code, but
I'm not sure how..

> 
> In addition, I successfully used the hmp "pcie_aer_inject_error" in the same conditions.
> The kernel showed relevant print information.

IIRC the AER paths print under all circumstances whereas CXL errors do not, they simply
trigger tracepoints - but you should have seen device resets.

However I span up a test and I think the issue is more straight forward.
The uncorrectable internal error and correctable internal errors are masked on the device.
I thought we changed the default on this in linux but maybe not :(

Hack is fine the relevant device with lspci -tv and then use
setpci -s 0d:00.0 0x208.l=0
to clear all the mask bits for uncorrectable errors.

Note I tested this on a convenient arm64 setup so always possible there is yet
another problem on x86.

Robert / Terry, I tracked down the patch where you enabled this for RCHs and there was
some discussion on walking out on VH as well to enable this, but seems it
never happened. Can you remember why?  Just kicked back for a future occasion?

Jonathan


> 
> Question:
> 1) Is my CXL RAS test operations standard?
> 2) The error injected by "pcie_aer_inject_error" is "protocol & link errors" of cxl.io?
>    The error injected by "cxl-inject-uncorrectable-errors" or "cxl-inject-correctable-error" is "protocol & link errors" of cxl.cachemem?
> 
> Hope I can get some helps here, any help will be greatly appreciated.
> 
> 
> My qemu command line:
> qemu-system-x86_64 \
> -M q35,nvdimm=on,cxl=on \
> -m 4G \
> -smp 4 \
> -object memory-backend-ram,size=2G,id=mem0 \
> -numa node,nodeid=0,cpus=0-1,memdev=mem0 \
> -object memory-backend-ram,size=2G,id=mem1 \
> -numa node,nodeid=1,cpus=2-3,memdev=mem1 \
> -object memory-backend-ram,size=256M,id=cxl-mem0 \
> -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
> -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem0 \
> -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k \
> -hda ../disk/ubuntu_x86_test_new.qcow2 \
> -nographic \
> -qmp tcp:127.0.0.1:4444,server,nowait \
> 
> Qemu version: 8.2.50, the lastest commit of branch cxl-2024-03-05 in "https://gitlab.com/jic23/qemu" 
> Kernel version: 6.8.0-rc6
> 
> My steps in the Qemu qmp:
> 1) telnet 127.0.0.1 4444
> 
> result:
> Trying 127.0.0.1...
> Connected to 127.0.0.1.
> Escape character is '^]'.
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 8}, "package": "v6.2.0-19482-gccfb4fe221"}, "capabilities": ["oob"]}}
> 
> 2) { "execute": "qmp_capabilities" }
> 
> result:
> {"return": {}}
> 
> 3) If inject correctable error:
> { "execute": "cxl-inject-correctable-error",
>     "arguments": {
>         "path": "/machine/peripheral/cxl-mem0",
>         "type": "physical"
>     } }
> 
> result:
> {"return": {}}
> 
> 3) If inject uncorrectable error:
> { "execute": "cxl-inject-uncorrectable-errors",
>   "arguments": {
>     "path": "/machine/peripheral/cxl-mem0",
>     "errors": [
>         {
>             "type": "cache-address-parity",
>             "header": [ 3, 4]
>         },
>         {
>             "type": "cache-data-parity",
>             "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
>         },
>         {
>             "type": "internal",
>             "header": [ 1, 2, 4]
>         }
>         ]
>   }}
> 
> result:
> {"return": {}}
> {"timestamp": {"seconds": 1709721640, "microseconds": 275345}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-signal"}}
> 
> Many thanks
> Yuquan
> 


