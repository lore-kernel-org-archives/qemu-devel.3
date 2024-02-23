Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7BCC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 10:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdSRO-0003zA-4A; Fri, 23 Feb 2024 05:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdSRL-0003ro-W9
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 05:06:00 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdSRK-0005uM-Hw
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 05:05:59 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-564647bcdbfso569847a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 02:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708682757; x=1709287557; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CnhNgcKju63+PRubhhaomuRl9ieZhBhLIJ6OWiqVIsM=;
 b=FZiw34athoMbzjYp49OG2GA5XMbF/gvTr73Kq52lNLOFdWAB3VIW/UQV9i71sgbQSN
 aS9OaR9yk6QEBL22mq1ZKtOySaMc+AFklpm6tK//LHbNO+CyhtMc1ZdJFmX5u2z+sGyf
 2pMjk9Ob9ff79p7Hq897PolsBkgMoGoq6YUCafKZIjN04bjj3Znc1vOEefoHpS8ISWeB
 0SMBBuXni+buoazD2BJv2XOK4ZpUxjALytLte6za2XPkwQFfsJAkKedWiLm/enrjg0SN
 Yy2o+lYUmEsT1rUPMqxzyLGZW4TISkT7o0ELHDSCbvDDe2UacgJF7lxIZ0KwJR+3ctKz
 BIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708682757; x=1709287557;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CnhNgcKju63+PRubhhaomuRl9ieZhBhLIJ6OWiqVIsM=;
 b=A/6zvvmBtJjjdmm0y/16xTpsg8tR6mZ5SlRpqIxVkjM6uejd99fUSJ5Mn2pPhx32nP
 yr4GucRGGQSIFMtASsipxCyVYjBf/fxBSu5Jvs6ScByV9glXiV1PYRHxHu425pwrPFNg
 vafBRYIxGs2fA2nBetq7gVw4Iwen9KlaChvH7x44DW9bVFMYC4SiT0agacCKC4Ml68fU
 CPdWooD86p91uGu1xSaVvIXo89AByElyRQ52eo3KAqV0puBJRyZx8aJ0oJr595FGnJBs
 UAwBdlT6qhXk2koIm8CXMw3NvU2qO9qR5BMKYTrLRLb/v0+gFK8rETzAqQ9KVvIu92a+
 yBJw==
X-Gm-Message-State: AOJu0Yxr1JZX31uJKtwHv0o8X/pMCdX4oyw2Pmlzsy7Ca+awaFUA+olB
 P+v0xQdJRB7ytRR1cYRhezXkBgo1ophhM81rk9q1V5KwbV7XeSfxRljpb6YHYGoT5JeDomq3FaV
 4D5J3IdGH7RWYzmjESaPOjaUPMqUUNakDXbCeXA==
X-Google-Smtp-Source: AGHT+IEXBW3goBxZDPXYi1blNDSz6QpKp0tOT5vbh5LI30fw2oki8NWDmeS7Ww28JgVKmKHPXL2rinU2cylB5Msf7f0=
X-Received: by 2002:aa7:c515:0:b0:565:7eff:58d5 with SMTP id
 o21-20020aa7c515000000b005657eff58d5mr349558edq.41.1708682756761; Fri, 23 Feb
 2024 02:05:56 -0800 (PST)
MIME-Version: 1.0
References: <20240220134120.2961059-1-rayhan.faizel@gmail.com>
 <20240220134120.2961059-2-rayhan.faizel@gmail.com>
In-Reply-To: <20240220134120.2961059-2-rayhan.faizel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 10:05:46 +0000
Message-ID: <CAFEAcA83CG9bXP4akpeccSA5qDas8t8TcMozxWjwVwQtVA7PvQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/i2c: Implement Broadcom Serial Controller (BSC)
To: Rayhan Faizel <rayhan.faizel@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, pbonzini@redhat.com, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 20 Feb 2024 at 13:42, Rayhan Faizel <rayhan.faizel@gmail.com> wrote:
>
> A few deficiencies in the current device model need to be noted.
>
> 1. FIFOs are not used. All sends and receives are done directly.
> 2. Repeated starts are not emulated. Repeated starts can be triggered in real
> hardware by sending a new read transfer request in the window time between
> transfer active set of write transfer request and done bit set of the same.
>
> Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>

Other than the minor things Philippe has noted,

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

