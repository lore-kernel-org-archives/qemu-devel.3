Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19D4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 09:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbz2Q-0001dF-Cj; Thu, 08 Aug 2024 05:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbz2I-0001Yv-S8
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 05:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sbz2G-0000hd-Rn
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 05:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723107735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HiyGi7Q1zlSqPeEiA5xu3E56J3mw7niOeosteLq135o=;
 b=JWz6QkI23ykLrXsa150FCqhiqzcWJTZo1Io0td/7aO1Oy58xpvvaP4LrQrXu1q/64NlpWd
 kTx8cEnJUN6/cJK4epLdwxRJEwmuEQ8iRwTRXK5EneeIu2kvInJLN3KozYMA7u219YALu4
 X29qC24/d4suCsKpR22tnE+GUkAsdxM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-njc4O-I7OWO53MLJTwwlsw-1; Thu,
 08 Aug 2024 05:02:09 -0400
X-MC-Unique: njc4O-I7OWO53MLJTwwlsw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6B361955F43; Thu,  8 Aug 2024 09:02:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41C6C1955F2E; Thu,  8 Aug 2024 09:02:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E1BAE21E66E5; Thu,  8 Aug 2024 11:02:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  qemu-devel@nongnu.org,
 Eric Blake
 <eblake@redhat.com>,  qemu-arm@nongnu.org,  Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH-for-9.1? 1/2] target/arm: Move
 qmp_query_gic_capabilities() to hw/intc/
In-Reply-To: <CAFEAcA8J4i-81rOEHBpqbV=c4F26o6qd3Lg9dZV+BuNyZPGg7Q@mail.gmail.com>
 (Peter Maydell's message of "Thu, 8 Aug 2024 09:44:59 +0100")
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-2-philmd@linaro.org>
 <f82397e9-3be4-49be-b291-5598acdaf39b@linaro.org>
 <CAFEAcA9emwsK07+itUzMxReOLG8gHaxNdDE8ymuwyuBfsoY2Pg@mail.gmail.com>
 <87bk23skhq.fsf@pond.sub.org>
 <CAFEAcA8J4i-81rOEHBpqbV=c4F26o6qd3Lg9dZV+BuNyZPGg7Q@mail.gmail.com>
Date: Thu, 08 Aug 2024 11:02:04 +0200
Message-ID: <87ed6z1j77.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 8 Aug 2024 at 05:32, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> [...]
>>
>> > The QAPI command which this code is implementing is
>> > also (a) target-specific and (b) unfortunately
>> > designed so that it doesn't get passed a particular
>> > CPU or particular device to query, it's just assumed
>> > to be a part of the whole simulation.
>>
>> We can fix (b) if we care: add a suitable optional argument, default to
>> the sole GIC in the system, fail if there's more than one.  I assume we
>> have no machines with more than one now.
>
> The exynos4210 SoC (board types 'nuri', 'smdkc210') has
> two GICs. (It's a rather odd design -- there's the
> interrupt controller that's part of the main CPU
> cluster, and then they used a second "external" GIC
> that feeds into that one.)

Then "fail if there's more than one" would be an incompatible change for
this machine.

If the two GICs have identical capabilities, it doesn't matter to which
of the two query-gic-capabilities technically applies.

Else, it matters, and we have an interface issue.  Do we?


