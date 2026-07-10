Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9A3C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiBmv-0001Sy-Jg; Fri, 10 Jul 2026 10:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wiBmt-0001Sa-Rz
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:01:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wiBms-0003G6-1E
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783692063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6F7g5LJi9+KE2tcGUjJ1O3R/32fFLVDjiZuy+Hl7Ip8=;
 b=Z7yERooz/PRZxgvfCrwtztbs8m0tV/4KsI2f4LABcF1t8lCVkty+tcRTPAOcILERJvHyT2
 8VNgOsfnPmrcNWsvB1RN+kTr2hG4IyFzQtJVmnodssvjBJeJvdNMszmELIho74SMzWA7Tn
 h4S3z0lHl2DzfOMu1pabl7FsUKnZU4s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-APqk4ukRNbuawtfWYc2f8A-1; Fri,
 10 Jul 2026 10:01:00 -0400
X-MC-Unique: APqk4ukRNbuawtfWYc2f8A-1
X-Mimecast-MFC-AGG-ID: APqk4ukRNbuawtfWYc2f8A_1783692059
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B59E71955F07; Fri, 10 Jul 2026 14:00:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 489A1180028B; Fri, 10 Jul 2026 14:00:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CAF4021E6920; Fri, 10 Jul 2026 16:00:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Mark
 Cave-Ayland <mark.caveayland@nutanix.com>,  pbonzini@redhat.com,
 richard.henderson@linaro.org,  mst@redhat.com,  mtosatti@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 8/9] hw/i386/pc_sysfw.c: convert pflash0 and pflash1
 object props to class props
In-Reply-To: <CAFEAcA_isBMYU8mEZV-sjbiePHLDqERiczkoPP6xw4i4UYm5pw@mail.gmail.com>
 (Peter Maydell's message of "Wed, 8 Jul 2026 14:27:44 +0100")
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
 <20260703090814.2993188-9-mark.caveayland@nutanix.com>
 <CAFEAcA-Agr3jDYfM466UtqNywfxxX6Vv6H30B8QQDMykQ0ktOg@mail.gmail.com>
 <ak4lRc9u5ol0DtCM@redhat.com> <87fr1tk9pu.fsf@pond.sub.org>
 <ak40R8r6q6X0bDyF@redhat.com> <875x2pk5ld.fsf@pond.sub.org>
 <ak5IXipr3F9we3oX@redhat.com> <87v7apiqpl.fsf@pond.sub.org>
 <CAFEAcA_isBMYU8mEZV-sjbiePHLDqERiczkoPP6xw4i4UYm5pw@mail.gmail.com>
Date: Fri, 10 Jul 2026 16:00:55 +0200
Message-ID: <87v7anx7u0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 8 Jul 2026 at 13:57, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>
>> > On Wed, Jul 08, 2026 at 02:50:54PM +0200, Markus Armbruster wrote:
>> >> > Something would need to validate that instantiating a machine type
>> >> > for help usage won't trip over any edge cases. Could be done with
>> >> > unit tests.
>> >>
>> >> tests/qtest/device-introspect-test.c covers this for devices.
>> >
>> > Ah, good, I was misled by its name into thinking it was only devices,
>> > not machine types too.
>>
>> Misunderstanding: it does cover it for devices, and only for devices.
>
> Does Marc-Andr=C3=A9's recent qom-tests test cover the machines? It
> does an instantiate/get props/unref cycle for all non-abstract
> QOM types, which ought to include the machines.

I guess you mean commit f741225073 (qtest: add "qom-tests" command,
2026-04-24).  Looking at the code...  yes, that should cover machines.

> A while back I had a look at moving Machine to be a subclass
> of Device, incidentally -- that would let us have machine
> reset not be a weird special case, allow separating machine
> init from realize, and make machines be more like SoC objects
> (which they resemble a lot in being "creates, configures
> and wires up a load of other devices").

Makes sense to me.

>                                         I forget where I
> got to in that, though.

Been there, done that *sigh*.


