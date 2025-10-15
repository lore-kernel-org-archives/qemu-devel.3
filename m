Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5859FCCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 06:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8v7X-0001iR-As; Wed, 15 Oct 2025 02:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8v7S-0001ZT-MX
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v8v7O-0004lQ-Fo
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 02:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760510168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JM2D+dYU2Iv0UYGJkIIde0R1cyS8xQU8yC33K20YvWc=;
 b=hR+SMMtDPItRtsCeKaGvuB6xeKsS41xPVUZ5Nec2pA61dwcZb6y1xwEB24cheJeTGmbaId
 mfpQQLniUe0ZC20WUN+1EAQhACRqciUHeX5+0bG5cTTXtwGUMsOQFZJgtaOYdQNPk1dkVi
 MdPecexEJvlx8fhlgdL4lo+ZCg91gWU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-hx5CQMwaN7CzFUdc1RiFaA-1; Wed,
 15 Oct 2025 02:36:05 -0400
X-MC-Unique: hx5CQMwaN7CzFUdc1RiFaA-1
X-Mimecast-MFC-AGG-ID: hx5CQMwaN7CzFUdc1RiFaA_1760510164
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C97C19560B2; Wed, 15 Oct 2025 06:36:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6911A18004D4; Wed, 15 Oct 2025 06:36:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C64B721E6A27; Wed, 15 Oct 2025 08:35:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: marcandre.lureau@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 eduardo@habkost.net,  qemu-devel@nongnu.org,  raphael@enfabrica.net,
 yc-core@yandex-team.ru,  d-tatianin@yandex-team.ru
Subject: Re: [PATCH v3 2/7] chardev/char: split chardev_init_logfd() out of
 qemu_char_open()
In-Reply-To: <20251014152644.954762-3-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 14 Oct 2025 18:26:39 +0300")
References: <20251014152644.954762-1-vsementsov@yandex-team.ru>
 <20251014152644.954762-3-vsementsov@yandex-team.ru>
Date: Wed, 15 Oct 2025 08:35:59 +0200
Message-ID: <87bjm8k6y8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The subject says "split chardev_init_logfd() out of qemu_char_open()".
What the actually does is factor chardev_init_common() out of
qemu_char_open().  Has the commit message gone stale?


