Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66E7D44D4B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 11:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8dm5-0003N0-H2; Wed, 06 Nov 2024 06:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8dlu-0003H7-J7
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:00:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8dls-0001YX-Nk
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730890819;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=zJeE4MEAppEcbLQtwfew1gCKPzTWRl7YXgaBin91yZk=;
 b=HvBM83Qn8fGeKHPRtkH0Bsp+rZqQkby8UhRZ/ZJw9zle5Fs6MrLIV2LPSXAIWEOSNfN0tM
 k3/Rf6AyQ1FDdB+AK3z2auL5HjQAoMcqXpgUd0mFWKziaKaS+qzbC3F5wRQlJlEcnqUm4p
 YjZKKSqIrIoYtyBpNI8UHcX12y80Ywo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-EIqBUXRUOU6YP0GjpMgHlg-1; Wed,
 06 Nov 2024 06:00:18 -0500
X-MC-Unique: EIqBUXRUOU6YP0GjpMgHlg-1
X-Mimecast-MFC-AGG-ID: EIqBUXRUOU6YP0GjpMgHlg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 816611955DC1; Wed,  6 Nov 2024 11:00:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.182])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF0FC1956054; Wed,  6 Nov 2024 11:00:14 +0000 (UTC)
Date: Wed, 6 Nov 2024 11:00:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 08/22] tests/qtest/migration: Move ufd_version_check to
 utils
Message-ID: <ZytMOqnHN1cLetxD@redhat.com>
References: <20241105180837.5990-1-farosas@suse.de>
 <20241105180837.5990-9-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105180837.5990-9-farosas@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

On Tue, Nov 05, 2024 at 03:08:23PM -0300, Fabiano Rosas wrote:
> Move ufd_version_check() to migration-util.c file. This is a helper
> function that is used during tests definition so it should be
> available outside of migration-test.c
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-test.c           | 47 ++------------------------
>  tests/qtest/migration/migration-util.c | 42 +++++++++++++++++++++++
>  tests/qtest/migration/migration-util.h | 11 ++++++
>  3 files changed, 55 insertions(+), 45 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 308a50a988..825544ba5e 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -34,6 +34,7 @@
>  /* For dirty ring test; so far only x86_64 is supported */
>  #if defined(__linux__) && defined(HOST_X86_64)
>  #include "linux/kvm.h"
> +#include <sys/ioctl.h>
>  #endif
>  
>  unsigned start_address;
> @@ -87,50 +88,6 @@ typedef enum PostcopyRecoveryFailStage {
>  #include <sys/vfs.h>
>  #endif
>  
> -#if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
> -#include <sys/eventfd.h>
> -#include <sys/ioctl.h>
> -#include "qemu/userfaultfd.h"
> -
> -static bool ufd_version_check(void)
> -{
> -    struct uffdio_api api_struct;
> -    uint64_t ioctl_mask;
> -
> -    int ufd = uffd_open(O_CLOEXEC);
> -
> -    if (ufd == -1) {
> -        g_test_message("Skipping test: userfaultfd not available");
> -        return false;
> -    }
> -
> -    api_struct.api = UFFD_API;
> -    api_struct.features = 0;
> -    if (ioctl(ufd, UFFDIO_API, &api_struct)) {
> -        g_test_message("Skipping test: UFFDIO_API failed");
> -        return false;
> -    }
> -    uffd_feature_thread_id = api_struct.features & UFFD_FEATURE_THREAD_ID;
> -
> -    ioctl_mask = (1ULL << _UFFDIO_REGISTER |
> -                  1ULL << _UFFDIO_UNREGISTER);
> -    if ((api_struct.ioctls & ioctl_mask) != ioctl_mask) {
> -        g_test_message("Skipping test: Missing userfault feature");
> -        return false;
> -    }
> -
> -    return true;
> -}
> -
> -#else
> -static bool ufd_version_check(void)
> -{
> -    g_test_message("Skipping test: Userfault not available (builtdtime)");
> -    return false;
> -}
> -
> -#endif
> -
>  static char *tmpfs;
>  static char *bootpath;
>  
> @@ -3522,7 +3479,7 @@ int main(int argc, char **argv)
>          return 0;
>      }
>  
> -    has_uffd = ufd_version_check();
> +    has_uffd = ufd_version_check(&uffd_feature_thread_id);
>      arch = qtest_get_arch();
>      is_x86 = !strcmp(arch, "i386") || !strcmp(arch, "x86_64");
>  
> diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
> index 8a974ded22..169b4884e6 100644
> --- a/tests/qtest/migration/migration-util.c
> +++ b/tests/qtest/migration/migration-util.c
> @@ -22,6 +22,13 @@
>  #include "migration/bootfile.h"
>  #include "migration/migration-util.h"
>  
> +/* for uffd_version_check() */
> +#if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
> +#include <sys/eventfd.h>
> +#include "qemu/userfaultfd.h"
> +#endif
> +
> +
>  static char *SocketAddress_to_str(SocketAddress *addr)
>  {
>      switch (addr->type) {
> @@ -283,3 +290,38 @@ bool probe_o_direct_support(const char *tmpfs)
>      return true;
>  }
>  #endif
> +
> +#if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
> +bool ufd_version_check(bool *uffd_feature_thread_id)
> +{
> +    struct uffdio_api api_struct;
> +    uint64_t ioctl_mask;
> +
> +    int ufd = uffd_open(O_CLOEXEC);
> +
> +    if (ufd == -1) {
> +        g_test_message("Skipping test: userfaultfd not available");
> +        return false;
> +    }
> +
> +    api_struct.api = UFFD_API;
> +    api_struct.features = 0;
> +    if (ioctl(ufd, UFFDIO_API, &api_struct)) {
> +        g_test_message("Skipping test: UFFDIO_API failed");
> +        return false;
> +    }
> +
> +    if (uffd_feature_thread_id) {
> +        *uffd_feature_thread_id = api_struct.features & UFFD_FEATURE_THREAD_ID;
> +    }
> +
> +    ioctl_mask = (1ULL << _UFFDIO_REGISTER |
> +                  1ULL << _UFFDIO_UNREGISTER);
> +    if ((api_struct.ioctls & ioctl_mask) != ioctl_mask) {
> +        g_test_message("Skipping test: Missing userfault feature");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +#endif
> diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
> index d75c5db5f3..f4a1f4750e 100644
> --- a/tests/qtest/migration/migration-util.h
> +++ b/tests/qtest/migration/migration-util.h
> @@ -67,6 +67,17 @@ static inline bool probe_o_direct_support(const char *tmpfs)
>      return false;
>  }
>  #endif
> +
> +#if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
> +bool ufd_version_check(bool *uffd_feature_thread_id);
> +#else
> +static inline bool ufd_version_check(bool *uffd_feature_thread_id)
> +{
> +    g_test_message("Skipping test: Userfault not available (builtdtime)");
> +    return false;
> +}
> +#endif

I wouldn't bother inlining this in the header, as it is not a performance
sensitive function. Having the complex #ifdef expression only in the .c
file would be a benefit IMHO

> +
>  void migration_test_add(const char *path, void (*fn)(void));
>  char *migrate_get_connect_uri(QTestState *who);
>  void migrate_set_ports(QTestState *to, QList *channel_list);
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


