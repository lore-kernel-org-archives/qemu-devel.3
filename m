Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40169C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 10:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGxyJ-0001Ic-D4; Mon, 19 May 2025 06:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uGxyH-0001IO-HN
 for qemu-devel@nongnu.org; Mon, 19 May 2025 06:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uGxyF-0000br-RN
 for qemu-devel@nongnu.org; Mon, 19 May 2025 06:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747651426;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfitW2OPWGY6f639pJt5qL9rwjMs2hfcXT9eecooW8I=;
 b=VaXhN780cr9Ec8SMZTc82VgvsxP0Ei31mLb6ZNFzK9zhj1cSIWSrujZ01nRRJOWGUTfYrL
 3iYw2AI2mpTNQz+vOa6it2vqtfh5Z1dMcrM9NxVvUDBmXvRk8eHFZD1hxWZTyJK1tEjYio
 aCIDps9MnVUnWqqF3cytEdx73elIYCI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-q_S5RSCzOFW0tP6qkHMfrQ-1; Mon,
 19 May 2025 06:43:42 -0400
X-MC-Unique: q_S5RSCzOFW0tP6qkHMfrQ-1
X-Mimecast-MFC-AGG-ID: q_S5RSCzOFW0tP6qkHMfrQ_1747651422
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3DEF1956094; Mon, 19 May 2025 10:43:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D467C1956095; Mon, 19 May 2025 10:43:39 +0000 (UTC)
Date: Mon, 19 May 2025 11:43:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 6/7] util/qemu-sockets: Refactor inet_parse() to use
 QemuOpts
Message-ID: <aCsLWCXlUQyh53LD@redhat.com>
References: <20250516155710.2246148-1-jmarcin@redhat.com>
 <20250516155710.2246148-7-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250516155710.2246148-7-jmarcin@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

On Fri, May 16, 2025 at 05:56:58PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> Currently, the inet address parser cannot handle multiple options where
> one is prefixed with the name of the other. For example, with the
> 'keep-alive-idle' option added, the current parser cannot parse
> '127.0.0.1:5000,keep-alive-idle=60,keep-alive' correctly. Instead, it
> fails with "error parsing 'keep-alive' flag '-idle=60,keep-alive'".
> 
> To resolve these issues, this patch rewrites the inet address parsing
> using the QemuOpts parser, which the inet_parse_flag() function tries to
> mimic. This new parser supports all previously supported options and on
> top of that the 'numeric' flag is now also supported. The only
> difference is, the new parser produces an error if an unknown option is
> passed, instead of silently ignoring it.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  tests/unit/test-util-sockets.c |   4 +-
>  util/qemu-sockets.c            | 158 +++++++++++++++------------------
>  2 files changed, 77 insertions(+), 85 deletions(-)
> 
> diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
> index 60f15a4ddf..77d0767b9b 100644
> --- a/tests/unit/test-util-sockets.c
> +++ b/tests/unit/test-util-sockets.c
> @@ -449,6 +449,8 @@ static void test_inet_parse_all_options_good(void)
>      InetSocketAddress exp_addr = {
>          .host = host,
>          .port = port,
> +        .has_numeric = true,
> +        .numeric =  true,
>          .has_to = true,
>          .to = 5006,
>          .has_ipv4 = true,
> @@ -463,7 +465,7 @@ static void test_inet_parse_all_options_good(void)
>  #endif
>      };
>      inet_parse_test_helper(
> -        "[::1]:5000,to=5006,ipv4=off,ipv6=on,keep-alive"
> +        "[::1]:5000,numeric,to=5006,ipv4=off,ipv6=on,keep-alive"
>  #ifdef HAVE_IPPROTO_MPTCP
>          ",mptcp"
>  #endif

Squash into the previous patch


If you do that, then for the remainder

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


