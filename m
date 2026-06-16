Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B20CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZTlZ-0004TN-SL; Tue, 16 Jun 2026 09:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTlY-0004Se-7O
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:23:44 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTlW-0004fp-Sl
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:23:43 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66043ecf6b3so4244972d50.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 06:23:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781616221; cv=none;
 d=google.com; s=arc-20240605;
 b=aBgcH8JIORb8dwpVM6t46GlnG9ujjCunNi5pi8b2jqPFG7uRTp8/7rJqoK4bReEP2Q
 /i4BpPU1Z30u8A8agTP0Vk2tjuKBJ9YRDq/i2GOrbJWil0SLsIfW3AUljsIh80+dEY3V
 U3zzX2UwaUdfZwcz8Y+lBzsxC6BKLKPHGcbeACyTZ+0AmKSFu66P2mwyeAZ6M2pImeeZ
 gVLuB0Zuk/inb3w8bAXPCYDTiQhqdm/558t4YbuaOEAxobAUVOwEKm1y6EoTcHSlBgPB
 XdD84TJj8H1aOcRd1PsDYztCiNw5+/69n/4oOb+OcTKuo6Gi6epIo6NinHpMJ7Iznd/G
 sFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FBxRE+w7wp8sxW0dHD4wgoXUzz5Cg0aGnuonc8RhnpI=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=HpWVobzSMZEISAj3vve17/I4OqjcVvXVqtFxH3kNFOmCQa3PVMIfZMm4J+1Sgys282
 O1GUBh0DxhqQEs/J02OI6wjQKqj8Yrh+Hd9cPqXpGhN80mT/Zyb/mqde1PwZV/OrCZHI
 iI7EaziLtpH1gBJB9BifXbaFfYwHq0NpIteiIHbEOPSsPuy1QOW8mP+dNZ0ZItQU8Ffa
 W5f1/+/VDygzPbqb/fa/szgkqrLXRMWKzxO4zmCMcTmky1mcZfMdpY+cHEzj2pTKGL9o
 EMsGhTm+Px+1DLpFo4eA8KuH5UmtARGT5RFvRCJCUSeek0mo203lFv76sCt9c12F/6jw
 n/Rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781616221; x=1782221021; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FBxRE+w7wp8sxW0dHD4wgoXUzz5Cg0aGnuonc8RhnpI=;
 b=UKSUhc73R2AkAKZB5LKXGpk2Vd0pkDjGxKbSuKr8/5tczBG3aBQVWwP86itZnNSX4E
 +K7yD1yaRQH2Ucb1RnAGoiHMd/mQbYaPBw3wbiPyeuMlhFsRK2Y5O9yVhxGZcHGxkBYM
 leWlFjli78cdLYJh5u7rCREh7Fof3ILewBNCJBC00u+DIAmVY3FNqML1MC058OUoTlFx
 43LdIwgewKD5IM3Q9JZslLTois3vosl6FpTxF8OF68TBDxnYnWM5gCNDef5YUjcKtNdz
 URJKjzWDnXUPJwiavInANd3a09AC/6HQNZ9D6umtLACm8p8vBMtLVZiljjsMQYtp5FJb
 hksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781616221; x=1782221021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FBxRE+w7wp8sxW0dHD4wgoXUzz5Cg0aGnuonc8RhnpI=;
 b=jorQDhMfXtmlEnlRXmmhllAXOQstP0pcFjXMpp0jvhEDRDx/TkZnQEljPxxTsu/YMX
 AvzWrUjeX+8SrUIl7XYdXkXMJQt2TiT47T8KWqhN++2GbzRC0tBBon6M8pmUa/eUo37h
 58pLt8P7CRUsNPKEMbz3hzW66buxbIaKl2EbrUm6U45T3FQv7dMur9J8BPnw04LH4u3O
 aX2WOUsyOpRxHIqnzAmPlxZPPlXUHo7fznYv+1BfCRMUg6R4lCFNXS1JHmoil1UMbULd
 QhNVJ33+UxbPxdBAbknudLk3sUzgUetuNDqYNzpHFp/9iVTqCvrCi2TpprJUsSZSi+Sj
 IHQg==
X-Gm-Message-State: AOJu0YxL9tb6cDL56Xge+fn5oQ7aeq1xw6XVpCNTmgax+1Hl9ApU2jlq
 nJV9B513Jb6Q3Pw0prjCwUCLR1fiTjgGSfAf5GTHohjYHeBqTY76PVQYP8LFTEl/4kutjgjiRPe
 Crn4NrCqbrYChRKp6PanjMfUk3eB1AgRTLKM2F7EdHw==
X-Gm-Gg: Acq92OFx5ajNhZt61toIUPho4k6cRjNgLTGT3sjhvD+lANeRHRSZ6vcmOVi1KulRxie
 vqlnu9mZPNJOO5snGpyL/bSPB6ngrjFs/HAdYq8WKKdC4AMC1eRJHChqHhqloGLlal73R7jnZyC
 7dfyVBvsRrCul7oJke4gks4MNG+for6QG7dniDpKS2SF0jjEtVJZFIj9nbnN0hv5+MgDK0TQcZ5
 f9zACKy1y2ptAzwuaqXtZUl7qa53KEA8XUJowuPyLzGfv4z7v0yxTWKR4+wstWyBPTBDB0ZzHHo
 d8SbCToClgMwM6+xzJemPbXiDLwcj3QEWdRKcCHbejqWoowDbEsObz3McdVjNkFoag0=
X-Received: by 2002:a05:690e:1241:b0:660:54e4:5dd1 with SMTP id
 956f58d0204a3-66278315777mr15055171d50.44.1781616221475; Tue, 16 Jun 2026
 06:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-19-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 14:23:29 +0100
X-Gm-Features: AVVi8CeiKpg4KRUsvuG7MfA1w97L0NvIirYypfK4Tud15FwrLiu0Ea0B7zAHL50
Message-ID: <CAFEAcA9=uoJ4NsmPQyVFr6XXxDoG1qHz93Eb-i_mu_pXo3XVCQ@mail.gmail.com>
Subject: Re: [PATCH 18/25] target/arm: Implement floating-point log and
 convert to integer (zeroing)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Fri, 5 Jun 2026 at 00:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is FLOGB, FCVTZS, FCVTZU.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

