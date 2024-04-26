Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C29DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 14:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0MMZ-0003wz-Kq; Fri, 26 Apr 2024 10:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0MMV-0003wP-Ge
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:15:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s0MMT-0000GF-Sg
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 10:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714140937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D+GQuGtejKAiA/4qnmLvxONXqZb/q0ZqUTr4GMrmk0I=;
 b=c0L8yaHEgZH6NecMIrQZqqip20c4sCbY1j3IkZZ2zn4AIMnAuXcVFS+n5vmfl5LZlQWf1S
 7QCJeg6032AAycSYoaGrnC6aRiIchuKAt8GPTe5XPwUUpD7457u2SzNnnfo689kdTS5c9C
 2rcjKzvB6+IKQxMsN2TAyFWWz+hX4DY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-b64hrSvzMi2EPob2bGMpFA-1; Fri, 26 Apr 2024 10:15:33 -0400
X-MC-Unique: b64hrSvzMi2EPob2bGMpFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED8BB8B5722;
 Fri, 26 Apr 2024 14:15:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 897762166B31;
 Fri, 26 Apr 2024 14:15:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AD2AA21E66E5; Fri, 26 Apr 2024 16:15:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,  devel@lists.libvirt.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Hailiang Zhang <zhanghailiang@xfusion.com>,  Eric
 Blake <eblake@redhat.com>
Subject: Re: [PATCH 4/6] migration: Remove block migration
In-Reply-To: <20240425150939.19268-5-farosas@suse.de> (Fabiano Rosas's message
 of "Thu, 25 Apr 2024 12:09:37 -0300")
References: <20240425150939.19268-1-farosas@suse.de>
 <20240425150939.19268-5-farosas@suse.de>
Date: Fri, 26 Apr 2024 16:15:31 +0200
Message-ID: <87cyqcrz0c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Fabiano Rosas <farosas@suse.de> writes:

> The block migration has been considered obsolete since QEMU 8.2 in
> favor of the more flexible storage migration provided by the
> blockdev-mirror driver. Two releases have passed so now it's time to
> remove it.
>
> Deprecation commit 66db46ca83 ("migration: Deprecate block
> migration").
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

[...]

> diff --git a/migration/migration.c b/migration/migration.c
> index a3dc8a7974..0f4df893e5 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c

[...]

> @@ -1997,8 +1983,6 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>          }
>      }
>  
> -    s->must_remove_block_options = true;
> -
>      if (migrate_init(s, errp)) {
>          return false;
>      }
> @@ -2080,7 +2064,6 @@ void qmp_migrate(const char *uri, bool has_channels,
>                     "a valid migration protocol");
>          migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>                            MIGRATION_STATUS_FAILED);
> -        block_cleanup_parameters();
>      }
>  
>      if (local_err) {
> diff --git a/migration/options.c b/migration/options.c
> index 638eeeb9a0..5049bfb78e 100644
> --- a/migration/options.c
> +++ b/migration/options.c

[...]

> @@ -942,17 +917,6 @@ ZeroPageDetection migrate_zero_page_detection(void)
>  
>  /* parameters helpers */
>  
> -void block_cleanup_parameters(void)
> -{
> -    MigrationState *s = migrate_get_current();
> -
> -    if (s->must_remove_block_options) {
> -        /* setting to false can never fail */
> -        migrate_cap_set(MIGRATION_CAPABILITY_BLOCK, false, &error_abort);
> -        s->must_remove_block_options = false;
> -    }
> -}
> -

MigrationState member @must_remove_block_options is now unused.  Please
delete it.

>  AnnounceParameters *migrate_announce_params(void)
>  {
>      static AnnounceParameters ap;

[...]

With that:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


