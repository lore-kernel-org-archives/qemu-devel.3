Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6340BC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 06:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rarXh-00056m-TX; Fri, 16 Feb 2024 01:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rarXZ-00054E-89
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 01:17:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rarXX-0006tU-Ic
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 01:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708064257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mB3FarE31PON4zXT19kaAQdW8U3EAvS7q68FrD62aeE=;
 b=Z0+Ag8xIFUUTsBvuoj6y7H3zaIyirGxb4x3SaZcHIQtN2NS3lTTDrt5yvMVQE+5A9MsYmk
 BI1HwetYW+bcPOJtcFWNvu+bfOyll83iyCcBRblsa/Yjqkfi5ZoSJJXag/Pb3qE9FzkApJ
 lT2ct/buh2JoKEVX8l7I8SSrUm1R4gY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-n_Bb5-8qOruf3B3zR27bGA-1; Fri, 16 Feb 2024 01:17:33 -0500
X-MC-Unique: n_Bb5-8qOruf3B3zR27bGA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04098106D020;
 Fri, 16 Feb 2024 06:17:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B124820110C4;
 Fri, 16 Feb 2024 06:17:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 827A621E6757; Fri, 16 Feb 2024 07:17:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Roman Khapov <rkhapov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  farosas@suse.de,
 eblake@redhat.com,  yc-core@yandex-team.ru
Subject: Re: [PATCH v2 1/2] qapi/migration.json: add reason to MIGRATION event
In-Reply-To: <20240215122759.1438581-2-rkhapov@yandex-team.ru> (Roman Khapov's
 message of "Thu, 15 Feb 2024 17:27:58 +0500")
References: <20240215122759.1438581-1-rkhapov@yandex-team.ru>
 <20240215122759.1438581-2-rkhapov@yandex-team.ru>
Date: Fri, 16 Feb 2024 07:17:31 +0100
Message-ID: <87il2p0w78.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
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

Roman Khapov <rkhapov@yandex-team.ru> writes:

> This commit adds the optional field reason for the events, which
> contains the string, describing reason of status changing.
> For example: reason of migration fail.
>
> Function migrate_set_state now accepts 4th argument: the reason to
> pass to event. Every call of this function appended with NULL argument.
>
> Also migrate_set_state_err_reason was added to form reason from Error*
>
> Signed-off-by: Roman Khapov <rkhapov@yandex-team.ru>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 5a565d9b8d..33bb5b7f50 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1392,6 +1392,7 @@
>  # Emitted when a migration event happens
>  #
>  # @status: @MigrationStatus describing the current migration status.
> +# @reason: Optional description of status changing reason.

Intended use?

When is it present?

>  #
>  # Since: 2.4
>  #
> @@ -1402,7 +1403,7 @@
>  #     "data": {"status": "completed"} }
>  ##
>  { 'event': 'MIGRATION',
> -  'data': {'status': 'MigrationStatus'}}
> +  'data': {'status': 'MigrationStatus', '*reason': 'str'}}
>  
>  ##
>  # @MIGRATION_PASS:


