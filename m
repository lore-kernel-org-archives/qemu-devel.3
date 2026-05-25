Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5952ACD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 21:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRdIJ-0003D0-FQ; Mon, 25 May 2026 17:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRdIG-000332-Us
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:57:04 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRdIF-0007Lh-5F
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:57:04 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-394095009beso84101981fa.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 14:57:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779746221; cv=none;
 d=google.com; s=arc-20240605;
 b=Mrul8JjerWS8C80jOMc+IBmCkA2iGFSmlUqOl56eXWfDO/JiHHWQkvhNMJ76LshCWR
 5QIb+ZZuwx2aEOzeRwBBuWc6y/gKh5CSIQ2CxfHKnEd1Z0zwarudbY+rPI5cY4v5jVo9
 s3paMCSl6mV38pLbOOFkeIoIGQ1krYYgA5eZFQ3pGautcmYDV+FZmr8Aua9zv83Y1i58
 co1ElBh9I43it++uW/IvuMnUR6lEgth8zq1w+4OJm/1s0nkyjRitfFUWV3Xo+nNlCXL4
 /b4OdryaqVoqEFwp/ZntIa6aF7ZqgyTrrq+AC3OdvAAki0dtfx+LxrTfKPu12OhFWUGR
 vlbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oj1udp2JH+JG+CuTgmxXKZOz98hE3h3a8e15M42/AZM=;
 fh=lcGHBXp9cedPWhtn5ZVpzv5aGtONIMIq3iWctCG7NbA=;
 b=gYSZEBvSJL6nitIbhYZGWbYJlkmdblLUUx4maAov01hLylLX8evz460OE4aiitKH6p
 fMGMQ5mNyoKwBLQvQm35LYAtxEIoBOmmhXx6guukWVVREcM6riJWZeXEl2sujozxPBKY
 dSCNbheETZ4zNENZ5zBQNSHorfVWG9iVJsOXAKH3V8TK0nPAImJqas13Sr1Q6BwH4xob
 3qrP2Yijen30eLrd0yPL5z0nU6tnL3InWinOlJcOmRhIysKGZ4TeY3hP6p1BZltMZXcI
 O0jnE6b9wM1lhQ7jpTd8Jiu775n8HeJBSMo4qVBFoOwRUorIZe/YEApdz5aXbpqgHd/K
 ADBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779746221; x=1780351021; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oj1udp2JH+JG+CuTgmxXKZOz98hE3h3a8e15M42/AZM=;
 b=c+3J/D2a3MmfFckxsU+M4c2yJFbSbSYVXoLmS2qej2BZPGrGYlaybqgE8jyMXR38S2
 dFtIQjJMOGBSUS7XVeKxMJJVLf7K3BqmvDZSb6URYIXxnaHmEGmFp5VMhjgTwv34S02v
 CAebS/yO8L9KksatCz7MHMbpABLhB4ZvR0NnBhkvs7gB9dfysfoT+ef3lZHVSd/0wdT5
 xQ8yps4DimEg6ewsuTClyjAhi/Qpwkh8rubxWk6r18qO7WqR0gZFy/eMpYYDNgnovCqA
 B+svKtDEawDipbGHg6Nvc2p9/XoITQHCdECj/Rkcll3YrL90TX2P5LBUHvp0c0DOb4No
 keAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779746221; x=1780351021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oj1udp2JH+JG+CuTgmxXKZOz98hE3h3a8e15M42/AZM=;
 b=UfqN0MWLydU96fKDSi74nENHmM3UUAS5mEFaCgQZ0l1Lui77oK5vAh+byl71ebZe3s
 SwLa7B8YltDbduwfbCEHUzVFO0UeVuMHOEUO6MYcw+/AjgRw5IBe5vXs6JgjaReUMgBt
 rEFqFhnuBmypOaQ6axNmNd8c8FlRJexytm+edpF/deWpqmpMnufTWPiJKSthJJdAFgo7
 KTvPmnJKAPubK+F91LGlynf8NPneo7+aCPkEp5FiWB2MEWeOeFfTy5iWbjCZgG1fHKq4
 WaQec+AswA6a4zNw9Lhu8V0Og6R7q9lNoyfIDzcp2f8vBRQKueaSq0d1LS1VKDSh1nDW
 4kqg==
X-Gm-Message-State: AOJu0Yyi6e4Gx3rS08EVSt0SYi/nN5BBewsWfneluvyb9L9mlSs5CWL1
 TDJCZfZbrpAHfJP7HvaUjtNaYjL1S2FgMeDW8pLNu6GdGi2gxPowAWozSie99LoDmW8/NMD+qT3
 /Vr2WiYNyEI+afjF1MYvBj3/uHuIZwzSJ6tfM1DM=
X-Gm-Gg: Acq92OH41tRf4IDiUBYHHqB2ExXLEgweSAnuqxWy3s2xaEjnf8ZuT1Q5jJKbSZUxBaf
 H8JJC6PokWIo43P3cPuGYdxe/UtguqNgzrBPpMMzINb1eJzHgGUqiBQVP1QBzN6O+sh6U8ZOQJC
 yxh9JxiNw8EaIzFlOtMuOqqFGIl6QldBE2AMZzVF5wChxsJCGmTbzFnoAqF6VYS3NoumexPK0aJ
 9eeUfUFu7Z5gp5fZkw0QvDw3sUgHuCIB4gnBRm8VmT9eVU3qn+XfQql67LlcHMhy/dd7LgV8haH
 gTZFsR93vkxDhBz+5gW8
X-Received: by 2002:a05:6512:31cb:b0:5a8:eaec:7567 with SMTP id
 2adb3069b0e04-5aa323e0206mr4153384e87.35.1779746221004; Mon, 25 May 2026
 14:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260525152312.4120017-1-mattst88@gmail.com>
In-Reply-To: <20260525152312.4120017-1-mattst88@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 25 May 2026 17:56:48 -0400
X-Gm-Features: AVHnY4IzIqJeZHBrKhL1-wNqA8DbCsR_etE2hapCM98Y9lAan0gchCv24hpCRDE
Message-ID: <CAEdQ38GYKVg_4UYtKsOpEJO4Suq4TMLdZ8-b8Z1zbPjXdDDyGg@mail.gmail.com>
Subject: Re: [PATCH] linux-user/ppc: restore fp_status from FPSCR on sigreturn
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x22c.google.com
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

On Mon, May 25, 2026 at 11:23=E2=80=AFAM Matt Turner <mattst88@gmail.com> w=
rote:
>
> restore_user_regs() restores the PPC FPSCR with a direct assignment:
>
>     env->fpscr =3D (uint32_t) fpscr;
>
> ppc_store_fpscr() exists precisely to write FPSCR and keep the derived
> env->fp_status in sync: it calls fpscr_set_rounding_mode() to update
> the softfloat rounding mode, and set_float_rebias_overflow/underflow()
> to reflect the FP_OE/FP_UE enable bits.  The direct assignment bypasses
> all of this.
>
> On sigreturn, interrupted code resumes with whatever rounding mode and
> overflow/underflow-rebias state the signal handler last installed in
> fp_status, rather than the state that was saved at signal delivery.
>
> Replace the direct assign with ppc_store_fpscr().  The FPSCR_MTFS_MASK
> applied inside ppc_store_fpscr() only excludes the computed FP_FEX and
> FP_VX bits, which it re-derives correctly from the exception and enable
> bits in the restored value.
>
> Fixes: bcd4933a23 ("linux-user: ppc signal handling")
> Cc: qemu-stable@nongnu.org
> ---

Signed-off-by: Matt Turner <mattst88@gmail.com>

