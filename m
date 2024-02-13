Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970B2C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 09:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZooZ-0001yY-VX; Tue, 13 Feb 2024 04:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZooY-0001y8-Dl
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:10:54 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZooW-0002yV-TA
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:10:54 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-561f5086a1fso419205a12.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707815451; x=1708420251; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9tJglhc81zUYw4ElHW68mk2XH8PW+R8MhTxP8Srfrg=;
 b=ty6Clm6uL2wfIr+yuxQGklVYmZldAnmtThfhq8iSjLP4HBbph+CpDhowLCbcD0UAe9
 YN+JBoJVEIfJRvVTgo6LtDU7egefq/7M3Cqq5VtwXZXa/ySD0sDES+xW87MBx/q4DsSg
 TN9uoQPS4psYNhAVChcrs2/WhgabTGf0tCo9KS1JWBa9PXNDmp9byn3RrDpbUWYEwpQK
 szGZeWP9slvpkGAdKVB3PwkI/ppZqbyDyTS01BP2AEjqe9j0OOYlOxU7fv8ZF/K98SJI
 UunAXqA0IPY9zbOSlBcSg5AhIIBRMJ+ny1pyj4SQQOiGomRuayUROiWegoqtAFk1XL76
 Hj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707815451; x=1708420251;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y9tJglhc81zUYw4ElHW68mk2XH8PW+R8MhTxP8Srfrg=;
 b=gfsUJ7DOUcZE7yLqVetNqCF+kBFVbJ4tAR7/NYEd9dyxLJ91yj3Cf7MMCTXJAVDI+K
 2V5k2C3uCNCzadGyFZmPmiR5CShtxRPKDLCV4+V6Ixz586AfZfl7CDc1vDTpnVHMZZXs
 t7RStHpNiGRQdV7k5xgh+CbqrS4gzn+oobX4pROPI9BufToWvehvJSU8E4UKJl0IlcGv
 osuGbybqKKneGQHtOebBtFQd8zHV5u+LPGoCw+6ovzn+ePuq0A5o1fKkCOvbf2E4NJvP
 luZbxZ7AO9J347LLhTlBQ60uBQ38Avg1bEfxrI6Ds9ossJi/wws9Q5s+GKoPZCzwAijD
 L3ow==
X-Gm-Message-State: AOJu0YyVRAy7BtUT/r7nc8a3+aAVtOdnj1G4Ue5nvDjvY8XJEavOqV1i
 AZDCRSE+RavPTqRjGEYz3MPadCM8K0vf+35TmNPOsIwJWoYuQXVHJd0T9vwf3PkR2c3s5y4Dd1l
 r/ESYI/X0LockhDJFvAFIQ3aXMoU043NCqMXS9Wpmip06JGwD
X-Google-Smtp-Source: AGHT+IFfczS6XY1bVOTB4jEB2RESBAW5X2CsnAQg82x1HhfVvNEP+Fsf6EBszoinVkn0tW2GcCthK+HoqEPcJJai+bY=
X-Received: by 2002:aa7:d8c7:0:b0:561:1364:bd06 with SMTP id
 k7-20020aa7d8c7000000b005611364bd06mr6430812eds.29.1707815451164; Tue, 13 Feb
 2024 01:10:51 -0800 (PST)
MIME-Version: 1.0
References: <20240211122909.5807-1-deller@kernel.org>
 <CAFEAcA-4ck9Ro-9x13veOqL-165i7q8w17HP7KDN_5uNj2RVEg@mail.gmail.com>
 <71756c3b-467d-4416-884d-e4aeed3482ba@gmx.de>
In-Reply-To: <71756c3b-467d-4416-884d-e4aeed3482ba@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2024 09:10:39 +0000
Message-ID: <CAFEAcA_CQ6PKHyvg9qKeWDJpkbTu8rv=TCm3GemJmKQCrjPNuA@mail.gmail.com>
Subject: Re: [PULL 00/12] Hppa64 patches
To: Helge Deller <deller@gmx.de>
Cc: deller@kernel.org, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 12 Feb 2024 at 23:04, Helge Deller <deller@gmx.de> wrote:
>
> On 2/12/24 22:16, Peter Maydell wrote:
> > This fails "make check", eg:
> > https://gitlab.com/qemu-project/qemu/-/jobs/6154451100
> >
> > because when the qom-test etc tests run qemu-system-hppa, it
> > barfs with "qemu-system-hppa: no firmware provided".
> >
> > That kind of firmware check needs to not fire when
> > using the qtest accel.
>
> Ok. But how do people usually work around this kind of issue?
> Test if the qtest accel is in use?
> Ignore if the firmware can't be loaded?
> Any hint would be great!

There's a qtest_enabled() function -- see eg hw/mips/malta.c
for an example of skipping the "fail on no firmware" check
when it's enabled. (There are a bunch of others in the tree too.)

thanks
-- PMM

