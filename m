Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DE3CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMX6N-0000xE-D7; Mon, 11 May 2026 16:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMX6K-0000wB-JT
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:19:40 -0400
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMX6I-0001J0-SI
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:19:40 -0400
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-63329e1c77aso527637137.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778530777; cv=none;
 d=google.com; s=arc-20240605;
 b=PQo9zkmzuWx62sYIqm6zolQfhZRUoCjBssN8/jS94xGi6w25i35SRLgzZPhDRVLM+M
 cFq3lLXWQ/e1V+u8AU19dpgAfIbRG4bYmQFK06Ksw3+O90CZVALcAgmv4JhF8eYitalt
 fObS8DF2cQShkv8CNXti/7PkXJf+BDa4UPUiZSQDqGNwNF2+WhV5Jt2i2I6jiMDppiVU
 CF74Jt1wyvhbvsDko369NOwinEitytxDEzu8qi57GvlbqB5ybMW+SCd59caSPkLTN38G
 afA4vVqmpWD2zgpQtHup+ne7r+Y71qsuQy0JW/Xj1MAEYn7hywpIHLrAaP14RsI5rJQw
 6Pdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uHrXelzpk3U56/AkIJBgiv2/PKvZi+vlY6nIiNpbELY=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=QYUchjZjB+NaXEirZbKgwPeXzK3j79sA4pPcgV+e0aOthuYJh10mbx5K6FkJBkM4KX
 oaP/rGXhXIXIfHy7YkISE1CxTQveVZXrZy158vH3S1HmEmLofhMTIsHkvYfcX8n1nmV1
 tTY8kZQW+eEJxtZv9fh0mxsISkafWSA5Yt2yLXT+fJK68bQb5yMwUJWdSZa/a3KBHlB6
 aDcC54R64Y8rIeVYltxmjioTYh//srz16C8eFqdN3bWgIcTT9IuGWCzlls2xnMO3kR8K
 FR30OK4GeyZF8lMJfU8RRfGTj/m6k8wlI4S2Qem+j8foG2hmDJrVPRTtnrstPRX57SRv
 fumg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778530777; x=1779135577; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uHrXelzpk3U56/AkIJBgiv2/PKvZi+vlY6nIiNpbELY=;
 b=oNdO2s1RbmWFw7OYPON5Fv+R/9ntxnm34QkgiB3yBnDdVTGmuO2O17974JbtV1mrIg
 L2CuucD9YS77+a+6Ml6NjeMKEZdv5KX9hGDq3LHZtqYVNTYoP2VG5KGuxbTc9CxpjqOQ
 SabuiMoQX5qzy/Worj/KJHraRxdUs2b30bK1U8rxZDmHuqOyhhz50MeHuM4r5g8dWCll
 x3+r+Zh3tVlyyY9+C28HrfV2wEw4fGKC96aoPNQmJd9kA6wMkmTV2TgvvdDYaX4q8yJK
 A4H1fvH25LPKYSwrCZ1KxNwgr7GfIatjjT2MRYWrCvK3qlFyJGC00E2g61QsBjK3fD3E
 7Qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778530777; x=1779135577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uHrXelzpk3U56/AkIJBgiv2/PKvZi+vlY6nIiNpbELY=;
 b=b05EQ/8au02gkAO5dnUUpkZMCuHtc/2hx8Qtk/lyW/reCx3pqHa2A9OJUoZzOrSjD9
 /W69TyrEhjo3I86yWiyZaMcSA0X+mIsIgXs/gitjqBYFxP8RftAXpqXES0fgJd2iuXFF
 9Bu5oDN5l+4sNGlZBH1VqEFX3LrOKjuSMBBec5Q77GiVeObb2rFG4lOdlxOlb4PqXm7w
 KPXvUCXUfN2/UtpVkaqoTgOOO01X9yypQiUhyhEq3UkJyZkmTi3IrhFxbw2KXc2YyO0P
 BLD0O1uwaX+m/oOfK6KxrhIxHYgbHXV4SYWBxXz64hUgVVS0ZLdsNvl7cQ1lIF6K6f6D
 2wfA==
X-Gm-Message-State: AOJu0YwQbmBMoBsPCABwJC4QCpVyzITrhtBCa+etjWX0ZYFfHqQx8XU0
 xEE3iydXrAeDolxbc8BIg3x/YhvHiFblgAyIPWsDTNdwi+Mn0130xnkgajx6x1a8GwN7xTq4GyT
 vAECz7v0IuvFB/1XxC6sMe03fWynrMFw=
