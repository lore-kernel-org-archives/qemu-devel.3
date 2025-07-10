Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319C3C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsGC-0008JN-4x; Thu, 10 Jul 2025 10:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uZs9L-000181-06
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:21:23 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uZs9H-0007dY-Oe
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752157280; x=1783693280;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=x+0iSIOhd3iStOZkuqLK862xie1zgpabBOtLsr+BmJk=;
 b=SBzyyDfc+bchKQKJtr6xIg7bXzkRcNiwDFpXeHJsfuhnED3hbDlvrWhv
 1Mr+MKUlrbHMJyEMi8GguJywPXzPhKVjyfQpd+UQZzjsnXGba+C85N+dd
 TzZyiTquCHGr9qVs4Yxcz8upuR/wzoEJcHiJoZzH9A+Bx+s9baMk/RLu2
 REiGdcCf0eM/L9Z9a+2vhE26jGCcLL8uyLe5gBdhzzXRJWrrgGPZ9wbSo
 eT7An+VjKYUMvxh0VlfUeEiwwUwtGF1i+JgrxjKq8NqGE3CbjGgkehlye
 jkOKPPpp6vzwgfMiYfufeY3ZapM8r5R91mnrhuINXw31dXZBOgmW2OSyB Q==;
X-CSE-ConnectionGUID: Miewe4hJSYCF6TYDL9jvUw==
X-CSE-MsgGUID: RYA9WswkRvK4DA0x8b3Q5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="58207292"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="58207292"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 07:21:17 -0700
X-CSE-ConnectionGUID: EiXQw64mQ2WKLHrkKExtPA==
X-CSE-MsgGUID: 8hq7oNB7STiwc/teT1Lsvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="160655571"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 07:21:16 -0700
Message-ID: <42650134-1e4f-4d10-afb3-46f98fa0a57a@intel.com>
Date: Thu, 10 Jul 2025 22:21:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/tdx: Fix the report of gpa in QAPI
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 chao.p.peng@intel.com
References: <20250710035538.303136-1-zhenzhong.duan@intel.com>
 <3b6c0344-0694-4a56-99dd-c7d437e43428@intel.com>
 <efbbe5f4-6f0c-4470-9968-c389cb206088@intel.com>
 <aG_KLeTIIblKbrY9@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aG_KLeTIIblKbrY9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 7/10/2025 10:11 PM, Daniel P. Berrangé wrote:
> On Thu, Jul 10, 2025 at 10:06:10PM +0800, Xiaoyao Li wrote:
>> On 7/10/2025 7:40 PM, Xiaoyao Li wrote:
>>> On 7/10/2025 11:55 AM, Zhenzhong Duan wrote:
>>>> Gpa is defined in QAPI but never reported to monitor because has_gpa is
>>>> never set to ture.
>>>>
>>>> Fix it by setting has_gpa to ture when TDX_REPORT_FATAL_ERROR_GPA_VALID
>>>> is set in error_code.
>>>
>>> Hi Zhenzhong,
>>>
>>> I would like to understand what the problem is without panic_info-
>>>> u.tdx.has_gpa being set?
>>
>> Never mind, I figure it out.
>>
>> qapi_event_send_guest_panicked() in qemu_system_guest_panicked will send the
>> event and data. Libvirt tries to parse the data, but find the .has_data
>> field is not set correctly.
> 
> Close, but not quite.
> 
> The "has_" fields are only present in the QEMU internal data structures,
> never on the wire in the JSON messages that libvirt receives.
> 
> The problem is with QEMU's struct -> JSON serialization - if the 'has_gpa'
> field is not set to 'true', then QEMU will *never* emit the 'gpa' field
> in the JSON it sends to the client app.
> 
> So what libvirt receives is this:
> 
>   {"timestamp": {"seconds": 1752156518, "microseconds": 809325},
>    "event": "GUEST_PANICKED",
>    "data": {"action": "pause", "info": {
>        "error-code": 0,
>        "message": "TD misconfiguration: SEPT #VE has to be disabled",
>        "type": "tdx"}}}
> 
> which has no 'gpa' present.

Thanks for the explanation! It's much clear to me now!

>> My original patch used (gpa == -1) as the indicator for whether gpa is
>> valid, this needs to be cleaned up. I will send the cleanup patch.
> 
> The value you assign to 'gpa' doesn't matter when 'has_gpa' is false,
> as it'll never get into the JSON event, so having it be '-1' is not
> significantly different from leaving it on 0.

I meant cleanup the QEMU internal logic in qemu_system_guest_panicked()

--- a/system/runstate.c
+++ b/system/runstate.c
@@ -690,7 +690,7 @@ void 
qemu_system_guest_panicked(GuestPanicInformation *info)
                            " error code: 0x%" PRIx32 " error 
message:\"%s\"\n",
                            info->u.tdx.error_code, message);
              g_free(message);
-            if (info->u.tdx.gpa != -1ull) {
+            if (info->u.tdx.has_gpa) {
                  qemu_log_mask(LOG_GUEST_ERROR, "Additional error 
information "
                                "can be found at gpa page: 0x%" PRIx64 "\n",
                                info->u.tdx.gpa);


> With regards,
> Daniel


