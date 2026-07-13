Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819D2C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIDx-0007XW-9g; Mon, 13 Jul 2026 11:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjIDt-0007Rp-Tq
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjIDs-0005d7-2A
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783955130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5SFLVbMcVkAeTlyFbYOggfgudo5zjRTBNUcVJRvtXeI=;
 b=Irgis9Qd2OZVjCqHWa39dy6LCLuD3RFtDmLQ3nI0E2fdxIK1IGzXc8K2taXV+3XB+nDRHj
 tb0DSo7NodrTR/C0c9Acfd4e6Zcg/+5bD88Rj6S9Yi+bSR5KN52eexK4kXQ6RC2bWwLGT8
 yBuOh5xj3c5HL0e7tHI3R4DB3FD4MnA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-s05xlxKhNb6NbyL3SwsVQA-1; Mon,
 13 Jul 2026 11:05:29 -0400
X-MC-Unique: s05xlxKhNb6NbyL3SwsVQA-1
X-Mimecast-MFC-AGG-ID: s05xlxKhNb6NbyL3SwsVQA_1783955127
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEED41805A07; Mon, 13 Jul 2026 15:05:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D06036F29; Mon, 13 Jul 2026 15:05:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 93E5B21E6920; Mon, 13 Jul 2026 17:05:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  qemu-devel@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2] qdev: Clarify instantiation and realization
In-Reply-To: <CAFEAcA-rv3ZCBjUc3Z42NkQFV1wHWrxocCeCNAd1Eov7HUxrYg@mail.gmail.com>
 (Peter Maydell's message of "Mon, 13 Jul 2026 14:58:34 +0100")
References: <20260629-qdev-v2-1-8cd1d9be0d8d@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA9QJCfeBTi4GdatY0Ci7no8BQETxHd7i6TtJ7SFxEtjjA@mail.gmail.com>
 <2c996e76-72a9-4e3f-b732-3cac1554be6b@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA_E=okeaQ=P4qW7_NE0dZPANYU7QXiC0N-kSqvwahwD1Q@mail.gmail.com>
 <874ii3gh5x.fsf@pond.sub.org>
 <CAFEAcA-rv3ZCBjUc3Z42NkQFV1wHWrxocCeCNAd1Eov7HUxrYg@mail.gmail.com>
Date: Mon, 13 Jul 2026 17:05:23 +0200
Message-ID: <87ik6jdj64.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

> On Mon, 13 Jul 2026 at 14:20, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > OK. We could make the text clearer then, I think. Maybe
>> >
>> > "#TypeInfo.instance_init may not fail. #DeviceClass.realize can
>> > fail, returning error information to the caller. A device realize
>> > method should handle being called again after it has failed once."
>> >
>> > ?
>>
>> In general, a function should either do its job, or fail cleanly,
>> i.e. without side effects.
>>
>> For .realize() "without side effects" includes:
>>
>> * The failed call is invisible to the guest.
>>
>> * The device behaves as if the failed call never happened.  This means
>>   you can try .realize() again.
>>
>> Does the comment need to spell this out?
>
> If we want that, I think we should spell it out. I have generally
> assumed when writing realize functions that the semantics are
> "if this fails, the only thing the caller can usefully do with
> the object is destroy it". Realize code very very rarely attempts
> to cleanly unwind if it finds an error partway through. I would
> expect the only cases where it works at all are the ones where
> the only errors are "sanity check of property values etc" that
> happens up front.
>
> I would prefer it if we did not require this, because I think
> it imposes extra burden on implementations in order to provide
> something that is not of any benefit to anybody.

No objection, as long as the function contract is clear.

> Analogy: for unix sockets, you need to first open() and then
> connect(). The connect() manpage and the POSIX spec say that if
> connect() fails the only thing you can validly do with the socket
> is call close(): you're not allowed to keep it around and try
> connect() or some other operation on it.
>
> (We also undoubtedly have a lot of bugs where an error in realize
> leaves bits of the device visible to the emulation, or doesn't
> free things that were allocated, etc. But that's a separate and
> uncontroversial kind of bug. We don't notice these because for
> almost all devices the response to "realize failed" is that we're
> going to exit QEMU, because the device is part of the machine.)

Yes.


