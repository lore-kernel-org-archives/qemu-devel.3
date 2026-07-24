Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCCDC531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnBiB-0007Y9-RH; Fri, 24 Jul 2026 04:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wnBiA-0007XY-IR
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:56:54 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wnBi8-0006Lq-85
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:56:54 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6679d88abdcso114616d50.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 01:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784883411; cv=none;
 d=google.com; s=arc-20260327;
 b=AwWss4qdxdGRp++obNk/pwu1IHiUNgtV6XBEHTz43VgBbxzq6G9zbhDMQB5teAnH8n
 dCtf4f/nKXTEUCc7KVScx2qGKInuDcWV9w4C7w2UQIYGfn37gE4GCQLiRSdsqlaSxXFg
 WwVNgPcSrJGIwHfkhoog/QSTPOlnRCrOu026R61tVMl3FZSeZ8Xs4mfY25D9G7dpjMRC
 SHQ/htPmanERzm0XAMFmKijCUvYV0cg7D6d4e85MKAmR/chbpMTwoxO3w4IPW74cH1EC
 OZm+9ikEuJWPFhcXbW9OZsgdh2jnheV5lrnASitLj31xXgvwv7jS6UJwthjX6uYVUmtc
 9osQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E9E6Y5fYCFx466ER0P+VAkHURzQzCjzaS5clb5a/W68=;
 fh=Bkm7h1qePyNu6XewviHipxJh5Gb0B/9a4YQ4WVdINBE=;
 b=EaObsNW8G874S7fYsFXiPM7tdj1jpGQNck4NRsRgx6BZ9/qRRq0BJzpIasYnUy5ygN
 pbeN/78Mt7B8RSUC1UChhgLKagBicei1vi1JwVz6aE+S7Uu2XBTkP8rcpZs2VLhzSLip
 3Vc2wJocEXCnMY5TCMPjSW2CC/4sWL9JgybB/houd+WMEjl2Or7Hlz4ErIgU1ywV/r5i
 g7CLiUVqtu297xsMovtU2Pi5UxK7WLzou0Li2X3FsTsqknW1+7RNBQpSflz/egqu07DB
 LMN2rQXJJA/8lym1bHDYLwg7dx/o95MGns1k0NRSESZwAF9RtrALdiatfvMDc2hHFkeE
 GTwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784883411; x=1785488211; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E9E6Y5fYCFx466ER0P+VAkHURzQzCjzaS5clb5a/W68=;
 b=c6dhgblg3ueqlSCXdJG3Kdxnv8FNfOezdON4vWF9C3UJIG7WwNdXPW6hSeE1E24n9Q
 wXfOIzfDlxhleLgat3SwlKsy3NjmylE6p/RI6xswnzF0tK3/tyULI7b7eASlRZtkQNbt
 BFDCFnnZJ3aYP5sMJgIncnrnsFqKP+RhJpaEoVdLz+PMdmjJ+W00KKHUAN08dUTxM3l/
 dOsaig7/3pfb9mU9NzCCteovg/EQI2hySMqPEsH8HYZYB6puS93xBhq5dkiGteAODEFn
 fJu1yt4Qpxhc+izdbdZyC9tZfDrCd9jpEhr0AbiA0K8B6jTm26EvYBQg2TvbuSvdOy3f
 CMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784883411; x=1785488211;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E9E6Y5fYCFx466ER0P+VAkHURzQzCjzaS5clb5a/W68=;
 b=dGz/7QmzrBb51X0WakUgR/w7bwqZRqwgVZdAUcgqChklFm0xb1+2Ye+BeFu2bnmb1P
 HLXd+89UpUzmPwzyocLOCfHIdZDQyLyCXF5m0p+hvkzvDRlEwchrXk6UeHOYDKw6Zb1t
 sB4aD95oi9G4dLw+H5jaU/B0vkq+4sBKXyExDb/ss0A+TzW6izzcAtOiBSlxcggydPvz
 3ZEtNWQqpd8mHRJZMd52mC8SR0kARkI2LxVbHMAPxT40ETx3j7hzOoZIyYDzjip4eMXf
 5pAqcMIAN8j5zmUfTkDB4pA5zbPM2tOtnMZk7n9LvLwYLsRr0yV1f1Ej0Q4PRyvD/x9Q
 Ui6g==
