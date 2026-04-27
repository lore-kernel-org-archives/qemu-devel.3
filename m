Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F65FFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHI9O-0000zr-6x; Mon, 27 Apr 2026 05:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wHI9D-0000yf-1z
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:21:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wHI9B-0005BQ-Lh
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777281655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+t9/qqn5a2fgaCO+fo0K9uRI2dLkdIHs2PrjbLuHfwo=;
 b=VFNLd8tTV1phpT3oJ1NScv3GwUQobNiGkORHLKvIk7z4prMGDr0kOVqMTxB9ViFSLH7e/5
 cgwJ+8Fb+qWQd4kz3W9IM5G5ja3FhZimfKAAvM2x3puasZKnqNQq6aP6QTuKb+hQxXTLLK
 dunZIXxdkFKYSoLjm1MSBEjQ5PoCEFA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-2ZLmNGgrO9OrtUUyEWCPkg-1; Mon,
 27 Apr 2026 05:20:53 -0400
X-MC-Unique: 2ZLmNGgrO9OrtUUyEWCPkg-1
X-Mimecast-MFC-AGG-ID: 2ZLmNGgrO9OrtUUyEWCPkg_1777281652
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C2811956046
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 09:20:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.3])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A3343000C22
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 09:20:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EA4F921E6A28; Mon, 27 Apr 2026 11:20:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] ui/console: remove console from global list on
 finalization
In-Reply-To: <CAJ+F1CLjuWApGFeivgTywJwzORfwtbf0kjxJdmw8_vpuraJZig@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 27 Apr 2026
 12:17:48 +0400")
References: <20260422202646.272081-1-marcandre.lureau@redhat.com>
 <87eck4x35p.fsf@pond.sub.org>
 <CAJ+F1CLjuWApGFeivgTywJwzORfwtbf0kjxJdmw8_vpuraJZig@mail.gmail.com>
Date: Mon, 27 Apr 2026 11:20:49 +0200
Message-ID: <87ik9cahe6.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Fri, Apr 24, 2026 at 10:52=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>>
>> marcandre.lureau@redhat.com writes:
>>
>> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >
>> > This commit removes the QemuConsole from the global "consoles" list wh=
en
>> > it is finalized.
>> >
>> > Previously, there was a TODO comment indicating this path needed
>> > checking. The assertions added ensure that `dcls`, `gl_block`, and the
>> > `dump_queue` are empty before removal, confirming the console is in a
>> > clean state.
>> >
>> > Fix potential use-after-free crashes when a display console is removed.
>>
>> Suggest to mention reproducers: QMP command qom-list-properties with
>> typename "qemu-text-console", "qemu-fixed-text-console" or
>> "qemu-graphic-console".
>>
>> > Reported-by: Markus Armbruster <armbru@redhat.com>
>>
>> Please add
>>
>>   Cc: qemu-stable@nongnu.org
>>
>> and Fixes: if it's not too much trouble.
>>
>
> Given that the hot-unplug path is not tested and has probably not been
> working correctly since forever, I don't think we should backport it
> or look for Fixes commits.

Hmm, makes sense.  Add a suitable "careful, this is broken" comment?


