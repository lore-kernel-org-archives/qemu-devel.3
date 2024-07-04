Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1840BC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 10:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPJfN-0001bd-EN; Thu, 04 Jul 2024 06:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPJfK-0001Z2-79
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 06:26:14 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPJfB-0001V7-Vo
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 06:26:13 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57cb9a370ddso631672a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 03:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720088764; x=1720693564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xC48v9f71+5BEv8BfLMiTZ3HX5Rc0SmAOdizqpMZ2xE=;
 b=EVFzN0Jko7U5UWy1FaDyb0c23GrA1eDrTDJP5CxY5yTUgKPSIcxlbN7kBHu4ePpsn7
 01I1TXGp4d/9l7H6Bb8lLxsfeSuV+Pg91R2PrWvUr5rK1H0Q2SuuFHsjyX22jCqPOinL
 VlYuByJTbNfrGz1CENxeRiqg6iPLOMpffR6XTOGALeT1+tFdaL0c43zoH1Jsr9qoHl5B
 Wtfhyoiu8XtGNyQSvhAp5v24jbTfLNuD6tgbEQBvrloGIn4lJ/3EXvf+6qZy+5kQQGWR
 QWQq294d7ZYBluahJYU1LyzyVN+FlB810EyPDJTn6VwwclUbklT9ogYlrJH+kkYz6mZo
 +fDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720088764; x=1720693564;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xC48v9f71+5BEv8BfLMiTZ3HX5Rc0SmAOdizqpMZ2xE=;
 b=e52a/Rq0ugtc5jH5X0CyvZSB8YKJLu4CRifATBcbZUXFwIWYsB6v/MK2fMz1PtJ6IY
 nn1qZcpXrwRkJSE9I4IZKvXYYwhRAl1VFIIYxCUlQcfpiKNw/sl/f/T8Vko+Z6w/79YM
 zLnhZawEN4tHEwalT0Fyx34Vqj6PnWX5cYbcROrl/4vLZkLJgK+RcsG950aXM032fXGf
 hCuhg2xj4bbyIEwqlZZTQ3CyTP2jmN+sQ4hotF7H0Y/HOYYv49rBvLWVuX1/vI4bEUZO
 zKmBpXZlmd1ZnYKPk55T9cZAyN+JM1IAIWqZbT1jqNqz+aSn1JJfjEyZ2xrnDNrmNv2w
 Jd3g==
X-Gm-Message-State: AOJu0Yyk80xQU3umNKiSS7U458RgZC1GOMP2fiDsS8eEyxoVYeJhdw9z
 hYdm7aI27CjxLpmco/z8Vx0x2/2qonB7YP1S/XtUzuUh/07QiOBdkeQOvJOmyR0=
X-Google-Smtp-Source: AGHT+IHz64s8lodGRvZkkyNhfG4JyZctTRVpw00+kq525U939ceTRawQk+CRkLio36MJ6fWXBYmhlg==
X-Received: by 2002:a17:906:618:b0:a72:b493:85f6 with SMTP id
 a640c23a62f3a-a77ba6fbd0amr79084666b.24.1720088763597; 
 Thu, 04 Jul 2024 03:26:03 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b7f9asm583320566b.219.2024.07.04.03.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 03:26:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 40F8F5F839;
 Thu,  4 Jul 2024 11:26:02 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org,  sstabellini@kernel.org,  anthony@xenproject.org,
 paul@xen.org,  edgar.iglesias@amd.com,  xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 1/2] physmem: Bail out qemu_ram_block_from_host() for
 invalid ram addrs
In-Reply-To: <20240701224421.1432654-2-edgar.iglesias@gmail.com> (Edgar E.
 Iglesias's message of "Tue, 2 Jul 2024 00:44:20 +0200")
References: <20240701224421.1432654-1-edgar.iglesias@gmail.com>
 <20240701224421.1432654-2-edgar.iglesias@gmail.com>
Date: Thu, 04 Jul 2024 11:26:02 +0100
Message-ID: <87ikxlo3lx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

"Edgar E. Iglesias" <edgar.iglesias@gmail.com> writes:

> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>
> Bail out in qemu_ram_block_from_host() when
> xen_ram_addr_from_mapcache() does not find an existing
> mapping.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>  system/physmem.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/system/physmem.c b/system/physmem.c
> index 33d09f7571..59d1576c2b 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2277,6 +2277,10 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool=
 round_offset,
>          ram_addr_t ram_addr;
>          RCU_READ_LOCK_GUARD();
>          ram_addr =3D xen_ram_addr_from_mapcache(ptr);
> +        if (ram_addr =3D=3D RAM_ADDR_INVALID) {
> +            return NULL;
> +        }
> +

Isn't this indicative of a failure? Should there at least be a trace
point for failed mappings?

>          block =3D qemu_get_ram_block(ram_addr);
>          if (block) {
>              *offset =3D ram_addr - block->offset;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

