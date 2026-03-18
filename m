Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62085103E177
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 13:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2qxS-00023Y-Ld; Wed, 18 Mar 2026 09:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2qvK-0000hZ-TF
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 09:27:00 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2qvH-0006AO-MM
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 09:26:56 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64ca9ec3ee7so8386642d50.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 06:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773840414; cv=none;
 d=google.com; s=arc-20240605;
 b=ghhGLDE+gEXscZfcamWUHgjS31+nOvqqJBL/hfwBmn8ouX8Lp6hgdHvk2WIkt7P75J
 W3uTDpzeTJIdEUaPFoGn8Fg67mhJrlUdD/rnmxcs+S0BUeqLRqL2orSuKhLOItHOJGcA
 Mh+X5Y31AOxEOWn4cVYCbv1XzS70dZirpogrZ/WEMKnVHe7iLdbbr6UKHhk4jUb3AmqA
 t//1gPrYTcXbEqFxZGRUEXZaQLkwWOwmhA5EFJ/SzeLmXfn3bcXL2W/WvcCM7ddIDmNV
 Ds5Qtn0kWqO9vWYL6qx2nkb8r2OXGS5gXb14UVzQG8DNyeM6L0TGV/b09bROVBFgYjXo
 C/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TVjhYadQw7kvPzU1W80hVUUvkJE1f/2kKWLVhDW7q/k=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=SKsJ0DGATFezCH19puGNonmATc3OWvQXiU3ZloXhpbKUmirHdOP3eKQhSDg+h5yk6i
 AEZSu4Mp0TQF4Z6f+pRVyKHbtDXUEk5kpQD83g9XBp2RgR3IhrkONytFi6JVibkrr41i
 RPhYP3skrRcvJBmXq8jAyj8xBowCbf7WmP2nsNXkk6rgHpLrirZlEgGVWTtb2Qx36GYl
 dtvN7QttbNdLE2/RNAjfkhitTsg+LCE/qLIpEMI8olZSjzJ3teOVSzzuUALM+0wdPQ7Q
 rHDhGrEkjr/JKzv81Y2I4XidvxaQ9Ddqu4qGnsHCwtyr5/2MHhAmsYvhDpaaIuafB6ao
 P82Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773840414; x=1774445214; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVjhYadQw7kvPzU1W80hVUUvkJE1f/2kKWLVhDW7q/k=;
 b=Zi/GDN2DMntH5gxJwbNoo66Yw7bfFvAkU3KWjVmndyHCtfPeBNVjRFOtbR8flwKmSD
 /lmDn7oy+DnTVM5DGS6zh04e78q9XO9e6VV1xTgy+xwwwzdBC97a5+TlkP/XyA7a/GGL
 UXUhAxx6EUya+L/tHYC3Tr40k1SLj1jJ5WZ5aAcdtna6URHCNDzu6SN+lORKD10d+N84
 fKs3WkzUT/3SAygwiaVVcXvwkwJUKIMQJuzcbavhxrqFLXjrsNP3zG7dLpkUT4MYszbJ
 bri0cZj3/iLs1hJ6VA0P7lWih3zu5Fn7s0yhVodA52iwH93qW4dhSPe5o0xoFb7ORrXT
 6xAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773840414; x=1774445214;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TVjhYadQw7kvPzU1W80hVUUvkJE1f/2kKWLVhDW7q/k=;
 b=QDToiQbMwjoRQ9mpnfzx3gFG4vWZgqDgrWZ38VKEutqu6TZagCZQw7T2gehjFccq+h
 j/XOeCq54oulyxfdLKafrPQHMIjuo8opMsE6peD9wlqVtxnbm7hBO8QBpMhUGmMjpOuX
 98IDacPeI5XM+Bbq3XgEC7Ekpx83NSbNj3IRAIzHgGe+pw0Py1R1VWB9lCLzPHXQMjJw
 jqSBm+Qh7j80iWX/BwP7R8Y5JNB8EtwOlxuKkdYN/nSRNjpSJO9MOEUP/1vuXAjZ8ESX
 nRd7GPdN+JkYcErzKVy/HiqMv56dBX6kjFnMsUC+o96plhsPP6egUMctL4DC0PPugizi
 n92w==
X-Gm-Message-State: AOJu0YytFZM3q+0Coy/lTNUHEDCJtt+pClHKM1KmV5mjFEq1XWuJ2ACE
 bAiR0/OvVkOkQ9D7JjA2Oz4T8bNMnDyEjf5Rrxo5cKjXWvPdQ3vr977wps5g+lp3vtafbZWZayk
 9BJYsOPFleudzEoq9cgZ99m29TZvwQKaO39NyepFvGA==
X-Gm-Gg: ATEYQzx5IgdpTjca7ZQmKZ6DEvQWJdPCr9F+hdiqFKQgi6P5tPK/zUXG9IxF/weJLDL
 22/2Yr7J3Z3V254WUdQONjvKgbZagFuFiaJYDxFbnM1px5qHxb6hh+0ff/VN07JkYIHWKeUo5Mt
 nAEbjHNw/l6eLgAk0XKhUQGWXfzV1hhc5bJOfnGzNePmrG9m+R2/tIywjY0lJQ2FMqR7WcRtTmR
 5/QT11JjpWLP5sjcPPqNxt5j3Th13QX/h2rFnplsOAakvU8WlgCP9sGzhic0waWd7jDwiOfVkvR
 LGoCzZ3D/Amj3oxKhwYYwtCOCcNpmAvC4gxyOGRIaRhIsxbRZQ1apqa8H0Pjo1/C5YA=
X-Received: by 2002:a53:da4a:0:b0:64c:c00b:e771 with SMTP id
 956f58d0204a3-64e915b9e31mr2685533d50.58.1773840414345; Wed, 18 Mar 2026
 06:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260317190250.70506-1-philmd@linaro.org>
In-Reply-To: <20260317190250.70506-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Mar 2026 13:26:42 +0000
X-Gm-Features: AaiRm52qhxgm6WneX07oFzMmeeJrGhBaI_GTWIhSfnZH2m0khertmbjvkwBGQ_Q
Message-ID: <CAFEAcA-Hb9c5PL4p35pHRJe+usyj9bTWVK9OfZVRfj381=zxow@mail.gmail.com>
Subject: Re: [PULL 0/5] Single binary patches for 2026-03-17
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Tue, 17 Mar 2026 at 19:03, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit 6667668e0cf369e47aa9dd0bae40989896e9ed=
9f:
>
>   Merge tag 'pr-plugins-20260316' of https://gitlab.com/pbo-linaro/qemu i=
nto staging (2026-03-17 10:20:30 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/single-binary-20260317
>
> for you to fetch changes up to eda09ccd3e00648bed8b13df465ef15c3c6a7a5d:
>
>   target/ppc: Replace TARGET_PAGE_BITS -> qemu_target_page_bits() (2026-0=
3-17 19:53:17 +0100)
>
> ----------------------------------------------------------------
> Few patches related to single binary effort:
>
> - Build some stub files once
> - Replace TARGET_PAGE_BITS by qemu_target_page_bits()
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

