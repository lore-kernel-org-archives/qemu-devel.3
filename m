Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2280CD13DE
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 03:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIe7K-0000IH-6y; Thu, 30 Apr 2026 23:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIe7E-0000Hw-Tx
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:00:33 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIe7B-00050H-LF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:00:32 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso319992366b.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777604427; cv=none;
 d=google.com; s=arc-20240605;
 b=U74edKFmPaJm3hGiVMjHmDKFxOhb8ujfufzEfBDe0uWXwl9i7FW8jwpDrt/m/nnKKg
 iEGTKXdAV0b7xwYW2R4qbJSkMxxRr1axDbKytT2UD276Y/SrpbZofLourvEdEjEx6YIy
 fw/qde1m0C1qSO23F3A9sbwnplIIdOoKxtNjNICkO3hMQb2i6s1g1o1NuRnC6IlCjs28
 z6e6uygCorWNGHJEDfWd3/lM8GCKm6jF89sRzdtgeDFYvJjoovjjjO2JLMlWF+BOgNP1
 X8NTlSuPAdcVAfppCtisCC9KGxqTddNf0HIiIdPgRo6OP/Y6K1vcFOfNHybuCnVlqMaF
 GzKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=G36MBBmBr7o8c6QoTHrb3LMTJzMpT4MLtvETJdQJiik=;
 fh=fx/r/twi0lR0VsLAVqPkirIE7VN6h63K7UWTunhhuts=;
 b=aIsri1VrkfPcFmpQTA7JNYtQ5Ps2jJY0Jom+X5/2Oc9FKmSMWbxY2me/Fw+oOKOvLL
 PVveO/4rd1ia0+7hBNqh+7/I9GET8GOeVIqOLP3ed8hbxN3wJl8BP2h/ivDvrAf0XwwS
 A4kvoOdGtCOxFlSV32jbUkFqRZhe65V9/JhvpUi1/SbRGMQPFaD1SNeIqlf14JdCHBl9
 x10wda8mBcDZ7CmbtoDBPIHmVN4XUcrFZziOiWhVQCEegPM2F5jt8sQMb6HpZlB+j9O/
 RewpY/cXHFJPmM3eZsShNM6iSfZFcLov4jX9n4SfA//yRPkworLZ4191Na3YdzA4AZJZ
 u0gw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777604427; x=1778209227; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G36MBBmBr7o8c6QoTHrb3LMTJzMpT4MLtvETJdQJiik=;
 b=Pj7vLekh4cD9m9arsliSE9QFjjvYjmDaO9O+hMyAos/SzS7S7SQOc26JUTWQ/QP/mz
 RBJsI23TRwnePE1uIE64EM3/IKq29T0X7BwUBdgF1UvXruiE4wjLzm6FWSvkgLmoRztv
 3u9uahJiR2xGGpyzX/bkafx0DNrNPmwAwq0fmmYK90bpbRJoWKdB+yMEXktTWYaUMqn5
 Yv/DgJ+ioMTM40Neml+LJS/C5FhpB5mhiI5RC3eR1b6JfyHLjbPWpqBAQcnmGtchsumD
 ivBITvmUm5cWevLG2qmQGWDmkTFHf/PR5Qexv1ZQZvBfHkkHHKB3LsbWUPY/PGsiMBs/
 rEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777604427; x=1778209227;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G36MBBmBr7o8c6QoTHrb3LMTJzMpT4MLtvETJdQJiik=;
 b=fo56/LG1LKHizg6/ufJECoTY081K93AkdHAO7NMePEuUu+KsSVYkLJ+hFZqRSFVuVY
 /IzM8TYBPUiN1erPEufcbz6gU3tsNv4E3kpeQvkoCu1TonDSKjiiS+K9v/tyU5ZYO6U6
 JHGk1uCojFCH5Ylq9iJaSCm2ohow7t91bmmY1NK3/ShGx0IXeH2Y5KlLcg/5rc5sJi1h
 TE02Ypxq5MOBqoPqAsaaNmQAul8d1eemuz3zZiR/c+L5reOhdz3yGQ7J2AZ0dJcHZh18
 YgpHuOsglw9XBj+pXxqo8qw04Rmo1WW8V+40eqtQMqcGRmTPB60W5tbBrBYSS3efqjud
 Y2Xw==
X-Gm-Message-State: AOJu0YwnZT/MUELQXIC025ZqbPthnzE6wAqUl5+U0wO0kbQEcA05FRmE
 pqSbNhsgKwWB4UrQAyou6QVpXAckFfJZSu9/SoPdIge1aZtrdpUzNmdYlpGNrWLPSQJY/Hr3YIK
 TJkdm3GqWQIaG6SL8TvorsVleuEz2e+gL6w==
X-Gm-Gg: AeBDiesC5+vug1m9sAmlSTLQ5bG3jBj06Pjya7I61Rtd6gYHLxIr1r3PozaPQrHdL5J
 cuF9HMW171J3SItsTumzVLMcpIpMSLtnapwtX/0aHs/GSeE0lUqJNxO/myHeW0qxLl52WyeWkqI
 hOqb8EsOLXa5JhRydA05NwqaiEkKMApy3j6YdQTr2dpLD9PBS9ueu5nEdRRF+oWGqxJXgKJppCm
 4ThnFyj+5FnzNyUPtA5NvQSG4MmJ7e4/BetkQltAR8RFIn5rHV/9T98XrTMyGdHU3sGZsZzdRVw
 gi0QjlcdilJi/d57FD1BZfJIBJCwdb4PQ+7BBRFUq3rP/Y+L
X-Received: by 2002:a17:906:895:b0:bbe:37fe:89fd with SMTP id
 a640c23a62f3a-bbe37fe8a45mr132892666b.12.1777603803667; Thu, 30 Apr 2026
 19:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260424050509.3935180-1-frank.chang@sifive.com>
In-Reply-To: <20260424050509.3935180-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 1 May 2026 12:49:37 +1000
X-Gm-Features: AVHnY4LyPZ4T0iUUBgSM5qDBKb08A8vh6igDgY2WEcHFnCh6_WNX2k8l4lzbVJY
Message-ID: <CAKmqyKPjWAWnjSjO4FL_bQn=5kJvoHmjpjo+G==JSq1JYLmgpQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Set MISA.[C|X] based on the selected extensions
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
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

On Fri, Apr 24, 2026 at 3:07=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> MISA.C and MISA.X should be set when the following extensions are
> selected:
>
> MISA.C:
>   * Zca and not F.
>   * Zca, Zcf and F (but not D) is specified (RV32 only).
>   * Zca, Zcf and Zcd if D is specified (RV32 only).
>   * Zca, Zcd if D is specified (RV64 only)
>
> MISA.X:
>   * When there are any non-standard extensions enabled.
>
> This patchset sets MISA.[C|X] bits based on the selected extensions.
>
> Changelog:
>   * v4: Warn user if user disables RVC but RVC is mandated by Zca/Zcf/Zcd
>         extensions.
>   * v3: Rebase to the latest to-apply.next branch.
>   * v2: Fix the missing parentheses bug.
>
> Frank Chang (2):
>   target/riscv: Update MISA.C for Zc* extensions
>   target/riscv: Update MISA.X for non-standard extensions

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.h         |  1 +
>  target/riscv/tcg/tcg-cpu.c | 54 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>
> --
> 2.43.0
>
>

