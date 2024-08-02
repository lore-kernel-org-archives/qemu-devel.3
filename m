Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29522C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 09:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZonk-0005tZ-VE; Fri, 02 Aug 2024 05:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1sZone-0005rG-Nq
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 05:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1sZonc-0001Gk-BI
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 05:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722591731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SR6COq4r8Q0id3Rqkqe8/eU3zLpLWDQO48baLmfUlac=;
 b=PjDGJPikW0O9KR4oT1chrjqDx8rSsee8mSQHMIKyn8p+ff3Bj2hgNDdMqgBFlrrzChrs4/
 +DvR+XmrOFEeZMD4L1YgyOvsdpxbe+gmKtgPl90dNhvLzshaDUEHEiQOAMVjyOVmFyQ5PD
 Pf5sjBeisApSOYG0W5ckimcDR1OZafs=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-1mixpjcQMG-hOPS-vtP_XA-1; Fri, 02 Aug 2024 05:42:09 -0400
X-MC-Unique: 1mixpjcQMG-hOPS-vtP_XA-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5d5ba9e5d8bso1120560eaf.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 02:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722591728; x=1723196528;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SR6COq4r8Q0id3Rqkqe8/eU3zLpLWDQO48baLmfUlac=;
 b=sCVhTARHzdEu2G9efklYFVSXTsAQpQJRtr06ZMvqZwsjzEpWHVHZ/PT19GrK3ERgW8
 L/1do5J3vfWiYVjNV6Zr8VpSTaaIuZRo/GsgAaBKZr+e77MPdO7bieQYNAI5EIe3KfHO
 a6FNqFTELwJhkHkBvPjkKWbNb7ESBl5bX5ABEpnmyVp5aJO+1yyEFfu46DzVSVOsAhNp
 HkR7juzD8L0UfxM4yTZJZwh3/Y00pTr1/ZgwZA47nLaD4YEX8fplN66JmiM1AIqm+rfn
 KA8Mt/akwpescYxWIHgfLZZdgbNHi6E7b24WynJnSSlzmlgckkdSBNGlwetY4zZwaSz/
 Uj/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+xL0tstb0/uQAYKr5xUFPZBXl6VpJk4qLGCcfdRkLGLL6v1iwof8oq56AOuA/5gjjIWeLu2CfPc+F@nongnu.org
X-Gm-Message-State: AOJu0YznUI9kM81OHZrgT5AkiqWmSdSn0EemRsz6b+I9OAQvZklknvT8
 pm2N9lPvyPNXaIyqO5PRs4RlCVqDtyWSODooETWdnNDg+P8CB4ZSAcNm9y4woecxe5m1gjMNYCv
 MuQiIrybP4XQve8zINa9GgPrwf6xnZ7iWLDa99CGqHFhSJ+Gr9IHh
X-Received: by 2002:a05:6358:3114:b0:1ac:f3df:3be4 with SMTP id
 e5c5f4694b2df-1af3ba1a9b7mr183374455d.2.1722591728474; 
 Fri, 02 Aug 2024 02:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk0paCGeWVhRcyWCJElxcdxOb74/vgPqg4SND/eYZU2Qfu/PnDhtQB1D1iskdtqVUxfW1sow==
X-Received: by 2002:a05:6358:3114:b0:1ac:f3df:3be4 with SMTP id
 e5c5f4694b2df-1af3ba1a9b7mr183371955d.2.1722591727921; 
 Fri, 02 Aug 2024 02:42:07 -0700 (PDT)
Received: from [10.72.116.40] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b7654be84esm1042263a12.89.2024.08.02.02.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 02:42:07 -0700 (PDT)
Message-ID: <45e9258c-b370-4b5c-884b-80a21f69cee8@redhat.com>
Date: Fri, 2 Aug 2024 17:41:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/5] accel/kvm: Support KVM PMU filter
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti
 <mtosatti@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Yuan Yao <yuan.yao@intel.com>, Xiong Zhang <xiong.y.zhang@intel.com>,
 Mingwei Zhang <mizhang@google.com>, Jim Mattson <jmattson@google.com>
References: <20240710045117.3164577-1-zhao1.liu@intel.com>
 <b10545d1-8e81-44f0-8e13-eee393ea4d1b@redhat.com>
 <ZqyovJZkOjm6HZFv@intel.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <ZqyovJZkOjm6HZFv@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Zhao,

