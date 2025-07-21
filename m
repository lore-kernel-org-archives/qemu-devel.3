Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EEAC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 12:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udpMO-0007XT-14; Mon, 21 Jul 2025 08:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udpMJ-0006ub-3E; Mon, 21 Jul 2025 08:11:07 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udpMB-00078F-BX; Mon, 21 Jul 2025 08:11:06 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56LCAMpU044515
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 21 Jul 2025 21:10:23 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=+SB18LhifwMhnPKqTfjmQ8gmvC4aRrNSH8mjWGIc11Y=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1753099823; v=1;
 b=pY8TmominlU2gpMgjMx3nxIGE7gKSnetu53wjZ1OdUji+Yp0LMTvfP7f4jdkdF4V
 ftlbqbmjbld+7cNsoUL2xNSWss3k8mWh78WhoQDrvds+/1ViP82JwF33flseHSEv
 eVdTzY1gemR/Nk3cl/F2nE/FN+elHm0Tqm31FMYR2yIVOpPpCKhRfF0D+8NH02FP
 JUMrOINqeBzMoMlnxte07i6f2QLh62ElOM6mz612wCuE9COfp/UyrcSw1bJFSpW6
 a1Vwl03HVkOz0tbfVKesh7hiOyy+7CHIRgy8L5hLkZ6lvCRWCyL69eQVR5l/eerm
 0BFyUnJEVrQdwxmIeu79Aw==
Message-ID: <bf321448-6fe2-429e-a36a-9f9e0fb6bec5@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 21 Jul 2025 21:10:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/24] migration: push Error **errp into
 vmstate_subsection_load()
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
 <20250721-propagate_tpm_error-v6-1-fef740e15e17@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250721-propagate_tpm_error-v6-1-fef740e15e17@redhat.com>
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

On 2025/07/21 20:29, Arun Menon wrote:
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that vmstate_subsection_load() must report an error
> in errp, in case of failure.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   migration/vmstate.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 5feaa3244d259874f03048326b2497e7db32e47c..129b19d7603a0ddf8ab6e946e41c1c4d773d1fa8 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -25,7 +25,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
>                                      void *opaque, JSONWriter *vmdesc,
>                                      Error **errp);
>   static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
> -                                   void *opaque);
> +                                   void *opaque, Error **errp);
>   
>   /* Whether this field should exist for either save or load the VM? */
>   static bool
> @@ -225,7 +225,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>           field++;
>       }
>       assert(field->flags == VMS_END);
> -    ret = vmstate_subsection_load(f, vmsd, opaque);
> +    ret = vmstate_subsection_load(f, vmsd, opaque, NULL);
>       if (ret != 0) {
>           qemu_file_set_error(f, ret);
>           return ret;
> @@ -566,7 +566,7 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
>   }
>   
>   static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
> -                                   void *opaque)
> +                                   void *opaque, Error **errp)
>   {
>       trace_vmstate_subsection_load(vmsd->name);
>   
> @@ -598,6 +598,8 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>           sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
>           if (sub_vmsd == NULL) {
>               trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
> +            error_setg(errp, "VM subsection '%s'  in '%s' does not exist",

There are two whitespaces before "in" but I think we only need one.

> +                       idstr, vmsd->name);
>               return -ENOENT;
>           }
>           qemu_file_skip(f, 1); /* subsection */
> @@ -608,6 +610,8 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>           ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
>           if (ret) {
>               trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
> +            error_setg(errp, "Loading VM subsection '%s' in '%s' failed : %d",
> +                       idstr, vmsd->name, ret);
>               return ret;
>           }
>       }
> 


