Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C41CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 14:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6UkI-0003i6-LG; Wed, 08 Oct 2025 10:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v6UkA-0003hr-2S
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 10:02:14 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v6Uk0-0002FS-Ji
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 10:02:13 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-62fca216e4aso2277596a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759932115; x=1760536915; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d10kDY2QyqMrSt0stL7AQX3Nak8ym6sbq2doRpi1vk4=;
 b=XuDZWmwLMG45hdXj5ZY8zHohOMWZZlNukE/LzVV+x2I9wuew9JVXXHkbBIGNo2XiMs
 3HPUbapsunWumOf0Z02WrOkVk4tmwzRahCLhIIp5VBBonFmwRga9F9bQvQeGKJlEG0vb
 3Kl7DdRuGrtWvL/SzNxDSHLUFXVlD1t6e9PUbKXLDySkDO/MRRMNN/3k1XrqbGBCWO6/
 uKFz365+AfLaOTAban8VdEw6QsR94OnF+CvbruUP56hw7DqlUjmxqDFiVcgk2/tpgF4C
 sspZWU0W9ThlhcIYHwyoZJh64VkV+sPYH2s9Vq9sYkZ7dOV6v1cdHNJ91cMxJQrnkCic
 CUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759932115; x=1760536915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d10kDY2QyqMrSt0stL7AQX3Nak8ym6sbq2doRpi1vk4=;
 b=Pf56KYeiVBzSUXxWfzrnhjYnwf+gtqtquNTqwbynvhRfwI9lY/Caqnwat/DT7QVSgr
 B701hrh0izBaFYCzFIeyz8OeUvBGR8IFMFRdLXaO4XNRq2uE3M47lkmpC7daFcOm5LrK
 0iSurglMFrJTrGUlWM9FO5CLvf+6cHtVtwgxzp4jcV/7Hm+ELWANRNm2OvsLbN0uiTqE
 f896mXukqMc8ECieQcFKlyisVwrBj6avDYJjEzmCdYgV8axwZtJ39ZN835Zz/99r1Ac/
 eAwpHXQ22f5Tago3cYi6+Aaz9H4fM4SXikwkN5BUANHLLZ7yYRbSS4fOJrM+LMFjz3Y1
 +3/w==
X-Gm-Message-State: AOJu0Yzl51fie1qQxJaplw7b3nCyBYENrIm918FufO0P8c6IemjfuogR
 jauMr9kk/dcEfCXsIMTdMPme5F/QQdOQz5ji2LbbH+auCFBrVK3Sq4v2kcZnpPgWuTKKi99wgMO
 3XaG2heOlFzeROqyZ8k16OnSiapPilQE27tPqb7kVag==
X-Gm-Gg: ASbGnctnMel5ucF/QotZ6RdslqhqGkj5q7DU5AJcI/Z4wS3Txk3zodnE/hQ6AdlX7Cb
 Tnvx2kL0mh4lnBpPTfucJs+dO7DvwnCPx9z4dhsEAG4i4NapIGLXzYQMQFFRcWU8P851f8CF6ZG
 iZJ0LKvg0RpIvqanPGRqp18S/3IN674KrwTS8RQlf/UHaOXx0he+o2gz6wKtgqPJHvxY/UX+TZC
 ReyzIuYYrVnzsuuha2Q3Kfh9tM9s+UhRKGGJPYzdv8=
X-Google-Smtp-Source: AGHT+IGGPQDm58OwiXOMaGn7ys4Kj1un9ZDX1h0/88Z82pj0QUvuV5oK4h7oJ/wu2tnOcZiHQR2YKMd+Q3CX6ztxgyw=
X-Received: by 2002:a05:6402:50c6:b0:634:c377:e1ae with SMTP id
 4fb4d7f45d1cf-639d615df4bmr3863732a12.14.1759932107509; Wed, 08 Oct 2025
 07:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251002145742.75624-1-philmd@linaro.org>
 <20251002145742.75624-4-philmd@linaro.org>
In-Reply-To: <20251002145742.75624-4-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 8 Oct 2025 17:01:21 +0300
X-Gm-Features: AS18NWAnN49isqZQsRSSRUNiEfxtfYZex54R-7BARcsPyfBpsRvIMQLQF_QMB8M
Message-ID: <CAAjaMXYg6zpoj7Mp3MP0rYSUX+_RZQeamkxcyxqGqnfjG77PEw@mail.gmail.com>
Subject: Re: [PATCH 3/6] target/riscv/kvm: Replace legacy
 cpu_physical_memory_read/write() calls
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 qemu-riscv@nongnu.org, 
 Max Filippov <jcmvbkbc@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Weiwei Li <liwei1518@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Oct 2, 2025 at 6:00=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Commit b7ecba0f6f6 ("docs/devel/loads-stores.rst: Document our
> various load and store APIs") mentioned cpu_physical_memory_*()
> methods are legacy, the replacement being address_space_*().
>
> Since the SBI DBCN is handled within a vCPU context, use its
> default address space. Replace using the address space API.
> As with the previous implementation, ignore whether the memory
> accesses succeeded or failed.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

