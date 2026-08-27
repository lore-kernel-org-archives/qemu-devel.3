Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783F8C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzeGl-0005gg-7s; Thu, 27 Aug 2026 13:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzeGj-0005cH-DZ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:52:05 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wzeGh-0004w8-Jd
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:52:05 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-85845398586so1414717b3.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787853122; cv=none;
 d=google.com; s=arc-20260327;
 b=lxzZ5CX0bTvVVa6yex4LzhMcN2wWgmUOMgkPyR8ZVKXhURsGe9Dd69jbZn/C+yUKKz
 EJ6YODsL+1poflSS4rwP8AqFpt32035JZ6wv85Ii5UA0yL0KhhzYvFt2NcnUYLLUYG/5
 ZuUeRpFhr+JfsJgQ8xyefhfZr+PqZvnfmjsnwhTVvG24a99YRcGTXV+bHAe3jL7ePcRV
 cQouBUMtVon+sgp1x9twsQqL7MmCl1X+djP77CHSsEygfVVg0FllHS3v3BQJrd9jnbWr
 4jhBL4gd1b5zNgxuzo+ZBG5LSzklvk3UVtBFfHynmIf8SVaYgOqjDV/GP6e7/MqPCO8/
 peag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ROGBvDv2p4b/cGR1h2MUzjJ9ex0xxQM2adm7U+8R2Uw=;
 fh=jtcP7ti16u6ZBTP8bnV5rwGLrPDi8ob9g/DXJoYL9qw=;
 b=oRIbjnoBmpvXXvUwo9oYnMy3be5FedFWmotj+9Q38U4eC43Mv52FLKD8M7WaSFqXCz
 vLqVBYqLnNLSyQFnz4hAEGU6EbN+ZDbvjZs3BWL5z4ece8P0JpvRd+P5DKiSEZchRH7a
 aY/Xs2kd4u4eZa6dSqIAOTApTrBeiZSXRJ5Y6twICjKZQmUJWiMsKDFENZVt23hQOYrW
 QHjlTFl5TNRMziu7OTDlTIg22SvL0sDbW1KGhC/XRr6p2mX7P08m1v2C+ZppjMXhkOyi
 E6KPIm8t6DQg9xgJj+fsoviBIp8fXX+L2KvLlSAMVckODF0S/79AhESFtMz7L1Ywc5uX
 6P+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787853122; x=1788457922; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ROGBvDv2p4b/cGR1h2MUzjJ9ex0xxQM2adm7U+8R2Uw=;
 b=xszfI3KJj/IZeDDmksPDxRQaOwZw5V64WS28afD4T+UijQ1bd/GDhPoRx/w5QcftXy
 9pKfRLM0vWRfp9gV3NRIRXavNw8HQEP50KPaUl9Up31hVW6PB2YTnbrOBrbRj9a4bmRS
 +2l0ohQvXzM3VlGKkNM40035fSZjwWs7VTYZtwzVIXiTgXvyuYM52Wshbq5IbG/ZPLYd
 fR+CDBHR/EHM/MgASrOWW30I54E+v0J6GuLIgEjl7pTdEaBjKqJRDXcZwlNn2nI2p74c
 bWT1EssSiIC+mHCqtShAhDCu7DZaSPHb3tGmVLz+9ns9/5TuoEjXQPP30osEdND3DcCa
 FFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787853122; x=1788457922;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ROGBvDv2p4b/cGR1h2MUzjJ9ex0xxQM2adm7U+8R2Uw=;
 b=SqGfsRKfZKHulnTVZ57jJ8If5z4fTrIaGJpLQIN+9UR26l1UAPfB4GbJXnRICQiM0m
 ftKe56TW0bZSlG7ZK5s14ddHp4lFvpQB05zvp+R967BpeKa/4C/8EHb1eC6WJWkqEh/V
 b9K8+13ryZwRoE1WjJA6abweyxqs2Yt7cZWQvnmAIWH5/05mHPmg8egb97Tm0Vm9l6cD
 lFAU6RlAhp1s7emR6xbs3SL142DNA8tNrIP9wgm9vbha1aNaSurzHwvmX7KBRiw6Gzz3
 yStyQ8gsKZenqK6vgfRiTmJKnEb4mhlFN5+S0SPXpQHFhQVO5I8yq9q1aT2VgJ1Cljbz
 HGDg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrrSL73es4lo0JsCRwSmmagDbplRIptb127dvmwcmHSJHoZWe81fDC3Xo+mOxe+sqTKKEkutooqfuIS@nongnu.org
