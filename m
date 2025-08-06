Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0932C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 05:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujWxx-00031j-Me; Wed, 06 Aug 2025 01:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ujWxr-0002va-2k; Wed, 06 Aug 2025 01:45:27 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ujWxn-0000xB-FR; Wed, 06 Aug 2025 01:45:26 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5765j10B033150
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 6 Aug 2025 14:45:01 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=YNEPux1jIgsqw82TMhqjdXP8kMG5KaYJemxmTPQ+m1w=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754459102; v=1;
 b=PXiVK7NwR/UD9sTEA/3L4c5xRHY1MgOuUP9GJOZshRYDFSfj0zyQvNF858sEqDxt
 beeXMC9ppVtRfLzUuZ1ost9p3niopR8k7H3HntQRf2VJip7ilghNWe1RC2KFt0e5
 6Mgid1+68piutT5FsvFxNin7vQlz5OaoTyh/OAcc9vpAhnutVhXla2seUr9Vz7Fu
 jTEuFBFrP5YKlFjO/wtjGzDocpIjRLIFIpOcE2X2m1j6pmd4kx7esohCHiuQdp/W
 tGlOEqonYPc0H5F1V+ZSYWMpFyq+YW4nU+CViUkVlrFV4Cm+qFiR8gmcEZdmFo2M
 g2K9SE5IrMQIJi0XbDz8SA==
Message-ID: <fa7bcb8f-03c1-4528-ae67-b7b8c5d6f443@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 6 Aug 2025 14:45:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 26/27] migration: Add error-parameterized function
 variants in VMSD struct
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-26-123450810db7@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250805-propagate_tpm_error-v9-26-123450810db7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/08/06 3:25, Arun Menon wrote:
> - We need to have good error reporting in the callbacks in
>    VMStateDescription struct. Specifically pre_save, post_save,
>    pre_load and post_load callbacks.
> - It is not possible to change these functions everywhere in one
>    patch, therefore, we introduce a duplicate set of callbacks
>    with Error object passed to them.
> - So, in this commit, we implement 'errp' variants of these callbacks,
>    introducing an explicit Error object parameter.
> - This is a functional step towards transitioning the entire codebase
>    to the new error-parameterized functions.
> - Deliberately called in mutual exclusion from their counterparts,
>    to prevent conflicts during the transition.
> - New impls should preferentally use 'errp' variants of
>    these methods, and existing impls incrementally converted.
>    The variants without 'errp' are intended to be removed
>    once all usage is converted.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   docs/devel/migration/main.rst | 24 ++++++++++++++++++++++++
>   include/migration/vmstate.h   | 15 +++++++++++++++
>   migration/vmstate.c           | 34 ++++++++++++++++++++++++++++++----
>   3 files changed, 69 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> index 6493c1d2bca48a2fa34d92f6c0979c215c56b8d5..35bf5ae26c87f3c82964eb15618be373ab5a41fc 100644
> --- a/docs/devel/migration/main.rst
> +++ b/docs/devel/migration/main.rst
> @@ -444,6 +444,30 @@ The functions to do that are inside a vmstate definition, and are called:
>     This function is called after we save the state of one device
>     (even upon failure, unless the call to pre_save returned an error).
>   
> +Following are the errp variants of these functions.
> +
> +- ``int (*pre_load_errp)(void *opaque, Error **errp);``
> +
> +  This function is called before we load the state of one device.
> +
> +- ``int (*post_load_errp)(void *opaque, int version_id, Error **errp);``
> +
> +  This function is called after we load the state of one device.
> +
> +- ``int (*pre_save_errp)(void *opaque, Error **errp);``
> +
> +  This function is called before we save the state of one device.
> +
> +- ``int (*post_save_errp)(void *opaque, Error **errp);``
> +
> +  This function is called after we save the state of one device
> +  (even upon failure, unless the call to pre_save returned an error).

Reviewing "[PATCH v9 24/27] migration: Propagate last encountered error 
in vmstate_save_state_v() function", I wondered why it has never been a 
problem post_load(), and this says only post_save_errp() is called upon 
failure.

Now I suspect it may be better to clarify their differences and avoid 
introducing post_save_errp() instead.

My guess is that post_save_errp() is being introduced for consistency 
with post_load(), but they cannot have "consistency" if post_load() and 
post_save() are not corresponding functions of save/load but are 
independent two functions. Perhaps the true problem here is that 
post_load() and post_save() look similar; if so, that can be solved by:
- Renaming post_save() to e.g., cleanup_save()
- Changing it to return void

