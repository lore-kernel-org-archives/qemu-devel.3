Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E31EE0AF1
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 21:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voq8z-0004GF-H1; Sat, 07 Feb 2026 16:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1voq8y-0004Fl-0F
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 16:47:08 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1voq8w-0004RE-Fx
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 16:47:07 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-8c6ac42b91eso390024885a.3
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 13:47:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770500825; cv=none;
 d=google.com; s=arc-20240605;
 b=Id8iwNR6YN4XSxx68wvZPy3v9uFT2mnD2BhSVwc0e7qrybHm1jdPSmGHcSi70FF2wf
 CshYaZQ++E35qCqbN67fXvy1iimqEEAkTpJT4t/yOGIOqdCFHBFUPoulm6mPF8gmwZc2
 7PAiru/rzi+pQOR2OauyP9/RF3kBhKKMqcHuEJRXy2Y/nv7w3CvArVdAZbpzfqJDBM3u
 vYYWdS4ovlAyaP3fglY8rCkbi7XcOQWNyK2iIhS8PplZsRBfQDQs64mn5C8d2+ZLEAiZ
 ex3UZDasn3YB+aryoTrRLK6CO7+p3EtiSNtq47a/HA4ihqkCw2kIIM0T5LaQGOOfi25c
 vZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RUsFhCXMgFpRVv3Et0M87bPXJH2fTGb+t5byJlfjU8Q=;
 fh=HTnfI7TkK90NwUX8trJ+uJcY/rWcyVT6rjxtD9deuaU=;
 b=TvjAEh6BmTVEV3BD5VcO/oJR8AAVHz0laxnUmd/l4eymzH4fpz0aZqZiYjMBqB8EP+
 hT24RIErty22L0k8/Z3Yfg4Guoea4f+b4RJ0wXwhjkFlzQyZI1y1SVIVZEm3gAGjHRyj
 9aYzx4yfoGjfyB6aDQuOBP6L4DGcVqz9o/eMRbh8VeZv1CNuY/Ui7UrrlpzvzjPW3PlA
 ll37S7+hkeGS62UISCymN7ts9FO6yPyFkNBLMWAFRgyRi4sTxgOxDI+dKw3NwUgDRPCX
 VPBWIkaU4vIvEh5EUMgzNOL2IbabHi09ntsPLdAcA5jkodq1vezWzH8lX36CinTigqPs
 gIrg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770500825; x=1771105625; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUsFhCXMgFpRVv3Et0M87bPXJH2fTGb+t5byJlfjU8Q=;
 b=fQ7yVMY6nvIDZB6hfxIbZUNa1uvMJdvr9/BVC2OwD8erGRNw2ipueQcA1x9MUyUdFc
 KMqDB3HD3xq7naYotZi47v9oEThN+exDYghJom1kEmJYlIPPUZySTaLcC2qVdsx9tah1
 Um3p4rzDXVUV1HkV7ZG4Ty7Qp0OKZMKPDHEyouXgiab+t0axCWphyPRqKvs7D8UCd5zV
 SBC0u9sBa7DbZZ2EjADwACoftKAclLJxfdgl0xOLCo14V6NItXAcPaHt/dyaO8mY22mW
 hQFKj5y1VjO1D89Qgvm2Pn6Dt5aasc7Xa6o8I2dlLQSgLzqcZqSelko+ZNJem3vwOizf
 82vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770500825; x=1771105625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RUsFhCXMgFpRVv3Et0M87bPXJH2fTGb+t5byJlfjU8Q=;
 b=vfjubAruCGOCDopH8S8k7+MPjUWPRKegEDtA3B4ez561gtMFlKM9+KDq4TuDrQ9oCu
 P5IPGh+xcSjOtTAOXN59Mqabgp1MO3J35MjyaWeC1BIKyhHi+lVD36hnwnh62Q+OBayy
 lRZW+NDsm0fov86ZNXcIanQxoNGUUPEUrvhXPjUNsHCQQZIBKZOOeFebJdaBaUshUmUn
 4Qizs9nt6SOZjHPhdIEx/8wesPTQ/Ojb5HpkPno6M9435iw9pjP5XBQoIxUCDf+eZePE
 7b5w3WBPH8G/pk1FnLyaZQfCXiQ8+T+V6byASKXYSsYZzeByxb2zLyNb+G6/yJNU+cYH
 Mb0g==
