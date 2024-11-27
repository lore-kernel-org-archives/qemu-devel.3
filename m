Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD266D609B0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 09:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGE6r-0000bp-Tt; Wed, 27 Nov 2024 04:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tGE6p-0000aF-It
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 04:13:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tGE6n-0003KX-Qd
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 04:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732698795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fAinqL4pQ1NhawHKPT5jqIM+Jldgrf9xrJdUPWN9/Vs=;
 b=KJhelQHElF2N90vXRPDigfgqG5z4AjZpgbGTOTqvmgiZ4ex6omq7bUAePBbXt7e8CM5iDH
 qxk9uzUm41wEGHA3TpVJZ8+BIPXD0zz361fSR62mxxN9lP20eX+yU571v6zegs/Yc6UmH4
 rsjwuH4pKCNJQ/muzPrWU2oAQq06WT4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-4oWljDccPpW7sqKDQNwKOA-1; Wed, 27 Nov 2024 04:13:13 -0500
X-MC-Unique: 4oWljDccPpW7sqKDQNwKOA-1
X-Mimecast-MFC-AGG-ID: 4oWljDccPpW7sqKDQNwKOA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38242a78f3eso3403894f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 01:13:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732698792; x=1733303592;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fAinqL4pQ1NhawHKPT5jqIM+Jldgrf9xrJdUPWN9/Vs=;
 b=e6Ca4hLOTvQUxAOZhVzzKjOaOehw1Z3rduA9IqvZSunjIjyLErZVgmqBccAUe+ZhB5
 GuiO1wkx4MMJxeeVDr853BY4kpDprRw4zBrL6qfi//pOsSyPRxe2LY8k8EGhGKRRdHPd
 1ri8mfW3+hPS/5+lTwXRZjB1WYHWkp7Z6bjqjfZQ47gLT6QaItPXC0+ZF6nTtxlqe9/Z
 tw4+zXDycxpievEKS807u0Jtczyd1pVYY1g6u/uTiwqGHbq32gXCtUN6bS3nt1cJiuOd
 tkXXFw9Qn21/ioT5te6L6gBYbpUDVPdFtePNCjdsUmRofC/VU64w2TpRJHKFZixZ0E8b
 SUZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8uZPTyoxTSF6J1fd+BCHNb3mvfIbzULcjBqHgUvajwp6snuLp7V0psTj5FJoneGAJYz3ozrcsLr89@nongnu.org
X-Gm-Message-State: AOJu0Yx9JMstyUwcM8q5vPAegQtYalikWfpBqneAR3oMkJTZbUsAAYjw
 wHq0f3ioPBvEfg9RmQB1Rg0pgLgZpPteKXngXB1iJq97UGdg22BzClD0psOm9WlpnV/AWloEGtx
 +Kj1pO8CV67Bq2djRG9twj3gb5wlzTlPNi9YjzZlnmaLC3VomW2Nc
X-Gm-Gg: ASbGncu38j/e7u9NriYJIyhu7vTb75TNRd5BGE4mVbfGCtY6Mkf2t9KjoxgTjO3AW8v
 l9SiJLCiqtrVSOalMLZA7oObhgEgCn9gQYO/5agWJEmns5qALe4rd3J9jNj4cvdXw0Bj7X2LciQ
 wsOsuUKCvHKtxfq6MalxhI1zOYPjhzZ6LhGZU1jy2YWMGytNRr0nmaH/H+r1Og9e80kfps9qGnO
 CvhpfLAaCCjp7CsNiDxi6ZcKmIl4vzYKP7xwqexr5lGKnDDuUK+2UQ57A5pViVOnuazV9LGlMbQ
 FvnfgMnj/ud3
X-Received: by 2002:a5d:59ad:0:b0:382:4725:7612 with SMTP id
 ffacd0b85a97d-385c6eb7ec0mr1556427f8f.4.1732698792239; 
 Wed, 27 Nov 2024 01:13:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG95dYeWcdEhD1Vy0M7+Dy7WVoDDmAduyrURB6MqeAzL0SCx+qbw7Z+OR/EHn5XEtB4NLRPiw==
X-Received: by 2002:a5d:59ad:0:b0:382:4725:7612 with SMTP id
 ffacd0b85a97d-385c6eb7ec0mr1556409f8f.4.1732698791895; 
 Wed, 27 Nov 2024 01:13:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd04ec7sm15800196f8f.110.2024.11.27.01.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 01:13:11 -0800 (PST)
