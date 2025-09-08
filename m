Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EB8CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uveP3-0005on-2d; Mon, 08 Sep 2025 12:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uveP0-0005oJ-LO
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uveOr-0001Pg-SL
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757347633;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=zGLqShjAjZWli36x+H6AqJsTZwco4DZV7ZSRKeHHrAE=;
 b=V/QQZPhiGGvVfTlOok5vXyXDZKBo+3tP/O6ZV55Q30G1Juc0vRxyPNVcJjEtPP4PEan/tV
 6szbSAEZ3ZTIZlV5otaZs7s5TThJbbac32H6oBIHAr+TTisQXmPYJjbuQ099Kt2G1ijmuW
 K2fyqt3esFpt6d0O0xVEuJI3jFTa9Ks=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-w-6KdTOgOjyiG1NEMVNkOg-1; Mon,
 08 Sep 2025 12:07:11 -0400
X-MC-Unique: w-6KdTOgOjyiG1NEMVNkOg-1
X-Mimecast-MFC-AGG-ID: w-6KdTOgOjyiG1NEMVNkOg_1757347630
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53C621953953; Mon,  8 Sep 2025 16:07:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B414B19540ED; Mon,  8 Sep 2025 16:07:07 +0000 (UTC)
Date: Mon, 8 Sep 2025 17:07:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH V3 5/9] migration: cpr-exec-command parameter
Message-ID: <aL7_KHXT0XuvY6aG@redhat.com>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-6-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1755191843-283480-6-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 14, 2025 at 10:17:19AM -0700, Steve Sistare wrote:
> Create the cpr-exec-command migration parameter, defined as a list of
> strings.  It will be used for cpr-exec migration mode in a subsequent
> patch, and contains forward references to cpr-exec mode in the qapi
> doc.
> 
> No functional change, except that cpr-exec-command is shown by the
> 'info migrate' command.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  qapi/migration.json            | 21 ++++++++++++++++++---
>  migration/migration-hmp-cmds.c | 25 +++++++++++++++++++++++++
>  migration/options.c            | 14 ++++++++++++++
>  hmp-commands.hx                |  2 +-
>  4 files changed, 58 insertions(+), 4 deletions(-)

> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 0fc21f0..79aa528 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -306,6 +306,18 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
>      qapi_free_MigrationCapabilityStatusList(caps);
>  }
>  
> +static void monitor_print_cpr_exec_command(Monitor *mon, strList *args)
> +{
> +    monitor_printf(mon, "%s:",
> +        MigrationParameter_str(MIGRATION_PARAMETER_CPR_EXEC_COMMAND));
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
> @@ -435,6 +447,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>                                 MIGRATION_PARAMETER_DIRECT_IO),
>                             params->direct_io ? "on" : "off");
>          }
> +
> +        assert(params->has_cpr_exec_command);
> +        monitor_print_cpr_exec_command(mon, params->cpr_exec_command);
>      }
>  
>      qapi_free_MigrationParameters(params);
> @@ -716,6 +731,16 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>          p->has_direct_io = true;
>          visit_type_bool(v, param, &p->direct_io, &err);
>          break;
> +    case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
> +        g_autofree char **strv = g_strsplit(valuestr ?: "", " ", -1);


Perhaps we should use   g_shell_parse_argv() in the HMP case ? IIUC
it should handle quoting for args containing whitespace (as long as
HMP itself has not already mangled that ?).

> +        strList **tail = &p->cpr_exec_command;
> +
> +        for (int i = 0; strv[i]; i++) {
> +            QAPI_LIST_APPEND(tail, strv[i]);
> +        }
> +        p->has_cpr_exec_command = true;
> +        break;
> +    }
>      default:
>          g_assert_not_reached();
>      }

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


