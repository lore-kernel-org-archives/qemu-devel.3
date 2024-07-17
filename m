Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD462C3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUC0n-0005wW-0k; Wed, 17 Jul 2024 17:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUC0i-0005vw-UV
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:16:29 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUC0h-0007Lq-An
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:16:28 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a77d9217e6fso7811266b.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721250985; x=1721855785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0D9CnvYgWR9Ly3mFaCmEKxH5HDJioJNYwziwQgKiMVQ=;
 b=BrUddAlVnQsN3/7yB2WNsJheJCSqWtetkky8T7lzC9t6r9kehZalTWmeOXsaFBmA7e
 HIJ1WNE7ZliIpJ4UG9Gn+Ks+br7eEetkbn8wS3CYQIDEXaQIL5qi8lAswM468tJRVIxB
 +e53a/PrPlR1q7UsBYBoDHCdIZ5qQbOwTPgi23ljsfW3U9SWHMf+PRutYg7CLkWKYSpW
 4v+wo4LCNW9IseB8kZsEiGD9b4Nd0vm+cSgmPwtq5BJ2GEiyKlar/FiwrHqIffFnfWiH
 DFRSBCuYZsV79r5kKzNCeut+9HjopQcjoHyazkUq5v1TI9UBI+UT9xPXFcJbf17ja5nc
 ynjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721250985; x=1721855785;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0D9CnvYgWR9Ly3mFaCmEKxH5HDJioJNYwziwQgKiMVQ=;
 b=mtyLUbol6NF9xOa5wm4sZ1/2IDaTwdA8v49+7Eo39lI5eOzJrIkcTxcPb9U/ublldE
 AXcCnXdVe8NXREklioVWUFr3Moh59GAddTyTCK2NFzCev/lEvgq8+Ilur7YPM+71o9/o
 FWWPl4gSokBcdeBEi8vnM6X3772D3FGpY+L9uBB1QnlDKCyjNE8QblaNBnVhrBWYmr8E
 8ZOPyMkbxxCi0frPC8PfPmVAxYR4h5kNSh7jfkQ6bL961KXeGt0uDPcfw3m0Nc81izLx
 Dj8FCSDWr0qpUhnG+iEZDwqeivIFUWNsUgMLARVGb6zuZmFGSiSYCfxXM+GE5wgW9ttS
 LKcg==
X-Gm-Message-State: AOJu0YySmsDSPe17vvG1Ew6US6LFVqsLvYVSVvQaC/+5YGDJKdKmfUJM
 LpASq8oBu4pjSB48gm2JgMfsodF338fV2znTPa4FcLh1ZziG59Ty9kbrGWloKX4=
X-Google-Smtp-Source: AGHT+IGogUHAq64exEX5jOYcZKR201KFLkXVhTkakOeosWHN4GYLG8EwE71Cp+lEy4HezgMS2+GsiA==
X-Received: by 2002:a17:906:88d:b0:a72:8d2f:859c with SMTP id
 a640c23a62f3a-a7a011adc32mr194944666b.33.1721250984697; 
 Wed, 17 Jul 2024 14:16:24 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5a3a30sm485852566b.2.2024.07.17.14.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 14:16:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 680C15F738;
 Wed, 17 Jul 2024 22:16:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>
Subject: Re: [RFC PATCH] hw/core/cpu.h: try and document CPU_FOREACH[_SAFE]
In-Reply-To: <20240620163204.2213916-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Thu, 20 Jun 2024 17:32:04 +0100")
References: <20240620163204.2213916-1-alex.bennee@linaro.org>
Date: Wed, 17 Jul 2024 22:16:23 +0100
Message-ID: <87sew7g1nc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> There is some confusion about when you should use one over the other.
> Lets try and address that by adding some kdoc comments.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

ping?

> ---
>  include/hw/core/cpu.h | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index a2c8536943..7122f742c1 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -587,8 +587,25 @@ extern CPUTailQ cpus_queue;
>=20=20
>  #define first_cpu        QTAILQ_FIRST_RCU(&cpus_queue)
>  #define CPU_NEXT(cpu)    QTAILQ_NEXT_RCU(cpu, node)
> +
> +/**
> + * CPU_FOREACH - Helper to iterate over all CPUs
> + *
> + * This macro iterates over all CPUs in the system. It must be used
> + * under an RCU read protection, e.g. WITH_RCU_READ_LOCK_GUARD(). If
> + * you don't want the CPU list to change while iterating use
> + * CPU_FOREACH_SAFE under the cpu_list_lock().
> + */
>  #define CPU_FOREACH(cpu) QTAILQ_FOREACH_RCU(cpu, &cpus_queue, node)
> -#define CPU_FOREACH_SAFE(cpu, next_cpu) \
> +
> +/**
> + * CPU_FOREACH_SAFE - Helper to iterate over all CPUs, safe against CPU =
changes
> + *
> + * This macro iterates over all CPUs in the system, and is safe
> + * against CPU list changes. The target data structure must be
> + * protected by cpu_list_lock(), and does not need RCU.
> + */
> +#define CPU_FOREACH_SAFE(cpu, next_cpu)                         \
>      QTAILQ_FOREACH_SAFE_RCU(cpu, &cpus_queue, node, next_cpu)
>=20=20
>  extern __thread CPUState *current_cpu;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

