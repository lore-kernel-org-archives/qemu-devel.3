Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F88CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fGf-0004IN-47; Tue, 14 Oct 2025 09:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8fGX-0004A9-Ps
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8fGU-0001hh-FX
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449231;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XTC2RrrB6xweYC0Ajkktb7AoOX0SYgbkHGC1J1h6wrA=;
 b=VkH+fG6oc7Vvw06pYAfb2Ct8+SXPtbwtogZfPSds3Umg3V5WraF1tqzaDgktNYEXwbbROg
 harGveNnexCpkd2+XT4ZuFI2KR09c7GW0ygKrRGOqP73kc3nhwdjLU2GmI0siQ3GIvJeBs
 zT8LGb+VG7erohvEWaUmydTmT7gwbzc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-DLzMK1VpN0CmOs_JVucs2A-1; Tue,
 14 Oct 2025 09:40:25 -0400
X-MC-Unique: DLzMK1VpN0CmOs_JVucs2A-1
X-Mimecast-MFC-AGG-ID: DLzMK1VpN0CmOs_JVucs2A_1760449224
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 442831800577; Tue, 14 Oct 2025 13:40:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.198])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44BBC1954107; Tue, 14 Oct 2025 13:40:19 +0000 (UTC)
Date: Tue, 14 Oct 2025 14:40:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, eduardo@habkost.net,
 qemu-devel@nongnu.org, raphael@enfabrica.net, armbru@redhat.com,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Subject: Re: [PATCH v2 0/7] chardev: postpone connect
Message-ID: <aO5Sv8i4rxLFi-XF@redhat.com>
References: <20251013133836.852018-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013133836.852018-1-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Oct 13, 2025 at 04:38:29PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> That's a preparation for backend-transfer migration of
> vhost-user-blk. For such migration we are going to transfer
> vhost-user-blk fds, including backend chardev fd to the target
> in migration stream (backed by UNIX domain socket).
> 
> So, on the target, we want to know, should we call connect(),
> or is it a backend-transfer migration, and we should wait for
> incoming fd.
> 
> But at initialization time we can't know it: user may setup
> migration parameters (enabling backend-transfer) later.
> 
> So, let's postpone chardev open/connect phase up to attaching
> to frontend. At this point we can check:
> 
> - if it's vhost-user-blk, do nothing, let vhost-user-blk decide
>   when to do connect()
> - otherwise, do connect() at this point

I'm finding it quite unpleasant that we've created a new set of
callbacks just for the socket backend, and not the other chardev
backends.

Conceptually it feels like the problem of transferring in pre-
opened FDs from a previous QEMU should be conceptually relevant
to all the backend types. If it is, then I very much want us to
convert all the backends instead of leaving a pile of technical
debt for someone else in the future.

This series also doesn't illustrate usage of the new model with
pre-opened FDs, so I'm finding it hard to validate whether
this design is effective or not.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