X-Gm-Gg: Acq92OECep5OZPI5vmYdr6j9IgK+RSyIIyZ7yMQMF+XhGd0+oSQJlkHxYI+MyVl/yCy
 k5dOK2dpVU96J7LoPhJYbLp4n6Jd8U4cz8mbLjy7e9wNK5SlZoV87vK4xzpDtnHWImC+TVI15zP
 2LwioY/jIYhknuMJdz6cbeJa7C9RJtbJe6lJwoJYy4eZSmq0rolNyV+l3d4l6jrJiDubNeAtZUM
 DP51csy5pcyFRT/+pNQMrGVWxNn8HzYUoBgn771JQjIffl9HbKoGzLG2l85IgaPkofADZ9v7JvS
 16jrLABdqst775DX0ygDzjiCXxudHOSUqoOPhSE6aP+WAfuSPKPM6bZ0Ex2OBh91SfsQ
X-Received: by 2002:a05:6102:5129:b0:633:e67f:b7f with SMTP id
 ada2fe7eead31-633e67f1352mr2631184137.25.1778530777484; Mon, 11 May 2026
 13:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
 <20260511-mips-octeon-missing-insns-v2-v6-16-5062889c4d3c@gmail.com>
 <0071f563-ba94-4c9a-ba4a-7999a0881084@linaro.org>
In-Reply-To: <0071f563-ba94-4c9a-ba4a-7999a0881084@linaro.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 14:19:26 -0600
X-Gm-Features: AVHnY4IaXkMfz-uvaM4E75oKBa0bZ0KttU3TP4YuRlHoYtkNMegRPuIh_9dvipw
Message-ID: <CADvTj4qtPWwM2+V+yF1D_3xv_5Urh-MuERQte=EqkdYbErXKBQ@mail.gmail.com>
Subject: Re: [PATCH v6 16/35] target/mips: add Octeon MTP0 instruction
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-vs1-xe2e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, May 11, 2026 at 1:58=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/11/26 13:22, James Hilliard wrote:
> > +static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index=
)
> > +{
> > +    TCGv_i64 value =3D tcg_temp_new_i64();
> > +
> > +    /*
> > +     * Octeon3 two-source MTP forms load lane index from rs and lane i=
ndex + 3
> > +     * from rt.  Legacy one-source forms encode rt as $zero.
> > +     */
> > +    gen_load_gpr(value, a->rs);
> > +    octeon_store_p(index, value);
> > +    gen_load_gpr(value, a->rt);
> > +    octeon_store_p(index + 3, value);
> > +    if (index =3D=3D 0) {
> > +        /*
> > +         * The hardware description and register-state table define P1=
 as zero;
> > +         * model P2/P4/P5 as zero for deterministic emulation.
> > +         */
> > +        TCGv_i64 zero =3D tcg_constant_i64(0);
> > +
> > +        octeon_store_p(1, zero);
> > +        octeon_store_p(2, zero);
> > +        octeon_store_p(4, zero);
> > +        octeon_store_p(5, zero);
>
> Likewise, where does this come from?

CN50XX-HM-0.99E is OCTEON Plus documentation and covers the older
three-lane product state. Its MTP0 definition is P0 =3D rs. It does not
define the OCTEON III rt source or the high product lanes P3..P5.

The behavior modeled here is from CN71XX/OCTEON III. CN71XX defines
MTP0 as loading P0 from rs, loading P3 from rt, and setting P1 to zero
in the description/register-state table. It marks P2/P4/P5
architecturally unpredictable; I modeled those lanes as zero for
deterministic emulation.

The P1/P2/P4/P5 handling is therefore not from the CN50XX/OCTEON Plus
MTP0 definition. It follows the newer OCTEON III product-state
definition.

The legacy form remains encoding-compatible because cnMIPS II MTP0 rs
maps to cnMIPS III MTP0 rs, $0, but the modeled state side effects follow
the OCTEON III definition.

> The octeon2 manual for MTP* are quite simple, writing to just the one reg=
ister.

I don't think you have an OCTEON 2 manual, you told me off-list you only
had the CN50XX-HM-0.99E manual which is OCTEON plus/OCTEON 1, not
OCTEON 2. I do not have a copy of the OCTEON 2 manual although the
OCTEON 3 manual presumably should cover just about everything there.

I emailed you a copy of the newer CN71XX-HM-0.991E OCTEON 3 manual
I found yesterday.

