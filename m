Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC46F46139
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4hHv-0000I3-RO; Mon, 23 Mar 2026 11:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4hHt-0000Gx-I9
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:33:53 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4hHs-0004C8-4a
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:33:53 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-79801df3e42so54780367b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 08:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774280031; cv=none;
 d=google.com; s=arc-20240605;
 b=WIUoL1DWars9reWBUU7lQeCaX/M9jTCxTj4q066bpaDe/b7UrXXt8JBp4UcisF/tSy
 sRNVKNPWeNindB/LG3hdmYL3xhvF6ogvZiomG4L7Ma8I0GOUg5MZuvnZJBhpL5j1/Mnm
 Ev02tZ08nfIyOMrVz/uHaegxqfH6/9U8SLj4NMgNzRaGqf44WUgd+btqpQu9/PukHGqF
 4lYA8xkfY06nZtW/cWyZa1iMJ8UTqGWWvvrloIKlHBsTSNDkRH9yGbedJuWgHad4yVes
 gQBj0oTx9siB0JZgSLVN0LOwSiEHN6cHqYI0YFCXuUF2hixmps041IJ+fbTmpit/8geU
 26tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8ZNFO4m9N974fMV6SMdh12CJIrrms+GSDZzZozFbW8k=;
 fh=lIg4F3nqWhRKsRwDZRN+oq7OtY9qZ/Lce+dK0XSk1r0=;
 b=PNSOjLq19Z3wTpbdQ0Ln8TwTGnfImjCWeDNB3XeHtDomdLPgeE7YdTkEk5kKgaqXPY
 /vr23V4Iy8i7Rx43Na1LW/hs0XmBQPm/aAtr8xsvQFR34udxXzmhjYyCjuKcX2VC342B
 b5+AeN9XgkmtMp8MxkBHhS87bWh2mBVv05xfTj3ii3A2Jz5h+sO1flLeS1c6GZX8bjlm
 pPpnhmrhm6NU6fJssZRJxOd5vWiTmzgXWNus8/WNjCxwMI/h+YbGppGbQM5Nm3o8owOA
 fHggdO214Q/9zOozzwTMrCX1244mknrJ6HKtOEYhtQYjz1ImgT6CxEhlsDTvWhHYLUwZ
 Wy3A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774280031; x=1774884831; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ZNFO4m9N974fMV6SMdh12CJIrrms+GSDZzZozFbW8k=;
 b=X0agY1SGhrO4+KeQmKF3z2edwMJkTrmb4fwEvnETo2DhtQkCaVCpn+zRI0YssFzGES
 ieJ46c7613LRKtdkMgmkZBKllRh/sl6Xa2iNfPnhKKRckyKDQQNQvUW/tXFCuUK+vzNu
 5zCNEVKuAeCk44N67/Xt4YC1TcvmUuUJQTE1UEV4UUrMhLNGwJx6jfIm8gsZhzewSJ2a
 pWuHaQyKrfMkT4EXPEuVGfpOE1kALt4MVdSmaQG2LjhwIv7wYjaBXq5vHUxEMMFdqp+2
 RZAQh2pIbo9e4qdxqgc3e+DnH2QyuTnL6AOtHV3vx/doPIFQOWmvchdyC/A91rkUGxJf
 DqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774280031; x=1774884831;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8ZNFO4m9N974fMV6SMdh12CJIrrms+GSDZzZozFbW8k=;
 b=rHnK3TSCSzhsUh2/Hm05uQp11xA68x5LECxpjmdOHT2Dsm5llXV0KN5twIQCg7SVFq
 HN5xr+yP3pYMCUgu8z4QmX5qGmCvWb9ZfVqRPT1+HlaW0gleCO+BFuSmzFt7ouUIvomk
 FddWMtTZo9RF5JkeIiqHHIQbB7FQD5VKzmVfwoWk906+O0wjNTMNHmooiUs4syo3Cyu2
 WqD3cqRfGzrxiCBbua46VdeTa1thtkkFCvUMbImBLDUxOHkkp9p6bIeJ9D08K+V9jzk2
 cy9VzmmlWiCn+QaRe9H3Im8CgZnXGsWe2hwwbYl69AMUdHRoECLusd+ZMMZD6adDWjdL
 bdqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSti+H79fEAm5CcgBueykd8rlf7f2uj5vYrGkLmOE8q9lJW5EKP/4bHflL+GI3id3iG3mim8HvfrrA@nongnu.org
X-Gm-Message-State: AOJu0YwEw3xmwt8Q0KeOskuftpTlIoIyrm9idXyZmwwpUoITfGZE71LD
 VT0edwPm5j9xEsL8G1120+pwFKRnscfN+IlGuWEjbpvNHUJgZZlm9atTr31k7zmgbnMxjL8j44T
 jGb1XJsUMUG0iX+zUtd5UAtJdPMAgqpZ8CtapJoQ/Mw==
X-Gm-Gg: ATEYQzxV1/mgUP/4cEjF9cyj3gW0kvaHkthpduarYplo6dlml8ttPdKqxqjho050rNQ
 FC75LNyfkGFQAZpAFORJklK2Sc3GyUA9i9CFSlA9Luiv6nKjavK/8JhREy0QuSUyBb1NUWkOmgB
 d11fKqxE8r5Xc4QNFvg+DL/BWOHq7OjsNbmtvoGt+4y9+Rx0+UEbteyS65GOlWKI7R98NgbxrqC
 BBQYzZ3nZgQ34urXZhSk9PZWarWuvkhm1glLRrk02pAM72zrAhz3ob4T+Fjzr/qudsUCkTsYgFd
 FMmHnf4hdy+LA1y4WNClLc1tF7FPIUvLEN0qqHeGlCm5RmzaaDi8Oa/6MKDfMH2f+lk=
X-Received: by 2002:a05:690c:dd5:b0:79a:ac83:ac67 with SMTP id
 00721157ae682-79ac2e7e1eemr495037b3.9.1774280030579; Mon, 23 Mar 2026
 08:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260323131531.1976-1-junjie.cao@intel.com>
 <acFDFHsh8Rjhfncc@redhat.com>
 <CAFEAcA88mHqmM8Pmm0Gbbeu4ugBV8snenZh7bvjSSruUtRcywQ@mail.gmail.com>
 <acFKLgvFAlP7asIp@redhat.com>
In-Reply-To: <acFKLgvFAlP7asIp@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 15:33:37 +0000
X-Gm-Features: AaiRm536DluWudFxi6Vj2Tm_bErHoSAAmouJTYoYqbUXjn3VnubAthP8MZWTAUs
Message-ID: <CAFEAcA9Yy=tdr+KaZO=hAitOH2aawrmp8X2FTW3piwTFrpg5xQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: validate RSS indirections_len in post_load
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, mst@redhat.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Mon, 23 Mar 2026 at 14:12, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Mar 23, 2026 at 01:53:53PM +0000, Peter Maydell wrote:
> > I would definitely be extremely cautious about having a threat
> > model where I had to distrust inbound migration data, but the
> > above does suggest we aim to handle that, and we have I think
> > in the past taken patches which add sanity-checking to the
> > migration data.
>
> My view of the migration stream is that we authenticate the client
> at the point of connection (either explicitly with SASL, or implicitly
> with a x509 certificate validation), and protect the data stream
> integrity with TLS, or equivalent.

This seems like it would be useful clarifying information to
add to the security.rst document under the "Sensitive configurations"
subsection as part of documenting what we recommend, even if we
decide that we want to continue treating malicious migration-data
as part of our threat model / security boundary.

-- PMM

