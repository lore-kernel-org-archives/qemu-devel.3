Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9ADC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 10:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGxzV-0001uz-OA; Mon, 19 May 2025 06:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uGxzS-0001s3-Vc
 for qemu-devel@nongnu.org; Mon, 19 May 2025 06:45:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uGxzR-0000iK-1Z
 for qemu-devel@nongnu.org; Mon, 19 May 2025 06:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747651500;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RW8oVP76G/byj0zrRscx8O+zcUOe4OuKkTWpdeI87UY=;
 b=DHLDUi2AhF6sUaypwz2cihgppTuKLUb4wDDGHRilEtcM1owlFXpI8Gi/Xd5F6CldLZml8S
 TcwQKHLehLhszApPbpdvek4LxmJK/7tx4Ub/nhmTNJF9cPTI4I9mg7mKWmXy333yaGabJz
 mbTWYoM2drSYgXolpcOotNuQVI+ktIc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649--5XhyLWwNHGokyvqdSD-ug-1; Mon,
 19 May 2025 06:44:58 -0400
X-MC-Unique: -5XhyLWwNHGokyvqdSD-ug-1
X-Mimecast-MFC-AGG-ID: -5XhyLWwNHGokyvqdSD-ug_1747651498
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96C86180048E; Mon, 19 May 2025 10:44:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B63ED180045B; Mon, 19 May 2025 10:44:55 +0000 (UTC)
Date: Mon, 19 May 2025 11:44:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 7/7] util/qemu-sockets: Introduce inet socket options
 controlling TCP keep-alive
Message-ID: <aCsLpHRY8qAU9YOF@redhat.com>
References: <20250516155710.2246148-1-jmarcin@redhat.com>
 <20250516155710.2246148-8-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250516155710.2246148-8-jmarcin@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 16, 2025 at 05:56:59PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> With the default TCP stack configuration, it could be even 2 hours
> before the connection times out due to the other side not being
> reachable. However, in some cases, the application needs to be aware of
> a connection issue much sooner.
> 
> This is the case, for example, for postcopy live migration. If there is
> no traffic from the migration destination guest (server-side) to the
> migration source guest (client-side), the destination keeps waiting for
> pages indefinitely and does not switch to the postcopy-paused state.
> This can happen, for example, if the destination QEMU instance is
> started with the '-S' command line option and the machine is not started
> yet, or if the machine is idle and produces no new page faults for
> not-yet-migrated pages.
> 
> This patch introduces new inet socket parameters that control count,
> idle period, and interval of TCP keep-alive packets before the
> connection is considered broken. These parameters are available on
> systems where the respective TCP socket options are defined, that
> includes Linux, Windows, macOS, but not OpenBSD. Additionally, macOS
> defines TCP_KEEPIDLE as TCP_KEEPALIVE instead, so the patch supplies its
> own definition.
> 
> The default value for all is 0, which means the system configuration is
> used.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  meson.build                    | 30 ++++++++++++
>  qapi/sockets.json              | 19 ++++++++
>  tests/unit/test-util-sockets.c | 33 ++++++++++++++
>  util/qemu-sockets.c            | 83 ++++++++++++++++++++++++++++++++++
>  4 files changed, 165 insertions(+)


Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


