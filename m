Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93621C87FCA
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Aug 2025 05:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukyBB-00060X-6d; Sun, 10 Aug 2025 01:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ukyAI-0005dL-70; Sun, 10 Aug 2025 01:00:16 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ukyAE-0006Jk-MK; Sun, 10 Aug 2025 01:00:13 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 57A4xln3063808
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 10 Aug 2025 13:59:48 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Fi7VB2/Ndo6JMiifk3GQv9lHCTbtsiXSXuanqSXP+CY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754801988; v=1;
 b=pCfwQy3M1qMnhftg4Iqb1Yp8/bA4FyezbdGl9qpmiLnpXwJhxbe3PFSxxrK+pIhS
 63L3BOyubcfUDCVi6FLD+Go8CT6lKhJJekRIydwDn0GOAKEHUFpT/ZOFmlVhKEW5
 UAGG078gi3Tw7ctj1vY6ogSQ4oZFtxkL/b+k2otf5bBBf3v3h9EP0KbokPV6mgLX
 5huWtnF9daS8vU10AUhOPK9hcogWgUwKQnbeWYUAwi211RC+e4JIOsOqW9yLrKOY
 oiepB97XNIHn8DgX5QHehb3W5LaJwTTVz5+NMuIwAfMYy8PZd6vKlLLOAy0nZtaG
 V3lJTLLfBum6AqZUcga3ag==
Message-ID: <e4325c6b-f543-4f1b-862a-290e51c80999@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 10 Aug 2025 13:59:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 23/24] migration: Add error-parameterized function
 variants in VMSD struct
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-23-fef740e15e17@redhat.com>
 <3e9aa703-2805-4ac4-9f10-f4ba71c10c8a@rsg.ci.i.u-tokyo.ac.jp>
 <aH5AtUcjI3HYXdBe@redhat.com>
 <9c552525-72fa-4d1e-89a2-b5c0e446935a@rsg.ci.i.u-tokyo.ac.jp>
 <87fre0ucxu.fsf@pond.sub.org>
 <d3c6cac8-cbf6-4c27-afea-c49391262935@rsg.ci.i.u-tokyo.ac.jp>
 <87jz3csh3b.fsf@pond.sub.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <87jz3csh3b.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/08/09 23:30, Markus Armbruster wrote:
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:
> 
>> On 2025/08/09 17:17, Markus Armbruster wrote:
>>> Almost missed this, sorry.
>>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:
>>>
>>>> On 2025/07/21 22:29, Daniel P. Berrangé wrote:
> 
> [...]
> 
>>>>> No, please do NOT make these functions void. As that text you quote
>>>>> says, we want functions to return a value indicating success/failure.
>>>>> 'void' return is a historical practice we don't want to continue
>>>>> in QEMU.
>>>>>
>>>>> Given that the existing methods all return 'int', we should remain
>>>>> consistent with the new functions and return 'int', with -1 for
>>>>> failure, 0 for success, and not use bool.
>>>>
>>>> Markus, I'd also like to hear your opinion since you are the maintainer of the error reporting facility.
>>>
>>> I'm with Daniel.
>>>
>>> New code should stick to the rules.
>>>
>>> Changing existing code from "sticks to the rules" to not requires pretty
>>> compelling justification.
>>>
>>> The other direction is more welcome, but whether the juice is worth the
>>> squeeze still needs to be decided case by case.
>>
>> What do you refer with the rules?
> 
> The big comment in qapi/error.h starts with a section = Rules =.
> 
>> There were three options on the table: bool, int, and void.
>>
>> The previous discussion you referred explains why void should be avoided, and include/qapi/error.h also says void should be avoided.
>>
>> There is pre_load() that does not use Error returns int, but now we are adding pre_load_errp() that uses Error.
>>
>> Then what pre_load_errp() should return: bool or int?
> 
> I like bool when it's all we need.
> 
> When we need to return a non-negative int on success, use int and return
> -1 or a negative error code on failure.
> 
> Another reason to pick int is local consistency: related functions
> already use int.
> 
> Changing working code from int to bool doesn't seem worth the bother.
> 
> Questions?
> 

I at least see what "[PATCH v9 26/27] migration: Add error-parameterized 
function variants in VMSD struct" says is undesirable. It says:
 > For the errp variants,
 > Returns: 0 on success,
 >          <0 on error where -value is an error number from errno.h

There are already non-errp variant implementations that return -1 (e.g., 
dbus_vmstate_post_load). Adding errp variants that require to return 
errno is degradation.

I'm still not sure what conclusion will be drawn. I can make two 
opposite conclusions:

- Non-errp variants return int, so errp variants should also return int
   for local consistency.

- bool is all we need, but changing non-errp variants doesn't seem worth
   the bother, so only errp variants should return bool.

