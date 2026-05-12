Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D01CD4855
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 08:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMihd-0005Yw-Os; Tue, 12 May 2026 04:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMihb-0005Yh-Kn
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:42:55 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMihZ-0006QC-L9
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:42:54 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65c6a2158d3so3726608d50.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 01:42:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778575372; cv=none;
 d=google.com; s=arc-20240605;
 b=GAJ5bGHJur5xX6HbRCZjczB8io5A8EO03/m2T/JURYOFsxNo1xEI9Y8q0BMIB9xJlM
 5TESlkdYMeqedopQU2C6qw8Y3d4zwrRNkPi96MbJX9sIRyrWXffOPzrj+PVzBD4Oz9rW
 tWsKFN+mvwTrLTRYs78ECHopjZXgzl8j91VfwjGe6baHL10JCt0fWWonNjSqmuKx0aXQ
 1mOhPojLN3gH1G/UP5amLm/kbuRQKvoWTCXSknJnmwpTZXXYsSJDdViOCDvEnXJI8S7A
 WkNrMqJFXR/xqJJl24Lm83ospoaw4CxEMp/WPWfrpXAWGZTmuL0DOL4lWB/P22ozQpij
 NJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zLTisNsOsvjc9+PWSQ6HuYrt9PVoP2aC65LEOhNuZ94=;
 fh=8jLQ9BF8TzoH/ErGnlkH4vSIZ9SpUVgmQkqZ4x0ADis=;
 b=FLCublpn4TlfBo4/I4CltBYs4uUfqSkjKwr0RLVhYhIE5V5rEgcXAVsGXPqqHWB2vk
 rnAMh2a7uafgdtQZzHLvn2dIo4cPjIZ3/q737uB4IeS2Coi8iaUuNNButbUfjybofgZM
 lCPJjsd4I0hGlP9WbSvrhiKoWUcFVXhEM4gy5vcZtRZHZy8BNAAOpW1WyByhGy04ouM+
 xBcrhP5mAxQ90XdUFxpnSxin/b4KULw9kGhuJDmEzI/wr1J/K9kRhfho4hpApKxzLVDH
 gJCPk7mA63wc1AsBR7520hk6MC9H+aKAqg82vW/qtrnxKtnUI8X97j0atUePUK8BfXQ0
 iVYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778575372; x=1779180172; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zLTisNsOsvjc9+PWSQ6HuYrt9PVoP2aC65LEOhNuZ94=;
 b=MmQ6OngG3Obf1/lpnhSckckI1gEOoQMpoUyry+hiRHH2vMzklV7xN3kWygYttTv6JC
 TMyzU2ToENyhW7aCay4hQA3nZGuvA7BMzI/hqSa6JBKkTGBvtpc/5uR0hGbwdYXAGLuL
 iBXT+Wx5Gb1t/9ezL0i+efBku6Bxw+UJ1CWly6qoy7EkRLgRZFIYEbb5jE9zrApG7c+H
 HqZvu7DccQPWckibQWxuNU4PQInnYDniZGXS8zC07Qq45w+H8jAqS1KldZ9eBUy63MP+
 gjgMM1gan243F//oz8v7fjyH3TedGlu+5IjTU4MNSHE2QlFstynPKaUOgzCgssiGOT/t
 eXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778575372; x=1779180172;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLTisNsOsvjc9+PWSQ6HuYrt9PVoP2aC65LEOhNuZ94=;
 b=gOYcuang/FfHNMQVyfdwo6VGzQ9tK+qES0kiwMteZfaeCulfVEEeDJ1GrPyHBRwJOV
 bTXiWSUYfF6iWIR6bEqaPzxob2VyUYMOMWK514gIoMRL8LdsZauGUFzoC+nh/1e3SMWA
 mFF+iDUxbTzW0sb4aorC+47q5s6REu9b0wBxJ/F5cm31zOlrB47sRuhDNizMc+r+WT8N
 omYEoQB/oN13SWy6jAAaJ3VzGbKcpCjnObsDi2LmJzwkeRTJkhT/J4DAbBOW1LGoXmUU
 A8kMCrG8bCvQfTqCLd8jZnRjQsdc3wkr/zRFrPyVIMw9jpMsErzOme2iuxdQI6iCaeWt
 2oAw==
X-Gm-Message-State: AOJu0YzCcsKmc1dA7QkGtQPtGjakDaCFe2psLh850B/oqgjrvxk3iBs0
 5abRvaFGzF75CJIMIZjQghmLE5MCipUW9GRwXL0P+AmYa4D7aOvAM0XDr+KQe7za9YNcLS5ORhQ
 xmOeDeR37fM1xicZ9DmFfH/HjdOO8EH5I98GhIhPXDg==
X-Gm-Gg: Acq92OFTTD9sTvGKVZb5hH5Ecozyw0pxS4d3aCCtfD/CnXI/uSx0hqUV6fFza2Zfv/y
 QbhfN49OXg3CwYeYlU6QqLnfQ1RsgiW4Jc6i/5y31TZVdWuqK9iD3m3LFr8uEWXsz77G7B3rY18
 D8AayK1ZsE1ye5xYoJswx7b/k8pghZKKpoloqtM/28U66EF1lKAZ073M/O0ZbtCl5mGxZfMDAKg
 IjAUYdOCcCJ9dYECu0yjX239Hhz4dWrpnL9ovSpBcf3W5PMNzsNd1PaR/eZTeyiXi2W6zaV3qfz
 C+DtBtLd42cVo9V4JlBMVwI5J8EBY6vEMo6jlEFUwaiiZIqkUpkHNbExON0P4b3wmV4=
X-Received: by 2002:a05:690e:4801:b0:65d:bf4b:f16b with SMTP id
 956f58d0204a3-65dbf4bf942mr4678365d50.3.1778575371974; Tue, 12 May 2026
 01:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260511182432.1333467-1-peterx@redhat.com>
In-Reply-To: <20260511182432.1333467-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2026 09:42:39 +0100
X-Gm-Features: AVHnY4LXMJORlaybed5W18exzPyw0KdTBALi3wqrJJ7wKnILRV1ur5Ex5LfGDjI
Message-ID: <CAFEAcA9wO-CNfor3V9mh04T=aKUE8dD5a7GEavi4RrgLtPD1mA@mail.gmail.com>
Subject: Re: [PATCH v3] migration: Fix possible division by zero on calc
 expected downtime
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Mon, 11 May 2026 at 19:24, Peter Xu <peterx@redhat.com> wrote:
>
> Commit dd4fe8844b changed the reporting of expected downtime behavior, so
> that the value will be calculated on-demand.  One side effect on the change
> is QEMU will allow the calculation to happen anytime even if there's no
> transfer happening for a short while.
>
> PeterM reported an ubsan report from clang when running migration-test with
> aarch64 binary on x86_64 hosts.  I can also reproduce if I run the test
> concurrently so some of the src QEMU may not get chance to push any data,
> causing mbps to be 0:
>
> ../migration/migration.c:1051:12: runtime error: -nan is outside the range of representable values of type 'long'
>
> Fix it by properly handle both Inf and Nan to return INT64_MAX.
>
> Add a rich comment, per PeterM's suggestion.
>
> Link: https://lore.kernel.org/r/CAFEAcA-MYH6C39xO0OLx4-M5pKurJpurwRsMqZe9q=W-NShAbw@mail.gmail.com
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: dd4fe8844b ("migration: Calculate expected downtime on demand")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

