Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70767CCF9E9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 19:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCkHo-0006SJ-3n; Sat, 25 Oct 2025 15:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vCkHc-0006RZ-Td
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 15:50:39 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vCkHX-0006jx-UC
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 15:50:36 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 3C822C00DB;
 Sat, 25 Oct 2025 22:50:21 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:538::1:38] (unknown
 [2a02:6bf:8080:538::1:38])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id JognN51L4Gk0-Q3YDIEVX; Sat, 25 Oct 2025 22:50:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761421820;
 bh=xGHa/gx+GWtepGVVatRmh8iiB6nmthhXtqEtzLEoL/w=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=QDQW2WQALPGQgwc5BDXA0ZRO0vsJHnN8r4J7vRylBfJzoUmZAM0GKmtDsEPJjNmSk
 LVPYYri+Rq2cBa3aYIlr7SFKpMMYdRm6ZbguWx/FO1oeWKDM6eqCGgbOdkhpW8t2yc
 6VTzUKB5PkuBVX76nX0NKjqT4l0rljhstNkI8S0s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5006c0f4-3dc7-434d-b0ba-be4db5dbded7@yandex-team.ru>
Date: Sat, 25 Oct 2025 22:50:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] migration: vmsd errp handlers: return bool
To: peterx@redhat.com
Cc: stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 armbru@redhat.com, berrange@redhat.com
References: <20251020160344.2401137-1-vsementsov@yandex-team.ru>
 <20251020160344.2401137-3-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251020160344.2401137-3-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20.10.25 19:03, Vladimir Sementsov-Ogievskiy wrote:
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
> 
> Let this new, recently added API be simpler and clearer, let it
> return simple boolean value, so we shouldn't think:
> 
>    - should we handle different error codes differently
>      (if yes - how exactly, if no - why do we need this information?)
> 
>    - should we add it to errp, or it was already added earlier in
>      the stack
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   backends/tpm/tpm_emulator.c   | 10 ++++------
>   docs/devel/migration/main.rst |  6 +++---
>   include/migration/vmstate.h   |  6 +++---
>   migration/vmstate.c           | 24 +++++++++++-------------
>   4 files changed, 21 insertions(+), 25 deletions(-)
> 
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index dacfca5ab7..3937ac5572 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -947,24 +947,22 @@ static void tpm_emulator_vm_state_change(void *opaque, bool running,
>   
>   /*
>    * Load the TPM state blobs into the TPM.
> - *
> - * Returns negative errno codes in case of error.
>    */
> -static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
> +static bool tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
>   {
>       TPMBackend *tb = opaque;
>       int ret;
>   
>       ret = tpm_emulator_set_state_blobs(tb, errp);
>       if (ret < 0) {
> -        return ret;
> +        return false;
>       }
>   
>       if (tpm_emulator_startup_tpm_resume(tb, 0, true) < 0) {

O_o, we've missed an elephant (errp is not set here).

> -        return -EIO;
> +        return false;
>       }
>   
> -    return 0;
> +    return true;
>   }
>   
>   static const VMStateDescription vmstate_tpm_emulator = {
> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> index 1afe7b9689..234d280249 100644
> --- a/docs/devel/migration/main.rst
> +++ b/docs/devel/migration/main.rst
> @@ -446,15 +446,15 @@ The functions to do that are inside a vmstate definition, and are called:
>   
>   Following are the errp variants of these functions.
>   
> -- ``int (*pre_load_errp)(void *opaque, Error **errp);``
> +- ``bool (*pre_load_errp)(void *opaque, Error **errp);``
>   
>     This function is called before we load the state of one device.
>   
> -- ``int (*post_load_errp)(void *opaque, int version_id, Error **errp);``
> +- ``bool (*post_load_errp)(void *opaque, int version_id, Error **errp);``
>   
>     This function is called after we load the state of one device.
>   
> -- ``int (*pre_save_errp)(void *opaque, Error **errp);``
> +- ``bool (*pre_save_errp)(void *opaque, Error **errp);``
>   
>     This function is called before we save the state of one device.
>   
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 63ccaee07a..dbe330dd5f 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -218,11 +218,11 @@ struct VMStateDescription {
>       int minimum_version_id;
>       MigrationPriority priority;
>       int (*pre_load)(void *opaque);
> -    int (*pre_load_errp)(void *opaque, Error **errp);
> +    bool (*pre_load_errp)(void *opaque, Error **errp);
>       int (*post_load)(void *opaque, int version_id);
> -    int (*post_load_errp)(void *opaque, int version_id, Error **errp);
> +    bool (*post_load_errp)(void *opaque, int version_id, Error **errp);
>       int (*pre_save)(void *opaque);
> -    int (*pre_save_errp)(void *opaque, Error **errp);
> +    bool (*pre_save_errp)(void *opaque, Error **errp);
>       int (*post_save)(void *opaque);
>       bool (*needed)(void *opaque);
>       bool (*dev_unplug_pending)(void *opaque);
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index fd066f910e..921e09c38e 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -154,13 +154,12 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>           return -EINVAL;
>       }
>       if (vmsd->pre_load_errp) {
> -        ret = vmsd->pre_load_errp(opaque, errp);
> -        if (ret < 0) {
> +        if (!vmsd->pre_load_errp(opaque, errp)) {
>               error_prepend(errp, "pre load hook failed for: '%s', "
> -                          "version_id: %d, minimum version_id: %d, "
> -                          "ret: %d: ", vmsd->name, vmsd->version_id,
> -                          vmsd->minimum_version_id, ret);
> -            return ret;
> +                          "version_id: %d, minimum version_id: %d: "
> +                          vmsd->name, vmsd->version_id,
> +                          vmsd->minimum_version_id);
> +            return -EINVAL;
>           }
>       } else if (vmsd->pre_load) {
>           ret = vmsd->pre_load(opaque);
> @@ -256,11 +255,11 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>           return ret;
>       }
>       if (vmsd->post_load_errp) {
> -        ret = vmsd->post_load_errp(opaque, version_id, errp);
> -        if (ret < 0) {
> +        if (!vmsd->post_load_errp(opaque, version_id, errp)) {
>               error_prepend(errp, "post load hook failed for: %s, version_id: "
> -                          "%d, minimum_version: %d, ret: %d: ", vmsd->name,
> -                          vmsd->version_id, vmsd->minimum_version_id, ret);
> +                          "%d, minimum_version: %d: ", vmsd->name,
> +                          vmsd->version_id, vmsd->minimum_version_id);
> +            ret = -EINVAL;
>           }
>       } else if (vmsd->post_load) {
>           ret = vmsd->post_load(opaque, version_id);
> @@ -438,12 +437,11 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>       trace_vmstate_save_state_top(vmsd->name);
>   
>       if (vmsd->pre_save_errp) {
> -        ret = vmsd->pre_save_errp(opaque, errp);
>           trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
> -        if (ret < 0) {
> +        if (!vmsd->pre_save_errp(opaque, errp)) {
>               error_prepend(errp, "pre-save for %s failed, ret: %d: ",
>                             vmsd->name, ret);
> -            return ret;
> +            return -EINVAL;
>           }
>       } else if (vmsd->pre_save) {
>           ret = vmsd->pre_save(opaque);


-- 
Best regards,
Vladimir

