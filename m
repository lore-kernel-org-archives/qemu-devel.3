Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBA8C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTZd-0008Bs-2D; Wed, 08 Jul 2026 10:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whTZM-0008AR-Kw
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:48:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whTZJ-0001KB-KY
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783522084;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tLamfs3fFIjKpIqk8th09odxTal0uPX5Sje2UWCbq+k=;
 b=Pi2jCkqwBWDxruJeGF77weD+a3YxTeRigVVl5pmRcebqy0vhbq6Vo3k/G2W3VY52/stSza
 G55OvBq04fmhQRdvwawnk1hx1qhQaEiLZEeaBoySH9zJuoYhCGRaSD5I+Rf92R1O0OpfN+
 YqGg100y24bIQCmfweZw4LL3drUDvV0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-Ulg3GMqrMty5vhBNPAY-KQ-1; Wed,
 08 Jul 2026 10:48:03 -0400
X-MC-Unique: Ulg3GMqrMty5vhBNPAY-KQ-1
X-Mimecast-MFC-AGG-ID: Ulg3GMqrMty5vhBNPAY-KQ_1783522082
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F56C19560B1; Wed,  8 Jul 2026 14:48:02 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 072E1180066F; Wed,  8 Jul 2026 14:47:58 +0000 (UTC)
Date: Wed, 8 Jul 2026 15:47:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/char/virtio-serial-bus: validate nr_active_ports from
 migration stream
Message-ID: <ak5jG_HOBzM1HzbX@redhat.com>
References: <20260708144112.1830881-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260708144112.1830881-1-lvivier@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 08, 2026 at 04:41:12PM +0200, Laurent Vivier wrote:
> The migration restore path reads nr_active_ports from the incoming
> stream and passes it directly to fetch_active_ports_list(), which
> uses it to size a heap allocation. A crafted migration stream can set
> this field to a very large value, causing QEMU to attempt a
> multi-gigabyte allocation and abort.
> 
> Fix this by checking nr_active_ports against the configured
> max_virtserial_ports before calling fetch_active_ports_list().
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3801
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/char/virtio-serial-bus.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


