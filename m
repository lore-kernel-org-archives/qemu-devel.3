Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E61CD342C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 00:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK3JS-00017M-BF; Mon, 04 May 2026 20:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK3J7-00015o-DE
 for qemu-devel@nongnu.org; Mon, 04 May 2026 20:06:37 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK3J5-0007zJ-T1
 for qemu-devel@nongnu.org; Mon, 04 May 2026 20:06:37 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-36536771300so1116263a91.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 17:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777939594; x=1778544394; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4etx3NeD4ffKiw+U/5YeMHSuPW6winEI4vRmjkkVAjY=;
 b=f4T/iHH0VC/ycFgImOThD+16BHCrGC9O2tFusK5ejeBJhkXMXEasWR3IEdjYCcZnEd
 fSExPnUvOzIfQ0DvWzJQN8hx1upmnQ9gWrsigw8SNAZah6hT97UyVJ7b2QsTA2CjQjQS
 bvQ05Li/4haQkYYRBXxgZHXT7Nndoj2EaNoozilIMStxSZt3qTXCBuP1qM1EZwcaiDen
 bSBaOIeAuPNOy93sv1eTONtTM3ijF6HSTNhgkoTWJIPAEdueYd3ddAo8TtjzQG9mKFrs
 R0rR3Ku6XSa6WZ2/nfisMvaxr+xTv446XdDVlxVre2+FbPi3WR5O6nAHTDQJ9NCDChDw
 CkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777939594; x=1778544394;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4etx3NeD4ffKiw+U/5YeMHSuPW6winEI4vRmjkkVAjY=;
 b=BrKIqz3HdgAc/AaqExoYhG3mAdMH8hdgjvaXx6ZIw/tWqhAOyf5I8PRb54DB8qgG68
 u7LfMwfyojEjuWhyL/FIAFI193qKloDoBcRFyhHBlyFIpcmqIH9w8lfYfHvsB/Slsp3X
 1YXnfMuVa9wM6ZZY1imIbilaG0Mh+j/IfPMDwaii/DZn1Q0ZSbAR4xn9S/mv1p8nl3oh
 KY2KDarzV9q3ZQNcbgXGsauW8cYaCB83B1nRz9eqvx/xk58m8b2Tms/B9eu1C5S2jBUo
 naw3lyXGhzNliaLm0n9ED+VBA3JWg0fdqd0nV10UpZbCgF7DI7XYTZD3QNv8ync0uzqx
 26gg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DDlryP1Z5xOdrBjWIyFGe0OI2uNvchbEwgM9+ugroiitm07z7WQGM4BKIRAF0vUob74cZmuFI6sqO@nongnu.org
X-Gm-Message-State: AOJu0YzAf20gx4Hj8gLMoanZ1Rq2iavGWkArNdxsGT1v2cwrYwaifFrq
 lTLoWdMMapbw1pfeyO3pCXyZwrQAgK4VE57v4+AuK03KJILmabK4DTg1
X-Gm-Gg: AeBDiettJPomyBxGKtGppBteHeBKBL5rE0h52kjCz/h3xmyfV8jtGCvVjS6V8J+XRL7
 NPWUloZtESk1p79K00EWZYVKgWq+iHdQRAXKIlhRoiNp0RcTTK7AsGLXYz4m7d8B7CHrlzt58zE
 jZeODX0vvqC/ruqHh3cHl6FTQNMZD76WQfsrwKDYQI7ZUE4zaDw0pwGLo/s0qBDDPrqtevCD4rz
 9RJeIUXQt9VRTz47aDsladWFwEzSF54I2yXChMo3N8Jpu/CABeaCbNkkjlQ7AzyeqfUsQJbpGna
 BWnLLe+v3RD3WyDCkc9nJu0dyx29xiT9XoKHseGe5A1qn/xxSbPnKGp74wv06b2+0aduOLn+mDS
 ertBNltE7gtGpwx/pGO3ket/TRGtJ8oXMaCxewBw7GbrM1wf9L16L6XKHeL0TDfwig6fhGMw3s4
 UXqerp2p4NXEssLiyMPA/8AosTSthll8dlcCsiObz928k9xgFAJYQDKw==
X-Received: by 2002:a17:90b:1dc5:b0:35f:c493:cac5 with SMTP id
 98e67ed59e1d1-365728822femr1249057a91.16.1777939594327; 
 Mon, 04 May 2026 17:06:34 -0700 (PDT)
Received: from localhost ([124.158.97.178]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caa8c45asm114300915ad.6.2026.05.04.17.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:06:33 -0700 (PDT)
Date: Tue, 5 May 2026 10:06:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 07/13] target/riscv: tt-ascalon: Enable Zkr extension
Message-ID: <afkxduwfLOu6A4kY@lima-default>
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-8-joel@jms.id.au>
 <CAKmqyKPU100u6R2JoLH=nRkocXMCOekCt=-=FR-pnfbSmoY_9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKPU100u6R2JoLH=nRkocXMCOekCt=-=FR-pnfbSmoY_9Q@mail.gmail.com>
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

On Thu, Apr 30, 2026 at 09:36:45AM +1000, Alistair Francis wrote:
> On Sat, Apr 25, 2026 at 11:21 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > From: Nicholas Piggin <npiggin@gmail.com>
> >
> > Ascalon supports Zkr and the SEED CSR.
> 
> A datasheet would be nice to verify this

At the moment nothing public with this level of detail, I'm sorry.

> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks for the reviews.

Thanks,
Nick

