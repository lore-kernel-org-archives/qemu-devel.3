Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF58C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 09:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwytO-0007UC-Ul; Thu, 20 Aug 2026 05:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wwytN-0007Ty-9N
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 05:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wwytL-0007Va-NM
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 05:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787217414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bpHna6wP0Ley8lIGpZRXmpAgnbZFmLgNWcMA/+hwyII=;
 b=KHrBiVv7kquvhZgAAhr9zNYLyIerGYNq+eUjzEHg2zVorOdKAO1viS/lfi8COsy7CP54EH
 cWUJocRZFzxavqtYVsjki/YHEORHVFuquQZwDexxfSXLTBuyGtnHBb34oU8EoluKsPQeMg
 Y8/JaNvTB7RDOS3fGBSUVhYRasUlAHk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-XAm8tHoMMs-TH8ZPokDPZw-1; Thu,
 20 Aug 2026 05:16:51 -0400
X-MC-Unique: XAm8tHoMMs-TH8ZPokDPZw-1
X-Mimecast-MFC-AGG-ID: XAm8tHoMMs-TH8ZPokDPZw_1787217409
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 274AF1955BDD; Thu, 20 Aug 2026 09:16:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65B1519560AB; Thu, 20 Aug 2026 09:16:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ECA8021E6920; Thu, 20 Aug 2026 11:16:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  mst@redhat.com,  peterx@redhat.com,
 farosas@suse.de,  raphael.s.norwitz@gmail.com,  bchaney@akamai.com,
 qemu-devel@nongnu.org,  berrange@redhat.com,  pbonzini@redhat.com,
 yc-core@yandex-team.ru,  mark.caveayland@nutanix.com,  Jason Wang
 <jasowangio@gmail.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v21 15/16] net/tap: support local migration with virtio-net
In-Reply-To: <20260819180201.1970193-16-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 19 Aug 2026 21:01:58 +0300")
References: <20260819180201.1970193-1-vsementsov@yandex-team.ru>
 <20260819180201.1970193-16-vsementsov@yandex-team.ru>
Date: Thu, 20 Aug 2026 11:16:45 +0200
Message-ID: <87cxvd2ltu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

> Support transferring of TAP state (including open fd).
>
> Add new property "x-permit-local-migration", which defines whether
> local migration is actually permitted for this TAP device.
>
> Note that local-migration is enabled by global "local" migration
> parameter, but individual devices may have additional options to
> enable/disable it per device.
>
> The tricky thing is that we need to know whether to call open/connect in
> TAP initialization code, i.e. we need to know the value of migration
> parameter "local" when creating the TAP device.  For incoming migration,
> we can know only for TAP devices created with QMP after setting the
> migration parameter with QMP.
>
> So the full picture is:
>
> On source, to start outgoing "local" migration you need:
>
>  - migration parameter "local" set to true
>  - "x-permit-local-migration" TAP option set to true
>
> If at least one of these options is not set, TAP backend
> doesn't participate in migration.
>
> On target, things are more difficult:
>
> Same, you need both "local" and "x-permit-local-migration"
> be set. And same, if one of them is not set, TAP backend
> is initialized as usual, and doesn't accept any incoming
> state.
>
> Additionally, if you are going to set "local", it must be
> set before creating the TAP device. If TAP device created
> with "local" unset, it initializes as usual. If you enable
> "local" after it and start incoming migration, it will fail
> in .pre_load handler of TAP backend.
>
> Moreover, there are interface restrictions: if you create TAP
> device when QEMU is in INCOMING state, and both "local"
> and "x-permit-local-migration" set, most of TAP options are
> not allowed, and script/downscript are required to be explicitly
> disabled.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Ben Chaney <bchaney@akamai.com>

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


