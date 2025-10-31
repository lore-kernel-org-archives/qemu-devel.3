Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4109CCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 13:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEpZY-0005TK-7G; Fri, 31 Oct 2025 09:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEpZU-0005Sh-Ha
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEpZO-0002K3-C0
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761918807;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BlegvYVlcib+eb4+DrTyeTwvHY1lb0LbwtGyACKkhrw=;
 b=VMF9098aIpx3OeQmcrJPU1C2bU0q1z1gqktQ8fGdRij1HtRoqaDmJxl3I0TlSH0j8xPzfN
 vwdg/YqX/HrhA/0yapPajSLGPAVOcm+fl3xQdUaMEzaVfhzGJ8v3GvGy9VpwjnOVuJ7cfJ
 FYfcpE3qKcP5ohMI/ZFTz6vMwu1L7vg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-j_-Xuy9RNZSgjmEslVKeXg-1; Fri,
 31 Oct 2025 09:53:25 -0400
X-MC-Unique: j_-Xuy9RNZSgjmEslVKeXg-1
X-Mimecast-MFC-AGG-ID: j_-Xuy9RNZSgjmEslVKeXg_1761918804
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7812518002F9; Fri, 31 Oct 2025 13:53:24 +0000 (UTC)
Received: from redhat.com (dhcp-17-192.lcy.redhat.com [10.42.17.192])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A94F19560A2; Fri, 31 Oct 2025 13:53:23 +0000 (UTC)
Date: Fri, 31 Oct 2025 13:53:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] io/channel: Have read/write functions take void * buffer
 argument
Message-ID: <aQS_ULZEGQSPrM63@redhat.com>
References: <20251031091351.27625-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251031091351.27625-1-philmd@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 31, 2025 at 10:13:51AM +0100, Philippe Mathieu-Daudé wrote:
> I/O channel read/write functions can operate on any area of
> memory, regardless of the content their represent. Do not
> restrict to array of char, use the void* type, which is also
> the type of the underlying iovec::iov_base field.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/crypto/tlssession.h |  4 ++--
>  include/io/channel.h        | 14 +++++++-------
>  io/channel-tls.c            |  4 ++--
>  io/channel.c                | 14 +++++++-------
>  4 files changed, 18 insertions(+), 18 deletions(-)

Also needs a change to tests:


diff --git a/tests/unit/test-crypto-tlssession.c b/tests/unit/test-crypto-tlssession.c
index d0baf3b304..0d06a6892e 100644
--- a/tests/unit/test-crypto-tlssession.c
+++ b/tests/unit/test-crypto-tlssession.c
@@ -36,7 +36,7 @@
 #define KEYFILE WORKDIR "key-ctx.pem"
 
 static ssize_t
-testWrite(const char *buf, size_t len, void *opaque, Error **errp)
+testWrite(const void *buf, size_t len, void *opaque, Error **errp)
 {
     int *fd = opaque;
     int ret;
@@ -54,7 +54,7 @@ testWrite(const char *buf, size_t len, void *opaque, Error **errp)
 }
 
 static ssize_t
-testRead(char *buf, size_t len, void *opaque, Error **errp)
+testRead(void *buf, size_t len, void *opaque, Error **errp)
 {
     int *fd = opaque;
     int ret;


which I've made locally when queuing this patch, so no need to resend.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


