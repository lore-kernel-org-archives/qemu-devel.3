Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7875AE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 18:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsmQ4-0004tP-EZ; Wed, 18 Feb 2026 13:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsmQ2-0004t2-Lb
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 13:37:02 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsmQ0-00043I-Tm
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 13:37:02 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ae2ce2fe1so58010d50.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 10:37:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771439820; cv=none;
 d=google.com; s=arc-20240605;
 b=ek1rO5Nnax0jliNmFrPY8vWkAog8+oepFkhGcG4w701v90wJtuLP6CxNgO6m78ShTg
 vKFQ3t/R5vIADrJZPJ0sCKOgtiamrbVOGSMKazaQLJ91/5b0m75yzX9Yfc07e9xp49xK
 YcKsOxn1h51vm8576a31KQybasZzYnv1/m7IRM/MEKEpH4lnSMcgIy0imN2S/calsIV5
 lL8hncXi3wQTt5UIv8eH9bVgsR9a3JXNj124Y9HfaauuIqexVXnmFF/pwAGBc+tBQ+nU
 M1SgA4t+8RG9nHFQRSyt3IGXgesj9MtF/ghUrk5p3hDeemzIPFPrKICC6gYWB+wl7O5Z
 ogbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lgIPidw36U66/xW6S1l3TlRoatzSM9UYI6dZmctMsvI=;
 fh=6kJ3CohSxQ+7EgnARanNFMAgatAnP0uu5SOkx3O7QGs=;
 b=KPDgVRKUnBDFHJO8TuQQaCwzrG1srsGrmHe8mxIusg1mH5/mW+b2qbtqcNLF0mERds
 27rQFbBDFudJcnqESqAckJceYidfBkDR+fkEeXAOoF3Yq8RyCInvXuske+Qfwm5xubsE
 ck338fctQa1Hekwv4WjbzJ1rsuJm9vOoPEDv4BgIakHsnfv6+GqzsRS9cSCbmGPe9H5N
 Qymcs6roWcOdM8r6P4m8E8A81Bq7vp1hF+3MMDyaDmQWiFpETW9FQde9+vMFXkGnTbAH
 VsHUj8J3X1aghSEHPwL1QczEnr1bcRb3JIM9Ddh9xGAU5dR29x+gh78YdSc9YofrZqeB
 XfXQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771439820; x=1772044620; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lgIPidw36U66/xW6S1l3TlRoatzSM9UYI6dZmctMsvI=;
 b=EEJi3OZdNVPk8y5UVPJLCbzi7/b/7zKwSntOkDKKmB5o7aj112Dz3R0BXuUcf0eStH
 Qtzeyykl6o0NSOOuRVV5mkt4mIuDja/Wz3QxVQFp2e8ntLMmAI2B+zxtkVTuKCezMLMb
 zSMlgfhcnVXedjw90Yr6/EF92yn5Q2eGZtTszQ0v20p3cdYvOH4imAjOwnyRowNtJUUl
 x8Azb9hsgQAVqp/kElZvYBR6Oa64CN6byemYFL2AfZDIgugM9tdHff9TMDjm6zdvKjbg
 280SVd1zxyFRLXpG9xpAwFtLvPFPfK7bUKhAjX+HvsyMq/MQfEJ4s3ehGMtsEEmIEaZD
 hlqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771439820; x=1772044620;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lgIPidw36U66/xW6S1l3TlRoatzSM9UYI6dZmctMsvI=;
 b=vHOgOIYxXyYc3nCA7BsltH+/KoJ8Eag3ZEjZM2xF+ZGJ5QzatKDyq3R3didLG8cN9q
 +lDXgrO9Lo6+Udg3cly78SeuyP38XRtWYGqaq2t4sv8VyvuZYJeWgsC867BlwNgNX/oU
 QBhF3ddP2oNgRhzfxSrBeNcLADSMm9ugy79QQcttmZJ0lcUvPU6tS3SZG1qZj1BICdGI
 wdleLygAEXvPxMxBIVGkychZYeNUshFgEjOeZ9T4er92aIVzmvEOaQbPzf32H5+7DaUj
 MFbYkivvDFUZK0dAxojZzM51HgnaJHgVWCFSG4yu+P2vGysNOqUfVaC/iLNnW6ewxwNu
 Oejg==
X-Gm-Message-State: AOJu0YzD3hoB/T3UpCof/RPanHHtf5EnVC4tm4JZHhPNzdbiWl9afAkE
 cgObZs1jiW8n071MQTiPsgUd6bOmLZZHHetpDCxsrGxQbMZHhdPnsgdd/Uk8zjc8b25Dn8Kbyw6
 7qljfHNTHAN8vGRjdYoL5lVZzqCxjJ6bUjsyaaooaAw==
X-Gm-Gg: AZuq6aJ8SY1eMKWpzYY+4RRopR9+I5dJrTyT6CnKRr0/mkB7ZqU16mD+NeQPowpnun+
 FCU7l494mcFZUaIP8/bShdMgU/nKoPhLJ3q6/5CS4q9p7l9SdPi5COwTN62SwxzK+cKGeEp5mXi
 5oGYd+C+D8h8Dw9RcGhiTvYzvkIMfspbyppFbHDrlQxWrBU6mv583r0ZYidUAdLhF+cEaPtGaev
 2bJr2hyBRhZ/y5lBp+B2d5D9O7cCLj/DpBbyi3wazlz9BiZNZ2eFbmQcXyNZ7X8PelX//m4WqIQ
 8COMmUxsTCmesHaiyu7YAKtYDu64gJOTJId2uFCJ1IWIrPOZy00wJb4iknRORgFipJ4=
X-Received: by 2002:a05:690e:1514:b0:64a:d444:48f5 with SMTP id
 956f58d0204a3-64c556c9974mr2857583d50.65.1771439819571; Wed, 18 Feb 2026
 10:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20260217161443.12738-1-farosas@suse.de>
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Feb 2026 18:36:46 +0000
X-Gm-Features: AZwV_Qi0Jhvd-L6CL8akj9Mr_oH98pj9H554_xtqkYkiVxssW3VsyqjT3cE2ksw
Message-ID: <CAFEAcA9xHs0-BGhwh9C8SJkfOoza+37Rt3V451PwaTGLPSd8PQ@mail.gmail.com>
Subject: Re: [PULL 00/32] Migration patches for 2026-02-17
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
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

On Tue, 17 Feb 2026 at 16:16, Fabiano Rosas <farosas@suse.de> wrote:
>
> The following changes since commit ece408818d27f745ef1b05fb3cc99a1e7a5bf580:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-02-13 10:30:08 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/farosas/qemu.git tags/migration-20260217-pull-request
>
> for you to fetch changes up to fd5ecd187bc245013399d14cc225f05c0ad1a96c:
>
>   tests/qtest/migration/tls-tests.c: Don't use tls_psk end hook for no_tls tests (2026-02-17 10:06:03 -0300)
>
> ----------------------------------------------------------------
> Migration pull request
>
> - Notifier changes: Remove duplicated events during postcopy. Emit
>   MIG_EVENT_FAILED before the VM is started.
>
> - Undefined behavior fix for tls-tests.
>
> - Cleanups: COLO, savevm handlers, CPR/VFIOheaders.
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

