Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06168C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 12:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaChC-000792-6F; Fri, 11 Jul 2025 08:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaCgr-0006sq-BA
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:17:25 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaCgn-0002MS-8t
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:17:20 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-71173646662so21580127b3.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 05:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752236234; x=1752841034; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J05MeQp7wPaUUuYCLiT42agKKg8NYCskjR2Bj0HYmPU=;
 b=HBxyOPKC7+HcgPy4NpYfoDDKPRh/d4OU7rj3cBnAXVTGUNa/uaCz0imSRA4kAcLzNH
 0cgWZECUS1Y/VW7ZQ8o/WWEQoCbLfP7zQTj+wurCc3YsgYkCwMHO9Z4ZHG4L+eya8I2q
 3TzaIpM5a6Qvh2t+ptGzO4qjmBlYI/hrm2jVChO9Jpa7iWYYPr1wiF/rQpDFgCl2xRoU
 /v0J4cQ5VjNhUbsicMszJI86VcI16rWTe0jk+9qZ02tUkQSgCdRVwHbtMBByjjWZYrHg
 unewPtODYdNPYi4YdLNGKDMUjmiUAhI5WGb8tGwKqUcdAukTsA2HRzd8WmHJocfOg+aS
 rQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752236234; x=1752841034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J05MeQp7wPaUUuYCLiT42agKKg8NYCskjR2Bj0HYmPU=;
 b=xVgzfDIaPy9upE4dQfXwGrWhrFcekZ5GLC6ECdAWdegMiSwQOm4Ks9SK9XfPWkYKUy
 hZhbtScpBni0/MBiyed7oT/JLaz4v5DS81FsBaTzmaC4+sjQ7cVXG/mC/SPk4JJW+Eso
 AntKAYRQup5AoBxHzLctnr+/oQkpI6+7HX9R7SUOwlO7H7WysFPS3irONU+4p7ajwgXc
 ViqniuC8LlTaTt8+EhbC1k0luu+3s/0lVxVY3IaDxYl0W9gLp/Fr3bYFQWV+pB8m+E37
 fovdc4XUIysCgDlWtI9RNRnsyxwgOSBxfm0jDgO1FMVJTA2s3lyZC5Xzh5axg+S3aMqh
 MhQA==
X-Gm-Message-State: AOJu0YwNJPjuwsLC38y4bIq8q1iSxfeN+XKqTeJe41NcQQFtsf9gqyoW
 whRtt5QH5H06+AeIBAhNREFVwxjaAybDMJmH+kUS01SiquDGDISBdgAVg9koDpn2oGf1XLqfBcj
 avOLgdcQNGWXfU+O8a27QLPEAAE4Zu0J6zRoanS4Uug==
X-Gm-Gg: ASbGncu3JuT9NBikB/FC1B7LqhwKLJN7nFYNBX5QxsFaIR4UB6RkCLpf6hrc+rQiF6b
 FoeZpaCAORKZgsI5udW4Rzj1Xl/jnz1kWUbWnTXUYBJ//+mJ6rONd5A17MEw7nvW/NcoMN4EyxU
 Y3qqiebybnd/dap8gSBXF6VobyPFqjoc8SrJtLuea/UzklOYEMZcixrWQmjWwt701g7xczNHZEj
 Kg5u93Q
X-Google-Smtp-Source: AGHT+IEfm2KQDWdqxZ7z+IqxY8rSP0vZ+tVApEhPl12Lbi7n0KccdOMXDwBGFAgyJste07YVS4KAYx0szqMkQvis0KU=
X-Received: by 2002:a05:690c:4a0a:b0:70e:2cba:868c with SMTP id
 00721157ae682-717d5bc3e39mr57040937b3.11.1752236234328; Fri, 11 Jul 2025
 05:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250704132439.25743-1-philmd@linaro.org>
 <20250704132439.25743-3-philmd@linaro.org>
 <CAFEAcA8e4jcoBup890sjNFmOkSJqCdC4JpDJT1H_OZS6n6=xhg@mail.gmail.com>
 <9a4e5e05-f96c-4e8f-8b8a-a5480267e789@linaro.org>
In-Reply-To: <9a4e5e05-f96c-4e8f-8b8a-a5480267e789@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jul 2025 13:17:02 +0100
X-Gm-Features: Ac12FXx8-0H-nGPzTAGroBRxl9fTYS3kHmff13CnOTSQCXXEXZ5ObeBRCGYK5Bs
Message-ID: <CAFEAcA82HR8TPdjQNwyFgdj4GExRLFK0h4pBBMPoUYh_Kn0_Bg@mail.gmail.com>
Subject: Re: [PULL v2 09/36] accel/tcg: Unregister the RCU before exiting RR
 thread
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Fri, 11 Jul 2025 at 11:45, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 10/7/25 16:33, Peter Maydell wrote:
> > This has reintroduced CID 1547782 (unreachable code).
> >
> > We can't get to this point, so why are we trying to call a
> > function here ? This is not a place where the thread can exit.
>
> The goal is to unify accelerators vcpu thread logic and
> eventually remove AccelOpsClass::create_vcpu_thread(), superseded
> by AccelOpsClass::cpu_thread_routine(). I couldn't finish RR for
> 10.1 but squeezed this patch in. Let's revert it, and I'll
> re-commit it later.

When you do have a need for it, note that rcu_unregister_thread()
is probably not the only call you need here -- see commit
da7510b720591. We used to also have an equally unreachable
rcu_remove_force_rcu_notifier() call.

thanks
-- PMM

