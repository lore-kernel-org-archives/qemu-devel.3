Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B4BE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 14:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKf7X-0000WZ-OG; Mon, 09 Dec 2024 09:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKf7V-0000WF-1h
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 09:52:21 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKf7S-0000CS-8Y
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 09:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733755938; x=1765291938;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=E9pXy7EBNZ3g4C/MtPNp0Cd39GKSq38KtSuMgDZQWL0=;
 b=HsimUFUTS/oe+NiXYsrxSqy6lhSCESbIZhVJvjzCZnmV9ixi0WomCiJ9
 zMh/Uw9++nZtR4e+NhuY1dBUug1EOyMfkB68iQO4pqop0m+15dvUzWCM+
 /eH0vdzp+KsNxsqkfNni5Sz3VjFDqUu4O4ZDgdpQp9g4j5SGXOYbGEfEg
 vUQUnOOw5vf8JO9RI2TjflTB8Vhn08U2sHcbgUm5FDWaBMoMmbxGKiJb6
 dOLTr8kb+kqeDUYiMsB0I9fPwnMwgRVEm4bWzdDQBQ9lb1SBddDsXvsjI
 3FA3694f1iVmbAeJjP8DrveAMTDTAiGtvdCgjOIWMc9r3PewMe4etQrGq g==;
X-CSE-ConnectionGUID: mXz/xj9ASTeAUTWTjTbVXQ==
X-CSE-MsgGUID: oqFzaortSKms5bIdLvpigg==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33972713"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; d="scan'208";a="33972713"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2024 06:52:15 -0800
X-CSE-ConnectionGUID: KjYDs8rdSjaV74dAT5+8OQ==
X-CSE-MsgGUID: HVbSeieARqyBOVLP0OtUMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; d="scan'208";a="125933160"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 09 Dec 2024 06:52:13 -0800
Date: Mon, 9 Dec 2024 23:10:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, imammedo@redhat.com,
 qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] hw/i386/cpu: remove default_cpu_version and simplify
Message-ID: <Z1cIY357gcsE1IgJ@intel.com>
References: <20241208064810.893451-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208064810.893451-1-anisinha@redhat.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

+Daniel,

On Sun, Dec 08, 2024 at 12:18:10PM +0530, Ani Sinha wrote:
> Date: Sun,  8 Dec 2024 12:18:10 +0530
> From: Ani Sinha <anisinha@redhat.com>
> Subject: [PATCH] hw/i386/cpu: remove default_cpu_version and simplify
> X-Mailer: git-send-email 2.45.2
> 
> commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be aliases")
> introduced 'default_cpu_version' for PCMachineClass. This created three
> categories of CPU models:
>  - Most unversioned CPU models would use version 1 by default.
>  - For machines 4.0.1 and older that do not support cpu model aliases, a
>    special default_cpu_version value of CPU_VERSION_LEGACY is used.
>  - It was thought that future machines would use the latest value of cpu
>    versions corresponding to default_cpu_version value of
>    CPU_VERSION_LATEST [1].
> 
> Unfortunately, all pc machines still use the default cpu version of 1 for
> unversioned cpu models. Only microvms use CPU_VERSION_LATEST.

Hi Ani,

So could we use CPU_VERSION_LATEST for other machines now?

Mapping unversioned cpu models to the latest version sounds like more
user friendly.

Regards,
Zhao

> This change cleans up the complicated logic around default_cpu_version
> including getting rid of default_cpu_version property itself. A couple of new
> flags are introduced, one for the legacy model for machines 4.0.1 and older
> and other for microvms. For older machines, a new pc machine property is
> introduced that separates pc machine versions 4.0.1 and older from the newer
> machines. 4.0.1 and older machines are scheduled to be deleted towards
> end of 2025 since they would be 6 years old by then. At that time, we can
> remove all logic around legacy cpus. Microvms are the only machines that
> continue to use the latest cpu version. If this changes later, we can
> remove all logic around x86_cpu_model_last_version(). Default cpu version
> for unversioned cpu models is hardcoded to the value 1 and applies
> unconditionally for all pc machine types of version 4.1 and above.
> 
> This change also removes all complications around CPU_VERSION_AUTO
> including removal of the value itself.
> 
> 1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")
> 
> CC: imammedo@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
 

