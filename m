Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A03C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjf2e-00066k-QL; Tue, 14 Jul 2026 11:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wjf2R-00065E-Rs
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:27:16 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wjf2Q-0005n2-9Y
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:27:15 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-81eaf3709b4so17696397b3.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 08:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784042833; cv=none;
 d=google.com; s=arc-20260327;
 b=WmXVOQwr43T0LT3mdf8u84K3lBilNNZMkm3i/NedTf7QBP9g24I/4hZuXIrVJmyFd1
 Ng7XsRXfLgj2rw/HtLMxt6jZC5EzO63ZXjC8JhSOlFPbWwqWATlH7seepvkpYxxhJ2lj
 ZjWmkchOzNyi6n7lWjRgpgPJCG+t6Hk+wNQLsRmjIFTwJ5TzdhUtIlKrILObYq3lMSsO
 kVkDltj3+d0okHa4Ti5x1m0NM5qVw85iMiydjNarCxbwYdntbgmDlNSgMVSg1n7iM5UW
 aAjHSwnXqSqoWQT2Ao9It4nE1pkuCVGRLsXNwEgRjQAaFKrbIPNJ4N1t1PY8yhITIStr
 Y+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zDCrKapO5C+WvYB1C45nVy3NZ4MnNXizM5QOey8jfgA=;
 fh=PgvuDsSrN5tO339qb9tpnPzNGxQ+CWeig4WyWwbLr+Y=;
 b=rczsGsyuRT55DWJGF4b8vGDnDfEaA95X1QbgYLteIRtM/jcJ/Z8QK8ZOOGaaKpBdfB
 moJCCbzK8l/ZHL4Br9WA+9KoZIToBIRRWLxCHuZCuAxVeZQWvMReZhfOlLgZUWN5uDMp
 oiMHu1koyNBN/ts7S05p5Q7qGJOBChhzhStyu3GdY+HzHZLeuw/lu/ERTASxTTxm8HrI
 EBRWQAXpkmEaaqhQML/JY93QAsfK+Ge876Pqp24j98AI1DTrETIr/jpqfHCr1OtO6Hbr
 8uNkmWn2az+epIMvqOoIEG7+a8R9nYO1u8sTFSxYTl7lNFDdjLLjH3vodrKXkzwHdbZs
 BEXg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784042833; x=1784647633; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zDCrKapO5C+WvYB1C45nVy3NZ4MnNXizM5QOey8jfgA=;
 b=bjso+moQCmmlljSWbhfVxYam1JrBF+r9x0FdQIJxtsekdvvJSItzCX9qNJOjP48x8u
 PIdU8/zhvXcPPJeacEcktF8bkP1XUvPJ6YfLNBazkOYKtibpJvCV4gh22t5eJ8f09RsK
 YV1/TM8y5vwpRpgTLYLbi0SinzoYrEFjgHyOIIC6nNE6CdicZnGsH10+pP3wP/FxpgFo
 sGVh+q7P0CVYV0xL8sAAr68EVQS3ZMMpRjAT0THNRSJ9dcgJbWWDYQzhCmKz0Xcwmj3U
 lGxs5ldzOYfAOY8vK+qKhSNCFnfM6lTy/IFCQ+Pi7CLNh3iC7kOvUxBaoOwiNZw3U8Ax
 LUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784042833; x=1784647633;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zDCrKapO5C+WvYB1C45nVy3NZ4MnNXizM5QOey8jfgA=;
 b=pePOMMA7VQ3i3OGuWFDXI4g6TpLAlpcyYtGmdDqsXCHkXgTRghflVDJrnf4DFi/ACx
 PBE5S/7I0VY0xV1T725q3FZ/nhGhs5/zxxor0+j5fC4a2ur8FMLtHCfiI5kQq4ke9O9T
 uEJT+lKeOkYmlSwsBzR9X/bmGhEfXQhLzAKC1002lyvqM9Ef1GsYgqE7Kv/mvpyI04Iz
 QnHknwTROAr8R39FVlHJ3kY5mxS0WIn//0eM8LrajUPEMtHIb4GI/SL1gcnVKrnf2UEg
 WnEdNWce3xP76zNEBxDPHUVGXOROOdE3pgiyFulJ4gbGXtSsWniAp+Wx52eDEfFaxZFw
 Y4Hg==
X-Gm-Message-State: AOJu0Yw5JFLgf527VCwl9BRz+5V3JRgKAPM0BnSAScQVK6n1q1bgFRVr
 5karbMkw5Dumq33reZMedMsLtIZ4u/6a8yPctLu5iT+Tu3AC7fA8HaUzc2asFhzFM99lxIOvHJF
 vzA3uVz57YXMm/+JaSnpo5s0HsrrEnPA=
X-Gm-Gg: AfdE7clNv0XxQX0cwEgemZwYnOQM3mdF5HvfaMLAmKm0JbuBEZ9Hw/tYV08g8YacIGC
 BQs8bPI2epzpYGFcqFqzbzn6VdmWqP5mIrTAeZNYc8YoHBeMmD+BaRxqdQwIqCKdrzFDHO+aKY2
 cDBid6wkxuydM0YbYd5jeZ/X5jkvMxgJJysfMnLoMvbBfzYjSy85pj5k3X9Uoak+113XV97p2YK
 4NiHV5zaMymmyOd8Kb2dWXJgmwOGR0eIDhxwcnG6ZId+EMzaWUeE8lRrW2EwCXnsH/D6tjb
X-Received: by 2002:a05:690c:6005:b0:80d:e214:c2bc with SMTP id
 00721157ae682-81ebffe4a65mr19131057b3.35.1784042832785; Tue, 14 Jul 2026
 08:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260714124621.522948-1-clg@redhat.com>
 <20260714124621.522948-5-clg@redhat.com>
In-Reply-To: <20260714124621.522948-5-clg@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 14 Jul 2026 23:26:59 +0800
X-Gm-Features: AVVi8Cc9Dhlc8yy3a3Q7CaWihlRAYYbo1SDUC16ZVqPRfi9yUdePuYn02kkwdZQ
Message-ID: <CAEUhbmW+LvM+2nP7uLQgEyTpfZNXp=jt=HOV_9g9F96k6PYXkg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] tests/qtest: aspeed_smc: Add Quad Output Read
 (QOR) test coverage
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bin Meng <bin.meng@processmission.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Jul 14, 2026 at 8:47=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:
>
> Add read_page_mem_qor (CTRL_FREADMODE with QOR command and quad data
> IO mode) and write_page_qor (user-mode QOR) tests.
>
> Link: https://lore.kernel.org/qemu-devel/20260708111544.1440761-5-clg@red=
hat.com
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  tests/qtest/aspeed-smc-utils.h |  4 ++++
>  tests/qtest/aspeed-smc-utils.c | 43 ++++++++++++++++++++++++++++++++++
>  tests/qtest/aspeed_smc-test.c  | 16 +++++++++++++
>  tests/qtest/ast2700-smc-test.c |  4 ++++
>  4 files changed, 67 insertions(+)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

