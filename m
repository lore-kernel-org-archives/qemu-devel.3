Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E6BC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 10:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPfo8-0003M2-2I; Fri, 05 Jul 2024 06:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPfo6-0003LK-SK
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:04:46 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPfo4-0004rb-BW
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:04:46 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a77c9c5d68bso63339166b.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 03:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720173883; x=1720778683; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3Y1l59R0892E8CuX65FN56sFY81In0xM2oJbySffBA=;
 b=R0kvnXpndY6afzVjzLNZqs9jB8ZUCKYeo0q9aJSjknwjD0D4I2Kz3w7ePSiJV5Ugkn
 VjbAQ+aA9DmDM+hnjR5IQmHYkzqX+/z3GRfsY7v5KTwlTKVSUsuHD/uCTyMlKktZdukM
 cMbghHD8xo8Km4HECUc4cHE2570BV7nVKvBQmI9OYIMydyFO59NW43tCXwh+UoBoRwor
 ON4282R83r0SmYBsuZ8q+ZLl/LjhBW/l2azlgdB+g03Wn/fyDwwp156PH3KQWK/p1HR6
 C5aXQ9Ql4Gmq/avOJeTaTgcFra/xaiL3suW8+AttcNB9DEA/jg+MeL9eQOAAlr4FHgSI
 I5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720173883; x=1720778683;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3Y1l59R0892E8CuX65FN56sFY81In0xM2oJbySffBA=;
 b=dJazLC7MxVn87Wphdzglg244eWEwEKK1VLq52olsi4lqz101pU54J6cT9xXogUC8Sy
 Vp/m/NZJBQMPaq16KmUwigOdjXAytI+GXI61twIefW/eOhpVKAnBPGhMdbomWO4k/f63
 U0KBRMqwRF1aAkhHFeM2KooVvXceM8EArpRMrbK9PcnR7z76xBQa1ylecO/ISPWbFgGy
 vrEYNmCFaUj6RrYeMCu9AFRda2rgXBSVWtOpeMKEB1llW52tsAsQJznbnCHTiHsBg4Ry
 vabJAF55JvbxMqHOqXQTZq6iWHcrhRjpQNDXppyhMXmHrC/F8i2YGsVdhmSwAAQeZrFe
 9yxA==
X-Gm-Message-State: AOJu0Yx4Eul7f1Wx1tlFFaJoifFj8IPHbadkgsIWc+nb8DDh/vITiJZf
 VdCSmI5/QjnYWNkftWYLxEdBUWufEK87LRV9bUIf29SQC666zVJiHT8BFu9un+QXUyYtTtkXsTq
 oO164hya9XBjbDLYuev5e2Y+UV9clUXXaruxxeQ==
X-Google-Smtp-Source: AGHT+IHQ+gVmBeuwnYzWbbeYUWr5kYu9VhHHxD7OPTfiUWSFi7lkrVDjaUbDYjPrS7b2/+5eikgq0toiLhXDS88cVEc=
X-Received: by 2002:a17:907:7843:b0:a77:c976:2987 with SMTP id
 a640c23a62f3a-a77c97634c7mr118229466b.29.1720173882575; Fri, 05 Jul 2024
 03:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240705084047.857176-1-alex.bennee@linaro.org>
 <20240705084047.857176-26-alex.bennee@linaro.org>
In-Reply-To: <20240705084047.857176-26-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 5 Jul 2024 13:04:26 +0300
Message-ID: <CAAjaMXboPhzYrpkJmrPe=meiMM2Y02wfNoC_SJ5vfH0H2MkGEg@mail.gmail.com>
Subject: Re: [PATCH v2 25/40] plugins/lockstep: mention the one-insn-per-tb
 option
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, 
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 5 Jul 2024 at 11:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> This really helps with lockstep although its super slow on big jobs.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  contrib/plugins/lockstep.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
> index 761bcdf363..353bf12dfb 100644
> --- a/contrib/plugins/lockstep.c
> +++ b/contrib/plugins/lockstep.c
> @@ -14,7 +14,8 @@
>   * particular run may execute the exact same sequence of blocks. An
>   * asynchronous event (for example X11 graphics update) may cause a
>   * block to end early and a new partial block to start. This means
> - * serial only test cases are a better bet. -d nochain may also help.
> + * serial only test cases are a better bet. -d nochain may also help
> + * as well as -accel tcg,one-insn-per-tb=3Don
>   *
>   * This code is not thread safe!
>   *
> --
> 2.39.2
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

