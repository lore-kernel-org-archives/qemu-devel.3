Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A12C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 06:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhjcS-0006jo-Mu; Fri, 01 Aug 2025 02:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uhjGA-0005ck-CH; Fri, 01 Aug 2025 02:29:02 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uhjG3-0000uN-5M; Fri, 01 Aug 2025 02:28:54 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5716SC2W024431
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 1 Aug 2025 15:28:12 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=b6uUMqJaXZzLOHjSfSXacYW9RH6k0o55Fq6Exuc2ebI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754029693; v=1;
 b=r+JGYFkY6XULQoCZsooRTGuk0px74aFcZughfvhdZNnTR33OvXSb+xey/RvdB9pQ
 zga7ZS1ZZjY7ONKPbWV9RAEVzlVLZKYG63O17F8fwMZ7TrhCR2UxJUe2wQo11/Ev
 LsFfm+12AodhG/Vpx0lvaNPrFqJas5D5uoYJqTbkqm65+UeDCPX4NNduRnP+9gsT
 mvT4e47CFIGxbCf2IbVkYwv9EtGkHhGZApzgvn+zrWaXDTuAe8zeg8H8wJU/RfGu
 uXO//Z0htpKJrmSQYAW9YALok12pk0FQegqlp7vKLAbCFqLlxtM93uEtE7VnOP4F
 +hwpYz7v5yeHIKwK65N6Nw==
Message-ID: <7014e103-e266-4270-8f24-947b11b1092f@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 1 Aug 2025 15:28:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/27] migration: push Error **errp into
 qemu_loadvm_state_header()
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
 <20250731-propagate_tpm_error-v8-3-28fd82fdfdb2@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250731-propagate_tpm_error-v8-3-28fd82fdfdb2@redhat.com>
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
> It is ensured that qemu_loadvm_state_header() must report an error
> in errp, in case of failure.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   migration/savevm.c | 27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index ab947620f724874f325fb9fb59bef50b7c16fb51..842ff3dc6d5ccb05f7d33cef9f7319b141419501 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2814,35 +2814,44 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
>       return 0;
>   }
>   
> -static int qemu_loadvm_state_header(QEMUFile *f)
> +static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
>   {
>       unsigned int v;
>       int ret;
>   
>       v = qemu_get_be32(f);
>       if (v != QEMU_VM_FILE_MAGIC) {
> -        error_report("Not a migration stream");
> +        error_setg(errp, "Not a migration stream, magic: %x != %x",
> +                   v, QEMU_VM_FILE_MAGIC);
>           return -EINVAL;
>       }
>   
>       v = qemu_get_be32(f);
>       if (v == QEMU_VM_FILE_VERSION_COMPAT) {
> -        error_report("SaveVM v2 format is obsolete and don't work anymore");
> +        error_setg(errp,
> +                   "SaveVM v2 format is obsolete and no longer supported, "
> +                   "file version %x != %x",
> +                   v, QEMU_VM_FILE_VERSION_COMPAT);

This actually "==". This added message is redundant and better to be 
removed as v == QEMU_VM_FILE_VERSION_COMPAT whenever this message is 
printed.

> +
>           return -ENOTSUP;
>       }
>       if (v != QEMU_VM_FILE_VERSION) {
> -        error_report("Unsupported migration stream version");
> +        error_setg(errp, "Unsupported migration stream version, "
> +                   "file version %x != %x",
> +                   v, QEMU_VM_FILE_VERSION);
 >           return -ENOTSUP;>       }
>   
>       if (migrate_get_current()->send_configuration) {
> -        if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
> -            error_report("Configuration section missing");
> +        v = qemu_get_byte(f);
> +        if (v != QEMU_VM_CONFIGURATION) {
> +            error_setg(errp, "Configuration section missing, %x != %x",
> +                       v, QEMU_VM_CONFIGURATION);
>               return -EINVAL;
>           }
> -        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
> -                                 NULL);
>   
> +        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
> +                                 errp);
>           if (ret) {
>               return ret;
>           }
> @@ -3119,7 +3128,7 @@ int qemu_loadvm_state(QEMUFile *f)
>   
>       qemu_loadvm_thread_pool_create(mis);
>   
> -    ret = qemu_loadvm_state_header(f);
> +    ret = qemu_loadvm_state_header(f, NULL);
>       if (ret) {
>           return ret;
>       }
> 