X-Gm-Message-State: AOJu0Yw+joG9ek4fpehjqj7WVruIeqF6IiJupzK1dP5DojwFbqtTHIUP
 o2mzc3wOhB8UKDJQUt2ctIoi5VCRmER6Th2MCsDo03Jx6nsvvjgU7xl9KmA9LCgzy/4TAID9s3T
 UrqT1Pk6Lk5IMBUwJYhhYSrQ1roIlK/E=
X-Gm-Gg: AZuq6aIwtxdzhGZAA216A5LvHm3mW5/+H+yawimvCJ1HMby8PZcxuf4ncNl+5sBapIs
 GliBKxSlsH1E0ywroEfLw5gPC2QBaMdgt+8tgGUbOuEpPZ7F8X3ktVXAdlmTGnI7tkBOX6KIZhF
 dxfyVi3fuHfthUGF0P45/TH+/E/lpa2HResgbn9QTAo9rfa2Vy6VNtmJnsl7CsW8JgznTRk1qVL
 VJYVNmIHafMwhsLivx8Vr0jQ3JEoEo/XkbZLIg/gUTPSdS3D0NcRlHFQWHHM97yLkw00HPiUKu4
 eakM3YMGtvI5SjFv5+wnX7N10ljkwrK5DCTCp4ieHfzmy5m+yur5qeU=
X-Received: by 2002:a05:622a:1113:b0:4ff:a946:7958 with SMTP id
 d75a77b69052e-506398d055emr94114041cf.32.1770500824803; Sat, 07 Feb 2026
 13:47:04 -0800 (PST)
MIME-Version: 1.0
References: <CALjG0Qw_MJ2sgTSiCB2UJ6jS+zMcsJYVTCzh4s=CSvrrH9ySVg@mail.gmail.com>
In-Reply-To: <CALjG0Qw_MJ2sgTSiCB2UJ6jS+zMcsJYVTCzh4s=CSvrrH9ySVg@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 7 Feb 2026 13:46:53 -0800
X-Gm-Features: AZwV_QhSk-tpM-E-REOrxA5sE0d-VkCJAn-uWm8T8AuyYfv2v2EdEfOavZVagOQ
Message-ID: <CAMo8BfJ9kJ8B+32EC9iH9borKmcHLC3Ceq49LLbM3vbrE0-vDQ@mail.gmail.com>
Subject: Re: [PATCH] hw/xtensa: convert calloc to g_new0 in mx_pic.c
To: Manish <manishyoudumb@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-qk1-x72f.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Feb 7, 2026 at 10:16=E2=80=AFAM Manish <manishyoudumb@gmail.com> wr=
ote:
>
> From cef7f1f3d7b47338b7359ad4b815e04bc965d427 Mon Sep 17 00:00:00 2001
> From: "Manish." <manishyoudumb@gmail.com>
> Date: Sat, 7 Feb 2026 23:26:09 +0530
> Subject: [PATCH] hw/xtensa: convert calloc to g_new0 in mx_pic.c
>
> Convert the calloc allocation in xtensa_mx_pic_init() to use
> g_new0() for consistency.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1798
>
> Signed-off-by: Manish. <manishyoudumb@gmail.com>
> ---
> hw/xtensa/mx_pic.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)

The patch is damaged and would not apply, but the change looks good to me.
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

> diff --git a/hw/xtensa/mx_pic.c b/hw/xtensa/mx_pic.c
> index 07c3731aef..ab308c9490 100644
> --- a/hw/xtensa/mx_pic.c
> +++ b/hw/xtensa/mx_pic.c
> @@ -316,8 +316,7 @@ static void xtensa_mx_pic_set_irq(void *opaque,
> int irq, int active)
> XtensaMxPic *xtensa_mx_pic_init(unsigned n_irq)
> {
> - XtensaMxPic *mx =3D calloc(1, sizeof(XtensaMxPic));
> -
> + XtensaMxPic *mx =3D g_new0(XtensaMxPic, 1);
> mx->n_irq =3D n_irq + 1;
> mx->irq_inputs =3D qemu_allocate_irqs(xtensa_mx_pic_set_irq, mx,
> mx->n_irq);
> --
> 2.52.0

--=20
Thanks.
-- Max

