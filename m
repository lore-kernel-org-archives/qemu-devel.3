Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD67EC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 11:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhpR9-0005EX-L3; Wed, 06 Mar 2024 06:27:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1rhpR2-0005EJ-Ao
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 06:27:45 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1rhpQy-0008C3-Dk
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 06:27:44 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBX00AYU+hleQg4Bg--.13040S2;
 Wed, 06 Mar 2024 19:27:20 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
 by mail (Coremail) with SMTP id AQAAfwCXZYIQU+hlc28AAA--.730S3;
 Wed, 06 Mar 2024 19:27:13 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Questions about CXL RAS injection test in qemu
Date: Wed,  6 Mar 2024 19:27:07 +0800
Message-Id: <20240306112707.3116081-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCXZYIQU+hlc28AAA--.730S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAQAWXnc+MHVAABsQ
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxZw4xXw4rCr4ktFW8XF17trb_yoW5Ww4Upa
 4xt3s2q34rJ3WxJa4DAFy8Z3W2qrn3XayDWF1UGrnYyFyjqr4rXr48Ka4Y9w1rKr97G343
 Xa4ktFs8Ga1DW3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello, Jonathan

Recently I met some problems on CXL RAS tests. 

I tried to use "cxl-inject-uncorrectable-errors" and "cxl-inject-correctable-error"
qmp to inject CXL errors, however, there was no any kernel printing information in 
my qemu machine. And the qmp connection was unstable that made the machine 
always "terminating on signal 2".

In addition, I successfully used the hmp "pcie_aer_inject_error" in the same conditions.
The kernel showed relevant print information.

Question:
1) Is my CXL RAS test operations standard?
2) The error injected by "pcie_aer_inject_error" is "protocol & link errors" of cxl.io?
   The error injected by "cxl-inject-uncorrectable-errors" or "cxl-inject-correctable-error" is "protocol & link errors" of cxl.cachemem?

Hope I can get some helps here, any help will be greatly appreciated.


My qemu command line:
qemu-system-x86_64 \
-M q35,nvdimm=on,cxl=on \
-m 4G \
-smp 4 \
-object memory-backend-ram,size=2G,id=mem0 \
-numa node,nodeid=0,cpus=0-1,memdev=mem0 \
-object memory-backend-ram,size=2G,id=mem1 \
-numa node,nodeid=1,cpus=2-3,memdev=mem1 \
-object memory-backend-ram,size=256M,id=cxl-mem0 \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
-device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
-device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem0 \
-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k \
-hda ../disk/ubuntu_x86_test_new.qcow2 \
-nographic \
-qmp tcp:127.0.0.1:4444,server,nowait \

Qemu version: 8.2.50, the lastest commit of branch cxl-2024-03-05 in "https://gitlab.com/jic23/qemu" 
Kernel version: 6.8.0-rc6

My steps in the Qemu qmp:
1) telnet 127.0.0.1 4444

result:
Trying 127.0.0.1...
Connected to 127.0.0.1.
Escape character is '^]'.
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 8}, "package": "v6.2.0-19482-gccfb4fe221"}, "capabilities": ["oob"]}}

2) { "execute": "qmp_capabilities" }

result:
{"return": {}}

3) If inject correctable error:
{ "execute": "cxl-inject-correctable-error",
    "arguments": {
        "path": "/machine/peripheral/cxl-mem0",
        "type": "physical"
    } }

result:
{"return": {}}

3) If inject uncorrectable error:
{ "execute": "cxl-inject-uncorrectable-errors",
  "arguments": {
    "path": "/machine/peripheral/cxl-mem0",
    "errors": [
        {
            "type": "cache-address-parity",
            "header": [ 3, 4]
        },
        {
            "type": "cache-data-parity",
            "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
        },
        {
            "type": "internal",
            "header": [ 1, 2, 4]
        }
        ]
  }}

result:
{"return": {}}
{"timestamp": {"seconds": 1709721640, "microseconds": 275345}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-signal"}}

Many thanks
Yuquan


