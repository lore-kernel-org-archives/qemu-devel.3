Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A8ECCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 05:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAiZA-0008I9-Eu; Mon, 20 Oct 2025 01:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vAiZ8-0008Hv-1i
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 01:36:18 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vAiZ4-0007Fm-PD
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 01:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760938575; x=1792474575;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=esGWuBbOZ2/fvxDU0/+W6HKp6MW1NADw1JIbPWWRgi8=;
 b=ihgpBQr6sbzJYi8ZFitRuwUEU1rvhIWY25cJpIBIS2ejZesnJHvw/L7T
 mt24wT0Xaj181u8SysYwgo4mKPD5Zk5v8+tYjMbi78jAJR4e6uxlNmm1T
 PUy4Xmit5jXX+RcDlqVoLnKvZiyTHOwHtgqCWTLDvmXJ2oqA2Eg8WSKRT
 k8GpNHPDyoNqEsT1y2db4zakSVkHLKevCXgNupzo+y3VlEuQPp9RtkhmS
 ZCIaNkDYsCJjUIhprkj7WK34EJVK1K3M52lMgbk/4IBpEHKiqICOoOSGz
 vvD2qSGzSxEGJttIYOLvidJIlIyhudN60PMvtR+2lPHKi2C28HpnC5Rms g==;
X-CSE-ConnectionGUID: d/ZU4zRhROCsinStSDmdWg==
X-CSE-MsgGUID: rRvxnDC2SvKKJ5iKwnH7nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="74397851"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="74397851"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2025 22:36:09 -0700
X-CSE-ConnectionGUID: l7Pu6WazQQKVaPyCqSw8ow==
X-CSE-MsgGUID: 1NHmU/eSRX+xw5zIBox7qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="183198630"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 19 Oct 2025 22:36:07 -0700
Date: Mon, 20 Oct 2025 13:58:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=C3?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] qapi/machine: Fix missing @modules in topology ordering
Message-ID: <aPXPdku0QmO+KAjb@intel.com>
References: <20251013074511.2030073-1-zhao1.liu@intel.com>
 <87jz0wk7m5.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jz0wk7m5.fsf@pond.sub.org>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Oct 15, 2025 at 08:21:38AM +0200, Markus Armbruster wrote:
> Date: Wed, 15 Oct 2025 08:21:38 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH] qapi/machine: Fix missing @modules in topology ordering
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > The module level is between core and cluster levels. Fix the QAPI
> > documentation to add the module level in topology ordering.
> >
> > Reported-by: Markus Armbruster <armbru@redhat.com>
> > Fixes: 8ec0a4634798 ("hw/core/machine: Support modules in -smp")
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >  qapi/machine.json | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 038eab281c78..5e268479e546 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -1624,7 +1624,7 @@
> >  # containers.
> >  #
> >  # The ordering from highest/coarsest to lowest/finest is: @drawers,
> > -# @books, @sockets, @dies, @clusters, @cores, @threads.
> > +# @books, @sockets, @dies, @clusters, @modules, @cores, @threads.
> >  #
> >  # Different architectures support different subsets of topology
> >  # containers.
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>

Thanks!

> However, there are more mentions of @drawers etc. in comments and
> documentation elsewhere.  Quick grep for "drawers" there appended.
> Please double-check for missing mentions of modules.
> 
> 
> docs/about/deprecated.rst:configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is

This case should be cleaned up since I rememberred the realted change is
reverted. I will check in details and submit a patch if necessary.

> docs/devel/s390-cpu-topology.rst:    -smp 1,drawers=3,books=3,sockets=2,cores=2,maxcpus=36 \
> docs/system/s390x/cpu-topology.rst:topology containers: drawers, books and sockets. They define a
> docs/system/s390x/cpu-topology.rst:If none of the containers attributes (drawers, books, sockets) are
> hw/s390x/cpu-topology.c: * (0, 0, 0) up to the last (smp->drawers, smp->books, smp->sockets).

s390x doesn't support module level, so its doc is fine.

> include/hw/boards.h: * @drawers_supported - whether drawers are supported by the machine
> include/hw/boards.h: * @drawers: the number of drawers on the machine

general machine codes has considerred module level.

> tests/functional/s390x/test_topology.py:    the cores, sockets, books and drawers and 2 modifiers attributes,

s390x doesn't support module level.

> tests/unit/test-smp-parse.c: *  -drawers/books/sockets/cores/threads
> tests/unit/test-smp-parse.c: *  -drawers/books/sockets/dies/clusters/modules/cores/threads
> tests/unit/test-smp-parse.c:         *   -smp 8,drawers=1,books=1,sockets=2,dies=1,clusters=1,modules=1,\
> tests/unit/test-smp-parse.c:        /* config: -smp 2,drawers=2 */
> tests/unit/test-smp-parse.c:        /* config: -smp 16,drawers=2,sockets=2,cores=4,threads=2,maxcpus=16 */
> tests/unit/test-smp-parse.c:        /* config: -smp 34,drawers=2,sockets=2,cores=4,threads=2,maxcpus=32 */
> tests/unit/test-smp-parse.c:         * config: -smp 200,drawers=3,books=5,sockets=2,cores=4,\
> tests/unit/test-smp-parse.c:         * config: -smp 242,drawers=3,books=5,sockets=2,cores=4,\
> tests/unit/test-smp-parse.c:         * config: -smp 200,drawers=3,books=5,sockets=2,dies=4,\
> tests/unit/test-smp-parse.c:         * config: -smp 2881,drawers=3,books=5,sockets=2,dies=4,\
> tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=3,books=5,sockets=2,dies=4,\
> tests/unit/test-smp-parse.c:         * config: -smp 0,drawers=1,books=1,sockets=1,dies=1,\
> tests/unit/test-smp-parse.c:         * Test "drawers=0".
> tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=0,books=1,sockets=1,dies=1,\
> tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=1,books=0,sockets=1,dies=1,\
> tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=1,books=1,sockets=0,dies=1,\
> tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=1,books=1,sockets=1,dies=0,\
> tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
> tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
> tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
> tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
> tests/unit/test-smp-parse.c:         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
> tests/unit/test-smp-parse.c:        /* when drawers parameter is omitted, it will be set as 1 */
> tests/unit/test-smp-parse.c:        /* when drawers parameter is specified */
> tests/unit/test-smp-parse.c:         * when drawers and books parameters are omitted, they will
> tests/unit/test-smp-parse.c:        /* when drawers and books parameters are both specified */
> tests/unit/test-smp-parse.c:         * when drawers, books, dies, clusters and modules parameters are
> tests/unit/test-smp-parse.c:         * when drawers, books, dies, clusters and modules parameters

test-smp-parse has coverred module case, so it's fine too. But test-smp-parse
doesn't cover smp-cache. I'll consider to add the new test case.

Thanks very much!

Regards,
Zhao



