Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1707CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3Il-0003cG-K6; Mon, 01 Sep 2025 08:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3Ik-0003bv-0H
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:06:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3Ig-0005RK-Gr
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756728374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=YfMdj4nM69HXMYZ8NFXOkodUUuoC1+mZxTUFVl/qQdU=;
 b=XjiNkWvZl39uYAR1yRQ1GoXVoMZCU6fJeM2gvZnW2nUEz5VxdQXf7XxnDF4Lqr/9c/yqHQ
 OHa6uGLmlapWA8SOLql4byDh8+Mx+dMdi5T8iWPdkg3YBUuOyN9QQu/xLQtc576zR2hjGT
 fZkTieVhWOnFEs1NLvyVg2jdvfDOnmI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-AZ9arXHlOxWKGteyx8ZXZw-1; Mon,
 01 Sep 2025 08:06:12 -0400
X-MC-Unique: AZ9arXHlOxWKGteyx8ZXZw-1
X-Mimecast-MFC-AGG-ID: AZ9arXHlOxWKGteyx8ZXZw_1756728372
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1D7E195C277
 for <qemu-devel@nongnu.org>; Mon,  1 Sep 2025 12:06:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A01918003FC
 for <qemu-devel@nongnu.org>; Mon,  1 Sep 2025 12:06:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D259821E6A27; Mon, 01 Sep 2025 14:06:08 +0200 (CEST)
Resent-To: qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 01 Sep 2025 14:06:08 +0200
Resent-Message-ID: <878qiy5qdr.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,  kraxel@redhat.com
Subject: Re: [PATCH] ui/keymaps: Avoid trace crash and improve error messages
In-Reply-To: <20250723131504.1482657-1-armbru@redhat.com> (Markus Armbruster's
 message of "Wed, 23 Jul 2025 15:15:04 +0200")
References: <20250723131504.1482657-1-armbru@redhat.com>
Date: Mon, 01 Sep 2025 13:12:56 +0200
Message-ID: <877byi77ev.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> parse_keyboard_layout() passes a possibly null @filename to
> trace_keymap_parse().  Trace backend log then formats it with %s,
> which crashes on some systems.
>
> Fix by moving the null check before the trace_keymap_parse().
>
> While there, improve the error messages a bit.
>
> Fixes: d3b787fa7dde (keymaps: add tracing)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Queued.  Thanks for the review!


