Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCBFC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 06:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwyYD-0003Oh-4s; Wed, 17 Apr 2024 02:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwyYB-0003Nz-DH
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 02:13:43 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwyY9-00026g-Jh
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 02:13:43 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a51a7dc45easo576448266b.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 23:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713334420; x=1713939220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BST9eofDihaJOQCczXOl+g0fCVp+il5SxjEJuA0kWsg=;
 b=I2X0VwwZexkAjs7UVFH9RPFWU/ovFCGl40XZmgb4JE0gzzUl/cT+DU8I3N+0PwNSeD
 3QyLf9z101mmfJAlsdcNAFkVO5F5+Pm1Are+dZQfV2UqcwZyvYbJXLL0HA1SkeLkD98Q
 SJdRe5f1e9oRhCYYXJf0v40GdWj4ZjQCQ0obR/9+sZjQ8uqbAx4NAKWVN02tw8cIK6m1
 mpY9symjL4+Ujx30/AlkoBOyOs+amovFOlc12hdsfiBCaRCdCcLR1SDWAihHbWkv4cq7
 Jpejd/CR7gRXz1jHyeOity0FhDtPouL36J6iGAgDOq96xBWmAtfwnPIl5t1IBADlP+cX
 uNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713334420; x=1713939220;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BST9eofDihaJOQCczXOl+g0fCVp+il5SxjEJuA0kWsg=;
 b=C9CmJwxrrhGfy5Eavesw0M5J1lcuH7TBUG5QwSHs6SE2sxOlNDFyEXAYqpiemMUrl+
 7hoaI1t0R18rbgtLhnXH0/Ul/JMvR1bAwe7Lf/Pk+uPe/G4VLjpZucm7FI4U+oWuj0aV
 FHYDk8gKdx4fZLBVDjiOgAQHqm/byvRl1vtnekKduzR9NZP98dRRRljTWd+rgY/9nss5
 y2vbMXxPLXFSkk/K5noO/GchdlQJ0rqIg4d6ttaZNqSrI9L4CLZeN8/onsMTYo2yoNfE
 stj0KJ+CQvy/sPPfPXmIQCUu7PG2WvTxnvYcSujmIycYNeH9VG0b6cbvNt2gwnq1XBO0
 Dr5w==
X-Gm-Message-State: AOJu0Yz1yo/VzveV6bmOh/KbdAiPcyHRyey3Fnee5UqXD0M2Kr5abM9b
 XeVLPfWDRlh3atGV5zyayLzdz9shWeNdibmL7QkR/IaELefeXRPsFqSQns+gsD0=
X-Google-Smtp-Source: AGHT+IHOKddi5SQV/DNc37tKnwVIs+ODfDPv47GL2V93N8csCvYeS9dUrS0yPjIWjqudIMuYtk9+5w==
X-Received: by 2002:a17:907:6d18:b0:a51:e2a9:97c with SMTP id
 sa24-20020a1709076d1800b00a51e2a9097cmr14491984ejc.6.1713334419659; 
 Tue, 16 Apr 2024 23:13:39 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 b26-20020a17090630da00b00a526fcac8aesm3146166ejb.208.2024.04.16.23.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 23:13:39 -0700 (PDT)
Message-ID: <84c98291-c9a4-4349-9143-aff61e06c125@linaro.org>
Date: Wed, 17 Apr 2024 08:13:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] migration/colo: Fix bdrv_graph_rdlock_main_loop:
 Assertion `!qemu_in_coroutine()' failed.
To: Li Zhijian <lizhijian@fujitsu.com>, zhanghailiang@xfusion.com,
 peterx@redhat.com, farosas@suse.de
Cc: qemu-devel@nongnu.org, chen.zhang@intel.com,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>
References: <20240417025634.1014582-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240417025634.1014582-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 17/4/24 04:56, Li Zhijian via wrote:
> bdrv_activate_all() should not be called from the coroutine context, move
> it to the QEMU thread colo_process_incoming_thread() with the bql_lock
> protected.
> 
> The backtrace is as follows:
>   #4  0x0000561af7948362 in bdrv_graph_rdlock_main_loop () at ../block/graph-lock.c:260
>   #5  0x0000561af7907a68 in graph_lockable_auto_lock_mainloop (x=0x7fd29810be7b) at /patch/to/qemu/include/block/graph-lock.h:259
>   #6  0x0000561af79167d1 in bdrv_activate_all (errp=0x7fd29810bed0) at ../block.c:6906
>   #7  0x0000561af762b4af in colo_incoming_co () at ../migration/colo.c:935
>   #8  0x0000561af7607e57 in process_incoming_migration_co (opaque=0x0) at ../migration/migration.c:793
>   #9  0x0000561af7adbeeb in coroutine_trampoline (i0=-106876144, i1=22042) at ../util/coroutine-ucontext.c:175
>   #10 0x00007fd2a5cf21c0 in  () at /lib64/libc.so.6
> 
> CC: Fabiano Rosas <farosas@suse.de>

Cc: qemu-stable@nongnu.org

> Closes: https://gitlab.com/qemu-project/qemu/-/issues/2277
> Fixes: 2b3912f135 ("block: Mark bdrv_first_blk() and bdrv_is_root_node() GRAPH_RDLOCK")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V2: fix missing bql_unlock() in error path.
> ---
>   migration/colo.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index 84632a603e..5600a43d78 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -835,6 +835,16 @@ static void *colo_process_incoming_thread(void *opaque)
>           return NULL;
>       }
>   
> +    /* Make sure all file formats throw away their mutable metadata */
> +    bql_lock();

Note there is also the convenient BQL_LOCK_GUARD() macro.

> +    bdrv_activate_all(&local_err);
> +    if (local_err) {
> +        bql_unlock();
> +        error_report_err(local_err);
> +        return NULL;
> +    }
> +    bql_unlock();
> +
>       failover_init_state();


