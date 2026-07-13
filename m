Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C1DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjP9g-0006Mb-RR; Mon, 13 Jul 2026 18:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wjP9e-0006MN-CH
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:29:38 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wjP9a-00020r-Ir
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 18:29:38 -0400
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66DMTS72038350
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 14 Jul 2026 07:29:28 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=20NE8yCf5vKiGpeM7pGoPN3IXBBS26LwnwtluTjXeHg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1783981768; v=1;
 b=DDOaowpJAaOQquxKYq7r7ujY4c6pDWRYS1pMMD9iid/hbJt41dH7JDw6flamVIX/
 fKTVFcGKlA52bX4Qqy1lq1h6Klg2O5lESuFrUoJluqvrlDVabzsYk+PIziRT4/9Y
 11TBrH7xV12q8SLZUJDnJCdyQHmbo7D4I43yvwzfBq/Gmwmi+paG3aBl1YT27f3b
 C7PVDS0v6SBSDWwNf6ZJYVooarZM32AAItV5tYghgi8Lw+NOFTruHb7RbiYv/MAT
 StfYgHHxPPSBL17UuEphbb5dOkCOS//FpZULwvPvskJHTYwzOcfH35flLIhvSVpJ
 K/nDgXDIeYNMiI6XpB2UBQ==
Message-ID: <d32977b4-b1f7-4fb1-87ff-c7c30bd429cd@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 14 Jul 2026 07:29:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qdev: Clarify instantiation and realization
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20260629-qdev-v2-1-8cd1d9be0d8d@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA9QJCfeBTi4GdatY0Ci7no8BQETxHd7i6TtJ7SFxEtjjA@mail.gmail.com>
 <2c996e76-72a9-4e3f-b732-3cac1554be6b@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA_E=okeaQ=P4qW7_NE0dZPANYU7QXiC0N-kSqvwahwD1Q@mail.gmail.com>
 <874ii3gh5x.fsf@pond.sub.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <874ii3gh5x.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/07/13 22:20, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Mon, 13 Jul 2026 at 12:21, Akihiko Odaki
>> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>>
>>> On 2026/07/13 18:13, Peter Maydell wrote:
>>>> On Mon, 29 Jun 2026 at 09:18, Akihiko Odaki
>>>> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>>>>
>>>>> The distinction of instantiation and realization was vague in the old
>>>>> documentation so this change clarifies it.
>>>>>
>>>>> The old documentation said:
>>>>>> The former may not fail (and must not abort or exit, since it is
>>>>>> called during device introspection already), and the latter may return
>>>>>> error information to the caller and must be re-entrant.
>>>>>> Trivial field initializations should go into #TypeInfo.instance_init.
>>>>>> Operations depending on @props static properties should go into
>>>>>> @realize.
>>>>>
>>>>> The first problem with the old documentation is that it is unclear what
>>>>> "trivial field initializations" means and why triviality makes
>>>>> initialization appropriate for #TypeInfo.instance_init. Another problem
>>>>> is that the documentation is not comprehensive enough; for example, it
>>>>> mentions @props static properties, but it does not say anything about
>>>>> the other properties.
>>>>>
>>>>> The keys to distinguish instantiation and realization are property
>>>>> setting and device introspection. The fact that property setting happens
>>>>> after #TypeInfo.instance_init and before realization implies that
>>>>> operations depending on properties should go into @realize.
>>>>>
>>>>> The fact that instantiation happens during device introspection but
>>>>> realization does not implies:
>>>>> - Instance properties should be added in #TypeInfo.instance_init.
>>>>> - Instantiation must not have any side effect not contained in the
>>>>>     instance.
>>>>> - Any operations without special requirements should go into @realize so
>>>>>     that they can be skipped during device introspection.
>>>>>
>>>>> Note these two facts to guide appropriate instantiation and realization.
>>>>
>>>> Thanks for sending this. I think we definitely need to try to be
>>>> clearer about what to do in instance_init and what to do in realize.
>>>>
>>>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>
>>>>>     * Realization
>>>>>     * -----------
>>>>>     *
>>>>> - * Devices are constructed in two stages:
>>>>> - *
>>>>> - * 1) object instantiation via object_initialize() and
>>>>> - * 2) device realization via the #DeviceState.realized property
>>>>> - *
>>>>> - * The former may not fail (and must not abort or exit, since it is called
>>>>> - * during device introspection already), and the latter may return error
>>>>> - * information to the caller and must be re-entrant.
>>>>> - * Trivial field initializations should go into #TypeInfo.instance_init.
>>>>> - * Operations depending on @props static properties should go into @realize.
>>>>> + * Devices are constructed in the following order:
>>>>> + *
>>>>> + * 1) #TypeInfo.instance_init
>>>>> + * 2) pre-realize property value setting
> 
> I find "pre-realize" confusing.  Suggest
> 
>            2) Set property values

