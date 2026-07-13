Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A74C4450A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjGaN-0003ij-Ht; Mon, 13 Jul 2026 09:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjGaM-0003iN-2m
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 09:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjGaJ-00014H-O9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 09:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783948833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ortu8WwD+9/M1jD0N3jV0kgeZzrEOBK+w9x5k8sKI4=;
 b=TU8yLJcZjHy9c7KO+m+QB7zn6NPPhznmiuNAjXz1nbrfChEzHD/canFzM8kCjTal5GdOkT
 xcI+3M84TOWfUlEyH50tOsliUkVB1U2ENfAQx0EiSrswhv7KWB6Mo9eNDqpNDIxZVUqC9o
 jTv+NKPkkV6yrSEajxgBlx+NSxdb8Mc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-9_U7AZHcOtqYvI3ZT5U0dg-1; Mon,
 13 Jul 2026 09:20:31 -0400
X-MC-Unique: 9_U7AZHcOtqYvI3ZT5U0dg-1
X-Mimecast-MFC-AGG-ID: 9_U7AZHcOtqYvI3ZT5U0dg_1783948830
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1DB71955D97; Mon, 13 Jul 2026 13:20:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 498BF1800348; Mon, 13 Jul 2026 13:20:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BC9EB21E6920; Mon, 13 Jul 2026 15:20:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  qemu-devel@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2] qdev: Clarify instantiation and realization
In-Reply-To: <CAFEAcA_E=okeaQ=P4qW7_NE0dZPANYU7QXiC0N-kSqvwahwD1Q@mail.gmail.com>
 (Peter Maydell's message of "Mon, 13 Jul 2026 12:33:08 +0100")
References: <20260629-qdev-v2-1-8cd1d9be0d8d@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA9QJCfeBTi4GdatY0Ci7no8BQETxHd7i6TtJ7SFxEtjjA@mail.gmail.com>
 <2c996e76-72a9-4e3f-b732-3cac1554be6b@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA_E=okeaQ=P4qW7_NE0dZPANYU7QXiC0N-kSqvwahwD1Q@mail.gmail.com>
Date: Mon, 13 Jul 2026 15:20:26 +0200
Message-ID: <874ii3gh5x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 13 Jul 2026 at 12:21, Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2026/07/13 18:13, Peter Maydell wrote:
>> > On Mon, 29 Jun 2026 at 09:18, Akihiko Odaki
>> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>> >>
>> >> The distinction of instantiation and realization was vague in the old
>> >> documentation so this change clarifies it.
>> >>
>> >> The old documentation said:
>> >>> The former may not fail (and must not abort or exit, since it is
>> >>> called during device introspection already), and the latter may return
>> >>> error information to the caller and must be re-entrant.
>> >>> Trivial field initializations should go into #TypeInfo.instance_init.
>> >>> Operations depending on @props static properties should go into
>> >>> @realize.
>> >>
>> >> The first problem with the old documentation is that it is unclear what
>> >> "trivial field initializations" means and why triviality makes
>> >> initialization appropriate for #TypeInfo.instance_init. Another problem
>> >> is that the documentation is not comprehensive enough; for example, it
>> >> mentions @props static properties, but it does not say anything about
>> >> the other properties.
>> >>
>> >> The keys to distinguish instantiation and realization are property
>> >> setting and device introspection. The fact that property setting happens
>> >> after #TypeInfo.instance_init and before realization implies that
>> >> operations depending on properties should go into @realize.
>> >>
>> >> The fact that instantiation happens during device introspection but
>> >> realization does not implies:
>> >> - Instance properties should be added in #TypeInfo.instance_init.
>> >> - Instantiation must not have any side effect not contained in the
>> >>    instance.
>> >> - Any operations without special requirements should go into @realize so
>> >>    that they can be skipped during device introspection.
>> >>
>> >> Note these two facts to guide appropriate instantiation and realization.
>> >
>> > Thanks for sending this. I think we definitely need to try to be
>> > clearer about what to do in instance_init and what to do in realize.
>> >
>> >> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> >
>> >>    * Realization
>> >>    * -----------
>> >>    *
>> >> - * Devices are constructed in two stages:
>> >> - *
>> >> - * 1) object instantiation via object_initialize() and
>> >> - * 2) device realization via the #DeviceState.realized property
>> >> - *
>> >> - * The former may not fail (and must not abort or exit, since it is called
>> >> - * during device introspection already), and the latter may return error
>> >> - * information to the caller and must be re-entrant.
>> >> - * Trivial field initializations should go into #TypeInfo.instance_init.
>> >> - * Operations depending on @props static properties should go into @realize.
>> >> + * Devices are constructed in the following order:
>> >> + *
>> >> + * 1) #TypeInfo.instance_init
>> >> + * 2) pre-realize property value setting

I find "pre-realize" confusing.  Suggest

          2) Set property values

>> >> + * 3) device realization via the #DeviceState.realized property

"via the #DeviceState.realized property" feels like detail.

>> >> + *
>> >> + * #TypeInfo.instance_init may not fail, and realization may return
>> >> + * error information to the caller and must be re-entrant.
>> >
>> > I know this is in the existing text, but what do we mean by
>> > "must be re-entrant" here ? Does this mean "even if you return
>> > a failure from your realize method you must be able to handle the
>> > caller retrying the realize operation" ?  (I'm not sure why that's
>> > a useful thing for the caller to be able to do...)>
>> > I assume we don't mean "even if you successfully realize you must
>> > handle (and treat as a no-op) a second call to realize", because
>> > none of our devices do that :-)
>>
>> If you take the code literally, device_set_realized() indeed avoids
>> calling realize after successful realization, but it doesn't report an
>> error when retrying, so I think this means to allow that.

Note that device_set_realized() is the setter of device property
"realized".

Setting a property to the value it already has is commonly a no-op, not
an error.

>> I don't think it's that useful, and it is likely to cause bunch of bugs.
>> I can also imagine that careful developers have written device code that
>> preserves this contract, though the added complexity is useless in practice.
>>
>> In my opinion, the property should be tristate: initialized, realized,
>> or retired. Then we would have only the following state transitions:
>>
>> Successful realization: initialized -> realized
>> Failed realization: initialized -> retired
>> Unrealization: realized -> retired

Maybe, but this is not the state machine we have.

>> This is another opportunity for refactoring, but for this particular
>> patch I'm planning to keep it out of scope.
>
> OK. We could make the text clearer then, I think. Maybe
>
> "#TypeInfo.instance_init may not fail. #DeviceClass.realize can
> fail, returning error information to the caller. A device realize
> method should handle being called again after it has failed once."
>
> ?

In general, a function should either do its job, or fail cleanly,
i.e. without side effects.

For .realize() "without side effects" includes:

* The failed call is invisible to the guest.

* The device behaves as if the failed call never happened.  This means
  you can try .realize() again.

Does the comment need to spell this out?

[...]


