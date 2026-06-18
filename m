Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B28CD98F3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waAKO-0003e0-Sy; Thu, 18 Jun 2026 06:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waAKO-0003di-6U
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:50:32 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waAKM-0004og-HA
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:50:31 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-662d484ff3bso936902d50.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 03:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781779829; cv=none;
 d=google.com; s=arc-20240605;
 b=TPxQ2/eZlOjnNqSWMcaen8VzLIFyWvEjzPXSlNL26sT25y5t+qEQjWdXAqDWCZXwer
 znuY+FsgbwYc6qn1etPbc2oEH1zssfDVTcapoiEh6Ffoi572aDeHTWlQ5Zpio9sqru6K
 LcpgItJPaBWRwIKHItfyIZ+OGwjZSSiHxutfUoUvp7S4dTabwMYgS1vhqBGJAtu7BFzY
 oocuHYfXGrX2ep9migjJM9qPWZNSd1I+qLWuFaDbEsgq6skAQ30YKGsPFV+1uTUZj4Yn
 AMDixL8ct8hFROfsqTP0JgbUnKQx360gTf5MmzFUHXORORA04Yv70iFbTY84yZhuL9wB
 IkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/K4CiDUbzDT4I7+ZNcqP46vQLFKnFUOJzNTb8XQEagg=;
 fh=GEnE7NxLeXx9QkA2OZv4dhzcoiI89wgQi/APRRC3Ub8=;
 b=FB5cWMemUEWwsoQ1uNdZq0mHIjzRfoyF2M3O1/1lUUkNfLCLy3nZY5n82vQ1dsmfmw
 p5f5/Utpc4hgBaTZmw3LyfId8P6iF6fpctLy0p7WW/jx1qZx0KkYQEeOKlOGQLb/gaRA
 yIgB9qTlbvQ8M5XEXzeT58ugHtB3BdqA9dH63Ux43S3znKZMeae7z6VZHcwN3ufzZYxm
 0zPwb6yPVbnkAKLeOLWpS1u+aZ3YXCSPfwxFrEa0zNJhNbVWXjJFmcexrWAAjqzAUhCK
 eCzvN8ReHvu2A/aIheYboyughmZU1/krMXiU2ssSfciBQji7tOC9ef7TaLciAWYiZkyl
 kBOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781779829; x=1782384629; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/K4CiDUbzDT4I7+ZNcqP46vQLFKnFUOJzNTb8XQEagg=;
 b=BXVM6E+UDxYa9gS28g5z3/aevVYDo1qCYwrIsAsFTaZDss7c/eGm3IVQova9k8CvnL
 NwyDZ6arTPU/7pKSGQt2xsRvIbDrLfAbiopE//ISuEa5djAXA2A9Cr1Eh/lwxii4awN9
 VMzoHBeksRyobLKCUrqT8KD2vy6fZoOJVC+1+yCCB651VClwT9cXQvFFrwP9gwLL837A
 lpvoMZdSbDplG4XtK648xv9BDFHClI+whHkPoMyCgvoAFnNkJaeY9xfIEPaJ8+5kvv66
 pSgBk8blIS236uVCEP7kIhnPFsPg2TY4v910ImHcxb+k1KrfsxHqjnrJrcy0QLjti/eC
 P8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781779829; x=1782384629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/K4CiDUbzDT4I7+ZNcqP46vQLFKnFUOJzNTb8XQEagg=;
 b=G5WJXQaqOupABMS/LSHsQxzc3z8PzEvcM1YQkHLmvrJoUsgRKuCiJu9oWFfIiUE7Ok
 TcIG9eBCSN2W9zwshL2WFiQAqgPMx2IHemXW4eH2rJOGYehsXS8KW+Kl8Jp/YFNyhzm9
 SwPhs838xfGTqgmxYqVISD7kzQ79cL1KxUuXZUC7WLNZF+K+ywRn8TcR5tdDIi/U23tH
 o4QGuVUaL4fBHvSpJx7N9t4qioPNVNWYfIA3bXrzWwVYYd4wtPDE/hb+77kVjWSmtTDX
 iYAxjradTLGMANVVFlgfPQydurOdUZ9ZDV+9tFPif/umJ/ZMBJHN3aX68sp1zRiBktkU
 PPAg==
X-Gm-Message-State: AOJu0YwsP+XvChxcpBESlz5eghVzZxGCcQ0b+xuL7kH2uYyhriDlZfEn
 cL4IQN72tjMdKC7B9w76GKwQCJLOgwkPxFeAQKNzRBzALFlyItMbcGs5ZjcS0ZGHuUhy4fkGeJc
 t/s/wmrVe2XE5xxB63WtEF3WUylj3TQ58PFCwFj71FA==
X-Gm-Gg: AfdE7clxVR+HyUvZq6gxspwqC3+JjYb+oFLEYX4MuYc/4wPSZJz01jy5wnX2uPj9ii4
 yOgSJ3xsNdX4W74NsBvpsxlvN2Nif1Bk/vH8whv5vvkOUvtwocG6Zprn6u1XQCquv/54Jg0ra6Z
 JX3A3IWyMs/5+oJlfEJ04WUFY8EHlJWgaG3FT4FKkD5OBDlAsKgrjfK4qE5GhmqQA3EfXEI0bsy
 cBZ07xlZxmjF11/86IAL1SXLAT/zNyQHJWEi31amuA9uXHkslXqFfz3HnVgH9a+Jfp3XHJH0PZj
 vZQfyuyR9mhU+e1RU3e2OX7yKTrMjl//HLAJ1qFpspdBIg3DZ9KIQSZP
X-Received: by 2002:a05:690e:d41:b0:65e:5aa3:9640 with SMTP id
 956f58d0204a3-662cb9bbcd7mr7382103d50.25.1781779829056; Thu, 18 Jun 2026
 03:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260618104654.3840263-1-alex.bennee@linaro.org>
In-Reply-To: <20260618104654.3840263-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2026 11:50:17 +0100
X-Gm-Features: AVVi8CeV9ZILRtwNquhZr0S736TdDOt9YatIrliXJT5zIwqfWL-KFcgK2CJy1ds
Message-ID: <CAFEAcA_TgWCqVOBFfbQmPYn2zz3EEE1dKesecr1=ULajz2Kw0w@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm: use cortex-a9 mpcore base for CBAR on npcm7xx
 machines
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Arnd Bergmann <arnd@arndb.de>,
 Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, "open list:Nuvoton NPCM7xx" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Thu, 18 Jun 2026 at 11:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> CBAR is an IMPDEF register and according to the A9 TRM [1]:
>
>   In Cortex-A9 MPCore implementations, the base address is reset to
>   PERIPHBASE[31:13] so that software can determine the location of the
>   private memory region [2].
>
> If it doesn't we will confuse the Linux kernel as it probes the system
> SCU registers [3] and erroneously assumes the system is a buggy Aegis SOC
> and nerf the emission of SEV instructions, deadlocking any WFE's in
> the kernel (or QEMU smpboot code).
>
> [1] https://developer.arm.com/documentation/ddi0388/i/system-control/regi=
ster-descriptions/configuration-base-address-register
> [2] https://developer.arm.com/documentation/ddi0407/g/Introduction/Privat=
e-Memory-Region
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/arm/kernel/head.S?h=3Dv7.1#n550
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>

Cc: qemu-stable@nongnu.org
Fixes: 2d8f048c25ab ("hw/arm: Add NPCM730 and NPCM750 SoC models")

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

