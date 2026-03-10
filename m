Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC86EEA8550
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vztwK-0006yB-QA; Tue, 10 Mar 2026 06:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vztwH-0006xx-5d
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vztwE-0005G4-Mm
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773137021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F3Q3Fyd5WdTVLZJblLRKe/QRbH8clVosOiSNvQWDP7U=;
 b=Y2fJPKalK9qxZeEqCR5yAgfl+jMSc0jsMV7OI+0xsYcwoG/TM652o+u5hiRnem1M6hQBWe
 WaQu502eph5S0w3injErv5X4vyBVCOBcLBARJY/KgXlz/AsRHfsGNfAyDULeHBXASKd+xc
 3Z9QhDUmeI8diHHbFO+/3+VFcX9wmXY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-2YAEAlYrM_milfcLqnv0xw-1; Tue,
 10 Mar 2026 06:03:38 -0400
X-MC-Unique: 2YAEAlYrM_milfcLqnv0xw-1
X-Mimecast-MFC-AGG-ID: 2YAEAlYrM_milfcLqnv0xw_1773137017
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F14871956060; Tue, 10 Mar 2026 10:03:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8535619560A6; Tue, 10 Mar 2026 10:03:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1CDCF21E675A; Tue, 10 Mar 2026 11:03:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Prasad
 Pandit <pjp@fedoraproject.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: assert that the same migration handler is
 not being added twice
In-Reply-To: <20260308100148.162503-1-anisinha@redhat.com> (Ani Sinha's
 message of "Sun, 8 Mar 2026 15:31:48 +0530")
References: <20260308100148.162503-1-anisinha@redhat.com>
Date: Tue, 10 Mar 2026 11:03:34 +0100
Message-ID: <87wlzkknm1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Ani Sinha <anisinha@redhat.com> writes:

> Currently the code that adds a migration blocker does not check if the same
> blocker already exists. Assert that the migration handler being added has
> not been added already.
>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Peter Xu <peterx@redhat.com>
> CC: Prasad Pandit <pjp@fedoraproject.org>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  migration/migration.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index a5b0465ed3..840cf0dfe2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1702,6 +1702,8 @@ static int add_blockers(Error **reasonp, unsigned modes, Error **errp)
>  {
>      for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
>          if (modes & BIT(mode)) {
> +            assert(g_slist_index(migration_blockers[mode],
> +                                     *reasonp) == -1);

Indentation is off.

Have we run into such extra additions, or is this just out of caution?

What would happen if such an extra addition went uncaught?

>              migration_blockers[mode] = g_slist_prepend(migration_blockers[mode],
>                                                         *reasonp);
>          }


