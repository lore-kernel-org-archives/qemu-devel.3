Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D8DC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 15:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZBJ7-0005Rf-Ka; Wed, 31 Jul 2024 11:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sZBJ5-0005QQ-9J
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:32:03 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sZBJ3-0001jS-EA
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722439922; x=1753975922;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=g7cS5tJmASey1cfuwhFUUpKl2NIrHlrYvQ/kQ2/CIiw=;
 b=eYdUsP+5C0DE1y7dVs/8+zG6sEqHz+JFi8nyaV9mQBOi4+PzVBzTqGii
 q7qqNHGPw0GMV9lGzNH3+3oKsQrnEeddg8t4LXdjszOLFM7WP8o6jFpmk
 n7hG0/QqEW/lrJM+8lvj0yNBybm56+6a0Cm0dw88+XP8CgXJvN6VWvGn7
 NIxC0gOhhYbHZuMQFyzUaaN6VAF7+Zv/yII/Vi956aTmcijVqiwcNOkh9
 FrV3tqDcepnQNlAr8EhybWifffBhW2o6ENPwFZeQ/4S+Plv6jBNMIa4yi
 RO2sjDEbb1qN5BW7D4t9pxvB8vAl1mAxJ5T4KOsJorn4UI8e0GYDXOTEe w==;
X-CSE-ConnectionGUID: NtvvAcEkSLiyWyNsgRVOeg==
X-CSE-MsgGUID: rdcpjE1xRWKaYBcTWqpgaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="42861086"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; d="scan'208";a="42861086"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2024 08:31:59 -0700
X-CSE-ConnectionGUID: h06EDND9TpyZ0JbKdiAwoQ==
X-CSE-MsgGUID: Kl2QsVsrRCebwYc7O9Nw4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; d="scan'208";a="59777678"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.26])
 ([10.124.240.26])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2024 08:31:56 -0700
Message-ID: <bda03736-ade0-46a9-977f-1ae368374555@intel.com>
Date: Wed, 31 Jul 2024 23:31:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
To: John Levon <john.levon@nutanix.com>
Cc: Manish <manish.mishra@nutanix.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, berrange@redhat.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, bob.ball@nutanix.com, prerna.saxena@nutanix.com
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com>
 <6e65dbb2-461e-44f4-842c-249c7b333885@intel.com> <Zqn6mNuCH4/HJoO/@lent>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Zqn6mNuCH4/HJoO/@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/31/2024 4:49 PM, John Levon wrote:
> On Wed, Jul 31, 2024 at 03:02:15PM +0800, Xiaoyao Li wrote:
> 
>>> Windows does not expect 0x1f to be present for any CPU model. But if it
>>> is exposed to the guest, it expects non-zero values.
>>
>> Please fix Windows!
> 
> A ticket has been filed with MSFT, we are aware this is a guest bug.
> 
> But that doesn't really help anybody trying to use Windows right now.

For existing buggy Windows, we can still introduce "cpuid-0x1f-enforce" 
but not make it default on.

People want to boot the buggy Windows needs to opt-in it themselves via 
"-cpu xxx,cpuid-0x1f-enforce=on". This way, we don't have live migration 
issue and it doesn't affect anything.

> regards
> john


