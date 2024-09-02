Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037A4CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 12:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl5qh-0003W9-D4; Mon, 02 Sep 2024 08:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sl5qe-0003UQ-NG; Mon, 02 Sep 2024 08:07:56 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sl5qc-0005Lc-As; Mon, 02 Sep 2024 08:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725278874; x=1756814874;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qgr1sU7wkJHclCHETFO8vyp0MlBwWnW+iyMOkHg9Fkk=;
 b=hENLyiwlK904calFsce5LwbM7Ubc8iepw7GriLluG3Wzd4OYxv6USiBr
 zU8pCew5pINv0c08AjkXxl+AaG/VMe7OEadNXfRhZucaTCgupMS/573Fd
 XPVLxz6q4HS7GDrzulbTsodGYc7vgBvNJk4NQ9Zgmy4TofdFcUIX8wQrx
 vJ0P7n+lKl024OAH0iaqrblJPlYjZ3cj+7D9ZlbtJtNDAGuph9SkP8o15
 HTGYMub/6SB0bLefi6LvCqpgZuMnoNNaMUrSWzXrFTQvaeKeYJX/9DrcX
 zQKQx9KWy34RfTuJbQTMC9rGoDk8mqN6Bz0id/nMgIb9l1WyzK7+9PWLC Q==;
X-CSE-ConnectionGUID: 07UTZtAOTzeFJ7hroD6INA==
X-CSE-MsgGUID: h/cuJ6LbRsWbYAjJBdfAGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="41333119"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; d="scan'208";a="41333119"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2024 05:07:49 -0700
X-CSE-ConnectionGUID: XhA4ac0RSvugfTevNzWVkQ==
X-CSE-MsgGUID: O8z3vyWmQb2M+INS6gcYvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; d="scan'208";a="95405433"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 02 Sep 2024 05:07:44 -0700
Date: Mon, 2 Sep 2024 20:23:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, zhenyu.z.wang@intel.com,
 dapeng1.mi@linux.intel.com, yongwei.ma@intel.com, armbru@redhat.com,
 farman@linux.ibm.com, peter.maydell@linaro.org, mst@redhat.com,
 anisinha@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, linuxarm@huwei.com,
 shameerali.kolothum.thodi@huawei.com, Jonathan.Cameron@huawei.com,
 jiangkunkun@huawei.com, zhao1.liu@intel.com
Subject: Re: [RFC PATCH 0/2] Specifying cache topology on ARM
Message-ID: <ZtWuT4W5kKEtodyo@intel.com>
References: <20240823125446.721-1-alireza.sanaee@huawei.com>
 <ZtL9u9kQcx0GtEKq@intel.com> <20240902112519.00005b67@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902112519.00005b67@huawei.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Sep 02, 2024 at 11:25:19AM +0100, Alireza Sanaee wrote:
> 
> Hi Zhao,
> 
> Yes, please keep me CCed. 
> 
> One thing that I noticed, sometimes, since you were going down the
> Intel path, some variables couldn't be NULL. But when I was gonna go
> down to ARM path, I faced some scenarios where I ended up with
> some uninit vars which is still OK but could have been avoided.

Ah I didn't get your point very clearly. Could you please figure out
those places on my patches? Then I can fix them in my next version. :)

Thanks,
Zhao

> Looking forward to the next revision.
> 
> Alireza

