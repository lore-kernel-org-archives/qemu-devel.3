Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0247C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 09:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHJJq-0002jL-Ny; Tue, 20 May 2025 05:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHJJc-0002hE-Kl
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uHJJa-0003Ef-Rc
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747733473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bGzFT3OLvc55OwY+/GhsrDYMFu7IhjNcL0bfWAqcI9M=;
 b=hJ/Eg9Wh+/IRtcSW8AF8TpthAAuR3JR/23KL7KXHylH6l+Uuk4R7lMrL57rgH9KQ3atReJ
 MSwwta45JIHw36deYyyVYX52T16PGfYjXBr5mt90J8JiC8ls/lxvXAPBpi7o189hCg+zH8
 YZzCFkdBRVUwOn9Lvb1TwxRuNgFCo+4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-Ww8UicxxPPe6KLQ3V64ycw-1; Tue,
 20 May 2025 05:31:09 -0400
X-MC-Unique: Ww8UicxxPPe6KLQ3V64ycw-1
X-Mimecast-MFC-AGG-ID: Ww8UicxxPPe6KLQ3V64ycw_1747733467
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 205741800570; Tue, 20 May 2025 09:31:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F57D1956096; Tue, 20 May 2025 09:31:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C559A21E6757; Tue, 20 May 2025 11:31:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,  Hanna Reitz
 <hreitz@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  qemu-rust@nongnu.org,
 Maksim Davydov <davydov-max@yandex-team.ru>,  Cleber Rosa
 <crosa@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 5/8] python: convert remaining deprecated type hints for
 3.9+
In-Reply-To: <20250519182153.3835722-6-jsnow@redhat.com> (John Snow's message
 of "Mon, 19 May 2025 14:21:49 -0400")
References: <20250519182153.3835722-1-jsnow@redhat.com>
 <20250519182153.3835722-6-jsnow@redhat.com>
Date: Tue, 20 May 2025 11:31:03 +0200
Message-ID: <87r00jaaso.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> In this patch, we don't have a builtin type to use for a type hint, but
> we do have collections.abc and other standard library types. Replace
> deprecated type hints with their standard library equivalents:
>
> typing.Awaitable      => collections.abc.Awaitable
> typing.AbstractSet    => collections.abc.AbstractSet
> typing.AsyncIterator  => collections.abc.AsyncIterator
> typing.Callable       => collections.abc.Callable
> typing.Coroutine      => collections.abc.Coroutine
> typing.Deque          => collections.deque
> typing.Generator      => collections.abc.Generator
> typing.Iterable       => collections.abc.Iterable
> typing.Iterator       => collections.abc.Iterator
> typing.Mapping        => collections.abc.Mapping
> typing.Match          => re.Match
> typing.MutableMapping => collections.abc.MutableMapping
> typing.Sequence       => collections.abc.Sequence
> typing.ValuesView     => collections.abc.ValuesView
>
> The primary benefit of this is, of course, that the standard type can
> now be used directly as the type hint. In general, this means far fewer
> imports from `typing`. The reason we *have* to do this is because the
> old type hints have been deprecated and will be dropped from a Python
> release in the future, so I am just getting ahead of it before it causes
> a problem.
>
> (Granted, yes, in practice this just means we're usually importing from
> collections.abc instead of typing, but... ah well. What are you gonna
> do.)
>
> Signed-off-by: John Snow <jsnow@redhat.com>

I'd expect to catch mistakes in the manual parts.  I gave scripts/qapi/
an eye-over anyway, and it looks good to me.

Acked-by: Markus Armbruster <armbru@redhat.com>

Typing imports left at the end of the series:

    *
    Any
    BinaryIO
    Generic
    IO
    Literal
    NamedTuple
    NewType
    NoReturn
    Optional
    Protocol
    TYPE_CHECKING
    TextIO
    TypeVar
    Union
    cast

The * are in scripts/codeconverter/.  You might want to double-check
nothing deprecated hides behind the *.

The others are all still good, I presume.


