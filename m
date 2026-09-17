Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08B4C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ApM-00048Z-MP; Thu, 17 Sep 2026 08:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7ApK-00048J-Vk
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7ApJ-0003cw-HW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789646572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=33cDWXygArK8W3qD/XU2ycvNEsev6MprkoWK9MyBT3Q=;
 b=Kkk1KW7+2Mb1nDb2fYi9daJT8EsgYWQ5LDJfnAZGj2NrkFO3ZDmBQkwDy40V1DfnAp5v2b
 rnItskUS0CqQ9cpY2VehSt9HEuNO02VNw602JX5FxNE4DyHi3nX24JoOFoFbqY5NzfZvph
 74jn/57hhIjFVn5XmD6A1UwDbZr1Fu4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-hP-FT5eMMDieM1j-LTgLbw-1; Thu,
 17 Sep 2026 08:02:48 -0400
X-MC-Unique: hP-FT5eMMDieM1j-LTgLbw-1
X-Mimecast-MFC-AGG-ID: hP-FT5eMMDieM1j-LTgLbw_1789646567
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A89D4195FD3E; Thu, 17 Sep 2026 12:02:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15F611800345; Thu, 17 Sep 2026 12:02:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 61A1F21E6A04; Thu, 17 Sep 2026 14:02:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  "Dr . David Alan
 Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 15/20] migration: Rewrite
 migrate_set_parameter_completion using QDict
In-Reply-To: <20260915000209.3692668-16-farosas@suse.de> (Fabiano Rosas's
 message of "Mon, 14 Sep 2026 21:02:03 -0300")
References: <20260915000209.3692668-1-farosas@suse.de>
 <20260915000209.3692668-16-farosas@suse.de>
Date: Thu, 17 Sep 2026 14:02:44 +0200
Message-ID: <87h5jot7a3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fabiano Rosas <farosas@suse.de> writes:

> We're moving towards having no open-coded access to the
> MigrationParameters members. Instances of parameters enumeration are
> being removed.
>
> The migrate_set_parameter_completion function is one of the last users
> of the MigrationParameter enum. Rewrite that code using an output
> visitor and QDict instead.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration-hmp-cmds.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 00d2d310af..c63d7f1ccb 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -693,14 +693,20 @@ void migrate_set_capability_completion(ReadLineState *rs, int nb_args,
>  void migrate_set_parameter_completion(ReadLineState *rs, int nb_args,
>                                        const char *str)
>  {
> +    g_autoptr(QDict) d = NULL;
> +    const QDictEntry *e;
>      size_t len;
>  
> +    /* Temporarily borrow the global parameters */

What do you mean by "borrow"?

> +    d = migrate_params_to_dict(&migrate_get_current()->parameters,
> +                               &error_abort);

@d is unused unless @nb_args == 2.  Move the call into the conditional?

> +
>      len = strlen(str);
>      readline_set_completion_index(rs, len);
>      if (nb_args == 2) {
> -        int i;
> -        for (i = 0; i < MIGRATION_PARAMETER__MAX; i++) {
> -            readline_add_completion_of(rs, str, MigrationParameter_str(i));
> +        for (e = qdict_first(d); e; e = qdict_next(d, e)) {
> +            const char *key = qdict_entry_key(e);
> +            readline_add_completion_of(rs, str, key);
>          }
>      }
>  }

This relies on all parameters being present in the value of
migrate_get_current()->parameters.  Worth a comment?


