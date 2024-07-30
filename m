Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE437C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYiv6-0005Lj-5k; Tue, 30 Jul 2024 05:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYiv3-0005Bs-1O; Tue, 30 Jul 2024 05:13:21 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sYiv0-0003pX-Ga; Tue, 30 Jul 2024 05:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722330798; x=1753866798;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=OJN+ESOf3j7WgRm7tp+5EaN6VLIEhB0GeZBgm8RyWZI=;
 b=VU1ZvamSbhpUJ1ZL3Nf2LSKn9Eh+h959uoXWtI4cN1QGZTDf1aRRMpEA
 lIqXL/l0tgVj9mEktMYNn5wZeqnRB/jt/yGhEDBISg16KbqUXMhA8FfVa
 qooBXwxRqNrWkm0ugk3Vtmbhce70X6XtsPiIgfN8kMN5iOZQqfjqRY94O
 FZT3FfZQYB51JQqCXNPcl/sJZGrCRoDDABio3FIr7zf9vAb7hCL/9DlIA
 da7aA/qFKC4R1pvhvoARbidnZRnTKr/BWQ4t2ATIajyCYz0BGMn8HVxtA
 80ln5jaS2TE5wLUKC0h9Wg2fWK8rYn1KGFtthpRzqSwKj8qUlf/HyJuFk g==;
X-CSE-ConnectionGUID: IflEyHHwSP6OLEsRhXPQKQ==
X-CSE-MsgGUID: Yg/3g3FESF2JMjjjsYRa1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31542665"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; d="scan'208";a="31542665"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2024 02:13:14 -0700
X-CSE-ConnectionGUID: gswTXqQTRYekTBKloxnqDw==
X-CSE-MsgGUID: gyJq+ddtRmOByRaoPYZs5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; d="scan'208";a="77507899"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 30 Jul 2024 02:13:04 -0700
Date: Tue, 30 Jul 2024 17:28:50 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com,
 andrew@codeconstruct.com.au, andrew@daynix.com,
 arei.gonglei@huawei.com, berrange@redhat.com, berto@igalia.com,
 borntraeger@linux.ibm.com, clg@kaod.org, david@redhat.com,
 den@openvz.org, eblake@redhat.com, eduardo@habkost.net,
 farman@linux.ibm.com, farosas@suse.de, hreitz@redhat.com,
 idryomov@gmail.com, iii@linux.ibm.com, jamin_lin@aspeedtech.com,
 jasowang@redhat.com, joel@jms.id.au, jsnow@redhat.com,
 kwolf@redhat.com, leetroy@gmail.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, michael.roth@amd.com, mst@redhat.com,
 mtosatti@redhat.com, nsg@linux.ibm.com, pasic@linux.ibm.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 philmd@linaro.org, pizhenwei@bytedance.com, pl@dlhnet.de,
 richard.henderson@linaro.org, stefanha@redhat.com,
 steven_lee@aspeedtech.com, thuth@redhat.com,
 vsementsov@yandex-team.ru, wangyanan55@huawei.com,
 yuri.benditovich@daynix.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH 07/18] qapi/machine: Drop temporary 'prefix'
Message-ID: <ZqiyUjihMSD0ce4b@intel.com>
References: <20240730081032.1246748-1-armbru@redhat.com>
 <20240730081032.1246748-8-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730081032.1246748-8-armbru@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Tue, Jul 30, 2024 at 10:10:21AM +0200, Markus Armbruster wrote:
> Date: Tue, 30 Jul 2024 10:10:21 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH 07/18] qapi/machine: Drop temporary 'prefix'
> 
> Recent commit "qapi: Smarter camel_to_upper() to reduce need for
> 'prefix'" added a temporary 'prefix' to delay changing the generated
> code.
> 
> Revert it.  This improves HmatLBDataType's generated enumeration
> constant prefix from HMATLB_DATA_TYPE to HMAT_LB_DATA_TYPE.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/machine.json            | 1 -
>  hw/core/numa.c               | 4 ++--
>  hw/pci-bridge/cxl_upstream.c | 4 ++--
>  3 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


