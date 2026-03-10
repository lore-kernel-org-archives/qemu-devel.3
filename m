Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4685BEA854E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 08:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzspn-00054H-PG; Tue, 10 Mar 2026 04:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzspk-000541-R6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 04:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzspi-0005qI-J7
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 04:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773132771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u57xTiOfwrmS3jdy8nQn0xyMwms1xDAVYGyJkK4uNho=;
 b=fM9MYaAeDeVH01/JJrsTTSz28d7g5XSULD/Qt4FrMOCA0Q72U6cVcqqwpjKu1pDysTBzCI
 BpiHwzjYD6cGZlBht2jktKnue83c1Tph55kyiWLCreT448uUPQjF0CHW8f4YbWmYOBw/Lf
 giqwyE7fFFrgfAsqnCDTx3Hs5dOUEmc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-MFD3CyXJOCqdxkKonB06XA-1; Tue,
 10 Mar 2026 04:52:50 -0400
X-MC-Unique: MFD3CyXJOCqdxkKonB06XA-1
X-Mimecast-MFC-AGG-ID: MFD3CyXJOCqdxkKonB06XA_1773132769
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4104D1955F38; Tue, 10 Mar 2026 08:52:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF6F01956095; Tue, 10 Mar 2026 08:52:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4BE3121E6614; Tue, 10 Mar 2026 09:52:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter
 Xu <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 1/1] io: make zerocopy fallback accounting more accurate
In-Reply-To: <20260309090907.956330-1-tejus.gk@nutanix.com> (Tejus GK's
 message of "Mon, 9 Mar 2026 09:09:01 +0000")
References: <20260309090907.956330-1-tejus.gk@nutanix.com>
Date: Tue, 10 Mar 2026 09:52:46 +0100
Message-ID: <87h5qom5gh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Tejus GK <tejus.gk@nutanix.com> writes:

> Currently, the dirty-sync-missed-zero-copy stat is incremented only when
> an entire batch of IO operations fails to use zerocopy and falls back to
> a normal copy. As long as at least one IO in the batch is successfully
> zero-copied, the whole batch is treated as a success. This hides
> individual IO fallbacks and makes the migration stat less accurate than
> it could be.
>
> Make the stat more accurate by reporting at a finer granularity, i.e, by
> incrementing for every individual IO fallback that occurs.
>
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index f925e5541b..94977b8810 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -58,8 +58,7 @@
>  #     (since 7.0).
>  #
>  # @dirty-sync-missed-zero-copy: Number of times dirty RAM
> -#     synchronization could not avoid copying dirty pages.  This is
> -#     between 0 and @dirty-sync-count * @multifd-channels.
> +#     synchronization could not avoid copying dirty pages.
>  #     (since 7.1)
>  #
>  # Since: 0.14

Dropping the documented upper limit might make the value harder to
interpret.  Thus my question: how is this value to be used?


