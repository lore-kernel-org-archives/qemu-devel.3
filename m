Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB7AD44D4C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 11:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8doR-00049h-Ks; Wed, 06 Nov 2024 06:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8doP-00049K-5t
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:02:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8doL-0001t1-LA
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730890972;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Rb4IU3YOsfMHo1dzYqpROIrkpU1GCOgXwkJta2knf4Y=;
 b=c4lMdIxdoRXlKhJp1Ya0F+MuyQH/H7RHuloFL5fqEqVFdpmlNZ4z/c9aeQCMWxxJ8hZvNs
 YMFRiBahyandLtEVYkXtJ/9rIZCul93Y26iVhmQNwtlCt4LpITRS6P9IyIiLRzq7NLypqX
 uYc7dmY3cIvjZhpVCVaGP/cNUrtoGBE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-K-lXN5j0Nzq0y4BgKBkg9Q-1; Wed,
 06 Nov 2024 06:02:48 -0500
X-MC-Unique: K-lXN5j0Nzq0y4BgKBkg9Q-1
X-Mimecast-MFC-AGG-ID: K-lXN5j0Nzq0y4BgKBkg9Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58D031955EA9; Wed,  6 Nov 2024 11:02:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.182])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B07AC1956088; Wed,  6 Nov 2024 11:02:44 +0000 (UTC)
Date: Wed, 6 Nov 2024 11:02:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 10/22] tests/qtest/migration: Isolate test initialization
Message-ID: <ZytM0bwMoxZdE3PR@redhat.com>
References: <20241105180837.5990-1-farosas@suse.de>
 <20241105180837.5990-11-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105180837.5990-11-farosas@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

On Tue, Nov 05, 2024 at 03:08:25PM -0300, Fabiano Rosas wrote:
> We currently have some environment validation to perform and flags to
> set during the initialization of the tests. To be able to add more
> migration test binaries, we'll need these tasks to be in their own
> function so they can be called from more than one place.
> 
> Move the initialization code to a function and introduce the
> MigrationTestEnv structure to hold the flags that are accessed during
> test registration.
> 
> Make the env object static to avoid have to change all the code to
> pass it around. Similarly with the tmpfs variable, which is used
> extensively.
> 
> Note: I'm keeping the new functions in migration-test.c because they
> are going to be moved in the next patch to the correct place.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-test.c           | 103 ++++++++++++++++---------
>  tests/qtest/migration/migration-util.c |   1 -
>  tests/qtest/migration/migration-util.h |   4 +-
>  3 files changed, 69 insertions(+), 39 deletions(-)


> diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
> index 858a6c9830..6874a7ad40 100644
> --- a/tests/qtest/migration/migration-util.c
> +++ b/tests/qtest/migration/migration-util.c
> @@ -18,7 +18,6 @@
>  #include "qapi/qmp/qlist.h"
>  #include "qemu/cutils.h"
>  #include "qemu/memalign.h"
> -
>  #include "migration/bootfile.h"
>  #include "migration/migration-util.h"
>

Squash this into the earlier patch which added the redundant blank line

> diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
> index ef94a6be02..e94d30a293 100644
> --- a/tests/qtest/migration/migration-util.h
> +++ b/tests/qtest/migration/migration-util.h
> @@ -29,6 +29,7 @@ typedef struct MigrationTestEnv {
>      bool has_kvm;
>      bool has_tcg;
>      bool has_uffd;
> +    bool uffd_feature_thread_id;
>      bool has_dirty_ring;
>      bool is_x86;
>      const char *arch;
> @@ -39,9 +40,6 @@ typedef struct MigrationTestEnv {
>  
>  /* migration-util.c */
>  
> -void migration_env_init(MigrationTestEnv *env);
> -int migration_env_clean(MigrationTestEnv *env);

Removing the decl of these two functions, but this patch isn't
removing their impl. Guess this is supposed to be in a different
patch in the series ?

> -
>  bool migrate_watch_for_events(QTestState *who, const char *name,
>                                QDict *event, void *opaque);
>  
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


