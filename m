Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416BDCD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 18:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWeIC-0005ST-6W; Mon, 08 Jun 2026 14:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWeI6-0005Rm-CE
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 14:01:40 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWeHz-0001nX-Lo
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 14:01:37 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-660633a60caso192770d50.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 11:01:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780941690; cv=none;
 d=google.com; s=arc-20240605;
 b=euXq2sCltqXWLX3UmdoJRJ6CdQR2HLmdMNmLRS+N18eoMaMwg/N02V8SgrT7Jglt3T
 YYMykfzWo94LqwtFDixpwH1wwra0dP2rmW28ojt7ZZJvUxxx3T9x4hZag6KgbPtjtkkX
 SrOUKQIoUV4+Y3MkxXDTCt5HbFfNX/KE3LYESumf2mfmpPev3wJ/kn0CMljcb9fz/8eo
 ftAuygYdXZzMbT+AsAc+PwSaQ5w5RUKImgzqq2x+POaOFl7Y+zxYhWoxv3ODKlqyvLk8
 A2xFmr+o6N7IEPTrt3IF7s3awmcTnJXquhl/HELCiTuf0aLpRZnICQBIjIcBws1IFjQ+
 UWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z+3rgRPDQ/IIdqD/0n+FWqkkTMdu5eRseNUEY3+hvCU=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=igW2k2KHwixx56FeXU+9GaRwo4PXS5D/KtjGZ5RJfSBxCb9hF1crXRKlTjl4GNqgZY
 M0B9ypbT6LvGgzPqtcrinKU3vPrBYrttBWwleJJCkHLO5ZOLXee3JFP7MSPOOUEvSDwN
 p3oktXFjWatWKvDXI89JCNEdbvUu9HOgZN+1t+6sN+7oYmHn4Slp9TCDhRKlwpZYXjTk
 tnhCk388nlwT5XZ0+Lhel2fxGr9GGckrovCX9TBf5UBCca59FUTrFedufXjIjNgouNo4
 ZfXX6I8+8WF9Rsxq5jJNFXk1BRJxGkTc0haa4sA7uvX/iGpjEe+RSrrhpR3OYs7RFCuA
 ys9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780941690; x=1781546490; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z+3rgRPDQ/IIdqD/0n+FWqkkTMdu5eRseNUEY3+hvCU=;
 b=HPuBeEafjrmXvQlNGJWhGHdWPrjuRQN8ghL1ZwuYHM3PqGdvG4qBXLL66+Be46DIIq
 IZUAOqPQdvd0i3PpDFsDsWBL+bdO65uoS5WpQEqZmvB8Kdwk8/SOIcly/KciHtNnGsyc
 J2CuqSDcXG/CpLxOnIPxHHEgc+s6aHppubrN7yYPdwvGSSIbVBn4no0+kyUMxL3inf/7
 TmTN2jyZp5A2HerhB2kJCRcTheMRB5BVhd4ppuXaa3Hqs75ibBr++5SgyAGaGr+jh2gD
 wBy57Hbt3A9p+waVJXT4Jz8cTCzSMTWfWMLL1/sGF8daEJPOqwCNLJiZ+GQNGMI9nLTm
 JIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780941690; x=1781546490;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+3rgRPDQ/IIdqD/0n+FWqkkTMdu5eRseNUEY3+hvCU=;
 b=nuu4qkv62rWiieOz3YfZVYTmnE+I8FfgidjhVTj015zvkxbjtA0NYnHg0PBjST5ogM
 WqR3VOS5tdaztE8Zht+zU8z2KAnDXOHGstO2ssMboUdXU3NxpkxyTUz+6H873s5tgule
 6jFU/IFsy0Q4RE6989KwYbGGGOTz1cDEVnexL/IONK7yEUtlsXp4mR+MWwxWRuVfq711
 VnaaRU//JSFIZuz4TsWulr69h0GHQ+BYUYq5FKqtuzTL8mGs9ly+GkWArQAOzA2DhpLX
 iAhgYSECiFPcKENobOhXvbSaGd2U38mNQ/T//W2noR+zuwQyKnXFthLODUnd4sMASUqj
 eAZw==
X-Gm-Message-State: AOJu0YxVIzduiNxYtLtboW1oEMAOubPXvLLTqw7nOIdqnGX6inINUCuu
 KIsNrpGsfj+6jVA2lm1XdRGviuGgxV5x+q0E+k80OXjH0OCGFIyfa5K3z7izg7sLRLfLWeS9KIY
 JZMGSV7rGgbjtktQMuoYIO+JLnjz1PAHhJtFUuxcfvLJypJgatq1D
X-Gm-Gg: Acq92OEcVoeijlejoM3f0fKh8Pq37Zk/zuYeVx1uCHejq0eNV76qr0NXe3b6wE5gdt8
 f1M2fW7BMH0Z2FfsTXdZGSjShbA1+t8SPl5yGM5id5EWbolmuaRgdNz/oX6GoI4jLZmhiaXRhix
 tkSBT1x6PMOIGBb6lgaITGbXICeIFBEF2mTsSnNbhd6fWCZJZ66pJTC+o9tWAL6c1VRMb4uI4sk
 WdvsVnkf+jqLJtpGSgFH3CYh1R1uCOIpiSXdGxo7gM+a8uf34mYVfHIosUkdP68kbEYuP61ZcW3
 DFmATZrj91WfInJ5jR/Mp21keUwPGVvd6wnlAVsTBDJM8y8ubi4JhWRq14bGrE+yogM6lVB8+1v
 oFg==
X-Received: by 2002:a05:690e:4090:b0:651:b108:be59 with SMTP id
 956f58d0204a3-66106f66b0dmr14128631d50.44.1780941679333; Mon, 08 Jun 2026
 11:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-13-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 19:01:07 +0100
X-Gm-Features: AVVi8Cf2Sdnc9zEr7ddO2hIGNQRfx23wKcREY1Pfka9xKPJXxUP92K-A2PrLl4Q
Message-ID: <CAFEAcA8_GdbLdSQOGCNu2b7HuMm4eWR1eGVSvuCzUFExLT9SBQ@mail.gmail.com>
Subject: Re: [PATCH v9 12/45] target/arm: Implement F1CVT, F1CVTLT, F2CVT,
 F2CVTLT for SVE
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

On Wed, 3 Jun 2026 at 04:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

