Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF580C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 08:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9KcY-0005I9-NA; Tue, 21 May 2024 04:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s9KcW-0005H1-LQ
 for qemu-devel@nongnu.org; Tue, 21 May 2024 04:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s9KcU-0002wf-QT
 for qemu-devel@nongnu.org; Tue, 21 May 2024 04:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716279193;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gie66S2+LDm1bDkpb+g5reFf/IPYXUzh6O1OFODj0fk=;
 b=a1FMdAF4Ig41Wj9q7xfU49bfH2lvGcc8I1uZZ3lbP3Hm7XA1FkVoc6b2ZlVkkAUIKRYyYu
 wUYHuUrT8RyHW6MRxO/sRi1QBjNJvBzVqszD5DQ7X8YVT9l/ooXYwT0irhpDQv+lRqw9vI
 h0Ojs3YidirqjBHalmxK1ZpOO+2yozs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-6E3gJ-DEMi2855tDVpSUrQ-1; Tue,
 21 May 2024 04:13:11 -0400
X-MC-Unique: 6E3gJ-DEMi2855tDVpSUrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB1703C025B0;
 Tue, 21 May 2024 08:13:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A68F40C6CB4;
 Tue, 21 May 2024 08:13:08 +0000 (UTC)
Date: Tue, 21 May 2024 09:13:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 18/26] migration: cpr-exec-args parameter
Message-ID: <ZkxXkgJejmlnyYIS@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-19-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1714406135-451286-19-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

On Mon, Apr 29, 2024 at 08:55:27AM -0700, Steve Sistare wrote:
> Create the cpr-exec-args migration parameter, defined as a list of
> strings.  It will be used for cpr-exec migration mode in a subsequent
> patch.
> 
> No functional change, except that cpr-exec-args is shown by the
> 'info migrate' command.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  hmp-commands.hx                |  2 +-
>  migration/migration-hmp-cmds.c | 24 ++++++++++++++++++++++++
>  migration/options.c            | 13 +++++++++++++
>  qapi/migration.json            | 18 +++++++++++++++---
>  4 files changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 2e2a3bc..39954ae 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1012,7 +1012,7 @@ ERST
>  
>      {
>          .name       = "migrate_set_parameter",
> -        .args_type  = "parameter:s,value:s",
> +        .args_type  = "parameter:s,value:S",
>          .params     = "parameter value",
>          .help       = "Set the parameter for migration",
>          .cmd        = hmp_migrate_set_parameter,
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 7e96ae6..414c7e8 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -255,6 +255,18 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
>      qapi_free_MigrationCapabilityStatusList(caps);
>  }
>  
> +static void monitor_print_cpr_exec_args(Monitor *mon, strList *args)
> +{
> +    monitor_printf(mon, "%s:",
> +        MigrationParameter_str(MIGRATION_PARAMETER_CPR_EXEC_ARGS));
> +
> +    while (args) {
> +        monitor_printf(mon, " %s", args->value);
> +        args = args->next;
> +    }
> +    monitor_printf(mon, "\n");
> +}
> +
>  void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>  {
>      MigrationParameters *params;
> @@ -397,6 +409,8 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "%s: %s\n",
>              MigrationParameter_str(MIGRATION_PARAMETER_MODE),
>              qapi_enum_lookup(&MigMode_lookup, params->mode));
> +        assert(params->has_cpr_exec_args);
> +        monitor_print_cpr_exec_args(mon, params->cpr_exec_args);
>      }
>  
>      qapi_free_MigrationParameters(params);
> @@ -690,6 +704,16 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_mode = true;
>          visit_type_MigMode(v, param, &p->mode, &err);
>          break;
> +    case MIGRATION_PARAMETER_CPR_EXEC_ARGS: {
> +        g_autofree char **strv = g_strsplit(valuestr ?: "", " ", -1);

Splitting on whitespace means it'll break with any arguments containing
quoted whitespace. If we use g_shell_parse_argv then it should support
quoting in the normal shell mannre.

> +        strList **tail = &p->cpr_exec_args;
> +
> +        for (int i = 0; strv[i]; i++) {
> +            QAPI_LIST_APPEND(tail, strv[i]);
> +        }
> +        p->has_cpr_exec_args = true;
> +        break;
> +    }
>      default:
>          assert(0);
>      }

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


