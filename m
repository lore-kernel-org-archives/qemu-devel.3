Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA038CE8D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 12:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srG1v-00018b-Km; Thu, 19 Sep 2024 08:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1srG1t-00017D-7C
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:13:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1srG1q-0001wL-4D
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 08:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726747974;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAEmQYvogYiSU0i4rYgxoJalQaWb6NynEl1e45qa6H0=;
 b=hQsWbeIdpkiVsWHvaMUDOiJSV1WbyMuev4GAbVT1susbrs1HziDwReegs2wjyOl8El8rO3
 Yky1khPkbL+ic1VzFLhwMa6y3FR04BhF6mj5I7e+lhL+h7jixFFOrVJ4xm7/GbXW3O7YGa
 sfwn84zTn2GEdk4SS27dHAmBpKIdyPI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-3_6gp3ExPxGC5n7b4Klvxw-1; Thu,
 19 Sep 2024 08:12:49 -0400
X-MC-Unique: 3_6gp3ExPxGC5n7b4Klvxw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DE481954B1B; Thu, 19 Sep 2024 12:12:48 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.100])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 293EB19560A3; Thu, 19 Sep 2024 12:12:46 +0000 (UTC)
Date: Thu, 19 Sep 2024 14:12:43 +0200
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: dave@treblig.org
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] sockets: Remove deadcode
Message-ID: <ZuwVLemC3hVirWGZ@redhat.com>
References: <20240918232633.463861-1-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240918232633.463861-1-dave@treblig.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Sep 19, 2024 at 12:26:33AM +0100, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> socket_remote_address hasn't been used since it was added in
>   17c55decec ("sockets: add helpers for creating SocketAddress from a socket")
> 
> inet_connect hasn't been used since 2017's
>   8ecc2f9eab ("sheepdog: Use SocketAddress and socket_connect()")

Excellent ! The more of sockets.h we can remove the better.

> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>  include/qemu/sockets.h | 16 ----------------
>  util/qemu-sockets.c    | 35 -----------------------------------
>  2 files changed, 51 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

and queued.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


