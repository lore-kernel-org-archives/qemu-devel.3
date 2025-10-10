Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49828CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 12:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CBz-00030c-WF; Fri, 10 Oct 2025 08:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v7CBv-00030J-NO
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:25:47 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v7CBh-0000Bb-2S
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:25:47 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b3e234fcd4bso346133566b.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 05:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760099117; x=1760703917; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJef+65pVyTbDY80dc3E9C47XCo6DR8VHYIZD9Yp23I=;
 b=oCPqzJadY7luhZ0xnucCQB9HL5PU63iipdykF6DmfVhxZvx0dfUyJkvLOXVx+NcR4b
 6M9HDMm5/yu7RnYbCX5sKkasyhzyQNOspYAjcvqxKEDROG0m3/JGVB4qeLDw2VOsj90k
 Ap/ZSem8uPmfhcYlowiqH+1khgvXQA2+3o8AgyFFgffinKObfaHKue0h8ZqYxnYaQltM
 jEw7TmJgrpopdEO0jA7ILxT4uq5itbpIa5w6FjvCY3aqH4C7kiC0d/3gtpTJIxrj/lwp
 XHLZ4ILLMmxpq3OzE6wihm4mQET531tFSBdZYIuej6ua6XNEHvAq09BB8ML2uf+AnFeW
 xtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760099117; x=1760703917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iJef+65pVyTbDY80dc3E9C47XCo6DR8VHYIZD9Yp23I=;
 b=kstx78BuMgyX0pgVb1GltTxSRC8ieD43Ya39DnOeXBBqrr71rtJoxUBk0o9M8ltSNJ
 5pvvrtVogBmeG7z1JxJByfcFCEVWrtRKCq3U3loOh3h7MKBN1Z/LTVBJ8XacrTBcQfu3
 8utCZIi8W9Arn8kW7QWy8aabcqKWopoKIdRV9n0ciPbGuBcwM8vn4z1SDuTdnzjbGEYG
 u7MRlqiweGsi7NACzNPDn7cgbEp+GD/sLietBkB9yOTUkWxbqmcZ25Yp5LqRyrOmrkTM
 89vyUbJbNxzkXgbmsG6DMy/SozwX6zFYogTKgHqCMKfbUBs8aPPiVUTiBF9I7vlBHxeU
 BhUA==
X-Gm-Message-State: AOJu0YwXt3glur9Mb3g4hQDgS2Uc4AUcOkyphW5eZ+Ugmhsg1vsobozQ
 MSayUNekd+rGhIxSF0W2CgDcd7yCOJXtU10EfwxVjDQ5AGlBomkM3brtxY3HF3M9rzpAZmywY8Q
 eAPBbO1/PGljAzsdYidVGKK4ICvVX6DPgvVZccDjzfA==
X-Gm-Gg: ASbGnctQbze3kgyRBV1e1zzZVmNNMdLOaLEFeewXSeL6D3FyADg2188C+C0QRQttVXT
 6MCoQKPMOaioyPfBNkj8Ng92mgCptDfz3srcSct0jqJAJ9WdO9HJr7Lt4ucz64a+L66XVmS8Xqy
 dM0f4bgBI1K7JxQOuxYOrtpB6RBBXkKkUA27MYMKSZe/+6ZbovEz80x0sFTN1gLZrb+Q27HdnDg
 KVsgWCkdqoRzrePru9yi8jY7e2VdAUClszpew==
X-Google-Smtp-Source: AGHT+IF656kEBXTzZ8byg7Devab5wI1Hv+Xa7n1VCnzFCHVk9ljSd3UVs7N8bOMVGxwtGbYcqq2wqERBNtdCvFNjJQU=
X-Received: by 2002:a17:907:1c91:b0:b3b:5fe6:577a with SMTP id
 a640c23a62f3a-b50aa79279fmr1224710566b.8.1760099116632; Fri, 10 Oct 2025
 05:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20251009211148.642966-1-pbonzini@redhat.com>
In-Reply-To: <20251009211148.642966-1-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 10 Oct 2025 15:24:50 +0300
X-Gm-Features: AS18NWA7cAXZZ0OXHK_huRz8qy5i8lVmyvq7ApWiiE9yVX2dj303xnWJo8-4KAE
Message-ID: <CAAjaMXYocRnv-TFFw8nBSsLDihooVNoM_VGrFNeeq5-9YVNdSw@mail.gmail.com>
Subject: Re: [PATCH] rust: pl011: fix warning with new clippy
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
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

On Fri, Oct 10, 2025 at 12:12=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> Newer versions of clippy are able to see that all the variants in
> the PL011 word length enum end with "Bits", and complain about it.
> Allow it.
>
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


>  rust/hw/char/pl011/src/registers.rs | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src=
/registers.rs
> index 0c3a4d7d214..fa572811b29 100644
> --- a/rust/hw/char/pl011/src/registers.rs
> +++ b/rust/hw/char/pl011/src/registers.rs
> @@ -255,6 +255,7 @@ pub enum Mode {
>
>  #[bitsize(2)]
>  #[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
> +#[allow(clippy::enum_variant_names)]
>  /// `WLEN` Word length, field of [Line Control register](LineControl).
>  ///
>  /// These bits indicate the number of data bits transmitted or received =
in a
> --
> 2.51.0
>
>

