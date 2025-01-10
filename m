Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F1EE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 07:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW9aQ-0000MU-V1; Fri, 10 Jan 2025 02:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tW9aI-0000M1-63
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 02:37:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tW9aC-00034c-Hr
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 02:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736494647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DyHFNH5Jvc7WtLOc4UKV/Vy64yR7JnfbssXJLfrMCnw=;
 b=AyZ/skvtN8WdfFKN7IJ123BQl7ZEb6JkPSs9s7+Tow3yfcIRUMRMxKbg3GJwwXTMSZbqK2
 3WUNzwVnP6HsDrKMoLNAf2QxIHJ2SSrpayFZRToboOZ8Uj4ara8oBbsKVHzbc861WhOKtT
 d++hzrvbc+7zv0qE3FuW40B6FTFX9HI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-RfHuGWEKPemqcPlECwm76g-1; Fri,
 10 Jan 2025 02:37:21 -0500
X-MC-Unique: RfHuGWEKPemqcPlECwm76g-1
X-Mimecast-MFC-AGG-ID: RfHuGWEKPemqcPlECwm76g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65C381955F79; Fri, 10 Jan 2025 07:37:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 238F51955BE3; Fri, 10 Jan 2025 07:37:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D56C221E6924; Fri, 10 Jan 2025 08:37:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 09/23] qapi/source: allow multi-line QAPISourceInfo
 advancing
In-Reply-To: <CAFn=p-aH0Py8qTiSO01Gc3r==gcTcYBm9zY4TT-x5wbaVxTo6g@mail.gmail.com>
 (John Snow's message of "Thu, 9 Jan 2025 12:19:09 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-10-jsnow@redhat.com>
 <87h66y4hgl.fsf@pond.sub.org>
 <CAFn=p-YBsJBNFWrX=XLF1TaWPjSA5kNhg3spf83Cw9_JnS2_pw@mail.gmail.com>
 <87plkwto0z.fsf@pond.sub.org>
 <CAFn=p-aH0Py8qTiSO01Gc3r==gcTcYBm9zY4TT-x5wbaVxTo6g@mail.gmail.com>
Date: Fri, 10 Jan 2025 08:37:16 +0100
Message-ID: <871pxb6rwz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> On Thu, Jan 9, 2025, 3:00=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
[...]
>> > Modifying freeform syntax to be purely rST that isn't modified or rewr=
itten
>> > at all has benefits:
>> >
>> > - No need to mangle or multiplex source line source information
>> > - Less code
>> > - More straightforward
>> >
>> > I'm quite happy to do it later, is there some kind of "ticket" system =
you'd
>> > tolerate using for tracking nits for cleanup? I *will* forget if we do=
n't
>> > listify and track them, I'm sorry (but wise enough) to admit. I just d=
on't
>> > want to get sidetracked on little side-quests right now. (Quite prone =
to
>> > this...)
>>
>> TODO comment in code this would obviously kill?  Not exactly a ticket
>> system...
>>
>> scripts/qapi/TODO?  Still not a ticket system...
>>
>
> If a TODO is fine (and you don't mind pinging me in the future), then the
> comment I left in the visit_freeform() function (it's in another patch)
> explaining that the custom parser can be dropped after we sunset the old
> qapidoc is likely sufficient if I just add a "TODO".
>
> Sound good?

Yes.

[...]


