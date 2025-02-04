Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0D3C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfL7E-0003E0-RA; Tue, 04 Feb 2025 10:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfL7A-0003D6-L2
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:45:28 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfL77-00080h-CJ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:45:27 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso5147771276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738683924; x=1739288724; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GlSXFXace9GO76gmkuZgYpUB6N75RaDZoHYno2q8Svo=;
 b=vuWzeW4LG7+2SsLLbg49H1n/2q308pWe8X2seCoyJYHy41aiqOTWiy5vw6OoN2T87M
 9v9KValgYLnJK1Mh2nuHw8EjfEyYHphWjft8bbl1E56vuMoYoaVxUlAct4KDbE6Au/WQ
 MQIh1rWhGJ60d+7dC2aVOWh84C2Ljm3uwo+M6XxPMzcCjqQbX4DDowXGt1D/yldNOmAw
 EJlt/PxejKqURS/aZ9lVdmJuxqvhbXDOHI/XYJVweAZ8Wv2L5IjDfja8Y/+F5oj7afXO
 aX8OHfg9q5MuwlQ0SWHayerkz7W9+BHAIDkeUAtdPZqftEqTXWbuFSz4wRT+D6D885wA
 glHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738683924; x=1739288724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GlSXFXace9GO76gmkuZgYpUB6N75RaDZoHYno2q8Svo=;
 b=KOTB7r4JfbVwnlmttXUQGmU89ZJUo1x2FTYNWUTUTa2Ooiaq3Sa9bQ7VhW+6yQZehG
 50OxIhrEwLkk2pU+o3N/tEW21SLXFb8l+vtZV+TRMKtEUn/TcJkBsyoWfU9itulQhAGm
 WtXBzuxd+KKpISZ33JwM9rLf9URtOY5S3Q5gflPQBsN01hGC47p9Usd8BvEjW7Eutjob
 dZPH+Gafuy3G3Jpr+4puX4SOyn2FKzU4smB3O4ueCpzOhSH570O1p2IL7kB1lQomq/VD
 H9JqSdPDPneMI6/hmP0ShAVyll2pmOEAkavISZFH7npDd6bFdb13X0sbLKyMKU0RI0DH
 q8nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLcq3HRHjZzv0FKPzLcmSV1ZbIYm4PRjA1CdYt+OaW9t4pcBm6dmuX10OgDRm8kEPiB4NGJUtnuNUv@nongnu.org
X-Gm-Message-State: AOJu0Yz4qf/w2/DkizVznScL/wQuNqXVSe2XsS+0wB7wInyDL2z/ESJ3
 r89ZnmMFtzZS7H7YRHf4zs2VJwUcJLILxPzewkfzA+F6jVqog2d/lf7IjUIUjCXQaXjsYkV5zul
 s99YDP672n8H4VIKIjte2E2BXEC+VG0pZvqZAZg==
X-Gm-Gg: ASbGncvgtUCUkXA08t7t4lz5UXQ/tCxzyxuc73FpMJDA9XaPdV14hbk+vgbJ2JN7Jxq
 FJMKr8g4i7zVMwfbi/DwNYoElMusEHg1+uYvVCibHKYDZ5dcIF96eqtpHbvPvQCLFZRVAiUQDXQ
 ==
X-Google-Smtp-Source: AGHT+IFTb4f57wB1Wq7yKxcNA8nH41BQokSo4Fn1PDnPFj3swhY4LD4ZKmk9OC2HCYpl035WuMYke1KJerYA/yfoEx0=
X-Received: by 2002:a05:6902:1441:b0:e57:44de:aba9 with SMTP id
 3f1490d57ef6-e58a4ad04d7mr19179352276.17.1738683924054; Tue, 04 Feb 2025
 07:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
 <20241226082800.2887689-7-wuhaotsh@google.com>
In-Reply-To: <20241226082800.2887689-7-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 15:45:12 +0000
X-Gm-Features: AWEUYZmvFU_mO1MS_kHd0dpUC_PlM8W5v_Z0BarWMj3tWZ_nYqjmKdacAffAlLw
Message-ID: <CAFEAcA-qth7X0Ypt-PjxMBmxReGWkfbLBwhFn6WdEpebn1uHRg@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] hw/misc: Move NPCM7XX GCR to NPCM GCR
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, hskinnemoen@google.com, 
 venture@google.com, pbonzini@redhat.com, jasowang@redhat.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Thu, 26 Dec 2024 at 08:28, Hao Wu <wuhaotsh@google.com> wrote:
>
> A lot of NPCM7XX and NPCM8XX GCR modules share the same code,
> this commit moves the NPCM7XX GCR to NPCM GCR for these
> properties.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

