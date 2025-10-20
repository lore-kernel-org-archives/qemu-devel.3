Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C93CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 11:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnho-0000rc-OR; Mon, 20 Oct 2025 07:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vAnhl-0000rM-Sl
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vAnhh-00048R-Ft
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760958325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uYqnp59a87lCpZeJ0vwoALD7W1k2nRedoTqrLTXbBZ8=;
 b=hGuHVY3u4Y2cKUSmuKRwoGlJ9V1sEnZqJRE4qBypHVZQD/py8AQBq2t/orFrX/G3RKtkCs
 qFrcWgs9YYQ+TwMJB9+Acz4vC6+hzlKNB5Tvf4k0qMIPVDRbp3/Iydxnb/9Y5pCTKog2Yl
 9z6jzwqx98sepr5DwBIbP1bu8HkjvLA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-yTFPkXZwM9CfDP7MSl1NyQ-1; Mon,
 20 Oct 2025 07:05:21 -0400
X-MC-Unique: yTFPkXZwM9CfDP7MSl1NyQ-1
X-Mimecast-MFC-AGG-ID: yTFPkXZwM9CfDP7MSl1NyQ_1760958320
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 385111956058; Mon, 20 Oct 2025 11:05:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F4AE30001BC; Mon, 20 Oct 2025 11:05:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 91E5F21E6A27; Mon, 20 Oct 2025 13:05:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: peterx@redhat.com,  stefanb@linux.vnet.ibm.com,  farosas@suse.de,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: vmsd errp handlers: return bool
In-Reply-To: <20251020091907.2173711-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 20 Oct 2025 12:19:07 +0300")
References: <20251020091907.2173711-1-vsementsov@yandex-team.ru>
Date: Mon, 20 Oct 2025 13:05:16 +0200
Message-ID: <87347d7s0j.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Recently we moved to returning errp. Why to keep int return value?
> Generally it doesn't help: you can't use in a logic of handling
> an error, as you are never sure, that in future the logic in
> the stack will not change: it may start to return another error
> code in the same case, or return same error code in another case.
>
> Actually, we can only rely on concrete errno code when get it
> _directly_ from documented library function or syscall. This way we
> handle for example EINTR. But later in a stack, we can only add
> this errno to the textual error by strerror().

It's a matter of the function's contract, actually.

If the contract is "Return negative value on failure", checking for
failure is all you can do with it.  Same information as "Return false on
failure".

If the contract is "Return negative errno on failure", the function is
responsible for returning values that make sense.  Ideally, the contract
spells them all out.

No difference between "documented library function or syscall" and a
function we provide ourselves.

> Let this new, recently added API be simpler and clearer, let it
> return simple boolean value, so we shouldn't think:
>
>   - should we handle different error codes differently
>     (if yes - how exactly, if no - why do we need this information?)
>
>   - should we add it to errp, or it was already added earlier in
>     the stack

