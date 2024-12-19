Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC53DE7718D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGm-0003XS-KG; Thu, 19 Dec 2024 11:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tOGqa-0006nq-2E
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 08:45:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tOGqV-0000jT-LR
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 08:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734615941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ExwIMgJ1cBPcwLGS7BB5z8KM86fahDUfuV9T5nAx34=;
 b=cWjmjJICg+Vl2rmttpYH+qUcRhKpUHcM7Q9D7m04AsuUR46y1m4yOO9YIC3Ia+Ex1U84Ur
 NsmZakeh3Yivsp2X+A70wlEKti3oYW2BO1tNaecBO07xceAqy4spEMfN4BIRQcOnAAcNMS
 WqZneGNaEzM0NOT5cpDWa0ZZhLbI/ls=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-AVyztpssOGydqfAGK8KiYg-1; Thu,
 19 Dec 2024 08:45:39 -0500
X-MC-Unique: AVyztpssOGydqfAGK8KiYg-1
X-Mimecast-MFC-AGG-ID: AVyztpssOGydqfAGK8KiYg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B40319560B5; Thu, 19 Dec 2024 13:45:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.27])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A7CC19560AD; Thu, 19 Dec 2024 13:45:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 057E921E6740; Thu, 19 Dec 2024 14:45:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 6/8] chardev/char-mux: implement backend chardev
 multiplexing
In-Reply-To: <CACZ9PQUk7ZjwfYWVNq3z2Wp_pnkKO8ObhLc6uy5ABHq2yCL9Ag@mail.gmail.com>
 (Roman Penyaev's message of "Tue, 17 Dec 2024 11:32:46 +0100")
References: <20241016102605.459395-1-r.peniaev@gmail.com>
 <20241016102605.459395-7-r.peniaev@gmail.com>
 <CAJ+F1CLkn2WcmJEmNpJwNcc5VPriDTdSFWcv44QWaYtvHycKcQ@mail.gmail.com>
 <87frmuwo6p.fsf@pond.sub.org>
 <CACZ9PQUk7ZjwfYWVNq3z2Wp_pnkKO8ObhLc6uy5ABHq2yCL9Ag@mail.gmail.com>
Date: Thu, 19 Dec 2024 14:45:36 +0100
Message-ID: <87ed23iy67.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Roman Penyaev <r.peniaev@gmail.com> writes:

> Hi Markus,
>
> Thanks for the explicit info. But I have a lot to ask :)
> Do I understand correctly that there are two ways to parse
> arguments: classic, via qemu_opts_parse_noisily() and modern, via
> qobject_input_visitor_new_str()?

Three, to be honest:

* QemuOpts, commonly with qemu_opts_parse_noisily()

* QAPI, commonly with qobject_input_visitor_new_str()

* Ad hoc parsers (you don't wan't to know more)

>                                  (for example, I look in
> net/net.c, netdev_parse_modern()). My goal is not to create a
> completely new option, but to add (extend) parameters for
> chardev, namely to add a new type of backend device. This
> complicates everything, since chardev uses
> qemu_opts_parse_noisily() for parsing and bypasses the modern
> way (I hope I'm not mistaken, maybe Marc can comment). And I'm
> not sure that it's easy to replace the classic way of parsing
> arguments with the modern way without breaking anything.

It's not easy.

The main difficulty is assessing compatibility breaks, and whether they
matter.

>                                                          I can,
> of course, be wrong, but if I understand correctly, util/keyval.c
> does not work with QemuOpts,

Correct.

>                              and the entire char/* is very much
> tied to this classic way of getting arguments.

In the beginning, there was the command line (CLI), and then the human
monitor (HMP).

As CLI options and HMP commands were implemented with QemuOpts, the
underlying internal interfaces tended to be adjusted to take QemuOpts
arguments.

Then there was QMP, and then there was QAPI.  As QMP commands were
implemented with QAPI, the underlying internal interfaces tended to be
adjusted to take generated QAPI type arguments.

This got us two internal interfaces doing the same thing.  To not have
two implementations, one interface needs to wrap around the other.
Wrapping the QemuOpts one around the QAPI one is more sane.

Have a look at qmp_chardev_add() and hmp_chardev_add().

qmp_chardev_add() wraps around chardev_new(), which takes QAPI type
ChardevBackend.

hmp_chardev_add() wraps around qemu_chr_new_from_opts(), which wraps
around do_qemu_chr_new_from_opts(), which wraps around
qemu_chardev_new(), which wraps around chardev_new().  CLI -chardev
works the same way.

So...  Yes, at some point the entire chardev/ was very much tied to
QemuOpts.  By now, its core *should* be untied from it.  There *may* be
remnants of the old way that still need to be untied.

>                                                Is there a
> transitional way to parse the arguments? Use the modern way, but
> still represent the arguments as QemuOpts?

You could convert manually from QAPI to QemuOpts, but that would be a
mistake.  We know, because we made the mistake with device_add and
netdev_add.  Fixing the mistake for netdev_add was painful (see commit
db2a380c84574d8c76d7193b8af8535234fe5156 (net: Complete qapi-fication of
netdev_add)).  device_add remains unfixed, which has been a source of
trouble.


