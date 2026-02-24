Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1676CF3C9AE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuvEW-0003Q6-Hd; Tue, 24 Feb 2026 11:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvEQ-0003NW-9S
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:25:54 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvEL-0005hi-L3
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:25:54 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-65a3fdeb7d9so8223917a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 08:25:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771950334; cv=none;
 d=google.com; s=arc-20240605;
 b=OAmHwRJ//aw4anpnVe0sonEfTZU8hDPk+KQiE4Nq4TC6VaePx0cHpyNvUo7Sw7jJmf
 Xo/nyEVhP1C9ZZr8LDoybwqtro35415TVHfBKMtq1O9O66KWt3AVNq89LfuShps5vrMT
 w7rk08lsBgndkMSLDrrl0BUlRrPL4Jl1fTcUNvyYFKioKdXjY1zCriaFT37fk4Thac5R
 9ibLLrL/Re26nYZ+4bCM48gFVkgQj7F2HldPu3Sa9GuLVRKwD8YdmP5+TMtM5TVFKgNE
 aFU1x5DMvUyCnSub82bsIjcLkXODvMjA7yfufdy7muouCZ/Pms/a5I8hiv8QQXmUWfDv
 55lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LlaW/iLqxXy1/nsGtsTdVe3Q5EDwrQub1KATZa42W8g=;
 fh=n/8mMVuQZuyVRDJW+LueEnhpKNaPMaAFCWC2XkeQkuA=;
 b=Y6ziKu/+OTgMAqrGbBCz5c30eF9Rfygb8hDaBOvyfApOtJITVhhDEiGDPJ3AAuVFxP
 xYZaScjIbgnD4uYvrfoinvg6TmZysKKtczpTUc3874s4b4lwmqQT7R0/LzMzvy4DdXNe
 eA5xtiy6SFaqn/wOsxIR5aW1N8z/MBHDvKM2VeLBHlCTYnHAnxPFWntAXHQo3NBMme6U
 7NhQ3P84CmKqw8zPC6qD9CXG8sDilP7dcAikdpHoGDXXpUIatB72CoYUKwLcM5XEbPRA
 WKmxDFP7Y/XA39I2ltxiRMeAXiBEnRUN/lqvkmEGVZm5AZBuUunztuDAkzhChFjSTG8O
 M1Dw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771950334; x=1772555134; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LlaW/iLqxXy1/nsGtsTdVe3Q5EDwrQub1KATZa42W8g=;
 b=DBwGIgmnrBHPGTHeRUFGv/rf86kqBLSgQxRiSa0EX8jCYtwJMoc7WiGwiWBV1myXtm
 PRCGYUCelUKMhSUqGZl04onboXR6Hv6WLV0bUKunUq5hY0JSSVN/rS3iHteq8bp/+VeQ
 yaoRXxlPr1pGMQZCe+hltiuMQfyUHNuOgP24vKGxEYFqqTle85vUTXa875B+BvEOCoSV
 u2bcVGu1OMn8Wp9rDPUrnFcbQ/R6CHZy8S3aeGl9IrGLmnPTtmD9P04DmBNwWWTtORRZ
 x9Ds4JqZRZeiWEP2oIC2xJ5c/tBR/Y55XI/lP6hZBisUBDXxVSBWtWY6kSn4B/thCLM9
 unxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771950334; x=1772555134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LlaW/iLqxXy1/nsGtsTdVe3Q5EDwrQub1KATZa42W8g=;
 b=C4rVMDrBfWpExfSW+Sv34L3txfCrKoYddNtqzsl1Q0XWAGeNz0WGMYdM21MEl5NVGh
 NGnJtGr+IxjlZ4Vl4Wg+L4slD71x9nRUwghTUaRroxTok5FAswN8MlmUQIwpsZ0NZxSM
 fYm1AdrMr1xevC5qWrAaXqOmt4v0Tp6HopDKViNtqNa5ayC6Mcvm8i6m46Vc5Fj4IfOz
 bS5+QTfBP6w0zuCO+D0bGYViTBwxPh+pZbJd2b1N+Ci5y7xXB+iAdOPib3mzTTnfXVVd
 U1iaSC8Vlv4MaX7EC07R2rg14TaHWRoNGbNZU2LOY4a9YQhIyHPwPvrQurjiys6Dt6c6
 uDSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs4Snm1i+HoGNn1I3d8bw9Iyy9N4Nvk7dQALN/yzoa4AY05KSRT6p7/UgiZs8Qmn1za66YFNJrV0LB@nongnu.org
