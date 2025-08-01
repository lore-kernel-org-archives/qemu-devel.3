Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBD2C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 07:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhkKT-0002BG-CT; Fri, 01 Aug 2025 03:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uhkJ3-0001GB-60; Fri, 01 Aug 2025 03:35:58 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uhkJ1-0005q4-2i; Fri, 01 Aug 2025 03:35:56 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5717ZYBv049885
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 1 Aug 2025 16:35:34 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=2y6O6eJmlW8br8Xbx14qVgC3H1CnATGP9+F9kgI2orQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754033735; v=1;
 b=vDbnNQ3aTz2ZOIWqOtr8CBK7mo47PkqTwL4hu5aQc0ql1YxYFPA1YDNjMGY1Jvr3
 uwUtnGBxwfBPigjU/u+xe0NnyiZjZA5trkGLRlqFw7jHBTsEXUZltWmm3DcvZFss
 2k7ltv+iJLTeQiY4kKTu+0OeyxKgrsMH9ahTXuAqHpg6R71SOpARyVbknk3i3LBm
 Yk4asQyoH6UOG3rdWq+ttYwpQJfsAl8dzoZIn8zjXisY5/sxZGdArHWUMLBCTeWW
 DoNW4TrsknHvEa2J8if6TriiYkMU0i6gnGJdY1/wAtLxQDigY4vLZ0Bodlqvn8Os
 0v5pRHs419x3br/OCAz3Gw==
Message-ID: <f1a331ae-f520-44d7-82a7-c5dbef3440a2@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 1 Aug 2025 16:35:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 23/27] migration: Propagate last encountered error in
 vmstate_save_state_v() function
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
 <20250731-propagate_tpm_error-v8-23-28fd82fdfdb2@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250731-propagate_tpm_error-v8-23-28fd82fdfdb2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2025/07/31 22:21, Arun Menon wrote:
> Currently post_save hook is called without checking its return. If post_save
> fails, we need to set an error and propagate it to the caller.
> 
> Since post_save hook is called regardless of whether there is a preceeding error,
> it is possible that we have 2 distict errors, one from the preceeding function
> call, and the other from the post_save call.
> 
> Return the latest error to the caller.

This needs to be explained better. This patch makes two changes on the 
behavior when there are two errors:

1) Proceeding errors were propagated before, but they are now
    dismissed.
2) post_error() errors were dismissed before, but they are now
    propagated.

This message doesn't mention 1) at all. It does say 2) is necessary, but 
does not explain why.

> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   migration/vmstate.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index b725202bfcf69c3c81338f1f5479aa2ddc5db86f..25a819da069b982d4043f287b4562ea402d9eb0e 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -418,6 +418,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                            void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
>   {
>       int ret = 0;
> +    int ps_ret = 0;
>       const VMStateField *field = vmsd->fields;
>   
>       trace_vmstate_save_state_top(vmsd->name);
> @@ -533,7 +534,14 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                       error_setg(errp, "Save of field %s/%s failed",
>                                   vmsd->name, field->name);
>                       if (vmsd->post_save) {
> -                        vmsd->post_save(opaque);
> +                        ps_ret = vmsd->post_save(opaque);
> +                        if (ps_ret) {
> +                            ret = ps_ret;
> +                            error_free_or_abort(errp);
> +                            error_setg(errp,
> +                                       "post-save for %s failed, ret: '%d'",
> +                                       vmsd->name, ret);
> +                        }
>                       }
>                       return ret;
>                   }
> @@ -561,10 +569,12 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>       ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
>   
>       if (vmsd->post_save) {
> -        int ps_ret = vmsd->post_save(opaque);
> -        if (!ret && ps_ret) {
> +        ps_ret = vmsd->post_save(opaque);
> +        if (ps_ret) {
>               ret = ps_ret;
> -            error_setg(errp, "post-save failed: %s", vmsd->name);
> +            error_free_or_abort(errp);
> +            error_setg(errp, "post-save for %s failed, ret: '%d'",
> +                       vmsd->name, ret);
>           }
>       }
>       return ret;
> 


