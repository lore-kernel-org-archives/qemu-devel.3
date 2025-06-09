Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899ACC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 14:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOdIU-0004PC-Th; Mon, 09 Jun 2025 10:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOdIL-0004O7-AL
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 10:16:14 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOdIJ-0001IY-Ev
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 10:16:13 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70e767ce72eso39653747b3.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 07:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749478569; x=1750083369; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bQIYhQQ46/3GiMg3bUTqo+IUCnHVfCM2joGVYy0qM+c=;
 b=XySB8XItjvj0RbcGHpnVFRkmW+R8DmHo6vM5pye7xsBNSPIEDazA8O0YcySwqcw2pn
 aK8PNzVHeE/vQR4p2LVPczwpmGDiYwExZ22eTBZGuLP8yy8BodWrzKDC0pUH3nU3U+mf
 6U1VTeLFifaioWqy2ANEq4eJBCfR3r9uZBkSxYYyQvPT9f3XK+w/zQ90L7de3dCtqy93
 jbN92qUoyp0ST0Z0/SIEOeTyIDheRZ2M2GTz7S840G4M7BKApAcd53QA6PTpEvPWwleO
 WXzS1tSgiAHpD9538Xn8zsk5K1JEVuGb8tKQ2OfNNgdT2CkEjInmWoR3EKh4Q0rvjkL4
 rLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749478569; x=1750083369;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bQIYhQQ46/3GiMg3bUTqo+IUCnHVfCM2joGVYy0qM+c=;
 b=IvYCeisU1H+OvCWTQ8DCtFyXw4Ec79f06NchvVCO5CrxV5S5zbDvi8j6x0H34CdDLH
 YMA5V5XKkcZ4ZBt1MIit/dALajGERhiXguGJ8cTyB0qc9X9gz0MKLwzaonjmUYz/EEHj
 wsCHC2C+hhGuZHxQBJjN4Uvr+F1Kva0qGiJkhH47KTR50ikE82FebGABwBXRmudi5NbD
 Ec1zxpuvCc/ggmcC6D40ij9682lKUN3WYDfedWnVeqKr4qOcc0AjbMKER1+Vu82fKcgk
 dmgTIXHQ1XTk9zUgr6Wl+DwxfCqkH7RWaeOwxcognQ3zZK1herGXy3TbE7IXAdGYqOxH
 cClA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZM2w3EsIpkeW88NQ2gO8piqE+dY9JcO2amF8LJJK3cbzpo9uN+v7zbP2zxBOKFfx5URWqbJpAyD/B@nongnu.org
X-Gm-Message-State: AOJu0YzEtkj0yVgheiGW5MxBy+RgjKj/8u/0PGhNvFyK7w72gQlNZ5PN
 OXEmhO1t+5RJdr4v+p7Q28dPSYvHUZ8DyOn8mYNvhZy0rjg/nvscjbhH660gmwMJ9LGb4qxcRcP
 4w7h07AmDbMXThboR6PAql/993DoQQzXbU53oyLa2/A==
X-Gm-Gg: ASbGnctBfyNQuJ/EPJ6lVa34ZMJkAaIOlpjCZMbKQPaD1HD342JM3128NctWaHZejvp
 T+KRCxiOXdrT6AjqsN2NcxGHPXG/aNKvzpQHYJYZyjNOMtqZnaLw5tCHXQX9iFpcLU1NytsjewF
 fx1yo7Zw+B7WSwgQAWo+Db43AuZtlDoZkOEg==
X-Google-Smtp-Source: AGHT+IGFmwjmtJILFeegMPtXYuXjjGYsSn4Ro2n6xsJMJR0Gsc6vbaKAKwk0LpaEbyameAYcx+Z5wybVFYben9BXAvE=
X-Received: by 2002:a05:690c:4b81:b0:710:f738:7125 with SMTP id
 00721157ae682-710f769a871mr196083687b3.19.1749478569516; Mon, 09 Jun 2025
 07:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250603101526.21217-1-thuth@redhat.com>
In-Reply-To: <20250603101526.21217-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jun 2025 15:15:58 +0100
X-Gm-Features: AX0GCFv42zoJTk9_HqDN9y9K06QDDEO7H-9dqbRdWlvcJqpqgMJsig012zjrwzY
Message-ID: <CAFEAcA84xH7t=8GQW5ZiVGmYJ4uet0ddS4ip2C1GFyN+yKxmFg@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: Add a test for the realview-eb-mpcore
 machine
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Tue, 3 Jun 2025 at 11:15, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Thomas Huth <thuth@redhat.com>
>
> Check that we can boot a Linux kernel here and that we can at
> least send one ping network packet.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                           |  1 +
>  tests/functional/meson.build          |  1 +
>  tests/functional/test_arm_realview.py | 47 +++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+)
>  create mode 100755 tests/functional/test_arm_realview.py
>



Applied to target-arm.next, thanks.

-- PMM

