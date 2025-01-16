Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5F3C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 11:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYO2Q-0006oO-F5; Thu, 16 Jan 2025 06:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tYO2N-0006o8-NZ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:27:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tYO2L-0004OA-As
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737026861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2b3bxRJgEIXuvreXMsJikDDfxJDZXZ63jQmJzHiTMGU=;
 b=VT66nL1yIl9x0siJlDTMYB2KxEGjFgXPf8tLesN+friHIvTzHwBjCQ9ewTZZ266mjwiEwj
 SxbxZfaWHhvgouW+H2Eej3yep3wKvfA4bojMIAKiEpfWe3onY8SAhlfl5iGPDlU4WYQZ2f
 V9rYfXgR2xWCFciY1gAYNPCpCIlMjTQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-chiCCYOHPkKldWgi1CoN7g-1; Thu,
 16 Jan 2025 06:27:38 -0500
X-MC-Unique: chiCCYOHPkKldWgi1CoN7g-1
X-Mimecast-MFC-AGG-ID: chiCCYOHPkKldWgi1CoN7g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BCAB1955E7B; Thu, 16 Jan 2025 11:27:37 +0000 (UTC)
Received: from redhat.com (unknown [10.39.196.38])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 256AC19560AA; Thu, 16 Jan 2025 11:27:34 +0000 (UTC)
Date: Thu, 16 Jan 2025 12:27:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 6/8] chardev/char-mux: implement backend chardev
 multiplexing
Message-ID: <Z4jtJMNeXexEEpVZ@redhat.com>
References: <20241016102605.459395-1-r.peniaev@gmail.com>
 <20241016102605.459395-7-r.peniaev@gmail.com>
 <CAJ+F1CLkn2WcmJEmNpJwNcc5VPriDTdSFWcv44QWaYtvHycKcQ@mail.gmail.com>
 <87frmuwo6p.fsf@pond.sub.org>
 <CACZ9PQUk7ZjwfYWVNq3z2Wp_pnkKO8ObhLc6uy5ABHq2yCL9Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACZ9PQUk7ZjwfYWVNq3z2Wp_pnkKO8ObhLc6uy5ABHq2yCL9Ag@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 17.12.2024 um 11:32 hat Roman Penyaev geschrieben:
> Hi Markus,
> 
> Thanks for the explicit info. But I have a lot to ask :)
> Do I understand correctly that there are two ways to parse
> arguments: classic, via qemu_opts_parse_noisily() and modern, via
> qobject_input_visitor_new_str()? (for example, I look in
> net/net.c, netdev_parse_modern()). My goal is not to create a
> completely new option, but to add (extend) parameters for
> chardev, namely to add a new type of backend device. This
> complicates everything, since chardev uses
> qemu_opts_parse_noisily() for parsing and bypasses the modern
> way (I hope I'm not mistaken, maybe Marc can comment). And I'm
> not sure that it's easy to replace the classic way of parsing
> arguments with the modern way without breaking anything.

A few years ago, I tried to unify the QMP and CLI code paths for
creating chardevs and this involved using QAPI for everything. As far as
I can remember, chardevs don't use any of the QemuOpts features that
don't exist in they keyval parser, so it's easy from that angle.

What makes it more complicated is that CLI and QMP options have diverged
quite a bit, and while generally the same functionality is available, it
sometimes uses different names or is negated in one compared to the
other etc.

So I ended up writing compatibility code that translated legacy CLI
options into QAPI-compatible ones, and then I could use the exising QAPI
types. Part of it made use of aliases, which would have been a new
feature in QAPI, but Markus didn't like them in the end. They could have
been replaced by manual conversion code, but I didn't have time (nor, to
be honest, motivation) to work it any more when Markus had finally made
that decision. It shouldn't actually be very hard.

Anyway, if it's of any use for you, feel free to resurrect parts of it:

https://repo.or.cz/qemu/kevin.git/shortlog/refs/tags/qapi-alias-chardev-v4

(Or maybe I will eventually...)

Whatever you choose to do, my one request for you would be that you
really make sure that CLI and QMP are structured and behave exactly the
same with your new option, to avoid making the problem worse than it
already is.

Kevin


