Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0757C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 07:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqSC0-0007b8-EE; Fri, 07 Mar 2025 02:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tqSBq-0007ac-2B
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:32:14 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tqSBo-00043L-3H
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 02:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741332732; x=1772868732;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0n9mnucRi4sYNV486/6Gw1e7LpF2GnO1kkWy7c3sKFk=;
 b=TXqwYR8oAB0QIDLwXMeqbcPSCWg9PWkkps/iNCFTWy7ZRghc+H4f0sUg
 UYPdEv+mPeGj8ljVaNZhGJtXAQT+YrF0a6AYVHY9p/WtbISaSYsJLZrKo
 cO3rL04jS+CjIcoctHbrxECf0wmBcAX8/pnSZuaBBQ4P38TCozVaNuuuv
 CV0PqgsvgM3/F4kH/1YhgAYiVh5j/+vpvgMZmDYyvQ8FGzzK64EBskgeR
 ECsFETVZHDh3GxbpNbSiOg+moNFzPtqkvh1WkEeUVpVPejsgce/Wiem4b
 RSC/PTYvLiFvprULO5vYls10SlL4JcMaN0T4o+jr3Q/uR6qfpbkCloH4G g==;
X-CSE-ConnectionGUID: 6BQ7NITnRRyy4EOr9iXA2g==
X-CSE-MsgGUID: vkl8Rh0kR3ONgiYA4da/6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="59931186"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; d="scan'208";a="59931186"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2025 23:32:09 -0800
X-CSE-ConnectionGUID: Z1+BL8nvTUqYhVfuIt1Egg==
X-CSE-MsgGUID: eTZR0ffEQceqcW7KL2AxEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; d="scan'208";a="142483946"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 06 Mar 2025 23:32:05 -0800
Date: Fri, 7 Mar 2025 15:52:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: dongli.zhang@oracle.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com
Subject: Re: [PATCH v2 03/10] [DO NOT MERGE] kvm: Introduce
 kvm_arch_pre_create_vcpu()
Message-ID: <Z8qlrjciHEbdnqaA@intel.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-4-dongli.zhang@oracle.com>
 <Z8hjy/8OBTXEA1kp@intel.com>
 <acef41fc-9eb1-4df7-b7b6-61995a76fcc4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acef41fc-9eb1-4df7-b7b6-61995a76fcc4@oracle.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
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

> I didn't know if I would need to wait until this patch is merged into
> mainline QEMU. That's why I didn't add my signed-off.

No problem if Xiaoyao is okay with it (copyright of patches need to
honor the original author & signed-off). IMO, if your series is accepted
first, it also helps to reduce the size of the TDX series, and it helps
the subsequent PMU development (like mediated PMU). Conversely, it's
also not a big deal; you can simply rebase and remove this patch at that
time.

Even I'm thinking that my KVM PMU filter should perhaps base on your work.

> I will add in v3 and remove "DO NOT MERGE" if the patch isn't in QEMU when
> I am sending out v3.

Okay.

Thanks,
Zhao


