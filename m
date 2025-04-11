Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296FCC369AE
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 13:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3EjI-0007U1-WB; Fri, 11 Apr 2025 09:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u3EjH-0007To-Eu
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u3EjF-0002hN-Lg
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744379252;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8fI29rRsUxCaC4A9juoyUkoHqOSnRZMZNlq/tLX5EG8=;
 b=cQApxXMEgc6Rw8TNIa/NBxfQnv46xOaceqidSnjoTqvj0OSxdElHPspSmNBdx/nw3FFW1z
 qfw7l6AQ+8C31aFZueloMuPyqjbdCKW4Sr/3Wm+PLoiAw7uol8SVLh9Rx8Iqt7nk2qwwWC
 lxFxEXWjAd9DFh/qEzPVwlPpGJKvF84=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-Alv6s-xxOD2uvWqft71YOQ-1; Fri,
 11 Apr 2025 09:47:27 -0400
X-MC-Unique: Alv6s-xxOD2uvWqft71YOQ-1
X-Mimecast-MFC-AGG-ID: Alv6s-xxOD2uvWqft71YOQ_1744379246
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8055118007E1; Fri, 11 Apr 2025 13:47:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EC861956094; Fri, 11 Apr 2025 13:47:22 +0000 (UTC)
Date: Fri, 11 Apr 2025 14:47:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 3/5] util/qemu-sockets: Refactor success and failure
 paths in inet_listen_saddr()
Message-ID: <Z_kdZ0DGj4Xg7zXO@redhat.com>
References: <20250408112508.1638722-1-jmarcin@redhat.com>
 <20250408112508.1638722-4-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250408112508.1638722-4-jmarcin@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 08, 2025 at 01:25:02PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> To get a listening socket, we need to first create a socket, try binding
> it to a certain port, and lastly starting listening to it. Each of these
> operations can fail due to various reasons, one of them being that the
> requested address/port is already in use. In such case, the function
> tries the same process with a new port number.
> 
> This patch refactors the port number loop, so the success path is no
> longer buried inside the 'if' statements in the middle of the loop. Now,
> the success path is not nested and ends at the end of the iteration
> after successful socket creation, binding, and listening. In case any of
> the operations fails, it either continues to the next iteration (and the
> next port) or jumps out of the loop to handle the error and exits the
> function.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  util/qemu-sockets.c | 51 ++++++++++++++++++++++++---------------------
>  1 file changed, 27 insertions(+), 24 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


