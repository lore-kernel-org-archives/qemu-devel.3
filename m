Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F93EC1E8B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 10:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnwQj-00026s-PO; Thu, 05 Feb 2026 05:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnwQi-000230-Ad
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 05:17:44 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnwQg-00071H-W6
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 05:17:44 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-790884840baso6917737b3.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 02:17:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770286662; cv=none;
 d=google.com; s=arc-20240605;
 b=AE56pFtg9KQRasZb6Kwip/0qVz/AUs63FmPksRxbtdAu2jGkr2r4zp+WMUaa9Sx+w5
 JAdf3gCpyYRD41ScztfWAklOP/oHeMZb+V+qeLyCorOdOc4366ZEqvieVrwIajg426Um
 j5XA5fegr1uupCcoIc7qOzuVOZZOpDODpvuPfPAruEb2BWGmnrgbwZruaoKW4jzh2JA0
 faKPQPwpSrIhCaLb8JlUT2R9xS/tUI63p/aO56BxbUCAk/JUODvQULvz9risSMVWYDPb
 gbtVNMxSn/6wYtYy4Vnk2Ca7us3teiqgVLlYzJBakOxNg7uEOuUSx/6Lm0ypyAGdA/8r
 qmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NwqyLTejgGUQwqWC9rLC0neXY1L1LQEfYlBSKMGnQbY=;
 fh=09I2axr4uxBaQZWOq7eGnNEbjKYzXXuOZ/WYgxqbxRU=;
 b=hX/ljR/K2CD1f+ynPXqC8oRIoiwm/3UaQN20kPFJ1c72nMkkwpD8K90IJ7fCSKwNtj
 IFfPAqstrag4iPX0UygDhXxa0T7ZK7mZ/Ozy6OSJs8Bz2mP4G/Fsd3sP9JwzBj4klHNR
 QkFPSI1Unu/XrEKsvBPUG0CUbrHaNM/QvYY0pc3ptYPTqXbv8I22r41PlUUgCT+ZSfam
 p7u3r1AqbeTOf8raND5asWV12Zz0o+1lXAzhE0dZM1Af2fF8Gqow6bq6wc0Tmyy9FhTL
 dwPQyqZfRMvizknjfLENL2dmwFIlzuoAS2EF3XIGXAZKSS0ssribJU4EUUOwVbPepEgR
 Ta2A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770286662; x=1770891462; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NwqyLTejgGUQwqWC9rLC0neXY1L1LQEfYlBSKMGnQbY=;
 b=kjfeTtSzddP1Oszrz4NPqhU3eLI0JKW5zsemeE+z27PEAZb3dS7a9j1FIf1EFnKvJX
 egrf73guH6d2tTfQP5FtXRbbcSPpoixJpP/GA+xNcwslEBEIHr48Lpr+xcVnnC5mxCO3
 Hhz1kXTFWoddrp/5P7cV//BY8x1cFcCiDrBygifAB9lb0JUDwCBhEQafICP4piWEryOM
 3lUS4yVWVuRElE+vi6aP9rSXTSsbrpFhPT5a6NX1eY7K4ZffcQpI+Gvz7fhencs0Xbv/
 GayZT/pmvmBRDmRHoO2s0IX41cq67YR5+wkvkbtIA7J2VqBWS3W9eJrdUzDuUOq+ceGc
 edtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770286662; x=1770891462;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwqyLTejgGUQwqWC9rLC0neXY1L1LQEfYlBSKMGnQbY=;
 b=B0i9uJ3GiWRhoC61tbLmq8I4uya/G4BELSivbSTdzIrHLhCLkv1AjrqDn/Rw8kZR5s
 aprWPgWNiHhntYut+7A2ipBXOfwTqYbASR9lWxLYP7lNOEsgyMzQYCDNr62EJgsuOXye
 r0d6xcSuJYcjvhLKWUUOUVl8zumBzp9HEDSAPNaCb/sfYp5tMjvHdb4Srakhx0ShDEy5
 yg8jURjMW9EwrkTJewkQZFSLHnoqbefFxkhqD+C3TfzvRviCvMgJ7oAuNtqxq1y/EE9z
 6xcb7krHXzJwpLCw5ztP9vk229GORtmhgleNtEcXlGlds96Ut/D+HkEdHiKEw1L7+KpT
 QuVw==
X-Gm-Message-State: AOJu0YwC/b+Y8weTz0RsLrqAWfleEWQN5L09cBpXNZm5EMWL359LXEnR
 LmrYMiscoZDUfOuJIOlePaHPkVGU5Xndh6nBwr3Hi0sVY+puOxK0F8FkLn+EAvoJP80IHRte+Cq
 OLMIrioWtJa5EOarrFzUZxUXA3krdtFqGOhd/etaIrg==
X-Gm-Gg: AZuq6aKst/dj5DU7O80OnnxMTNZZgmkjXVVn7ffeumcl+MKdajEu24ne+Cg9LbbYOQ0
 xs1N+Q/buy6PVC3hocwNLMPvdzkdkluIPojjLYsIeY9r/yG4CNkeIPWMn00591+sdS5TS8uMCsM
 xxt9WFg/sNrbVUf4X1FDEAxJQPHm6CZi5/lVN3h+6Bc+Zpo/oYUkw7dSwmecZr1vAM71rLfUgcl
 IdAG7S62iiumj4zuhOBBSL2QSugUeHfgnaydgohGu1NaKKdxvlwAMUfY+2uMSjXvZuX5g==
X-Received: by 2002:a05:690c:289:b0:795:e10:3c9c with SMTP id
 00721157ae682-7950e104ca6mr33143217b3.29.1770286661823; Thu, 05 Feb 2026
 02:17:41 -0800 (PST)
MIME-Version: 1.0
References: <20260129192009.14707-1-mohamed@unpredictable.fr>
 <20260129192009.14707-8-mohamed@unpredictable.fr>
In-Reply-To: <20260129192009.14707-8-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Feb 2026 10:17:30 +0000
X-Gm-Features: AZwV_QigkqPVo0n6PvcWC7mgVXFYBB9hP5GqRFZnSJ54x9ktmIJHHLWpVDx4VcU
Message-ID: <CAFEAcA8vQNvLUP72HE6Prak+AaZJPq_jf+Nd0Y6rXrGRSDYB7w@mail.gmail.com>
Subject: Re: [PATCH v19 07/22] docs: arm: update virt machine model description
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Thu, 29 Jan 2026 at 19:20, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Update the documentation to match current QEMU.
>
> Remove the mention of pre-2.7 machine models as those aren't provided
> anymore.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

