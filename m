Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316E4CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGHQV-0006Xu-N9; Mon, 12 Oct 2026 10:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1xGHQJ-0006Jq-LO
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:54:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1xGHQH-0004rQ-VS
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:54:43 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0Qf42088624
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 14:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=qyieATY+92xROrdlPKOWMx6JxrR3KPBPFfw2XlNeY7o=; b=Ah
 +16Nqrj5kjDRnQC55Ur+iE742Q9LvbLZvLsi+N9dZFIR1bT8Q0x5pyTaZGxdpHwR
 r/y9Wij9l3PvGy4F7DMfv6wiUn4K5YJ4eoY9WYvRFmV1PeiWS2xSIGuYa3p4E/cc
 oXtN4J914ySVSOW4+lbSd0g3pFznene1PhhYYF8evHBrlUm+aPVZtaiOHkuFbBJM
 rOYs4/FsHGEdJvpbo4T0gev/r/TtJSWbUDCAsnov546EEiOBvWcrCya1pciNVisH
 9xtJdIv2HHY8cFzmF9SiIoxjAu7JtiXPUUQlf1ze+0q9zhsleRr05GuCulWnxGYs
 b3tRhKbOfuK9tTbwIePA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sgu2fed-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 14:54:40 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-837aaa9a3f6so19993287b3.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791816880; cv=none;
 d=google.com; s=arc-20260327;
 b=LlLIVkIFopNAWS467l2aiHFJTTpPUokzxRifNb2ygKWR3C0PBMSk7tIc9QkHS5gvRg
 16XgKIBz6stOdsaUBwquxA1SV2PXdL3HomVWoO0JJLgjj2KbQfanIZtq1EsDrU6UBWqY
 T4RjTfeHAgNv5Cl1cDf6hEn/7c9qkqozqVWXMY7LnMnpqPtop8MBxpyydRz8LH1VZtXt
 n5jd0NfLb7sAwRvsLw2AZuYMJ9fVqYCoiwGSf9orkV3w7XXuVNmdh8Wt9001snhFoW65
 XaFZtSa3lKryITC4xeY1c5/kDWLk9CPzBo32Jiltq7lYGmPQX0sfBEPXlV3+cXsQTE29
 yGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=qyieATY+92xROrdlPKOWMx6JxrR3KPBPFfw2XlNeY7o=;
 fh=r0J+HPcfTowdh9DQWXSwxaVazWIaGX5sOKyW3RtyfkQ=;
 b=MzsmW9zYl2r4HAghEfAYwomWTGSxuFT5QDOSnv6Gpq+3LLoOqMPxbjNu3JOH8Lpjqw
 cCsGyaR9Bz39yx+CldzBsIdp5MX3oYj/kh0HrV1DjG/G2KlTYnGhnZ8IExbFZpj26DxH
 YaB8LGwntUwZAVzRF6j44upBP0yNHzbsNRVtict8W8DHzw27T6XCWO6u7feKYVpFGiaS
 rLCGzIMOpB/cIygmUY20LvIiNRenvAaZzskixecPlzF5MP5c0irj9yI5W1YsPlemhpnt
 XZ2dXKWxLVOZImF5XWbWBG35TX1gShfOahlXgLCC/C1sFhROilktyzgIi00ipMIKIm5H
 qpKg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791816880; x=1792421680; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qyieATY+92xROrdlPKOWMx6JxrR3KPBPFfw2XlNeY7o=;
 b=H6Z+ZRTFJozF5jbzhoGxz6Tmsw3bIZWSI5+b42IuLu6ocSwlwjhobFF7WVpzJnLpeO
 +ewk6796VwerdSvxinGKBJSDu5YIkudyXshPMgQ1mO1+m0uOHGxTYpxNtdbhSHyRFwXc
 Kd3987NJ/fV0VR3NVMAELoTkuWV1XLOT8Cef/A5cQpvxB61XQLBemW4fDAoWXy366hkg
 /+p3NrwjoN5j03K3nCZS1Aa0jAh+H01qWiV4JWvWa4bs8XTVoHXL3wJZKOH4H89nkdj6
 R6+Gs1RKpNlRwTAGDgg8iMCUrQOUzgpADqTWJDgUkiEEgzlPXR8oOkyHJ3TN9UruiSSE
 e2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791816880; x=1792421680;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qyieATY+92xROrdlPKOWMx6JxrR3KPBPFfw2XlNeY7o=;
 b=QHB/AmstiwYz5UUCvIEYagxFoUY6fQuZHI0KYmymNT9SYM5xkhwc5op/PE4rIzhiDj
 HmAdSuYqLoD0/JC9wqsNyF4MNJX/yt+BHiBlLKiMP0212HXGswoq6Yl7TapcxyWZTBNb
 KNnFl0UNAz0i7qrsj1xf1xRYFxW8E9D7INLAHj4ideQy+2bkO5NHmfFKtQd81L3K/cDS
 72CDin1y6vMQYdwaPgBF4atuHeu8eIZPDI//3R9wwHCRAYIbB3a946BdcB8Bu8JzqtSd
 i0ctB5xKicYHtQJqBXrOf1jIXULx86zLKGJGLhcvfzFuRJcEARYKwkqHDNLcyppOGXD3
 bplQ==
