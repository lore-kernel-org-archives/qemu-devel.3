Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7832CF01812
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 09:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyRn2-0001OC-Lj; Fri, 06 Mar 2026 04:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyRn1-0001Nl-Nf
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:48:11 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyRmz-0004dZ-Ob
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:48:11 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ca09f2170so9456811d50.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 01:48:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772790488; cv=none;
 d=google.com; s=arc-20240605;
 b=bZJxc1LaD3I2JmcPPmC3hMFdI/SI5nldjAISrwt75Uah0WS9pX+dhA0E3eALyzbJXC
 k3d6jOY66EeOSySxtvHSiG2K3taq4vk0Gd6p01CowD9+UYpxe3l3rDBtODSRloCY9nrO
 jTUrJqb/S92tGYYtlEM1z8zQMpX00DSF2pqwEgUvy6wNNHtdesEQj/jL3x8lNLIHEm9N
 NTll9y1vzmerpvq+rmlMgYjP25oyWcmmWADodjGAFjP5oH0PT5bOCDRrmBGx6H8Uq4cH
 EJGn9Xj7bJSEq4CbdAhTf3JGMkulPlqFtxdkeOg5qAtBFlcr57Aau0UA+IHFRmIeMba7
 CcYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1aqSBlqDr1uj9MQOZACHT1mU2eY2ox33fOiMTA41tp4=;
 fh=BAyh76Dt9lJjY3uGbG9gye4E4bNa4dvV51FFfKIqCkc=;
 b=X9foBXCUtPWoQVLaMJstL/U8RlhZZEgsK8I6PBHmNWQoP0PxNIaIFJMvY73i9Hh3B3
 7npU50GKxAVLisjPEjiqUcGZJd11G9SkpEfcwprPMs7IOS9017JJIUT1B02cfhlx6mh3
 WDJtJ+vOzlAo7UUTDy2cIAtbVdH9ZxM9I2jJZWjscN0+mHGYOWI9zY3+B4/RgV5Gfk7Y
 bAS4nSzWjsHcIU0LsJZbv4HhB9lb9H3ia+EiIf38Rn0oncoGwGYMzO17gAZqgJBnXPRq
 +0d3IbREt0UJkF7n+6Kuz+V7B8Ga1h9/djrvOkYmYCL3hJdn3RAlptuqR7iXaKjV3jtu
 g7yQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772790488; x=1773395288; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1aqSBlqDr1uj9MQOZACHT1mU2eY2ox33fOiMTA41tp4=;
 b=TJVsUefQiCNVqkDEO2IqDjRZeVcRsL5IO0L1vLjOSa/SgHiYdgRVlGfsy3AtToYmL+
 fcSZo4mbNfT1/Cdpxiw8jYPgeOibLXShDB6QnpYTlkoB6eU+Az2wMs08orrordJKjyjd
 eMV0OtDNkVxdAJ81FYMUYZph3WYHjM7+EnYJvWzRHcTtRG4SsWuhXvKYIvXg3rc2ceTo
 wNJEP/Y8A5BldvRODTTUqDvDIh8XsZ0F4CWIpjwyhFh9WyhWftEdZMetvxciyjEr6kVr
 VFGrcSOYDy53ypAIpmqbmPInlqusdXFnWbvy05Cw6O4K31y6aY3V5Uk0K1nd694iswCP
 upHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772790488; x=1773395288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1aqSBlqDr1uj9MQOZACHT1mU2eY2ox33fOiMTA41tp4=;
 b=xPkLogAmJO9oNzK2tFat0WTi+pKQbtF1S8U5RrgbXsjoAo/SmjZGlzf4Q3KIiCte0B
 NKWXCvojAjt9TWqOD5GCiFhZkL/Czk+Ciyg1Nhk1r3QFj5lD+1SG80tKK+rirdfahPVl
 S2uxIp3OiT/GLI0yQIereMf8o9LaHleRC1Wy8GFu03YAGklEdCBXkDjk4q9zKtLGotB5
 T6LF+u71yiVWyyhc2KOxSToUMLVY4g7TuiqpCeCaI8+RwVHyE/2FdyzzjTW0elX9MyFp
 DM9UhnW9iz6JPzEkqU9qX98RYR/g3dkUK0YDb2znZvTf1zcZxAiXScvVLERy7OClOAbG
 i7fQ==
