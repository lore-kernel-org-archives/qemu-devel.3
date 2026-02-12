Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F364FEE369D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZ37-0005eB-DC; Thu, 12 Feb 2026 10:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vqZ35-0005dU-O0
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:56:11 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vqZ33-0007vo-7P
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:56:11 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 79112596A0B;
 Thu, 12 Feb 2026 16:56:05 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 9Y8NtiR0Q00T; Thu, 12 Feb 2026 16:56:03 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 626B95969F6; Thu, 12 Feb 2026 16:56:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 602885969F0;
 Thu, 12 Feb 2026 16:56:03 +0100 (CET)
Date: Thu, 12 Feb 2026 16:56:03 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Zhao Liu <zhao1.liu@intel.com>
cc: =?UTF-8?Q?Daniel_P=2E_Berrang=EF=BF=BD?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu-Daud=EF=BF=BD?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
 qemu-devel@nongnu.org, devel@lists.libvirt.org
Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track external
 user input
In-Reply-To: <aY3yNPRh2qw0tt3q@intel.com>
Message-ID: <e761bbc7-7778-67d3-f5ce-a74f1ace3a73@eik.bme.hu>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <aYsElqDoGXQ_xMBD@redhat.com> <aYtOh9guoiQocdjk@intel.com>
 <0193cb6f-7b73-43c1-ac89-93b426d3983e@eik.bme.hu>
 <aYwuxfPyExb3Hv8y@intel.com>
 <cefd333c-9893-47b7-9c1b-1ebd218b734d@eik.bme.hu>
 <aY3yNPRh2qw0tt3q@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 12 Feb 2026, Zhao Liu wrote:
> On Wed, Feb 11, 2026 at 12:28:13PM +0100, BALATON Zoltan wrote:
>> Date: Wed, 11 Feb 2026 12:28:13 +0100
>> From: BALATON Zoltan <balaton@eik.bme.hu>
>> Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track
>>  external user input
>>
>> On Wed, 11 Feb 2026, Zhao Liu wrote:
>>>> So another way could be to not use properties for internal settings but add
>>>> another set of internal properties for those. These could be set the same
>>>> way but stored in a different hash table and not get mixed with
>>>> introspectable and user changable properties. But maybe that would be too
>>>> much refactoring.
>>>
>>> Yes, it may require adding interfaces similar to object_property_add/get/
>>> set, which would need significant changes.
>>
>> Maybe not that part needs significant changes as you could still use a flag
>> the same way adding a parameter to object_property_add/get/set to tell it
>> should put the propery in the internal hash but then you need to add the
>> other hash and maybe related changes. I don't know how much would those be
>> but no new interface is needed just extending existing one as you did
>> already.
>
> Yes, you're right, the flag-related interfaces in this series provide
> enough support. But I haven't quite figured out what the advantages of
> using an independent hash table would be, or what problems it could
> address... I feel like I need to think about it more :).

Storing internal properties in another hash could avoid needing INTERNAL 
and USER_SET flags as then there would be no way to set internal 
properties other than from code and may save some checks as then you would 
not need to special case internal properties in the user 
inspectable/settable properties handling. But I don't know how much other 
infrastructure it would need and if that would end up simpler than your 
approach or not. I think it may be simpler by avoiding the special cases 
and flags and clearly separating properties but as you say that would need 
more thinking and I did not try to think further just throwing the idea at 
you :-). The part creating, setting and storing internal properties should 
be simple but I don't know if the usage of these would have a problem when 
getting properties use the same interface for both external and internal 
properties. But if all these internal properties just set device state 
fields then all that's needed might be changing the property definition to 
use internal property and the compat props to set such properties (but 
compat may use some user settable properties too so this may make those a 
bit more complex).

Regards,
BALATON Zoltan

