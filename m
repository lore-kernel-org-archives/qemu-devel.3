Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCE9D4A603
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 06:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgdIW-0002Id-MG; Fri, 16 Jan 2026 01:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgdIV-0002IT-FP
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 01:27:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgdIQ-0006iC-G7
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 01:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768544800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=feM8e7A6YCbPo1NATFaabiPqUve8jN0RQK4rAMOMs0Y=;
 b=XGwbjAyltXM2CZa4wxRJdjb0r8Yl/6QioUrsd2sKQznMuXtqB8JmhzYRLHgN4ojzFizfHJ
 czKr1ZZxSO/GyBWnkkUkaXX8gTMQSXOUSZmoXdMC90I+qKYnxz/9TL88GzovVtm7Umh9FG
 7VOEAGqZub8XG5hf7NRN7brCSc8ynHE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-vQ8QupTTNDamE2-NF90NCw-1; Fri,
 16 Jan 2026 01:26:36 -0500
X-MC-Unique: vQ8QupTTNDamE2-NF90NCw-1
X-Mimecast-MFC-AGG-ID: vQ8QupTTNDamE2-NF90NCw_1768544795
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D343918002C2; Fri, 16 Jan 2026 06:26:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22C2A3001DBA; Fri, 16 Jan 2026 06:26:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A8D5E21E692D; Fri, 16 Jan 2026 07:26:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,  Juraj Marcin
 <jmarcin@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,  Juan Quintela
 <quintela@trasno.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,  Zhang Chen
 <zhangckid@gmail.com>,  zhanghailiang@xfusion.com,  Li Zhijian
 <lizhijian@fujitsu.com>,  Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
In-Reply-To: <20260115224929.616aab85@penguin> (Lukas Straub's message of
 "Thu, 15 Jan 2026 22:49:29 +0100")
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
Date: Fri, 16 Jan 2026 07:26:31 +0100
Message-ID: <87ecnqt6nc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Lukas Straub <lukasstraub2@web.de> writes:

> On Wed, 14 Jan 2026 15:11:55 -0500
> Peter Xu <peterx@redhat.com> wrote:
>
>> On Wed, Jan 14, 2026 at 02:56:57PM -0500, Peter Xu wrote:
>> > COLO was broken for QEMU release 10.0/10.1 without anyone noticed.  One
>> > reason might be that we don't have an unit test for COLO (which we
>> > explicitly require now for any new migration feature).  The other reas=
on
>> > should be that there are just no more active COLO users, at least base=
d on
>> > the latest development of QEMU.
>> >=20
>> > I don't remember seeing anything really active in the past few years in
>> > COLO development.
>> >=20
>> > Meanwhile, COLO migration framework maintainer (Hailiang Zhang)'s last
>> > email to qemu-devel is in Dec 2021 where the patch proposed an email
>> > change (<20211214075424.6920-1-zhanghailiang@xfusion.com>).
>> >=20
>> > We've discussed this for a while, see latest discussions here (our tho=
ughts
>> > of deprecating COLO framework might be earlier than that, but still):
>> >=20
>> > https://lore.kernel.org/r/aQu6bDAA7hnIPg-y@x1.local/
>> > https://lore.kernel.org/r/20251230-colo_unit_test_multifd-v1-0-f9734bc=
74c71@web.de
>> >=20
>> > Let's make it partly official and put COLO into deprecation list.  If
>> > anyone cares about COLO and is deploying it, please send an email to
>> > qemu-devel to discuss.
>> >=20
>> > Otherwise, let's try to save some energy for either maintainers or
>> > developers who is looking after QEMU. Let's save the work if we don't =
even
>> > know what the work is for.
>> >=20
>> > Cc: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>=20=20
>>=20
>> My apologize, I copied the wrong email.
>>=20
>> Cc: Lukas Straub <lukasstraub2@web.de>
>
> Nack.
>
> This code has users, as explained in my other email:
> https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/T/#mc9=
9839451d6841366619c4ec0d5af5264e2f6464

Code being useful is not enough.  We must have people to maintain it
adequately.  This has not been the case for COLO in years.

Deprecating a feature with intent to remove it is not a death sentence.
It's a *suspended* death sentence: if somebody steps up to maintain it,
we can revert the deprecation, or extend the grace period to give them a
chance.

I think we should deprecate COLO now to send a clear distress signal.
The deprecation notice should explain it doesn't work, and will be
removed unless people step up to fix it and to maintain it.  This will
ensure progress one way or the other.  Doing nothing now virtually
ensures we'll have the same discussion again later.

"Broken for two releases without anyone noticing" and "maintainer absent
for more than four years" doesn't exacltly inspire hope, though.  We
should seriously consider removing it right away.

Lukas, can you give us hope?

[...]