X-Gm-Message-State: AFq9FYKUnJzvgXPZstqfwFIKn9gHxX+y2mbPHRA3HINoHiT7j/mPP4QH
 X4uxSki7UrKkG2cixheXAQOdZ2t1McfB6bLNvgsou+1Bm4Xydpa1QK2XHPPHdP/ZR4tN5u2himj
 enQEGJoRZlJY//HCZ7042uS5SogVBaYyyra4wDBw+4ZuhEDE6zVQH3Vbai6Ocp0NiK5NljeqLaS
 v8ob/Nb2u7eVxyGm3lUboOci2hzfNu8zQp
X-Gm-Gg: AYBFou0QW3+YWM+tmzJ27fFGWsdOuhOaYjtXOEYZE9WYEz0D0a8RTxvAOHNLllZy6hA
 QPlbIJaISK+PZ0xjskmwo5JsYyF0TFD0499WwXhrQufMR41vX0ebjIKZ5iHKznmXXncFuBkhG55
 erF63uB5Q8gEe2wM5P0jxWe+uV68VfFhFb0pC+inUCb3HTe5cf6mXY6KxsatQ=
X-Received: by 2002:a05:690c:e3c8:b0:8b0:a4f7:7353 with SMTP id
 00721157ae682-8b0a4f775ffmr10617827b3.13.1791816879759; 
 Mon, 12 Oct 2026 07:54:39 -0700 (PDT)
X-Received: by 2002:a05:690c:e3c8:b0:8b0:a4f7:7353 with SMTP id
 00721157ae682-8b0a4f775ffmr10617707b3.13.1791816879301; Mon, 12 Oct 2026
 07:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20261011182552.1071742-1-sunilvl@oss.qualcomm.com>
 <20261011182552.1071742-3-sunilvl@oss.qualcomm.com>
 <3847ee55-78c8-496d-942e-104def334b72@oss.qualcomm.com>
In-Reply-To: <3847ee55-78c8-496d-942e-104def334b72@oss.qualcomm.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 20:24:28 +0530
X-Gm-Features: AclHuK8e0tPjv5_TbUWC_CP-4zcIPPK3hmQhvkYa7b6gcr2vBon3rc_JVzq2mEU
Message-ID: <CAB19ukGY_o3E4qzmHRvPHA+5HAUokRp_5CowLR5rQOW+pke-mA@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/riscv/virt: Add ACPI PPTT table
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>,
 Drew Fustini <fustini@kernel.org>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=QdzzLcbv c=1 sm=1 tr=0 ts=6accf4b0 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=Bq6zwJu1AAAA:8
 a=QGs316aN6dwDMrRK9cwA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=KQ6X2bKhxX7Fj2iT9C4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1OSBTYWx0ZWRfX43EuKeixW6Cy
 rmphCjskGVL+x/7VRQXxYpU7NgXH3hSeDI6EINqOgF08qpQ9Bzj3Nq8dKfOwj8KZwM0slg9IHWt
 qBflESWPdpyGHMt3BskabiLdLJbUIft4yvulDM1FxgMCvQFY39L+9/wP1X45qZNZ0mDmz1YQLa+
 0fjl8uCNvX/dEP3Q0b2mSWwcJD3rYVJgWIY36g7CMQxK8Km0CMdTR8+jPJwUQ7fNwSsnafljX0q
 1ozYjlPmhHNDsvDYvOUjtlrDh7TLyyrc4afID+baC1MOU6mufnZ6ZKMcyMYpxBKBt2EQD4+L71U
 GYuHHtg1wT8EWX+Dqt1tz9PW62f15V58N43WTLvumY4pPqgRK+Fh9tNnOZtDakg00Im/9FzfZYh
 LBkLJdPnVrQ1oo4Fk55N16+sMzG3jvJZUr5CMslNV3Rp47aKrWEq+KNzxoedMvwAGJl/mY/7X+w
 tgs2O6tcuHT2OdYOWZQ==
