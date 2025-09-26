Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F46CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 10:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v25M9-0008Ib-AX; Fri, 26 Sep 2025 06:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v25M5-0008I1-DC
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 06:07:10 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v25Lv-00063O-1x
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 06:07:09 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6352ba3c35cso1182778d50.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 03:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758881214; x=1759486014; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iySpOkGs+Ete6W2p6L3KdbLpNC+/AbFkwUJlm2GV+vc=;
 b=x/y+CtQ8/xn85LRsHm5bz7KzTLDIa1bshGSPpUnZEDU/2WY5nQYM54qKrXK5qzyDpV
 X8vN3dQgjSV2vDbmhwJ5mataCdkERzgU6G3UxziU4TuBSveELjWUIWX+A+2bXeiiQ/GV
 mG5Se9XhIcBcZvRgT8WEJKcoSk/pO5GluuGHEXj9JZPWHU/kA5FCxRKYNgB/MFu6RYCy
 bx4n42w5srQc31RcNyQW2zYvXVGg7fONa4orFMI7E/Mm19gxHgsnxoFp/dVeS65hZqMS
 IroH+B7wYkDKdcZIxI9ua46ceeoVZYXMqadL4s0eNg8iy2C58WiKu0PfR5xxjVn/9fYx
 luVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758881214; x=1759486014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iySpOkGs+Ete6W2p6L3KdbLpNC+/AbFkwUJlm2GV+vc=;
 b=Z6k2jF1voyGG/PJzDdTTslYST9eFDbtSR082rN5JrDhhNTAwIrI06GuG5SJRSAQwiq
 BH0Hqv9ymDOumXcJckxyMjG+LYlX7DxMDycEWSGjYRd75wPu0A1bbS0rnX1N07MZmoWy
 wmfxgTNAFjMqbB9XL9ZJt+o2M9WYgciSt4hqMaI8U7IUlMPJSkPjYoLK0BjI0VjEtKLq
 Yp1JbpS7CB5C9jdzlO+38fKK7qcMv9HB9pxJ8DhQcgZP7ftK7ycMkwbwZ2YLrpkaCSSA
 b84owtpEQpNzkmzDPT+vf0SBwAyp3fIvPdqWRQ/pNnLBtVdYnFYHFljUh3OOGFTbG07k
 x+Gg==
X-Gm-Message-State: AOJu0Yw84g6xdRL0kbbLfcgBxICeHR01xEqGF6DVKvVpxn2VfKiZtiG8
 q+WI52LvHLUC/udC9BCQXT9i8G37iSTyPgXq7y7SOdA3y/fSKCR8vsWPtGdRRbEr5DL8gudy4Ta
 H2dmittiEh0//nzctgqQP+QnzmzowP0p7ivoglkmmEQ==
X-Gm-Gg: ASbGncu/4WhczCBTcw/F56Vze5PvnwlUlNe2GN/lV6FMU1zTf8BGa/MUFSzVrGUAxc/
 vFAFOMdkUV/tW7MqaQl52rNOXj5vLjGVRTka4eXA6a/7DQB6sLgmdbhcvJPJ8BAcoI/ZyrEiyzx
 Cz3N986nHNtnzcIrhv3qEqE9YPbt1BM4ef/Wf7lyIIA7/sG0sBna0yeW5OB24wQceO6VN5OIsYh
 nBogieC
X-Google-Smtp-Source: AGHT+IH3aM7e2BoehfpDtgmDWSbVVS+bpHD9Y6xJi8R6LWGNA/M4FQuDLo2O/u3BUIYCO7d6x3T3qzGVUL3dlE//9og=
X-Received: by 2002:a53:ed42:0:b0:636:1c2a:28a with SMTP id
 956f58d0204a3-6361c2a1459mr4930234d50.16.1758881214450; Fri, 26 Sep 2025
 03:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250925032151.73250-1-philmd@linaro.org>
In-Reply-To: <20250925032151.73250-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Sep 2025 11:06:43 +0100
X-Gm-Features: AS18NWBa7bWD4CcOT00xsI1wHzg32K7bhAUF6eMq2SMOgz2DcU9Aoz1pIxzFQcs
Message-ID: <CAFEAcA9m+=M3Ds4oTSmWrreGxgu+cL2k_nvsbPj9f7Lc5bT+aw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Replace magic GIC values by proper definitions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Thu, 25 Sept 2025 at 04:21, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
>
> Prefer the FIELD_DP64() macro and self-describing GIC
> definitions over magic values.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---




Applied to target-arm.next, thanks.

-- PMM

