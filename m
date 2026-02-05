Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35429ECD983
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 16:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo2AT-0004Qg-No; Thu, 05 Feb 2026 11:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vo2AS-0004QA-2e
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:25:20 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vo2AQ-0005b7-EG
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:25:19 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b8849dc12f6so155667866b.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 08:25:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770308716; cv=none;
 d=google.com; s=arc-20240605;
 b=eMsJgrbPSdVOjYxGXinaniZu0FG4HxGyJYr47AY320kS9pFi6r01AuMCf6OEV1hlBd
 4NKQayp6rtW2N0DUaRuyoHUgcbNuXnk4l3xdxR4pq4GrjnBzZ/W0Dl/f3bT6zA55Z3j1
 Mza5wzb1NCJDrtxpJdJgIfiDgKbLHd7tgo9VBhiPtgO3DYeL6XyzzYx6lNo2sxwlvi30
 0METJDpaZsSk+WyuKdUu7en+0B7jCjZ/5dYN8popfEOtg/1O6rD4KW6lUV2bkXK+JlaI
 L0XPMwAc5DLAWT7ArrnoG6pQlhY4SHsfteN8TE2FBacMHIGOD0eoZYiwrhNEum6Ztznu
 wr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JR6njBaN+z8DpCDpqa/umI0znnbAP+7x9tdYmtKQ5gY=;
 fh=30rw4qnSN8oaVlmU4JTRQtGnXmvUslDYe6VJB4BfjUg=;
 b=VQx0KcWDEdEZe9a2bD+bZfM4mWCIG62fZJNC+33L5+IkAe28IlQk7PGKX7/E/kHj6O
 8VXd+dPLw9bv1Ae7pWvN5fVDpaQlrwFaqX8n/8tDRnOOKRcRm59wfSuxcQQxdOd0128t
 /8Dno36fORTSNliNcX9mrgUb6Q0GAhFlq730OLhRatwvq3oLsWG+o10yLfnQxxF9cSMW
 AvufQJknwEwEx3h66X7WrqLMNr0Sc/Ike21PBAqyJ/Yl6k9Ur/CapuwZJn70tdny2s2y
 GAzjWqX1BwCdX07Tu21nXFqoJCDNdNdjHZUBQ86LYVGGMjsK01JGDrDulnIKLKCc9DTb
 GQeA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770308716; x=1770913516; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JR6njBaN+z8DpCDpqa/umI0znnbAP+7x9tdYmtKQ5gY=;
 b=eeyjtKUjoldw08xW1zGcAlxdARB/PE228k5HnY0imRwxJibDQBiR99yTKlxk/I4Ryq
 XyvJAGVjYVwXWz0lk0PcJ8doByyNG2z2bvqm33moDQ+vJ4uxFlhS1p8ckSGT68muYZxG
 v+5A7ORVThGlNHeaw+QYBpZ2VpLPerMr0qOZvx2ojNl4pL206riFxC6lpLC8Tnda2fum
 tszNB0lZkVgUFWdvIGxGW1+A/iizjFV8Pl8c0mPEbsacEnTvSS2E3D5rRFcr0yrKRueI
 3/70sGDq/V7oFKW/G00UBH7NAJWciUa85uDhHGR+VYcHf3pQs+JW/ItuLuVQruaXCv7v
 2YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770308716; x=1770913516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JR6njBaN+z8DpCDpqa/umI0znnbAP+7x9tdYmtKQ5gY=;
 b=bU7LOw90lovFejUnOTcoIKYaYmlUQpi5JRgod3Yr5pQnMcGlRKHY0LFVhsiGgQ7r+J
 ekYvCEZm4vbgQFK18KgSjyCNI4Q9AWRUH7glLERVOydPkemJAOU/MYFgdu71uVvoM4jS
 TcTmY5f0f0cJOKOZVc9JkPrAOlBNygQ72qYQD35hiqnufN59ZanX/ixreRtuV/d26aZ8
 y/8E6PQ5OnKcOxxgJ4zdyBNsK0aOLAK4pFpyJWeVrHkwcGN3bCs8WLJD9DEKP+RPcsEa
 wCraJYu/OQra6SuKRiQJpTlG3gLW39AfWGf4TR9Ks11e3GhN8adl9cQbeQwO0TuJO0g5
 BRSA==
X-Gm-Message-State: AOJu0YwR9ysD3YTkgt/i6/c8IPXu2g86O7j6HKOPzShHXF4tfaBcFx//
 xWd0Wq852s1UwXz/9uWoMGct+dLgFfcCf699b5rcULbuPgGjQ4A+ImU5Eb7UF+hh6mlPW5csIRm
 bD2Idu1SPum+YE+AOdcrevAbJ6CGzEZg=
X-Gm-Gg: AZuq6aJxaCddNZ4Sdd+bz4S/ilK6Y7WFBtw08IDZEmqzbyhuPJzfVOoNaGRTALNTQ9M
 MI9FjitG9JnlW23jVG5AtWgd0tMhbqpMAcydpoTAs3MnZTCzURc9aG9ukdLKHvMqw2oH47WtqX4
 34IwrfUpQkCSzl4yQDuamgSiM7rYaMq0IIJMI7rgcppwiWTFV9ngGGSHtgFFQpb5oBJD06iteQT
 kODmZ1Gv3b/bk1WywDMQxeQ3Xy1F7mwGhHGL94mibgHNr+u3hZ82UTGjw6EU+wOYjWEJQnQBu+X
 Mald
