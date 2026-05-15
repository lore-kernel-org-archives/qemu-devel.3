Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162C5CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 07:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNnMh-0003Nb-44; Fri, 15 May 2026 03:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnMf-0003NJ-Uq
 for qemu-devel@nongnu.org; Fri, 15 May 2026 03:53:45 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNnMe-0006JS-9P
 for qemu-devel@nongnu.org; Fri, 15 May 2026 03:53:45 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-65db820588aso6548680d50.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 00:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778831623; cv=none;
 d=google.com; s=arc-20240605;
 b=ZgQB0tIPn/8EwYNMNBLUsZvn0ya6OOxh4ljIondankTAvH61LWFh5wVZB8Cq4qrEgs
 rAvZWq5q7fgrrQe7d3lF5XrnqJGRbp7r/48BUygaCymFD26vCmrzRCtOUVpnduFeu5bX
 I5wacZ+4kuhtgpdtjQB9XC3Ycu/PcNaqbGOOfkSDXE6MxMh3/BklBCrHc0bwuTaosOPM
 FJeQUNCmaKvSuORZdcqVDHhm+P8glmFjQcVaYA0ti59y8k2bhkqywHAUot31uWYFsq35
 jXEWXnYILvFZVvDcTo6o4BXaEaikdNSbi9jMaOSQak6e7adN81cxaHbEudY8kjMG6l+U
 DwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IJ+oUe8oGbEUKSRqECazEtaPL7QJvkcdQxXjOvM9upc=;
 fh=dLwwt/6PJelAWMThWWIJ5d1nOog5XyB2a5wXLG5A9pE=;
 b=SqhhqPzQL9zZ9zNTouAKttSCGdlJeBZRJ1MrVxrncBOlDBxSQkvbdiDd70Jk5GAIv5
 sxU+fIItkOVtUDDu36adSuhuY+igZ62DxASHvXUjLqCG9b2MuHSj/7W3v/f86u/bz+AP
 eUBmertI/oVdXnzSGo1LdYa7NOGRfCQ4HvN+YCLOWsX9BohWUqT7PShK2roJF8QvhvCV
 7RbLwnTjRGYhBn3wFYLkyzhRKDvfuCZgecykvFm2FVM8q6Id0iUyxuYVVvFy5Tu0HosT
 twxbXaHacAGvSbktHLVBCZvD9fIFg2xTunfoT7IUA+k7a6BplLKRg7QNov7+5Oe10Y6Y
 hupQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778831623; x=1779436423; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJ+oUe8oGbEUKSRqECazEtaPL7QJvkcdQxXjOvM9upc=;
 b=px3Sa+geyvRd4RigBk4pQ+beDTaAbSHJ07/lfAA1YgqSUb3xwU+OtQE7AAOzo1+7l7
 mfKm/b+faYxH5ERvJGoA50vVJD+943840H+htHODAMBLAgRo1tv0K3OWAOOcuK/iH0Wr
 N0x3KSBxPYndVrIhuFs/DxmcKq5Si76mFp6gT6Nps3KvdrBL8WGL0Yj9IdNw+NcxdBbZ
 +ceu96++fL3QltGLC3VzZT6rhmQLLssTr/+jIFoVp4ndu7QUWGlP3L+4YmpAsIvQHfH8
 TBoP9yqRLqrFAdMIrCDsD/j7iZaHJfm/Wey2GGUdO2i1OTDbDJYGdulQ66BrqdvHRgFN
 xN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778831623; x=1779436423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IJ+oUe8oGbEUKSRqECazEtaPL7QJvkcdQxXjOvM9upc=;
 b=NJFxVpUIsOKQpuv99h7ZiPRITg9JXyG0CNnu0bdfELwR/HoC9Kz5U7+yMyiuJl2+pL
 E1mACfAuBeBLyIlQ/Cqwwb87p1JivuF+Ba/cLPuRULLFQCQD4j96eMHXQWZxfpAPa1iv
 avZDn6PDpORihBuFuUjouxkiokdUPFKUh8MLkEO6u9tpikO69f1lgF4oWw3ttR60kpVf
 M04lDgqSiUXoUj8YPfe3jGzhnHPG6FKaf7NMm+/B8DAvQ2Ct2rqOdG8UQYRkeozJ1AjU
 hkvqaUyUp+BYR5WD4yFAvgz9048u11gNNs1DFU5PmMRVow1ZQBWHRIl1/Y2VYZM7NBfL
 EdWw==
X-Gm-Message-State: AOJu0YwWFMjyn24TkuLtIFQQodPvP6cQNsvjadwjFRiPM8PxgDVdGC59
 urzRcHVfV8XpuL/XLRwVjVG/cIIpIzh34/wbD+P7lnK7wdCxK38opJSZuYbXuPiltPIP4DTavsI
 KIpisqJusAqeWKcAEHyJJDMgmgwJ8RuTVw6fb4RJ3vhT4X9WnhkXu
X-Gm-Gg: Acq92OHvVWdlgAt0JvZsRabWvOkrm2e3WmqFSZh7B/nEiZRhNKEo6Ur/qZnul+isJ8w
 lfpetOt47TTbs1DxKSroAkgyF19K29TWCsn5D0Ep8j6XlRk/nyk96L4WIa+/BBup4V4iyWVlMGF
 EjTReTvIZnHMqpiEcKC7mLknDDcMj4wTjV6xs4QB+Ri45tsAtYTjUOm8KYIJfQFTUz2nKm7qgrs
 AP7sPyPrE0LSPopIYLJbJb4MaqC8krgo588zO4f/xJUvy2k87zOZQwGw+607FSN3Wf337DXIGAw
 7a/Nw7BNZjLpxQBZWPMnL7kmk+s9vnsW5FOwEUFbXEqtVj3l+5lh4XEPk6wc/s5HBio=
X-Received: by 2002:a05:690e:1517:b0:64e:a335:95cd with SMTP id
 956f58d0204a3-65e227f64damr2592808d50.41.1778831623163; Fri, 15 May 2026
 00:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260507134709.70507-1-philmd@linaro.org>
In-Reply-To: <20260507134709.70507-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2026 08:53:31 +0100
X-Gm-Features: AVHnY4IIiEcqBsWj2187kbXMGwed8ZNnMBs-CBoxAoll8AKJ0fwo4HcjuIvbiLs
Message-ID: <CAFEAcA9VrYhdqPU_Lao=OGOvtXt8KFyfj4Y5P_U1xek6C7x_RQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/arm: Extract IDAU interface to its own unit
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 7 May 2026 at 14:47, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Trivial series moving TYPE_IDAU_INTERFACE to its
> own unit, and moving its header under the tcg/ namespace.
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   target/arm: Rename Aarch64-specific methods
>   target/arm: Extract IDAU interface to its own unit



Applied to target-arm.next, thanks.

-- PMM

