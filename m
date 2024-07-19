Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE5AC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 06:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUh2a-0001Uo-32; Fri, 19 Jul 2024 02:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1sUh2Y-0001UJ-Kg
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 02:24:26 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruansy.fnst@fujitsu.com>)
 id 1sUh2V-0001jg-JU
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 02:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721370263; x=1752906263;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=j2S2BiTnFjnMDCqHjpzb2VhUaNfciznSi4vJjRSF6QU=;
 b=SHnVlRQaVC1m21cXkg3xSUwP6KbbEPpucGcGTLFBzEorQVClFyRqhKtl
 ZIWQLgrrys9fPyZ0gIczNW7oeRGn3boAgfJazGP4atIRNUzKSbV59S844
 b6D6Wvs4SGAf/QL3l0H/qaC5ShM5s/ii+w5NqC7z8ycFBQM47N5bAuPV/
 O2bc7oStGKrzvKhU2KqKOVrwb57GzTHjEtnL5f0nQjz7DJj9Nj6dKQfOb
 rm2CE03LFfBQeTTL+uKTwr06wWzPgAQvNYBURCH2sC3RlHqYxg+ggp6My
 f13QoUuv4idZvpfgwX5MUmleSq/fhjnTX9qhjTKP2ezwYvwUr/9jcFTJC w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="147292170"
X-IronPort-AV: E=Sophos;i="6.09,220,1716217200"; d="scan'208";a="147292170"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2024 15:24:18 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 63B9FD9230
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 15:24:16 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 9832DF67EE
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 15:24:15 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2C82D2007FAEF
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 15:24:15 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 6343B1A000A;
 Fri, 19 Jul 2024 14:24:13 +0800 (CST)
Message-ID: <1d98c0a9-3981-4a01-890a-00eb763a140c@fujitsu.com>
Date: Fri, 19 Jul 2024 14:24:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
To: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
 linux-edac@vger.kernel.org
Cc: dan.j.williams@intel.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 dave@stgolabs.net, ira.weiny@intel.com, alison.schofield@intel.com,
 dave.jiang@intel.com, vishal.l.verma@intel.com,
 Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
In-Reply-To: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28538.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28538.003
X-TMASE-Result: 10--24.299000-10.000000
X-TMASE-MatchedRID: Ef5f9TJi2wePvrMjLFD6eKn9fPsu8s0a2q80vLACqaeqvcIF1TcLYCxz
 RYsJiUavTn58gKg8la7m3gC+nXarcZcLewwAa76fs/Hes76OTZCNTfm/w05jw56fSoF3Lt+MnRw
 gpbfXKvNRzAfF54kYaWowq23ynEFcWHT+0u4LwuT+xRIVoKNMvH5Lmbb/xUua13kaiNHAkIBlWG
 AuNI6Sxsz9lPfBq+1F7abh56CWkbN/s7IOpKdgtxFbgtHjUWLyutt2Dch6FcotferJ/d7Ab5/1F
 vKGn+lPEEqtRysSflO46UHmTVPkFB63VPG+eA2DrMZ+BqQt2NpDVmiiHQSFeAtLaYWP8cGHuua+
 F17fpzj7EH8CyiIGBt6nuB9VOJmrWrN4/58ppmLTCZHfjFFBz7JOtZXi/DJf1xSe1t5SKeM7ETv
 uQ225CXsDbTFoPmjmf+pDHdeWxgz4eXMWsO1RDPUDwTduLUkchCDQXoQcDah9ZDXSzHFFNzd7cd
 HHAIr1Wb1EFD5Yly4kAchtY7c9mnzh4vqEo4GEtT4jIeGRd/Vcsgu/IQFPzk8XS5YwROOZRtUL4
 XifTntJN5dsWcjr6TpA5K9m1Jp8/bu+3CdDf0BZNYSHk3Zr0eOaAxDXuHnryPRAwD/3abYYrur/
 gtBkqOHJnvo8jZJC7wQR4QooTK5VmyN0+mvk2EXBhxFdFgcQrECF/8Y+iZ+PaLJ/Ca3ST28GLH2
 U1HrNpFedpgCFxaXJVWLjSiZxbnAA9eFj9SfYngIgpj8eDcBZDL1gLmoa/CGj6i653v+C7nY51l
 wLq0+8QIu4z6HhEH7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.137;
 envelope-from=ruansy.fnst@fujitsu.com; helo=esa11.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
