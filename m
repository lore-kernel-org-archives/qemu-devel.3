Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F71CA0EE6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 08:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umqAQ-0001g2-MZ; Fri, 15 Aug 2025 04:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1umqAO-0001fT-Bj
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 04:52:04 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1umqAM-00035S-PK
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 04:52:04 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b9e415a68fso1569166f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 01:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755247921; x=1755852721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T6Fgvsz4TUcefPYGimAiSsNrerxbiOJDy0eMF3PqGCU=;
 b=rmKEhkh3v73NPyEuP120i1eTM04fAZeR6Y5TPNYeppoKMYDnxyq6vKSqdAda7Lu4aa
 5VnibnK/KZivGolqLLahd8iQMhEzCtaLcI77vFB/5DqP6eGJRTE34o1zIEbRvOhWOK/R
 1EIt1vcpxQRJ52LX+clHEUHAXaQdjaj6bdBIb9QVTsLJOBSSdxfUJv9FTojw9b2CSRJb
 lK9rOp8aJ81CNpFfcqmrF+e71kmAeGaDcKg2AphMbCysJu/E7ivWeqc7AcKt5YXu8Ddw
 sB0N8G4Bz23nfGJsHTzE5Wk0e4q/B3GhhUFT0z6ObY1Ul4zUrE0c0+VYqN6N/V99Q+Lv
 roRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755247921; x=1755852721;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T6Fgvsz4TUcefPYGimAiSsNrerxbiOJDy0eMF3PqGCU=;
 b=AKh+nVF9sDFmnPzZmJ6S1s08vshIOqdwFxbvMNnT9X9pc6ChTDYOmzoJSZpiXSCqBZ
 mBt34vT8VLlDEA6Oy/sHNc040GZtOMaZIco6CZyeTvzxahe5OsMn7BkITfqrrxYY5QbF
 pSqtv6Q713feyYQ7CIv7nyHaYwpU4QP3CDzBMcEDywPAu/gR+ph58v9SOSy/SgW+SSbl
 J5oPjZOAt4Swu6dbU/Tq31geJSZu/pDja7bandL5VA47Gn1CsB3GGlAWYGIdQ86oOY8z
 L8A4lbS8M3jR0KcFTCkwZjdafnIyK1dLr4uXKNnPfR+gOR57yp4ql6G6h+8+6mu3AkHj
 A6og==
X-Gm-Message-State: AOJu0YyqKJzY3s7GJ3ZzkjDxY4CEodgrwTdzjxAY+D1ATFIcPCVSIRRU
 NYk/R535lyI2bfu6jXdO9rvpt1zxco/kYxgx7UIr5tUf40hh2+F+t8vI1wrVgsXnjvg=
X-Gm-Gg: ASbGncuFnnnfnRi012SDdGXOtshVUUG0oh+ZZZmrNdRBA6GAzz06Ysm5EmHT+9B3J03
 7ncrN6WLHKCnZga0BFnKjI1Xy6ne/WtFTi8ishrE5b0hwl8h/cG8l75ev/X5duaROiUJ/FNhPOC
 jOQSrUHj30Dc6Vv4+BBURh8xeDH25FzvsqSi4/zUY+sCECep1gN9g6FTSlSAn9pQyZOm5gWyaqq
 qAag8g51rnTwrMxEpAuK6wSWhOFaePZPjgrrgQ01HNbyPiO4BCQ6eHUVQImqd3sJOduFs9lkSqn
 EL6oGLjojXxjEof6jp1IQ3bv62avPjc4EFkIOz9RfLivsLtj74QH58kBYKn26sgNNnQMY9P8Vdp
 k1kCjxyEnxwoyF0WvKmxpBMw=
X-Google-Smtp-Source: AGHT+IFVmVKZz0PeKYsl4ZXl5/dHyjNUM1P8/kfa4ZsICrSW3EvW77G71Qjwmy8V21o3ZEPSWv0GOQ==
X-Received: by 2002:a05:6000:40db:b0:3b9:13e4:966d with SMTP id
 ffacd0b85a97d-3bb69a82c57mr1039367f8f.59.1755247920680; 
 Fri, 15 Aug 2025 01:52:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb64758463sm1162220f8f.4.2025.08.15.01.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 01:51:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DA8945F872;
 Fri, 15 Aug 2025 09:51:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: gerben@altlinux.org
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 sdl.qemu@linuxtesting.org
Subject: Re: [PATCH] util/qht: fix possible NULL pointer dereference in
 qht_bucket_remove_entry()
In-Reply-To: <20250814113807.16146-1-gerben@altlinux.org>
 (gerben@altlinux.org's message of "Thu, 14 Aug 2025 14:37:40 +0300")
References: <20250814113807.16146-1-gerben@altlinux.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 15 Aug 2025 09:51:58 +0100
Message-ID: <87ectd3r2p.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

gerben@altlinux.org writes:

> From: Denis Rastyogin <gerben@altlinux.org>
>
> If b->pointers[i] is NULL on the first iteration and
> prev has not yet been assigned (i.e., is still NULL),
> calling qht_entry_move(orig, pos, prev, QHT_BUCKET_ENTRIES - 1)
> can lead to a NULL pointer dereference.
>
> The qht_debug_assert(prev) check does not prevent this issue
> because QHT_DEBUG is currently disabled (the #define is commented
> out).

The assert is saying you should never see prev as NULL so that would
indicate a bug so we shouldn't be just skipping.

I agree we should probably enable QHT debugging when --enable-debug-tcg
is true.

>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Reported-by: Alexey Appolonov <alexey@altlinux.org>
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>  util/qht.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/util/qht.c b/util/qht.c
> index 92c6b78759..cb7e367ebb 100644
> --- a/util/qht.c
> +++ b/util/qht.c
> @@ -768,6 +768,9 @@ static inline void qht_bucket_remove_entry(struct qht=
_bucket *orig, int pos)
>                  return qht_entry_move(orig, pos, b, i - 1);
>              }
>              qht_debug_assert(prev);
> +            if (!prev) {
> +                continue;
> +            }
>              return qht_entry_move(orig, pos, prev, QHT_BUCKET_ENTRIES - =
1);
>          }
>          prev =3D b;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

