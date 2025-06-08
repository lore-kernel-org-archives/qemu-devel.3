Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26C1C5AD49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 08:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOBDU-00080f-4l; Sun, 08 Jun 2025 04:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uOBDR-00080L-4v; Sun, 08 Jun 2025 04:17:17 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uOBDM-0007gk-GA; Sun, 08 Jun 2025 04:17:16 -0400
Received: from [157.82.203.223] ([157.82.203.223]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5588GtQM022037
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 8 Jun 2025 17:16:56 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=T9rZfoFZmPjiozfTnHuPIhnvQtmIEpWoWotOf9XSBS4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1749370616; v=1;
 b=Yw5GXRKkQxjfIY61QeoEvCSSoXTiAYRotcfmmPXXnNAK17dyLdTQ/hiTuyssAvdd
 ji5dXLWTADpgs+JKSthBknFH1U3MklloDqMCvgoFtEVgvn1dlilN1AyMRlaxjes2
 3FSmjOR2mqazO+jMMiK8Mp2yhZvhP+q5quLoNnYxgny7EkDXVlJZYnonk5j/cvEV
 THu3/hnfyXYmDoky8aqgFrdwQUCXN1EBBzlppKAduAisVfrZKUK3p8c4hlxxxbpZ
 Vjg2/T3dbkxUgIhtDloKLXfoUDt4e39dFVidxsIcNyBwd97l74i5e7xDAYNlZ8rs
 WURbMincUBBLWa1aX6lGEw==
Message-ID: <6c4b9d6a-d86e-44cf-be48-f919b81eac15@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 8 Jun 2025 17:16:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/17] virtio-gpu: refactor async blob unmapping
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
 <20250605162651.2614401-11-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250605162651.2614401-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/06/06 1:26, Alex Bennée wrote:
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
> Change the 3 part async cleanup of a blob memory mapping to check if the
> unmapping has finished already after deleting the subregion; this
> condition allows us to skip suspending the command and responding to the
> guest right away.

This patch has no effect because "[PATCH v3 13/20] virtio-gpu: refactor 
async blob unmapping" was dropped:
https://lore.kernel.org/qemu-devel/20250521164250.135776-13-alex.bennee@linaro.org/

This is because dropping the patch prevented the unmapping operation 
from finishing after deleting the subregion. I'll show this by showing 
that the patch broke the reference counting in details first, and then 
by showing that the correct reference counting prevents the unmapping 
operation from finishing.

If !vmr->finish_unmapping when virtio_gpu_virgl_unmap_resource_blob() is 
called, there are the following references:

- owner -> subregion
- container -> owner
- FlatView -> owner

Note that reference 2 and 3 were made by memory_region_ref(), which 
makes references to the owner.

For simplicity, let's assume there are only these references for the 
subregion.

And the following functions are called. Note that the order represents 
the time order and the indention represents the call stack.

The main thread:
  bql_lock()
  virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended)
   memory_region_del_subregion(&b->hostmem, mr)
    memory_region_transaction_commit()
     address_space_set_flatview(as)
      flatview_unref(old_view)
       call_rcu1(&old_view->rcu, flatview_destroy)
        qemu_event_set(&rcu_call_ready_event)
    memory_region_unref(mr)
     object_unref(mr->owner) (a)
   object_unparent(OBJECT(mr))
    object_property_del_child(OBJECT(&b->hostmem), OBJECT(mr))
     object_finalize_child_property(OBJECT(&b->hostmem), name, mr)
      object_unref(mr) (b)

The RCU thread:
  call_rcu_thread(NULL)
   qemu_event_wait(&rcu_call_ready_event)
   bql_lock()
   flatview_destroy(old_view)
     memory_region_unref(mr)
      object_unref(mr->owner) (c)

(c) always happens after (b) due to the BQL. The correspondence between 
the object_unref() call and the removed references are as follows:

(a) container -> owner
(b) owner -> subregion
(c) FlatView -> owner

With "[PATCH v3 13/20] virtio-gpu: refactor async blob unmapping", the 
owner is g (VirtIOGPU). So the correspondence will be interpreted as 
follows:

(a) container -> g
(b) g -> subregion
(c) FlatView -> g

Therefore, the subregion will be freed with (b), incorrectly ignoring 
(c). (b) is made during object_unparent(OBJECT(mr)), so it made the 
unmapping operation finish early.

Without "[PATCH v3 13/20] virtio-gpu: refactor async blob unmapping", 
the owner was the memory region itself. So the correspondence will be 
interpreted as follows:

(a) container -> subregion
(b) subregion -> subregion
(c) FlatView -> subregion

Therefore, the subregion will be freed with (c). So the unmapping 
operation will never finish until the BQL gets unlocked.

Regards,
Akihiko Odaki

>  
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-Id: <20250410122643.1747913-4-manos.pitsidianakis@linaro.org>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-ID: <20250603110204.838117-11-alex.bennee@linaro.org>
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 71a7500de9..b4aa8abb96 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -155,7 +155,32 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>        *    asynchronously by virtio_gpu_virgl_hostmem_region_free().
>        * 3. Finish the unmapping with final virgl_renderer_resource_unmap().
>        */
> +
> +    /* 1. Check if we should start unmapping now */
> +    if (!vmr->finish_unmapping) {
> +        /* begin async unmapping. render will be unblocked once MR is freed */
> +        b->renderer_blocked++;
> +
> +        memory_region_set_enabled(mr, false);
> +        memory_region_del_subregion(&b->hostmem, mr);
> +        object_unparent(OBJECT(mr));
> +        /*
> +         * The unmapping might have already finished at this point if no one
> +         * else held a reference to the MR; if yes, we can skip suspending the
> +         * command and unmap the resource right away.
> +         */
> +        *cmd_suspended = !vmr->finish_unmapping;
> +    }
> +
> +    /*
> +     * 2. if virtio_gpu_virgl_hostmem_region_free hasn't been executed yet, we
> +     * have marked the command to be re-processed later by setting
> +     * cmd_suspended to true. The freeing callback will be called from RCU
> +     * context later.
> +     */
> +
>       if (vmr->finish_unmapping) {
> +        /* 3. MemoryRegion has been freed, so finish unmapping */
>           res->mr = NULL;
>           g_free(vmr);
>   
> @@ -166,16 +191,6 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>                             __func__, strerror(-ret));
>               return ret;
>           }
> -    } else {
> -        *cmd_suspended = true;
> -
> -        /* render will be unblocked once MR is freed */
> -        b->renderer_blocked++;
> -
> -        /* memory region owns self res->mr object and frees it by itself */
> -        memory_region_set_enabled(mr, false);
> -        memory_region_del_subregion(&b->hostmem, mr);
> -        object_unparent(OBJECT(mr));
>       }
>   
>       return 0;


