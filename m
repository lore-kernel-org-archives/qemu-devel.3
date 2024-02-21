Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E83BC48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoT1-0005jk-13; Wed, 21 Feb 2024 10:25:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcoMs-0000nB-18
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:18:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcmN4-0005Ou-B1
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708521044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AtCSsIwXL4IiaaxqSyjHIbu+Bf1iRXGlN67g2XJpYIc=;
 b=YGIYK0AJutBUP6uI26VRLSL9UgJBUUW/FDxgYE1GpyXbenv1vcOhLSLKVOBDXaMdd5Dp/v
 bFV86Waov3r+h76g4xjxjDb6rOgQ/iMe74uph5OX2R1QWGh1E8e+yFsco8NLDbwArOuFiZ
 3oEPrwDydzJnUNwte15QLjjfeoRtp4w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-TKZFUVCnM6ShfPOtNgDJIg-1; Wed, 21 Feb 2024 08:10:40 -0500
X-MC-Unique: TKZFUVCnM6ShfPOtNgDJIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FBAB85A58A;
 Wed, 21 Feb 2024 13:10:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDD92200B436;
 Wed, 21 Feb 2024 13:10:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B661121E66C8; Wed, 21 Feb 2024 14:10:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  =?utf-8?Q?Marc-An?=
 =?utf-8?Q?dr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH V4 5/5] migration: simplify exec migration functions
In-Reply-To: <1705099758-211963-6-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Fri, 12 Jan 2024 14:49:18 -0800")
References: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
 <1705099758-211963-6-git-send-email-steven.sistare@oracle.com>
Date: Wed, 21 Feb 2024 14:10:33 +0100
Message-ID: <87r0h63quu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Het Gala, Peter, or Fabiano, please review.

Steve Sistare <steven.sistare@oracle.com> writes:

> Simplify the exec migration code by using list utility functions.
>
> As a side effect, this also fixes a minor memory leak.  On function return,
> "g_auto(GStrv) argv" frees argv and each element, which is wrong, because
> the function does not own the individual elements.  To compensate, the code
> uses g_steal_pointer which NULLs argv and prevents the destructor from
> running, but argv is leaked.
>
> Fixes: cbab4face57b ("migration: convert exec backend ...")
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  migration/exec.c | 58 ++++++++------------------------------------------------
>  1 file changed, 8 insertions(+), 50 deletions(-)
>
> diff --git a/migration/exec.c b/migration/exec.c
> index 47d2f3b..1312ca7 100644
> --- a/migration/exec.c
> +++ b/migration/exec.c
> @@ -19,12 +19,12 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qemu/strList.h"
>  #include "channel.h"
>  #include "exec.h"
>  #include "migration.h"
>  #include "io/channel-command.h"
>  #include "trace.h"
> -#include "qemu/cutils.h"
>  
>  #ifdef WIN32
>  const char *exec_get_cmd_path(void)
> @@ -39,51 +39,16 @@ const char *exec_get_cmd_path(void)
>  }
>  #endif
>  
> -/* provides the length of strList */
> -static int
> -str_list_length(strList *list)
> -{
> -    int len = 0;
> -    strList *elem;
> -
> -    for (elem = list; elem != NULL; elem = elem->next) {
> -        len++;
> -    }
> -
> -    return len;
> -}
> -
> -static void
> -init_exec_array(strList *command, char **argv, Error **errp)
> -{
> -    int i = 0;
> -    strList *lst;
> -
> -    for (lst = command; lst; lst = lst->next) {
> -        argv[i++] = lst->value;
> -    }
> -
> -    argv[i] = NULL;
> -    return;
> -}
> -
>  void exec_start_outgoing_migration(MigrationState *s, strList *command,
>                                     Error **errp)
>  {
> -    QIOChannel *ioc;
> -
> -    int length = str_list_length(command);
> -    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
> -
> -    init_exec_array(command, argv, errp);
> +    QIOChannel *ioc = NULL;
> +    g_auto(GStrv) argv = strv_from_strList(command);
> +    const char * const *args = (const char * const *) argv;
>      g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
>  
>      trace_migration_exec_outgoing(new_command);
> -    ioc = QIO_CHANNEL(
> -        qio_channel_command_new_spawn(
> -                            (const char * const *) g_steal_pointer(&argv),
> -                            O_RDWR,
> -                            errp));
> +    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(args, O_RDWR, errp));
>      if (!ioc) {
>          return;
>      }
> @@ -105,19 +70,12 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
>  void exec_start_incoming_migration(strList *command, Error **errp)
>  {
>      QIOChannel *ioc;
> -
> -    int length = str_list_length(command);
> -    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
> -
> -    init_exec_array(command, argv, errp);
> +    g_auto(GStrv) argv = strv_from_strList(command);
> +    const char * const *args = (const char * const *) argv;
>      g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
>  
>      trace_migration_exec_incoming(new_command);
> -    ioc = QIO_CHANNEL(
> -        qio_channel_command_new_spawn(
> -                            (const char * const *) g_steal_pointer(&argv),
> -                            O_RDWR,
> -                            errp));
> +    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(args, O_RDWR, errp));
>      if (!ioc) {
>          return;
>      }


