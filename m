Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B958ECF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 17:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlxP-0000jC-Av; Fri, 04 Oct 2024 13:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swlxL-0000eC-JV
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 13:19:07 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swlxK-0002Zq-3X
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 13:19:07 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c8784e3bc8so3027422a12.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 10:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728062344; x=1728667144; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRRtFUUt1Nwga/XyzX7IsYAsDRqRcwBi6s4hI5EmbYs=;
 b=nxymdMAD4eg2LOzx1UHX38sfwm16d2eUSbYXpy2GbL77hbgmMoUUDUH0czbyvmB2lk
 uvIhsf/ubRXPlsA0agRGCB4k3/VafZnOiR9JRSG9NpmTGWzriNgw/nKtoP17NPiY7CiS
 9hNhsBurB/fw/VlfiTOvaB4+5cWG5l4JDKLZlNEtmKUQi3BvXcaktHNNxnuh+W3ijGbB
 SmlKXMr+h11H45GBCfjc1WL0mW+fQ3Bk+lveU6oIB3CFVbRSBhggoPogGdNOnMARjFZ8
 xmQFugEW5v8qbFvC9aHTSmIKCK5hg2YwjP9suOu440k8Mlkwp9h7aYUo0BQi8W7IM0zx
 EKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728062344; x=1728667144;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRRtFUUt1Nwga/XyzX7IsYAsDRqRcwBi6s4hI5EmbYs=;
 b=cA/wly7o3E7paZVAvcuqSi202x49fQQMseVVl02JZzAEciAW5nREfmVNwNUf9+t23P
 sGcwB8Qq6JC+N65uliF38q9NP//nOB3UBjk6IxJ9aGDEP9xrJwOPdcA2JxlmDo8RQLVQ
 wFVO3ltHeao6HwlC4qMYA5GvW66kN6QgRRPasVpsHd/dloH840RD2HkDhDbcv9D/S518
 p4vBw9PmQlSHvH7Fe51Bo6g32VqS9DF8gvjvTooIDldvBcONGTQP2U/0aNxHhI/glqY5
 zkEYBimDuP1BmDRvYjrUi0U4kDIDa8lWmPS1ESfj0V5JMMB71pAuxgl3j7xzBJTJIPKc
 UIig==
X-Gm-Message-State: AOJu0YxT1I+QqsodvWyj7Vee4iw3g++BatmyI9AqXtnEDx+49dDYH1kY
 KHBiZH2FimWOnGVqL6WQ0UIzzDV5FuwZS5s5Vum1KTn3tQg0KhNv7rH0CAY0hbmg184s8pLc8TJ
 XwWvS9jynwVNPKL5y78aSmLKm2b8Jp/njqwsMqg==
X-Google-Smtp-Source: AGHT+IHrdGYxTzeymTamDAGpYSpUrzsEwd6+HL5qlGHFnB1/dAdovATJulKkvfbQ8xvsXyW9WAx/llO0lyNBWdK4pyA=
X-Received: by 2002:a05:6402:4312:b0:5c8:bb09:ae49 with SMTP id
 4fb4d7f45d1cf-5c8d2e24f38mr2838620a12.8.1728062343780; Fri, 04 Oct 2024
 10:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240903215309.32111-1-philmd@linaro.org>
In-Reply-To: <20240903215309.32111-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2024 18:18:52 +0100
Message-ID: <CAFEAcA8LVx03N8bp05oymus7_ZnvXn5i=dR7H=CA10n8nQCv=A@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/omap1: Remove unused omap_uwire_attach() method
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 3 Sept 2024 at 22:53, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The recently removed 'cheetah' machine was the single user
> of the omap_uwire_attach() method. Remove it altogether with
> the uWireSlave structure. Replace the send/receive callbacks
> by Unimplemented logging.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Based-on: <20240903160751.4100218-1-peter.maydell@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

