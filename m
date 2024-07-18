Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F77C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMU4-0002hP-36; Thu, 18 Jul 2024 04:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUMU2-0002dd-PG
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUMU0-0002Qc-LA
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721291242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Csfv8UKwQNZgTU8Pypj1wPiCCQtN74A3k50hOXF1azE=;
 b=O8v6mJa6iOQ9swiNmm6fYTFRXQPUBp4+e8MiE4v20WMMm0f/gU/os4EninndNlP42RUPb+
 Nh6BcTHjdEC4dMMCE/A72SUZwXY1/vYuRCoLdJVsESPRUEbaGhOYBanai8mqaM3SzH/qAq
 uAZPTQhOVSC+qafMJ9XuAyOxS61Vylk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-oTKwWBhwNrOPBT9g9iprlg-1; Thu,
 18 Jul 2024 04:27:20 -0400
X-MC-Unique: oTKwWBhwNrOPBT9g9iprlg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F3391955D4D; Thu, 18 Jul 2024 08:27:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACC2C1955F40; Thu, 18 Jul 2024 08:27:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3E52321E668A; Thu, 18 Jul 2024 10:27:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  raphael@enfabrica.net,  mst@redhat.com,
 qemu-devel@nongnu.org,  eblake@redhat.com,  eduardo@habkost.net,
 berrange@redhat.com,  pbonzini@redhat.com,  hreitz@redhat.com,
 kwolf@redhat.com,  yc-core@yandex-team.ru
Subject: Re: [PATCH v5 3/3] qapi: introduce device-sync-config
In-Reply-To: <20240625121843.120035-4-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 25 Jun 2024 15:18:43 +0300")
References: <20240625121843.120035-1-vsementsov@yandex-team.ru>
 <20240625121843.120035-4-vsementsov@yandex-team.ru>
Date: Thu, 18 Jul 2024 10:27:12 +0200
Message-ID: <87cynbm7fj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Add command to sync config from vhost-user backend to the device. It
> may be helpful when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG failed or not
> triggered interrupt to the guest or just not available (not supported
> by vhost-user server).
>
> Command result is racy if allow it during migration. Let's allow the
> sync only in RUNNING state.

Is this still accurate?  The runstate_is_running() check is gone in
v4, the migration_is_running() check remains.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

QAPI schema and QMP part:
Signed-off-by: Markus Armbruster <armbru@redhat.com>


