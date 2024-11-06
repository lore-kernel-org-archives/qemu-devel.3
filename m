Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83214D44D4C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 11:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8e1E-0000sH-Hu; Wed, 06 Nov 2024 06:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8e1C-0000rV-2i
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:16:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8e19-00080X-Ir
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730891766;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9MG09nGgkxOvielq8awGIKMKnQb47hL6ovzb2UGoi7k=;
 b=Liy76VoDwyHN160QeTQV1qsc9u3x65xolXtV+qSDtPRH5YKx2kPXa6NFsiO2ecEWl1QV90
 Gr2FpQBXEcmt9HcirzUmNnsFZmrOug8MyWolssAkZI+E+R6ROt6MVPsVld703gqppKxH8B
 cjVWw0VClaKlXnoDYNZhhiBE5HZU50s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-l2sVFG9vOjyfANEOsEh8Fg-1; Wed,
 06 Nov 2024 06:16:05 -0500
X-MC-Unique: l2sVFG9vOjyfANEOsEh8Fg-1
X-Mimecast-MFC-AGG-ID: l2sVFG9vOjyfANEOsEh8Fg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 221131955D54; Wed,  6 Nov 2024 11:16:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.182])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8627119560AA; Wed,  6 Nov 2024 11:16:01 +0000 (UTC)
Date: Wed, 6 Nov 2024 11:15:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 12/22] tests/qtest/migration: Split TLS tests from
 migration-test.c
Message-ID: <ZytP7hMbUkkDS1MX@redhat.com>
References: <20241105180837.5990-1-farosas@suse.de>
 <20241105180837.5990-13-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105180837.5990-13-farosas@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Nov 05, 2024 at 03:08:27PM -0300, Fabiano Rosas wrote:
> The migration-test.c file has become unwieldy large. It's quite
> confusing to navigate with all the test definitions mixed with hook
> definitions. The TLS tests make this worse with ifdef'ery.
> 
> Since we're planning on having a smaller set of tests to run as smoke
> testing on all architectures, I'm taking the time to split some tests
> into their own file.
> 
> Move the TLS tests into a file of their own.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/meson.build                  |   8 +-
>  tests/qtest/migration-test.c             | 788 +---------------------
>  tests/qtest/migration/migration-common.h |   6 +
>  tests/qtest/migration/tls-tests.c        | 790 +++++++++++++++++++++++
>  4 files changed, 803 insertions(+), 789 deletions(-)
>  create mode 100644 tests/qtest/migration/tls-tests.c


> diff --git a/tests/qtest/migration/migration-common.h b/tests/qtest/migration/migration-common.h
> index 8d0081c698..c546e92259 100644
> --- a/tests/qtest/migration/tls-tests.c
> +++ b/tests/qtest/migration/tls-tests.c


> +
> +void migration_test_add_tls(MigrationTestEnv *env)
> +{
> +    tmpfs = env->tmpfs;
> +
> +    migration_test_add("/migration/precopy/unix/tls/psk",
> +                       test_precopy_unix_tls_psk);
> +

...snip...

> +}

Looking at this, and considering the later patch which introduces
'make qtest-<subsystem>' support, I wonder if we actually need to
have a single 'migration-test' binary. Why not just add a main()
method to this  test-tests.c, and have a 'migration-test-tls'
binary ?

"make qtest-migration" would provoide a way to run the same level
of functionality seen when everything was in one 'migration-test'
binary.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


