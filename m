Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3900C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Qss-0006fX-6P; Tue, 15 Sep 2026 06:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6Qsl-0006bQ-IB
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6Qsj-0004aK-6d
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789469958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9O+ezIjr5/Y0LBDet7rz8QyIfw1Sw8dwi5harGh+4cA=;
 b=DkNqsX4fgtDVSXWXDl0yTENduguC3wUGGmUm1wraYQa4KIj60zbYYoPVpQ1VPcwvp9H1jY
 /UiRYWl8FPTkzUy5GsTSoNwunZj4MaVaMVlCtwuFgK1IIzk6mzf1c2aNQbbs+YEPFCIgcJ
 fEt1fvXcCC0xCDX4hJwrt3+AY/e7Rnw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-CgBm5K9sN2WCxDLLYy9Nhg-1; Tue,
 15 Sep 2026 06:59:15 -0400
X-MC-Unique: CgBm5K9sN2WCxDLLYy9Nhg-1
X-Mimecast-MFC-AGG-ID: CgBm5K9sN2WCxDLLYy9Nhg_1789469954
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73F5219128B6; Tue, 15 Sep 2026 10:59:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16C1E1956057; Tue, 15 Sep 2026 10:59:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A0EC821E6A04; Tue, 15 Sep 2026 12:59:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  'Daniel P .
 =?utf-8?Q?Berrang=C3=A9'?= <berrange@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH V17 12/13] iothread: make legacy AioContext getter
 explicitly unsafe
In-Reply-To: <20260915101655.3216101-13-zhangckid@gmail.com> (Zhang Chen's
 message of "Tue, 15 Sep 2026 18:16:54 +0800")
References: <20260915101655.3216101-1-zhangckid@gmail.com>
 <20260915101655.3216101-13-zhangckid@gmail.com>
Date: Tue, 15 Sep 2026 12:59:11 +0200
Message-ID: <87bj9yrda8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Zhang Chen <zhangckid@gmail.com> writes:

> Now that holder-aware callers have been converted, rename
> iothread_get_aio_context() to iothread_unsafe_get_aio_context() and
> update qmp_x_blockdev_set_iothread().
>
> The block graph retains only the AioContext, while detachment happens
> outside qmp_x_blockdev_set_iothread(), so this call site cannot provide
> a matching holder lifecycle. The new name makes its existing lifetime
> assumption explicit.

Suggest something like

  The only remaining user is qmp_x_blockdev_set_iothread().  It cannot
  use iothread_ref_and_get_aio_context() as is, because it ties the
  AioContext to the block node, and iothread_unref_and_put_aio_context()
  would have to be called when that tie is broken.

> New code should use iothread_ref_and_get_aio_context().
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


