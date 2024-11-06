Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B10D59F67
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 21:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8nYj-0001hx-6q; Wed, 06 Nov 2024 16:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8nYh-0001hU-F6
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 16:27:23 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8nYf-0002Zz-RE
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 16:27:23 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539f4d8ef84so259465e87.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 13:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730928439; x=1731533239; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=byxdsA88HA0HDl3n3Mxnxg9Pg8YU/YA7TWUNIlcs6Yg=;
 b=R98N7JTcTiPvmylLf5Vv0An1GsyVDP6xniiIgr4w5IHM5RtqKhEe09GAd/3EHCRpmy
 /XKjYKv3wMgNLMTysu0F7PPYp43OXGziT86MuXSijDcjy3ArCjh4shP4TdMD3V3yuW16
 xf7UKDSYNzhXJdg8ke6AWDaZZK5H8459RWKgp1NFdWJaOSi4Ayv1V/td2+VH/mP3eRXN
 0DyfJTcQMzwrT+SUact7Q6SV3/C1rffQRSrltL0LajXJJ9fJiXSfKjMbOPtHj6JVOvbJ
 vXXmhAq5EEfZGz7GT0/cm3s7QfIllx91/F06ylpaZdLADSPTgfVxr9CgAD2//Z8FjRCf
 Sc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730928439; x=1731533239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=byxdsA88HA0HDl3n3Mxnxg9Pg8YU/YA7TWUNIlcs6Yg=;
 b=F3MNZAgAdOjsL0MZTJaUIh6iDtTb1Rj2UO+YTePuDH3tfyRUVDHo/FdjSVcRj8xDPI
 /pAszm2uHIikafb6PSNeQslWHUUcaEcIzgoMBhcprOGu4C+X0/e2ZivHst2ga0AG/8kf
 uUjsRyG7gh8Zs+TndVMWatlanbN9pcrrG7yCDsAVYN63LjFI9YsA6s1rB7vFgg8d3tj2
 jX/thi4rJs9iNRQw7VEW+w+SPyrA1WaFhn0E524rjobjyFquvC6omkEwrDYV2vRjuebe
 k36y1Sxwj4HkOjN6NR55iVUhB0egQfkssl1NqdF6nGvYdL15nDQi5GLvRXhZCljKgTcT
 EHBg==
X-Gm-Message-State: AOJu0Yxg3WUAsotSPzeP3GA+EcZFgd55+kwPLN++Xfe69KEbg0v+aXpV
 oEDYiqlkQ0esuu64lyv4FZ2ohZi918brqNQs3Ea0sbiw/70oU1iRqFf1Fh+AcZ+oVbW483xNdY4
 j1d19a+aB//lwkhmh+A8oEz+tfXx8cUUQNOfnew==
X-Google-Smtp-Source: AGHT+IFYxjORqyTiSuknvmNBQhOBUBQ16B+QFI5lSsecJlbmgIGSnmGqUuSbrRGRPJutpvNjYzl8S+mlERm+Ypr7l58=
X-Received: by 2002:a05:6512:b84:b0:539:adb0:b86 with SMTP id
 2adb3069b0e04-53c79e2f3a1mr12569106e87.14.1730928439560; Wed, 06 Nov 2024
 13:27:19 -0800 (PST)
MIME-Version: 1.0
References: <20241105184115.381511-1-berrange@redhat.com>
In-Reply-To: <20241105184115.381511-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2024 21:27:08 +0000
Message-ID: <CAFEAcA_JMViR9VrKhGFb3PbomvMWNPbA94uWV6hK7rTACYE=3w@mail.gmail.com>
Subject: Re: [PULL 0/4] Crypto fixes patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

On Tue, 5 Nov 2024 at 18:42, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> The following changes since commit 44a9394b1d272b53306d097d4bc20ff7ad14b1=
59:
>
>   Merge tag 'pull-nvme-20241104' of https://gitlab.com/birkelund/qemu int=
o staging (2024-11-05 14:23:22 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/berrange/qemu tags/crypto-fixes-pull-request
>
> for you to fetch changes up to a7e42752324a264439bef28da3ee3e2563cf0e16:
>
>   crypto: perform runtime check for hash/hmac support in gcrypt (2024-11-=
05 18:37:18 +0000)
>
> ----------------------------------------------------------------
> * Remove deprecated 'loaded' property from crypto objects
> * Fix error checking of hash function in gcrypt
> * Perform runtime check for hash functions in gcrypt
> * Add SM3 hash function to pbkdf
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

