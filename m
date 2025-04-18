Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF97C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 10:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5jFS-00017k-2r; Fri, 18 Apr 2025 06:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u5jFQ-00017X-2O
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 06:47:04 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u5jFO-0006Po-Ii
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 06:47:03 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2295d78b45cso28931395ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 03:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744973220; x=1745578020; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPYs8SUhDDwuuvv2w0Us8LWBm85suq02AsNoBCgYyIo=;
 b=NfQ4kyaY9iqnekb7ovc7zE3XAdil2DD+wiD9xGS6KA+hzV2mnCyb/+NHykjD8SgyHj
 j/3rvNuH8gqHLz6roN/OoHRU56+xbqSxt5Sg7WRJdNsM/pU/6RtZwaBceoGu6lNhvI+g
 IutVDd3HI4J2I0naDT0pbSb+hlAxbhJalEtYgKrMYMmrx4o4Ku395dxks+X/zoxZ96CS
 5zYEKUk/Y7dp8oyoekkoRwyIhk26p5GQwZcKfBaJ0W3HC7B9eTKFlSirtLpWOMv6pPiA
 KnmGz1O76aYTGUlerRKUCpU98wSCatGl0BpRGzIY42nvTlOh4gMF+mYVYW3sy0fykaC4
 qAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744973220; x=1745578020;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jPYs8SUhDDwuuvv2w0Us8LWBm85suq02AsNoBCgYyIo=;
 b=pAahy4Q2ameoXi23uD5VBhUuum13ZMJKheVLhN9oU8BMeL3VDJ8R+BpqgFQnlfyU+2
 ut/MaVPgG/lg5/n8YhFISmw+N/bovo4VEHqbSbdCs+do6jjAmbCK46mdkLUF6QYcw6hr
 9XzPD3xvXMlKux+yOsoCMb5jH/7UlAER3jGS2kYG8jEzYYC8Zf+ULjC2yERVNXZiTqPF
 1Qc+supKU82EeLu687YdVLM/Wk7Ko5xM4e0/A1v6Smqu5nB265cgLFyne99q6QKkBiGv
 BOD1H6hg/++wPoC0zrZ1hil0+D1fkHfqhbKsRZrPI1Cyrq1OffqlKypgr1HoS6KTWBOl
 th8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb3ZoeT4bzazEl5hPjU9Dkwz62ySA+mi5JVO6hCJXk/6301CYxemSGzQctETMfBtJx14qGmVhld90f@nongnu.org
X-Gm-Message-State: AOJu0Ywmgth+CP6G0DYDHYH8WWKdz8YAMvREZX1WDRwjcQagIFgaHthf
 ebsJ0vrDA4Og60M0PrFn27un6wo0LMD48Qh6/e+HIw6zwNjcA9cF
X-Gm-Gg: ASbGnct2GHD217kCpp8o718gq4DssiyJkDYb5dNV/COfjqsJttrVa9zQ4xU814F+qqk
 HtrXlMQ7pH5PZyAcLD8BIXHLjvDaLU0RKdL59iJk2qjr+em+ZwhYAgcnhuy4hS4CjeTWTKQYkHL
 4W/ExsN44LD5xJf2E0d/E/bW4eS+oTbLufStS2wlHfpjfcJx+TCbQijdPe9OaA6X1sA8IC/fASt
 /x6asemHSwc8uQOQSqGziOJg59wcaSffxLYf5v+ddzSUOYWNGTWTFLYnjToL9m+3Era54qTXwXt
 CX/UwqFEs0YCxcWvU9zIoGsyWmavhnVN5R9tdRqNQTfx2xapE3maw1dmZeJpcmwmNg==
X-Google-Smtp-Source: AGHT+IHIlltKy8pK1Iw8zABbC8QZW7fdpKWqwDNvBe/l2GUaG0pugmi48ZbyvPbQzUss3z449xrgVQ==
X-Received: by 2002:a17:902:d4c4:b0:224:5a8:ba29 with SMTP id
 d9443c01a7336-22c5361b3afmr32910135ad.43.1744973220518; 
 Fri, 18 Apr 2025 03:47:00 -0700 (PDT)
Received: from localhost (219-90-164-138.ip.adam.com.au. [219.90.164.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4816sm13945315ad.131.2025.04.18.03.46.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 03:46:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Apr 2025 20:46:55 +1000
Message-Id: <D99PDOQBOJL0.2MX82UOFOJ9FK@gmail.com>
Subject: Re: [PATCH v4 153/163] tcg: Assign TCGOP_TYPE in liveness_pass_2
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-154-richard.henderson@linaro.org>
In-Reply-To: <20250415192515.232910-154-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed Apr 16, 2025 at 5:25 AM AEST, Richard Henderson wrote:
> Here we cannot rely on the default copied from
> tcg_op_insert_{after,before}, because the relevant
> op could be typeless, such as INDEX_op_call.
>
> Fixes: ...

Missing ^

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 05604d122a..3c80ad086c 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -4408,6 +4408,7 @@ liveness_pass_2(TCGContext *s)
>                                    : INDEX_op_ld_i64);
>                  TCGOp *lop =3D tcg_op_insert_before(s, op, lopc, 3);
> =20
> +                TCGOP_TYPE(lop) =3D arg_ts->type;

tcg_op_insert_before/after I think are only called in these 3 places?
So after this patch, the type assignment in those functions looks
redundant. Maybe you could pass in the type as an argument.

Thanks,
Nick

>                  lop->args[0] =3D temp_arg(dir_ts);
>                  lop->args[1] =3D temp_arg(arg_ts->mem_base);
>                  lop->args[2] =3D arg_ts->mem_offset;
> @@ -4480,6 +4481,7 @@ liveness_pass_2(TCGContext *s)
>                          arg_ts->state =3D TS_MEM;
>                      }
> =20
> +                    TCGOP_TYPE(sop) =3D arg_ts->type;
>                      sop->args[0] =3D temp_arg(out_ts);
>                      sop->args[1] =3D temp_arg(arg_ts->mem_base);
>                      sop->args[2] =3D arg_ts->mem_offset;
> @@ -4507,6 +4509,7 @@ liveness_pass_2(TCGContext *s)
>                                        : INDEX_op_st_i64);
>                      TCGOp *sop =3D tcg_op_insert_after(s, op, sopc, 3);
> =20
> +                    TCGOP_TYPE(sop) =3D arg_ts->type;
>                      sop->args[0] =3D temp_arg(dir_ts);
>                      sop->args[1] =3D temp_arg(arg_ts->mem_base);
>                      sop->args[2] =3D arg_ts->mem_offset;


