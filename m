Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76AFC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 15:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udsHa-0008EE-Nu; Mon, 21 Jul 2025 11:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udsFd-0005xL-B6; Mon, 21 Jul 2025 11:16:25 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udsFX-0005G7-L0; Mon, 21 Jul 2025 11:16:24 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56LFFsYu041503
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 22 Jul 2025 00:15:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=bNuNKyzVDeKh62uH7stdtMjPgFbdM7XIM9ZPukFTRII=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1753110954; v=1;
 b=jrTi2svaunOw9q9Gz6FDmaUzajYOMh842KfGn6oUn8X9UwB/asRw0VRxXaGKiVZq
 L0P0yubWYDrP6yrdeYSAhccnkoNdi5QBJuG1DQiwFpTdhnkrvDkRb++XoKINQ+gi
 l+heVn2GeDMJ9RLaX5pG2WADeOBzAqetzgEJCU4iBy5J3GxTbtmcquI/cmZx/LP5
 Zbq837SUZcUp4YwSwl5ndWZ+dFlq8e0ErgT0QYthXa5prlkgu3kurbBX+cVHzam1
 L7iLhSZgnSGHNZZaPcvSf1EqjxaYWmbSo7+KgrZz9hzRLmdjAvC7XNJmLqpzM5/M
 L/WwkStHClKEN2laINhusg==
Message-ID: <9c552525-72fa-4d1e-89a2-b5c0e446935a@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 22 Jul 2025 00:15:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 23/24] migration: Add error-parameterized function
 variants in VMSD struct
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org,
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
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aH5AtUcjI3HYXdBe@redhat.com>
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

On 2025/07/21 22:29, Daniel P. Berrangé wrote:
> On Mon, Jul 21, 2025 at 10:14:30PM +0900, Akihiko Odaki wrote:
>> On 2025/07/21 20:29, Arun Menon wrote:
>>> - We need to have good error reporting in the callbacks in
>>>     VMStateDescription struct. Specifically pre_save, post_save,
>>>     pre_load and post_load callbacks.
>>> - It is not possible to change these functions everywhere in one
>>>     patch, therefore, we introduce a duplicate set of callbacks
>>>     with Error object passed to them.
>>> - So, in this commit, we implement 'errp' variants of these callbacks,
>>>     introducing an explicit Error object parameter.
>>> - This is a functional step towards transitioning the entire codebase
>>>     to the new error-parameterized functions.
>>> - Deliberately called in mutual exclusion from their counterparts,
>>>     to prevent conflicts during the transition.
>>> - New impls should preferentally use 'errp' variants of
>>>     these methods, and existing impls incrementally converted.
>>>     The variants without 'errp' are intended to be removed
>>>     once all usage is converted.
>>>
>>> Signed-off-by: Arun Menon <armenon@redhat.com>
>>> ---
>>>    include/migration/vmstate.h | 11 +++++++++++
>>>    migration/vmstate.c         | 47 +++++++++++++++++++++++++++++++++++++++------
>>>    2 files changed, 52 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>>> index 056781b1c21e737583f081594d9f88b32adfd674..53fa72c1bbde399be02c88fc8745fdbb79bfd7c8 100644
>>> --- a/include/migration/vmstate.h
>>> +++ b/include/migration/vmstate.h
>>> @@ -200,15 +200,26 @@ struct VMStateDescription {
>>>         * exclusive. For this reason, also early_setup VMSDs are migrated in a
>>>         * QEMU_VM_SECTION_FULL section, while save_setup() data is migrated in
>>>         * a QEMU_VM_SECTION_START section.
>>> +     *
>>> +     * There are duplicate impls of the post/pre save/load hooks.
>>> +     * New impls should preferentally use 'errp' variants of these
>>> +     * methods and existing impls incrementally converted.
>>> +     * The variants without 'errp' are intended to be removed
>>> +     * once all usage is converted.
>>>         */
>>> +
>>>        bool early_setup;
>>>        int version_id;
>>>        int minimum_version_id;
>>>        MigrationPriority priority;
>>>        int (*pre_load)(void *opaque);
>>> +    int (*pre_load_errp)(void *opaque, Error **errp);
>>>        int (*post_load)(void *opaque, int version_id);
>>> +    int (*post_load_errp)(void *opaque, int version_id, Error **errp);
>>>        int (*pre_save)(void *opaque);
>>> +    int (*pre_save_errp)(void *opaque, Error **errp);
>>>        int (*post_save)(void *opaque);
>>> +    int (*post_save_errp)(void *opaque, Error **errp);
>>
>> I think the new functions should have void as return value instead.
>>
>> As I discussed before, I think having an integer return value is a source of
>> confusion:
>> https://lore.kernel.org/qemu-devel/0447e269-c242-4cd7-b68e-d0c7211784a7@rsg.ci.i.u-tokyo.ac.jp/
>>
>> In the previous discussion, I suggested using bool, but void fits better in
>> this particular case.
>>
>> include/qapi/error.h says:
>>> Whenever practical, also return a value that indicates success /
>>> failure.  This can make the error checking more concise, and can avoid
>>> useless error object creation and destruction.  Note that we still
>>> have many functions returning void.
>>
>> There will be more implementations of these function pointers than their
>> callers, so it makes more sense to let return void and make implementations
>> more concise while making the callers less so. There is also DeviceRealize,
>> an example of function pointer type that takes errp but returns void.
> 
> No, please do NOT make these functions void. As that text you quote
> says, we want functions to return a value indicating success/failure.
> 'void' return is a historical practice we don't want to continue
> in QEMU.
> 
> Given that the existing methods all return 'int', we should remain
> consistent with the new functions and return 'int', with -1 for
> failure, 0 for success, and not use bool.

Markus, I'd also like to hear your opinion since you are the maintainer 
of the error reporting facility.

Regards,
Akihiko Odaki

