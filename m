Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EE2106ACCD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0kX7-0006gt-02; Thu, 12 Mar 2026 14:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0kX4-0006eo-H9
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:13:14 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0kWz-00051Q-Q6
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:13:12 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64ca1ba0089so1351922d50.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 11:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773339189; cv=none;
 d=google.com; s=arc-20240605;
 b=CHMDuaXOqv8aYhyasljp8Um6mrfxw9DAiE5bB3V2YAu6Sdqn1VhUj1RcbGH8M13p2d
 8MIgmqO+K7CusxSkwbvUVTVR+ZflvqCQ4JJbRyOxWzo82rX73uBVlHCDUyvUo08pkR+2
 dke9cdX2aNpx+TyMG0dtIMCQux4HJWP+JLzkSbSm1kYjMTbKcZTOydkr8opkzZZ6NKSd
 FDL+8da6UA/X+LZrjZXcrVsjikQEecRSuV7Mlo5feUZzinWOIiUVCwuIMmMQFAL9jf53
 bpoRCJI07h5F51Tulk3pO4kkye01ef2c5VBgkR0hxj+ozNTeUcZ3fRewCDDUf++5cm5a
 C5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Bj2ux2ZKIDOgh8BWnUS91esbp9/1Bxkgcp3sKxYffs0=;
 fh=aoMLixUL2qiim8HMY1VRDEv3jtKPzRLEfPHkJ6XdwnA=;
 b=guH8wdz9JQtqHkm6bYc/SvPUADEStgr+zSnpy3zr9rs7IdyLDQIaIVlfWPmg+vifjl
 9ak4rePfRCM0z/hQXQ1JcAtuUZeUZE2LXPpRwjt0v2sBoRl93lWCcgdxGrftYLC7BAKl
 jvnBNi8eyl1yiQ58RvLx0AewZ+7srX25mWq5BZYSfgSWit36rm0DHtLQzpZar/bhvmRf
 E7oAaD5IRoKNTRk4pAWdupC04AGqm0iUOH6l5j14R/xTVWPJWdP/TTubuRxta68x3acs
 mHfF/0IA6xMVZ1cWTiKhHtMLmdY/+4Kj+8l3K0mO+OhA25nbhIqlFHEhApUwZ5RWkknW
 hHCg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773339189; x=1773943989; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bj2ux2ZKIDOgh8BWnUS91esbp9/1Bxkgcp3sKxYffs0=;
 b=DaZ6evRBWVT1MTGnBVzN+ebBb+i0LSyPxKCBeuju9tHj/NQ7h/E/+5JGla0fSRxM04
 WWVYI+0hdaMh5+KHgtB8lthiOaJI5rGx1/rRleBavyo4EUOhF4sElRp3oxcpyajT/Kek
 JUetHvlenB2/uOK6QtXtmy9M1KNZpu+qFqQ0w01dkYwrQqC0pPmfQp+X4ZA03o6I9Jra
 DgRj7glZrvdZC2d0f8kyOC5HKqEB4xQG2T4nYV2rtHzy7Uze+y1FemrkSS5FlMdhyUo7
 i3gRvN98YezTCyP0xR5PI+PV/BMexrm2KccEeb5O9/j4g96v+9pBgrrz3QDVR1zj9rTu
 TPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773339189; x=1773943989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bj2ux2ZKIDOgh8BWnUS91esbp9/1Bxkgcp3sKxYffs0=;
 b=dYJP/ONeL17AKMOch7sQUDhuSBL0Pn47DuI2bcprPgCnG06W2tTgkgmSXuNZX+heGE
 jFUR8kOG6in9maGF4PNF/F3XMajeSYFqGAm0iIVrUw7ESU0KsbZZfykEoejwhNPMPebH
 IiZ7gQNfPa3gjAa/PMuveRN2t0DKYRUeYAm0s0huicExgU+64+REiarYoROLEMX0bgny
 S5nXRHpd4AOPnj5BuoF0FDHRXElXjJG7ASQd1+t5eB8vHNREZe0qysxhlwgO8XfpxFSS
 k+u0U2weaQZpF+ALLaGkBQsyZ0dOTIVipqbs4uMT3Fl1+NWn14e0igAmGZs4nvHsbT/e
 7oeQ==
