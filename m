Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AF5CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWcWZ-0004zY-Ki; Mon, 08 Jun 2026 12:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcWV-0004z6-LB
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:08:24 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcWU-0007UA-3a
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:08:23 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bed2b9bfa02so611316466b.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 09:08:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780934900; cv=none;
 d=google.com; s=arc-20240605;
 b=kgg9i/1mqpYmVhn9cz8Z0qb48TxNEh+tNSVmJwwt7nwED3zuSNyz7i5lUQbcXN8QfM
 LNlknoXVjXjjpBjCToZBgC8zHKv3+qIBQXdtxSFGhIrb5pKH3A5Ffckcr993WjVL43Wq
 /Q7Ab6llPFzQ/t9sw/Gk420ZtkLRyEkhnU1ZM8WhIOUh80YaZrB8itlJXtxnfFOS9S9g
 x/umIqK6bosVYNTuoHMEFyx/UTn37TlLiD+qhe1ES/KXMuvqBX6n2HX0PFG8+XMSeE4Z
 FJmjT9r63S9gA7RIF4Ka2XhzsYz3GovOCANiRbeRXSLDGGJ1I90oAHpw5Y8ifYlRdgI8
 xi+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JviVQiNcyfBKKTJ9X+lnH18j4+CiFFtHjwWqorA4zLw=;
 fh=F8TB8zHciHT63HpcYYSLckSvVVJwGMtcKH4uTYU8jy0=;
 b=Qh4ifbEqSUUevcmvemqYlKyM2ICh2ZTKXKYjgJc/Hpt4FZ4G6qpzhemgGp7DWUXxKe
 lMON4sL40qQX6OOOl2PnpPlqtX2CjQU7XqLaSykLRZFqB/UX0YfOfOsZs1963LplPjZ7
 4GLvE8oFFWxcY3IbgozOkEWsjR0Wjkoa7EwEmDIw+NV7msurFGo31ZfZ9vae4Y/hInRG
 e21H0X2vqFngpDiagvKgexb1l3E5WV3/HTbBGKHvDv+WwWets6Rry9h7T78MeNyCm2Xx
 sXDSfNQmdS2wqnpDxPN68k27uju1CwVDclMhp6yDC7At8EGCWG/EvgVp/aHl2RKpPTDv
 MhzA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780934900; x=1781539700; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JviVQiNcyfBKKTJ9X+lnH18j4+CiFFtHjwWqorA4zLw=;
 b=Jqxo/oUGvJqgdasQAWVPVyN+/jUFi+Gyy/7XdKC2O1hPG8+hmqz3kUNvXNM7w8yIqe
 DclUJwgVhmGWaBkO3SYTwp0Tn1/GsEPtxa+VqEdca+rzlgwwGRwWp3NLWWhRdDbZaAY/
 5hyJFKflKWQtp+h1o95KDkBZCCcT4UnHggt6aq44l+55LZKbRijHua6tLdjQFzko43wP
 c1r0Cr8wWJvF8J2+WggzcUKDHxnbKf4SjSp+qhlRWGdzt8en6rlIxMdAXGIgcBfYNGFd
 qH+4zGnuDfAmTH2N5SSumCJQKUCqHwNj451jGi5EEKTCSqeJdi3iVD3jSe7h/VjKGsFI
 URUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780934900; x=1781539700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JviVQiNcyfBKKTJ9X+lnH18j4+CiFFtHjwWqorA4zLw=;
 b=NU2We7+1stfnWepgPQKEa2ycT9va/lJQ1oVzPiOirAcpRNAL8RLa7Zjar6irtSDsN8
 /eY6VwzVtRLYi1GFD1QDLqa+9wPwQpU0BOP3x65I7SUpNtF5S2HnvKrC453yrvnIgJ5U
 lS2deD1ixQ8dC9y3RFt5jExAFC6kDkb/r6xq6J2sQ1wZa5tmJaphs0Un1au40FzCneSE
 boKhI9+DQCj9UK6P5ThGopzdwjqvrijim3VdoZEM6gsQJFlhY5igqUXu1ViY733697xl
 P7cEV11rA8kGgdJyMt8RcrL9dyk8xZRXAcG08WnXutHCSCNeYf7DQeUtGtF2q396s96d
 //ig==
