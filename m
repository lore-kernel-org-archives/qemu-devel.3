Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7851C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 18:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC1O0-0004qh-HF; Tue, 28 May 2024 14:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sC1Nu-0004gy-Hk; Tue, 28 May 2024 14:17:18 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sC1Ns-0001gN-GE; Tue, 28 May 2024 14:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716920237; x=1748456237;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ZOwIjjXPtrApLzL7oZpHcOhTAraK3uir0bWfE7zfeEY=;
 b=Gtq0HTkMFNLLEMVi5242mlmiDNVJtTQu7EC0uMUGcS8H+uW0JHfh79ki
 V+O/dn2jWXdioJLw++n/hPbn+4qWfR5GRBNjdfrRnowSPgDIQpDIDuYSp
 iqV/eciky2VYM8FRI3QakPxMAIF3fHIupnxhpXcXVzM3k8eLzSEt7poOg
 S5gjUycXqm0jlmvuIsB/O1X9oRgUCwfQXTQ3TEYw4vZzv90cZOJRRGP+8
 33DPCejjqOBOGo7YxtLSN65m0OgqaWLEbmANTq98UPw2ScICsOg3BWX3L
 476n2a+t/xhz3lgcSePkbYmuDeE3CycdN7gDFKcruNMb20I2j1tjOy/5G A==;
X-CSE-ConnectionGUID: 9gDGe8mbR1qGF/3lzHfe3w==
X-CSE-MsgGUID: 61cUCNbDQduD7gEZgsNvKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30810548"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; d="scan'208";a="30810548"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 11:17:13 -0700
X-CSE-ConnectionGUID: GJbmfcQlQBukV0di5FvkmQ==
X-CSE-MsgGUID: 4ui2EA6PROKl5OmcESTiCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; d="scan'208";a="39578098"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.51]) ([10.24.10.51])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 11:17:12 -0700
Message-ID: <29944dba-7005-496d-81ff-1cbc77c67f15@intel.com>
Date: Tue, 28 May 2024 11:16:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/3] improve -overcommit cpu-pm=on|off
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 thuth@redhat.com, cfontana@suse.de, xiaoyao.li@intel.com,
 qemu-trivial@nongnu.org
References: <20240524200017.150339-1-zide.chen@intel.com>
 <20240528112327.634e95a6@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20240528112327.634e95a6@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 5/28/2024 2:23 AM, Igor Mammedov wrote:
> On Fri, 24 May 2024 13:00:14 -0700
> Zide Chen <zide.chen@intel.com> wrote:
> 
>> Currently, if running "-overcommit cpu-pm=on" on hosts that don't
>> have MWAIT support, the MWAIT/MONITOR feature is advertised to the
>> guest and executing MWAIT/MONITOR on the guest triggers #UD.
> 
> this is missing proper description how do you trigger issue
> with reproducer and detailed description why guest sees MWAIT
> when it's not supported by host.

If "overcommit cpu-pm=on" and "-cpu hpst" are present, as shown in the
following, CPUID_EXT_MONITOR is set after x86_cpu_filter_features(), so
that it doesn't have a chance to check MWAIT against host features and
will be advertised to the guest regardless of whether it's supported by
the host or not.

x86_cpu_realizefn()
  x86_cpu_filter_features()
  cpu_exec_realizefn()
    kvm_cpu_realizefn
      host_cpu_realizefn
        host_cpu_enable_cpu_pm
          env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;


If it's not supported by the host, executing MONITOR or MWAIT
instructions from the guest triggers #UD, no matter MWAIT_EXITING
control is set or not.

