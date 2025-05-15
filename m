Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12280C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 23:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFiLb-0007yH-K3; Thu, 15 May 2025 19:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFiLW-0007vw-Hb; Thu, 15 May 2025 19:50:38 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFiLV-00014G-4t; Thu, 15 May 2025 19:50:38 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30a9718de94so1536870a91.0; 
 Thu, 15 May 2025 16:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747353035; x=1747957835; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCyogcm6/3jB34lunXm6V7paSEmRjPYi1QNCs0wYBUg=;
 b=Rcf6jMhxPVal+UfxFnV2lYgGnft2il0UMX2ZWKlWWi5lcQV/rQxAVvYHhQeNZv74Aw
 oCrb5AEpPTo35hzRz4nyBJaL11ge69u+0RpDvrUree1emd1ypfk6iJoMJrEO5+9lWTTc
 wgDJgrVobEBo7EIkR3MSrqmTUK6LdV+SrbNmtRXIJpk1KPhd+/J2VvmJkuCLc4b1hWSV
 khkgTMfyqM9e+WiJonlT523eS2oaEbAZEj2ce7cdtLcXtehmXgSLHkiRsNjGN0iSJF1k
 N8QWrfybxAvMh7oN5HjAtadagjZUO+dZEAm8TkPFoNBvFEyeAzaJtLSVZSctFUTNxHS2
 evfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747353035; x=1747957835;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PCyogcm6/3jB34lunXm6V7paSEmRjPYi1QNCs0wYBUg=;
 b=ksADczx39FB2c9iZG/XPUDeLDk1F9CqtzVg76LCbewnnsQCrk+/8gkMy/bDQ7Hu8cN
 s5EsXm1jS5v9D2DGKfUc4ZXzBgBwbq5qN+LJf03JhzKz28IZSY35jUrxEEiCqu/eTDq8
 +neZS9gj4RyA9+tCLtUG+hZkiYfl5kzbzEtg7Qhbwb3Hzfk2nXjv1F2iAOv8f7+tmIyS
 V775gBO/Ct5tSZQIt8z3mbofvHmpKMu2h/tudiUTFDvZgWSBhvQNhQo4Io6HBQwdHePc
 vozybQfyOFndoTZtfssgHafVqcNdsk86iMXvw2arE2Y/Rni9q8bYOsWPYLNDp0si7mTI
 96Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgkYdmqrOSmwv8nCfX452/94oz29JlA9/LH6OhjM+6O7LPZNcxEJ5uwxEzuXsclfRNKUUGQl/zWw==@nongnu.org
X-Gm-Message-State: AOJu0YxxEYlY+g8nJA2Gzma/Q7/sHKRxdrhA+UWg25t+dWVQsVOesGOU
 nCCbeDttjmJfUhgSFr4w+ZbA/LbI5cg8sbWa9RF1Pnwlfa6iZzYJX+VL
X-Gm-Gg: ASbGncuMafHrZrtSxOy2gF5sK+h47rQ+ZBlcJRkVyPYvhJpg4cyqPjb1KIh6lfsEUHo
 HYydTNtcDz/B82K+TdgZnVDqr2nAi9rfCqVigTaezYO3E8WySPlLmBSx90DWXTm9dCSLrxm0c/t
 Y6uM+jNivqib2dd73U53R8y7tAIBr1rWkUMVjdGce2Lw5BE9D3K+X0vxZ8JhiZWBkK7X5g5U3ZY
 lmYHIWw+Dc2r9JS0r+FCxG/C3j89GIn+mX7Lcx/E8ggiK/aKj3CHbXutV4EZxVcrky1iZ/qjSjO
 RG9o6BBb5hHeIK0e7PhWNYlmSzdJ1MJz+g+AzvkuCC4VM8A=
X-Google-Smtp-Source: AGHT+IGfWzkTH8GfjqmPPKks3jrRDOD8jXTnwyGOksi6K6Yw8CIG5yb6DV+TQFuzpvnapAk+xa9j7A==
X-Received: by 2002:a17:90a:c2cd:b0:2fe:861b:1ae3 with SMTP id
 98e67ed59e1d1-30e7d5212aemr1605810a91.8.1747353035251; 
 Thu, 15 May 2025 16:50:35 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e6af9d586sm1251325a91.11.2025.05.15.16.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 16:50:34 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 09:50:29 +1000
Message-Id: <D9X4YBZZN8MI.YT9P5G4O4G1M@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Mike Kowal" <kowal@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Caleb
 Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 34/50] ppc/xive: tctx_accept only lower irq line if an
 interrupt was presented
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-35-npiggin@gmail.com>
 <e361e136-ec17-4b0e-a036-23aa3242d9d5@linux.ibm.com>
In-Reply-To: <e361e136-ec17-4b0e-a036-23aa3242d9d5@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
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

On Fri May 16, 2025 at 1:16 AM AEST, Mike Kowal wrote:
>
> On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
>> The relationship between an interrupt signaled in the TIMA and the QEMU
>> irq line to the processor to be 1:1, so they should be raised and
>
> ...needs to be...
>
>
>> lowered together and "just in case" lowering should be avoided (it could
>> mask
>
> I think you missed the rest of the line...

Thanks, good catch. I think it's supposed to be "could mask a bug in
the logic elsewhere".

I'll fix.

Thanks,
Nick

