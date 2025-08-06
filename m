Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E01C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 05:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujWe8-0004vh-Vo; Wed, 06 Aug 2025 01:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ujWe5-0004ov-4T; Wed, 06 Aug 2025 01:25:01 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ujWe3-0005Md-5H; Wed, 06 Aug 2025 01:25:00 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5765Obx4026769
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 6 Aug 2025 14:24:38 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=DpnuxVGiOycWhUr24jk22G5hNwgdUVJG5d9NkWehf5k=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754457878; v=1;
 b=IvVBfvJkjkEurU1Qq1mtavC1UTR6Kf4QVIL2oTlmsMNNRVisUpDaXlC8canVxL0o
 Vm3KxLmbMuAKNtmQcVPClVOQ4TGWY2aKsznTwKq2r1L4XAC6kfTNVlhprHYFFUPP
 9eE5jGxOIdCQLvJ2vB329e4ebw+gRrAd6rK+Eg8gZiBE7/4xqFECe+8Uu7k49Vup
 12o3+6TmX9CMWFPF4aFYqWkOkhVBNZeEdis1cdfSydjHhelNpRc7U8OSeLuSRORm
 d51kkcbveGxQKOKuTpifNL+yGjdCA8rQmJRRdlvf5yL3XWyPdxvlISDfEvOEslaB
 W/3/x1Sn0zIyupOjvINqcw==
Message-ID: <a8d174a7-44cf-48b0-ae6c-4e33e9a2e232@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 6 Aug 2025 14:24:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 24/27] migration: Propagate last encountered error in
 vmstate_save_state_v() function
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
 <20250805-propagate_tpm_error-v9-24-123450810db7@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250805-propagate_tpm_error-v9-24-123450810db7@redhat.com>
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
> We consider,
>    - the saving of the device state (save or subsection save) and
>    - running the cleanup after (post_save)
> as an atomic operation. And that is why, post_save() is called regardless
> of whether there is a preceeding error. This means that, it is possible
> that we have 2 distict errors, one from the preceeding function and the
> other from the post_save() function.
> 
> This commit changes the error handling behavior when two errors occur during
> a save operation.
> 
> 1) Preceding errors were propagated before, but they are now dismissed, if there
>     is a new post_save() error.
>      - A failure during the main save operation, means the system failed to
>        reach a new desired state. A failure during the post-save cleanup,
>        however, is a more critical issue as it can leave the system in an
>        inconsistent or corrupted state. At present, all post_save() calls
>        succeed. However, the introduction of error handling variants of these
>        functions (post_save_errp) in the following commit, imply that we need
>        to handle and propagate these errors. Therefore, we prioritize reporting
>        the more severe error.

This explains why the post_save() error is propagated instead of 
propagating the preceding error. But the preceding errors still do not 
have to be dismissed if we report them with error_report_err() instead.

> 
> 2) post_save() errors were dismissed before, but they are now propagated.
>      - The original design implicitly assumed post-save hooks were infallible
>        cleanup routines.
>        This will not be the case after introducing the post/pre save/load errp
>        variant functions. Dismissing these errors prevents users from
>        identifying the specific operation that failed.

Re-iterating previous comments, if introducing post save errp variant 
functions break the assumption, we just don't have to introduce one. The 
reason to introduce one needs to be explained.

>        The entire save-and-cleanup process is treated as a single
>        logical operation, and all potential failures are communicated.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   migration/vmstate.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index fbc59caadbbcc75fe6de27b459aa9aa25e76aa0a..ef78a1e62ad92e9608de72d125da80ea496c8dd1 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -554,6 +554,12 @@ static int vmstate_save_dispatch(QEMUFile *f,
>                       error_setg(errp, "Save of field %s/%s failed",
>                                   vmsd->name, field->name);
>                       ps_ret = post_save_dispatch(vmsd, opaque, &local_err);
> +                    if (ps_ret) {
> +                        ret = ps_ret;
> +                        error_free_or_abort(errp);
> +                        error_setg(errp, "post-save for %s failed, ret: %d",
> +                                   vmsd->name, ret);
> +                    }
>                       return ret;
>                   }
>   
> @@ -603,10 +609,14 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>       }
>   
>       ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
> +
>       ps_ret = post_save_dispatch(vmsd, opaque, &local_err);
> -    if (!ret && ps_ret) {
> +    if (ps_ret) {
> +        if (ret) {
> +            error_free_or_abort(errp);
> +        }
>           ret = ps_ret;
> -        error_setg(errp, "post-save failed: %s", vmsd->name);
> +        error_propagate(errp, local_err);
>       }
>   
>       return ret;
> 


