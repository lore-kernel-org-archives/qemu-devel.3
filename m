Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBB3CCF9EE
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKd2-0005e9-B1; Mon, 27 Oct 2025 06:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDKcs-0005cs-3s
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:38:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vDKck-0000mF-AB
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761561525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fw8k+9K2IZYTTk6QD/aPafJUyiI6LdCipQ1znq7ubKg=;
 b=Vw25HFj2XZhU1nCs+T9JlcdyCvIcFUOfu9yXjcQmgQIOdPiiaQU+ax9s69n9ElM0Ky0jQb
 dkZNGTPkdNSugQUfHqStNZSupzJsIVkQzhnno7VHhhij7Hbz+EGyr4e+5hB8tU2i4Xu5Dr
 FBE2ywzBneRjTESN9ODQIu7e7+8Mfh4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-mwKsJ6UjNJmRbLA_mVIEtA-1; Mon,
 27 Oct 2025 06:38:41 -0400
X-MC-Unique: mwKsJ6UjNJmRbLA_mVIEtA-1
X-Mimecast-MFC-AGG-ID: mwKsJ6UjNJmRbLA_mVIEtA_1761561521
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F327180137A; Mon, 27 Oct 2025 10:38:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 918473000223; Mon, 27 Oct 2025 10:38:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DF72521E6A27; Mon, 27 Oct 2025 11:38:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: peterx@redhat.com,  stefanb@linux.vnet.ibm.com,  farosas@suse.de,
 qemu-devel@nongnu.org,  armbru@redhat.com,  berrange@redhat.com
Subject: Re: [PATCH v3 4/4] migration: vmsd errp handlers: return bool
In-Reply-To: <20251025202649.1122420-5-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Sat, 25 Oct 2025 23:26:49 +0300")
References: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
 <20251025202649.1122420-5-vsementsov@yandex-team.ru>
Date: Mon, 27 Oct 2025 11:38:36 +0100
Message-ID: <87o6psocib.fsf@pond.sub.org>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> Switch the new API to simple bool-returning interface, as return value
> is not used otherwise than check is function failed or not. No logic
> depend on concrete errno values.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  backends/tpm/tpm_emulator.c   | 10 ++++------
>  docs/devel/migration/main.rst |  6 +++---
>  include/migration/vmstate.h   |  6 +++---
>  migration/vmstate.c           | 14 ++++++--------
>  4 files changed, 16 insertions(+), 20 deletions(-)
>
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index aa69eb606f..6cc9aa199c 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -947,25 +947,23 @@ static void tpm_emulator_vm_state_change(void *opaque, bool running,
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

Note for later: this returns 0 or -EIO.

>      if (ret < 0) {
> -        return ret;
> +        return false;
>      }
>  
>      if (tpm_emulator_startup_tpm_resume(tb, 0, true) < 0) {
>          error_setg(errp, "Failed to resume tpm");
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
> index 677e56c84a..adaaf91b3f 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -154,13 +154,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>          return -EINVAL;
>      }
>      if (vmsd->pre_load_errp) {
> -        ret = vmsd->pre_load_errp(opaque, errp);
> -        if (ret < 0) {
> +        if (!vmsd->pre_load_errp(opaque, errp)) {
>              error_prepend(errp, "pre load hook failed for: '%s', "
>                            "version_id: %d, minimum version_id: %d: ",
>                            vmsd->name, vmsd->version_id,
>                            vmsd->minimum_version_id);
> -            return ret;
> +            return -EINVAL;
>          }
>      } else if (vmsd->pre_load) {
>          ret = vmsd->pre_load(opaque);
> @@ -256,11 +255,11 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>          return ret;
>      }
>      if (vmsd->post_load_errp) {
> -        ret = vmsd->post_load_errp(opaque, version_id, errp);
> -        if (ret < 0) {
> +        if (!vmsd->post_load_errp(opaque, version_id, errp)) {
>              error_prepend(errp, "post load hook failed for: %s, version_id: "
>                            "%d, minimum_version: %d: ", vmsd->name,
>                            vmsd->version_id, vmsd->minimum_version_id);
> +            ret = -EINVAL;

With ->post_load_errp is tpm_emulator_post_load(), the value returned on
error changes from -EIO to -EINVAL.

Do callers of vmstate_load_state() care?

>          }
>      } else if (vmsd->post_load) {
>          ret = vmsd->post_load(opaque, version_id);
> @@ -438,11 +437,10 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>      trace_vmstate_save_state_top(vmsd->name);
>  
>      if (vmsd->pre_save_errp) {
> -        ret = vmsd->pre_save_errp(opaque, errp);
>          trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
> -        if (ret < 0) {
> +        if (!vmsd->pre_save_errp(opaque, errp)) {
>              error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
> -            return ret;
> +            return -EINVAL;
>          }
>      } else if (vmsd->pre_save) {
>          ret = vmsd->pre_save(opaque);
> -- 
> 2.48.1


