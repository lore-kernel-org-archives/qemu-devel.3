Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EF2CCF9F1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 09:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEPDH-0008Bi-E1; Thu, 30 Oct 2025 05:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEPDG-0008BT-0Q
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:44:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEPD2-0007jl-9R
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761817478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hU2MdMbuB/v+aY0A7qINe8SBTjy1hc9rPgV+pSJQrrQ=;
 b=JFVh6JvFwcJ/HJC2l/h6YasUi/fTqM9WMax+uGEj2AsjPcXkuc1PCnO0Ok0Cxf3lhfgmqI
 ldv5jc81N5xSpDe1ZkkJ8cqXPD0ouFyJQu+V4zbzOEwPkto+utsN0hXM1hP+kTysRfnWQx
 fnSbSPH33fZX1lUZUjhnOMIm+8X1+Ek=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-xQwQfn1zO32m9PsGcVtAkA-1; Thu,
 30 Oct 2025 05:44:36 -0400
X-MC-Unique: xQwQfn1zO32m9PsGcVtAkA-1
X-Mimecast-MFC-AGG-ID: xQwQfn1zO32m9PsGcVtAkA_1761817475
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D32FD1956058; Thu, 30 Oct 2025 09:44:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3465F1955BE3; Thu, 30 Oct 2025 09:44:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7B52521E6A27; Thu, 30 Oct 2025 10:44:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  devel@lists.libvirt.org,  eblake@redhat.com,
 farosas@suse.de,  lvivier@redhat.com,  pbonzini@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v5] qapi: net: deprecate vhostforce option
In-Reply-To: <20251028152400.45938-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 28 Oct 2025 18:23:59 +0300")
References: <20251028152400.45938-1-vsementsov@yandex-team.ru>
Date: Thu, 30 Oct 2025 10:44:31 +0100
Message-ID: <87h5vgk9kw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> This option for tap and vhost-user netdevs doesn't make sense
> since long ago (10 years!), starting from commits:
>
>  1e7398a140f7a6 ("vhost: enable vhost without without MSI-X")
>  24f938a682d934 ("vhost user:support vhost user nic for non msi guests")
>
> Prior these commits, to enable kernel vhost-net, or vhost-user-net for
> some specific kind of guests (that don't have MSI-X support), you should
> have set vhostforce=on.
>
> Now guest type doesn't matter, all guests are equal for these
> options logic.
>
> For tap the current logic is:
>   vhost=on / vhost=off : vhostforce ignored, doesn't make sense
>   vhost unset : vhostforce counts, enabling vhost
>
> So you may enable vhost for tap several ways:
> - vhost=on
> - vhostforce=on
> - vhost=on + vhostforce=on
> - and even vhost=on + vhostforce=off
>
> - they are all equal.
>
> For vhost-user we simply ignore the vhostforce option at all in the
> code.
>
> Let's finally deprecate the extra options.
>
> Also, fix @vhostforce documentation everywhere to show the real picture,
> and update vhost-user test to not use deprecated option.
>
> While updating command line options, drop "experimental" word from
> "experimental in kernel accelerator". vhost-net is in production for
> years.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


