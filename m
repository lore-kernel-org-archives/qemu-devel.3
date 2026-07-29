Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E0DC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp3fk-0006hB-9l; Wed, 29 Jul 2026 08:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wp3fh-0006fe-5F
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 08:46:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wp3ff-0000Dc-7b
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 08:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785329162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0C0KEc7fmodXRRaLfl5nsdgWxAjHwuQvUyvH1IbIkys=;
 b=hvrkrdrRJPDWBersDlG+3d4GeIwjG/y3w4z739PozNoJx9iyVqK0PqOQa+8MInBcRiK71t
 JbxzWWs6Ur0hrm2HikLMxuzIOuLdFNeTkuglAkPSOY52NK6xiNWjp1LmJw+2qDQ7XXM0ML
 2jENgOGRjp3pr3WFtZzMWj07mLaUAwI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-YguQSYtmNPqTsizD0pTaeQ-1; Wed,
 29 Jul 2026 08:46:00 -0400
X-MC-Unique: YguQSYtmNPqTsizD0pTaeQ-1
X-Mimecast-MFC-AGG-ID: YguQSYtmNPqTsizD0pTaeQ_1785329158
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39C10195604B; Wed, 29 Jul 2026 12:45:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A0C8180044F; Wed, 29 Jul 2026 12:45:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CBC1321E6920; Wed, 29 Jul 2026 14:45:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  mst@redhat.com,  peterx@redhat.com,
 farosas@suse.de,  raphael.s.norwitz@gmail.com,  bchaney@akamai.com,
 qemu-devel@nongnu.org,  berrange@redhat.com,  pbonzini@redhat.com,
 yc-core@yandex-team.ru,  mark.caveayland@nutanix.com,  Jason Wang
 <jasowangio@gmail.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v20 13/15] net/tap: support local migration with virtio-net
In-Reply-To: <86a38d6a-f9e4-4597-a7e6-9999cd8a11f6@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 29 Jul 2026 15:25:40 +0300")
References: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
 <20260729091334.1863155-14-vsementsov@yandex-team.ru>
 <87jyqeqbgx.fsf@pond.sub.org>
 <86a38d6a-f9e4-4597-a7e6-9999cd8a11f6@yandex-team.ru>
Date: Wed, 29 Jul 2026 14:45:54 +0200
Message-ID: <87zezaotfh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

[...]

> Or x-permit-local-migration? I've added "x-" prefix as Michael suggested.
> And it seems reasonable, as it's not only QAPI field, but also QOM property,
> and we don't have "unstable" features for properties.

I'm fine with "x-".


