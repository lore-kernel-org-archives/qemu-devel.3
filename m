Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF96C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 08:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9KVc-00019R-8O; Tue, 21 May 2024 04:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s9KVa-00018N-NR
 for qemu-devel@nongnu.org; Tue, 21 May 2024 04:06:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s9KVW-0001hk-4m
 for qemu-devel@nongnu.org; Tue, 21 May 2024 04:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716278760;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Lq2vaKxU8u138SfM0kxTHlTlzI57HKQCzqAj/TeBNqA=;
 b=YDsuPW4PDb0LMjCsx8EBAej3vorgFnu1TQTlc3eLuAdc5k7+ZTNFsNukIIAvsZlyV3KYAp
 DetV69QuOcx7oYSd2s1xurWnJ6kZ4yuxvnBVzWxyQw/Nlz7xCu4N+PE9wh8WbSEpIMSz+s
 xsBYxLDtxsrjNRSDGxLSpWB80doUGYk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-o5v0imGvOzSr6-mcGda6pQ-1; Tue, 21 May 2024 04:05:52 -0400
X-MC-Unique: o5v0imGvOzSr6-mcGda6pQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62755801190;
 Tue, 21 May 2024 08:05:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCF2D1C09481;
 Tue, 21 May 2024 08:05:49 +0000 (UTC)
Date: Tue, 21 May 2024 09:05:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 26/26] migration: only-migratable-modes
Message-ID: <ZkxV2ytNDTz_COla@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-27-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1714406135-451286-27-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Apr 29, 2024 at 08:55:35AM -0700, Steve Sistare wrote:
> Add the only-migratable-modes option as a generalization of only-migratable.
> Only devices that support all requested modes are allowed.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/misc.h       |  3 +++
>  include/sysemu/sysemu.h        |  1 -
>  migration/migration-hmp-cmds.c | 26 +++++++++++++++++++++++++-
>  migration/migration.c          | 22 +++++++++++++++++-----
>  migration/savevm.c             |  2 +-
>  qemu-options.hx                | 16 ++++++++++++++--
>  system/globals.c               |  1 -
>  system/vl.c                    | 13 ++++++++++++-
>  target/s390x/cpu_models.c      |  4 +++-
>  9 files changed, 75 insertions(+), 13 deletions(-)

> diff --git a/qemu-options.hx b/qemu-options.hx
> index f0dfda5..946d731 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4807,8 +4807,20 @@ DEF("only-migratable", 0, QEMU_OPTION_only_migratable, \
>      "-only-migratable     allow only migratable devices\n", QEMU_ARCH_ALL)
>  SRST
>  ``-only-migratable``
> -    Only allow migratable devices. Devices will not be allowed to enter
> -    an unmigratable state.
> +    Only allow devices that can migrate using normal mode. Devices will not
> +    be allowed to enter an unmigratable state.
> +ERST
> +
> +DEF("only-migratable-modes", HAS_ARG, QEMU_OPTION_only_migratable_modes, \
> +    "-only-migratable-modes mode1[,...]\n"
> +    "                allow only devices that are migratable using mode(s)\n",
> +    QEMU_ARCH_ALL)
> +SRST
> +``-only-migratable-modes mode1[,...]``
> +    Only allow devices which are migratable using all modes in the list,
> +    which guarantees that migration will not fail due to a blocker.
> +    If both only-migratable-modes and only-migratable are specified,
> +    or are specified multiple times, then the required modes accumulate.
>  ERST

Adding new top level CLI options is not something we much like doing
these days. Also its is preferrable to define args using QAPI rather
than creating hand written parsers

The pre-existing -only-migratable flag isn't ideal either, as a random
top level flag on its own.

I tend to think we should probably make both these arguments become
properties in the Machine class, and thus settable with the existing
-machine argument, since they're describing a requirement of the
machine and devices added to it.

The existing -only-migratable can be deprecated and simply made to
set the corresponding machien property

> diff --git a/system/globals.c b/system/globals.c
> index e353584..fdc263e 100644
> --- a/system/globals.c
> +++ b/system/globals.c
> @@ -48,7 +48,6 @@ const char *qemu_name;
>  unsigned int nb_prom_envs;
>  const char *prom_envs[MAX_PROM_ENVS];
>  uint8_t *boot_splash_filedata;
> -int only_migratable; /* turn it off unless user states otherwise */
>  int icount_align_option;
>  
>  /* The bytes in qemu_uuid are in the order specified by RFC4122, _not_ in the
> diff --git a/system/vl.c b/system/vl.c
> index b76881e..7e73be9 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -3458,7 +3458,18 @@ void qemu_init(int argc, char **argv)
>                  incoming = optarg;
>                  break;
>              case QEMU_OPTION_only_migratable:
> -                only_migratable = 1;
> +                migration_set_required_mode(MIG_MODE_NORMAL);
> +                break;
> +            case QEMU_OPTION_only_migratable_modes:
> +                {
> +                    int i, mode;
> +                    g_autofree char **words = g_strsplit(optarg, ",", -1);
> +                    for (i = 0; words[i]; i++) {
> +                        mode = qapi_enum_parse(&MigMode_lookup, words[i], -1,
> +                                               &error_fatal);
> +                        migration_set_required_mode(mode);
> +                    }
> +                }
>                  break;
>              case QEMU_OPTION_nodefaults:
>                  has_defaults = 0;
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 8ed3bb6..42ad160 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -16,6 +16,7 @@
>  #include "kvm/kvm_s390x.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/tcg.h"
> +#include "migration/misc.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qapi/visitor.h"
> @@ -526,7 +527,8 @@ static void check_compatibility(const S390CPUModel *max_model,
>      }
>  
>  #ifndef CONFIG_USER_ONLY
> -    if (only_migratable && test_bit(S390_FEAT_UNPACK, model->features)) {
> +    if (migration_mode_required(MIG_MODE_NORMAL) &&
> +        test_bit(S390_FEAT_UNPACK, model->features)) {
>          error_setg(errp, "The unpack facility is not compatible with "
>                     "the --only-migratable option. You must remove either "
>                     "the 'unpack' facility or the --only-migratable option");
> -- 
> 1.8.3.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


