Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447DBEA8551
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 03:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzRlw-0006uG-Vr; Sun, 08 Mar 2026 23:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzRlv-0006te-SQ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 23:59:11 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzRlt-0007oD-2k
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 23:59:11 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b96f02b4329so101301866b.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 20:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773028747; cv=none;
 d=google.com; s=arc-20240605;
 b=Gt3Fy26EM/20s9qWUHPoE7vPNHsyjW5hKW53v+RJDUYFviaDl7Uy3wwqgkc1cbFKFW
 R4pP1bDODEwON8emix3RZxsXVr/3f+pKxH/l9KGUPvPdCGIVR441klaQ4r/t2RnAhyTf
 WUmCprraNkzLffy8Y3iQXOYvYUnboru4vk7homy8nRCiqA+BMK6m7zK0vVdT6zfoBurk
 zdJIbCMgltj3hlDHKpWXI8aPPDKr8FKbFdGE4V49HbSooq9nc/P4hMkL2VKXDYvmDWr+
 JLByIh6IVEfT2D2HNt917p2h+YyYOUh/+PzYayquLlNGOFDjCVYdI3q0kS3wt2Y2BoDN
 oH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=laN/908x31mRl1ZCOeSOXIYp8CBwzvMltdkeFhZHb6Q=;
 fh=OB+sqaeSPNGtddv8NBpHBKr+XluyK9xGL9lrBlA84BU=;
 b=jQARZFfxzi2wwqZRZgDoDc17TR3gQpASuWI8fC3qow0DLtqKn0xESPYc5+755V1e30
 GIgw++zbndzOs5zFcbySHC/2sR6BdhiD3qVneHS3JbJxc9zvwCnUXSfF92CNd+qFz7Ny
 qlOT6PKz1EmB/K7ekeXnrRChQ+TwKyE1p6JMhIXv0s+qMYic1DckNpppVJT+RQqyYYOZ
 8LxVQteXSlCeASNAN+XhahoY5sYDLt0lEijapT5877o//riLtq8qXkzQ2UJ9+uiWYxik
 +g73oYKaRDi+y5hy9lmeZwxBEu3ghDA+rlOke9XNgpfdxfr3MsqSAQJMRI7y7Oz5LjYF
 aEXQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773028747; x=1773633547; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=laN/908x31mRl1ZCOeSOXIYp8CBwzvMltdkeFhZHb6Q=;
 b=BzuAZQo5DIw606JbpUmkMwWeVgW7yYk40DzqOWjdtBrOysMzb6YY876c9Er4PPPAVY
 RlTXYn2CCxXCBxiV0WA4R7p0xnUkKRIxdCWahUp5X/rlqcNm6BE7U7fe7ftbQImwqn5B
 0eQObtiQsvRFjw1UGj2D0dd8LHIN0yQbgkN0addgxkekXvZcj1iStPqtIiOS1pONN0YB
 Readhy3e00Sk/hU0TBb2rKrzsHlaRvKvvc+cZXXWXEGfBgSxZFuU/AcdMmrgmCC1wrpC
 Ys08zpk+p2e0SnGMpfI49k9y5T+mslNl866W42cAuTKC24UX1hGo4qev4zpS93u3qkej
 XETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773028747; x=1773633547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=laN/908x31mRl1ZCOeSOXIYp8CBwzvMltdkeFhZHb6Q=;
 b=Jk64c6XLpYO7GLkQ06T7TWV9M5bucjKvLyqejY9byS3x4vvi/xk7FzwQOB/2NqNrc1
 K0AUsjsZcr2iPN4tcfRF6s83EPZLzzh6/GGzW0fqHXh4XQKmaRDRqMZtHaCNINorhwde
 bSIBXI9wDBLzGEUrrsdosBlfLt3m91y1j0l3T/c3eO3IqDb2DN8O+u1tFSJPNPY6tWU3
 BLoSnxgN+bcobMnkH9chdklNnVH8gsshNLaUfZ/F/0uajBPy6tIdCtgMtDVRqs+8MAmO
 NNdkwMhV1KcsX2mvVasTWWOLZCC1Gr8fICLqkFtm5gVgKiQccJdnT4OgJFqxma++JWgd
 jSGQ==
X-Gm-Message-State: AOJu0YynjN0gRhY+gEnKY3hGjHJsDov606n0VC6m9WtqljtSkzj2Z0Ek
 +ycN0BbU2IPO8+5GzsjVBdCvsse7NHvApMvzIZ5h3ezDPCaCW05jMPXY9c24wx9jNd8vGGQ1fxK
 Itj9HTxwOLqvnbfEP8gYBiRxe90Xb9qc=
X-Gm-Gg: ATEYQzyu5QERkjWXfGeN6Kec9Ef4slnluUeUQhAXgdfzKhSTYHGJyrs6cnY7/gbS52J
 rrPPy0CFZprCLW7Nvh1FTc2VeFpHlSrD1bM6OAZMeECF6wTr1kX4lZ40Wja4euFe8gotgfd1kEy
 O9A11POpWdDWBw7jnhPRVYNS4Y5bcJrBcdNzBKE88zm939UEp7L/AHAj3a2aY+CsSIai5alZT+k
 KCpAeYbfB+2E7eFCCkAUu/e78hc5s1fJV4FhvyuL++DxfbWg3c0BcElKEek91Nb1gWh4uDJ5q0s
 hAIyjjvW2vIXN81wfx5wYM15eSo1vkysHPGQeg==
X-Received: by 2002:a17:907:98d:b0:b93:5351:7e30 with SMTP id
 a640c23a62f3a-b942e026243mr532857466b.61.1773028746762; Sun, 08 Mar 2026
 20:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260307125222.3656140-1-peter.maydell@linaro.org>
In-Reply-To: <20260307125222.3656140-1-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Mar 2026 13:58:40 +1000
X-Gm-Features: AaiRm51agPZFm_1GXsboBU2XG8WBeleksbWaAo86BL31Iu5G20DuNAqdGg4pFuk
Message-ID: <CAKmqyKOmU9dkq_VhgN5QEy9G81CZHO0JBReCwLkwhFz-KkEWgw@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Free instance_init allocations in
 instance_finalize
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

