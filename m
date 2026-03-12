Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7671106703C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 15:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0hq5-0007a4-3Z; Thu, 12 Mar 2026 11:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0hq4-0007Zt-3W
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:20:40 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0hq2-0003sb-Hn
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:20:39 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64c9a6d68e5so1015582d50.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 08:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773328837; cv=none;
 d=google.com; s=arc-20240605;
 b=BN51+tdt+K2hawsUPIrBHFyjeuHleP3Ny6Cm0QaYGxY6qArPRtxDNWwnH/SLfDt/Jc
 6c/HRr8oualHBMMIKreqgFNBs9EVBfqrrb5fCW+SoibAB6Ua689SLItBooTCCgfXmefJ
 32ZTLu1IveJ/0BxsMUoEErOEJoUW6zEFvB1WlyDB/svT4rNAqzGoKtWte/V67zEf5Cl0
 e2Bv3g9MgICKPe6uqm7IxoQ0si91WMSLfkI2ZsK2y12O45cD3P2u/ep9TjhkDxrCIIlx
 6sJuNnjqt9Vi2wi/EbNoIZ9kfoHUCDsLlwrQnYMAg86ixmPyQIJ27+N3mFm5UspMGDsk
 NaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wYIZDAmDbB6akos9bdz9qrAIIEaO9coO1LLcMpQYKyw=;
 fh=Ka5Fm2uGNoMN6LvftSCwVWZ6LDxGZumgYDW+5kU6bEI=;
 b=g3NIM6A5sJoZAseyuUPceHMbYj6M5AiVq6zM5gEu/y8InEF4KKawvqpusIlusGbUut
 8RVbWgBP6k3yQ7Ui17KHkUvVyaSfNeZoov7q8MZw1lNd5B2/25KrOCtj+ZNo1Jyha2Vq
 daGoleRik7rDbg8MlXG2pOVl3hvPBAQTfAIAJBo4ZOJVm0NzemIPnNSehKcIu//GV23E
 pFO8PZSIqy+gpHajOo42gONlxFaIF2pMDAs/OWrUO8f4clDZP/eNZSf8DvpWTpasteUK
 HtcIiPvjw4fArvNYB/iFPpPZmOsKG0L8aAne52W8kch52Un/+lDzPxAn5fI2h5xXr/uY
 S0Ug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773328837; x=1773933637; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wYIZDAmDbB6akos9bdz9qrAIIEaO9coO1LLcMpQYKyw=;
 b=SG8eQGmu0S6riEgmQydUsY2a22xEaRo20jlJUapWQ5VB/WppYRjnoS2yHE19t1JGlY
 HLgsSXo1U6w0eLN7Bz1xIQAJ0Cj3Kwu4jcDUAwu3mFHYtsn9z6wvyEp4ssKbhj0gOZM9
 V7dEKDgw/FLeSTztkH9sSI8AHYYyQcqMBaxp8oKZbARshmuy4E8vmz2iugIGpU7CYnX4
 QSp2p8ZZXUN2suyYc2nam2WWCjbs7ydwtUk/EQMMJu9VGK/22LqsoZjlWAIr4NRVG2wp
 0s2xj/yh7VpBgTpL8hDeYhAkwBjYGMng7Mufue8iUueyfUBGx+ytGijgIwE8+vRhYJxj
 BA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773328837; x=1773933637;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYIZDAmDbB6akos9bdz9qrAIIEaO9coO1LLcMpQYKyw=;
 b=oMQOflAKoiGoEOOXxUodcuZeFo6uCYq8rMTaVfEwSz03KzSFtkJz62b9ku0xMc0G9D
 UpEZZENZK/HTOcToeqaKhQuweMrDrly2+kCarIH4/Tja6TZ8gsE548V4iA0HNrBVa4QF
 4moNtHKq5IK4G32lxiNaWyVdOVF5+EoCMXqMAuKMCf91OPgAWv83j5pXu38gXtfpf90b
 ktB9xrvTdh3ZpN6x6iZXOGRNgI9KJ/L+QPVKqHFDp4wn8FFGI8oXIo5vK6dqkyrHMa7F
 s/Us6gyESHDKyT5B0xusMguate7Fq+F4kCs334fLgRlNgfFSbfeb4Z1gGytUr88B0J0O
 dsEQ==
X-Gm-Message-State: AOJu0Yy3gAGd74n5Ef06HIdynXVThry7pnFf8gnXrVDhDLdSKfHzLwDA
 AHIRm4HJyKnmPeMGQAFX7Sp9B6+zG6JiIEFGGbflMsb3KGGC6YVs5Ul0M4xFfalq670+Iou3ogK
 5E3Bc6QncKye9xeiUV6IUqtUszZkOvY2Hu27aXkTBxQ==
X-Gm-Gg: ATEYQzxi9pdgy+YF0tbKBoEXuIT8DF0zECOLtLalrNt7H0gsHeBDuhZKQRNHce5Tf6n
 oAakNRDoxTFP/mZsi8fVS6l/qTJ0Ks+cEuzbGn9/S2vMnsYjTgY9p/QFNVm1JCNKiMKFYT2ejDp
 ytwQs0DcjNn2CDXsHJ5f+RotTc3YLPAa79Visj/by5cC/ph2ZRHsFN0VWUzAHP0lZVPovrRZZ9/
 sZp7Mq8up0eKxAsiR7pHrSCOkbj7XAEVdTDeJxZfEydOp4OPEYaIk+vGygABn8JllTryquz6lDi
 buhaa5g/219zvMuw+6IODNmnIAELrwtT8beJ2/g8XoFBvJcAQ7h99mVFGOEMY6o6xtk=
X-Received: by 2002:a53:acd3:0:10b0:644:60d9:7300 with SMTP id
 956f58d0204a3-64d6581e91bmr4956404d50.88.1773328836730; Thu, 12 Mar 2026
 08:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260311193112.417841-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260311193112.417841-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 15:20:25 +0000
X-Gm-Features: AaiRm51-J19jTRWRIBPzWyApnZNKA0Jyon8cGG8vghdswznG2Ti6h9ebKu5z_fY
Message-ID: <CAFEAcA8aJRZBjwDVuoq+tPQOoaSw1tDzPVLPHCRVwFPR=c7stQ@mail.gmail.com>
Subject: Re: [PULL 0/1] Plugins doc update for 2026-03-11
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Wed, 11 Mar 2026 at 19:31, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> The following changes since commit 1fd5ff9d76d23ab23a68419cbc76d5ee33e8b455:
>
>   Merge tag 'for-upstream' of https://gitlab.com/kmwolf/qemu into staging (2026-03-10 16:29:24 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260311
>
> for you to fetch changes up to 71b424ca7644e2546da3f07fce3c33980d85602e:
>
>   plugins: add missing docstrings to qemu-plugin.h (2026-03-11 12:30:17 -0700)
>
> ----------------------------------------------------------------
> Changes:
> - [PATCH trivial v3] plugins: add missing docstrings to qemu-plugin.h (Florian Hofhammer <florian.hofhammer@epfl.ch>)
>   Link: https://lore.kernel.org/qemu-devel/20260311-add-missing-plugin-docs-v3-1-d68b9135e397@epfl.ch
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