Reply-to:  Shiyang Ruan <ruansy.fnst@fujitsu.com>
From:  Shiyang Ruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


在 2024/6/19 0:53, Shiyang Ruan 写道:
> 
> This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
> to check whether the current poison page has been reported (if yes,
> stop the notifier chain, won't call the following memory_failure()
> to report), into `x86_mce_decoder_chain`.  In this way, if the poison
> page already handled(recorded and reported) in (1) or (2), the other one
> won't duplicate the report.  The record could be clear when
> cxl_clear_poison() is called.

Hi guys,

I'd like to sort out the work I am currently carrying forward, to make 
sure I'm not going in the wrong direction. Please correct me if anything 
is wrong.

As is known to us, CXL spec defines POISON feature to notify its status 
when CXL memory device got a broken page.  Basically, there are two 
major paths for the notification.

1. CPU handling error
   When a process is accessing this broken page, CXL device returns data
   with POISON.  When CPU consumes the POISON, it raises a kind of error
   notification.
   To be precise, "how CPU should behave when it consumes POISON" is
   architecture dependent.  In my understanding, x86-64 raises Machine
   Check Exception(MCE) via interrupt #18 in this case.
2. CXL device reporting error
   When CXL device detects the broken page by itself and sends memory
   error signal to kernel in two optional paths.
   2.a. FW-First
     CXL device sends error via VDM to CXL Host, then CXL Host sends it
     to System Firmware via interrupt, finally kernel handles the error.
   2.b. OS-First
     CXL device directly sends error via MSI/MSI-X to kernel.

Note: Since I'm now focusing on x86_64, basically I'll describe about 
x86-64 only.

The following diagram should describe the 2 major paths and 2 optional 
sub-paths above.
```
1.  MCE (interrupt #18, while CPU consuming POISON)
     -> do_machine_check()
       -> mce_log()
         -> notify chain (x86_mce_decoder_chain)
           -> memory_failure()
2.a FW-First (optional, CXL device proactively find&report)
     -> CXL device -> Firmware
       -> OS: ACPI->APEI->GHES->CPER -> CXL driver -> trace
2.b OS-First (optional, CXL device proactively find&report)
     -> CXL device -> MSI
       -> OS: CXL driver -> trace
```

For "1. CPU handling error" path, the current code seems to work fine. 
When I used error injection feature on QEMU emulation, the code path is 
executed certainly.  Then, if the CPU certainly raises a MCE when it 
consumes the POISON, this path has no problem.

So, I'm working on making for 2.a and 2.b path, which is CXL device 
reported POISON error could be handled by kernel.  This path has two 
advantages.

- Proactively find&report memory problems

   Even if a process does not read data yet, kernel/drivers can prevent
   the process from using corrupted data proactively.  AFAIK, the current
   kernel only traces POISON error event from FW-First/OS-First path, but
   it doesn't handle them, neither notify processes who are using the
   POISON page like MCE does.  User space tools like rasdaemon reads the
   trace and log it, but as well, it doesn't handle the POISON page.  As
   a result, user has to read the error log from rasdaemon, distinguish
   whether the POISON error is from CXL memory or DDR memory, find out
   which applications are effected.  That is not an easy work and cannot
   be handled in time.  Thus, I'd like to add a feature to make the work
   done automatically and quickly. Once CXL device reports the POISON
   error (via FW-First/OS-First), kernel handles it immediately, similar
   to the flow when a MCE is triggered.  This is my first motivation.

