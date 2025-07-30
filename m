Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E599C83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 14:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh8GX-00069q-23; Wed, 30 Jul 2025 10:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uh6vQ-0005f8-Oz
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 09:33:00 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uh6vN-0000cx-O3
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 09:32:55 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-615378b42ecso6418779a12.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 06:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753882371; x=1754487171; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ciVlkbuR4UFeWui6Qjrl8wlTqowBMKzbFvDwaULAMKY=;
 b=g1LxwGZi9gk7JAQoezlEAC+xkAP6lyNIXhwO4YX43DmCilr4IaZv/wuL8rLlGD5PEb
 jtMMdhweXHkoCAaVHONPMC30SGJ2ZmJR0/VTJsdqNeKkxEkUZRzLdWOUxNlYw7+IvA08
 IPOq0LumuZgGPtGsx+HutxWwSUiq5r0qrifdbBEe7qMgCThq5oT3rcOV6WlzqDd+Xalz
 Uqs8KIDD1yrrszebFWkeITUQWA4s9lJ/Dl3fgg2bTywAjO8myo8/Rb9Gnv5qI7Yv8apv
 AJ1BreOIeJttHMXkYRQzKdyGuVbaebNWyM8k8p0NrPsggK49rQI3b4aCx1jWduJZLQEG
 NnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753882371; x=1754487171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ciVlkbuR4UFeWui6Qjrl8wlTqowBMKzbFvDwaULAMKY=;
 b=kn18dntqi0pE2K1UCtjCxb9XbaFh0XcrEHW4zoyT+F8n32wiUfDeLg5Bfif8yRBXEt
 Z6JIT2hZj1fiAeCcWqfzP/LhpTRtwIR7wzQ+NLziYUbYNqjyWTKhX3QsLpyjZs5jlswF
 DUqvYdn2usjo/qB1XO+bP4fd/tAjqrO6LD36IWrOCmtvs2GSTAeJpF2hGi6f30qnPvwI
 c5QgyoxGSkjLJIUykiUTYRHWI/pnru9yUHWfw0Olcxy6+VcIGLM4wsxq4eNNXg9Ezv1x
 PzZWKiRHTZF+8er39QCGcsVTmRdgZprZuxluANLcwfWAVWfBWjHvPlPXKOdntr6jmj4t
 DZvw==
X-Gm-Message-State: AOJu0YwHARIavKLlubL+Kci91ROYEVvdfv6eQAYs3yw/nDBc2GvpaOrL
 95I+k01n/KrbxC5P+OU0rlqL9700yjRAEMRWlQThprzsa5dXaVK4dP/2fE3LZp0DMBgEd+Q76AF
 wyb4XPAC335dTtP9aXXgmrrFeAJRPD2w+kNVS9zEr8g==
X-Gm-Gg: ASbGncvQ5aNisblg2IFVvmD6AFqO4+8nXvtn3fvm6EVaipBbxNWrVTjxcHlWMfYGGZo
 WPp6ifXH1RR66Q0d6bmwnVld7iYnIis1lSdPbfKRJqcUm6obb/3R3v7i48PhImK0+/mkWtxP319
 9udbTvHc5eM+6Xu6LRXtEYYN4RVcEv3VmJOivnTktn1l40NyWnKbAMhnX3qd05J3j4GUuWcpkT4
 HwoxbI=
X-Google-Smtp-Source: AGHT+IEdqbMg2hxEgFeCHQDOhHk9RmC69XrlwVHlbweuQCahi08uwa+RuPXXiUfbsc8gF6pwNEh9mw8wMEgoocwrMb8=
X-Received: by 2002:a05:6402:2344:b0:615:142a:c066 with SMTP id
 4fb4d7f45d1cf-61587209266mr3452116a12.23.1753882370903; Wed, 30 Jul 2025
 06:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1753857212.git.asb@igalia.com>
 <5d26c9d99ee87ac4a4034ff64e3d8881253eedf3.1753857212.git.asb@igalia.com>
In-Reply-To: <5d26c9d99ee87ac4a4034ff64e3d8881253eedf3.1753857212.git.asb@igalia.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 30 Jul 2025 16:32:24 +0300
X-Gm-Features: Ac12FXwDTvFwJ83k-QdXEMmvdhbcOwn8V1Mr8s6iE44WrjtyhxKGget0EOWCVo4
Message-ID: <CAAjaMXYb42FxRk6Ly7c8MqSFor9X2phBEN=ZMdkT9qwF6hqS5Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] contrib/plugins/hotblocks: Print uint64_t with PRIu64
 rather than PRId64
To: Alex Bradbury <asb@igalia.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, erdnaxe@crans.org, 
 ma.mandourr@gmail.com, pierrick.bouvier@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x533.google.com
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

On Wed, Jul 30, 2025 at 4:30=E2=80=AFPM Alex Bradbury <asb@igalia.com> wrot=
e:
>
> qemu_plugin_u64_sum returns a uint64_t, so PRIu64 is the correct format
> specifier.
>
> Signed-off-by: Alex Bradbury <asb@igalia.com>
> ---
>  contrib/plugins/hotblocks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
> index cf4d6b8c36..40d8dae1cd 100644
> --- a/contrib/plugins/hotblocks.c
> +++ b/contrib/plugins/hotblocks.c
> @@ -87,7 +87,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>          for (i =3D 0, it =3D sorted_counts; i < limit && it; i++, it =3D=
 it->next) {
>              ExecCount *rec =3D (ExecCount *) it->data;
>              g_string_append_printf(
> -                report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
> +                report, "0x%016"PRIx64", %d, %ld, %"PRIu64"\n",
>                  rec->start_addr, rec->trans_count,
>                  rec->insns,
>                  qemu_plugin_u64_sum(
> --
> 2.50.1
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

