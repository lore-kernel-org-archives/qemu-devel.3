Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F144FCD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 21:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRdHN-0001pp-0x; Mon, 25 May 2026 17:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRdHK-0001h2-Hw
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:56:06 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRdHJ-00070f-0n
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:56:06 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5aa0cf8bca3so9035601e87.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 14:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779746163; cv=none;
 d=google.com; s=arc-20240605;
 b=klnvJCqXF34QTuABGantIp+2xnBcEQvcSujRD9hZqLwIaxPXsK88rNak/xFE/Nevt7
 og6VvEJ+gnC9/N51fgpYbsM9Qjpf9fiNyi12zDa6jR5YLHi+bSXiiFtEh3uD1+56VZ1a
 xeSSvSDqD6N0teAJ1sjxbiDAz9KvBA1PTPwJ+dccqtb6+9j+a1WPxk8sMWKcVFNiejaN
 okr+z9i4iP17jSDSifjHJC6dKCYF6xhxatUyD92nf2VOw8S0UYj3qOSM9iFrmDTrKXI/
 LL/eoYhSPW6aNq6cYWY+AiO5epImBfc/mWV/jtIe63fDTUP5L451f3s1LDA8aCkoGQcU
 s9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ksq63zSIQ3RIqP358THIgGB23rYSmau+eqseG/SmP2g=;
 fh=VDGqiENZLmjMFMZWY1xbVB15zxWtxE1H+z48zMSi81E=;
 b=hSFpGJzuWnoMwp1XSID21ChhGQZqVUD4Y9fgDrLu1vMOCkapEkjQowimYz9Ju0/PEh
 c4QjNlIhLmracTpBxVXpGnkG8IYrCDBEZ7Ua+nx7Yse7LZu8MT11Tite/Da3q2lbvIvS
 qJ0iJBaw6GyvFtEdDlXW81Tlbm94d/jCawC+I6l4Yrop96vl2pPBY0RBTtgOWsiQBqnI
 KEZOzVBlNiJUY832vtE4iqvcDy2wTyBaUW4jC3eqqmh0Mgivm7h5r0sKbLSETXYBBD1M
 nhoGKnFMko1GrxTEUp9y/Dk3b4scA1LEOIk1iY39kNrVJeXQ4rMVSSycLfeHvC24nY3j
 k48Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779746163; x=1780350963; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ksq63zSIQ3RIqP358THIgGB23rYSmau+eqseG/SmP2g=;
 b=bivdsE+cQRUb2WkDSjTWmaAc3iSRErTDu6goLuwG/Voydx/W4IRiBn3kuTwtxQqRTu
 u5rdt2RBX52OoXlLVniHdDovjG+KepJlY+CCCpT0ft8WzJpvbM9LzrVLSHUtrVIFcwsF
 0uatOQSeYo/osItxiqHShJzlsGrby4f95342IpLAuPn0LmsAOANcXwC9lCTvevpDigpf
 eOWW6TjxdfwABCngfR3HHo9C9tDD23MmHI0KW/K7usHEehN0uu4HLBOEf7ut0M1qboso
 ysfpkDhYx5rRiADXfAllvFgQlcYTwcDR9JEPjoEuI4C8NfF7Bh6LT73FQ7XyuYY/pBt/
 aF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779746163; x=1780350963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ksq63zSIQ3RIqP358THIgGB23rYSmau+eqseG/SmP2g=;
 b=EBg2aDxFLNu4eh3HtwMLxcoy2pTCo8N2MT+bZFJy+kgrH4ehcVz++4m1yWfbx3CG+s
 FDudMed4vI3FoAviBgaL3HNksVWaNxoZA2jL9SbhJmYNvcf7EtHbxvUzifIWlfIesYaB
 dIEncC+ZyuDVf29gB03kLXZT+16gp9GcGTEfSN8uckpuoJJEw3KLpPp086erTrWJ0xBc
 Lk4cQiNS4UbfGVVZN98Kc0tNxxKPFBnD8MCFQSc5p4VRmxczgguLAJiYNe1KB33/xCN/
 dN+pnyMaDAIXD1n/Lg1HwvfPfXgpV8LXsLoWIXcQJxMLs5sZDjDog+Qo9adLw2XtO3yc
 isdg==