X-Proofpoint-ORIG-GUID: J6CK-Sjy3f3Dl8mpSGTEg5AaT2fd6CaF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1OSBTYWx0ZWRfX6+zSEJ37OwwM
 5xJbYhnygjgiIXnLeSIF/E0/r/WyIVS4rntZR7AjtXAbdjWhc4mQmeDwVHCAbTfEI5GWFHlRr/t
 2n/1ECXXXqFcChbw7QFODm5fkIuOa0Q=
X-Proofpoint-GUID: J6CK-Sjy3f3Dl8mpSGTEg5AaT2fd6CaF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120059
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Reply-To: sunilvl@oss.qualcomm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Daniel,

On Mon, Oct 12, 2026 at 3:09=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Hi Sunil!
>
> On 10/11/2026 3:25 PM, Sunil V L wrote:
> > From: Sunil V L <sunilvl@oss.qualcomm.com>
> >
> > Generate the Processor Properties Topology Table (PPTT) for the RISC-V
> > virt machine.
> >
> > Describe the machine using separate L1 data and instruction caches plus
> > unified L2 and L3 caches, and enable the corresponding cache and cluste=
r
> > SMP properties.
> >
> > Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > ---
> >   hw/riscv/virt-acpi-build.c |  7 +++++
> >   hw/riscv/virt.c            | 54 +++++++++++++++++++++++++++++++++++++=
+
> >   include/hw/riscv/virt.h    |  4 +++
> >   3 files changed, 65 insertions(+)
> >
> > diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> > index 0475dcb5c601..3c72a03dadb6 100644
> > --- a/hw/riscv/virt-acpi-build.c
> > +++ b/hw/riscv/virt-acpi-build.c
> > @@ -882,7 +882,10 @@ static void virt_acpi_build(RISCVVirtState *s, Acp=
iBuildTables *tables)
> >       unsigned dsdt, xsdt;
> >       GArray *tables_blob =3D tables->table_data;
> >       MachineState *ms =3D MACHINE(s);
> > +    CPUCoreCaches caches[CPU_MAX_CACHES];
> > +    unsigned int num_caches;
> >
> > +    num_caches =3D virt_get_caches(caches);
>
> So if we have virt_get_caches() as:
>
> unsigned int virt_get_caches(CPUCoreCaches *caches)
> {
>      for (int i =3D 0; i < ARRAY_SIZE(virt_caches); i++) {
>          caches[i] =3D virt_caches[i];
>      }
>
>      return ARRAY_SIZE(virt_caches);
> }
>
>
> And then we do:
>
>
>      CPUCoreCaches caches[CPU_MAX_CACHES];
>      unsigned int num_caches;
>
>      num_caches =3D virt_get_caches(caches);
>
>
> Isn't that the same as:
>
>
>      CPUCoreCaches caches[CPU_MAX_CACHES];
>      unsigned int num_caches =3D ARRAY_SIZE(virt_caches);
>
>      memcpy(caches, virt_caches, num_caches * sizeof(CPUCoreCaches));
>
>
> and then we can get rid of virt_get_caches()?  Am I missing something?
>
Yes, memcpy looks better but I would like to keep the
virt_get_caches() function.
I also missed defining the array as static in virt.c. Let me make those cha=
nges
and send v2.

Thanks,
Sunil

