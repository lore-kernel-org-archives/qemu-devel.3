Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E30EA854C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 02:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzQfo-0003pm-SE; Sun, 08 Mar 2026 22:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzQfl-0003p0-VS
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 22:48:45 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzQfk-0008Qc-AY
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 22:48:45 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6615c461d3fso5230467a12.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 19:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773024522; cv=none;
 d=google.com; s=arc-20240605;
 b=EOdBrvm+VIKAtF960eXLSXu+IfFnFdPRM1A28rRPAXkGADLRlNs/ezWCX5T54Yc2K9
 6V8WIMLEze7VwNi+OXkm4c0TqJWIZxaKCIwYFDFq/0ClOvlNzrPOZ6KmNA9pv0alBwEO
 4mdlTJSnRWzwTy+PRDc8WAb8Mob1bkyjJ/edIZ4h847ttD/KEtZ/zIElk2U9jJWvQB6X
 ZvTSR7kaCdnMO+PtUfbDO9uLHA5huUEwjmLkCA8D258HupGr34VzyeHneJHCPwfZZmjd
 FlryZXg2nOt1qBq49tBnzaNedJ2azDw3zqRhbplXEQDWBRB+72NgxpkS6rmtcCgLfC9I
 RGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MvrvG2jWSH3RI4Gi51QRXJBXB4fR2UdOx7dznIt1rDo=;
 fh=OB+sqaeSPNGtddv8NBpHBKr+XluyK9xGL9lrBlA84BU=;
 b=TvUBasiGkPvLywoB+9TBSkreNpjr8l+rFH7uSBBm1jROwLQtcXz3r+oOxUABTHxMO3
 yOQmuOcSW2zzv85qXwsCpGRkXbQjTZgI5fdWymX2ryBk9MSMMK3sIozMCaa7j7+ZLODO
 24U5MKed1gLFoAw01bde5uIByw+HC2B6/oS0Gi+j37YRQFGOUrAsnsEMshXoGdyNjQqh
 PZRc4UHyqJE2m0w5fvXBNzKNpweTF3HuldL6Ht7bmvDph4BaCqsrCRsrY3AAbh/+MVMo
 JzpdkRNvIRrdHkF9RQdYUkHzlSQh+Q2/yS4jkJNPnIyoBXQcP2UeDzw7o8b+t/OzJM9d
 TRyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773024522; x=1773629322; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvrvG2jWSH3RI4Gi51QRXJBXB4fR2UdOx7dznIt1rDo=;
 b=F7o78cIF2uYSvZ1kpU7avdzUpIC4mVbmq1AXahzSF7QUNQZcVQ6buzmfi1h6mHCuDP
 fFWDThMb7HRiTdLeWVLjO+kkD5Xt9jnsDPt1qsdFscjWRS87L5QJ0TR/3NfjtUwUZyKI
 jKy8da8Ht8O6phsThSptmd5KUeQ0eG46Mnd2a89k6d9GfJyWVoZvHxmcDTOHKuWm0ycc
 Q7pdc+FUKAvKcmxjOm/DEbtDg8lUkjdhSqdxVhgrcs2QQ5f84SWYcQRvemECBRQPCZ89
 UEsTLL+dc8V3jQQjqf8qhtGEMws/OLKk/FtftP2nfNVmo++0I1hcBe8Z1GDymPr1U0t/
 Hhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773024522; x=1773629322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MvrvG2jWSH3RI4Gi51QRXJBXB4fR2UdOx7dznIt1rDo=;
 b=itArgpRGuh2lsb43Gm6uolqvCsF/HziPUmsEMYbmEK/U+OcPoJlwF3TSO5lXXAQOG1
 hLch6NIEaMXlYcHnRqg87GHVlVL60+VD5Ae3yF6KNtSZEyhmZs/4vSvjloq1Yn9f+eMe
 LXJE+1q72zN0x4/4OKpuNWaFRoMfjo7CgSdKC4hIn16NLVk+ZIwuCMj55sAzz75XbLpl
 bPvARhK0B4iMSDP3GC8d9XgYrF+M36mZN+XMuIDauXzMOasov5sfHla9VMCqxFCRAdWK
 lWu20f+VzDQF3JAIYIZzDlxner3UwbLmEoaCo0oKpW7GPZ5E0HwR7yh7DV9IHWOR5Uhe
 M3vw==
X-Gm-Message-State: AOJu0Yw3FbHa9OlMc7zcBcz3BuCh5/ouupE+sMkzKsYKiLfTPBiO1cX5
 jyI72uI48dAiCVOM2n8KtZ+x6D5GDEbxMh45zr7RheYcRrAQsaQb47QfUH4hZnYs0GZIbPpEPbx
 VoUveZQHFkrVu06anFTK5ra9BA3IMu5k=
