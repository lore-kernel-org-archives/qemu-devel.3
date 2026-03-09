Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E047EA8525
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 03:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzRUa-0003Ql-CU; Sun, 08 Mar 2026 23:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vzRUZ-0003Q1-1O
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 23:41:15 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vzRUX-0005YU-AT
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 23:41:14 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so6693975eec.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 20:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773027672; x=1773632472; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wTtWxJjz7lZ3hjZtIiOrqt4lfqYT/6p3O035byP1zwQ=;
 b=MNqEf8VPiS+wJYkwzfe7vgULM69cGO1XUA5q36IdMYmx57ricbL4N8VqlKIeFpCE2I
 HHNrzK/CislPRRBJ+LqYYS0qsvpJ1iy85afWd0kMEqL5+pvckFxa5njGNNvHUTQQdFJj
 hWbX3UGLneVHXvyEi8r5Tc1uuggkZZGbVyvJws/M9pyVYfW8fHrHOZK1ybObQS0BoB8S
 qYIiCHlzT8tgk6bfq59ZicT3clne/h6yuMGZzOGbHawFC7+lqVpWeGmmxTmvk6c5K6i5
 h/MAA+7TPbqindArlxTb56yf04lU66rSwUARChZp4VxAizJoQaysSr6/C3NWkXFSO2f1
 w6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773027672; x=1773632472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTtWxJjz7lZ3hjZtIiOrqt4lfqYT/6p3O035byP1zwQ=;
 b=mBZ7JbYU1DFDP49D33me+97knBi6ty3p9wgFDUzw7Fe07iw7LdxMpE1K5PLIpVYA/9
 FFEiLYbEJS9dc9ytr4LFdp7e1VZPE5UmmOyqyWiZd7aK5oLhXa8nP/ltVIjG6nRy9M8E
 v2x6TXn9J1a7FD6oLzMhNNAI6RUPo3IOfxjjHl0O2Gr1wlspnPA645oNnmqVw8N8QnDb
 D+DHEWyW3b5oErKMfvsYjoGizz+5E6bHxEcQJfSjq6G/n4rmy6vNDkHbwPYPd/EgNOfh
 Q3JA0eLrtO9EIra7JWsOmJmoU7hBKpWxacP5WThCAI5DuODt9AcZY+27od1hIwvJY7IC
 ZFjw==
X-Gm-Message-State: AOJu0YwF+9EAKj5vDEh80+q1WIRKKnqr9Z4xm5Ye7zhLg9ih+aLodENX
 0hbqJzMA0bkqEQw4CCjJImvRPQ/EmntFfcOaCSSF1PFncu3MFOjpEJlh
X-Gm-Gg: ATEYQzxeEsUwhMqfu99B8IcJWYAW9Zq1H7Pzg1XzrY4OPcy+Bn1cWGLFH00tX/25Rv3
 hHc32nP42Xw4I4+ksLxvQVF4oZS0peXslVqvyaJgr+jHhLpuMpQr7IXKA8KYjL4aYzyd19mDQMd
 ZwajN8K6eY7N2K7LIPj/baO0pK3tUAd6MSUx4mS9SalnGynutGKsSFKiNcZO7qnBvnIhM/VVxTA
 e17j855oWB7DdmzFO/IVOi0JdIO96w+FZIgCWH4lxYYH0peUyhG6D7IWwPlWSaJNSDlSXcbHebR
 EnaGhK3MOc/GEFhzwkmB/v05z3aWW7AO9Jc8NF9JWWAA80zjbrf56IOqQApoJ4biJ/pLOUkzmk7
 fo3DwfexYIaiUNjr2fIqPq8HvufrTWtBMuuso+RCY8ic6I6axgkR+yId/CfsZTXjKkW6ge6flSV
 lg7b6WAUZ6SoRgZrvj7lIWAdoZox8OcHm5sNI8Zvk1QUCe74quY4DdrjNaJ4RHEAakRzpyp7pDa
 WIzzzvEFDP711BGG7qWoVpz8I4J1p8=
X-Received: by 2002:a05:7300:ed0d:b0:2bd:c8a2:954 with SMTP id
 5a478bee46e88-2be4e03a89fmr4321335eec.24.1773027671583; 
 Sun, 08 Mar 2026 20:41:11 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f96f25bsm7330063eec.28.2026.03.08.20.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 20:41:10 -0700 (PDT)
