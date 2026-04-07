Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A71AFF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABW9-0007sU-H2; Tue, 07 Apr 2026 14:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wABTk-0003JO-Te
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wA3wi-00063K-57
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 06:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775558770;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=G/f2EyGX7gvXpLSndWp6OuVfMsg+2klCtQ776d4WlN4=;
 b=THC2UZ8EjBqeGxYY6fxON+gqt+QeY5Q84MEUU+N5/tgGjRU7aw7+Pw10ya9jIGgNivkytR
 7DgRgHVHxfiQcss4oihU7Q0BsOC6D4NDbOtCVxuSDaPCCM8dQYtIwAKhDaBDfH+9NoHNSW
 KwCBhX58EcDc7JIxvL3Y24U/3JSQm14=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-XucXg9sWOlaZIJiJzevmwA-1; Tue,
 07 Apr 2026 06:46:06 -0400
X-MC-Unique: XucXg9sWOlaZIJiJzevmwA-1
X-Mimecast-MFC-AGG-ID: XucXg9sWOlaZIJiJzevmwA_1775558765
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 395F2180061A; Tue,  7 Apr 2026 10:46:01 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B016230002C3; Tue,  7 Apr 2026 10:45:56 +0000 (UTC)
Date: Tue, 7 Apr 2026 11:45:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 3/5] qapi: add monitor-add, monitor-remove,
 query-monitors commands
Message-ID: <adTgYYklczPVA40Q@redhat.com>
References: <20260407-work-qmp-monitor-hotplug-v3-0-cb259800fffb@kernel.org>
 <20260407-work-qmp-monitor-hotplug-v3-3-cb259800fffb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407-work-qmp-monitor-hotplug-v3-3-cb259800fffb@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 07, 2026 at 09:32:47AM +0200, Christian Brauner wrote:
> Add QMP commands for dynamic monitor lifecycle management:
> 
> - monitor-add: Create a QMP monitor on an existing chardev at runtime.
>   The chardev must exist and not already have a frontend attached
>   (enforced by qemu_chr_fe_init()).  The new monitor starts in
>   capability negotiation mode.
> 
> - monitor-remove: Remove a dynamically-added monitor.  CLI-created
>   monitors cannot be removed.  The removal sequence is:

Why should we block removal of statically created monitors ? Our
normal approach is that the creation of objects via the command
line & QMP be indistinguishable.


> diff --git a/qapi/control.json b/qapi/control.json
> index 9a5302193d..fd58b57c31 100644
> --- a/qapi/control.json
> +++ b/qapi/control.json
> @@ -211,3 +211,107 @@
>        '*pretty': 'bool',
>        'chardev': 'str'
>    } }
> +
> +##
> +# @monitor-add:
> +#
> +# Add a QMP monitor on an existing character device backend.
> +#
> +# The chardev must already exist (created via chardev-add or CLI).
> +# The monitor begins in capability negotiation mode -- the first
> +# client to connect receives the QMP greeting.
> +#
> +# @id: Monitor identifier, must be unique among monitors
> +#
> +# @chardev: Name of the character device backend to attach to
> +#
> +# @pretty: Enable pretty-printing of QMP responses (default: false)
> +#
> +# Errors:
> +#     - GenericError if @id is already in use
> +#     - GenericError if @chardev does not exist
> +#
> +# Since: 11.0

We're just about to release 11.0, so 11.1 is the earliest
opportunity to merge anything now.

> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "monitor-add",
> +#          "arguments": { "id": "extra-qmp",
> +#                         "chardev": "qmp-extra" } }
> +#     <- { "return": {} }
> +##
> +{ 'command': 'monitor-add',
> +  'data': { 'id': 'str',
> +            'chardev': 'str',
> +            '*pretty': 'bool' } }
> +
> +##
> +# @monitor-remove:
> +#
> +# Remove a dynamically added QMP monitor.
> +#
> +# The monitor must have been created via monitor-add.  Monitors
> +# created via CLI options (-mon, -qmp) cannot be removed.  The
> +# underlying chardev is NOT removed -- use chardev-remove separately
> +# if desired.
> +#
> +# If a client is currently connected, the connection is dropped.
> +#
> +# @id: Monitor identifier as passed to monitor-add
> +#
> +# Errors:
> +#     - GenericError if @id does not exist
> +#     - GenericError if the monitor was not dynamically added

I don't think we need to include "GenericError" in the description.
We've abandoned the idea of error classes in general, so everything
is GenericError  except for a bit of historical cruft.

> +#
> +# Since: 11.0
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "monitor-remove",
> +#          "arguments": { "id": "extra-qmp" } }
> +#     <- { "return": {} }
> +##
> +{ 'command': 'monitor-remove',
> +  'data': { 'id': 'str' } }
> +
> +##
> +# @MonitorInfo:
> +#
> +# Information about a QMP/HMP monitor.
> +#
> +# @id: Monitor identifier (absent for CLI-created monitors without
> +#     an explicit id)

We can't make 'id' mandatory for the existing arg without breaking
compat, but IMHO we should allocate an auto-generated 'id' if the
user omits it.

> +#
> +# @mode: Monitor mode (readline or control)
> +#
> +# @chardev: Name of the attached character device
> +#
> +# @dynamic: true if created via monitor-add (removable), false if
> +#     created via CLI
> +#
> +# Since: 11.0
> +##
> +{ 'struct': 'MonitorInfo',
> +  'data': { '*id': 'str',
> +            'mode': 'MonitorMode',
> +            'chardev': 'str',
> +            'dynamic': 'bool' } }
> +
> +##
> +# @query-monitors:
> +#
> +# Return information about all active monitors.
> +#
> +# Returns: a list of @MonitorInfo for each active monitor
> +#
> +# Since: 11.0
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "query-monitors" }
> +#     <- { "return": [ { "id": "mon0", "mode": "control",
> +#                         "chardev": "compat_monitor0",
> +#                         "dynamic": false } ] }
> +##
> +{ 'command': 'query-monitors',
> +  'returns': ['MonitorInfo'] }

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


