Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155C3CD343F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 02:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMz6w-00015f-G6; Tue, 12 May 2026 22:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMz6h-0000xW-LZ
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:13:56 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMz6g-00027T-4a
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:13:55 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-67be41d5eeeso9291522a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 19:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778638433; cv=none;
 d=google.com; s=arc-20240605;
 b=SZI+Tnly6HQpBzVAD1VAtHc6Bf+QzG7ylChZhYVqc+hKB6nXaHFPo0LZWJ4ubPAH5A
 tuYWpclYqdL+sywX/97VcvO0iyDkWNPzCkvJe0eCH2BdjqNfgKGL2/IekXp/ylwXjUvp
 rtJQem4eIipfcxQRQCHqyWGw2v/qmSm3qyRVdlbn5ebg1G2LVj7BTaB05Bji7EcH6X+3
 PWul8suTWQ4IrHG7AwwZAXE9nFuLyfJdQCrV8iNIE3EWPORaAvMK82Gf6phwuZ85Ws2d
 r4VODVHnbDEo4xvcmZX7PnIenvjJyEE3j5ommiK3BmYltYThcQ1iSeSfTc6F7T/Y7/Ej
 Ekpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rc7MwJXnqBDt5QbBV0vxUmKzrD9CQaR3SSyo0DxMKlo=;
 fh=RcfPfWEJGy1LW5mJaQdkNxk/QOEDyvSgn6TJYhY5H8Y=;
 b=dmq13y7MOwoaHvyQ9dMNiJ7vEAqwaTm6KvRDTkx7yPbY3h6AqmBbTYCHbSzH2LG5kB
 qzJHuQro48FEnOs5hC1SGb+l1YpNg3la6ku0mfniQK8K7YKIxOUL7GwdUdBl7bTXlhGb
 JHHy7KjGyxSNxwijGJDL65+7r7NWdoHyeUs595AUsdubHdOnfLwVvpzxo4uqaRV45h7u
 0myeDMruHg0Df39/lQZ1lHkD7Pb2xC86T9CMmpOr0ZKDJNHNZwqLN10/McRG+Zvobc4J
 ny+8I3qr7H1Q6yzz6LKf/Jn0Xqf0xgnGFUM9T8ipCXukhY4CEXe/oq+Qq9GZyImaB/bm
 k+MA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778638433; x=1779243233; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rc7MwJXnqBDt5QbBV0vxUmKzrD9CQaR3SSyo0DxMKlo=;
 b=emXHpmJcatwRYkio+y4a3jk0RVNn+meTYsC97N3XvnHlQBdaeT71xgUXru3LgykZi0
 uZG8xGxCSwB2o84kDbhMLjKtikYOFHnwfF9vPFBKbIhJtp3oSJpSlE5YaWuk5s5Au92S
 UvZQn7om33Ybp3ueT9vHW1KB/fs8QjM2b8zEqCXlSn1o+BCAUWc6R2kFPz6JirkT5PA0
 p4JZvG51Jo51PEbpKfbGCrPi1P7/HIt7XgBm6BXugaXltmCrYBq0BWluAi67Cg+kDUBb
 ar09h8ta1/i+HCUCc37WNPDJkkSsyXMbzGYLjC6cxxLDAgIfzgcAxGQo7V6dZSuDhBq+
 eFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778638433; x=1779243233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rc7MwJXnqBDt5QbBV0vxUmKzrD9CQaR3SSyo0DxMKlo=;
 b=lXbc7zBJTbOn+tyVghtIkdHgY+stCztqzynlMBBundPULnYrOoMJHLfziQuxAIl9vq
 HQTDGxoH6zXOUN9fEBAu2Knr4RNzDIWXFr3Zu7BD7bzxAoiHwaZl1V2m7Nd/axJfVEt8
 V9YsFTTFbIO4C+NZImscoLHzo48HiALDkwybhqG3qEMFN65UsFMFFSt696Qc1bKk93Za
 /KgCjjcZuIIvJCnNDFolEbjrUgL9DvIZu0HFL0uRfOz4xMSofn6ETGedbBzTDrdnfI3H
 LENwQbtAXfLCsetVfF/PbGRvDfgwg5XJG+NC+KdTJ0RhCV33793Dv8SJUiT40MImtCo6
 7i1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/KyUSL0V61Px7LyWrqh0ygdd2q0qu+/Cnp2QMW3/VdgUMiNd+5HXQOU0YgAbedJacMPrezRAu0xdJ3@nongnu.org
X-Gm-Message-State: AOJu0YwHuByV0Vo6H4skEq13Fin+X0H4DgoS1Zs4RdJdoZi8WkAWPzhr
 0+XkXS07pOEoR1p+0Wh9g81JhOy0Poq16Zo26fEgByMV+MbLB6fcXheAfzCzW670fHS07/Rb+DQ
 vHWm4sTEFPlCf95ToFDccQNF2RY8sGWY=
X-Gm-Gg: Acq92OFK6clm7ko3ULICIGiAd2vGU9ZMOgE+NFSNZA/CVv9RL1yCXGWgSAhsx7TDSAO
 kM0GhfukW/mGDOr+YcW0vPi3K6iemsN4cZfuw4Th2OtFBbrQx8tNy5zZddqHbs8K6/n5uXnB9CN
 JcOx8/3gsHyNMms+0T0zPDfZ3ZQteHVjWUI6PiDYm/SH27uwAfYajJma8UMVPT1HV+k7D86kXIE
 I+BeQ5Ls3xCKn/RQ8hmKEwP/pk3TIkzz7onNVgGULZTU9fVOQstWvEJ9ySKUR8DjNa/HuGu4n2J
 2l6TCEi5tfHzlRhQaL33M3387hqf8jdK/UD/4Q==
X-Received: by 2002:a17:907:60d1:b0:bc4:6136:b6e6 with SMTP id
 a640c23a62f3a-bd3e2ec0920mr45468066b.38.1778638432550; Tue, 12 May 2026
 19:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260512094614.3464388-1-visitorckw@gmail.com>
 <20260512094614.3464388-2-visitorckw@gmail.com>
In-Reply-To: <20260512094614.3464388-2-visitorckw@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 13 May 2026 12:13:25 +1000
X-Gm-Features: AVHnY4IHOFTchUjGC8hXs0CiV28s49cg9E0TD2EeJkjEcqQYkiGgzvgNb3fxDDE
Message-ID: <CAKmqyKPpKPOgpKuY9wcyShzXw1y5vVgyT6Lx2f7Jhs8cqzZD0Q@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] target/riscv: Add stubs for T-Head PMU CSRs
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, christoph.muellner@vrull.eu, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, May 12, 2026 at 7:47=E2=80=AFPM Kuan-Wei Chiu <visitorckw@gmail.com=
> wrote:
>
> T-Head CPUs use custom CSRs for performance monitoring, specifically
> mcounterinten (0x7ca) and mcounterof (0x7cb).
>
> Since we don't implement these custom PMU registers yet, the system
> crashes with an illegal instruction trap when OpenSBI like this:
>
> system_opcode_insn: Failed to access CSR 0x7ca from M-mode
> sbi_trap_error: hart0: trap1: illegal instruction handler failed (error -=
1)
>
> Add simple read/write stubs for these two CSRs. By silently ignoring
> writes and returning 0 on reads, we prevent the fatal exceptions and
> allow to continue normally.

Can you include a link to the documentation for the CSRs

Alistair

