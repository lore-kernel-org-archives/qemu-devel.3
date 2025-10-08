Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910C8CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 13:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6UgQ-0002Co-Ni; Wed, 08 Oct 2025 09:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v6UgN-0002CV-Gv
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:58:20 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v6UgH-0001aS-DW
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:58:19 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-afcb7a16441so1208955366b.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759931880; x=1760536680; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JADSVj+c05yFM+Bc0BTYO3Nwo6lYEhhOGwtrovfVYiU=;
 b=eKWizcwijF6MnBp9eMiVjoM2PF9yNz6WZ5JSVM2EsNLh8TSfrw16k+e42IkB2CrTga
 5pAIXIVE14olstO/vTuBUkqx7plJjkWBqjb2spHW5Uvg6rEu5eYHRsGWB7oMAii2ER8B
 +88ezoPz+COvtVSqpp0Wm4aF125Z9zFtC5bpICgwzpPYu2iB8Ij8SX+s+jljx49R/sbR
 E9QNqS9K2VcSaL7cEhgayJXJ6KNQIG1qM6Ge1YtpZBOUc91ssH8/sM6so/UmBggNf8R2
 0MKvAZznVZMeCGF02KdR7RgzePa3HdWF8MfVMdSmLIwMk95dOvyp/CSc5ceNz11b4q49
 fQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759931880; x=1760536680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JADSVj+c05yFM+Bc0BTYO3Nwo6lYEhhOGwtrovfVYiU=;
 b=MBaLpWId/pHf7iwiGtCr9mbFY2uiiMb8qLo/0huiYS+YG0F0PkFDLa5QR8lB/9tAf2
 4IzHlmGi4DP/jwgtP9QscleOXGRqgbK97izB2tjW92enePbUjZRVcE/2nBp8o2xX37rl
 iB5DODYbkxBczZ4MRouxcn8FmCMOzYBB4w5HYiFsnGjd0ADUNFRIJvm9nqYulymHTKbX
 5kus15jOXVypyAUfRzD3axlsEccDWESreV680IF7M6aUulwpOdDPH6/fBVKf3+OLhm4F
 VjnTrnK3QZyByPnQpm1ahfb5SOvs1PxBYyYSLzF+csQDyiFKZUCg0QQGDjMDu/QK1p7+
 QHEw==
X-Gm-Message-State: AOJu0YzExY3/5y7t7P+iKtAOOrKlC1S1B0ooRZtLeSOo/iV5XAuT7FQu
 Cp3tyltdpiyCcMZ1+MtLDcnkkprQwcwFAIuTJZxOaw3SsdjuPfTswo14PB5BPM/3GCVsCtwnaHc
 pdN3tjp7kpba+uYsjayEJkSZg0ebcEDJim4OVdOfofg==
X-Gm-Gg: ASbGncs+73wx+EfC/ojexFsTZ3Ki+7viMc11sUaRUB954ziGuMlMead9Nn4LC3qgywF
 LOs4bDCGpkad9Ycyitzims4tL2D7WOsTD65XJL1STrcYh9reVyvNowAhJ/r4c7886foh6ANJXoH
 XG0IXhiMi8CKy7iuZ83dlUSMLPCUh7+bAj93IIKdZUpT0ox7e4OcifSBeJ3cmvZQuAhdlAzdecR
 bTisVYBlwUjD9fzzmgLEYhWzkWFhII/
X-Google-Smtp-Source: AGHT+IGiVjo3CAeR63KX2SVqyK7ykg1Anc8yWjv2sE3Oh91d+9NbcLu3Y6bxaeDAHnN/ugURX65PftlD7Vc+N/khf+8=
X-Received: by 2002:a17:906:4550:b0:b50:b539:8be6 with SMTP id
 a640c23a62f3a-b50b539915dmr341766266b.43.1759931879628; Wed, 08 Oct 2025
 06:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20251002145742.75624-1-philmd@linaro.org>
 <20251002145742.75624-6-philmd@linaro.org>
In-Reply-To: <20251002145742.75624-6-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 8 Oct 2025 16:57:33 +0300
X-Gm-Features: AS18NWDZUUaO0rEwrcvEvdXr3_TRBKTPkeZAvpq_AXmn0SnQrcbShSDZQ0WD6qg
Message-ID: <CAAjaMXZqR_EQ8+UoWjdneUh46_=EvocknhbXKQ-hOV3ePMZcBg@mail.gmail.com>
Subject: Re: [PATCH 5/6] target/xtensa: Replace legacy
 cpu_physical_memory_[un]map() calls
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
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62a.google.com
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
> Replace the *_map() / *_unmap() methods in the SIMCALL helper,
> using the vCPU default address space. No behavioral change expected.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

