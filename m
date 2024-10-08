Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EDACED24D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyzD-0007FJ-Jd; Mon, 07 Oct 2024 21:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxyyy-0006YF-DG; Mon, 07 Oct 2024 21:25:48 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxyyv-00017T-9g; Mon, 07 Oct 2024 21:25:48 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-5094a6123e4so1697663e0c.0; 
 Mon, 07 Oct 2024 18:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728350743; x=1728955543; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VxhbmcpsXolAmE35ZT7XUcWcTaLMqcT+yECnGMzXJgU=;
 b=BwlmtVNgoWphBOrJRfdtQe2IW+UYrguPJzeD93JIwjxYxQnr7oR8zpT7daiK8B7l+v
 QHuiQXBk/oyN0aaHoVbF/Ovw2O7DdWaKGSKq0sJN9xsSLTVNQ3XPZCTIIZsowIB/7+hi
 vs2Q421+Mazq+KjTXVW0Qp99sGfAOCqDeo4kVGi3C/3NGkxSO/KoTcO8TqTxgVDizTkz
 AGu+gPoEzJyNWZ4az/InETL1QMwhjt7lteQsgdjISaqisg5OVkpYNKTO2BaLkEaahQdM
 i5IxD6ak4Uhj4wLanDAnYBb4JpOimXkmpqJE13y3TD4D2ZORSHYcP8jOTFCFi+JDwv9v
 xd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350743; x=1728955543;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VxhbmcpsXolAmE35ZT7XUcWcTaLMqcT+yECnGMzXJgU=;
 b=spOMp9E90KsMYb4sLPJLXjS48Qbpu//Q94RBtsfNny26Xom1FHsDlrThjukriam9D7
 3vhnqOLLlrjj/lZBmN8GPW0592CwwwB6Cu+qtSNknlR9SHNnfluZxN06Hw/HuhXA27Ed
 sTJt7q4i1pUM/ZGVO1lMqEA8MMijwk48V8JE7stbAe7PXoy8njVFm+0Mz0fuWRdgdyN/
 aYs1bOgg1i9cOQkfyS/eYqg7ZaYxT2R39fk+++xP73jK9xEPepR4IJOxeMtWjt94dmxd
 JWEQZG6SfXipaz0Cushm9gUM9mOVwBz37wsqbkB/ip+UZXcyHO4YLTLZrYV2yNA3lRbk
 3mJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGwfxrli9WOzbj4/AZ/WTwK7hbkYD4cmk1KoQ5mWNL7BThhczPzE6+LOXFXV7iuiOcxm6bTPpSCpgy@nongnu.org,
 AJvYcCWMvY/XZDt/yLbC5hBbxP5Ekxie4XSB3X9vN0yjgi5Xth4Wx0RY3fLTEjM74FyRTMnVmvXtDronPbRFnA==@nongnu.org
X-Gm-Message-State: AOJu0Yxx/K8b3WLAuqGKy8qGkThLme6KAWXw1l4vWQueDQoKOeud25kh
 21pYfqhuGm4v99bCD2l8lSMYE0zF5xhUdtbtolSLFk0vGe3oz95Lp6vWKMT57/eYfA89iyIJvQN
 mJbDRhgOJU3uPBZYIA/B9CAla0Y8pGpqf
X-Google-Smtp-Source: AGHT+IGb7iw/apOTjeuLwFF2OiCmVenBc9jL1UBOkuVSHFTWmixGVUQqe0gY0nA5ol8PyCzo05gWPcaukW3UCi+g6m0=
X-Received: by 2002:a05:6122:3b09:b0:507:9096:423a with SMTP id
 71dfb90a1353d-50c8559682fmr8144071e0c.12.1728350743409; Mon, 07 Oct 2024
 18:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240918140229.124329-1-s.makarov@syntacore.com>
 <20240918140229.124329-3-s.makarov@syntacore.com>
In-Reply-To: <20240918140229.124329-3-s.makarov@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 Oct 2024 11:25:17 +1000
Message-ID: <CAKmqyKOSqzC9d8PUbCgHcme9UMMT_wz6U8gXHfYjLDnR9b=dFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/intc: Don't clear pending bits on IRQ lowering
To: Sergey Makarov <s.makarov@syntacore.com>
Cc: Alistar.Francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Thu, Sep 19, 2024 at 12:03=E2=80=AFAM Sergey Makarov <s.makarov@syntacor=
e.com> wrote:
>
> According to PLIC specification (chapter 5), there
> is only one case, when interrupt is claimed. Fix
> PLIC controller to match this behavior.
>
> Signed-off-by: Sergey Makarov <s.makarov@syntacore.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/sifive_plic.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
> index 3f3ee96ebc..deec162630 100644
> --- a/hw/intc/sifive_plic.c
> +++ b/hw/intc/sifive_plic.c
> @@ -354,8 +354,10 @@ static void sifive_plic_irq_request(void *opaque, in=
t irq, int level)
>  {
>      SiFivePLICState *s =3D opaque;
>
> -    sifive_plic_set_pending(s, irq, level > 0);
> -    sifive_plic_update(s);
> +    if (level > 0) {
> +        sifive_plic_set_pending(s, irq, true);
> +        sifive_plic_update(s);
> +    }
>  }
>
>  static void sifive_plic_realize(DeviceState *dev, Error **errp)
> --
> 2.34.1
>
>

