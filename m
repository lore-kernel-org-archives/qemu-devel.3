Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015AECDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbhpF-0003he-W9; Mon, 22 Jun 2026 12:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbhon-0003gD-QP
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:48:19 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbhoh-0007RL-0b
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:48:14 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-662c360aa73so4926774d50.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 09:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782146890; cv=none;
 d=google.com; s=arc-20240605;
 b=LciG8YpmckSbVVJRChlCXf5LJT25OFVNkKrhGdF+PV7ANWrIRfG8qyVazLp+hMjoBP
 QQ5BNMrLdR/G8e2wa3cdwspPhcZ1LnZ6801NJE8vNafZ/4oEcQUGUcClf0xaolBGM5/z
 a4NJ0PZKkfgIykYqkATIF1Jr9SnZcC8g9IGiFrvyz5+dwDJX3zBiYru4E5Et8QHnymKC
 Z+7911rHlKq+bV6kx4Sru1NnBNm8JYE1WkPdiAM17Er9PYHShk3QmLbkDVLzpL5olq99
 lXf6CBIWZUvfY14iHDTxvWqHtp0Ib/JRANKMbDMhXVv+nEUK107Ng8whD09TnLE58tXJ
 ukqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nJqvqEgEvE3fnaTNk74o8NOcy+gsaycQJR0ykl/gqCU=;
 fh=NQqZtnaAYV7t1mhOfL1aUng32BmCPbILN5V4pwdJe9o=;
 b=JnnsOaGGRkBw3LICHKXPBP0mRSVDjVPFvXOkCbkJBqntmTESA84Ns7sgZSt6VOEMQh
 LcU6zjMwKK/p1rlMLHi3fKDEiDdXMYa7Omco1RYxiLuuPXJyfY+T1CfmS0W5bNMkcw/Z
 Dg1Ns/WkXpE1ecVYd5aIqcN+uibUpY9UCIGpL7e1PUtq90QPXBrLKmmEkC5HZnMtl9ND
 vlIWnn+y6yPZ+w5l2VFwI2xpAujf5b1UTV8Vx2Eh+39MQVXJTpmYLnk7QBaqenJx2irI
 L4eLCyt+QZQpB/uOkYCzf7/9Cd1HGs0QDEqpd4Tbbkvzd0ujUhV0Ii4HaWr3UdiQWMLU
 L1QQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782146890; x=1782751690; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nJqvqEgEvE3fnaTNk74o8NOcy+gsaycQJR0ykl/gqCU=;
 b=x5Kkax26SkXGy+uB6dXPY79RAwsptz6M/23VrQhieIL+PhvrhPFDpmyPLxFsNxikJT
 1tn4oCjgvhvVp+kMiwPo985+QhzUjS+/5PfHFbE5FsTg/yYHJLoa6InnuT45QeRq0YPu
 BWdYTiUyKk72DDYS3zmTn3+VD1HEy15pU1kgyPqwS4kTmnkvhl4avrMuX3seQOMXzUKH
 kqv8bDCD18/6kuKC9Auf/zYE1/GdoDPjPsh4Lw4UYjucCJIKnwCSJpOYTV9d9gLt1LvQ
 Hd1bKmGVl+BOp44Y4wKllWfyc9AWn7n/x4aNi09sDjZ8ympvses3Q5U8MPlj22UBQebO
 Sg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782146890; x=1782751690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nJqvqEgEvE3fnaTNk74o8NOcy+gsaycQJR0ykl/gqCU=;
 b=n+o8sfPeslv15spUpn96X780ORXNXLhK21voV4gY4/6tAssAECVraN71TGgZBUnTZO
 +r6RngzPRmYPMYZvkJ5tzEq9U3Hpht0/gfEUjimNYl/6fnZSvhuAUrhM10x0lp4P3kTE
 BKTC4zqQv1do05gAjhGwcwkBKBjo4AfEMQLatZZyI2ya0x8l8Bheurxw7NcJQUNMLfFS
 fk1d89FU5/gO6PQVnZtkS4kdghhCMAkgWlBn9QMA0sKEtOD1RI2oNnEbIP0jkN6ISQ8p
 QJ+t9UWPr0UyEIjyRc0/AcANUgu8c7gJ8tQijmmnX882GXtSoF7gk/C4zTKtIlh/lS91
 Qs2w==