X-Forwarded-Encrypted: i=1;
 AFNElJ9j3xjt6u54E0DHaBzruvQZ6WJ3Y2pHmZ2wuaO92xUfHQpAiwJxuhpmHlQJbBYwtbPecZJTLV6iDQhm@nongnu.org
X-Gm-Message-State: AOJu0YxGrQigrE0jOCArpxvE2pdEx5z3HTU7+S+ksq2ZlDm1tcwL94dj
 vE2PxkMkmDHABTHS2z1kZGbu6hhM8ib+YR+/+ooKzz0SBbvEyCtjEj4KskLDrzRNgdAXEd9ZU/c
 6w+v2cLh+/qRoFw0TfmgAyUhpR3MO+UmbeAoy04doGA==
X-Gm-Gg: Acq92OG//OQJVPN1WiTrxwNWgGWjbBPR0TvAwxzotHz7UycdnuT5+XwA6mlL4J5UTpb
 hcUI7skKd41/WBbv66++yhjJ2lNCncooHifzLeQYY9sMzipwH04z0V140AFS+TMqrKToWpA8viV
 XNk5pNBD1CQ7V2SQN0OyIT6o8S8F08e7X0dLx+G4ITvghfsy/4/D12k1/hlhYPlon9nPnQn/FQc
 3HnaONqf9e2PIct4QW3qmnT5kI59MLx2yIt/mgA8Ho6qKZe/fcrKxhexaJq4/dWu2XvhVLAnGIT
 GV33j1rvw/82CqDpWF7pM9VJdyWp9gZw+e76GjR4IBXzyUkRK7FluAJda3HEQYouzeuZ2ipo3FL
 I9LVKo+s1Rr7P
X-Received: by 2002:a17:907:a0d1:b0:bec:fa92:d370 with SMTP id
 a640c23a62f3a-bf373ee4f1fmr836333566b.33.1780934899498; Mon, 08 Jun 2026
 09:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-testing-macos-v1-1-42774498936f@meta.com>
 <CAFEAcA-aNmOmjhbVypCLpDVowTeSK-28aaY5X0jqRe32qmkqUQ@mail.gmail.com>
 <aibhMPHu6nbBT3Yi@redhat.com>
 <CAFEAcA98r4DxQbB+yiWKqnTGSzps+GGQ3gxFPLogBGTXY77jXQ@mail.gmail.com>
 <CAMdbysh2-mjxmWZcfDw53UbJd0keBtTgO_gnGc6pPMzv3GOPDw@mail.gmail.com>
In-Reply-To: <CAMdbysh2-mjxmWZcfDw53UbJd0keBtTgO_gnGc6pPMzv3GOPDw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 17:08:04 +0100
X-Gm-Features: AVVi8CfLW4QgxX-WzxPhpXCDVlLiG2UQv4yfMo5J7Xkonlm_JeH1j_tQrMdF-xE
Message-ID: <CAFEAcA_WtRMz93Y7CrGW0PDTzoA+jXtY-4e0AgYXemCe4GG6RQ@mail.gmail.com>
Subject: Re: [PATCH] tests: strip macOS "-unsigned" suffix from binary name
To: Emmanuel Blot <eblot@meta.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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

On Mon, 8 Jun 2026 at 16:57, Emmanuel Blot <eblot@meta.com> wrote:
>
> Ok thanks, got it.
>
> I need to use `ninja -C build qemy-system-arm` to generate the signed
> binary, because the default target only generates the `-unsigned`
> version (I guess this is the linker's default output, macOS requires
> an extra signing step).
> The signed version is defined as an on-demand command which is not
> part of the default build (`all`).

Right, this is the bug that needs fixing. The default target should
build the signed binary.

-- PMM

