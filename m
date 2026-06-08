Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBC5CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWcxV-0004OI-G1; Mon, 08 Jun 2026 12:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcxT-0004Nr-Tf
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:36:15 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcxS-0001ST-4b
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:36:15 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-691956903abso2936186a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 09:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780936572; cv=none;
 d=google.com; s=arc-20240605;
 b=c+npYgfC93H8ZsA/fY5e8dIDJ99rdHFEIZdqIhYnWQ6q7z7UsLQu+kPkeWXomyarBx
 fCfRMBxMLLuCrvj2s987tw1ZgPkPquow48JjOdT8ffZ+swRKGCSk9X+aq81Jv+/3CllS
 b1mjngJSS7LTKOoj5oP9Dx0kyjsDBwOoO1hn5h/6lBWGIt8ZslkX35RQi8+HUKZF+UR2
 /14Fc1nk49F3PDlljlhUh+VHXyU7gUEJk6GIZreNgWDXyod4GoNAsL5Wv76jQQO3FUC+
 ozqQLfsYnfk3cK0DZRCHHI7dzfO0vD5CWNHeMo+Os0UAAtMcQmGkhNeR9bLWjw2TOoZy
 /Lpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NwmNCLGkuspzIgI28Et1TAD4Xjw7J4i47cOhJHPACAE=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=FOFkXzOgyMe8VV47xmKcXcceLLFd/mO07XX9zRcfArv9TNLZDhjy3y/EGhBRJTHhba
 VtkA8Y8tE9uRZJ6jDUOlfePq7pXOuo3uz1GiVcVbOXbTr1M/uGl50wYdmtcEeLigXgb6
 Lcgvp7f5iKhLq+LnPhFOcwt1y/RHeTz/xiKYjnHoQ8VvCi7LLWWo9Q91af+3ABLRe6B/
 +XOY5JTeRKRQmAj+jh9lBJGtj4nFXSjlmNGo6c5F/el1fzI5fqnQE04ZXi2WAG/MWg/u
 RWGYDa0cCm8TebWjvTdYtg4gUUJ6khYDyUAlbsNxXcgQXY5w/4Oi6+K4lRtNxukSV1hQ
 nWdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780936572; x=1781541372; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NwmNCLGkuspzIgI28Et1TAD4Xjw7J4i47cOhJHPACAE=;
 b=xR+8vaRia8renAl0rhK6JRLsraMlcM8xtSX/t59zK9Tlz3aeoKhL35q2ZUZ/c5DOY4
 KT6rkDLgov98hOx4BThxV6p6dVT43EfJJvJgPIRX+TPlWkWOTPcSp2hf8MSpkCj+q046
 skvR14ILbwDpYR21UOY+YDaMLnWSLQiLhzYEjDcqpQLzUHzWb/OmpI8VSE2BXEZATBt6
 nQHvG2VpyZ7rXC6eJ5UzJFtXeGZDgIOELiQXnYERutnXn6GP0EDQIqGBQYUzTLE8SW0f
 VASvKMWfRvHi9C6GxcraL5770LwLe7/icMwdYcar5HUy7CuDZcKSEk0acZYFCnbV/kzU
 h+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780936572; x=1781541372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwmNCLGkuspzIgI28Et1TAD4Xjw7J4i47cOhJHPACAE=;
 b=maXwfSrlyVDw+NntNWcEBXyK7x6lw+NKThkB7e94lPU1UgGp6he9IFPzDs+3PYk3AY
 F2w4eZkHqkcgSlMMt6f+FvYOZ2yLKCKCdLGmaG0h9IEJ5ae4d4btG6S/D/17FFivL/i2
 jR5YZSU75Fk+w+gIESYhNPpATtj0zAIvZmDzvYRDMtcyDGk+OyDBJZi7zsQQ+6YDlazF
 hSZgCukrt9Fa2zHaLb+dHC2EeYCFgQcP1jEyzWiPHUZtpuHVJCNrnZodAVNqKG1PIU1h
 6/QUBIkqZr7H8yAQ06Vl/2w90P6Qzu6hSPiPElGvXoQifk9Z7HHqOea3E5nKFoI6e3Hw
 9a+Q==
X-Gm-Message-State: AOJu0Yzbhm8SgNO1k53tYCork8mvj0xWZeOLaxkXCSGE5idPz/7rAMn4
 Fl5NnWcewlckt7SV+Fhfhg1d5SKkdQZ/2lXksXRwY4+r2RyLA/Tf+DEopSH0EqZePqhSpeLqaPb
 mOT9Y75JxgTYBnU1oWA9OEDpodHm3dumAFnzt3V27pjIQBWmyopgf
X-Gm-Gg: Acq92OGfkeQvG3lK0ZNv6eh+TviZgZx4MJATHWnOI+YFblrTM4JtmMQflF0GnXC2ZYy
 bY5XgkTAG7KlsAgTvIOVAoHB8AkxQV9visiNi7PwrXq3lKpAifNkpfwhdjoXs3m+DHyZNCzrya6
 PMwJQPTIPcnHUQbpKeK4/BGoqUtLFqHX77sU1dZcMQS4qULXPQrYFw92lECP8XyYrHIwV7k/SuM
 Sm4SOIVrU5ib3PZYNv/q6xwi9Lj+d0eOpDK8RVJoGIsilQV5GwUdb1j4KKlN4dK2lRM4XG1BmSJ
 zL9XTL7G0APPVaQQf0eFrROytd3z3izkGf33J9jZG+rJtK8sabEmIduxfo5jaPD7FLnhsflKMj7
 WtQ==
X-Received: by 2002:a17:907:75c2:b0:bec:db41:e4ae with SMTP id
 a640c23a62f3a-bf3737ebea2mr555282266b.43.1780936571371; Mon, 08 Jun 2026
 09:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-6-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 17:35:49 +0100
X-Gm-Features: AVVi8Ceep9zUbh-cOsDcs4ya6Q6mN97MphPOKfCRFqkWAD8wxZqdo3ZHUzUHu38
Message-ID: <CAFEAcA-L_u_jJL8aG8OGuw9Xixz-LqZrgtTnXp=aZog4jRBQyg@mail.gmail.com>
Subject: Re: [PATCH v9 05/45] target/arm: Introduce arm_init_fp_status
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Wed, 3 Jun 2026 at 04:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Create a function to set all default controls for a float_status.
> Other settings for specific FPST will be set afterward.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