X-Gm-Message-State: AOJu0YwX6o3EymE9sTzpNZ/cDz5dUX2zk1A7KdUqXR1bDRRp2sISzaKW
 4XMgfQt7U+rShEL9VQJ8Asbegml+KGhZC5nffwUE7AitFH1aZ1/DpXOhVpJIdj3g1AAwSP3a0dG
 x8ycQ94GLYJe5VzTsx/QQxl4Zd4t8QtDvlr1hT5MTSQ==
X-Gm-Gg: ATEYQzyQGW69UEhmsX+zLJNSB+hGL0m5XOdFeGaH/wjtRFHr82LqNYePqJ1+7iypbEP
 aB00owa0uD+gHcc1qs6FJObRIBgo2tP9s77IRH51JT7qdKByn0IuGO6IQ0uKUZkRlC1zgUxW/Y8
 FZHmlDc+K+YKEAAJ0QXidn0IrDE+Cu1/kHGQQbKTvA0xHFqIH94DNRSwajL3iyJQvw2sMVtg7zt
 cGyXiwEvbceitN9oDhbtJrV52r7ohiajBUAFu421CN73wlMPFleGqziiS8DhZsht3FZ4swT7SVp
 QihD3QYKdB8NfMYF7HM6bum/lmSZoZe0Z2AfKhosGUOzj6tzuk7PykbYF4DbsLHU2yU=
X-Received: by 2002:a05:690e:1286:b0:64a:d541:bc3d with SMTP id
 956f58d0204a3-64d141271f3mr1292041d50.25.1772790488328; Fri, 06 Mar 2026
 01:48:08 -0800 (PST)
MIME-Version: 1.0
References: <20260303-sme2-hvf-v6-0-b473702d8287@linaro.org>
 <20260303-sme2-hvf-v6-1-b473702d8287@linaro.org>
 <CAFEAcA8zTkc4pyHQKoDkTMhGPLQmxBaJS3bZiGRrPgux3rDLzw@mail.gmail.com>
 <CAAjaMXbXdrW9N1xLMPxL9OmjLqti6A3rqAmYipu6OkdBY8JPNQ@mail.gmail.com>
In-Reply-To: <CAAjaMXbXdrW9N1xLMPxL9OmjLqti6A3rqAmYipu6OkdBY8JPNQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 09:47:57 +0000
X-Gm-Features: AaiRm52PxOMDhyEx1vSCa8UvcQppyNGVohLxbT9VnoVhUVsuDEV-s0Cny4-vA7Q
Message-ID: <CAFEAcA_MuZH8d=Z=NfrNQ78k+Kv9mSx+=DLLt8AxZeEjccN8yw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] hvf/arm: handle FEAT_SME2 migration
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Fri, 6 Mar 2026 at 09:31, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Fri, Mar 6, 2026 at 11:19=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> > Mohamed points out that this breaks the build when compiling
> > with GCC (which I hadn't noticed because I happen to do my testing
> > of target-arm with clang on Linux these days):
>
> Oops. same here, I was using clang.

> > typedef uint8_t hv_sme_zt0_uchar64_t;
> >
> > Could somebody confirm that that works OK on the relevant macos
> > configurations ?
>
> I think this works. Do you want me to send a new revision?

If you can test it for the macos configs I can just make the change
locally. I have:

+/*
+ * The system version of this type declares it with
+ *    __attribute__((ext_vector_type(64)))
+ * However, that is clang specific and not supported by GCC.
+ * Since these headers are only here for the case where the system
+ * headers do not provide these types (including both older macos
+ * and non-macos hosts), we don't need to make the type match
+ * exactly, so we declare it as a plain uint8_t.
+ */
+typedef uint8_t hv_sme_zt0_uchar64_t;

While you're retesting, could you also look at / test patches
17 and 18 in Mohamed's series
https://lore.kernel.org/qemu-devel/20260306083113.74177-18-mohamed@unpredic=
table.fr/T/#m2d1e3dfbfa5aecd41af6c0aa9e3b574a72c6f04d

?

They look to me like bugfixes that we should be squashing/including
in the "enable SME2 for hvf" handling.

thanks
-- PMM