I used "pre-realize" to distinguish this phase from property changes
that can happen after realization.

> 
>>>>> + * 3) device realization via the #DeviceState.realized property
> 
> "via the #DeviceState.realized property" feels like detail.

Nice catch. I kept the original text here, but this is a good 
opportunity to make it more concise. I'll drop it in the next version.

> 
>>>>> + *
>>>>> + * #TypeInfo.instance_init may not fail, and realization may return
>>>>> + * error information to the caller and must be re-entrant.
>>>>
>>>> I know this is in the existing text, but what do we mean by
>>>> "must be re-entrant" here ? Does this mean "even if you return
>>>> a failure from your realize method you must be able to handle the
>>>> caller retrying the realize operation" ?  (I'm not sure why that's
>>>> a useful thing for the caller to be able to do...)>
>>>> I assume we don't mean "even if you successfully realize you must
>>>> handle (and treat as a no-op) a second call to realize", because
>>>> none of our devices do that :-)
>>>
>>> If you take the code literally, device_set_realized() indeed avoids
>>> calling realize after successful realization, but it doesn't report an
>>> error when retrying, so I think this means to allow that.
> 
> Note that device_set_realized() is the setter of device property
> "realized".
> 
> Setting a property to the value it already has is commonly a no-op, not
> an error.

This is about the retrying scenario i.e., "even if you return a failure 
from your realize method you must be able to handle the caller retrying 
the realize operation".

> 
>>> I don't think it's that useful, and it is likely to cause bunch of bugs.
>>> I can also imagine that careful developers have written device code that
>>> preserves this contract, though the added complexity is useless in practice.
>>>
>>> In my opinion, the property should be tristate: initialized, realized,
>>> or retired. Then we would have only the following state transitions:
>>>
>>> Successful realization: initialized -> realized
>>> Failed realization: initialized -> retired
>>> Unrealization: realized -> retired
> 
> Maybe, but this is not the state machine we have.
> 
>>> This is another opportunity for refactoring, but for this particular
>>> patch I'm planning to keep it out of scope.
>>
>> OK. We could make the text clearer then, I think. Maybe
>>
>> "#TypeInfo.instance_init may not fail. #DeviceClass.realize can
>> fail, returning error information to the caller. A device realize
>> method should handle being called again after it has failed once."
>>
>> ?
> 
> In general, a function should either do its job, or fail cleanly,
> i.e. without side effects.
> 
> For .realize() "without side effects" includes:
> 
> * The failed call is invisible to the guest.
> 
> * The device behaves as if the failed call never happened.  This means
>    you can try .realize() again.
> 
> Does the comment need to spell this out?

Practically I think it's irrelevant.

Indeed failing cleanly is a generic good practice and we currently have 
that explicitly spelled it out here. In reality, however, the retrying 
path is never tested and it would break things in interesting ways if 
you exercise it. So I think the tristate I described above is already 
accidentally formed and the realized property is not accurately 
representing it.

Considering that reality of device lifecycle instead of the realized 
property, which is just an extra detail, I regard it as a documented 
invariant not enforced and it is rather misleading.

Regards,
Akihiko Odaki

