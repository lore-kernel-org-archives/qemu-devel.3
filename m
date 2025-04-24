Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFC1C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 06:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ppD-00048n-Va; Thu, 24 Apr 2025 02:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7pp4-00045C-0u; Thu, 24 Apr 2025 02:12:34 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7pp1-0003kQ-Fn; Thu, 24 Apr 2025 02:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745475151; x=1777011151;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=+wR3q3TpP6Sy48Z2TnhaEs8cnjRG2sHsyvRLGH/8NIU=;
 b=Jvsx2B2TUoEPdMrWaBZEt++ANLSc0AyS6Qw6oys8T8qssPhiwZSexeBy
 qIg5cgO2QA48QdMD1GaFC9wDmGxMgFzPeGDqpU4PKOHIaowTafzLwJn69
 24uMij+W9LtHtShzYif/GOZ381tYCiUE2ju6jSVr+n8lFjI65SuN7xFCc
 8GNPSSvwZgUVjNRNFSBv6VbcbU23A9H8vt9LxVcFaRgYVhwr6XcHqVaP/
 GcoqQrwP52glLr/5+cszhMA7Lp1EcQp1Rd7GufiXjdCjcd5c7G5ivPTrs
 uXETrRS++ptu2bTsYe2h7VZQoWwCv96tSontVSL/srmZcds1Afg4G/vYw Q==;
X-CSE-ConnectionGUID: FQr0lZ5yTPetAKJ7vE+ijg==
X-CSE-MsgGUID: 1tWrPty8QiG4Lqhw2ckUow==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="50915760"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="50915760"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 23:12:27 -0700
X-CSE-ConnectionGUID: AXBQj+KTTMui2ZOnky74AQ==
X-CSE-MsgGUID: /zjX24e/S2i0kYYfnU6H3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="137696301"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 23 Apr 2025 23:12:22 -0700
Date: Thu, 24 Apr 2025 14:33:18 +0800
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
Message-ID: <aAnbLhBXMFAxE2vT@intel.com>
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-2-zhao1.liu@intel.com>
 <878qo8yu5u.fsf@pond.sub.org> <Z/iUiEXZj52CbduB@intel.com>
 <87frifxqgk.fsf@pond.sub.org> <Z/i3+l3uQ3dTjnHT@intel.com>
 <87fri8o70b.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fri8o70b.fsf@pond.sub.org>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

Hi Markus,

> > This is for security purposes, and can restrict Guest users from
> > accessing certain sensitive hardware information on the Host via perf or
> > PMU counter.
> >
> > When a PMU event is blocked by KVM, Guest users can't get the
> > corresponding event count via perf/PMU counter.
> >
> > EMM, if ¡®system¡¯ refers to the QEMU part, then QEMU is responsible
> > for checking the format and passing the list to KVM.
> >
> > Thanks,
> > Zhao
> 
> This helped some, thanks.  To make sure I got it:
> 
> KVM can restrict the guest's access to the PMU.  This is either a
> whitelist (guest can access exactly what's on this list), or a blacklist
> (guest can access exactly what's not this list).

Yes! The "action" field controls if it's a "whitelist" (allow) or
"blacklist" (deny).

And "access" means Guest could get the event count, if "no access", then
Guest would get nothing.

For example, if we set a the whitelist ony for the event (select: 0xc4,
umask: 0) in QEMU:

pmu='{"qom-type":"kvm-pmu-filter","id":"f0","action":"allow","events":[{"format":"x86-select-umask","select":196,"umask":0}]}'

then in Guest, this command tries to get count of 2 events:

perf stat -e cpu/event=0xc4,name=branches/,cpu/event=0xc5,name=branch-misses/ sleep 1

Since another event (select: 0xc5, umask: 0) is not on whitelist, its
"access" is blocked by KVM, so user would get the result like:

 Performance counter stats for 'sleep 1':

            348709      branches
                 0      branch-misses

       1.015962921 seconds time elapsed

       0.000000000 seconds user
       0.015195000 seconds sys

The "allowed" event has the normal output, and the result of "denied"
event is zero.

> QEMU's kvm-pmu-filter object provides an interface to this KVM feature.

Yes!

> KVM takes "raw" list entries: an entry is a number, and the number's
> meaning depends on the architecture. 

Yes, and meaning also depends on format. masked-entry format has special
meaning (with a flag).

> The kvm-pmu-filter object can take such entries, and passes them to
> straight to KVM.
> 
> On x86, we commonly use two slightly higher level formats: select &
> umask, and masked.  The kvm-pmu-filter object can take entries in either
> format, and maps them to "raw".
>
> Correct?

Yes, Markus, you're right! (And sorry for late reply.)

And "raw" format as a lower level format can be used for other arches
(e.g., ARM).

Thanks,
Zhao


