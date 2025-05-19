Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE37EC3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 10:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGxwm-0000go-2r; Mon, 19 May 2025 06:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uGxwk-0000gR-BX
 for qemu-devel@nongnu.org; Mon, 19 May 2025 06:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uGxwi-0000Qn-5x
 for qemu-devel@nongnu.org; Mon, 19 May 2025 06:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747651329;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=iJICt/bzpw9K1Gw3j5c6LNsvFkcltxDHb2X1LcYaZoc=;
 b=iAPFzhvItR4NVp/YDDhpk8EEPa5ME65/fTFfRbBYnj+6CJ4Ydt/ZLqAphXZHC0qL9pcGCH
 sORkzar06F650dKg+EKfr0Hg3fxMkPUkQjOj6aT+h28Kv7giHqAmsE1/2nYVQm1OGqiA7+
 cGw7EhrDsd3clfcRN5jA2atioxoXNis=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-mxFRxu9iM06-uBPp3qZvyw-1; Mon,
 19 May 2025 06:42:08 -0400
X-MC-Unique: mxFRxu9iM06-uBPp3qZvyw-1
X-Mimecast-MFC-AGG-ID: mxFRxu9iM06-uBPp3qZvyw_1747651327
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DE071955D8A; Mon, 19 May 2025 10:42:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C5621955F1B; Mon, 19 May 2025 10:42:04 +0000 (UTC)
Date: Mon, 19 May 2025 11:42:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 5/7] tests/unit/test-util-sockets: Add tests for
 inet_parse()
Message-ID: <aCsK-czEW0xTY84d@redhat.com>
References: <20250516155710.2246148-1-jmarcin@redhat.com>
 <20250516155710.2246148-6-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250516155710.2246148-6-jmarcin@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Fri, May 16, 2025 at 05:56:57PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> Before refactoring the inet_parse() function, this patch adds tests
> verifying the inet address parsing works correctly.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  tests/unit/test-util-sockets.c | 161 +++++++++++++++++++++++++++++++++
>  1 file changed, 161 insertions(+)
> 
> diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
> index 4c9dd0b271..60f15a4ddf 100644
> --- a/tests/unit/test-util-sockets.c
> +++ b/tests/unit/test-util-sockets.c
> @@ -332,6 +332,144 @@ static void test_socket_unix_abstract(void)

> +static void test_inet_parse_all_options_good(void)
> +{
> +    char host[] = "::1";
> +    char port[] = "5000";
> +    InetSocketAddress exp_addr = {
> +        .host = host,
> +        .port = port,
> +        .has_to = true,
> +        .to = 5006,
> +        .has_ipv4 = true,
> +        .ipv4 = false,
> +        .has_ipv6 = true,
> +        .ipv6 = true,
> +        .has_keep_alive = true,
> +        .keep_alive = true,
> +#ifdef HAVE_IPPROTO_MPTCP
> +        .has_mptcp = true,
> +        .mptcp = true,
> +#endif
> +    };
> +    inet_parse_test_helper(
> +        "[::1]:5000,to=5006,ipv4=off,ipv6=on,keep-alive"
> +#ifdef HAVE_IPPROTO_MPTCP
> +        ",mptcp"
> +#endif
> +        , &exp_addr, true);
> +}

This example is using bare 'keep-alive' and 'mptcp' options, but
this is discouraged syntax. It is fine to test it, but we should
have a 2nd test case with 'keep-alive=on', 'mptcp=on', etc.

In fact, the ipv4/ipv6 options are flags too, which can omit
the "=on" bit, so test both with & without for those too.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