X-Gm-Message-State: AOJu0YzsP6rsPVAkyvVh2XTsZ9xOY0FkE9GOYSSLt9Jm9L7LU2qQnV0v
 wsWvh5qJy1TTnJEXhz9owRT0EJoIk1SyjTHg8x/G0lgouIBbUuYn5GfTF7hNanHlbEMgTRjwJ4t
 oILzsmAGmWBwlRpHjudVYIDal/sNPWYA0bBr3uTohTQ==
X-Gm-Gg: AR+sD11+0//CEZy/jS7PrNScdK4V98VGH3ECNFiS1RbINIOsQvVO9eA8uqn4twWXhgw
 +d7/JXbJ6Q9VPlJprSwoP3wYeb/9QKQfxvMjy0Dxzsj5j58fdvb9wP3jObO5U1QWdKSdPkxE9k6
 Chrmr8omsJIzqBNRMABsdK+cVVn0iunyLrL21+EEnqezYRwNr2Dpx4Qzz8J+NE8EDGpBz2ve5ij
 y8bnUT0WGXqvZTanDZ5JA6mtEr21U3PljXP1JNjGS1NAPNsx0oCYHUjgKequ9JhD1Be1oCkft6W
 M91xcWgUW6jmny9BLQT4CAAXNGoDEpDJFWQ5fDoHZXZOwdS8xuwSrFOx
X-Received: by 2002:a53:cecc:0:b0:668:2628:5768 with SMTP id
 956f58d0204a3-668a4fb4fe6mr1310519d50.90.1784883410756; Fri, 24 Jul 2026
 01:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260723164357.1462-1-simonxhy0404@gmail.com>
In-Reply-To: <20260723164357.1462-1-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jul 2026 09:56:39 +0100
X-Gm-Features: AUfX_mwxWnY-oX2H2Z5AivLjEvdUVLYw43pzlkkxUkmzgedaFtLE5QfdlMQZ2hk
Message-ID: <CAFEAcA-3iJyD1mUw_jz=0aE10Hp4qkoMZTNeZ4zMQqusjyfOgw@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/mps2-scc.c: fix scc_partno() and cfg7 write
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Thu, 23 Jul 2026 at 17:43, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> Increase the extract32 length from 8 to 12. The Primary part number is
> defined as bits[15:4] by the "SSE-310 with M85 and U55 FPGA"
> documentation. For example for the mps3-an547, 0x547 is 12 bits but we
> only return 8 bits right now.
>
> Change the CFG7 write function to modify the correct variable.
>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
> ---
>  hw/misc/mps2-scc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
> index 7877b31479..554b504c72 100644
> --- a/hw/misc/mps2-scc.c
> +++ b/hw/misc/mps2-scc.c
> @@ -57,7 +57,7 @@ REG32(ID, 0xFFC)
>  static int scc_partno(MPS2SCC *s)
>  {
>      /* Return the partno field of the SCC_ID (0x524, 0x511, etc) */
> -    return extract32(s->id, 4, 8);
> +    return extract32(s->id, 4, 12);
>  }

Whoops, this is in "how did this ever work?" territory. I
guess most guests don't actually do enough with the
part-specific bits of the device to notice...

>
>  /* Is CFG_REG2 present? */
> @@ -299,7 +299,7 @@ static void mps2_scc_write(void *opaque, hwaddr offset, uint64_t value,
>              goto bad_offset;
>          }
>          /* AN536: Core 1 vector table base address */
> -        s->cfg6 = value;
> +        s->cfg7 = value;
>          break;


This is also an obvious cut-and-paste bug: writing to A_CFG7
should clearly write s->cfg7, not 6.

However, these are two separate unrelated bugs. Could you send
them as two separate patches, please? (You can put them in a
2-patch series with a cover letter.)

thanks
-- PMM

