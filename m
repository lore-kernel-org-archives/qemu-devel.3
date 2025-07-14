Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082D7C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 10:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubGf0-0005S7-7s; Mon, 14 Jul 2025 06:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubGar-0004Hx-FV
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:39:34 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubGap-0006BK-KK
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:39:33 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70e3e0415a7so34794587b3.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 03:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752489569; x=1753094369; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ei4SD5y8jqVtlTDsI7wyp9CH/LyVovq+fEsPt5A2vgU=;
 b=kGddQ3Q/rzpBxZ7He+9CS0zNe+6Fgio8EOANwr30BzA82iZoGTeuJhJWJD9Zhbsy01
 j3LCSY/b8Ht6cnk6t/LSKGtknGmxQ+0EQ7OO6Pc22Ckmyq9bGsmUCKYXZ8InZzs2AQwF
 BiB/umhYw7qwNMo9BrI59m/hrW1zgALlOjUH+ZvNznkM1uwt3AoeB+6WN9mKSz9wITh4
 iZ+6N/VV4jz49uJWrFiRDYHzAIY85h0KsUjgfjUIkqk6MFoj9qqU+Ip0+dYa3g11NCIT
 xEudL8h7yYbI8gyQvCAVWShHxuXcYr5fxymPaVcIAt6mPQDzAzB3LHEwo3un8yTz38ta
 pZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752489569; x=1753094369;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ei4SD5y8jqVtlTDsI7wyp9CH/LyVovq+fEsPt5A2vgU=;
 b=T8EFNN+7z32TeheNEcnpL+73xwn4vFk93RU6VXgjlFmx4bO7w+YGhSso1K4IYdOgu0
 ebDSvPMuykNxqoOPeTQl1j03NxWs2FpzUbasXlOMcwle69qBqK8c14+3vmC7nOPSgT0a
 fWovyUcL1MpVw6aN3TtpZDFGgskSAP7ErNG+SIvZ9OAmwQOTstxrdGzpnqYLs0G2pq+L
 a7cKi2B4cUTgBG2w3I0om2QpxfG475wYh/CpIKck+iEnv/9VGRWxZ/9+pjf9wwDv5Mwo
 WVQhjTA5xHHo1xQc94F67kJ+D8RiGqwQR9Qcz3I/DNYKnE1HV3cqIozxg2mcmNgMZ+x7
 811w==
X-Gm-Message-State: AOJu0Yx7oED5xMQxpmU78bNQq9pPoxcOsVsbOOFy6OazX7pNJM5buKmn
 8Fa6yJZg7cQV0h9anW6W+0D8Zk2VAV04OcJw8tzGJKNPVTMooEhgc15nDibxV0CLWI7BUS/7qYE
 G9ZTcDjXZ63qTBeh0EIx/y0USOLVWuqtu4IGsDFyt7Q==
X-Gm-Gg: ASbGnctqid4mk+XlJuxloyt40Owmqz222pZBR17bi8f3bS59Yk3Na87TqsG1U01XU0A
 UAxxETZVTK+rZUkN39AF95bg0/fHKJbp3qMP3LFGXKx0yY3cj33pucwNw8ntUfOy+N9/uEw60H/
 VbXaOsZN1R/outReye4v1yH7TZN2FCITE1Jkw6Pvjbc1SV6cFTjPjRC4kjyb2lILrXiahyGreFI
 TRTEJ8lHuBDSJgLJnY=
X-Google-Smtp-Source: AGHT+IEhjwN/GOGD1EEZ9VBFvTTlLWJw40fiGVqbu6HWeBw4SUm2v2ZisIgOjiJgZjbwjb+x9bg6fg5hsTHPnSt3zdg=
X-Received: by 2002:a05:690c:7484:b0:70e:61b:afed with SMTP id
 00721157ae682-717d68748ddmr179642787b3.7.1752489568715; Mon, 14 Jul 2025
 03:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250704223239.248781-1-jcksn@duck.com>
 <20250704223239.248781-11-jcksn@duck.com>
In-Reply-To: <20250704223239.248781-11-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jul 2025 11:39:16 +0100
X-Gm-Features: Ac12FXx9JwX8grI0kwUJmeJTlBwIDz4RDYnOpc0epejx1rki7QMR4Tltk6Zgr0E
Message-ID: <CAFEAcA9iQtisF6FO6bSDLs6sUnpQxW9jRZeMa2ZgLUbvbWnLFQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] MAX78000: AES implementation
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Fri, 4 Jul 2025 at 23:32, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This commit implements AES for the MAX78000
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Hi; now this is upstream Coverity Scan noticed a possible
issue in this function (CID 1612247):

> +static void max78000_aes_do_crypto(Max78000AesState *s)
> +{
> +    int keylen = 256;
> +    uint8_t *keydata = s->key;
> +    if ((s->ctrl & KEY_SIZE) == 0) {
> +        keylen = 128;
> +        keydata += 16;
> +    } else if ((s->ctrl & KEY_SIZE) == 1 << 6) {
> +        keylen = 192;
> +        keydata += 8;
> +    }
> +
> +    AES_KEY key;
> +    if ((s->ctrl & TYPE) == 0) {
> +        AES_set_encrypt_key(keydata, keylen, &key);
> +        AES_set_decrypt_key(keydata, keylen, &s->internal_key);
> +        AES_encrypt(s->data, s->result, &key);

Here we call AES_set_encrypt_key() and AES_set_decrypt_key()
before calling AES_encrypt()...

> +        s->result_index = 16;
> +    } else if ((s->ctrl & TYPE) == 1 << 8) {
> +        AES_set_decrypt_key(keydata, keylen, &key);
> +        AES_set_decrypt_key(keydata, keylen, &s->internal_key);
> +        AES_decrypt(s->data, s->result, &key);

...here we call AES_set_decrypt_key() twice before
calling AES_decrypt(). This looks a bit odd: should we either
(a) call both AES_set_decrypt_key() and AES_set_encrypt_key()
in each half of the if(), or (b) call AES_set_encyrypt_key()
twice in the AES_encrypt() code path ?

(Coverity is sometimes wrong, as it's only using a heuristic
here, so the other option is "the code as written is correct",
but in that case a comment might be helpful for human readers.)

thanks
-- PMM