X-Gm-Message-State: AOJu0Yx3AGLl4c94c0yrxBkt/57QbJZmSjJkj76wFqKNRFVmffgUhJ74
 5JJfKYo3YwudVrzL0RBY6kWsCh3OMJQ4TxF+MzCPuGRMkEf5Mrzz4mo4DqUc1vl0O77wPc5GXBI
 QKB7isO27ushg65POIT1NTWGz0fYUZrD1iYwd2m0=
X-Gm-Gg: Acq92OGK1ororeHYk+mKihAKprzI0mos6P20r51t9xiw3uPnzGZipaO0VsFe3T531r2
 sFqMB+eyqx4FKBEU5ZtX59m3UW3lmsLrrVym09GZoj8IIvRNtZd77SENTfUxOxqk6GW/35XO2xB
 HFiifAiFDzKlRtksAAmyBwdq/tIUKjgEQRWzQm/KXah3HLNAl0Kko/CtECC3WqcfaRnEM1Ko87U
 0VTrRSFGelv1FtxWWpKa3so2cwzg88uAOafyAv1ONmPZAIiR10I4YPlIW7CddGn9igZfX5wts5y
 M6IiAzktpAkD9GNGdFw5
X-Received: by 2002:ac2:4552:0:b0:5a8:fbe1:15a3 with SMTP id
 2adb3069b0e04-5aa323cf57fmr3498477e87.39.1779746162988; Mon, 25 May 2026
 14:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260525152642.4121729-1-mattst88@gmail.com>
 <20260525152642.4121729-2-mattst88@gmail.com>
In-Reply-To: <20260525152642.4121729-2-mattst88@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 25 May 2026 17:55:49 -0400
X-Gm-Features: AVHnY4Jtj6TQucLETXkwHVX2xKYKw4WbLhFhW_siI0b4GJprUNa2aVa8TqpcJic
Message-ID: <CAEdQ38GK+X-cEOyafXz8spOzS2ZCi1OqD3XU8gsrtE=0Ho5y=w@mail.gmail.com>
Subject: Re: [PATCH 2/3] linux-user/sh4: restore FP rounding mode on sigreturn
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, May 25, 2026 at 11:26=E2=80=AFAM Matt Turner <mattst88@gmail.com> w=
rote:
>
> The SH4 FPSCR rounding-mode (RM) and denormal (DN) bits are not held
> only in env->fpscr: they are also reflected into the derived
> env->fp_status via set_float_rounding_mode()/set_flush_to_zero(). The
> guest keeps the two in sync by routing every write to FPSCR through
> helper_ld_fpscr().
>
> restore_sigcontext() wrote the saved value straight into env->fpscr and
> never touched env->fp_status, so on sigreturn the interrupted code
> resumed with whatever FP rounding mode and flush-to-zero setting the
> signal handler last installed. (regs->flags =3D 0 forces the FR/SZ/PR TB
> flags to be recomputed, but fp_status is runtime float state, not a TB
> flag, so it was left stale.) This is the FP analogue of the T/M/Q bit
> problem just fixed for the integer status register.
>
> Factor the FPSCR -> fp_status synchronisation out of helper_ld_fpscr()
> into cpu_load_fpscr() and use it from restore_sigcontext() so the
> rounding mode round-trips correctly across signal delivery.
>
> Fixes: c3b5bc8ab3 ("SH4: Signal handling for the user space emulator, by =
Magnus Damm.")
> Cc: qemu-stable@nongnu.org
> ---

Signed-off-by: Matt Turner <mattst88@gmail.com>

