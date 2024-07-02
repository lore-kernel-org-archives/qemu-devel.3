Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78120C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 18:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOho4-0002Kw-3s; Tue, 02 Jul 2024 14:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sOhny-0002KI-P1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sOhnp-0003dL-9H
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719943225;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qJSikkv+EJR5AFlo8UVY8nknqzLQr5dmmgUrhJbseU8=;
 b=TVoUsIQSQxprA/7bRcf0ckfZIvVpR5XYYgKn5OTWOVLyvtZpYsFq8++KXbgf/56gcU+88Q
 Z2fF9s6vaLXxoTQAeViTpmF9yRgAasgt/aVHiTgyJ8kyUczXCRnRfgJnVXATHnrrglZw+0
 O/OGWO2SFdFtZawdG+4bFzNtBeOIfFQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-nUg9zQKtNnSeBYDelTlc2g-1; Tue,
 02 Jul 2024 14:00:24 -0400
X-MC-Unique: nUg9zQKtNnSeBYDelTlc2g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED23B1945117; Tue,  2 Jul 2024 18:00:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.33])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80BDA19560AD; Tue,  2 Jul 2024 18:00:20 +0000 (UTC)
Date: Tue, 2 Jul 2024 19:00:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/22] qga: clean up command source locations and
 conditionals
Message-ID: <ZoRAMXeKDObGnl4h@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240613150127.1361931-1-berrange@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ping: for any review comments from QGA maintainers ?

On Thu, Jun 13, 2024 at 04:01:05PM +0100, Daniel P. Berrangé wrote:
> This series is a side effect of other work I started, to attempt to
> make the QGA safe to use in confidential VMs by automatically
> restricting the permitted commands. Since this cleanup stands on
> its own, I'm sending it now.
> 
> The QGA codebase has a very complicated maze of #ifdefs to create
> stubs for the various commands that cannot be implemented on certain
> platforms. It then has further logic to dynamically disable the stub
> commands at runtime, except this is not consistently applied, so
> some commands remain enabled despite being merely stubs.
> 
> The resulting code is hard to follow, when trying to understand exactly
> what commands are available under what circumstances, and when changing
> impls it is easy to get the #ifdefs wrong, resulting in stubs getting
> missed on platforms without a real impl. In some cases, we have multiple
> stubs for the same command, due to the maze of #ifdefs.
> 
> The QAPI schema language has support for many years for expressing
> conditions against commands when declaring them. This results in the
> QAPI code generator omitting their implementation entirely at build
> time. This has mutliple benefits
> 
>  * The unsupported commands are guaranteed to not exist at runtime
>  * No stubs need ever be defined in the code
>  * The generated QAPI reference manual documents the build conditions
> 
> This series is broadly split into three parts
> 
>  * Moving tonnes of Linux only commands out of commands-posix.c
>    into commands-linux.c to remove many #ifdefs.
>  * Adding 'if' conditions in the QAPI schema to reflect the
>    build conditions, removing many more #ifdefs
>  * Sanitizing the logic for disabling/enabling commands at
>    runtime to guarantee consistency
> 
> Changed in v2:
> 
>  - Make FSFreeze error reporting distinguish inability to enable
>    VSS from user config choice
> 
>  - Fully remove ga_command_init_blockedrpcs() methods. No more
>    special case disabling of commands. Either they're disabled
>    at build time, or disabled by user config, or by well defined
>    rule ie not permitted during FS freeze.
> 
>  - Apply rules later in startup to avoid crash from NULL config
>    pointer
> 
>  - Document changed error messages in commit messages
> 
>  - Add -c / --config command line parameter
> 
>  - Fix mistaken enabling of fsfreeze hooks on win32
> 
>  - Remove pointless 'blockrpcs_key' variable
> 
>  - Allow concurrent setting of allow and block lists for
>    RPC commands
> 
> Daniel P. Berrangé (22):
>   qga: drop blocking of guest-get-memory-block-size command
>   qga: move linux vcpu command impls to commands-linux.c
>   qga: move linux suspend command impls to commands-linux.c
>   qga: move linux fs/disk command impls to commands-linux.c
>   qga: move linux disk/cpu stats command impls to commands-linux.c
>   qga: move linux memory block command impls to commands-linux.c
>   qga: move CONFIG_FSFREEZE/TRIM to be meson defined options
>   qga: conditionalize schema for commands unsupported on Windows
>   qga: conditionalize schema for commands unsupported on non-Linux POSIX
>   qga: conditionalize schema for commands requiring getifaddrs
>   qga: conditionalize schema for commands requiring linux/win32
>   qga: conditionalize schema for commands only supported on Windows
>   qga: conditionalize schema for commands requiring fsfreeze
>   qga: conditionalize schema for commands requiring fstrim
>   qga: conditionalize schema for commands requiring libudev
>   qga: conditionalize schema for commands requiring utmpx
>   qga: conditionalize schema for commands not supported on other UNIX
>   qga: don't disable fsfreeze commands if vss_init fails
>   qga: move declare of QGAConfig struct to top of file
>   qga: remove pointless 'blockrpcs_key' variable
>   qga: allow configuration file path via the cli
>   qga: centralize logic for disabling/enabling commands
> 
>  docs/interop/qemu-ga.rst |   19 +
>  meson.build              |   16 +
>  qga/commands-bsd.c       |   24 -
>  qga/commands-common.h    |    9 -
>  qga/commands-linux.c     | 1805 +++++++++++++++++++++++++++++
>  qga/commands-posix.c     | 2373 +++-----------------------------------
>  qga/commands-win32.c     |   78 +-
>  qga/main.c               |  216 ++--
>  qga/qapi-schema.json     |  153 ++-
>  9 files changed, 2234 insertions(+), 2459 deletions(-)
> 
> -- 
> 2.45.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