X-Gm-Gg: ATEYQzz93OqT8MbfU5s3M+Edp0qqdCHN0CeBw4EftSLHN48yljQNubZBWppkM1pccl0
 NFVhxpXNHKKUGf2kGZqmr8V9kzkcj5exN/bPp3vAOivoFKByqvK5QHzLg+SWoafPSto4UKJHA0c
 xm/lTTlBeA7P0mj4ESgGu/Kr4kkmgD92Yb0BsF2ZypPxy77ctYEUS2vhALRdnXqN3yJQBAIvyhL
 a2yAbkGZwJ4xls6G6zGscIw7RvR2SXSXes53nhfKmLqbt8+GoQrepUJwMXi2CvvWInY/a/BJDQ8
 ZwJCEr9uaclaWq72fHqhMV5L0Awg8bi98tRZkp7AiXl7HrVH
X-Received: by 2002:a05:6402:210b:b0:660:dd8e:5382 with SMTP id
 4fb4d7f45d1cf-6619d4a3429mr5219838a12.13.1773024522049; Sun, 08 Mar 2026
 19:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260307125222.3656140-1-peter.maydell@linaro.org>
In-Reply-To: <20260307125222.3656140-1-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Mar 2026 12:48:15 +1000
X-Gm-Features: AaiRm5117xvma0KXDuFWzUQzcqfVIu9iFhHJAX0AP3pUtstYjdFCVjzM0-wJJqo
Message-ID: <CAKmqyKPSC2BwK6dVP-aEkUGgWxyFeXdUjCs2mPDc1Pxd5H4jbA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Free instance_init allocations in
 instance_finalize
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Mar 7, 2026 at 10:53=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> The riscv-iommu device makes various allocations in its
> instance_init method. These will leak when QMP inits an
> object of this type to introspect it, as can be seen if you
> run 'make check' with the address sanitizer enabled:
>
> Direct leak of 4096 byte(s) in 1 object(s) allocated from:
>     #0 0x5d8415b6ed9d in calloc (/home/pm215/qemu/build/san/qemu-system-r=
iscv32+0x1832d9d) (BuildId: fedcc313e48ba803d63837329c37fd609dd50849)
>     #1 0x75c0502f1771 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.=
0+0x63771) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>     #2 0x5d8416d09391 in riscv_iommu_instance_init /home/pm215/qemu/build=
/san/../../hw/riscv/riscv-iommu.c:2463:18
>     #3 0x5d841710483f in object_initialize_with_type /home/pm215/qemu/bui=
ld/san/../../qom/object.c:570:5
>     #4 0x5d8417104ee9 in object_initialize /home/pm215/qemu/build/san/../=
../qom/object.c:578:5
>     #5 0x5d8417104ee9 in object_initialize_child_with_propsv /home/pm215/=
qemu/build/san/../../qom/object.c:608:5
>     #6 0x5d8417104db1 in object_initialize_child_with_props /home/pm215/q=
emu/build/san/../../qom/object.c:591:10
>     #7 0x5d8417106506 in object_initialize_child_internal /home/pm215/qem=
u/build/san/../../qom/object.c:645:5
>     #8 0x5d8416d16a12 in riscv_iommu_sys_init /home/pm215/qemu/build/san/=
../../hw/riscv/riscv-iommu-sys.c:199:5
>     #9 0x5d841710483f in object_initialize_with_type /home/pm215/qemu/bui=
ld/san/../../qom/object.c:570:5
>     #10 0x5d841710661f in object_new_with_type /home/pm215/qemu/build/san=
/../../qom/object.c:774:5
>     #11 0x5d841755d956 in qmp_device_list_properties /home/pm215/qemu/bui=
ld/san/../../qom/qom-qmp-cmds.c:206:11
>
> (and other similar backtraces).
>
> Fix these by freeing the resources we allocate in instance_init in
> instance_finalize.  In some cases we were freeing these in unrealize,
> and in some cases not at all.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
> +    RISCVIOMMUState *s =3D RISCV_IOMMU(obj);
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
>      RISCVIOMMUState *s =3D RISCV_IOMMU(dev);
> @@ -2597,9 +2609,6 @@ static void riscv_iommu_unrealize(DeviceState *dev)
>  {
>      RISCVIOMMUState *s =3D RISCV_IOMMU(dev);
>
> -    g_hash_table_unref(s->iot_cache);
> -    g_hash_table_unref(s->ctx_cache);
> -
>      if (s->cap & RISCV_IOMMU_CAP_HPM) {
>          g_hash_table_unref(s->hpm_event_ctr_map);
>          timer_free(s->hpm_timer);
> @@ -2675,6 +2684,7 @@ static const TypeInfo riscv_iommu_info =3D {
>      .parent =3D TYPE_DEVICE,
>      .instance_size =3D sizeof(RISCVIOMMUState),
>      .instance_init =3D riscv_iommu_instance_init,
> +    .instance_finalize =3D riscv_iommu_instance_finalize,
>      .class_init =3D riscv_iommu_class_init,
>  };
>
> --
> 2.43.0
>
>