Message-ID: <9a229308-2c80-4ee2-8c49-5fec2207ad74@redhat.com>
Date: Wed, 27 Nov 2024 10:13:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/24] migration: Add thread pool of optional load
 threads
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <877b7108c9cb9064615606d4c731cb12c549b7f9.1731773021.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <877b7108c9cb9064615606d4c731cb12c549b7f9.1731773021.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/17/24 20:20, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Some drivers might want to make use of auxiliary helper threads during VM
> state loading, for example to make sure that their blocking (sync) I/O
> operations don't block the rest of the migration process.
> 
> Add a migration core managed thread pool to facilitate this use case.
> 
> The migration core will wait for these threads to finish before
> (re)starting the VM at destination.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   include/migration/misc.h |  3 ++
>   include/qemu/typedefs.h  |  1 +
>   migration/savevm.c       | 77 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 81 insertions(+)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 804eb23c0607..c92ca018ab3b 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -45,9 +45,12 @@ bool migrate_ram_is_ignored(RAMBlock *block);
>   /* migration/block.c */
>   
>   AnnounceParameters *migrate_announce_params(void);
> +
>   /* migration/savevm.c */
>   
>   void dump_vmstate_json_to_file(FILE *out_fp);
> +void qemu_loadvm_start_load_thread(MigrationLoadThread function,
> +                                   void *opaque);
>   
>   /* migration/migration.c */
>   void migration_object_init(void);
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 3d84efcac47a..8c8ea5c2840d 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -131,5 +131,6 @@ typedef struct IRQState *qemu_irq;
>    * Function types
>    */
>   typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
> +typedef int (*MigrationLoadThread)(bool *abort_flag, void *opaque);
>   
>   #endif /* QEMU_TYPEDEFS_H */
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 1f58a2fa54ae..6ea9054c4083 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -54,6 +54,7 @@
>   #include "qemu/job.h"
>   #include "qemu/main-loop.h"
>   #include "block/snapshot.h"
> +#include "block/thread-pool.h"
>   #include "qemu/cutils.h"
>   #include "io/channel-buffer.h"
>   #include "io/channel-file.h"
> @@ -71,6 +72,10 @@
>   
>   const unsigned int postcopy_ram_discard_version;
>   
> +static ThreadPool *load_threads;
> +static int load_threads_ret;
> +static bool load_threads_abort;
> +
>   /* Subcommands for QEMU_VM_COMMAND */
>   enum qemu_vm_cmd {
>       MIG_CMD_INVALID = 0,   /* Must be 0 */
> @@ -2788,6 +2793,12 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
>       int ret;
>   
>       trace_loadvm_state_setup();
> +
> +    assert(!load_threads);
> +    load_threads = thread_pool_new();
> +    load_threads_ret = 0;
> +    load_threads_abort = false;

I would introduce a qemu_loadvm_thread_pool_create() helper.

Why is the thead pool always created ? Might be OK.


> +
>       QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>           if (!se->ops || !se->ops->load_setup) {
>               continue;
> @@ -2806,19 +2817,72 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
>               return ret;
>           }
>       }
> +
> +    return 0;
> +}
> +
> +struct LoadThreadData {
> +    MigrationLoadThread function;
> +    void *opaque;
> +};
> +
> +static int qemu_loadvm_load_thread(void *thread_opaque)
> +{
> +    struct LoadThreadData *data = thread_opaque;
> +    int ret;
> +
> +    ret = data->function(&load_threads_abort, data->opaque);
> +    if (ret && !qatomic_read(&load_threads_ret)) {
> +        /*
> +         * Racy with the above read but that's okay - which thread error
> +         * return we report is purely arbitrary anyway.
> +         */
> +        qatomic_set(&load_threads_ret, ret);
> +    }
> +
>       return 0;>   }
>   
> +void qemu_loadvm_start_load_thread(MigrationLoadThread function,
> +                                   void *opaque)
> +{> +    struct LoadThreadData *data;
> +
> +    /* We only set it from this thread so it's okay to read it directly */
> +    assert(!load_threads_abort);
> +
> +    data = g_new(struct LoadThreadData, 1);
> +    data->function = function;
> +    data->opaque = opaque;
> +
> +    thread_pool_submit(load_threads, qemu_loadvm_load_thread,
> +                       data, g_free);
> +    thread_pool_adjust_max_threads_to_work(load_threads);
> +}> +>   void qemu_loadvm_state_cleanup(void)
>   {
>       SaveStateEntry *se;
>   
>       trace_loadvm_state_cleanup();
> +
>       QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>           if (se->ops && se->ops->load_cleanup) {
>               se->ops->load_cleanup(se->opaque);
>           }
>       }
> +
> +    /*
> +     * We might be called even without earlier qemu_loadvm_state_setup()
> +     * call if qemu_loadvm_state() fails very early.
> +     */
> +    if (load_threads) {
> +        qatomic_set(&load_threads_abort, true);
> +        bql_unlock(); /* Load threads might be waiting for BQL */
> +        thread_pool_wait(load_threads);
> +        bql_lock();
> +        g_clear_pointer(&load_threads, thread_pool_free);
> +    }

I would introduce a qemu_loadvm_thread_pool_destroy() helper

>   }
>   
>   /* Return true if we should continue the migration, or false. */
> @@ -3007,6 +3071,19 @@ int qemu_loadvm_state(QEMUFile *f)
>           return ret;
>       }
>   
> +    if (ret == 0) {
> +        bql_unlock(); /* Let load threads do work requiring BQL */
> +        thread_pool_wait(load_threads);
> +        bql_lock();
> +
> +        ret = load_threads_ret;
> +    }
> +    /*
> +     * Set this flag unconditionally so we'll catch further attempts to
> +     * start additional threads via an appropriate assert()
> +     */
> +    qatomic_set(&load_threads_abort, true);
> +


I would introduce a qemu_loadvm_thread_pool_wait() helper

>       if (ret == 0) {
>           ret = qemu_file_get_error(f);
>       }
> 

I think we could hide the implementation in a new component of
the migration subsystem or, at least, we could group the
implementation at the top the file. It would help the uninitiated
reader to become familiar with the migration area.

Thanks,

C.


