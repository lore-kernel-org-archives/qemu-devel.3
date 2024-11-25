Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183C5D3B7D0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 04:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFQIN-0007f5-Ky; Sun, 24 Nov 2024 23:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tFQIL-0007ea-J9; Sun, 24 Nov 2024 23:01:53 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tFQIK-0001or-14; Sun, 24 Nov 2024 23:01:53 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-856e76fdf11so891010241.3; 
 Sun, 24 Nov 2024 20:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732507310; x=1733112110; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20z6im6nQ0/3Stjv9eBtZ94i8AdjHF2gyGmqoYlguVA=;
 b=ahnkvSf/dc7bGeXKnVRjvMZOxeHCTLBO8c319FbsnDAPBdrFlLyRbaIGca32OuctwQ
 QHv6r4Ao4VaN2amcvYXAC1HktHXnkaCZVh9XM22YfmAmB8I9bCXjck9xrtiOaqsE3IR1
 IG/kjQiZiDP+QXowPVgHyQNg7/SI1xqShNfOA8ovMIC5KT3Aly+9KuGtgrWQYgoPEXYI
 LHHBbwE3y7ecgaoiIIRJCv6k2OaEY3TLmo+8IJRFrfgcOxVV4wc8OCivevzrIdAL9bcb
 ncegmQjSKedOXDSlgxu6CDErCvtFh09JmHAOsBhmUN/9hTKxYuZAIhlXuXwlPqhsxIzL
 IcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732507310; x=1733112110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=20z6im6nQ0/3Stjv9eBtZ94i8AdjHF2gyGmqoYlguVA=;
 b=Af94V60iV6pX65mPTzc8wU3M8FVgjBsCFUovXJAgOuspVYqpd4HpSzueoK4pFMjDcg
 Gltb7IfGF0FJxWtVvyNjWdluDJ/FSDVYbpxBVy3WNsYeJR3RwnUBSYvAuSAqStVb3ckO
 b4SYBOzD10a+UzjkF0uoObcckPPaKAJdxkFt6yI+vCR08oYL7NBFH5620Ar/ImCzhk2u
 +kpOb3dX7CLzlCwvubJ4gcvz/oaTbLCq4v6sNY3sI3J849CnQBLsnbjBGpOgIx0wwQ6y
 CiKDvDsipHoq3uhvsixrq/eJj6NKCo6Wj99B/SV6PI2kcq4CUF593jr7cXvR3ZcVHGgn
 bC1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh6h5/E7AqXb/tMXoxv0kvIqMrNfljPoY2dkk/NpFMKO7ivuzTbXnYixJGlnh3+WhulpRU3dqb2EOizA==@nongnu.org,
 AJvYcCX8XSBjMTnnFq0mM2iBFbeEDy2Tv31s1YiR+K3pg3sjSr1X4/9noQ6dZvw7HUyzEnTb8M1CeCs1EvEM@nongnu.org
X-Gm-Message-State: AOJu0YwQNAjfBwECnygMZa7rAvsheUBYVQTHkXDBiKN7mYszhl/B2I/a
 PgQ4wz9G1kGacfuGdoSa7RZq3/aC38moWq/J+DK0pH12rjZQiCuWsincCvy9ztQ3NaFWQcR8917
 PQhWjH309YPNUSBmluHYox6LDovs=
X-Gm-Gg: ASbGncswoQYgN7MoSIlh1ylLKOS9WPjVn6ppcdoP8kwV6RA3345cSKFqP9B14Ix8FaN
 mIXWb41V3X84BtNiFU/QCx3LF2e1J6EE/Zerr6zHKQEZ3Qap/4K5Fe/N08t5C2w==
X-Google-Smtp-Source: AGHT+IEfEOY/cHzvXVpQKDoqa3TUzwRT9qTeVTkmcRfnK9dFpxALGhCpdLLeLBFD7blv2MWhQxg+AJV/EZMuEIj6Jsc=
X-Received: by 2002:a05:6102:c52:b0:4a4:878a:e3b7 with SMTP id
 ada2fe7eead31-4addcd33997mr8552423137.22.1732507310149; Sun, 24 Nov 2024
 20:01:50 -0800 (PST)
MIME-Version: 1.0
References: <20241121061259.4043177-1-baturo.alexey@gmail.com>
 <20241121061259.4043177-2-baturo.alexey@gmail.com>
In-Reply-To: <20241121061259.4043177-2-baturo.alexey@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 25 Nov 2024 14:01:24 +1000
Message-ID: <CAKmqyKObuwwp7AGrUgNWO9PdzBW0f8FFTrhFBVqij8ZOy+RQAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] target/riscv: Remove obsolete pointer masking
 extension code.
To: baturo.alexey@gmail.com
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Thu, Nov 21, 2024 at 4:13=E2=80=AFPM <baturo.alexey@gmail.com> wrote:
>
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Zjpm extension is finally ratified. And it's much simplier compared to th=
e experimental one.
> The newer version doesn't allow to specify custom mask or base for pointe=
r masking.
> Instead it allows only certain options for masking top bits.
>
> Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

Wasn't this and part of this series previously reviewed?

Alistair

