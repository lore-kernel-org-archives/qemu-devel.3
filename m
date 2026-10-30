Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C46606A334
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 05:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MnGTdp/M;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dWn7Eado
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMf8r-0007fn-RN; Fri, 30 Oct 2026 01:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1xMf8n-0007f4-TL
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 01:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1xMf8m-0003NE-F0
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 01:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793338019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRsNbAHpudxEenLMORDVEFfulu4vxVjp8oQNw/o1bgI=;
 b=MnGTdp/MMB2nVzA1vUEKUzOuCbQGzTNCmzaINKd5WuvxEsnN/2qXiMGhHSUmfMPCg7OR8q
 fslmBKujaq1VfNNFkjifdow0b8A7r6nzxZmZjYFVbcuC+1Idf+SX2qVXgvKJ7qljb9cP9B
 KnshWDbs3drKqKyrsSp5/Z+YEYPhYB4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-yNbsCFiJPCG5g_c_cKBjiA-1; Fri, 30 Oct 2026 01:26:57 -0400
X-MC-Unique: yNbsCFiJPCG5g_c_cKBjiA-1
X-Mimecast-MFC-AGG-ID: yNbsCFiJPCG5g_c_cKBjiA_1793338016
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ea381ce04fso5025655ad.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 22:26:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793338016; cv=none;
 d=google.com; s=arc-20260327;
 b=bfDBbegsvhF9gRdx5gIBhPmXijOGoweAGO6QLEPVuTSwtU3OMrfd6buPoEUwF4rpHI
 T1R+Yua4nddwjZvDmaDBsePBq50KgOowfVmw/Ag/HuS/vtUznwLdakoanMMOeSvAZlC4
 9Od9RcVGAJzzDLPXliLgk8CTJSJ7le3W2HSycQvD41Izo8/wlX55rqiogkhCKUQjLWKY
 PLLw+hiBjibt2x6pZNNygtU6kDJx9OTMS6oTKx6YKxm6NTkL1GCZxjcvwbYk9OoBEnks
 NAuaF9l1z+8xmBxEo2QV1JKKpwrkrPOS0TFDd2/gyDcui4tqpAnn9O/q4jxtu8Jy1JGg
 HtiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mRsNbAHpudxEenLMORDVEFfulu4vxVjp8oQNw/o1bgI=;
 fh=gC9WThtCBEwSjXwVXbPerUJtkzrkpim/kc5UAA4fn2o=;
 b=Ilykx/WHkXrq/s7ikjbdgPdTQxEZoOGP3bisPV0Wd2QJBadKQtJomXzP/T/Zs0HumQ
 CIK8HBJvJrkuJzqj88QEZDIfX8RGiL/Ve5m9dacbScNv1RUCo0fu2gaU6/5/OdY3JfGo
 OqURYVlVsjzsBQO7OlIkhkfcP7+p/TDARLVk3NIQ2SawXMZ+eJGcab6Tv5woZwAvEWOz
 QgMvvFsBQZZ8iMPQLrflRIkR+gJloXrvz/uS0yxFNr6b7dAaJSJ/9SP4hdNOyl+99Plh
 aZ8MgFv+AHzEJ84hBepZy4SkucHr7Vhl42GHATaAYSrkgXuUvtbluTp2oZqIlkpmMS4d
 3HPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793338016; x=1793942816; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mRsNbAHpudxEenLMORDVEFfulu4vxVjp8oQNw/o1bgI=;
 b=dWn7Eado2fZ03ARuqIpILUFekICEGaAH8rMP5dMTjYngEiHgc2rMt+nAUQAKhxUm0m
 TH1+TPFaJY0BQWK2qQ/XlnOvPMObyH4aJDqPT/4jvkSTElWvAUUjdb3et0P4atkq8Qwr
 60XFLG8r6KBFfXv+Jbia6rdE1+hJhdR+GhQzzafe+6dzLzd3aSgFAmJCs0Zd4PbBH7kK
 iqljGm3f4zOTApQKu1kGBu+kc4hQ9R3BcVJzELbl4e44Jj9cFIsEFA7bd0C1jYz/bvGx
 p7b4wRUsrYwJy3tGrWiEEejO6ryNBI/Y03KmISiMbu6i6z2s2jia7t0yqFehfyRuv2rJ
 2tNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793338016; x=1793942816;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mRsNbAHpudxEenLMORDVEFfulu4vxVjp8oQNw/o1bgI=;
 b=1jmy8onZUt0S3DWWy9neR+HyjZ7YBxQfZMG2SV01/w5p99u6ZXNhSOKJkTFYfrCpRn
 +S1q+2HWqQyHzoyUCliyi5wdfFdhxxFYW967a8r1MYW89L/YFlRoQegm3fSnOfztfH/g
 l2NlTB6I0YBbdB1+HgkRR3lMT6BikkOeIscS5t1HElq7elgx7/azrCmIBTAq17LLJ6/q
 7yFDkLnuLHx9NeOB8CyH5/t1PkwxyjYyASZBtffpo4mit8x9pi5vMZgNoWAvqSGC7C7L
 wzkGyooOnHHF7Qt9j+O6vFpBMFg/4iVQUizOPRZDZkucgWlQjlR6K3+RPfnL2+5j7O5A
 sJjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2OONjMu1u9QIhyiNJFbEJCEBNgraeIeYd+0GvG1qNGPUkla6sE8LlpD2vVpsGjCiz5PiSa1CfBGbT@nongnu.org
