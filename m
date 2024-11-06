Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DECD3E798
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 09:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8cMg-00043J-Uu; Wed, 06 Nov 2024 04:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8cMf-00042b-NN
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:30:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8cMd-00081x-OZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730885410;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kkuwZvg/CYDq/besXcFtwA5ZKPrzoZPQGOcZgXIHYJo=;
 b=FBFC0WqclUCj5gRGL5iUuvsf9CsospMQTQwrUGBHaMOZwZb7mUMEcgPWKP70hb0gQVwzWD
 95GrB/BOsy26Fb0B8WLFcTJxnAETwt/jNOK9AAlTSpKPsbdzrUkK+9s4DUNP0GCMwMOK98
 f4q5DUjwm1aaW5Uo6ldtF7sHOehBb0E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-weAJfzOXO0SkbPNJsS-5SQ-1; Wed,
 06 Nov 2024 04:30:07 -0500
X-MC-Unique: weAJfzOXO0SkbPNJsS-5SQ-1
X-Mimecast-MFC-AGG-ID: weAJfzOXO0SkbPNJsS-5SQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 245551955F3C; Wed,  6 Nov 2024 09:30:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31CB71956088; Wed,  6 Nov 2024 09:30:02 +0000 (UTC)
Date: Wed, 6 Nov 2024 09:29:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 03/22] tests/qtest/migration: Stop calling everything
 "test"
Message-ID: <Zys3F6326kF5W2Br@redhat.com>
References: <20241105180837.5990-1-farosas@suse.de>
 <20241105180837.5990-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105180837.5990-4-farosas@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 05, 2024 at 03:08:18PM -0300, Fabiano Rosas wrote:
> Test frameworks usually prefix "test_" to the entry point of the test
> code. Having every function prefixed with test_ makes it hard to
> understand the code and to grep for the actual tests.
> 
> Remove the "test" prefix from everything that is not a test.
> 
> In order to still keep some namespacing, stick to the "migrate_"
> prefix, which is the most used currently.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> note: I would prefer the prefix "mig_" to avoid using "migrate_" which
> is a verb, but several functions such as migrate_qmp() would have to
> be given an entirely new name to keep expressiveness and I want to
> keep this a mechanical change.
> ---
>  tests/qtest/migration-test.c | 410 +++++++++++++++++------------------
>  1 file changed, 205 insertions(+), 205 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 04890e0479..a40451df1e 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c

> @@ -919,9 +919,9 @@ struct TestMigrateTLSPSKData {
>  };
>  
>  static void *
> -test_migrate_tls_psk_start_common(QTestState *from,
> -                                  QTestState *to,
> -                                  bool mismatch)
> +migrate_tls_psk_start_common(QTestState *from,
> +                             QTestState *to,
> +                             bool mismatch)
>  {
>      struct TestMigrateTLSPSKData *data =
>          g_new0(struct TestMigrateTLSPSKData, 1);
> @@ -964,23 +964,23 @@ test_migrate_tls_psk_start_common(QTestState *from,
>  }
>  
>  static void *
> -test_migrate_tls_psk_match_start(QTestState *from,
> -                                 QTestState *to)
> +migrate_tls_psk_match_start(QTestState *from,
> +                            QTestState *to)

My inclination is usually to go from most general, to
most specific, left-to-right. I think it is also worth
distinguishing these functions as hooks, which would
suggest:

  migrate_hook_start_psk_match

That makes it easy to identify all hooks by grepping
for 'migrate_hook', or identify all start hooks by
grepping 'migrate_hook_start', or all PSK start
hooks with 'migrate_hook_star_psk'.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


