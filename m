Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496FCC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 13:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tclYt-0004MS-MW; Tue, 28 Jan 2025 08:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tclYo-0004Le-NP
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:23:23 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tclYj-0001xS-GK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:23:20 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e587cca1e47so3285060276.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 05:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738070593; x=1738675393; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Axz5E3/0syXeLtx38Nztqx4VhAYcg41Xh5fhz5/CPao=;
 b=wEUxbSf4JlXRSB0SXU1QoGQVmgegg+nroyucmvIUkdmpHHONFh68BshZ/WkJFRGVZK
 2Xe1zuQYlDrBZ5jOaAaal8xWqcxIbcDzfGmqmYx7Ey2YdH7vmQej7SiWoGSa719i3S+q
 urfFDYEmFmzEKgTIAv7l6WggFRuYhy4Vwo84Dsxc/mmZ+8KVPyjF7aqIcJxubdchQ4dA
 +ta3t3pWbA9QHuNbx7av5TprQkhO3Yp0E/foFkyA5R/YPWpUR1bGh13ckEcG6W0jREbM
 1OuImb0uQZo9j35Hcmc1SdbWwmaFFaG96rCFKv2lnxJHAVrtUdCJnSRXbRUZJH2u1ksG
 HJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738070593; x=1738675393;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Axz5E3/0syXeLtx38Nztqx4VhAYcg41Xh5fhz5/CPao=;
 b=hM+ONaCqFNpdXxqDSfMt01D2e//MprJPz/Hizbp2LzIxDK58iuT70bMfxxV4QE/s52
 WnzDDWT3oyWT6cTOWPHCLHjf9E3jY5+FlxQRmk8D70VTF0yv7AS6KIuxOoMT3JhDHOf4
 HqNQlZYv76e2TCKwuPpkD0RaEiQfDOdYqlBpWftkLhnWcv36r0iP5p/fAd0YQ659T4R9
 Uk6Dua3HmbCWhDZHlVbChlY7GYc5XXtOMB+QNqyFJAhKmZo3TQCpHDExjHyDJgvDoMgs
 8CO1yxiw4kMD1aDs+9XA4w4CJs/AedzqkTigh22AaG21yMF0rZXhzW7ElwHa+auv+xTJ
 rsvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZz+bf9i6Hr/k02J5kEJFdH0jYoGjLPbFoGvA4Sa/iL9gPE4KmbedblETpwLw5X4DevSxUt7MA/boF@nongnu.org
X-Gm-Message-State: AOJu0YwtK+d3VADPcj9QK7itFjOKdWEpuUad6fUfnitj/z/SP71KJzzL
 3kXzAgEeonm33MreZpJ5BgoDiJnQbNx3Y+gk+QGz7+DKGhNBlbAKaJjw6+uZ9L97srqkaJ8gYl6
 7XxOMwH2gwzajPmTSRlVKAjjVGHij303BxAlnCA==
X-Gm-Gg: ASbGncs7+odhjNYM2Rbv+WXj4XQMabzn414YRCmSG1xjLciRiwXMb/6P7kUbFOrTDMY
 ya+yOExZ25cl8QPRxoJYuiHkHGfMFChjDdbWB0R+vkwSm2GbiylVf7hkTxcqDByq6v9HAQrk6dw
 ==
X-Google-Smtp-Source: AGHT+IG1qAZW3dVPIxEaI3w9dP37rmaG7HGaD8XxAM+hpBoccAf98PTQ1DZkPLdz4JiyDJE5OZ1TPNWlDMwd4Q6z8qU=
X-Received: by 2002:a05:6902:72a:b0:e58:32b4:486d with SMTP id
 3f1490d57ef6-e5832b449c5mr17368474276.30.1738070592830; Tue, 28 Jan 2025
 05:23:12 -0800 (PST)
MIME-Version: 1.0
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2025 13:23:01 +0000
X-Gm-Features: AWEUYZnHW0ZL2sk_ht5fFjcurmIhSi4e_bRExQhgQaUQwq2Bqt14KKJEyYlx74M
Message-ID: <CAFEAcA98=OVehu6Yp5i-30ascFJogupQVBf2WkCg5AEEh=yJ-Q@mail.gmail.com>
Subject: Re: [PATCH 00/76] target/arm: Implement FEAT_AFP and FEAT_RPRES
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 24 Jan 2025 at 16:28, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset implements emulation of the Arm FEAT_AFP and FEAT_RPRES
> extensions, which are floating-point related.

I plan to take into target-arm.next the following patches
from the start of this series: 3-21, 25, 26. (Paolo has
already picked up 1 and 2.)

I'm making the renaming of the FPCR_* constants RTH suggested
as I do that (i.e. not reposting the series just for that).
I'm also making the correction to the is_ebf() function
discussed in the review subthread on patch 7.

Handling the review comments on the rest of the series
will take a bit more time/work, but at least this way
v2 will be a bit smaller...

thanks
-- PMM