X-Gm-Message-State: AFq9FYKEyaN4KITF9Z6e+8VbncG2baUEmfahbcMCV2IjfJ9rt0sR9Hs3
 JdDbR26MCXHgOnl1Yw4mV91W+pqmsCOpEUVRRG/x/1slnercSE3q5Ze/I9ldAKBV40tOwDsyoqq
 rLvumrcoTG00Zdci7xQGVruVKQE+ACPm2xTa1LlqN2s6Tuew/6bkr0wKUjZwcyPLnzSnsHfaQ44
 j90oaDfl/aQ5RmmEV42kJQ6Led1LIfPdY=
X-Gm-Gg: AYBFou08Bx4jckmTtwywKOLZ5bJQ9n4gDkuw72fVylJ1G+X0IKaL2pLtLXjAlwGd1GH
 BISZBEpddzYzQ255E3bh8CWZ2hoNSOMWn5Yl42RX3hTZHP2WEaZ3CAFfnuawikOjCfCQqcgWrNR
 O5pyCDl0iMTCok8Y1QWO80M00Cnznoahaqu5MaKfC65tsv/ioKoh06MJ6qM8Xn77DQC12cbKB6i
 LsGe3vf5/QC2dlc
X-Received: by 2002:a17:903:1786:b0:2e2:d3ef:125 with SMTP id
 d9443c01a7336-2eb3640f000mr11804835ad.5.1793338016409; 
 Thu, 29 Oct 2026 22:26:56 -0700 (PDT)
X-Received: by 2002:a17:903:1786:b0:2e2:d3ef:125 with SMTP id
 d9443c01a7336-2eb3640f000mr11804705ad.5.1793338015962; Thu, 29 Oct 2026
 22:26:55 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029143742.294275-1-eric.auger@redhat.com>
 <20261029143742.294275-10-eric.auger@redhat.com>
In-Reply-To: <20261029143742.294275-10-eric.auger@redhat.com>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Fri, 30 Oct 2026 10:56:39 +0530
X-Gm-Features: AclHuK8IchFk1YCWtlGSwksthnpix-UcaExYdZJoq4kbbQKvsBekB7r_RPWOGRQ
Message-ID: <CAJg9KkydH099qM7vFeYOkEMwus7a1hYODEy+5gE+z37+xdhCHQ@mail.gmail.com>
Subject: Re: [PATCH v2 for-11.2 9/9] hw/arm/virt: Make sure virt_get_caches()
 keeps on reading CLIDR_EL1 as 0
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, skolothumtho@nvidia.com, 
 philmd@oss.qualcomm.com, 7746591750@163.com, maobibo@loongson.cn, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, 
 daniel.barboza@oss.qualcomm.com, milesg@linux.ibm.com, farman@linux.ibm.com, 
 cohuck@redhat.com, alireza.sanaee@huawei.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 8:08=E2=80=AFPM Eric Auger <eric.auger@redhat.com> =
wrote:
>
> In KVM mode, virt_get_caches() currently gets a zero value for the
> CLIDR_EL1 register. This is due to the fact CLIDR is never read from
> host. This is a bug.
>
> Soon we will initialize all writable isar.idreg[] from host and this
> includes CLIDR_EL1. However, we cannot directly fix the initialization,
> first because it would change the way caches are exposed to guest in
> DT/ACPI descriptions and because some host values would be rejected
> by the current QEMU code, especially in the case host has a unified
> L1 cache which is currently not supported and triggers the following
> error: "Unified type is not implemented at level 1" error.
>
> So this issue will be fixed separately.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Khushit Shah <khushit.shah@nutanix.com>
> Reviewed-by: Gustavo Romero <gromero@redhat.com>
>
> ---
>
> v1 -> v2:
> - fix the commit msg and improved comment (Gustavo)
> ---
>  hw/arm/virt.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0d56197dac..a80c60f3fa 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -338,6 +338,21 @@ unsigned int virt_get_caches(const VirtMachineState =
*vms, CPUCoreCaches *caches)
>      ARMISARegisters *isar =3D &armcpu->isar;
>      uint32_t clidr =3D GET_IDREG(isar, CLIDR);
>
> +    /*
> +     * Commit f669de70011 ("hw/arm/virt: add cache hierarchy to device t=
ree")
> +     * read the CLIDR value from the isar array. However, in KVM mode, w=
e failed
> +     * to initialize that register value from host and the resulting bug=
 is that
> +     * we have always read 0.
> +     *
> +     * Soon we will initialize all writable isar.idreg[] from host, incl=
uding
> +     * CLIDR_EL1 but we will need to handle compat properly and also ext=
end the
> +     * support to unified L1 cache. For now do not pretend we have somet=
hing
> +     * different from 0.
> +     */
> +    if (kvm_enabled()) {
> +        clidr =3D 0;
> +    }
> +
>      for (int cache_level =3D 1; cache_level <=3D CLIDR_CTYPE_MAX_CACHE_L=
EVEL;
>           cache_level++) {
>          uint8_t ctype =3D
> --
> 2.53.0
>
Reviewed-by: Mohammadfaiz Bawa <mbawa@redhat.com>


