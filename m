Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96F4C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 20:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTT8R-0001JP-Tb; Fri, 26 Jan 2024 15:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rTT8R-0001JA-2g
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 15:49:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rTT8O-0001Qc-VL
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 15:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706302147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+H9QhM33mS50VET8ZAmUJOqbMwvpJw7HJPJxCGLXW2k=;
 b=D2Vix6Wmi7sP4Xb8jnQyQjJn7bFQkrFA12fhhnGbU2iGdJbtUDe5d4rjwLHDWfWSzvtFCt
 AVFYFvcRvihzwhpD5B0XLex+UcxKJzesuqK1zp6C5QVsEsRNp3bi6l6vw3htQdfb2nAFWw
 aiOqg0rX92vlcGyXM7597tYWUEeUbSM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-TDdwbg3CP3qrv7n3yeR9Tw-1; Fri,
 26 Jan 2024 15:49:03 -0500
X-MC-Unique: TDdwbg3CP3qrv7n3yeR9Tw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6AB43C0F387;
 Fri, 26 Jan 2024 20:49:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E6E6900;
 Fri, 26 Jan 2024 20:49:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DF06721E66DA; Fri, 26 Jan 2024 21:49:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,  Nicholas Piggin
 <npiggin@gmail.com>,  Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  David Gibson
 <david@gibson.dropbear.id.au>,  Harsh Prateek Bora
 <harshpb@linux.ibm.com>,  qemu-ppc <qemu-ppc@nongnu.org>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: spapr watchdog vs watchdog_perform_action() / QMP
 watchdog-set-action
In-Reply-To: <CAFEAcA_KjSgt-oC=d2m6WAdqoRsUcs1W_ji7Ng2fgVjxAWLZEw@mail.gmail.com>
 (Peter Maydell's message of "Fri, 26 Jan 2024 15:23:44 +0000")
References: <CAFEAcA_KjSgt-oC=d2m6WAdqoRsUcs1W_ji7Ng2fgVjxAWLZEw@mail.gmail.com>
Date: Fri, 26 Jan 2024 21:49:00 +0100
Message-ID: <87le8byg5f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> Hi; one of the "bitesized tasks" we have listed is to convert
> watchdog timers which directly call qemu_system_reset_request() on
> watchdog timeout to call watchdog_perform_action() instead. This
> means they honour the QMP commands that let the user specifiy
> the behaviour on watchdog expiry:
> https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#qapidoc-141
> https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#qapidoc-129
> (choices include reset, power off the system, do nothing, etc).
>
> There are only a few remaining watchdogs that don't use the
> watchdog_perform_action() function. In most cases the change
> is obvious and easy: just make them do that instead of calling
> qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET).
>
> However, the hw/watchdog/spapr_watchdog.c case is trickier. As
> far as I can tell from the sources, this is a watchdog set up via
> a hypercall, and the guest makes a choice of "power off, restart,
> or dump and restart" for its on-expiry action.
>
> What should this watchdog's interaction with the watchdog-set-action
> QMP command be? If the user says "do X" and the guest says "do Y",
> which do we do? (With the current code, we always honour what
> the guest asks for and ignore what the user asks for.)

Gut reaction: when the user says "do X", the guest should not get a say.
But one of the values of X could be "whatever the guest says".

> (The bitesized task for watchdog_perform_action() is
> https://gitlab.com/qemu-project/qemu/-/issues/2124 . For the
> purposes of this email thread I'm only after a concrete decision
> about what we think the right thing is, not for any code. Then
> I can write that up in the bug for potential new contributors.)
>
> thanks
> -- PMM


