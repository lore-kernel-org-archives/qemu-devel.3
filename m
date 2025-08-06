Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7D1C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 05:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujWR0-0003hD-Ef; Wed, 06 Aug 2025 01:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ujWQw-0003ca-C0; Wed, 06 Aug 2025 01:11:26 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ujWQr-00035i-Vd; Wed, 06 Aug 2025 01:11:26 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5765AfTY022550
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 6 Aug 2025 14:10:42 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=utGiHnYJ6YtJ/HU17T9qS3pEpFtDM7mXxpmltXL6oBU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754457042; v=1;
 b=aQsoVaOlZDxOncOfLN89YDqTMqASjJfhsf9v7rFaZVCb9QiDqgZA+dR0cgTwf8x6
 kWJkJERyTsmIk37RHu4yTgXp+SEWIX22L2GPCq5rqHqyNUFyWa7QVwuuLbL6LCzW
 a8rXvmUuGtEITsRtT6yJP44NyzRqxXBwEk867DOMJmhmMR3oRMnvz1uC5iEr0iQA
 TJx+ooBZDI5iDMm5TaOzEDVx77DZshBn76rCUOqOym87CaPFxMQeltEN5BX3JX/M
 /GrQsPiITRYW2SN70sRivg77uhQorHWzZuxsraLW8k4PD6J+PgEtlCUgqh2TMAs5
 TnUCtEDLtq/pRr00SXY1Ig==
Message-ID: <293e470b-6835-4ad0-b502-8a1a0eea525d@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 6 Aug 2025 14:10:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 23/27] migration: Refactor vmstate_save_state_v()
 function
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
 <20250805-propagate_tpm_error-v9-23-123450810db7@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250805-propagate_tpm_error-v9-23-123450810db7@redhat.com>
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
> The original vmstate_save_state_v() function combined multiple
> responsibilities like calling pre-save hooks, saving the state of
> the device, handling subsection saves and invoking post-save hooks.
> This led to a lengthy and less readable function.
> 
> To address this, introduce wrapper functions for pre-save,
> post-save and the device-state save functionalities.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   migration/vmstate.c | 78 ++++++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 60 insertions(+), 18 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 60ff38858cf54277992fa5eddeadb6f3d70edec3..fbc59caadbbcc75fe6de27b459aa9aa25e76aa0a 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -414,22 +414,43 @@ int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
>       return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, errp);
>   }
>   
> -int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> -                         void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
> +static int pre_save_dispatch(const VMStateDescription *vmsd, void *opaque,
> +                             Error **errp)
>   {
>       int ret = 0;
> -    const VMStateField *field = vmsd->fields;
> -
> -    trace_vmstate_save_state_top(vmsd->name);
> -
>       if (vmsd->pre_save) {
>           ret = vmsd->pre_save(opaque);
>           trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
>           if (ret) {
> -            error_setg(errp, "pre-save failed: %s", vmsd->name);
> -            return ret;
> +            error_setg(errp, "pre-save for %s failed, ret: %d",
> +                       vmsd->name, ret);
>           }
>       }
> +    return ret;
> +}
> +
> +static int post_save_dispatch(const VMStateDescription *vmsd, void *opaque,
> +                              Error **errp)
> +{
> +    int ret = 0;
> +    if (vmsd->post_save) {
> +        ret = vmsd->post_save(opaque);
> +        error_setg(errp, "post-save for %s failed, ret: %d",
> +                   vmsd->name, ret);
> +    }
> +    return ret;
> +}
> +
> +static int vmstate_save_dispatch(QEMUFile *f,
> +                                 const VMStateDescription *vmsd,
> +                                 void *opaque, JSONWriter *vmdesc,
> +                                 int version_id, Error **errp)
> +{
> +    ERRP_GUARD();
> +    int ret = 0;
> +    int ps_ret = 0;
> +    Error *local_err = NULL;
> +    const VMStateField *field = vmsd->fields;
>   
>       if (vmdesc) {
>           json_writer_str(vmdesc, "vmsd_name", vmsd->name);
> @@ -532,9 +553,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                   if (ret) {
>                       error_setg(errp, "Save of field %s/%s failed",
>                                   vmsd->name, field->name);
> -                    if (vmsd->post_save) {
> -                        vmsd->post_save(opaque);
> -                    }
> +                    ps_ret = post_save_dispatch(vmsd, opaque, &local_err);
>                       return ret;
>                   }
>   
> @@ -557,16 +576,39 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>       if (vmdesc) {
>           json_writer_end_array(vmdesc);
>       }
> +    return ret;
> +}
>   
> -    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
>   
> -    if (vmsd->post_save) {
> -        int ps_ret = vmsd->post_save(opaque);
> -        if (!ret && ps_ret) {
> -            ret = ps_ret;
> -            error_setg(errp, "post-save failed: %s", vmsd->name);
> -        }
> +int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> +                         void *opaque, JSONWriter *vmdesc, int version_id,
> +                         Error **errp)
> +{
> +    ERRP_GUARD();
> +    int ret = 0;
> +    Error *local_err = NULL;
> +    int ps_ret = 0;
> +
> +    trace_vmstate_save_state_top(vmsd->name);
> +
> +    ret = pre_save_dispatch(vmsd, opaque, errp);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ret = vmstate_save_dispatch(f, vmsd, opaque, vmdesc,
> +                                version_id, errp);
> +    if (ret) {
> +        return ret;
>       }
> +
> +    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
> +    ps_ret = post_save_dispatch(vmsd, opaque, &local_err);

local_err leaks here.

> +    if (!ret && ps_ret) {
> +        ret = ps_ret;
> +        error_setg(errp, "post-save failed: %s", vmsd->name);
> +    }
> +
>       return ret;
>   }
>   
> 