- Architecture independent

   As the mentioned above, "1. CPU handling error" path is architecture
   dependent.  On the other hand, this route can be architecture
   independent code.  If there is a CPU which does not have similar
   feature like MCE of x86-64, my work will be essential.  (To be honest,
   I did not notice this advantage at first as mentioned later, but I
   think this is also important.)


Here is the timeline of my development of it.

Two series of patches have been sent so far:
- PATCH: cxl/core: add poison creation event handler [1]
- PATCH: cxl: avoid duplicating report from MCE & device [2]
[1] 
https://lore.kernel.org/linux-cxl/20240417075053.3273543-1-ruansy.fnst@fujitsu.com/
[2] 
https://lore.kernel.org/linux-cxl/20240618165310.877974-1-ruansy.fnst@fujitsu.com/


The 1st patch[1] added POISON error handler in "2. CXL device reporting 
error" path.

My first version was constructing a MCE data from POISON address and 
calling mce_log() to handle the POISON.  But I was told that 
constructing MCE data is architecture dependent while CXL is not.  So, 
in later version, just call memory_failure_queue() in CXL to handle the 
POISON error to avoid the arch-dependent problem.

After many discussions, a new problem was found: as Dan said[3], added 
POISON handling will cause the "duplicate report" problem:
 > So, I think all CXL poison notification events should trigger an
 > action optional memory_failure(). I expect this needs to make sure
 > that duplicates re not a problem. I.e. in the case of CPU consumption
 > of CXL poison, that causes a synchronous MF_ACTION_REQUIRED event via
 > the MCE path *and* it may trigger the device to send an error record
 > for the same page. As far as I can see, duplicate reports (MCE + CXL
 > device) are unavoidable.

[3] 
https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/


To solve this problem, I made the 2nd patch[2].  Allow me to describe 
the background again:

Since CXL device is a memory device, while CPU is consuming a poison 
page of CXL device, it always triggers a MCE (via interrupt #18) and 
calls memory_failure() to handle POISON page, no matter which-First path 
is configured.

My patch added memory_failure() in FW-First/OS-First path: if device 
finds and reports the POISON, kernel not only traces but also calls 
memory_failure() to handle it, marked as "ADD" in the figure blow.
```
1.  MCE (interrupt #18, while CPU consuming POISON)
     -> do_machine_check()
       -> mce_log()
         -> notify chain (x86_mce_decoder_chain)
           -> memory_failure() <---------------------------- EXISTS
2.a FW-First (optional, CXL device proactively find&report)
     -> CXL device -> Firmware
       -> OS: ACPI->APEI->GHES->CPER -> CXL driver -> trace
                                                  \-> memory_failure()
                                                      ^----- ADD
2.b OS-First (optional, CXL device proactively find&report)
     -> CXL device -> MSI
       -> OS: CXL driver -> trace
                        \-> memory_failure()
                            ^------------------------------- ADD
```

But in this way, the memory_failure() could be called twice or even at 
same time, as is shown in the figure above: (1.) and (2.a or 2.b), 
before the POISON page is cleared.  memory_failure() has it own mutex 
lock so it actually won't be called at same time and the later call 
could be avoided because HWPoison bit has been set.  However, assume 
such a scenario, "CXL device reports POISON error" triggers 1st call, 
user see it from log and want to clear the poison by executing `cxl 
clear-poison` command, and at the same time, a process tries to access 
this POISON page, which triggers MCE (it's the 2nd call).  Since there 
is no lock between the 2nd call with clearing poison operation, race 
condition may happen, which may cause HWPoison bit of the page in an 
unknown state.

Thus, we have to avoid the 2nd call. This patch[2] introduces a new 
notifier_block into `x86_mce_decoder_chain` and a POISON cache list, to 
stop the 2nd call of memory_failure(). It checks whether the current 
poison page has been reported (if yes, stop the notifier chain, don't 
call the following memory_failure() to report again).

Looking forward to your comments!


--
Thanks,
Ruan.