X-Gm-Message-State: AOJu0YxB73UY5hWTcA1r2hvmQEJ7iBSPwcG1Ta46Phrov7jDmMqQ+czT
 ufnSJz7R7swyEF+OlQIh/MTeOWaP6HhO+MfR0tHfDNzuY/J1yEF89SG80Odt/VTDii/ohD4gXsh
 ynpWep4CN6XelNhJ5KjaLlLzqqKBcaSrHlDBDStj4BQ==
X-Gm-Gg: ATEYQzx9RmaKX1wJeoaiFbWcOfHikf866KnkJT6HEUvH9zjn8J4XfaULwmSORSG73FN
 u8Erne//n/8+taMU5zQGs4VfEK5ydpTj/rludXoMtprmdovlK1yabZYug1Xb5ndh1A51KEiieB5
 BviWlKwa7blSF9NIUyH1Eo4gxruaMalUS5MWHfsuoKU26lGQ7sVJwLtfcH1f6Ozpb7xiCAuEro9
 RawxO+aqkhFBTd+a2ahY86Bk2WjA9RaOJnFd5PdvXbYHJ0xMI9bQkr8EPOjCtanZQDpY8CE8GNf
 gMmNpvuv0XKzkSlJURH+8wH5yCE+LgfVTuJP631XHkNgdXAPkq13XwYgpiuFdvSTJJs=
X-Received: by 2002:a05:690e:2545:b0:649:6053:15da with SMTP id
 956f58d0204a3-64e63093f18mr384520d50.63.1773339188633; Thu, 12 Mar 2026
 11:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260312121617.228654-1-vikingtc4@gmail.com>
In-Reply-To: <20260312121617.228654-1-vikingtc4@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 18:12:56 +0000
X-Gm-Features: AaiRm52f1EAtcDSQogpaEH7SHvCXEdQFsyEqo_zjGrBcbFg15xEaDUJ_f9AX-pM
Message-ID: <CAFEAcA90yzGw6=GBCD99ZjsEqLNm+NbZAZjQTC1ormu_BscUSQ@mail.gmail.com>
Subject: Re: [PATCH] plugins/api-system: Handle migrate_add_blocker() failure
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Thu, 12 Mar 2026 at 12:17, Trieu Huynh <vikingtc4@gmail.com> wrote:
>
> migrate_add_blocker() can fail (e.g. if migration is already in
> progress), in which case it returns a negative value and populates
> its errp argument with the reason.
>
> The previous code ignored the return value, leaving state
> inconsistent on failure. Fix this by:
> - Passing a local Error ** so failure details can be reported.
> - Checking the return value; on failure, report the error, free the
>   migration_blocker Error object, and return NULL to the caller.
>
> Resolves: CID 1645470
>
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>  plugins/api-system.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/plugins/api-system.c b/plugins/api-system.c
> index 9a70b9caa6..f0d6cefe74 100644
> --- a/plugins/api-system.c
> +++ b/plugins/api-system.c
> @@ -105,10 +105,16 @@ static Error *migration_blocker;
>  const void *qemu_plugin_request_time_control(void)
>  {
>      if (!has_control) {
> +        Error *local_err = NULL;
>          has_control = true;
>          error_setg(&migration_blocker,
>                     "TCG plugin time control does not support migration");
> -        migrate_add_blocker(&migration_blocker, NULL);
> +        if (migrate_add_blocker(&migration_blocker, &local_err) < 0) {
> +            error_report_err(local_err);
> +            error_free(migration_blocker);
> +            migration_blocker = NULL;

You don't need to free the migration_blocker Error if
migrate_add_blocker() fails -- the function documents that it
will do that for you and set the pointer to NULL.

> +            migration_blocker = NULL;
> +            return NULL;
> +        }
>          return &has_control;

thanks
-- PMM

