Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EC6E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 15:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJDiF-0003wc-GS; Thu, 05 Dec 2024 10:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tJDi7-0003rY-UB
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:24:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tJDi5-0007cY-QV
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733412248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6fgpox0VmUNbx6ZoeRGz4mdweQE1z2xLqWpAYCdqRN0=;
 b=T1ScbrvSVnzdnSimGIKR9AcqyrjJaeDobBJWM3TwPz2eJd8tNJ762CjfwetnV3hHRqYprJ
 W9I7ubOtP7QlpIL+EtIev04RJZMQwIaWeyFYaggfC0NOqlYcsKV6ZNxJo94MQmFl1Il1DQ
 yrZ8Mp7WzFwAaMf0Kt2FVZQzKaPlv/I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-81hzhC3gM3mxhTF1UNL4Qw-1; Thu,
 05 Dec 2024 10:24:04 -0500
X-MC-Unique: 81hzhC3gM3mxhTF1UNL4Qw-1
X-Mimecast-MFC-AGG-ID: 81hzhC3gM3mxhTF1UNL4Qw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82D4D1955F43; Thu,  5 Dec 2024 15:24:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC33A1956054; Thu,  5 Dec 2024 15:24:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EF0A521E681F; Thu,  5 Dec 2024 16:23:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  David Hildenbrand <david@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Philippe Mathieu-Daude <philmd@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V4 09/19] migration: incoming channel
In-Reply-To: <1733145611-62315-10-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Mon, 2 Dec 2024 05:20:01 -0800")
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-10-git-send-email-steven.sistare@oracle.com>
Date: Thu, 05 Dec 2024 16:23:53 +0100
Message-ID: <87ser2cfw6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Extend the -incoming option to allow an @MigrationChannel to be specified.
> This allows channels other than 'main' to be described on the command
> line, which will be needed for CPR.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

[...]

> diff --git a/qemu-options.hx b/qemu-options.hx
> index 02b9118..fab50ce 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4937,10 +4937,17 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
>      "-incoming exec:cmdline\n" \
>      "                accept incoming migration on given file descriptor\n" \
>      "                or from given external command\n" \
> +    "-incoming @MigrationChannel\n" \
> +    "                accept incoming migration on the channel\n" \
>      "-incoming defer\n" \
>      "                wait for the URI to be specified via migrate_incoming\n",
>      QEMU_ARCH_ALL)
>  SRST
> +The -incoming option specifies the migration channel for an incoming
> +migration.  It may be used multiple times to specify multiple
> +migration channel types.

Really?  If I understand the code below correctly, the last -incoming
wins, and any previous ones are silently ignored.

>                            The channel type is specified in @MigrationChannel,
> +and is 'main' for all other forms of -incoming.
> +
>  ``-incoming tcp:[host]:port[,to=maxport][,ipv4=on|off][,ipv6=on|off]``
>    \ 
>  ``-incoming rdma:host:port[,ipv4=on|off][,ipv6=on|off]``
> @@ -4960,6 +4967,16 @@ SRST
>      Accept incoming migration as an output from specified external
>      command.
>  
> +``-incoming @MigrationChannel``
> +    Accept incoming migration on the channel.  See the QAPI documentation
> +    for the syntax of the @MigrationChannel data element.  For example:
> +    ::

I get what you're trying to express, but there's no precedence for
referring to QAPI types like @TypeName in option documentation.  But
let's ignore this until after we nailed down the actual interface, on
which I have questions below.

