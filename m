Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA58CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 18:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waHaR-0003n8-CO; Thu, 18 Jun 2026 14:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waHaB-0003g3-6d
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 14:35:26 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waHa7-0005be-Ax
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 14:35:18 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-662b76dabfcso1647615d50.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 11:35:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781807710; cv=none;
 d=google.com; s=arc-20240605;
 b=SXk0mwTI5ZBoS7hOafRMgjo8YvsFXt7SY2PouKTcKp9swzb9DESUnp8+RRGB7ZTeb8
 P0WxTxTJDiApPOcDImysY/P62UK/2kv4UPDEcEVELhX3i1b8CAkC6ZQH7NknmQ1bub0/
 WBBOSgwLFavuK51C+e7Gsbs0o/ofj/au+zJ6HwxuswkwkQZ9D1RRCFcfAq1CFtSDGOnI
 eGI0nqkBqMxHEqgYIaYTQL6u6GHudflsPQdmbKvUan7hdMKroCXm3G4I/x1wLWRzPTlw
 NrvUTYdM7s/xKOjcVF++0ld99OXnxsTx5tqr9jlJKz0pby8U/HeDfMxULsmhGja92tn6
 9atg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JxA6t9TDQs+wJG9I07O2lg8Gh1zoBJRvDWqNrILd7+g=;
 fh=BpvX1m7Cobxv3/01HZRfu6blDsTvPE0KPNQ6OudVgOw=;
 b=UhGYDH11dHi+WXN90fadAqO49+7FSMPrkoQC69mI+Y6fA0NCV0t5HwU5a6BQapW8Yo
 LoqDeUm3AafR0lH9gxaufNjktHNCIqYhjZkiAbnFyjW99GvcZxXw52vaRr0SjX19Tfhv
 Lx9CJmKadZm6UE/kDPoVTJ/T6pZ9N2T5JALsBh4DAcuIeE3SrJgc3/SCm1gf7B14zXfg
 LAT/8poRiCx/fozYwLeRh1PjudWN4UkMwXpwVr9X3W9a76KLDpELj4gPiPPwgJ9iT2fi
 j/VSUOEUXCclNu8mW9DxZI8vL2gDZgg9QViKofXPy5VLQ9VJNuLg4y0T4av1Ub27GfiV
 99xQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781807710; x=1782412510; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JxA6t9TDQs+wJG9I07O2lg8Gh1zoBJRvDWqNrILd7+g=;
 b=BsDWASvAECoDuVTH+3M8hdC3fR/SoyI1RFe1omacDUjAHELMLJeZ6Nkn3kCi4a4VIT
 Qv9V4St8SVaIn/psDQcPBgfmMeIvxxfHbSVfTjWSce6E+motpPTV9fZgupRvGxQQAyCe
 fPbO65OEjkVKBxEO/ioheQt+EKBXrGuUyvmFjmzw9ZSIK2iUgUx1seA3Lzrp8VfJRmhZ
 SeKBgHnmTKiU1jaJ918vynj2S8DmXtcGIkEGMAV4kK0njXl51wlhli/dCYZ9h3Ej5UO0
 VJf4Oif50YRzwtph8wlwGdyZnak5KjU8lNa7AqJPc5dALtsfVSQ6+BDPWUd7jrP/M2uy
 5sMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781807710; x=1782412510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxA6t9TDQs+wJG9I07O2lg8Gh1zoBJRvDWqNrILd7+g=;
 b=MQ3YBr3iVrCbtacVSPdkLNpByKNeSz+IUn8fdViyzSDJk6JZXZrfTwh198DwCjjtIT
 tH8wwD13jZZcNMZgXGsjy1L98QAkyJ7ilZHjSdKZv+fyqLQTJI0O65QydvnzzZSCsn2q
 S3LO1NkKPKyk1qdfyStMNIB1x7OdcyrF+FlU0LMqe7cMtL2dkOfx8BK6dWMcMrxF61T8
 usLYJCcml6oNe3IRPJ3m3rYarhCzzBR/1zzVdJhZTfwWjariOhFWOxMDEQRYnFz8ThzU
 9hCGxXEsjBmC7z8dOSB/OWdybTY9YjVYyhoNMfHf2FtmlCA1ZuPtC6Vj4vW073NdT9YH
 JBnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9EH0ntEfX8aBEXB3WQpcJ+o1YHhSHdZdO8quwkWWDKPjI3+K+GhaoYAyL1Xr449kaGSOJXTQ5p6LTu@nongnu.org
X-Gm-Message-State: AOJu0YybAiOtARJcxZxZYI5ZgFLze+fzzxDsSIvo2U8iL4xNUNcO1RgA
 poRR2IQq6bem5OC0hsd/0PF7BAqHewMlyoO+ICioFpHW3iNH8n/UU88hxveiHdAVysJ//9V7bPE
 f11IFezVmxf0t+hbhoIqqUnVWxVI4nhezIL0VdWtdag==
X-Gm-Gg: AfdE7ckpXpxODaLpjMpuWHSfcYLX5dB8dje5XbdYgY/pf3Qs/+JkZlplVzDlbTEJWs1
 DlAM4Fx8JZN2bkrghtcRooY79kop7QI38ypN4vm3AZM5OxK0KjxUq08W1tJrRD7ZXmNEjJju7gC
 XvOWj/MkMc6WEEeIFqjGZYnz5nXQckEnHdviW5fYeKlnWXbCZtZS7XB5viN9b9EuX8MbgklaWHa
 vIaURxrfeOTlDm4VMJNKJdKh9o1FJ0ju8VK7rTc0BrUBADAlpT6gTPdFPdiGyJCGyrzr0D3atIq
 XOHb9aJFoBnUPjBUm5FXwGPWugdZRkpiM4IzXEI5IM5BpFDe+30ppY9O
X-Received: by 2002:a05:690e:43d3:b0:65d:7e2c:cbe0 with SMTP id
 956f58d0204a3-662fccbf847mr758397d50.55.1781807710192; Thu, 18 Jun 2026
 11:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260618082623.345255-1-th.huth@posteo.eu>
 <20260618175353.GA748600@fedora>
In-Reply-To: <20260618175353.GA748600@fedora>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2026 19:34:58 +0100
X-Gm-Features: AVVi8CeMZbU-1U_rhKyiY0igRiOmSYieQEyLywpWt1WuYkbWr4p3qo4upklxvgI
Message-ID: <CAFEAcA93R4UXit4UNLf36RXS3k4MaBWOXwqP8rNFzC47B_wAoA@mail.gmail.com>
Subject: Re: [PULL SUBSYSTEM pseries 0/1] pseries: Update SLOF firmware image
 to release 20260618
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <th.huth@posteo.eu>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Thu, 18 Jun 2026 at 18:54, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

"PULL SUBSYSTEM" pullreqs are our marker for the oddball ones
that are for a subsystem maintainer, not direct application to
master. It also says "not for master" in the cover letter.

cf: https://www.qemu.org/docs/master/devel/submitting-a-pull-request.html
(last bullet point)

FWIW, my gmail filter for pull requests is
  "for you to fetch changes up to" list:(qemu-devel.nongnu.org) -{"not
for master" "PULL SUBSYSTEM"}

thanks
-- PMM

