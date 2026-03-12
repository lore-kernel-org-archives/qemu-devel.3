Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3974A106ACCD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0kTP-0005fq-PX; Thu, 12 Mar 2026 14:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0kTE-0005fX-NK
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:09:17 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0kTB-00045O-Ho
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:09:15 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ad9fabd08so1773846d50.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 11:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773338952; cv=none;
 d=google.com; s=arc-20240605;
 b=CGG4z42tPRI+Iqyz2Slu0h7sm0pZ1oqIkcqlyVnzYLcwMEiM7Rresu/N5CA7OWYX9n
 478xTrLgmoH1D88W04YIdYQzQvKtAeEHLxkwwBh9zBEwOQPKDhvX3hcYCY0WlFxbN5Fs
 OGBlzD9cureSsUmhnPFddJ3k779LDebdiCYvNBu85v2geVacKKfTNWflHSIvQ1pq0avv
 g1XnuPV8TsKiV5H2/n98Al72L0ZM4d6zgb+rzV3eE3A84B9i+/FuliLFtNSgybtIXejW
 St0TpUeqcv8T57bjkUDpgbBHdgR7iV+he0XHX/LSdWcZwz2eZApgqxgyIiLM6zoT8dUc
 CZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Hn/DQbNDnb1SE7e9KWKhdpEZ81O5c1zj037552NaUI4=;
 fh=49pLzmJ/j6jAPgMhGWGU3UK0QaR2KuJR3Os1mSCfjXs=;
 b=WcHOVlLqXy++6gFFdtXhM7lX5pehP9FYnXIIlWCJ8MoR8s8Lsy6/zvkuzrYZQf3RRX
 HWb81/nLjLtbmQDckNDhXHFs0wkwVdrhXCHnGtPp9EL+5NkHBgrLRiiMNebaKWtxWrfZ
 5DZaZCZEWLqtSpN1pAOXx4qI1EZd842AUFb3BxMhjKluGfPNIUN5Ep3tQUoepZtqWbfq
 HewZn3z5+Bq01YhRBSH0YyCCeYtJC9DaO9Szn8TpZbewNKz80XCjAtJKhMkL3Y8IPsq8
 WtCXkoHnN1BUTyxYm5vLaqyyR9IJ0d4ldd16Av+rikkAq9y52jMkm3Kq2TBj9Y/LZ1pC
 3+pQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773338952; x=1773943752; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hn/DQbNDnb1SE7e9KWKhdpEZ81O5c1zj037552NaUI4=;
 b=g3iUyv0fiDWNtLQl5LTS4z40ZuVK3r6EGVAnlXZ9UuIfyk8MpjPeTAcJLV42KpZRij
 +cU+LjFOdpRfUJoE2uYwhMuzPAnsCiCCrfRTlAv7x9ZKSkEN0sdER0LRmnl58S/K7gMZ
 beegmgokl7vHUAn8UfpN4/ysii/AHpriEUxHNzXp9uxbYF5AZoYsrjnSEwF8GbdORByl
 D+zewbHgCqCJvYQ8xuYPrr/dRjFw95U/ATt7ypT4Y9DlaoSiPMK/ZSBcHY2kSlykMghj
 M6KNYUk6ppNDaZ+IKuYHxuuaKF3Aue34G5fUeIoquq02FcDtpraV5h8KEL5VC9/G4mgw
 s1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773338952; x=1773943752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hn/DQbNDnb1SE7e9KWKhdpEZ81O5c1zj037552NaUI4=;
 b=CMC2onEq1TRMjThnOLC/IF0cGGgMSpyyXx0iv+y7xNXS3xeFzJQ3o+PeRr+I4rJx13
 y6T8m9AAd945nx8V7j6gFAvFkbkd16EDO6ltGL/zztwmhGsTjVwNI9GdJg88go2vMxF2
 dWrdQzxPnkJuNW779J3vw1X7DLsHqLFNqGpqud1vqNz+dMhWWjEeWO3qK5d030Niir4M
 zDWhhGwdP50SG5qLKux7m5BRp5i3uPx2IpdEUeJa+tiNOTp/vWTpgFQ65wxr4lbE3Dmh
 IjNRqc74Hxc9SEF0XJdyt4aY40UM+4QZyhsi6kgxWm69Z+7Y+wc+UO7fsngEQRCCzVSc
 63ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3eW5wdQ+TTO5L/R7On5hDUXIljS08ayc8padtKn2ooVdWGXC++ygvIPEMXMQKFeVd/Y3l8ZPe8yrs@nongnu.org
