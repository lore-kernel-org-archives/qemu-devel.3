Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB41DC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 07:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhkJq-0001q8-Ov; Fri, 01 Aug 2025 03:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uhkJ1-0001FB-Jn; Fri, 01 Aug 2025 03:35:58 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uhkIy-0005p0-An; Fri, 01 Aug 2025 03:35:55 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5717ZOZP049860
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 1 Aug 2025 16:35:24 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ahAGXuEl8UqAOIIfQCSb+Q9A+ydZ3ewLQFr7jnluZFA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754033725; v=1;
 b=mdjy66ciBKYHIkcU4daoKAuRVrVfG7R/5/UOlN0lI7kTigWCseo2/KZUOC2MBktT
 l6NemdVsAwvNE1SifWMMMmr+VJ0STcs1dH7mKYbfx2Xs7qsUJXghrxIFB8x7IO/a
 gnnO/0D12Ol+XkmEtnuyr7uXemjG0oP9uxKQIw5RaixIr5ojImZlmXgD2VC4Di+A
 mSO6MzDKmfgMYKxMOsojAjZRzr/lUaDE04iA01BqCL/S+OrV5qgHKZAQSwd9XZmc
 jRPuOTJ044w9n8s8ZipgI6P+lCW3MX+IK89THHrQ8aFxv7pXCxZc9olG/N2PFVcJ
 U/FLKC9CF1sSXF1vUwEGjA==
Message-ID: <13363ce0-93d7-434d-a1ae-aeb14a75dbee@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 1 Aug 2025 16:35:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/27] migration: push Error **errp into vmstate_load()
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
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
 <20250731-propagate_tpm_error-v8-4-28fd82fdfdb2@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250731-propagate_tpm_error-v8-4-28fd82fdfdb2@redhat.com>
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

On 2025/07/31 22:20, Arun Menon wrote:
> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that vmstate_load() must report an error
> in errp, in case of failure.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   migration/savevm.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 842ff3dc6d5ccb05f7d33cef9f7319b141419501..736410be867a29efa24d749528c9bc203a3e8131 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -963,14 +963,20 @@ void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
>       }
>   }
>   
> -static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
> +static int vmstate_load(QEMUFile *f, SaveStateEntry *se, Error **errp)
>   {
> +    int ret;
>       trace_vmstate_load(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
>       if (!se->vmsd) {         /* Old style */
> -        return se->ops->load_state(f, se->opaque, se->load_version_id);
> +        ret = se->ops->load_state(f, se->opaque, se->load_version_id);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to load VM version_id: '%d', ret: '%d'",

This whole series have quoted and numeric messages mixed; I suggest 
removing quotes as they don't contribute better readability for numbers 
and make messages verbose.

> +                       se->load_version_id, ret);
> +        }
> +        return ret;
>       }
>       return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
> -                              NULL);
> +                              errp);
>   }
>   
>   static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
> @@ -2741,7 +2747,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type)
>           start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>       }
>   
> -    ret = vmstate_load(f, se);
> +    ret = vmstate_load(f, se, NULL);
>       if (ret < 0) {
>           error_report("error while loading state for instance 0x%"PRIx32" of"
>                        " device '%s'", instance_id, idstr);
> @@ -2794,7 +2800,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
>           start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>       }
>   
> -    ret = vmstate_load(f, se);
> +    ret = vmstate_load(f, se, NULL);
>       if (ret < 0) {
>           error_report("error while loading state section id %d(%s)",
>                        section_id, se->idstr);
> 