When no caller actually needs to distinguish between errors, bool is the
most obvious interface.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  backends/tpm/tpm_emulator.c   | 10 ++++------
>  docs/devel/migration/main.rst |  6 +++---
>  include/migration/vmstate.h   |  6 +++---
>  migration/vmstate.c           | 31 +++++++++++++------------------
>  4 files changed, 23 insertions(+), 30 deletions(-)
>
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index dacfca5ab7..3937ac5572 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -947,24 +947,22 @@ static void tpm_emulator_vm_state_change(void *opaque, bool running,
>  
>  /*
>   * Load the TPM state blobs into the TPM.
> - *
> - * Returns negative errno codes in case of error.
>   */
> -static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
> +static bool tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
>  {
>      TPMBackend *tb = opaque;
>      int ret;
>  
>      ret = tpm_emulator_set_state_blobs(tb, errp);
>      if (ret < 0) {
> -        return ret;
> +        return false;
>      }
>  
>      if (tpm_emulator_startup_tpm_resume(tb, 0, true) < 0) {
> -        return -EIO;
> +        return false;
>      }
>  
> -    return 0;
> +    return true;
>  }
>  
>  static const VMStateDescription vmstate_tpm_emulator = {
> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> index 1afe7b9689..234d280249 100644
> --- a/docs/devel/migration/main.rst
> +++ b/docs/devel/migration/main.rst
> @@ -446,15 +446,15 @@ The functions to do that are inside a vmstate definition, and are called:
>  
>  Following are the errp variants of these functions.
>  
> -- ``int (*pre_load_errp)(void *opaque, Error **errp);``
>
> +- ``bool (*pre_load_errp)(void *opaque, Error **errp);``
>  
>    This function is called before we load the state of one device.
>  
> -- ``int (*post_load_errp)(void *opaque, int version_id, Error **errp);``
> +- ``bool (*post_load_errp)(void *opaque, int version_id, Error **errp);``
>  
>    This function is called after we load the state of one device.
>  
> -- ``int (*pre_save_errp)(void *opaque, Error **errp);``
> +- ``bool (*pre_save_errp)(void *opaque, Error **errp);``
>  
>    This function is called before we save the state of one device.
>  
>
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 63ccaee07a..dbe330dd5f 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -218,11 +218,11 @@ struct VMStateDescription {
>      int minimum_version_id;
>      MigrationPriority priority;
>      int (*pre_load)(void *opaque);
> -    int (*pre_load_errp)(void *opaque, Error **errp);
> +    bool (*pre_load_errp)(void *opaque, Error **errp);
>      int (*post_load)(void *opaque, int version_id);
> -    int (*post_load_errp)(void *opaque, int version_id, Error **errp);
> +    bool (*post_load_errp)(void *opaque, int version_id, Error **errp);
>      int (*pre_save)(void *opaque);
> -    int (*pre_save_errp)(void *opaque, Error **errp);
> +    bool (*pre_save_errp)(void *opaque, Error **errp);
>      int (*post_save)(void *opaque);
>      bool (*needed)(void *opaque);
>      bool (*dev_unplug_pending)(void *opaque);
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 81eadde553..026fd6f1a4 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -153,15 +153,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>          trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
>          return -EINVAL;
>      }
> -    if (vmsd->pre_load_errp) {
> -        ret = vmsd->pre_load_errp(opaque, errp);
> -        if (ret < 0) {
> -            error_prepend(errp, "pre load hook failed for: '%s', "
> -                          "version_id: %d, minimum version_id: %d, "
> -                          "ret: %d: ", vmsd->name, vmsd->version_id,
> -                          vmsd->minimum_version_id, ret);

Numeric errno codes in error messages are an anti-pattern.

> -            return ret;
> -        }
> +    if (vmsd->pre_load_errp && !vmsd->pre_load_errp(opaque, errp)) {
> +        error_prepend(errp, "pre load hook failed for: '%s', "
> +                      "version_id: %d, minimum version_id: %d, "
> +                      "ret: %d: ", vmsd->name, vmsd->version_id,
> +                      vmsd->minimum_version_id, ret);

Did you forget to delete ", ret %d:" and its argument @ret?  It's always
zero here now.

> +        return -EINVAL;
>      } else if (vmsd->pre_load) {
>          ret = vmsd->pre_load(opaque);
>          if (ret) {
> @@ -255,13 +252,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>          qemu_file_set_error(f, ret);
>          return ret;
>      }
> -    if (vmsd->post_load_errp) {
> -        ret = vmsd->post_load_errp(opaque, version_id, errp);
> -        if (ret < 0) {
> -            error_prepend(errp, "post load hook failed for: %s, version_id: "
> -                          "%d, minimum_version: %d, ret: %d: ", vmsd->name,
> -                          vmsd->version_id, vmsd->minimum_version_id, ret);
> -        }
> +    if (vmsd->post_load_errp && !vmsd->post_load_errp(opaque, version_id,
> +                                                      errp)) {
> +        error_prepend(errp, "post load hook failed for: %s, version_id: "
> +                      "%d, minimum_version: %d, ret: %d: ", vmsd->name,
> +                      vmsd->version_id, vmsd->minimum_version_id, ret);

Likewise.

> +        ret = -EINVAL;
>      } else if (vmsd->post_load) {
>          ret = vmsd->post_load(opaque, version_id);
>          if (ret < 0) {
> @@ -438,9 +434,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>      trace_vmstate_save_state_top(vmsd->name);
>  
>      if (vmsd->pre_save_errp) {
> -        ret = vmsd->pre_save_errp(opaque, errp);
>          trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
> -        if (ret < 0) {
> +        if (!vmsd->pre_save_errp(opaque, errp)) {
>              error_prepend(errp, "pre-save for %s failed, ret: %d: ",
>                            vmsd->name, ret);
>          }

Likewise.


