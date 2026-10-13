Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AC4CC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGd0P-00013L-MT; Tue, 13 Oct 2026 09:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xGd0N-00011j-Rx
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xGd0M-0000KB-2y
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791899841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yb7H2h6+FxnbZhJJ9xVz8kNfPT7ICXA9vEaPrEb7+Bg=;
 b=fW7iTl5neQSzmlR/+3tKXuuQtAnjLDY7iN/9Y9zX63aGZEd+49guunGH8cHIhVf+HMzVsx
 VUvPdPDFNLYxjKjUz4wy4av+YcJ05Dj7u/z38J1SkEQaZgBcPM6YDj8yDgVccfV6zm1t+m
 wBKDoCb0UFb/IFLsQW3lkfGQi2/t/FY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-bYYl86CpOoulKCsJWez68Q-1; Tue,
 13 Oct 2026 13:57:19 +0000
X-MC-Unique: bYYl86CpOoulKCsJWez68Q-1
X-Mimecast-MFC-AGG-ID: bYYl86CpOoulKCsJWez68Q_1791899838
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D005195FD00; Tue, 13 Oct 2026 13:57:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A58430000E6; Tue, 13 Oct 2026 13:57:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1E26C21E6A04; Tue, 13 Oct 2026 15:57:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  jsnow@redhat.com
Subject: Re: [RFC PATCH 0/6] qapi: Preliminary work for better QOM
 introspection
In-Reply-To: <CAJ+F1CKqDbV0xVkL6Q_++qHk4iNstWC_y2raPXy8BovUyPQzdQ@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 9 Oct 2026
 18:57:54 +0400")
References: <20261009140431.3175479-1-armbru@redhat.com>
 <CAJ+F1CKqDbV0xVkL6Q_++qHk4iNstWC_y2raPXy8BovUyPQzdQ@mail.gmail.com>
Date: Tue, 13 Oct 2026 15:57:16 +0200
Message-ID: <871p9tya83.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi Markus
>
> On Fri, Oct 9, 2026 at 6:05=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
>>
>> Marc-Andr=C3=A9 Lureau has patches to improve QOM introspection.  Latest
>> version is
>>
>>     Subject: [PATCH v5 00/62] qom/qdev: associate properties with QAPI s=
chema types
>>     Date: Fri, 11 Sep 2026 20:34:34 +0400
>>     Message-Id: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
>>     https://lore.kernel.org/qemu-devel/20260911-qom-qapi-v5-0-7732a55b77=
60@redhat.com/
>>
>> The first few patches make the QAPI code generator emit type
>> information for use by QOM introspection commands.  They refactor code
>> to gain access to masked type names, and to make query-qmp-schema not
>> elide types QOM introspection might want to refer to.
>>
>> My series does this in a different way I find simpler.  It is RFC
>> because merging it only makes sense if Marc-Andr=C3=A9 finds it useful.
>> Marc-Andr=C3=A9, please have a look.
>
> This is essentially doing the same introspection changes but at a
> different level. If you ask me, since it's essentially code cleanup at
> this point, I would rather merge my changes first and iterate on top.
> But you are the gate keeper, so I wouldn't hold it, we need to move
> on... I can rebase on top of your refactoring if you prefer.

A rebase gives me a cleaner git history, which I like.  Asking you to do
it feels a bit unfair, so I did it:

    https://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/qom-props-qapi-t=
ypes-v5-rebased

I had to change "qapi: add type-infos generator" quite a bit (commit
465ae98da2).  Slightly simpler now.

I resolved a rebase conflict in "qom: convert scalar properties to
QAPI-aware registration".

I dropped "qapi: expose integer signedness and width in introspection"
because I don't agree with it, and couldn't be bothered to resolve the
conflict (iirc).

I dropped "qapi: select introspectable types directly", because it's not
needed anymore.


