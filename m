Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FE0C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 12:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqAeN-0005jn-DK; Mon, 16 Sep 2024 08:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenyzha@redhat.com>)
 id 1sqAeI-0005PK-0L
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenyzha@redhat.com>)
 id 1sqAeB-0000UE-GV
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726488962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7XHYgu+al8w35VZ43QPTcPnTcScVSz3NhYxZGUejxpQ=;
 b=BVi+/tZLSUsD9DLijkvjZV1IpJWdnIF4UqRJTxC8nxxNPtf5OL6+0HxGFGmQN33F4ajiuG
 T9WuNv+r1jbTGpzM5AeHebCuILoog7vWnV0jMYaJCwcJ7Llnrn/Z0esoZa67+YgtE0C/zH
 +olV6VoOg5CnFsupxnQG/pg/KlblBuw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-HaowosuSMLyd1XGfw2123w-1; Mon, 16 Sep 2024 08:14:25 -0400
X-MC-Unique: HaowosuSMLyd1XGfw2123w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a870f3a65a0so34069266b.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 05:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726488864; x=1727093664;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XHYgu+al8w35VZ43QPTcPnTcScVSz3NhYxZGUejxpQ=;
 b=lOUR4XmdBubFgp+V3NwSl4AP4Rg+eK+0K9SkG8AyooATbFn5u4gqgA38yNcUmR57ki
 dWLUJVkZXhuikUQnZJqxqx9iXDVcGz+fUgDXxNCY8QHOisg4TB5GBKotZCEcJUv1bQ/0
 Fp8jG3HOHqcCDTzhgsXMnZMXklwkHUihuC8zrXnUI7G3ZenG4nq3L0gcwDNL9JTWGaoS
 z4kZ/bcc3/fH/wLY5C5c/ZeTAxDmdSdbS6jvdK9G0kmNj/XGQWAUc6KhS2qYJPhQu1i3
 IGx9jHR2xtfU5vU/s07imLCbia8CWqa5TIWP6+9HQAMXupA2Dl0bnYH/C1UF+pKpRJ0v
 r2RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI/RL3IRYzOMabyqJcyPyJqhQQvq/zFwJ0bszCBdhW0/966kQEfD3fRmNRJS3UG+4l7NDVAWZsEQtN@nongnu.org
X-Gm-Message-State: AOJu0Yz0NRmTXaGj4egO6gMjYP/7bqF53jDIrkvnOzYHBdyN6wTG0xlH
 o1aGQ5D/LzJZmkpzwY70I0MD3MqWEW/+glInNMyJUiURZL1drl/TMjSg8qmadgmpzLxh124bC5x
 pQSNw4yk5KAdxsQvGApZzrhjOGMG9m8eG/5yPYAmr5PAZmseVDkr0e62rTGyzHOFixXCOg4PCFi
 e7H5kYzMX/XJe64gAw+cLSxni+5cyN7r0h6Qo=
X-Received: by 2002:a17:907:e662:b0:a8d:75ab:17aa with SMTP id
 a640c23a62f3a-a90294a4b21mr1478144366b.37.1726488864258; 
 Mon, 16 Sep 2024 05:14:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO+XoQ7vkzuqclXeqEFszltxt3s8F6RfbS/p8+JU4dtWuCIFdwE1ZJ6+qg5s1euw3m+J84KaaV/dDiUYboHdo=
X-Received: by 2002:a17:907:e662:b0:a8d:75ab:17aa with SMTP id
 a640c23a62f3a-a90294a4b21mr1478137066b.37.1726488863141; Mon, 16 Sep 2024
 05:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240915233117.478169-1-gshan@redhat.com>
In-Reply-To: <20240915233117.478169-1-gshan@redhat.com>
From: Zhenyu Zhang <zhenyzha@redhat.com>
Date: Mon, 16 Sep 2024 20:13:46 +0800
Message-ID: <CAJFLiBJLEqbf16Dt6UxfVeE6eC=fQ=eA0A7Y2r8LWgPbtf4tpQ@mail.gmail.com>
Subject: Re: [PATCH] hostmem: Apply merge property after the memory region is
 initialized
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, david@redhat.com, 
 imammedo@redhat.com, philmd@linaro.org, pbonzini@redhat.com, 
 peter.maydell@linaro.org, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=zhenyzha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

[PATCH] hostmem: Apply merge property after the memory region is initialize=
d

Test on 4k and 64k basic page size aarch64
The patches work well on my Ampere host.
The test results are as expected.

# /home/test/qemu.main/build/qemu-system-aarch64  \
   -accel kvm  -machine virt -cpu host                           \
   -object memory-backend-ram,id=3Dmem-memN0,size=3D4096M,merge=3Doff

Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>


On Mon, Sep 16, 2024 at 7:31=E2=80=AFAM Gavin Shan <gshan@redhat.com> wrote=
:
>
> The semantic change has been introduced by commit 5becdc0ab0 ("hostmem:
> simplify the code for merge and dump properties") even it clarifies that
> no senmatic change has been introduced. After the commit, the merge
> property can be applied even the corresponding memory region isn't
> initialized yet. This leads to crash dump by the following command
> lines.
>
>   # /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64  \
>     -accel kvm  -machine virt -cpu host                      \
>     -object memory-backend-ram,id=3Dmem-memN0,size=3D4096M,merge=3Doff
>     :
>     qemu-system-aarch64: ../system/memory.c:2419: memory_region_get_ram_p=
tr: \
>     Assertion `mr->ram_block' failed.
>
> Fix it by applying the merge property only when the memory region is
> initialized.
>
> Fixes: 5becdc0ab083 ("hostmem: simplify the code for merge and dump prope=
rties")
> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  backends/hostmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 4e5576a4ad..181446626a 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -178,7 +178,7 @@ static void host_memory_backend_set_merge(Object *obj=
, bool value, Error **errp)
>          return;
>      }
>
> -    if (!host_memory_backend_mr_inited(backend) &&
> +    if (host_memory_backend_mr_inited(backend) &&
>          value !=3D backend->merge) {
>          void *ptr =3D memory_region_get_ram_ptr(&backend->mr);
>          uint64_t sz =3D memory_region_size(&backend->mr);
> --
> 2.45.2
>


