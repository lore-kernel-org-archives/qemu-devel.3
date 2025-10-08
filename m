Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2527FCCA472
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 14:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Uj5-0002md-25; Wed, 08 Oct 2025 10:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v6Uj1-0002h1-8A
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 10:01:04 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v6Uiw-0002AY-TR
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 10:01:01 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b3d80891c6cso155131866b.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759932055; x=1760536855; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvWOlddfwghaVSH+2JYyD0HHGY3kc4q9PORKPryKrbg=;
 b=ZA/Pge/AfxqZXgEN38+mSX4Ui38N/dicATfI0+RQcG41XgZxsiWEOGnONIucQVAdcT
 rYTMLA2nMyedYiCZNpNN0xjASvAHdGRgQNpcf3nznPBrsrK3uRAKCczbdswlYs59w2m8
 Hwj1lXLMqgJhvI3k4BsOVkvXtErTTjmA6zKfVtLRdSN/fi94H4SXVQl4DMlYtGFzFRjC
 6BKTzOM40mkojJ3ojOH9Ho+/jCbRIsxjlzu0BS9N4HPbgPhL/YqBkqF6Knwo3xUqN2wH
 25azVbWJj4uI4FeWZxNbc27L7rtK9z+FuiYpvXhWZKvol0GFt28a3vJ4h+466ifYA8sJ
 gmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759932055; x=1760536855;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CvWOlddfwghaVSH+2JYyD0HHGY3kc4q9PORKPryKrbg=;
 b=TpiskP3XE9KeAEeN/n+0fQWNDrMUVp98Hv79ODqO5pzy5wXWSolQIOKkxf7rI15bbe
 UN4Xoqy6Y+IRO6H0Y7FZ3sXxeMlWTFVLPhhhbpl+FVwmngc2tQ1ppDWV/NwzosFLFwYX
 QpLb4dH1HmeY2O6Dnp3wH/7KlxgaevhOGv9zlgNm56ab7K7wcluwNbAE4Eppq+EjosQE
 FL98Wwq4ihUo7Lm24j4dcep+286MHKDtGf/Df0e5lePWDI1qKaZ1ghqKC1NQlb+cBaR3
 zIIep7pxMy7U29V/XDsYllbj0yaBgCq/riJCGsoikKUYB5IXELSrsCLQnG3V5OyezqF8
 SGyQ==
X-Gm-Message-State: AOJu0YwdCs/YISOEUleRWyj3IUqtXEp9Hajge/VBBmNix/RuJKG5RbW/
 73hZ51Ew6HlB5PUlr1IMaWdRch7tjZuG0TxP6qPzVW4JZDekeMd02sEUlvA0zy5JHHYUrAan5El
 phUY/RhDo9rUaF+VOJLVmW49XTu5XYz1lDQNV131+ng==
X-Gm-Gg: ASbGncv2bmpGXYBvWl7XhQQBth5YY5lkAk6bZCcqTQbvbdjarbhUnvJY/T1olaleIvj
 Uj0W2SivnAuO+M2RmR4ld0HpwnVMth2U6i5KEmUHGIuBFCN9yJ7E2wL90kTqVdDINAkxmWDq8jP
 VxZJ1nDEQDQ2+c8njswaYrD5XCQSBRN9m21iOtm+P2SGjXCzw2s6QYgT5F8tgBVdxZDIkwGZaO3
 p51GDDNTpXNwnLrWjF8RYimm8flt5Scfx2lRhdWVwA=
X-Google-Smtp-Source: AGHT+IHzbcvevwtiJmcSCyTnpSe6ZYqYf+ORpXPT2lt6T61tTXibD/ONxha3y1rZesbiXb2eB4p2ylYJ+00qrrJQErI=
X-Received: by 2002:a17:907:18c6:b0:b54:2c82:40f1 with SMTP id
 a640c23a62f3a-b542c8241bbmr94793066b.11.1759932054694; Wed, 08 Oct 2025
 07:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20251002145742.75624-1-philmd@linaro.org>
 <20251002145742.75624-5-philmd@linaro.org>
In-Reply-To: <20251002145742.75624-5-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 8 Oct 2025 17:00:27 +0300
X-Gm-Features: AS18NWC0r1CfGpCOlAndQZ9y5ukBp4J5WxxvLPUGkg2KvH2wUbjmqMI3mSNwSpk
Message-ID: <CAAjaMXbZfGF2V5e=YRnXDTwNTk4b3iaJkaHE=EVxRVB=OZ8eRQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] target/riscv/monitor: Replace legacy
 cpu_physical_memory_read() call
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
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62f.google.com
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

On Thu, Oct 2, 2025 at 6:00=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Commit b7ecba0f6f6 ("docs/devel/loads-stores.rst: Document our
> various load and store APIs") mentioned cpu_physical_memory_*()
> methods are legacy, the replacement being address_space_*().
>
> Propagate the address space to walk_pte(), then replace the
> cpu_physical_memory_read() by address_space_read(). Since the
> monitor command are run with a vCPU context, use its default
> address space. As with the previous implementation, ignore
> whether the memory read succeeded or failed.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

