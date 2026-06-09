Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9101FCD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWz6P-00087o-5I; Tue, 09 Jun 2026 12:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz6F-00085x-Nf
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:14:47 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz6E-0007Gi-4H
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:14:47 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-becfa735b9aso774498466b.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:14:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781021683; cv=none;
 d=google.com; s=arc-20240605;
 b=Q2YOzAxnVG6tBooZXGq7mP4GyIz7OX3s7cLaV59x4XtM5/G5C8yVVbafWq4MSHqAfO
 S5v9TzAaPK2QrIyd5tS4wkKGAdYsv66G49hgijmnQnUbZw0dTjguyM7gVYICCUsxB6mf
 aKjDSgcVzJPBv3RDWbK8YtkYiGZbCg32FEk4fEQOoH1b2w/LDNqC3r7YZW2v4gm1S6B8
 APkFIt4ard3eIhJdeV6R3iz/Q0KSG6XP1LvuTnvnjYPCGmFdJWgeSOmvcbCNPgV4FqvA
 Rjojy+9AXirocNO3jncJdR/UNDdVNgQpVQ6XrEpTPP5HT3xgcJzya+cLoZ44vRkeIWU0
 1M9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bmbZtOBEhzGzWB5lH6BsUTwAB8cq+OSXLFA+O8hG9ys=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=k04hy1hUuv+etIHhULwxhsqogKF6iYaEY6XTwnStpOR8p4EF5fHLNhvE0FDiLuXzTB
 Vuc4siSmUjnXUS5XiROsTUZM2+krG74rNEGLNmJFSn60rNKw3jbRvLZZ+Cdx5G1JPmuC
 8TQtm3Xj1dd8bVz+NuIESNYH7Rc7dSHpBSQ3nsDMqJnHVX6kKjsJuvO2SRF+IwZXrSLw
 50pM9QiyvkdRosRo8TdX884jMzdKm0DnqgFFzRT8VgKee05wNrPIQ2F6ciF2/5RDPe/G
 zd+RLvvYbHIzOBjqyYRbMKLGxQw5JFN9bd3KZlVfgObDyqV3gXF0N7nJvbd3GSk/uQ05
 gJHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781021683; x=1781626483; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bmbZtOBEhzGzWB5lH6BsUTwAB8cq+OSXLFA+O8hG9ys=;
 b=AAAg3gXOmKsZ4VCtVSjx759ij3X5osPkSQS90sEonXvoPmZpUua1QNsGaMBrqkrc6K
 PgiiGDevuz1durey0mlEZLwnr5Yrz777gxKRvF5rulCAmcZwfQJzMYAyqe9ITyJ9zaOw
 qnL7n91rE0fV0G12RsAd0cPHfSky4eBaMj0CwNtKodZj6pzvsdswZuLfd2nbbydruWlN
 SewP/Y3VYMNdLd4dR9MiIaIRB31ul6yAWNZG6ZZdjRDNVvTz3PCdM8ZsHk/AOzhIeDXD
 N50WisAaTbQrw2qSsQtTZNGk/VY1BZCT2E0rgenYvJXGjoj+pm+qPGpCMV9/yzTY/yRC
 QRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781021683; x=1781626483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmbZtOBEhzGzWB5lH6BsUTwAB8cq+OSXLFA+O8hG9ys=;
 b=cTai2Zgr2H7D61XU51xXb3gGNJ65C/3lRHg7MuNgKq0iAownLzMGuupmFm6CCvyOVC
 CfLdj4KNdvdSptDHETG7N0pSifMEFNSj18YdI54h3jR9MZoj2bJs2zWetmjZDYYscNRO
 b/zNiI18Pbg8yEzOkWRbfULTUwbyAaSEM64/IuO7gAcqKloCSoyNx7hE7zLUBVixyw/N
 N408F0Y1m+7M+drskoWYxHx0hrjMPc0v1BPDWPhcakA+jhOVQQ296l7zKif5PfLnhPTP
 pRr8vuX2sddkgnLl3zlZYbNi+/7faIpGTE2kqX4uAfczJIEKmK5ZCdJdBY+2SexhyS86
 WpvA==
X-Gm-Message-State: AOJu0YzxxRBj3VsirpgWJtTcfiDQ8cqBp5g8xF9XRs5qrYyPOGkrsPQg
 VAWTiwyz1jCUNr1R1oJHpHD7nuUyY1Q7+klWXAzz0dJENwlbGj02Ix8IxOIUy7936ClmKE5sr6m
 gsnKiKz1bcxS2hg1kDJ62j8uUgZPjqG9pYndMu8Fdlw==
X-Gm-Gg: Acq92OF52GoDjAyV8ZeJnOR4P2Jm2JnYu4z0AbL12KFqYaodkLgBcvgwZlmfkjAqzdx
 P2pV5cSSk0ukK4fNYTU0yKY+jWKwra9Pa7dH22JU8iT/l2ZgK5hN3miu626SCW00S/RNZKo4XWs
 zTIWXfazbuB0PPVXSCalSymhTbzx2BRD/xJenmnAYbOAnLBiqXX2r+6r3eMuFBJOOuxEdeMZSY3
 NvtCrkjITr7CQRdXJ95qoNMI33X6Y4pVWUVVRLBTtws6kc8j9H+dOdlxD2zn4AQW1I0Sz92VYyW
 7s0FXiZD9tCHYAS1UBh6mTGwIOATYKcNKXBtgT821S1Jnm6nmaKnLKJVZItSbRYdo1m+oXhj7z2
 9yA==
X-Received: by 2002:a17:907:9687:b0:beb:1dbf:ebfe with SMTP id
 a640c23a62f3a-bf373408635mr1074165366b.36.1781021683421; Tue, 09 Jun 2026
 09:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-37-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-37-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 17:14:30 +0100
X-Gm-Features: AVVi8CcX498MBZAGQVeJBG8M65WuCgYCgOLMs40tK_gwfCcV5pc9cEkdLGG3e54
Message-ID: <CAFEAcA8uT0091zwWr2dLJrp6xU3+DG10xHh-M9T37_Wmj-ayqA@mail.gmail.com>
Subject: Re: [PATCH v9 36/45] target/arm: Enable FEAT_FP8DOT4,
 FEAT_SSVE_FP8DOT4 for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 3 Jun 2026 at 04:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/aarch64/elfload.c  | 2 ++
>  target/arm/tcg/cpu64.c        | 2 ++
>  docs/system/arm/emulation.rst | 2 ++
>  3 files changed, 6 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

