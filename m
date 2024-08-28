Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3017C54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 11:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjGlk-0006bk-TC; Wed, 28 Aug 2024 07:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sjGlj-0006YL-Ai
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sjGlh-0002dT-Nf
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724844197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sjPscny8RpBp/Hq/MF0Txq0RsmBmvhMA9j1IvksC6Zg=;
 b=DYBwdJZik06WcAWULhLhPjdfZG835oO/PYABzPkV19pDnYQqWSs3//6zshfIffymHKO4ql
 faciYn7b382XH5GVULILzzHcM9oOB+KcsVzHpZo0cWRNLKRCa+i6XOCShJHH8lFjsdGoB6
 RVRKTib7ljhPbVxieKV+D1Wqy647at0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-VVMG9EtQNq6uKZ4tlwC9Sw-1; Wed,
 28 Aug 2024 07:23:13 -0400
X-MC-Unique: VVMG9EtQNq6uKZ4tlwC9Sw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AB3F1955F4A; Wed, 28 Aug 2024 11:23:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 151FE19560A3; Wed, 28 Aug 2024 11:23:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E498221E6A28; Wed, 28 Aug 2024 13:23:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-trivial@nongnu.org,
 zhao1.liu@intel.com,  kvm@vger.kernel.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v5 1/2] kvm: replace fprintf with
 error_report()/printf() in kvm_init()
In-Reply-To: <20240828075630.7754-2-anisinha@redhat.com> (Ani Sinha's message
 of "Wed, 28 Aug 2024 13:26:28 +0530")
References: <20240828075630.7754-1-anisinha@redhat.com>
 <20240828075630.7754-2-anisinha@redhat.com>
Date: Wed, 28 Aug 2024 13:23:08 +0200
Message-ID: <87ikvkriw3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ani Sinha <anisinha@redhat.com> writes:

> error_report() is more appropriate for error situations. Replace fprintf with
> error_report() and error_printf() as appropriate. Cosmetic. No functional
> change.

Uh, I missed this last time around: the change is more than just
cosmetics!  The error messages change, e.g. from

    $ qemu-system-x86_64 -nodefaults -S -display none --accel kvm
    qemu-system-x86_64: --accel kvm: Could not access KVM kernel module: Permission denied
    qemu-system-x86_64: --accel kvm: failed to initialize kvm: Permission denied

to

    $ qemu-system-x86_64 -nodefaults -S -display none --accel kvm
    Could not access KVM kernel module: Permission denied
    qemu-system-x86_64: --accel kvm: failed to initialize kvm: Permission denied

Note: the second message is from kvm_init()'s caller.  Reporting the
same error twice is wrong, but not this patch's problem.

Moreover, the patch tweaks an error message at [*].

Suggest something like

  Replace fprintf() with error_report() and error_printf() where
  appropriate.  Error messages improve, e.g. from

      Could not access KVM kernel module: Permission denied

  to

      qemu-system-x86_64: --accel kvm: Could not access KVM kernel module: Permission denied

> CC: qemu-trivial@nongnu.org
> CC: zhao1.liu@intel.com
> CC: armbru@redhat.com
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 40 ++++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
>
> changelog:
> v2: fix a bug.
> v3: replace one instance of error_report() with error_printf(). added tags.
> v4: changes suggested by Markus.
> v5: more changes from Markus's comments on v4.
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 75d11a07b2..fcc157f0e6 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2427,7 +2427,7 @@ static int kvm_init(MachineState *ms)
>      QLIST_INIT(&s->kvm_parked_vcpus);
>      s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
>      if (s->fd == -1) {
> -        fprintf(stderr, "Could not access KVM kernel module: %m\n");
> +        error_report("Could not access KVM kernel module: %m");
>          ret = -errno;
>          goto err;
>      }
> @@ -2437,13 +2437,13 @@ static int kvm_init(MachineState *ms)
>          if (ret >= 0) {
>              ret = -EINVAL;
>          }
> -        fprintf(stderr, "kvm version too old\n");
> +        error_report("kvm version too old");
>          goto err;
>      }
>  
>      if (ret > KVM_API_VERSION) {
>          ret = -EINVAL;
> -        fprintf(stderr, "kvm version not supported\n");
> +        error_report("kvm version not supported");
>          goto err;
>      }
>  
> @@ -2488,26 +2488,22 @@ static int kvm_init(MachineState *ms)
>      } while (ret == -EINTR);
>  
>      if (ret < 0) {
> -        fprintf(stderr, "ioctl(KVM_CREATE_VM) failed: %d %s\n", -ret,
> -                strerror(-ret));
> +        error_report("ioctl(KVM_CREATE_VM) failed: %s", strerror(-ret));

[*] This is where you change an error message.

>  
>  #ifdef TARGET_S390X
>          if (ret == -EINVAL) {
> -            fprintf(stderr,
> -                    "Host kernel setup problem detected. Please verify:\n");
> -            fprintf(stderr, "- for kernels supporting the switch_amode or"
> -                    " user_mode parameters, whether\n");
> -            fprintf(stderr,
> -                    "  user space is running in primary address space\n");
> -            fprintf(stderr,
> -                    "- for kernels supporting the vm.allocate_pgste sysctl, "
> -                    "whether it is enabled\n");
> +            error_printf("Host kernel setup problem detected."
> +                         " Please verify:\n");
> +            error_printf("- for kernels supporting the"
> +                        " switch_amode or user_mode parameters, whether");
> +            error_printf(" user space is running in primary address space\n");
> +            error_printf("- for kernels supporting the vm.allocate_pgste"
> +                         " sysctl, whether it is enabled\n");
>          }
>  #elif defined(TARGET_PPC)
>          if (ret == -EINVAL) {
> -            fprintf(stderr,
> -                    "PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
> -                    (type == 2) ? "pr" : "hv");
> +            error_printf("PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
> +                         (type == 2) ? "pr" : "hv");
>          }
>  #endif
>          goto err;
> @@ -2526,9 +2522,9 @@ static int kvm_init(MachineState *ms)
>                          nc->name, nc->num, soft_vcpus_limit);
>  
>              if (nc->num > hard_vcpus_limit) {
> -                fprintf(stderr, "Number of %s cpus requested (%d) exceeds "
> -                        "the maximum cpus supported by KVM (%d)\n",
> -                        nc->name, nc->num, hard_vcpus_limit);
> +                error_report("Number of %s cpus requested (%d) exceeds "
> +                             "the maximum cpus supported by KVM (%d)",
> +                             nc->name, nc->num, hard_vcpus_limit);
>                  exit(1);
>              }
>          }
> @@ -2542,8 +2538,8 @@ static int kvm_init(MachineState *ms)
>      }
>      if (missing_cap) {
>          ret = -EINVAL;
> -        fprintf(stderr, "kvm does not support %s\n%s",
> -                missing_cap->name, upgrade_note);
> +        error_report("kvm does not support %s", missing_cap->name);
> +        error_printf("%s", upgrade_note);
>          goto err;
>      }

With the commit message corrected:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


