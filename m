Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5562E98E10
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSeq-0001P9-PF; Mon, 23 Feb 2026 04:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuSej-0001Fq-Aq
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:55:09 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuSeg-0007nj-FE
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:55:09 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64acd19e1dfso3386271d50.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 01:55:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771840503; cv=none;
 d=google.com; s=arc-20240605;
 b=PfAyTcUBXpgClDodLpMtGn5I+pve/Nb0zLEcjwzXp9vv/vJyX3hdp1nw9Kn0JEXsAi
 pX1tGAMph+TtRwfba+dEWs3IKZKaMUxH/b/im8xmQn6kJQDiiscvXuioTKssitkMPtpA
 FeQxzVy5gk9hagNPJittRQxgnDEjocz5FrTvGfj6pvXqYAmHyNI17aymP2T8pagKXLWL
 I8UG2Xq3pu7Pyu0m7x69AfqQlr1b2/n2V6hAhnTe2cG9piK8YF9ECraSxtiDywrPZp8U
 /qdoTjzChXW+xaMzirxj4UMAmoXG0L2lp0EBtiYKy9IiytLiyG3HbkD99GzcQR865IiV
 ofRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+GHlUSBBRR1Y+9AY97ijsakmp2RIvYOYKlNE6baqxc0=;
 fh=RCtHAAFaYj2DfzydqBRq4n00hdxhMeZ24nyfGGrIk6I=;
 b=IUueIdKICDE8+nzcz2YGNQ7tMFYstN6+RSF87a+Yz7d7o2WDnxn8V2T8IlTUTbUUFt
 wQk59Uz7jofmn1gY2EawzHj8qchQOfSWIK68e+nHMMrsCgVqao9oOounYeNyY/fMBjel
 hlTxNvhLmfab9cIF2pm7ndZlaHfVcPGYuyA1tWR80wvfk40+70VftyEtFYFH3E6Bef8e
 JNzSiSRbR4eHzHLxp1qTHLZtXavuwqItw5eLoYvChCYK2MEDWq4Ec+H+sVJxf2OzIyj7
 KeoSDbzC5XcgrGTaF2g1AmoxlIWISJpXxo5HTPqDa60yglTvqbiN2Zu15oggIGN4Hdhq
 Nlyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771840503; x=1772445303; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+GHlUSBBRR1Y+9AY97ijsakmp2RIvYOYKlNE6baqxc0=;
 b=hjZUaQ1pjHi3wjYmxliIgCxmuVYqCTPkF6vNr0ePyS5/hw+5VkTmrx3/qPooen2u9d
 T7KaFy0qzkDARY9qLbQxm13OBTVXvawRE4/fZv0HlJf34hvHJeRG8hTTvXGRBaOxTtC6
 /k0XY+10OChM7uZujaQaFItv8nap730B2m3T2FX2SD4ltfOSHjux3tGxuKyX/ffdDxdV
 0RkBxQ2FUQ7RBzkN+elw88itAKkhTfcYJWUcpt56TpaPDXlY6XHjCT3XZzIoDjgSy211
 8yoXMXD5B7T8JHBMQqjBHklAroWEZ/kVHDSbfOHhRau6KFaavDaVtM9SLaHQFtbujgq8
 vGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771840503; x=1772445303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GHlUSBBRR1Y+9AY97ijsakmp2RIvYOYKlNE6baqxc0=;
 b=K+RTiNB4CT9kkgdz441iJDc1AF82+kaO4MAHXfwOjoZXoQJueHTbCOwqBirB0bkWCH
 qXV8vdVxCB/jxTnZSmdohz7HA8nKXIDe8kwRP+3ddFaNtp9jFTV3Sg3RVSmSpvXNlrR6
 1qDnUe8Efe052sgEUMwxgcn6Ip1WgztuGMk8ajRlmpz83sBR+uwapddI1UWbQjQHKEkL
 /8YMD0rY1qQmUYjh5mTfjwNkMZjmeYc9SyCE8j6dTFo0g0lFNs78al5/6tBgGY674KGc
 /JmZnbnB0mGG/qxOMElbWoAJ3y+9gECq63S+opjUhUt9OuH8jvYyswg4T3PfZkSgNUSv
 gFFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZjyVvZrB/CU6h7nzfB1f9kNmjWwyowFCDk08hb6HIYPMHGzoL5OF/tsOcC8fCqlO+RWXM0QlI29n4@nongnu.org
X-Gm-Message-State: AOJu0YxRvVDbzzef0YRoqk9zq3Sq5YfTfmHkYld3kuNP0cyenrV3vLJE
 0Jngn34z2wYpqVzZ8QhBppoVUF2JTb6GKQ7lgpXiu16m6sZkImR+WaDE6lDeqPEPWP1j7jZNtQf
 0twdO1X70HiF5OgT0pq5nLqKGsOcqU96RQQIoe7Hy9Q==
X-Gm-Gg: ATEYQzxPgm8Pu5RSNMtFy2RdV72gKFjePI7e0HJSrL4tVXG3qHQZb150cITMZdyS1+1
 bUZBjroEoJeRANKX5i5RVpS5yL0jZdeFroHl06MDqPNMIAxI7fX+Xkrdw9CmGsKqSkHYBGf1qM9
 ZF/6ddtDWFZhQYhNmZy48YrzAO3XlAJDY0hfzNAJ22259JRaRQMGZE3ej7I59fgN06LtF//FwDt
 zNxXqB4uZNOKIa0yvgOES7d3C3KK5yJ0mkOI8STcW9t3DKab0uQ1Akmm67+7piC3eFuu66DREwD
 3XpvHDAlwjdzMVHpafm/MxwqrtoZCMnyuBHt5+F1N3rhn0tQlBP4nfMVTqFvslEGH6A=
X-Received: by 2002:a05:690e:1513:b0:645:51f9:b4c0 with SMTP id
 956f58d0204a3-64c78d3b2b3mr7024128d50.55.1771840503418; Mon, 23 Feb 2026
 01:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20260219124408.3515-1-deller@kernel.org>
In-Reply-To: <20260219124408.3515-1-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Feb 2026 09:54:52 +0000
X-Gm-Features: AaiRm51IsxO-iBLV70zqsDa_NTkmlcqBHgyv5ER4jp2aLPwcOpXWE4lDWOoegb0
Message-ID: <CAFEAcA-ez8+SGM4zJpYuH0JT=W0i2VqxE5XEhm9gbvGmgYuHzg@mail.gmail.com>
Subject: Re: [PULL 0/4] Hppa a400 patches
To: deller@kernel.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 19 Feb 2026 at 12:45, <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The following changes since commit ece408818d27f745ef1b05fb3cc99a1e7a5bf580:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-02-13 10:30:08 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/hdeller/qemu-hppa.git tags/hppa-a400-pull-request
>
> for you to fetch changes up to 9e59b112b6c0e24831e1f28926df0bc917b14902:
>
>   hw/hppa: Add emulation for the 64-bit A400 server (2026-02-19 13:41:21 +0100)
>
> ----------------------------------------------------------------
> hppa a400 machine support
>
> Major enhancements to SeaBIOS-hppa to support an A400 server. This server
> requires 64-bit PAT firmware, so SeaBIOS-hppa was extendend a lot. PAT firmware
> is required as well to support 64-bit HP-UX 11i3 or MPE.
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