X-Gm-Message-State: AOJu0Yyjjqph6JsknL8qQRm4uqFnG26ix6fGG1FAi37Ehel6ooN3F9YK
 03WQvOwYPUvaFwwcKPB3+QfTcH+mqYDiiHB2oQAaUCrt7+GV+ilkEpqAEBuPMRvSjaGBQu0UQrN
 B9ngoCSHYjIfL1xdsxzFCkqDI6JbTWlItH1ZoLxd/xw==
X-Gm-Gg: ATEYQzzK7ogLfKgMg7WuhQxXyqiXT4f7JsK1P9XBaw4ZAXcR/4r7m7DqAEGYmwb0bWW
 I6lQHReQ6CIb686Ygpgl7DnBC4nnrRqSQhM6ZRS7lbDrbW93ojP19ECy94fx95sqvdS3mY3jl5A
 k+M/8bIqMSA2vQmFGgopokTDu/ph+6bAkszbSY1W9SpyiwMGFqEDnXZlL1aziDBvKAsl2ksIp66
 wSGwktHgXl6DJJaGfhf6MPphks0ZmJzskHVQti28eUK1Op1Twh5ZUcldICqWrYjzOtJqmMmIq29
 cyWPcOn9Q8FBjlQuTNl8M5IQzOcrZtemep4Wzwtk8gesgf5DWk08OV6LRtmOBm6S7Jr2xCS2hSI
 V3Q==
X-Received: by 2002:a53:e23b:0:b0:64a:dd9d:e944 with SMTP id
 956f58d0204a3-64e62f68f5bmr430741d50.25.1773338951752; Thu, 12 Mar 2026
 11:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260312121617.228654-1-vikingtc4@gmail.com>
 <4d7c6db3-0915-411d-ac1a-f26b5b38dc28@linaro.org>
In-Reply-To: <4d7c6db3-0915-411d-ac1a-f26b5b38dc28@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 18:08:59 +0000
X-Gm-Features: AaiRm52tR3jsno1WYZKeyn6rvlnx8tvqMDI2_IaSXa4viT8XHd51j0wweYsq4aA
Message-ID: <CAFEAcA9m_0VCWzxFACJzHKw=WUQhmuXSEgHzfJs1a9NUzWm6SQ@mail.gmail.com>
Subject: Re: [PATCH] plugins/api-system: Handle migrate_add_blocker() failure
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 12 Mar 2026 at 18:02, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 3/12/26 5:16 AM, Trieu Huynh wrote:
> > migrate_add_blocker() can fail (e.g. if migration is already in
> > progress), in which case it returns a negative value and populates
> > its errp argument with the reason.
> >
> > The previous code ignored the return value, leaving state
> > inconsistent on failure. Fix this by:
> > - Passing a local Error ** so failure details can be reported.
> > - Checking the return value; on failure, report the error, free the
> >    migration_blocker Error object, and return NULL to the caller.
> >
> > Resolves: CID 1645470
> >
> > Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> > ---
> >   plugins/api-system.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
>
> While the description makes sense, how would it happen in real world?
>
> Plugins usually will request time control on startup (so no migration is
> happening). In all cases, plugin who want to control time will have no
> other choice than abort.
> Maybe we could simply assert that migrate_add_blocker succeeded in this
> context.

If the user starts QEMU with the --only-migratable option then
all attempts to install migration-blockers will fail. In this
case we need to report to the user that the thing they tried
to do (use a time-control plugin and also migrate) isn't possible,
i.e. exit cleanly with an error rather than falling over.

thanks
-- PMM

