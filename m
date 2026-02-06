Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D1FEE2086
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 10:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voJBY-0005xP-9D; Fri, 06 Feb 2026 05:35:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voJBV-0005x9-4O
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:35:33 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voJBS-0008Pu-VJ
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:35:32 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7927261a3acso6570427b3.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 02:35:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770374127; cv=none;
 d=google.com; s=arc-20240605;
 b=PBINTB20IZz15yAynaVe7jz9Gaz2pxdUWNw2OHVQN8mAa9q2v8bbywVMnuhlQcCaaZ
 XJlQUdLMArpc+LyHNUlcwRiD+BkXO7nLYiL3/NlKhFqvYowAD+O9NTUdNu469aU+nwDJ
 ZNgTYFtBwGnKGymFzAcus3KPO/5Cw14f5pVsWQ7NL6grWBo5MnzBgYRYYBoIMQpfYAKw
 diZ/MSQftPp2xyO/p7D6wqg5rAM86gYdwiuIKkSuhNeOtPOPQCACiACkU+cDNM2ynnbd
 hOQFhyBmvbbgn6e+YSXsWtyJspKoY3eEsNar27MohfPBU+qiK39CBj/o514S7VNKv7is
 1qiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XpJ85sLfvaJT3RtyAID7pCXsI3iFK/SNDAoiG1GyF2k=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=JH+QEG9g40eyhyhXJPFrDT83jKwppJ+9fP2FlDEZGDJx2vvO81/6pRlHWmmXEzyAS1
 do7Euw1LYBeeguTXEXShn2C3+PVHW3AKpY+Nap70zU5zU55GG/VQlh+T3alGu6KgYr4/
 K+P48jHwRzGE6YiaUEXs4W6XZ68t24aAJuLUbm5qhE2bt7EjW8Ngq6gaW7WQqrYbn32r
 4T8cKhH9C5OSf5VFSy/wrs4CcMLJPLcapR6XVhzp99QMV5ZHcn1q8MuANJnq0qcTey2v
 HTYDjDSyi3Zl1fOwqZH17z3szHaN0eHkfppEl8KX6wHKFPaOEtzW5RHoFN2OBvsW8gB1
 pSeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770374127; x=1770978927; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XpJ85sLfvaJT3RtyAID7pCXsI3iFK/SNDAoiG1GyF2k=;
 b=emEV/fC/tccvjW6XNEX4FnXsgZoq784KtWqA3o2nWavIKbZ0RVpwFFYSEU9j+nt4KS
 XzozCweWljUb5y5SaEHABuF72oq7GvXdGjy7igLxaif+5mWlTfSl9trQQOlc5v1i17As
 hMbsc8SivnJAl8GEiOu1xO+tXDGQ6kLCY7weRJ99ir0b9fG/huxx+2u5UIcO7F48U4zd
 KR6SazOCaMslZkKniS0yMDVfUoqOf6W8pnP3mm2j8JKqRXJxIT+BKylLlWPgJNC6c5CS
 zeUub5ljVIyxqGQx9UI4z+ZoOP65wSg8JZXldzm87aRgIrmMSAlBQjvlM8t9Q8VIrGsF
 /BfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770374127; x=1770978927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XpJ85sLfvaJT3RtyAID7pCXsI3iFK/SNDAoiG1GyF2k=;
 b=HCplZHcZjDgTEc2KXiM84RE7ZphEBYOS7TkM/KVgU1uxGJhM0xNw+Ui1WrkIrLi2ya
 PBVE1oIQxbdiWiXJ1scnbJJDPUdyu9kXUlcTDP+lLIiLAxGoui4dd07duKNWd/2NmEKe
 ml4YuOK+LlvG7a1KD7sDNXjH3Pzdb9M4QQG4g5Cy8plnmFTxjKiIbEl3T9iDGCM5/lIB
 B0if+v4KN8pz0TWS2RxEm8eNfluV/UkYFOHflo6hLIctKl953qUNjyJcnsLjOK676aMV
 0MY8mN3GnO5yTzu4grINVYS5Trw+jKWtQIHO/svRIw+cKWNjg3ALHLQf3Tn34eUta4DV
 12Rw==
X-Gm-Message-State: AOJu0YzU+VrL2rcj4bOw/ftfc4Q98yi1emdJwqFzTvlNbD3jWaVBuz7M
 bYrK/fJ3hAaanzoaWrJLKN/8z/Ezv4iuspaQSpEqukkYYmzISDcroO2SavW8wGntQX5sFCzYH0S
 r7kTkeO35m7T2HGSd9fNRLKu5545D8EB/mibkJ4k3jA==
X-Gm-Gg: AZuq6aLHKvS2ERM+vfGGqF24wjgZ03GbuwvIbhf45u4Eebp7p9+n80IvJE7EM2We427
 Ijrd8RRX5gdUYJTSQODtF8jEccS0whf3dR9MGGTQ29y+VWeEO4/+QmUxBdCLPYRCsbQWqFatKM0
 Z74R6m+NRBoXKQMCv4urOImXqi+tlgOPzNGhkDLRgi2owdnnX2aeyrY2UNXWVOQWFc1m13w9W9u
 5pWnZ5QUCGXPEtSXShtlBBt0fL8I3hb2kAIDpnmBlFlmeRJAmQo1QkJZz7fcr1Y4XM8fLgR0keq
 Zv7d6gq6vCpDfXFiRJoKaWKCmHZVRJA25bYuAJAIbzcZFefMvLFUsyY=
X-Received: by 2002:a05:690c:e3e8:b0:794:d8a8:674 with SMTP id
 00721157ae682-7952ab6de6dmr21374547b3.53.1770374126817; Fri, 06 Feb 2026
 02:35:26 -0800 (PST)
MIME-Version: 1.0
References: <20260206102652.164018-1-richard.henderson@linaro.org>
In-Reply-To: <20260206102652.164018-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Feb 2026 10:35:14 +0000
X-Gm-Features: AZwV_QgeUNFFfS-zYIjweT3IP0G4fxtd-4EwLfL4zEMVAdzymlpDfoFF6viHJ-A
Message-ID: <CAFEAcA-tMs7TB5sCfbKTGK6nkp5R1UWpO0BVQhD6xwBhsms4rg@mail.gmail.com>
Subject: Re: [PULL 0/5] tcg + linux patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Fri, 6 Feb 2026 at 10:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
>

There doesn't seem to be any body text in this cover email,
so there's no url/tag for me to pull from...

-- PMM

