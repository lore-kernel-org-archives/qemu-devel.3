Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DADC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgHR-0004qC-Bi; Thu, 28 Aug 2025 13:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureQU-0001Du-4B
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:20:34 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureQR-0007GN-PK
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:20:33 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-71ff2b20039so9185447b3.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756394430; x=1756999230; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iaL3djnZvIkIBQMDbXl9rw2XdK0hyzUvMqiP76Y3fh0=;
 b=iYwFFMODM59Ta9bUXH3OLV9F5sj0WqU8vr4b2R8/qze5HNaA68dmxKN2WOsg5GmCVd
 vIfO6ZpvYIFTCbvDAUyBpeYmcGsyg2UWOFNDC960AAACz25iSPhUk+xeUrvDiPbNLk0x
 CP5OQnTWAA3U1Sc6yX+aImoOuw3UWfLKSPFypGGgEKXSzuy0IFAo+Je/WAWPEqUrrTF0
 UOfbD4qMoY5shxLd4KAgdTTCP7BakkOMCRv3IpPHsC8bs9svuBAAgtZonpT8kVKZ/u93
 hM9sAhq9rdZaokAm18lK8NExcoOEQle/l9CBn2xfsLqlANU4F5YT2aNRT/MPxsqn5yP8
 YBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756394430; x=1756999230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iaL3djnZvIkIBQMDbXl9rw2XdK0hyzUvMqiP76Y3fh0=;
 b=JNlgkxej9FdOC8IN6Emtq9l11NQ5xpEVkPQ97VK474NoQJSC+GI8AykxhSU5+F53KV
 U5ZuAjY2pqeSRRnkIIY1NzIhSdAgXTVK67syd8qk6aCdX+FvoOxXXiUUC0fjahbAfazq
 vDFsT5tB0CczuwOskxJlJGPGSdJpUWSdMIytYaiT5DFQHpun43iFbgLDq2o4YjSwU9u4
 kpl013M9S9EwcIfJ9wg9CUlVlfd4kJklzLMKmLlc6ozuOF5RSxvsOvD38gArnB/X5zjJ
 +Wl1BbqnTjh8xsURKqWanOsGlnVgr37UHjRBIfOVJCiCALqtrQ2W8lnH0n+2rZHchsDU
 AuvA==
X-Gm-Message-State: AOJu0YxebRISQ6t/0ePhZNNidxQjiVxvQ+M3OU0PJIA95Zu8NaqJAuiP
 +DHh6jqeb/BY6r6nL9gwY5DdaqaOKZX8vKWrLyQPKee8sKhbetFD+Ccn6dRn3/SwaoFlqz1pJ8j
 14aq/AQoqAoEXe2xZhID+5uH3vNnTx0kHGnBEWbVhp2ezwe8R3Yj6
X-Gm-Gg: ASbGncsQwYu6lXLlVRHnvQa/0KNJQ+aG1337uSTWM5EL6e7OFbDTzjuhb3OZ0SLCKSD
 BvjgardkycH5dHq0pYRLtc7ujYgWzEPxFd8PbyAPse1KjhbcKd9THsYHJSNW+Wr51zoo9FPiVMH
 wfQJ+WUNLAr78giuPQMLAy2jR1G1HdkK2YJULdou4NCAAxdQn1ToMmPVBDATl4+JSMUb5YyNW0N
 ioKBpSb
X-Google-Smtp-Source: AGHT+IH1DM8+R70QPrVX5bUikk41cDVEi6pcHsahhoSrOSdszh44+I63pkqtOfUlTC0+DKx7TEK6vi9fZNFkcS+/uVI=
X-Received: by 2002:a05:690c:6c12:b0:720:75c:37fb with SMTP id
 00721157ae682-720075c3928mr212539767b3.23.1756394429865; Thu, 28 Aug 2025
 08:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-88-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-88-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 16:20:17 +0100
X-Gm-Features: Ac12FXwpCYM1pdejFIUb68bBAZH926PCtbqrXKpqkwck-pXAlJgmjTbEqs3vgsw
Message-ID: <CAFEAcA-gCzUsj_E+p+A-Pn3DgehsaY2PbwK8BjcNjYybUjS0hw@mail.gmail.com>
Subject: Re: [PATCH v3 87/87] linux-user: Remove target_pt_regs from
 target_syscall.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Thu, 28 Aug 2025 at 13:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> All target_pt_regs which have not been broken out to
> target_ptrace.h by this point are unused.  Remove them.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

