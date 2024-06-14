Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB97C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI36Y-0002q8-3l; Fri, 14 Jun 2024 05:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sI36U-0002nv-7o
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sI36R-0004gp-NU
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718356809;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NCtOsNZieavbs1pVxCvKvSIZAsFBptq9jrNJsGSgPdI=;
 b=RNL5mczOLb79BFZRgdmo06IshTEuOOSDMMBnMqRUmeFlO9fYaCh/epfsssksKt9JBHNu97
 0mNDg/M2JHyKDNW7iwvw9PMJZ6r7bMTmHquVoSiN6GMdNKreOUEQ3Rvsw8tkSgBb3JiMNT
 QID+Y0Wbru+18NbwB1An1HJ00QDcs/8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-btPFw6kbPUuom-9zPzo8RQ-1; Fri,
 14 Jun 2024 05:20:06 -0400
X-MC-Unique: btPFw6kbPUuom-9zPzo8RQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 822F41956070; Fri, 14 Jun 2024 09:20:05 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.248])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 010591956087; Fri, 14 Jun 2024 09:20:01 +0000 (UTC)
Date: Fri, 14 Jun 2024 10:19:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 00/22] qga: clean up command source locations and
 conditionals
Message-ID: <ZmwLPg9DtEmCHMAl@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <CAJ+F1CJ49ojg1uNL_dsrSxJDSuRJiwmeK3Y5W1qK1GiNo_+S8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CJ49ojg1uNL_dsrSxJDSuRJiwmeK3Y5W1qK1GiNo_+S8A@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jun 14, 2024 at 12:34:52PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jun 13, 2024 at 7:02 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > This series is a side effect of other work I started, to attempt to
> > make the QGA safe to use in confidential VMs by automatically
> > restricting the permitted commands. Since this cleanup stands on
> > its own, I'm sending it now.
> >
> > The QGA codebase has a very complicated maze of #ifdefs to create
> > stubs for the various commands that cannot be implemented on certain
> > platforms. It then has further logic to dynamically disable the stub
> > commands at runtime, except this is not consistently applied, so
> > some commands remain enabled despite being merely stubs.
> >
> > The resulting code is hard to follow, when trying to understand exactly
> > what commands are available under what circumstances, and when changing
> > impls it is easy to get the #ifdefs wrong, resulting in stubs getting
> > missed on platforms without a real impl. In some cases, we have multiple
> > stubs for the same command, due to the maze of #ifdefs.
> >
> > The QAPI schema language has support for many years for expressing
> > conditions against commands when declaring them. This results in the
> > QAPI code generator omitting their implementation entirely at build
> > time. This has mutliple benefits
> >
> >  * The unsupported commands are guaranteed to not exist at runtime
> >  * No stubs need ever be defined in the code
> >  * The generated QAPI reference manual documents the build conditions
> >
> > This series is broadly split into three parts
> >
> >  * Moving tonnes of Linux only commands out of commands-posix.c
> >    into commands-linux.c to remove many #ifdefs.
> >  * Adding 'if' conditions in the QAPI schema to reflect the
> >    build conditions, removing many more #ifdefs
> >  * Sanitizing the logic for disabling/enabling commands at
> >    runtime to guarantee consistency
> >
> > Changed in v2:
> >
> >  - Make FSFreeze error reporting distinguish inability to enable
> >    VSS from user config choice
> >
> >  - Fully remove ga_command_init_blockedrpcs() methods. No more
> >    special case disabling of commands. Either they're disabled
> >    at build time, or disabled by user config, or by well defined
> >    rule ie not permitted during FS freeze.
> >
> >  - Apply rules later in startup to avoid crash from NULL config
> >    pointer
> >
> >  - Document changed error messages in commit messages
> >
> >  - Add -c / --config command line parameter
> >
> >  - Fix mistaken enabling of fsfreeze hooks on win32
> >
> >  - Remove pointless 'blockrpcs_key' variable
> >
> >  - Allow concurrent setting of allow and block lists for
> >    RPC commands
> >
> > Daniel P. Berrangé (22):
> >   qga: drop blocking of guest-get-memory-block-size command
> >   qga: move linux vcpu command impls to commands-linux.c
> >   qga: move linux suspend command impls to commands-linux.c
> >   qga: move linux fs/disk command impls to commands-linux.c
> >   qga: move linux disk/cpu stats command impls to commands-linux.c
> >   qga: move linux memory block command impls to commands-linux.c
> >   qga: move CONFIG_FSFREEZE/TRIM to be meson defined options
> >   qga: conditionalize schema for commands unsupported on Windows
> >   qga: conditionalize schema for commands unsupported on non-Linux POSIX
> >   qga: conditionalize schema for commands requiring getifaddrs
> >   qga: conditionalize schema for commands requiring linux/win32
> >   qga: conditionalize schema for commands only supported on Windows
> >   qga: conditionalize schema for commands requiring fsfreeze
> >   qga: conditionalize schema for commands requiring fstrim
> >   qga: conditionalize schema for commands requiring libudev
> >   qga: conditionalize schema for commands requiring utmpx
> >   qga: conditionalize schema for commands not supported on other UNIX
> >   qga: don't disable fsfreeze commands if vss_init fails
> >   qga: move declare of QGAConfig struct to top of file
> >   qga: remove pointless 'blockrpcs_key' variable
> >   qga: allow configuration file path via the cli
> >   qga: centralize logic for disabling/enabling commands
> >
> >
> Something broke patchew handling:
> https://patchew.org/QEMU/20240613150127.1361931-1-berrange@redhat.com/20240613154406.1365469-1-berrange@redhat.com/

gmail refused further mail delivery from me part way through sending
the series, so I had to send the 2nd half of it separately.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


