Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2ADEC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhUmy-0000xZ-A5; Tue, 05 Mar 2024 08:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUmw-0000wl-Ov
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:24:58 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUmu-0000Ge-UJ
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:24:58 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-564fc495d83so6908084a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709645095; x=1710249895; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3HjOVpyemVvfYxuS83Hc64F3D7md4xvq6tyhMY07ABg=;
 b=JXJuhPBPMq10gvwo+BB6ZjjQF8nNhlCo4GG8Kz0dMKGkm1sgqk4dUPWIHpoJBBxW9X
 5kZCU6WapOpnqfHuo9StEsZ4Oy/h8B5VkhDc9aGdEDJgw7JrslcEbT0z6j9ySJXnH7Ed
 G4eSuwXmAV/uV3UOpz8uNySXeR3DvCtQRyCRemWgXK//eEkRThkkJbEOXkKLjjr2f7Vj
 2CdqO2uWb33q5FZspvTIUjVvRdbUT5OHzCfvpZS4GCqju3M87nk+DcIqZqHVNIyGe3Z7
 V2b2v3o+CYzpLsNRhthyS0gibInF+n1zHq8wkwLJx664b7DBnAyTqHjY/4kx+BFGdN5Q
 gO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709645095; x=1710249895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3HjOVpyemVvfYxuS83Hc64F3D7md4xvq6tyhMY07ABg=;
 b=adgJXbngkhmbKSc3yK2aAgo0+nwT9/Atgw3IVNlgAXdRmTQVmav0fZqlb837cAQ3Ul
 KrtNo9xCkdVOUGVa/LNw3YuGgpBpdOWpIhclXY2S7iJS8L1c8+0IQxXdJ0pcpAybNR+9
 aQz/z4TJ4VIFZ8M6gaJvqXqMqSRizIVZCli//vTotpilHjZZwnTsKqbC0AbtiT/6K/0q
 XE7MVKkKw04516R76a5gxh+IpP+1CXTD9jVeA/nFPMHHmQjrJbdjqCR3xcngYUsTxcfF
 gTqihN5io21/p3laAhh9z36cY3K+MKVR5BTvCkm/nPX33y79hMGtuEb8t2QZ3YxNb7Fb
 5G2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrGg6dS766Z8rZt20VJwUcrgal/6NzG15R3MVoQ3O5kPUqYrcpWfDd+7L4l5vewxo/Ho7phLT1If9Bj1lvhrbabGwki4s=
X-Gm-Message-State: AOJu0Ywv9d41a7Fi1eRB17yO72BGvXARpO7oEVKCR8ynOSrlwuNvh98q
 MG6mggi63eAemQV7N8ou0iJRomrtjI0yQiNZLTOZRhQ9eY7aqtrAqrX9SvylFHFYqAMqJHxdh+A
 GNBfrI0T/lRO0SbjLcXT+Yr5TlQiB8d07VgJQ0g==
X-Google-Smtp-Source: AGHT+IGngYB4/h4gk3+d+tr2yMKdbdEQNIIQxQYjf/N1fWP3Dp06kehmch3y9YicVoUfBpb3hinQrG/tn2HvVKbL/jU=
X-Received: by 2002:a05:6402:b6b:b0:567:bce2:e3a9 with SMTP id
 cb11-20020a0564020b6b00b00567bce2e3a9mr211922edb.15.1709645095222; Tue, 05
 Mar 2024 05:24:55 -0800 (PST)
MIME-Version: 1.0
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
 <20240305-elf2dmp-v2-2-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-2-86ff2163ad32@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 13:24:44 +0000
Message-ID: <CAFEAcA8OpgnQojTVxLhy84jodoRHZrQq+sxr4cskRL4+edjsNQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] contrib/elf2dmp: Assume error by default
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 5 Mar 2024 at 07:36, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> A common construct in contrib/elf2dmp is to set "err" flag and goto
> in error paths. In such a construct, there is only one successful path
> while there are several error paths, so it will be more simpler to
> initialize "err" flag set, and clear it in the successful path.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