On 8/2/24 17:37, Zhao Liu wrote:
> Hello Shaoqin,
> 
> On Fri, Aug 02, 2024 at 05:01:47PM +0800, Shaoqin Huang wrote:
>> Date: Fri, 2 Aug 2024 17:01:47 +0800
>> From: Shaoqin Huang <shahuang@redhat.com>
>> Subject: Re: [RFC 0/5] accel/kvm: Support KVM PMU filter
>>
>> Hi Zhao,
>>
>> On 7/10/24 12:51, Zhao Liu wrote:
>>> Hi QEMU maintainers, arm and PMU folks,
>>>
>>> I picked up Shaoqing's previous work [1] on the KVM PMU filter for arm,
>>> and now is trying to support this feature for x86 with a JSON-compatible
>>> API.
>>>
>>> While arm and x86 use different KVM ioctls to configure the PMU filter,
>>> considering they all have similar inputs (PMU event + action), it is
>>> still possible to abstract a generic, cross-architecture kvm-pmu-filter
>>> object and provide users with a sufficiently generic or near-consistent
>>> QAPI interface.
>>>
>>> That's what I did in this series, a new kvm-pmu-filter object, with the
>>> API like:
>>>
>>> -object '{"qom-type":"kvm-pmu-filter","id":"f0","events":[{"action":"allow","format":"raw","code":"0xc4"}]}'
>>>
>>> For i386, this object is inserted into kvm accelerator and is extended
>>> to support fixed-counter and more formats ("x86-default" and
>>> "x86-masked-entry"):
>>>
>>> -accel kvm,pmu-filter=f0 \
>>> -object pmu='{"qom-type":"kvm-pmu-filter","id":"f0","x86-fixed-counter":{"action":"allow","bitmap":"0x0"},"events":[{"action":"allow","format":"x86-masked-entry","select":"0xc4","mask":"0xff","match":"0","exclude":true},{"action":"allow","format":"x86-masked-entry","select":"0xc5","mask":"0xff","match":"0","exclude":true}]}'
>>
>> What if I want to create the PMU Filter on ARM to deny the event range
>> [0x5,0x10], and allow deny event 0x13, how should I write the json?
>>
> 
> Cuurently this doesn't support the event range (since the raw format of
> x86 event cannot be said to be continuous).
> 
> So with the basic support, we need to configure events one by one:
> 
> -object pmu='{"qom-type":"kvm-pmu-filter","id":"f0","events":[{"action":"allow","format":"raw","code":"0x5"},{"action":"allow","format":"raw","select":"0x6"},{"action":"allow","format":"raw","code":"0x7"},{"action":"allow","format":"raw","code":"0x8"},{"action":"allow","format":"raw","code":"0x9"},{"action":"allow","format":"raw","code":"0x10"},{"action":"deny","format":"raw","code":"0x13"}]}'
> 
> This one looks a lot more complicated, but in the future, arm could
> further support event-range (maybe implement event-range via mask), but
> I think this could be arch-specific format since not all architectures'
> events are continuous.
> 
> Additional, I'm a bit confused by your example, and I hope you can help
> me understand that: when configuring 0x5~0x10 to be allow, isn't it true
> that all other events are denied by default, so denying 0x13 again is a
> redundant operation? What is the default action for all other events
> except 0x5~0x10 and 0x13?
> 
> If we specify action as allow for 0x5~0x10 and deny for the rest by
> default, then there is no need to set an action for each event but only
> a global one (as suggested by Dapeng), so the above command line can be
> simplified as:
> 
> -object pmu='{"qom-type":"kvm-pmu-filter","id":"f0","action":"allow","events":[{"format":"raw","code":"0x5"},{"format":"raw","select":"0x6"},{"format":"raw","code":"0x7"},{"format":"raw","code":"0x8"},{"format":"raw","code":"0x9"},{"format":"raw","code":"0x10"}]}'
> 

Yes you are right. On Arm when you first set the PMU Filter, if the 
first filter is allow, then all other event will be denied by default. 
The reverse is also the same, if the first filter is deny, then all 
other event will be allowed by default.

On ARM the PMU Filter is much more simper than x86 I think. We only need 
to care about the special event with allow or deny action.

If we don't support event range filter, I think that's fine. This can be 
added in the future.

Thanks,
Shaoqin

> Thanks,
> Zhao
> 

-- 
Shaoqin


