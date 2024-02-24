Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A30C54E49
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 12:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdrOt-0003mB-47; Sat, 24 Feb 2024 07:45:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdrOm-0003W6-RW
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:45:02 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdrOj-00072r-Cc
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:44:59 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d27184197cso15315071fa.1
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 04:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708778695; x=1709383495; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wVlkatg12yOy5mCz4tZOrfBAEwI0fDtLdyC6x03FHHU=;
 b=rozDzs41tzdxhDa0EDz2qNe6LDhlzITtLTxDeqtuE3r8jhsAodmPYmJFO8rSmgPokH
 eOA3K0WzylwtW57aSHV//jApuMiAB4xmXTyNRhno6HQUOz/nX7wSkXTSXX0YKpu/Ml76
 oMm73qZiZPTaXCq0eC+/JbluqrIY5tc3QlhSB+MJvkX5V3E5N58RINYmENJ5/7k0oDHY
 vnCw5p5HArL1nVVzbJAdaLEvTGbAStmasRkiF8HwIo/4jKcqkbjpSxe/1Z0faWKumcX2
 lSnooYVTYSRnrlzS1oIWwWv9+gcX1b9YVkuZfsgdrTOF1A0FgdHG7UDKS/pJ9WoZqKl7
 4b4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708778695; x=1709383495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wVlkatg12yOy5mCz4tZOrfBAEwI0fDtLdyC6x03FHHU=;
 b=w8qqV1n+rqhkiiA6MzXp3Dfllwhp4A6+jSG0GsJg4VoU0BexgNpaXASqPkIwaDrnyU
 CqTVk4nXoMUO1NMQaIhqhD/RKOzIJukqvbOFRMEl6djheb4lbOjoA1ZP4Ow2L+TK1mXk
 r1TXjRSNOG0VYW2S5xMIHId+e++Y9SbwAqbVgGn8aIo250rw6Fi/2VJPP2SWcTHhKi7v
 uozYekGYkKR2q4sQAYOct5yR1/p/6HWg09m+SCdaR/IPTMevqi4h+JUTufdr+lWcEP18
 jTA/E2zM2zRkzPObJhEt8suRfM5Jor2miwsPTxGZGN6OZcxtqJixjKksnKgRyYvVA+bT
 evKg==
X-Gm-Message-State: AOJu0YyAiRPOKlV9/Wb6d6PkO8O2lFkfZyoJgDcF0zCDf2Zl6Mn4wpGU
 rHJIquD2xVti8SiBv85cazbGwvUKjnRucppn4/JMlHAseUKZqZuP+IUTLR4dCpGcFzKP2kYTDUC
 W4hjjJ4QlZpcPUQZNA6Jmjka2h9JAziQei1W3mA==
X-Google-Smtp-Source: AGHT+IEdwlFnPyhpTwkRsFRDHHV1yY9IJECs+rCGUMoKTlEGVesD4t1fr2Mp1AeC1sAAYcqt2of+gD8iWmUcEi45/5A=
X-Received: by 2002:a2e:a379:0:b0:2d2:3392:8c0b with SMTP id
 i25-20020a2ea379000000b002d233928c0bmr920563ljn.51.1708778695387; Sat, 24 Feb
 2024 04:44:55 -0800 (PST)
MIME-Version: 1.0
References: <20240223154211.1001692-1-npiggin@gmail.com>
In-Reply-To: <20240223154211.1001692-1-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 24 Feb 2024 12:44:44 +0000
Message-ID: <CAFEAcA9bV78ECEmHtxU_+Yz-pP_arJ_EO-abLa7D78+odbj7ig@mail.gmail.com>
Subject: Re: [PULL 00/47] ppc-for-9.0 queue
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 23 Feb 2024 at 15:56, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The following changes since commit 3d54cbf269d63ff1d500b35b2bcf4565ff8ad485:
>
>   Merge tag 'hw-misc-20240222' of https://github.com/philmd/qemu into staging (2024-02-22 15:44:29 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-9.0-20240224
>
> for you to fetch changes up to 4acc505d2236190efea94746e7f22e2c07bce5d6:
>
>   target/ppc: optimise ppcemb_tlb_t flushing (2024-02-23 23:24:43 +1000)
>
> ----------------------------------------------------------------
> Let's try this PR again. Since the previous attempt, I dropped the empty
> already merged pci/raven patch. Also added several missed R-B tags.
>
> A bunch more testing showed up some issues with the new avocado
> tests. FreeBSD artifact URL availability is marginal so dropped that
> for now. ppc_hv_tests.py sometimes hangs due to a bug in console
> interaction so marked it flaky so it's not gated behind the fix for
> that.
>
> * Avocado tests for ppc64 run guests with emulated or nested hypervisor
> * facilities, among other things.  Update ppc64 CPU defaults to Power10.
> * Add a new powernv10-rainier machine to better capture differences
>   between the different Power10 systems.
> * Implement more device models for powernv.
> * 4xx TLB flushing performance and correctness improvements.
> * Correct gdb implementation to access some important SPRs.
> * Misc cleanups and bug fixes.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