> +
> +New impls should preferentally use 'errp' variants of these
> +methods and existing impls incrementally converted.
> +The variants without 'errp' are intended to be removed
> +once all usage is converted.
> +
>   Example: You can look at hpet.c, that uses the first three functions
>   to massage the state that is transferred.
>   
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 5fe9bbf39058d0cf97c1adab54cc516dbe8dc32a..51baf6c7f9d061ee33949d7e798f2184e50b4cbf 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -200,15 +200,30 @@ struct VMStateDescription {
>        * exclusive. For this reason, also early_setup VMSDs are migrated in a
>        * QEMU_VM_SECTION_FULL section, while save_setup() data is migrated in
>        * a QEMU_VM_SECTION_START section.
> +     *
> +     * There are duplicate impls of the post/pre save/load hooks.
> +     * New impls should preferentally use 'errp' variants of these
> +     * methods and existing impls incrementally converted.
> +     * The variants without 'errp' are intended to be removed
> +     * once all usage is converted.
> +     *
> +     * For the errp variants,
> +     * Returns: 0 on success,
> +     *          <0 on error where -value is an error number from errno.h
>        */
> +
>       bool early_setup;
>       int version_id;
>       int minimum_version_id;
>       MigrationPriority priority;
>       int (*pre_load)(void *opaque);
> +    int (*pre_load_errp)(void *opaque, Error **errp);
>       int (*post_load)(void *opaque, int version_id);
> +    int (*post_load_errp)(void *opaque, int version_id, Error **errp);
>       int (*pre_save)(void *opaque);
> +    int (*pre_save_errp)(void *opaque, Error **errp);
>       int (*post_save)(void *opaque);
> +    int (*post_save_errp)(void *opaque, Error **errp);
>       bool (*needed)(void *opaque);
>       bool (*dev_unplug_pending)(void *opaque);
>   
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 569e66ea983f833e6a0d651d2a751f34a64e8f5c..0acaa855cfec8ddac63e33d4562e39c345856213 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -152,7 +152,16 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>           trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
>           return -EINVAL;
>       }
> -    if (vmsd->pre_load) {
> +    if (vmsd->pre_load_errp) {
> +        ret = vmsd->pre_load_errp(opaque, errp);
> +        if (ret) {
> +            error_prepend(errp, "VM pre load failed for: '%s', "
> +                          "version_id: %d, minimum version_id: %d, "
> +                          "ret: %d: ", vmsd->name, vmsd->version_id,
> +                          vmsd->minimum_version_id, ret);
> +            return ret;
> +        }
> +    } else if (vmsd->pre_load) {
>           ret = vmsd->pre_load(opaque);
>           if (ret) {
>               error_setg(errp, "VM pre load failed for: '%s', "
> @@ -242,7 +251,14 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>           qemu_file_set_error(f, ret);
>           return ret;
>       }
> -    if (vmsd->post_load) {
> +    if (vmsd->post_load_errp) {
> +        ret = vmsd->post_load_errp(opaque, version_id, errp);
> +        if (ret < 0) {
> +            error_prepend(errp, "VM Post load failed for: %s, version_id: %d, "
> +                          "minimum_version: %d, ret: %d: ", vmsd->name,
> +                          vmsd->version_id, vmsd->minimum_version_id, ret);
> +        }
> +    } else if (vmsd->post_load) {
>           ret = vmsd->post_load(opaque, version_id);
>           if (ret < 0) {
>               error_setg(errp,
> @@ -411,8 +427,16 @@ int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
>   static int pre_save_dispatch(const VMStateDescription *vmsd, void *opaque,
>                                Error **errp)
>   {
> +    ERRP_GUARD();
>       int ret = 0;
> -    if (vmsd->pre_save) {
> +    if (vmsd->pre_save_errp) {
> +        ret = vmsd->pre_save_errp(opaque, errp);
> +        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
> +        if (ret) {
> +            error_prepend(errp, "pre-save for %s failed, ret: %d: ",
> +                          vmsd->name, ret);
> +        }
> +    } else if (vmsd->pre_save) {
>           ret = vmsd->pre_save(opaque);
>           trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
>           if (ret) {
> @@ -427,7 +451,9 @@ static int post_save_dispatch(const VMStateDescription *vmsd, void *opaque,
>                                 Error **errp)
>   {
>       int ret = 0;
> -    if (vmsd->post_save) {
> +    if (vmsd->post_save_errp) {
> +        ret = vmsd->post_save_errp(opaque, errp);
> +    } else if (vmsd->post_save) {
>           ret = vmsd->post_save(opaque);
>           error_setg(errp, "post-save for %s failed, ret: %d",
>                      vmsd->name, ret);
> 


