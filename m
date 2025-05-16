Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59867C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 00:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFibR-0008Kv-B7; Thu, 15 May 2025 20:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFibE-0008Fl-Cz; Thu, 15 May 2025 20:06:52 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFib7-0002fC-62; Thu, 15 May 2025 20:06:51 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7423df563d6so1682454b3a.0; 
 Thu, 15 May 2025 17:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747354003; x=1747958803; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+gk6EV22H8YMdbVP/4hXSoq8A2EIKX/ulF/tv0ylKs=;
 b=Wex3wauo0xYcsHapW9+aiAfTh7MMR4izgP2V10CWVbf4cx8a+kRXDjYgK1dO/fU3sL
 FJ6F8r81lcLSxg0Jt21rBoZww3Zz059Cur+bqOuAATU1jYlSrKftjxrc++Vt5+iHDlqv
 siUsdfFymRUlvYQdmjVQD46vzrXMa/zfIMoAQim553v/s45k8k3mSfIOrzV0ffomuwel
 kqp6bw6un5oANRqi8TMcbEqwltIKZbJFw2H5FJvXvXv9fO5TkMlVzgLxSfOm3m8wEMiq
 y/YzR8pEKQsJrRoCOQXFArgMmoXYDmr3J7k80Bge1FaB4dGcZUw2onLbGG458OGrejS9
 fQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747354003; x=1747958803;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a+gk6EV22H8YMdbVP/4hXSoq8A2EIKX/ulF/tv0ylKs=;
 b=XfhoEG4Rz67L9AVunwypPHuVBQmHb3iuEDZ8ph4aTAWG5/aE5AbrDdLXQWgNtJR3kE
 K0nV3p2hn8YC7LxvJp7KOOzmdFf9pJpDn4QI35BoDvGRtp3jsc7aZ9kegzFtw0wcErk4
 7IVCudtYXP3qDQHnuq72zbHm0ilSAUZ4KiZfMrug4amTxlXcYpokSuFkScupRm1Cv3BP
 Dc7Tr84IXK7myYo2sjkX1SDsq1USl4RhEaz1NSaprAyNZqvMGsLEyPUlXIP4wnbhi6qp
 Byd6gD6ceF/ZpA5Nugly3Jl9WUqXfmMYFyjAnqSg8j9LiMSOJUt4mfObKyfuvS8/SmzL
 n/Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV0/vEEAxwL5G16xV1S4XOxkTEKGPTBDFSPt+/Q0U7mR/QkTuBOjIBlQjxN/2IMqJKZn70Ali9Mw==@nongnu.org
X-Gm-Message-State: AOJu0YzuRx8qiI4Y5KUQYJQxG3cj9UBqbyOM1g/ghJKcoEYJNSVTuKpg
 Z/ny5LwjU7IrC0DpyKu60uxsv+4c0E2+TM9cb46M8iEk3LOz/NqsEZpE
X-Gm-Gg: ASbGncv/AF/joeKsKC5MT3MLJMAjA5VCq2Vw7IpgpDa3pKewHx5r4TzNn/MNxm/f46r
 jj9tQp7Mc0dc3Gy284spYH9jv4zZLZnMEEJIQChNh9hjLuxNatLMvuauWE8jy2n1UvCuw8k84Hu
 FH7glsQo0XOGK0rcPgQzpm/2yqRyPW6xIAI187n4SpNN3ffFvZWwU2lVSMBLafxu4nMbfV5fKbl
 JA/Y9nUfZ82lpLKCZCrOEgIU98cKOsxOcKfHVzntB+Xf1piM7umGiDDGox3dP03/IVnsMYQHShA
 y7ySyp+JslRv3SKQj4jyJkrvMCLzRlNPJB9gmEmfojzfuLs=
X-Google-Smtp-Source: AGHT+IE6pkdkF/dtQdLGaeF4oL72X/ik9HX8XsUdjRaNtmfQa9bfCFRHri0/Ej++fNVT4yHQQNff1g==
X-Received: by 2002:a05:6a00:2304:b0:739:50c0:b3fe with SMTP id
 d2e1a72fcca58-742a97ab076mr1623020b3a.8.1747354003195; 
 Thu, 15 May 2025 17:06:43 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9878b53sm366798b3a.152.2025.05.15.17.06.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 17:06:42 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 10:06:37 +1000
Message-Id: <D9X5AOSM8SJH.37ETITSTNVR79@gmail.com>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Michael
 Kowal" <kowal@linux.ibm.com>, "Caleb Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 03/50] ppc/xive2: Fix calculation of END queue sizes
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-4-npiggin@gmail.com>
In-Reply-To: <20250512031100.439842-4-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

