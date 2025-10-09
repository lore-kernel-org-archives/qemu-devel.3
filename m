Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D430CCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rTD-0002l2-IT; Thu, 09 Oct 2025 10:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6rT8-0002kA-0k
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6rT0-0000th-0z
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760019474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ymHKgbrV3naM8m+4hDW6vw3GtCo7y/Pec/5CASqYulw=;
 b=RIopg012iCudbWB6FysXM7IHZb9dWthx/qf640RrRKlO8nOUA7Fbtpqc9Kv4aO2OOxPp39
 oNDvYIFneCU1E3rddznJgEOIPR1m75QtgLN7V7k87YTciLwx/+ZXudCYKiCt40claG0RQj
 kt0lb8iQOFRwrrelrdbf/N/FRROdFOI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-8t-cpI_VOE6aQDIS5Os3pw-1; Thu,
 09 Oct 2025 10:17:51 -0400
X-MC-Unique: 8t-cpI_VOE6aQDIS5Os3pw-1
X-Mimecast-MFC-AGG-ID: 8t-cpI_VOE6aQDIS5Os3pw_1760019470
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0B311800592; Thu,  9 Oct 2025 14:17:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0551E18004D8; Thu,  9 Oct 2025 14:17:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3527D21E6A27; Thu, 09 Oct 2025 16:17:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  eblake@redhat.com,  jasowang@redhat.com,
 devel@lists.libvirt.org,  pbonzini@redhat.com,
 marcandre.lureau@redhat.com,  yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, qemu-trivial@nongnu.org
Subject: Re: [PATCH 0/2] remove deprecated 'reconnect' options
In-Reply-To: <20250924133309.334631-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 24 Sep 2025 16:33:07 +0300")
References: <20250924133309.334631-1-vsementsov@yandex-team.ru>
Date: Thu, 09 Oct 2025 16:17:46 +0200
Message-ID: <877bx4p3at.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> They were deprecated in 9.2, now we can remove them.
> New options to use are reconnect-ms.

Acked-by: Markus Armbruster <armbru@redhat.com>

Who would like to merge this?

* Marc-Andr=C3=A9, since PATCH 1 is chardev

* Jason, since PATCH 2 is net

* Myself, since both touch qapi/

* qemu-trivial


