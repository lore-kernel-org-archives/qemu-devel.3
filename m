Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD211C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 18:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOhww-000731-3i; Tue, 02 Jul 2024 14:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sOhwu-00072h-AO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sOhwo-0008Ll-N9
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 14:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719943784;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5bK1y9btdKaDVmoH6IKo493R+ffO59OwI6Xk+BjOKo=;
 b=BWUkPffP9Jhf4vOnADxDjIX59IQdGFuUu5i65Zi6eHWHbI+JBy+MK7j0fV5YxRzZxWeY9C
 /Z2y3/Vb6QXG9f7Mc0p5CITTvIXUJ6pVrMfysJVqGlG+ZrDz3VPzBH3jr8AtFe31C1qMP2
 2NlJkGuLHhUDA7lNrb749Q65fXc4Qis=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-LaLUQExGN9ax6JxoiW3Eyw-1; Tue,
 02 Jul 2024 14:09:40 -0400
X-MC-Unique: LaLUQExGN9ax6JxoiW3Eyw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B6F31944D05; Tue,  2 Jul 2024 18:09:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.33])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 923621956089; Tue,  2 Jul 2024 18:09:37 +0000 (UTC)
Date: Tue, 2 Jul 2024 19:09:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH 00/14] Improve mechanism for configuring allowed commands
Message-ID: <ZoRCXdfu4Dbdzgbj@redhat.com>
References: <20240604153242.251334-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240604153242.251334-1-berrange@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Ping: any review comments from QGA maintainers ?

On Tue, Jun 04, 2024 at 04:32:28PM +0100, Daniel P. Berrangé wrote:
> The QGA supports dynamically filtering what commands are enabled via a
> combination of allow lists and deny lists. This is very flexible, but
> at the same time very fragile.
> 
> Consider that a user wants to block all commands that allow unrestricted
> file access/command execution, so they set the deny list when starting
> QGA. Now their OS vendor issues a software update which includes a new
> version of QGA. This new QGA version is liable to contain new commands,
> some of which might undermine the intent of the user's configured deny
> list.
> 
> IOW, the generic deny list functionality is inherently dangerous as a
> mechanism for limiting risk exposure.
> 
> Using an allow list is much safer, but means on every update the user
> should check the list of new commands to decide which are safe or not,
> putting a burden on every user.
> 
> In the context of RHEL, there has been a long term deny list that blocks
> use of guest-file and guest-exec commands, since they give unrestricted
> access to the guest.
> 
> With the advent of confidential computing, a far greater number of QGA
> commands are very unsafe to permit, and it is unreasonable to expect
> each user and/or downstream vendor to repeat the work to figure out
> what commands are OK.
> 
> This is a similar problem seen in the "seccomp" world where new syscalls
> appear frequently and users can't be expected to understand all of them.
> Systemd pioneered the approach of defining "profiles"  which group
> together sets of syscalls, which we subsequently copied in QEMU.
> 
> This series applies this same conceptual idea to QGA command filtering,
> making use of the QAPI "features" facility to associate commands into
> one or more groups.
> 
> This grouping is then exposed via some new higher level command line
> arguments.
> 
> * --no-unrestricted / -u
> 
>   A flag to block all the guest-file and guest-exec commands
> 
>   This replicates the policy RHEL currently defines via a deny list.
> 
> * --no-user-auth / -e
> 
>   A flag to block all the commands for manipulating user account
>   authentication credentials.
> 
> * --confidential / -i
> 
>   A flag to block all commands, except for those which have been
>   explicitly marked as not violating guest owner data privacy
> 
> This feature mechanism is further utilized internally to track the
> commands which are safe to use while FS are frozen.
> 
> A key benefit of using the QAPI "features" facility is that these
> groupings are visible in the documentation of the QGA commands.
> 
> By using these high level command lines arguments, deployments will
> be safe wrt software upgrades, as long as QEMU maintainers apply
> appropriate tags to any new commands.
> 
> The allow/deny list command line flags can still be used to further
> refine the command lines, but ideally that would be rare.
> 
> A missing piece in this series is getting the --confidential flag to
> be automatically passed to QGA when running in a confidential VM. This
> is something that will likely be done via systemd unit files. My thought
> is that the existing 'qemu-guest-agent.service' would get a parameter
> 
>    ConditionSecurity=!cvm
> 
> while a new qemu-guest-agent-confidential.service' would have the same
> content but with ConditionSecurity=cvm instead, and would pass the
> --confidential flag.
> 
> This series depends on the one I sent earlier:
> 
>   https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg00743.html
> 
> Daniel P. Berrangé (14):
>   qapi: use "QAPI_FEATURE" as namespace for special features
>   qapi: add helper for checking if a command feature is set
>   qapi: cope with special feature names containing a '-'
>   qapi: add a 'command-features' pragma
>   qapi: stop hardcoding list of special features
>   qapi: define enum for custom special features on commands
>   qga: use special feature to mark those that can run when FS are frozen
>   qga: add command line to limit commands for confidential guests
>   qga: define commands which can be run in confidential mode
>   qga: add command line to block unrestricted command/file access
>   qga: mark guest-file-* commands with 'unrestricted' flag
>   qga: mark guest-exec-* commands with 'unrestricted' flag
>   qga: add command line to block user authentication commands
>   qga: mark guest-ssh-* / guest-*-password commands with 'unrestricted'
>     flag
> 
>  include/qapi/qmp/dispatch.h   |   1 +
>  include/qapi/util.h           |   6 +-
>  qapi/qapi-util.c              |   4 +-
>  qapi/qmp-registry.c           |   5 +
>  qapi/qobject-output-visitor.c |   4 +-
>  qga/main.c                    |  66 ++++++---
>  qga/qapi-schema.json          | 248 +++++++++++++++++++++++++++++++---
>  scripts/qapi/commands.py      |  20 +++
>  scripts/qapi/gen.py           |   2 +-
>  scripts/qapi/parser.py        |   2 +
>  scripts/qapi/schema.py        |  33 ++++-
>  scripts/qapi/source.py        |   2 +
>  12 files changed, 341 insertions(+), 52 deletions(-)
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