On Mon May 12, 2025 at 1:10 PM AEST, Nicholas Piggin wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
>
> The queue size of an Event Notification Descriptor (END)
> is determined by the 'cl' and QsZ fields of the END.
> If the cl field is 1, then the queue size (in bytes) will
> be the size of a cache line 128B * 2^QsZ and QsZ is limited
> to 4.  Otherwise, it will be 4096B * 2^QsZ with QsZ limited
> to 12.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Fixes: f8a233dedf2 ("ppc/xive2: Introduce a XIVE2 core framework")
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>  hw/intc/xive2.c             | 25 +++++++++++++++++++------
>  include/hw/ppc/xive2_regs.h |  1 +
>  2 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 7d584dfafa..790152a2a6 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -188,12 +188,27 @@ void xive2_eas_pic_print_info(Xive2Eas *eas, uint32=
_t lisn, GString *buf)
>                             (uint32_t) xive_get_field64(EAS2_END_DATA, ea=
s->w));
>  }
> =20
> +#define XIVE2_QSIZE_CHUNK_CL    128
> +#define XIVE2_QSIZE_CHUNK_4k   4096
> +/* Calculate max number of queue entries for an END */
> +static uint32_t xive2_end_get_qentries(Xive2End *end)
> +{
> +    uint32_t w3 =3D end->w3;
> +    uint32_t qsize =3D xive_get_field32(END2_W3_QSIZE, w3);
> +    if (xive_get_field32(END2_W3_CL, w3)) {
> +        g_assert(qsize <=3D 4);
> +        return (XIVE2_QSIZE_CHUNK_CL << qsize) / sizeof(uint32_t);
> +    } else {
> +        g_assert(qsize <=3D 12);
> +        return (XIVE2_QSIZE_CHUNK_4k << qsize) / sizeof(uint32_t);
> +    }
> +}
> +
>  void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width, GStri=
ng *buf)
>  {
>      uint64_t qaddr_base =3D xive2_end_qaddr(end);
> -    uint32_t qsize =3D xive_get_field32(END2_W3_QSIZE, end->w3);
>      uint32_t qindex =3D xive_get_field32(END2_W1_PAGE_OFF, end->w1);
> -    uint32_t qentries =3D 1 << (qsize + 10);
> +    uint32_t qentries =3D xive2_end_get_qentries(end);
>      int i;
> =20
>      /*
> @@ -223,8 +238,7 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t=
 end_idx, GString *buf)
>      uint64_t qaddr_base =3D xive2_end_qaddr(end);
>      uint32_t qindex =3D xive_get_field32(END2_W1_PAGE_OFF, end->w1);
>      uint32_t qgen =3D xive_get_field32(END2_W1_GENERATION, end->w1);
> -    uint32_t qsize =3D xive_get_field32(END2_W3_QSIZE, end->w3);
> -    uint32_t qentries =3D 1 << (qsize + 10);
> +    uint32_t qentries =3D xive2_end_get_qentries(end);
> =20
>      uint32_t nvx_blk =3D xive_get_field32(END2_W6_VP_BLOCK, end->w6);
>      uint32_t nvx_idx =3D xive_get_field32(END2_W6_VP_OFFSET, end->w6);
> @@ -341,13 +355,12 @@ void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uin=
t32_t nvgc_idx, GString *buf)
>  static void xive2_end_enqueue(Xive2End *end, uint32_t data)
>  {
>      uint64_t qaddr_base =3D xive2_end_qaddr(end);
> -    uint32_t qsize =3D xive_get_field32(END2_W3_QSIZE, end->w3);
>      uint32_t qindex =3D xive_get_field32(END2_W1_PAGE_OFF, end->w1);
>      uint32_t qgen =3D xive_get_field32(END2_W1_GENERATION, end->w1);
> =20
>      uint64_t qaddr =3D qaddr_base + (qindex << 2);
>      uint32_t qdata =3D cpu_to_be32((qgen << 31) | (data & 0x7fffffff));
> -    uint32_t qentries =3D 1 << (qsize + 10);
> +    uint32_t qentries =3D xive2_end_get_qentries(end);
> =20
>      if (dma_memory_write(&address_space_memory, qaddr, &qdata, sizeof(qd=
ata),
>                           MEMTXATTRS_UNSPECIFIED)) {
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index b11395c563..3c28de8a30 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -87,6 +87,7 @@ typedef struct Xive2End {
>  #define END2_W2_EQ_ADDR_HI         PPC_BITMASK32(8, 31)
>          uint32_t       w3;
>  #define END2_W3_EQ_ADDR_LO         PPC_BITMASK32(0, 24)
> +#define END2_W3_CL                 PPC_BIT32(27)
>  #define END2_W3_QSIZE              PPC_BITMASK32(28, 31)
>          uint32_t       w4;
>  #define END2_W4_END_BLOCK          PPC_BITMASK32(4, 7)


