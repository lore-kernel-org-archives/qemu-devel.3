Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A75CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 14:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6UhR-0002I1-NZ; Wed, 08 Oct 2025 09:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v6UhN-0002Hh-C9
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:59:21 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v6UhG-0001mj-Q9
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:59:21 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-631df7b2dffso2289436a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 06:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759931948; x=1760536748; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKZ2hImwlN1b+rqDZz6p6av73pHb6Oqe7unc9VE/QZc=;
 b=fxZLuzjcAr1WsLrd6BTsuCR3lQSVcz3iZkqpHhZeFuxgDgRwKuQRey+xeDKkjirjUL
 AQwT1TVxPgk5VoAh1wiZ4rxC0Rd9986CnQIY0duHIc7A/5bdX3eLlXiFBqGQn36zJ7N9
 WWwwO4XsXOWpUEgzeRCdyLKzavSJ8Zaejdj0XDv+GKB11lfh5tTp5lUhL1EW0XHXkl/T
 C8Xdg2qlodlKagbiN2oHKCrl+XuckKGKZ4UcKf5iTHfpTEgRTlZtuwbVePKOhPsPOnOf
 5glmTqgBpLX8H523CvaZAYE+BM5eXtupYTuv/pe/6tPsMU4MJe7zJL0x9kZx/WH4woos
 hR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759931948; x=1760536748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mKZ2hImwlN1b+rqDZz6p6av73pHb6Oqe7unc9VE/QZc=;
 b=Ois0g8KvjDqP6QPrC8KW8fCTOrEuY1ZLCGMGiq0EAeaePaMvW2cJ+R2A/BvIiR7U4u
 eprUcVJaauJoxJG9dNomaj6zKl9HcIwbgnHYEE+AJvRhYmLDSFIDYLzkSq40DrpKwmvD
 d1lTveT1oQRpEev3UYqLj7GB+sJnITHf7wF04nkGkB1MX2gGwHY+yFqlplzndoxKOSMp
 zjEGigBkFb7U2SInvWUdmfIkLE32TVN8463iYDKNvMzt1mALYkRhu9nVPvxtv3wC/fYM
 vlV8swtcR/bD1O/ikdq2MQodvxScztJ2XQjgMncy4SHLGqNZuAYK94X0fpxNSHIkf2rH
 rZ6Q==
X-Gm-Message-State: AOJu0YxLAc9oYal7EF2J1fT9RQyq7QqGUW6GsHu4T+86vOpQop2Ex9Yn
 sqRo/uwmcqS1Z/RBrDnX+Mtw+t47q4Dj7GLAieaqY0Ibw3csm0hIsvrYWkJr2EliWpu5o/tNGoa
 vZrJ+Wi8raaAz66WdHyFE4cwPLzfQHz2Ie8T0Rfkd3A==
X-Gm-Gg: ASbGncu/lXvuQXAbn8onStfBp7a6XQTC26hiGmfcO021gPHLVPP0sMEkU81740roXSV
 ymByk+3PBtr9Ut69n5A6woFfpPQl6OlTlqfWGM2chp32GLhkNu9DbsMcS1ACb/sXdAFfDK7fFWM
 P8Cf8YCQVEMoBIOJBv4OxLDfM26u1jmaaWqe0Co5feh3Gb8aZN5d7zU/1oWl+UdWB1z79gbK8m7
 8U9mkitEOKY0PvZlu/W5H/s6oM9/LH3
X-Google-Smtp-Source: AGHT+IF4Ag1+92MGiUt9CKwt2oOGl2No9PF3vzFEfX9vnrqJSIyk+IOeXq0IJz2p0unitfFCUOW/Et2DDz7ObCbHuHA=
X-Received: by 2002:a05:6402:354c:b0:61c:db49:aec0 with SMTP id
 4fb4d7f45d1cf-639d5fd60a4mr3556203a12.5.1759931948084; Wed, 08 Oct 2025
 06:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20251002145742.75624-1-philmd@linaro.org>
 <20251002145742.75624-7-philmd@linaro.org>
In-Reply-To: <20251002145742.75624-7-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 8 Oct 2025 16:58:41 +0300
X-Gm-Features: AS18NWBlZBlQ_ooaz6BrC9frnCFGO2qn7kgdxIpU9ZAMjnkM6wf8LcP_f9u6EWw
Message-ID: <CAAjaMXZo4NER2tjOZdZSbH0YfuBuuE8DGsFWm5jUXeP0D25fWw@mail.gmail.com>
Subject: Re: [PATCH 6/6] target/sparc: Reduce inclusions of 'exec/cpu-common.h'
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
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52d.google.com
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
> Only 2 files require declarations from "exec/cpu-common.h".
> Include it there once, instead than polluting all files
> including "cpu.h".
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

