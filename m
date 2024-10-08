Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133B8CEF17D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syB8Z-00045d-Qr; Tue, 08 Oct 2024 10:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syB8Y-00044e-7F
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:24:30 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syB8W-0000lO-Dz
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:24:29 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c88e4a7c53so7055638a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728397467; x=1729002267; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z4aiC/7up85pu8OiJPObcHH8gZqfcYf+jIO69S39Gcc=;
 b=ooAfSeAVJ50nyt1DJz4yDDniWwYMYJ+BdR2dl6RmKHs9evDf8rjEWE0YXvlM7zTNaS
 b8GGXHDdDMCQGaxE9n73JEuc7SFLjCfdJppDXYEQPhJNHpnxGnuVLNV9winiVOV8mbs2
 wwcDv/l3yxKo2ptyrY4UuJx8ItnzTSPZKPI9Zbv3PhBjgyn0doG2H6rpq8Hsu+KiKe2e
 HHYoj0d9xAazFKMAADr9xAMZg6qUvdi9/mKbnpUZcmcaIwpOHl1WX4ScUFbgGcRborsc
 KfuL9XiEoHVJqZ4w75ZjUr5XiVbavKb+SjhaeziIkpKkc9mX9GJH8CqE1bUfD3g7DKI8
 6bMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728397467; x=1729002267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z4aiC/7up85pu8OiJPObcHH8gZqfcYf+jIO69S39Gcc=;
 b=l1nJk5OjzlKu47K5vPCP7VGQvTKHpmYJWbDvtw9Ly3+/WYi8gHyIcrh7mVY2IZjRCx
 Hov3vYXRc0+d2G+N5ThCenJ4Lzg8F7YXV/BqV9pohHdnXBp/0VoVsPkVJVrzl+jKDf80
 /EMlQASRn+8AAIAoNe1wLHAVLawmLs0IOHj3zmUwMX/rXjyzc+FmyGKo0HDjkBRWfpaL
 ijQ7Ast3N25qYfyv5s00djPGyIX8+T+d/C2ErBfXGz1SvKh0FABx7+cAqqX3deFbw/dY
 Ie7yMddtZm9GDNVXI/N3UBxg51+7ZMhqo6OvLy4fELW/8goUJ4lSRZl+ye5U6bdmNVGH
 dLQw==
X-Gm-Message-State: AOJu0Ywd0YQJ/gykgZm6dezwecOcGn/by0s4EyWh+B/BAazZ7wtDmMXB
 U6x0WQ/9CS7zlZI1B+nrBoVjX0vABJ3bs3D145y0su5fuLmyvw/6fEvm2AYEEFL4rEBMLyCXi5H
 x1bS4+hxHWOvvPxCGCf542cOCAfxN8yv0jkuVdpJmQCcYs88X
X-Google-Smtp-Source: AGHT+IFjmaXftKW+6p8dHDnPmSfWnXvCGIMLOzreTCd39rQv0liiKgCkuBl94L1p1zuof0Lcc7z7N+hK0iYL5rshMJc=
X-Received: by 2002:a05:6402:4286:b0:5c0:c10c:7c1d with SMTP id
 4fb4d7f45d1cf-5c8d2e71be8mr13160085a12.23.1728397466890; Tue, 08 Oct 2024
 07:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-19-richard.henderson@linaro.org>
In-Reply-To: <20241005200600.493604-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 15:24:15 +0100
Message-ID: <CAFEAcA_F5V43XofxAOUCdnHfU5_xArJucqvWczJqi8eqgKREoQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/21] target/arm: Pass MemOp to get_phys_addr_lpae
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 5 Oct 2024 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Pass the value through from get_phys_addr_nogpc.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/ptw.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

