Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF99ECAC599
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 13:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uysSz-0004Tn-8U; Wed, 17 Sep 2025 09:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uysSx-0004TD-Ep
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:44:59 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1uysSt-00048k-WC
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:44:58 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-ea5bc345eddso829599276.1
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1758116693; x=1758721493; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DnAo/2DPNzNJlRCruVcjhGpDofdhOKJsOj0CkRAW0IA=;
 b=W90MhyGYuXGydLIG+rKt3TVC0EU71Hi+qM7uhMSxpmARFPvFRfgdlZXTOO9yYT7p8U
 BSniosN1bQC8i60K4YKG9JWi9XB0NXXD9Wbu6OY2G0vjnL9hWiyb6FJ+fctx+yrmkmM/
 HBvSaOL2fYHlb9MLh6VB8PapHVzwkjRPI5Nbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758116693; x=1758721493;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DnAo/2DPNzNJlRCruVcjhGpDofdhOKJsOj0CkRAW0IA=;
 b=SfAqADjh3y2hlx3peLpN56sadft5rySI+cAKb4SaBF7CqpGZAmls1JQm8Ea7Z39tym
 P6s5FyYufM1j20BJXemf4dnVywEbfPwDmJk6syjlpRznME3O2yi2BJITyaskyjONLujh
 mYWMExY5VFm7Lsbov3BGveSoLTk5IDa9fefcoUM+mkxP34WvxU7OyTWXw2xLuuPSMrw+
 tehIGeQRn0r8XXCRDDtTNEP+BiJVwWaQUTVnGiXye5sNeYoP5wwfmb0Fj6LjBsLlS9ZW
 0yo5gShFY0HnAg1c/mMYZw8qykHOg3X9FcBx0P+40IyxC5R+XzcXgFLTbjrGFVsrdGXW
 4D0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3r5/CaVtMSbbCO7VrVY7zL+DLbCeuS8nVi5fxQCvKH7cRKahx1d4hiWLMMt4TT/3mlLd2xqgpAdRm@nongnu.org
X-Gm-Message-State: AOJu0Ywqq/U0RQ3JQs2oclgm22ron7SQpSaNpuXW+BA8Nr5bcU5WuyAk
 c1VnbciyfGaci64MElWRI2KuP1HuFadNwtz17Zyao/sNhfRV8bN6yg+sSvmQDAaaeBAFxHSgrN1
 AxOTK+/oeql1QyOlf8ehXPn64lJFmU1U=
X-Gm-Gg: ASbGncsW5ic+VJ12vq4IbvEIUI/HLuIYY7MLIn1bpcmB0qkQaw1pms+mlOmZH8oJA2M
 uhXqA5CYhOwd1cTZ+4fypcM0UC1RJDAqTpAzVhrc00yll2VAxnewqvt1T9UxKgc5RcaGzmq+Swb
 26hT8Rr/JQHttWhthtTEarx+W8o0c532KihQsUDTMyf7wXuUSH+WJcB/O0Sz/InLFuca0RwlugT
 zzfI+8=
X-Google-Smtp-Source: AGHT+IHgmMs5+X+sQEWEMHFWE610CrlbWgH9A1Rc6LlrOXPzIxlnt/SDMG6N3YwrHeDPmFn7nRAks5AfBQvM/zPEkLU=
X-Received: by 2002:a05:6902:6283:b0:ea3:be0a:ccdb with SMTP id
 3f1490d57ef6-ea5c06ca785mr1698131276.49.1758116692811; Wed, 17 Sep 2025
 06:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250903030114.274535-1-npiggin@gmail.com>
 <20250903030114.274535-3-npiggin@gmail.com>
 <6bff4c9d-1da4-40b3-901a-789923d8ef7e@ventanamicro.com>
 <qyikdqxxiewb7tqykt74gpx5oereckbepyptd3vr4flptmrvoc@midnt5c7agnc>
 <3dd9888f-be16-48f8-a858-f58a5b57825d@ventanamicro.com>
 <188f0525-154e-4d08-a155-68e8800e302d@linaro.org>
In-Reply-To: <188f0525-154e-4d08-a155-68e8800e302d@linaro.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 17 Sep 2025 23:14:41 +0930
X-Gm-Features: AS18NWCeGWFuyoGez7_HVxFGxkW8bU2PFEbxZV1W3p48u8b7E3YyLpPT6h8kHMY
Message-ID: <CACPK8Xd183vLgSyNfjzN5caUeJGRrjM1J8ugTVRd2k0Ea5LpfQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/risvc: Fix vector whole ldst vstart check
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-devel@nongnu.org, Chao Liu <chao.liu@zevorn.cn>, 
 Nicholas Joaquin <njoaquin@tenstorrent.com>,
 Ganesh Valliappan <gvalliappan@tenstorrent.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=joel.stan@gmail.com; helo=mail-yb1-xb2b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

On Fri, 5 Sept 2025 at 16:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/4/25 13:06, Daniel Henrique Barboza wrote:
> > How hard it is to update the GCC version we're running in the docker images for
> > "check-tcg"? We would like to use a RISC-V vector header that isn't supported
> > ATM.
> If debian packages the gcc version, then it's easy: change
>
>    gcc-riscv-linux-gnu
>
> to
>
>    gcc-NN-riscv-linux-gnu

The test that was failing uses debian-all-test-cross. This is based on
Debian 12 which maxes out at GCC 12.

If we move to Debian 13, we get GCC 14. Something like this would do it:

--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -6,7 +6,7 @@
 # basic compilers for as many targets as possible. We shall use this
 # to build and run linux-user tests on GitLab
 #
-FROM docker.io/library/debian:12-slim
+FROM docker.io/library/debian:13-slim

Is updating the distro something we would consider for this development cycle?

Cheers,

Joel