X-Received: by 2002:a17:907:3ea6:b0:b87:9d1d:ec6b with SMTP id
 a640c23a62f3a-b8e9ec21bb9mr449954766b.0.1770308715473; Thu, 05 Feb 2026
 08:25:15 -0800 (PST)
MIME-Version: 1.0
References: <20260126094422.23116-1-zhangckid@gmail.com>
 <20260126094422.23116-3-zhangckid@gmail.com>
In-Reply-To: <20260126094422.23116-3-zhangckid@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 5 Feb 2026 11:25:02 -0500
X-Gm-Features: AZwV_QjcPkvMUAuISXoSIMczAwRocnfb6YOBgVWR2n5hooWISGzVrcDDgemW9Y4
Message-ID: <CAJSP0QWRNwXGgC4ZGMpkD=LQ27DeD7BybEqsKkRr7zrnw+ZhDQ@mail.gmail.com>
Subject: Re: [RESEND PATCH V3 3/3] qapi: Add attached flag for iothread
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 26, 2026 at 4:52=E2=80=AFAM Zhang Chen <zhangckid@gmail.com> wr=
ote:
>
> The attached flag depends on struct IOThreadInfo's
> 'attached': 'bool'. It can show whether the iothread
> is attached to an actual device. Show in the qmp/hmp
> CMD with "attached": true/false.

I mentioned that a ref/unref API is needed in my reply to Patch 2/3.
The API could look like:

void iothread_ref(IOThread *iothread, const char *holder);

And the holder string is added to a list inside iothread. That way the
monitor commands can report an actual list of holders rather than just
true/false:

  attached =3D ["/qom/path/to/virtio-blk-0", "/qom/path/to/block/export/nbd=
-0"]

The QOM path would be a useful string to use as a unique identifier.

>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  iothread.c         |  1 +
>  monitor/hmp-cmds.c |  2 ++
>  qapi/misc.json     | 12 ++++++++++++
>  3 files changed, 15 insertions(+)
>
> diff --git a/iothread.c b/iothread.c
> index 38e38fb44d..fb4898e491 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -358,6 +358,7 @@ static int query_one_iothread(Object *object, void *o=
paque)
>      info =3D g_new0(IOThreadInfo, 1);
>      info->id =3D iothread_get_id(iothread);
>      info->thread_id =3D iothread->thread_id;
> +    info->attached =3D iothread->attached;
>      info->poll_max_ns =3D iothread->poll_max_ns;
>      info->poll_grow =3D iothread->poll_grow;
>      info->poll_shrink =3D iothread->poll_shrink;
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 5a673cddb2..7463f34bf5 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -202,6 +202,8 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qd=
ict)
>          value =3D info->value;
>          monitor_printf(mon, "%s:\n", value->id);
>          monitor_printf(mon, "  thread_id=3D%" PRId64 "\n", value->thread=
_id);
> +        monitor_printf(mon, "  attached=3D%s" "\n",
> +                       value->attached ? "true" : "false");
>          monitor_printf(mon, "  poll-max-ns=3D%" PRId64 "\n", value->poll=
_max_ns);
>          monitor_printf(mon, "  poll-grow=3D%" PRId64 "\n", value->poll_g=
row);
>          monitor_printf(mon, "  poll-shrink=3D%" PRId64 "\n", value->poll=
_shrink);
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 1f5062df2a..cb865d6e48 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -76,6 +76,15 @@
>  #
>  # @thread-id: ID of the underlying host thread
>  #
> +# @attached: The attached parameter is a flag indicating whether
> +#     the IOThread is currently associated with an active device
> +#     (e.g., virtio-blk).  In hotplug scenarios, users can
> +#     pre-allocate multiple iothread objects to serve as a persistent
> +#     thread pool.  When a device is hot-unplugged, the corresponding
> +#     IOThread is released but remains available, allowing subsequent
> +#     hot-plugged devices to attach to and reuse the existing thread.
> +#     (since 12.0)

How is this supposed to work since Patch 2 does not support hot unplug
(attached remains true)?

I'm also curious what the use case for this property is. First I
thought it's for debugging, but based on this documentation it sounds
like maybe you want to use it to avoid having to keep track of which
IOThreads are used in a management tool?

> +#
>  # @poll-max-ns: maximum polling time in ns, 0 means polling is
>  #     disabled (since 2.9)
>  #
> @@ -93,6 +102,7 @@
>  { 'struct': 'IOThreadInfo',
>    'data': {'id': 'str',
>             'thread-id': 'int',
> +           'attached': 'bool',
>             'poll-max-ns': 'int',
>             'poll-grow': 'int',
>             'poll-shrink': 'int',
> @@ -118,6 +128,7 @@
>  #              {
>  #                 "id":"iothread0",
>  #                 "thread-id":3134,
> +#                 "attached":false,
>  #                 "poll-max-ns":32768,
>  #                 "poll-grow":0,
>  #                 "poll-shrink":0,
> @@ -126,6 +137,7 @@
>  #              {
>  #                 "id":"iothread1",
>  #                 "thread-id":3135,
> +#                 "attached":true,
>  #                 "poll-max-ns":32768,
>  #                 "poll-grow":0,
>  #                 "poll-shrink":0,
> --
> 2.49.0
>
>