X-Gm-Message-State: AOJu0YxiYzzrTT3DxwWVj5MCNxaZnoIHvCr+PlBEmDD2W48rug3/11Vh
 ned+Cf1noLTPFKWyKeRR4DKirvAwP0Zb24WALGVlBunh4I5uoa+jzocKZ/WSuhqUqujkxFcGQHu
 42C7r1yg34YjrSPqPZ7YD2+ch62NDP/o7DXGn/lu1sA==
X-Gm-Gg: ATEYQzxrKOwGqpNm1j14j8OfYEehpEtunkTb342ur5sbWEuk9zNQInfxUn1he7pJJfu
 S+vXRHJY0hHBf3qjyM0dWp5OLOTxjIgFcknjEXVZDSva1SxDNErjNuM/ewPqZyLGNcaD6SGOhVF
 cjm/kZL0zEkE7aap0S57dVYiKAUrUnTv1iloiQtJM3SnI6QQgBPZuiiiTkWNE6qUGlmfbUqDcsv
 bbBGTFE4e01+GNaYAI89qtZMlp/JC16NmQCKhP0IScqHrYe++1xTNOG83q++fuFQMBvsf+bhR2u
 KleSz2ALxsn1z3FZ92DhUQQxJGcHw74qp5WDRcKSV2fJpnBlR1nhOCfORgbogA1FafT+9YtYf1w
 QKg==
X-Received: by 2002:a17:907:a43:b0:b83:b7c5:de2c with SMTP id
 a640c23a62f3a-b9081986379mr832729366b.10.1771950333833; Tue, 24 Feb 2026
 08:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20260202133353.2231685-1-peter.maydell@linaro.org>
 <20260202133353.2231685-6-peter.maydell@linaro.org>
 <7ffe8bf6-bd94-4f7f-aa77-274c90d1aa78@tls.msk.ru>
In-Reply-To: <7ffe8bf6-bd94-4f7f-aa77-274c90d1aa78@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 16:25:20 +0000
X-Gm-Features: AaiRm53MUn7Csb7YhgFkm-SftTRUdbqnL2h_ooGFYYKbzTkT98toSs7lqnz_6xg
Message-ID: <CAFEAcA-iqQnwYnKR3BLE7VO0iAOSOjcOWADFw7XGu9kLB-f8Tw@mail.gmail.com>
Subject: Re: [PATCH v3 05/15] target/arm: Don't let 'sme=on' downgrade SME
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Sat, 21 Feb 2026 at 07:19, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 02.02.2026 16:33, Peter Maydell wrote:
> > In our handling of the boolean 'sme' CPU property, we write this 0/1
> > value directly to ID_AA64PFR1_EL1.SME.  This worked when the only
> > valid values in that field were 0 (for no SME) and 1 (for SME1).
> > However, with the addition of SME2 the SME field can now also read 2.
> > This means that "-cpu max,sme=on" will result in an inconsistent set
> > of ID registers, where ID_AA64PFR1_EL1.SME claims SME1 but
> > ID_AA64SMFR0_EL1.SMEver claims SME2p1.  This isn't a valid thing to
> > report, and confuses Linux into reporting SME2 to userspace but not
> > actually enabling userspace access for it.
> >
> > Fix this bug by having arm_cpu_sme_finalize() fix up the
> > ID_AA64PFR1_EL1.SME field to match ID_AA64SMFR0.SMEver.  This means
> > the "sme" property's semantics are "off" for "no SME" and "on" for
> > "enable at whatever the default SME version this CPU provides is".
> >
> > Update the documentation to clarify what 'sve=on' and 'sme=on' do.
> > (We don't have the equivalent bug for 'sve=on' because
> > ID_AA64PFR0_EL1.SVE only has 0 and 1 as valid values, but the
> > semantics of the property are the same.)
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Hi!
>
> I suppose this change makes sense for 10.0.x (LTS) series to.  There,
> since it lacks idregs conversion which happened during 10.1 development
> cycle, I had to adjust the change.
>
> The result is at
> https://gitlab.com/mjt0k/qemu/-/commit/3c1f1b8065c625040787c2c89d22d5602100aeb4
> (I kept original code fragments - using idregs - in comments).
>
> Please let me know if I should've done something different here, for
> example not picking up this change for 10.0.x :)

Thanks for the ping -- there's nothing technically wrong with your
backport and it would be harmless to have it in 10.0.x, but the
support for the SME2 feature that makes "just write 0" become a bug
only went in from the 10.1 release, so we don't need to backport
the fix any further back than that.

thanks
-- PMM

