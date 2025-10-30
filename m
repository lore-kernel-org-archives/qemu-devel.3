Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC286CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 07:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEMdd-00056j-8f; Thu, 30 Oct 2025 03:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vEMdW-00056W-WF
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 02:59:57 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vEMdM-0000sG-Dr
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 02:59:53 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-63b9da57cecso1062703a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 23:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761807578; x=1762412378; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJ/HO6pHQVocYwCqGJnhbN0FHbwRi34rNhDy730oj+I=;
 b=D8vsWG9q9Md4emtDzfwd2XylL48QzWkii731JBlo8M2jjDCYT8rxB6ReURTOOB4iTh
 aTnJ40sohxrVkNYpF2eUHy2P2Fr9c8TvNcfbjy9Pm8pu2yABNvAxxOPIUItDSXcCJ6Fo
 QMtP6CikS0iM3T0vuGo12U9X7pBcC5Fxe5R6fdtFGe/5Rkxu2XXVTTwqXNxlm6uLQENA
 IFWcTw+Ho99vUseuFb+RPP9Nka7ICTXgNqfIM5kl1GUoeGPmXBsuJX3b7GTsZY+PLk9E
 t7yssP0JwaQ9Ox5RUdt4I2nSVWAbVm/vkwVe2S0jws2aaL2+NJSSq7jLK0kOenp2n2Nz
 IANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761807578; x=1762412378;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJ/HO6pHQVocYwCqGJnhbN0FHbwRi34rNhDy730oj+I=;
 b=KTCq0cqABRk+qLiAJGGWOnKs9j8ULXRrDFuvX21no80F+SFgj8NNuFNqHycF0TUNRT
 7fYtr5CY35qlfBxuO0jX7kXsEebVL+NdoFkjXL6n+xZ8O2sWpa8FK/UfGPV+RqTaT1IA
 jbvfOntxgnSQJbQYC3+bRQxj7I/mNwqucYgOiGLFDUJMH3XYJgo9tGCwAUUnCh/qLrIe
 h/ZVNvjLIAB1NSc8/fBp6oO9TyXhaS1eEP5cc3KCkCctNCCX9gu/ZrBsnWDIb6CyuSWR
 V3WcryUWiDoIryQbHeF9ru4aYkYPDilX5snh3bD5Pvu7XP0s2wfioW5KnNTzZyWef15T
 ViOA==
X-Gm-Message-State: AOJu0Yz5YhwO4+Wc+0rq8/TUf+5mzJ1XfgEGobEAuM6mcTO55ZHWboDm
 U/kIt9dMOp5jXvXN8cb6RyWeQQXBpy/k3WbuO6jm0tbOkJL4cifY5cKc64ledZPfX5J/8139ziP
 a+K0W6P5wKAgfsBNoPDOjmakoXJoTjA7D+JTBsKmpCg==
X-Gm-Gg: ASbGncsH96oTkLgaQxHoDDnKQlX/isFTqLnmOUfro9ZzBiTlULemQuQnFDMoGVyHvVe
 3ZlolCH6AXyJKsq/Ok6+YXHFjaq3Di3eOQCFUD1D567dE0vCXO8tTVSM90cS8CYpQj01gYpTlxV
 l/MATRGr7fC5og3Y+DxoIXmewR2GAiHXpWvBkQxYwF25BzkCmd0jLG6tAq/IBq7m4VKDoJGJCIg
 cS/lwWY4cE63fM/19l6sSd0UA+cQ5C9BXu2kwCzxlgd+cF/DWMxNbFNseW88yhrc3jYlHQ=
X-Google-Smtp-Source: AGHT+IH0xKtTOvXSj0w0p9pGjs44bfmfXmJe9ZjkC3NgIW10Mc0UYv7dQoY/VDKyF22Hv8KKVyDpPTiWdRNVg40T52w=
X-Received: by 2002:a05:6402:3506:b0:640:464a:56ce with SMTP id
 4fb4d7f45d1cf-64061a206bdmr1615343a12.2.1761807577663; Wed, 29 Oct 2025
 23:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250120061310.81368-1-philmd@linaro.org>
 <395c7c86-08b1-4af4-a5ca-012a9aa89339@linaro.org>
In-Reply-To: <395c7c86-08b1-4af4-a5ca-012a9aa89339@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 30 Oct 2025 08:59:11 +0200
X-Gm-Features: AWmQ_bl6hqBdTUMqfB1A4rR44hN5EJ76yR6SMau1gPDpmEtyNMVrsra4cLNQE5A
Message-ID: <CAAjaMXZSkxCgzdC6w-onUxVxU_ZW5fiBtW5-ioeKaXwD_7tJeQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] cpus: Constify some CPUState arguments
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 kvm@vger.kernel.org, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
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

On Wed, Oct 29, 2025 at 7:59=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 20/1/25 07:13, Philippe Mathieu-Daud=C3=A9 wrote:
> > This is in preparation of making various CPUClass handlers
> > take a const CPUState argument.
> >
> > Philippe Mathieu-Daud=C3=A9 (7):
> >    qemu/thread: Constify qemu_thread_get_affinity() 'thread' argument
> >    qemu/thread: Constify qemu_thread_is_self() argument
> >    cpus: Constify qemu_cpu_is_self() argument
> >    cpus: Constify cpu_get_address_space() 'cpu' argument
> >    cpus: Constify cpu_is_stopped() argument
> >    cpus: Constify cpu_work_list_empty() argument
> >    accels: Constify AccelOpsClass::cpu_thread_is_idle() argument
>
> ping?
>

Hi Philippe, I can't find this series in my mailbox and it's not on
lore.kernel.org/patchew/lists.gnu.org either. Resend?