X-Gm-Message-State: AOJu0YykfSC3gS+T2M1R0WMEqEPiIOpXBYfd9JqWlYOTsibyuw2dLdB2
 2+UGT5r/ppS3QV02hPTF09Alj4lxza3QUs453Pw4Zn5vaFbhdaO14JYI8MN3sZ1Jwk8w0j8/fcD
 urLTrvTl4R4T34k+COkcaiSatD6G2erkqeSv9L7yttQ==
X-Gm-Gg: AfdE7ck4QyCf0nu6s0gExFk0c7Ip+9omVJZecl9n3PKDLAHEAXvyHQodSLBtgkruBgG
 muQEcyr2u0LMUz0EIY1vkYf7BJWIJw4h7Eowv9T2kO8h3L/3YtpVaV3MvSQvvMPelvi9xjpERXX
 VWxWjKsRIlvIbzJxLs3uBj5MoRvIstfbNXZ+hMZJF7g5s4X78C12smR5a/fOu7tYsho9GAoVUxU
 C6WCSd+ZY7tZ8y9xGWWRkVSAHzACJTbXcGB8JB6agKATRnqLCFNG7SI1mSbeNweLKSh6naygL8m
 PMDG03BdM0fZrG+k2wRtuB36Mdb/oIhEasNQQeugw6/ODjGYK3eq3OWb5uLlNmnni28=
X-Received: by 2002:a05:690e:1908:b0:660:5a04:9a03 with SMTP id
 956f58d0204a3-662ffc380ebmr13158798d50.20.1782146889544; Mon, 22 Jun 2026
 09:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260617235032.21491-1-mhjacobson@me.com>
 <20260617235032.21491-3-mhjacobson@me.com>
In-Reply-To: <20260617235032.21491-3-mhjacobson@me.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2026 17:47:58 +0100
X-Gm-Features: AVVi8Cdbsq15bRKyVEH8pRPNXMWxh2c_g2WO1wR_XFc1QaP7uov_SLXOLsh07bs
Message-ID: <CAFEAcA8_QKDkOKAQ96smx5hfEFbZD5S2hDjf_nCCDo8T3XNs_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] fifo32: add fifo32_peek()
To: Matt Jacobson <mhjacobson@me.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 18 Jun 2026 at 00:52, Matt Jacobson <mhjacobson@me.com> wrote:
>
> Add fifo32_peek(), which, like the other Fifo32 functions, ultimately just
> delegates to the Fifo8 code.
>
> Signed-off-by: Matt Jacobson <mhjacobson@me.com>
> ---
>  include/qemu/fifo32.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/include/qemu/fifo32.h b/include/qemu/fifo32.h
> index 4e9fd1b5ef..7601bcfbfe 100644
> --- a/include/qemu/fifo32.h
> +++ b/include/qemu/fifo32.h
> @@ -117,6 +117,31 @@ static inline void fifo32_push_all(Fifo32 *fifo, const uint32_t *data,
>      }
>  }
>
> +/**
> + * fifo32_peek:
> + * @fifo: fifo to peek from
> + *
> + * Peek the data word at the current head of the FIFO. Clients are responsible
> + * for checking for emptiness using fifo32_is_empty().
> + *
> + * Returns: The peeked 32 bits data word.
> + */
> +
> +static inline uint32_t fifo32_peek(Fifo32 *fifo)
> +{
> +    uint8_t bytes[sizeof(uint32_t)];
> +    uint32_t ret = 0;
> +    int i;
> +
> +    fifo8_peek_buf(&fifo->fifo, bytes, sizeof bytes);

fifo8_peek() assert()s that we have enough data in the FIFO
to peek it. fifo8_peek_buf() doesn't assert anything, it
instead returns you the number of bytes actually read. I
think to make fifo32_peek() consistent with fifo8_peek() we
should here have

    uint32_t read = fifo8_peek_buf(...);
    assert(read == sizeof(bytes));

This will also avoid code analyzers like Coverity complaining
that we failed to check the return value of fifo8_peek_buf().

> +
> +    for (i = 0; i < sizeof(uint32_t); i++) {
> +        ret |= (uint32_t)bytes[i] << (i * 8);
> +    }

This bit can be more simply written as

       return ldl_le_p(bytes);

(which says "load a little-endian 32 bit value from this addr").

thanks
-- PMM