Date: Mon, 9 Mar 2026 11:40:29 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Free instance_init allocations in
 instance_finalize
Message-ID: <aa5A-m0nXq2ArYUQ@ZEVORN-PC.localdomain>
References: <20260307125222.3656140-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307125222.3656140-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Mar 07, 2026 at 12:52:22PM +0000, Peter Maydell wrote:
> The riscv-iommu device makes various allocations in its
> instance_init method. These will leak when QMP inits an
> object of this type to introspect it, as can be seen if you
> run 'make check' with the address sanitizer enabled:
> 
> Direct leak of 4096 byte(s) in 1 object(s) allocated from:
>     #0 0x5d8415b6ed9d in calloc (/home/pm215/qemu/build/san/qemu-system-riscv32+0x1832d9d) (BuildId: fedcc313e48ba803d63837329c37fd609dd50849)
>     #1 0x75c0502f1771 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63771) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x5d8416d09391 in riscv_iommu_instance_init /home/pm215/qemu/build/san/../../hw/riscv/riscv-iommu.c:2463:18
>     #3 0x5d841710483f in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
>     #4 0x5d8417104ee9 in object_initialize /home/pm215/qemu/build/san/../../qom/object.c:578:5
>     #5 0x5d8417104ee9 in object_initialize_child_with_propsv /home/pm215/qemu/build/san/../../qom/object.c:608:5
>     #6 0x5d8417104db1 in object_initialize_child_with_props /home/pm215/qemu/build/san/../../qom/object.c:591:10
>     #7 0x5d8417106506 in object_initialize_child_internal /home/pm215/qemu/build/san/../../qom/object.c:645:5
>     #8 0x5d8416d16a12 in riscv_iommu_sys_init /home/pm215/qemu/build/san/../../hw/riscv/riscv-iommu-sys.c:199:5
>     #9 0x5d841710483f in object_initialize_with_type /home/pm215/qemu/build/san/../../qom/object.c:570:5
>     #10 0x5d841710661f in object_new_with_type /home/pm215/qemu/build/san/../../qom/object.c:774:5
>     #11 0x5d841755d956 in qmp_device_list_properties /home/pm215/qemu/build/san/../../qom/qom-qmp-cmds.c:206:11
> 
> (and other similar backtraces).
> 
> Fix these by freeing the resources we allocate in instance_init in
> instance_finalize.  In some cases we were freeing these in unrealize,
> and in some cases not at all.
> 
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/riscv/riscv-iommu.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 98345b1280..225394ea83 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2479,6 +2479,18 @@ static void riscv_iommu_instance_init(Object *obj)
>      QLIST_INIT(&s->spaces);
>  }
>  
> +static void riscv_iommu_instance_finalize(Object *obj)
> +{
> +    RISCVIOMMUState *s = RISCV_IOMMU(obj);
> +
> +    g_free(s->regs_rw);
> +    g_free(s->regs_ro);
> +    g_free(s->regs_wc);
> +
> +    g_hash_table_unref(s->ctx_cache);
> +    g_hash_table_unref(s->iot_cache);
> +}
> +
>  static void riscv_iommu_realize(DeviceState *dev, Error **errp)
>  {
>      RISCVIOMMUState *s = RISCV_IOMMU(dev);
> @@ -2597,9 +2609,6 @@ static void riscv_iommu_unrealize(DeviceState *dev)
>  {
>      RISCVIOMMUState *s = RISCV_IOMMU(dev);
>  
> -    g_hash_table_unref(s->iot_cache);
> -    g_hash_table_unref(s->ctx_cache);
> -
>      if (s->cap & RISCV_IOMMU_CAP_HPM) {
>          g_hash_table_unref(s->hpm_event_ctr_map);
>          timer_free(s->hpm_timer);
> @@ -2675,6 +2684,7 @@ static const TypeInfo riscv_iommu_info = {
>      .parent = TYPE_DEVICE,
>      .instance_size = sizeof(RISCVIOMMUState),
>      .instance_init = riscv_iommu_instance_init,
> +    .instance_finalize = riscv_iommu_instance_finalize,
>      .class_init = riscv_iommu_class_init,
>  };
>  
> -- 
> 2.43.0
> 
> 

