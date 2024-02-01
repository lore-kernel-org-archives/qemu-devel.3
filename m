Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E93C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 13:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWzQ-0005Ln-M0; Thu, 01 Feb 2024 08:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVWzL-0005LD-Q0
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:20:19 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVWzK-0004eY-9j
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:20:19 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55f03ede12cso1174289a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 05:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706793616; x=1707398416; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CYLwbcJKd9Ihw9QGaPLNzCC2RliKyra+kACTOhZuxMU=;
 b=R6RbUZ/9zsSZFAcEmUP62Uoi/sgUL4IM2JDv7hB9b4qzMJUhQl1Nw/unh3rr+nHWbo
 Af7TM2dLDFt+1FSkm3RJgQn+WpsTzchD4zZdi+pjiwlzH1iChG9lREukKGbvbwoMAPBV
 su6zJ1p5aOniDK2C5v8+Ft3N9h/+maeV+gI3apgACKdinWyKz0+fMOlmb7fHWnKypz1Y
 qfeq8PORk3XpIH6pvmxMbgh5IWnr39cD2TStUkyWnTBgr6wIzuWVGvSaqLo+L1QiE0YL
 USpcJlBJsE9mR9bxAq09sKwnLROvbhtFMZ643lsRsK7YLBGN8h7NEZx57HaH2WadV+RF
 +sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706793616; x=1707398416;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CYLwbcJKd9Ihw9QGaPLNzCC2RliKyra+kACTOhZuxMU=;
 b=jCvQdozXrC0dhe6IU+hTZUxab0oacBpFYCr/8f8tTaaoz/dG9YCTEds9kerABrXftq
 /iMtVnLnIpFGrGWHaRWE2eNGr44OPRFA3RzljdZtfoowtP0DZVh7/prpDmg2iEyJJy+N
 Ih1FhmFOnkQeTuOl1hwOsPk72uDjJPV847tw/AYa5Y3verUjOf1UnTfjENyGI4UtZs4B
 eQvOS1/2rmdjCF0Kb4/IHaj5L18YcaEIh0p5ck1n6qTz3vsegqiWV4B2kZlEgop4b3rQ
 q/Y/VUOEfB1NaKNkDLHhD5vUr4BXTHE3urKdiEgE7QsUREc7/SYXWwho7IeWr8trnu+O
 llwg==
X-Gm-Message-State: AOJu0Yw4asoPekAwupW0vW5mpz4Jd81FX6YaS9KEuOX6uqn77vbNXZL3
 2/V3pAwS80J0ErnuYeFwa+9dBFOSnqQGpp2I5XlQxjlx18Np9zhqblKiykyvei5nAnZ+W7IwwlZ
 0TnlP647/imwoTxpZ0IEzturN50r1XQtQhmfSFqKDVoCXRYne
X-Google-Smtp-Source: AGHT+IGMsbpnUtny9FzKOz/MCtsvU5fZZgmUds85OkHrAtQ/yXVRKV5aUVI/0J22+0CzMdbm9rC3csC5cCdkl/o8dSw=
X-Received: by 2002:aa7:c718:0:b0:55f:43e2:56c8 with SMTP id
 i24-20020aa7c718000000b0055f43e256c8mr1629327edq.38.1706793616269; Thu, 01
 Feb 2024 05:20:16 -0800 (PST)
MIME-Version: 1.0
References: <20240119163512.3810301-1-peter.maydell@linaro.org>
In-Reply-To: <20240119163512.3810301-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 13:20:05 +0000
Message-ID: <CAFEAcA-ow3XQ3cPeCE7Vva2KMCrRduZkQWnFQ1sTmTmbj=CPMw@mail.gmail.com>
Subject: Re: [PATCH 0/5] buses: switch to 3-phase-reset
To: qemu-devel@nongnu.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 19 Jan 2024 at 16:35, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset switches the handful of bus types that implement a
> reset method over to using the 3-phase-reset APIs, and then removes
> the transitional infrastructure from the core bus class that was
> supporting the ability to have bus types that use old-style reset.

Thanks all for the review and testing. It seems like there
weren't any negative reports, so I'm going to take this via
the target-arm.next queue. We're still early in the 9.0
release cycle so we have plenty of time for debugging or
(if necessary) reverting if any unexpected consequences
turn up...

-- PMM

