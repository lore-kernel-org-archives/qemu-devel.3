Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4436C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 06:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u37eQ-0007Oo-E6; Fri, 11 Apr 2025 02:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u37eH-0007NW-RH; Fri, 11 Apr 2025 02:13:58 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u37eC-0008OD-7U; Fri, 11 Apr 2025 02:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744352032; x=1775888032;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=XiD4Ot+jgvnkKI7STgAM9iTJOwfmABvmI0JlTGgCnBk=;
 b=W2oPL7P6W6tfbJnQa6xeOzZux/xsCVHgNv9CzLhxRmvSddYL9/mm0NDK
 ifmHTSu9W0OMhUhP4qc6RDo1K6bRKovuJHoJRlqW3ertpZSWPJ6HpwbPu
 pmygChPrMnZW6YuZtC9pl30bH0d5x9XcpWIUSsnzrjPg/VkKN0R53PfEG
 roTD5zqbFnr93WRWqaoPq63tDSzgk5Sjoaec62Vmp54enI+n1v49yS04k
 Pa/b87qN6EmlDxZuoYcHuVsWMfsHM1TmTV8acN5VQDZuBIvR2jz2X1DDG
 X1mtnGk8Pi42ICglGbu7EGfr9EHcT+XG/ieoa1VBJrQTXCV9ilEFOiUNG g==;
X-CSE-ConnectionGUID: CZ5a5l0VTDKF9cttu20PlA==
X-CSE-MsgGUID: xQV5hNFSR1WrPf7+1TA0jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56076138"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="56076138"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2025 23:13:48 -0700
X-CSE-ConnectionGUID: TUGIGU/aTYqXKX7y6P1t4Q==
X-CSE-MsgGUID: 7Ebq+NivTnqdNeSWdeYkxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; d="scan'208";a="134219489"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 10 Apr 2025 23:13:44 -0700
Date: Fri, 11 Apr 2025 14:34:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH 1/5] qapi/qom: Introduce kvm-pmu-filter object
Message-ID: <Z/i3+l3uQ3dTjnHT@intel.com>
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-2-zhao1.liu@intel.com>
 <878qo8yu5u.fsf@pond.sub.org> <Z/iUiEXZj52CbduB@intel.com>
 <87frifxqgk.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87frifxqgk.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
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

On Fri, Apr 11, 2025 at 06:38:35AM +0200, Markus Armbruster wrote:
> Date: Fri, 11 Apr 2025 06:38:35 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH 1/5] qapi/qom: Introduce kvm-pmu-filter object
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > Hi Markus
> >
> > On Thu, Apr 10, 2025 at 04:21:01PM +0200, Markus Armbruster wrote:
> >> Date: Thu, 10 Apr 2025 16:21:01 +0200
> >> From: Markus Armbruster <armbru@redhat.com>
> >> Subject: Re: [PATCH 1/5] qapi/qom: Introduce kvm-pmu-filter object
> >> 
> >> Zhao Liu <zhao1.liu@intel.com> writes:
> >> 
> >> > Introduce the kvm-pmu-filter object and support the PMU event with raw
> >> > format.
> >> 
> >> Remind me, what does the kvm-pmu-filter object do, and why would we
> >> want to use it?
> >
> > KVM PMU filter allows user space to set PMU event whitelist / blacklist
> > for Guest. Both ARM and x86's KVMs accept a list of PMU events, and x86
> > also accpets other formats & fixed counter field.
> 
> But what does the system *do* with these event lists?

This is for security purposes, and can restrict Guest users from
accessing certain sensitive hardware information on the Host via perf or
PMU counter.

When a PMU event is blocked by KVM, Guest users can't get the
corresponding event count via perf/PMU counter.

EMM, if ¡®system¡¯ refers to the QEMU part, then QEMU is responsible
for checking the format and passing the list to KVM.

Thanks,
Zhao