> +
> +        -incoming '{"channel-type": "main",
> +                    "addr": { "transport": "socket",
> +                              "type": "unix",
> +                              "path": "my.sock" }}'
> +
>  ``-incoming defer``
>      Wait for the URI to be specified via migrate\_incoming. The monitor
>      can be used to change settings (such as migration parameters) prior
> diff --git a/system/vl.c b/system/vl.c
> index 4151a79..2c24c60 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -123,6 +123,7 @@
>  #include "qapi/qapi-visit-block-core.h"
>  #include "qapi/qapi-visit-compat.h"
>  #include "qapi/qapi-visit-machine.h"
> +#include "qapi/qapi-visit-migration.h"
>  #include "qapi/qapi-visit-ui.h"
>  #include "qapi/qapi-commands-block-core.h"
>  #include "qapi/qapi-commands-migration.h"
> @@ -159,6 +160,7 @@ typedef struct DeviceOption {
>  static const char *cpu_option;
>  static const char *mem_path;
>  static const char *incoming;
> +static MigrationChannelList *incoming_channels;
>  static const char *loadvm;
>  static const char *accelerators;
>  static bool have_custom_ram_size;
> @@ -1821,6 +1823,35 @@ static void object_option_add_visitor(Visitor *v)
>      QTAILQ_INSERT_TAIL(&object_opts, opt, next);
>  }
>  
> +static void incoming_option_parse(const char *str)
> +{
> +    MigrationChannel *channel;
> +
> +    if (str[0] == '{') {
> +        QObject *obj = qobject_from_json(str, &error_fatal);
> +        Visitor *v = qobject_input_visitor_new(obj);
> +
> +        qobject_unref(obj);
> +        visit_type_MigrationChannel(v, "channel", &channel, &error_fatal);
> +        visit_free(v);
> +    } else if (!strcmp(str, "defer")) {
> +        channel = NULL;
> +    } else {
> +        migrate_uri_parse(str, &channel, &error_fatal);
> +    }
> +
> +    /* New incoming spec replaces the previous */
> +
> +    if (incoming_channels) {
> +        qapi_free_MigrationChannelList(incoming_channels);
> +    }
> +    if (channel) {
> +        incoming_channels = g_new0(MigrationChannelList, 1);
> +        incoming_channels->value = channel;
> +    }
> +    incoming = str;
> +}

@incoming is set to @optarg.

@incoming_channels is set to a MigrationChannelList of exactly one
element, parsed from @incoming.  Except when @incoming is "defer", then
@incoming_channels is set to null.

@incoming is only ever used as a flag.  Turn it into a bool?

Oh, wait...  see my comment on the next hunk.

Option -incoming resembles QMP command migrate-incoming.  Differences:

* migrate-incoming keeps legacy URI and modern argument separate: there
  are two named arguments, and exactly one of them must be passed.
  -incoming overloads them: if @optarg starts with '{', it's modern,
  else legacy URI.

  Because of that, -incoming *only* supports JSON syntax for modern, not
  dotted keys.  Other JSON-capable arguments support both.

  How can a management application detect that -incoming supports
  modern?

  Sure overloading -incoming this way is a good idea?

* migrate-incoming takes a list of channels, currently restricted to a
  single channel.  -incoming takes a channel.  If we lift the
  restriction, -incoming syntax will become even messier: we'll have to
  additionally overload list of channel.

  Should -incoming take a list from the start, like migrate-incoming
  does?

> +
>  static void object_option_parse(const char *str)
>  {
>      QemuOpts *opts;
> @@ -2730,7 +2761,7 @@ void qmp_x_exit_preconfig(Error **errp)
>      if (incoming) {
>          Error *local_err = NULL;
>          if (strcmp(incoming, "defer") != 0) {
> -            qmp_migrate_incoming(incoming, false, NULL, true, true,
> +            qmp_migrate_incoming(NULL, true, incoming_channels, true, true,
>                                   &local_err);

You move the parsing of legacy URI from within qmp_migrate_incoming()
into incoming_option_parse().

The alternative is not to parse it in incoming_option_parse(), but pass
it to qmp_migrate_incoming() like this:

               qmp_migrate_incoming(incoming, !incoming, incoming_channels,
                                    true, true, &local_err);

>              if (local_err) {
>                  error_reportf_err(local_err, "-incoming %s: ", incoming);
> @@ -3477,7 +3508,7 @@ void qemu_init(int argc, char **argv)
>                  if (!incoming) {
>                      runstate_set(RUN_STATE_INMIGRATE);
>                  }
> -                incoming = optarg;
> +                incoming_option_parse(optarg);
>                  break;
>              case QEMU_OPTION_only_migratable:
>                  only_migratable = 1;


