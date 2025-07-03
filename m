Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BE9C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMri-000610-Ry; Thu, 03 Jul 2025 12:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMrK-0005rm-Pu
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:32:28 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMr9-0001L7-44
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:32:22 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e7b4ba530feso5164966276.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751560329; x=1752165129; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+k2gtyeQo7uAkZlHY3AA6iIKGiYvlMVTDh+AjcUxqlQ=;
 b=ctEGokKe7XW5aFYGFU/NyhniCi3mIQooq4ORWaYmLsXdxbrhjIi9AHHHUDBez6h5mg
 EpiyaK7NjmJ5ItS8Hi5Qs+wiCq+Kji2QD0jTjrMxfY4qOShLWZXiV0BioFOz/gWq6lEb
 yrdv6Z2fNqpbk5GHhFPXmh8YdZAkmhqtusj/fGdmfF2CEMLqOrKXD297Od88OAXa4ffh
 k0U2lfJUX5F9wIlb5CIHhgkuSfi98Ggu5zTC988K1pXzya/m1s2/Y+h6k0n6KnBvSv1f
 XQizfPuCF0ICBtF52iuasJKxPwI1fj/qKgRY8tx2uI7wScq4Ce+C1behl9jVowvudhW1
 QPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751560329; x=1752165129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+k2gtyeQo7uAkZlHY3AA6iIKGiYvlMVTDh+AjcUxqlQ=;
 b=XOvfRNR9HAMHSZi3CtiP1rpX1aCUJXz7Y1CN2v5SN/cT4ELZcBkBhMnVCOo1VA5PAy
 2E1SsKLkw/ZUjrwwijv577kzvcQuHQGLP8grQqpV+gXP8/qu6WakSzX/stX6nlwJMWvg
 YPy91VQdh6Pq0qt7MpQPq1VLEF3Q8DsMS4VSjT/u9PQUrAJfy4k/I51wGZeHE3gc8PXU
 ShrCdzrJz8fDDi/YGyaYwlVRHs2exsHTGgxfKEkV18yJQFHw+n/VHjp91ffiEomxuo7V
 2K7KZPgAE7g5OpRhjzgLIluqCqJuuw8CQpiU/fhIkV1Tpl7IBRt5htQe4C++F9EpR5da
 rI9Q==
X-Gm-Message-State: AOJu0YyDKtK4Zn+HbDRpiK8ttaitLKJ66ngcGk3Ig2YUGmidKtaAeGa5
 fJZcmIeO5SZKrAJTUFT40dz69/GK7KIpWbGnAD1+u02DD9YPDWv3ASLo4rGjRIXEm4gcSN7eXo3
 +z35OLjRbb3NNO0zj1dgVuOzCFJ+v5OCmJarODeGw8nBDhbLs6ucK
X-Gm-Gg: ASbGncvN4LqtCpkV0WM3I+OmLQCPYO1emN+M41BW/kpQeALKmGdV79jA56C3XRcEuNK
 R5WnuQNP9GV+PicLGN/L0EadkRFa9rZBhoZ94NrVgpkuwMUK2ZOuMe1zdz3hs1/yKQySsa7PrqR
 iY+jv6/nJCLX+cYcqPDi8ZzYYLD9U760AVnkNN0BqR9ujt
X-Google-Smtp-Source: AGHT+IGQDjSW9wiBWlveayY74kflWVZE8EAukYCTCEy3gY3REvI80fYsicKPiesCS7ml3Ux6DuE/kh8JDRFKwDqEF20=
X-Received: by 2002:a05:690c:650a:b0:712:d70b:45cc with SMTP id
 00721157ae682-71658fda9c5mr59483517b3.8.1751560328583; Thu, 03 Jul 2025
 09:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250618230549.3351152-1-jcksn@duck.com>
 <20250618230549.3351152-11-jcksn@duck.com>
In-Reply-To: <20250618230549.3351152-11-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 17:31:57 +0100
X-Gm-Features: Ac12FXwmWdBGqmwt6pfAAJ5FdWTViSWiuvcdYKsbE6-17BpRK3FvjuKh8li2C2s
Message-ID: <CAFEAcA-3m42gWJE-iKM_87n08nUxamQ21KmcdFEosONUReLAcg@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] MAX78000: AES implementation
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Thu, 19 Jun 2025 at 00:06, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This commit implements AES for the MAX78000
>
> Signed-off-by: Jackson Donaldson
> ---


> +static uint64_t max78000_aes_read(void *opaque, hwaddr addr,
> +                                    unsigned int size)
> +{
> +    Max78000AesState *s = opaque;
> +    switch (addr) {
> +    case CTRL:
> +        return s->ctrl;
> +
> +    case STATUS:
> +        return s->status;
> +
> +    case INTFL:
> +        return s->intfl;
> +
> +    case INTEN:
> +        return s->inten;
> +
> +    case FIFO:
> +        if (s->result_index >= 4) {
> +            s->intfl &= ~DONE;
> +            s->result_index -= 4;
> +            max78000_aes_set_status(s);
> +            return (s->result[s->result_index] << 24) +
> +                (s->result[s->result_index + 1] << 16) +
> +                (s->result[s->result_index + 2] << 8) +
> +                s->result[s->result_index + 3];

You can write this more simply as
      return ldl_be_p(&s->result[s->result_index]);

(that's a function which loads a big-endian 32-bit value from
the given possibly-unaligned host address).

> +        } else{
> +            return 0;
> +        }
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"
> +            HWADDR_PRIx "\n", __func__, addr);
> +        break;
> +
> +    }
> +    return 0;
> +}

> +static void max78000_aes_write(void *opaque, hwaddr addr,
> +                    uint64_t val64, unsigned int size)
> +{
> +    Max78000AesState *s = opaque;
> +    uint32_t val = val64;
> +    int i;
> +    switch (addr) {
> +    case CTRL:
> +        if (val & OUTPUT_FLUSH) {
> +            s->result_index = 0;
> +            val &= ~OUTPUT_FLUSH;
> +        }
> +        if (val & INPUT_FLUSH) {
> +            s->data_index = 0;
> +            val &= ~INPUT_FLUSH;
> +        }
> +        if (val & START) {
> +            max78000_aes_do_crypto(s);
> +        }
> +
> +        /* Hardware appears to stay enabled even if 0 written */
> +        s->ctrl = val | (s->ctrl & AES_EN);
> +        break;
> +
> +    case FIFO:
> +        for (i = 0; i < 4; i++) {
> +            s->data[(12 - s->data_index) + i] =
> +                        (val >> ((3 - i) * 8)) & 0xff;
> +        }

Similarly here this is
           stl_be_p(&s->data[12 - s->data_index], val);

There should be some kind of check here that s->data_index is
in range here before we write to s->data[] (either an assert,
if the device code is supposed to maintain data_index in range
at all times, or else some kind of error handling path if
guest software can do funny things to put it out of range).

> +        s->data_index += 4;
> +        if (s->data_index >= 16) {
> +            s->data_index = 0;
> +            max78000_aes_do_crypto(s);
> +        }
> +        break;
> +
> +    case KEY_BASE ... KEY_END - 4:
> +        for (i = 0; i < 4; i++) {
> +            s->key[(KEY_END - KEY_BASE - 4) - (addr - KEY_BASE) + i] =
> +                        (val >> ((3 - i) * 8)) & 0xff;

   stl_be_p(&s->key[...something...], val);




> +        }
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"
> +            HWADDR_PRIx "\n", __func__, addr);
> +        break;
> +
> +    }
> +    max78000_aes_set_status(s);
> +}

thanks
-- PMM