X-Gm-Message-State: AFuF++k74nyeoF42uYjLi9OF67+0Xuoj0+cAXaOZMDPHutF7ht6S2fyh
 6waDyZSOvjI28EPd7i/RJxJkZDjDGGWuI/JJ3OXOxYpPO6oxe+1J8QFcxBHcHWHRtWKUNOwwhHi
 IqNylhEZxjJNtq2pqDrEK8+uDTUAqXBngOb1lTJAYOA==
X-Gm-Gg: AR+sD1314gJPdehA3W+TFXNWSycJ3vNSp0CEUyfXz+XuNSPNXVdPwRhtTeT0rhN5AJY
 eAZd5wkVpMWtt4gxSJDAmewdRnZiH0rTt2cO1g2DTCWgdqAcaa6v5SYJKGFu+L66gtIbc9ZqK3u
 76HsNjYBKRz6GZRsceE+/jnBhwf52BbUE3RkzuCotjFJOyrt5uE0ehp4gOA2Y4N1FLnCGFOTB3e
 3PDvLninKnwnP0csCaRUMg2VRrWGexQXXCTV2Bh7cbBM1M3EywUN3S8pI1DMakhvp1wUNLusGyT
 aYNdm1CIZIzZJiC7TpElp/fYtJ2K0XCZ2UrQblGHqglkcCdvJodKCEmkGQKHCmFWe43mepJ38ri
 b7i9xGHcNa5ZOOOd2hXSrsdo6X+hy
X-Received: by 2002:a05:690c:f13:b0:858:ad19:324d with SMTP id
 00721157ae682-85d67df459fmr5036967b3.3.1787853121656; Thu, 27 Aug 2026
 10:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231007072313.22108-1-huth@tuxfamily.org>
 <1826b106-2b9a-41e2-81a4-8a3439f9c511@ilande.co.uk>
 <bf3036ba-0259-4757-a249-68e2a15af1ea@redhat.com>
 <74883723-8f58-404c-9bab-ddb9a4aef4a8@oss.qualcomm.com>
 <CAFEAcA_ALPTQLQwA_XzqOr=Zuc4_K9=LPNXN9jN_i0fyouqwxQ@mail.gmail.com>
 <apB3oX536mOoPoXt@redhat.com>
In-Reply-To: <apB3oX536mOoPoXt@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 18:51:49 +0100
X-Gm-Features: AcwNN1WpEvGOl4Wdtvnq8rOT5n-kOH-DfsNMeX7BOxzzSGRr02Ui5XQr_fFMWKI
Message-ID: <CAFEAcA901ke+DMQGOHk+rf9U2Q98TPK=OOetmTMU0_sPh-AXug@mail.gmail.com>
Subject: Re: [PATCH] docs/about: Deprecate the 'next-cube' m68k machine
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Natalia Portillo <claunia@claunia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Thu, 27 Aug 2026 at 18:45, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> I don't mind about the quality, as we never claim this stuff
> is providing a security boundary, but I do wonder whether the
> bar for merging a machine should have been higher than
> "shows firmware prompt" ?
>
> Are there other machines we have merged with that level of
> very limited functionality ?
>
> Is it reasonable to say "boot a guest OS" is a criteria for
> merging machines in future ?

I think the idea behind merging a machine earlier is/was
that it means it doesn't build up as a huge hard to review
patchset waiting until all the functionality is there enough
to boot a full OS. That can be an awkward workflow, especially
with multiple contributors.

But allowing in a half-finished machine only works out when the
contributors working on it are actually here and continuing
to work on it -- the failure mode is a half-finished thing.
That's why "is anybody planning to actively work on it?" was
one of my questions earlier.

-- PMM

