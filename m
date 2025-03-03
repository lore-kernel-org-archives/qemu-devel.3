Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C4FC19F32
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 02:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tovg0-0002Tw-0h; Sun, 02 Mar 2025 21:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tovfy-0002TU-1h
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 21:37:02 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tovfv-0006mT-9i
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 21:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740969419; x=1772505419;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=yXnkXkENrzb8r1gN4wtDU6veXvrITTCGm0kyhoR+UK4=;
 b=kHO65iWCoYRsKCLgkvm+v9O8DSh0FknUSuXmffjYiWfPQDnS2myi6EMh
 ZbVmEidwl97LjliSQLrGfkqY4Jllm/iuR0szL9R25mxgRIPwGd1GB1oT/
 FyRUpES5QZP9V6T40X/6ncbSb9pOPwxh1m1nyf+s2J716qADv4kz+2DiT
 LlO1UKiH4SxCUBDDrNyUCTQ5sb0zL9AGnOGRrd2iVzw7QobB/Wa87l+sk
 OrXJ4mdHzOCzxpOPPEXeSCtqNp11kOKaEWjwMDuU50J/Lu9PaivsX3Ri7
 iKwbHQgN32iXWjWzE7rq/1vpLbU8K0qalNSAsRMyiDRp0zVmJd1T9Psip g==;
X-CSE-ConnectionGUID: D/mar+GlRgeDx4mUNd/mrA==
X-CSE-MsgGUID: gBXo5zT5QqGnwz2buBt3zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="59375814"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; d="scan'208";a="59375814"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2025 18:36:56 -0800
X-CSE-ConnectionGUID: RMIqGMMkQy6G/jfM1Jvlog==
X-CSE-MsgGUID: ulreb2OpRz+uPvfHaiqJLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; d="scan'208";a="122468717"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2025 18:36:52 -0800
Message-ID: <d686aa93-3207-4129-bf70-08406e2d6df9@intel.com>
Date: Mon, 3 Mar 2025 10:36:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 28/52] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with
 GuestPanic facility
To: Francesco Lavra <francescolavra.fl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-29-xiaoyao.li@intel.com>
 <c5418f363998a7416bf3667de7a9f3536634d3ad.camel@gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <c5418f363998a7416bf3667de7a9f3536634d3ad.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/28/2025 12:30 AM, Francesco Lavra wrote:
> On Fri, 2025-01-24 at 08:20 -0500, Xiaoyao Li wrote:
>> diff --git a/system/runstate.c b/system/runstate.c
>> index 272801d30769..c4244c8915c6 100644
>> --- a/system/runstate.c
>> +++ b/system/runstate.c
>> @@ -565,6 +565,60 @@ static void qemu_system_wakeup(void)
>>       }
>>   }
>>   
>> +static char *tdx_parse_panic_message(char *message)
>> +{
>> +    bool printable = false;
>> +    char *buf = NULL;
>> +    int len = 0, i;
>> +
>> +    /*
>> +     * Although message is defined as a json string, we shouldn't
>> +     * unconditionally treat it as is because the guest generated it
>> and
>> +     * it's not necessarily trustable.
>> +     */
>> +    if (message) {
>> +        /* The caller guarantees the NULL-terminated string. */
>> +        len = strlen(message);
>> +
>> +        printable = len > 0;
>> +        for (i = 0; i < len; i++) {
>> +            if (!(0x20 <= message[i] && message[i] <= 0x7e)) {
>> +                printable = false;
>> +                break;
>> +            }
>> +        }
>> +    }
>> +
>> +    if (len == 0) {
>> +        buf = g_malloc(1);
>> +        buf[0] = '\0';
>> +    } else {
>> +        if (!printable) {
>> +            /* 3 = length of "%02x " */
>> +            buf = g_malloc(len * 3);
>> +            for (i = 0; i < len; i++) {
>> +                if (message[i] == '\0') {
>> +                    break;
>> +                } else {
>> +                    sprintf(buf + 3 * i, "%02x ", message[i]);
>> +                }
>> +            }
>> +            if (i > 0) {
>> +                /* replace the last ' '(space) to NULL */
>> +                buf[i * 3 - 1] = '\0';
>> +            } else {
>> +                buf[0] = '\0';
>> +            }
>> +
>> +        } else {
>> +            buf = g_malloc(len);
>> +            memcpy(buf, message, len);
> 
> This fails to null-terminate the message string in buf.
> 

will just use g_strdup(message);

