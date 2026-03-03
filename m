Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD080EC1431
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxO1d-0001dx-BS; Tue, 03 Mar 2026 06:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxO1b-0001Z6-HE
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:34:51 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxO1Z-0000A9-6G
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:34:50 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-79801df3e21so51383797b3.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:34:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772537688; cv=none;
 d=google.com; s=arc-20240605;
 b=J8tnW/cGiaYnn6bfrDty11cagq+LDySlyJ6FxZ8TWy+bIBkvsCBe6lS0/jz5nRFPKa
 553KrdYF9F0BQjTfcek4T9utn8ljl831qWZ7u9eiHqWtDIb384ZqjXtYbj7+8E9hJPXF
 jz9Sl0bFN4iyMCnuTq4mndjEto5tC/cLvJfJKCW/70J9JlVpnzWSMRpd37zO3B3FF2aw
 hOmoq+PbgR8O4XBnBLIQaP8gbGrSCr0UOrqtJYcbI1y2HvlbRYrEH0UYE/xgOwWoUNaB
 lrmkUInSyFYwu/kAjO85eeczeCajMy+OP7hFmBw/KCvV1gEI2Fb5Gk2t4aJrev6xoUf2
 mBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5NRJS8Fmj6taE+ChlPXhko7izMNTfy88kisQKe4FMyw=;
 fh=e8lPG31nRq0pa29+ILZPVpv23pShvDc8zQNyomzI6HQ=;
 b=PR/UYqIV0fBT4eou6FbJLwmvwcrKgfh0RRskzJm+NohUNsBll+qNtDlKa8542X3QKk
 Q9P5V9lz9If9SoJvEEa6q/TUiWqhDz31iiwUx/kl7Xb/dqgXZyVcb8JyLAefi3zdv77k
 caJCVlOp21aePmY2x0eRAVVdzwv0gBUYPbqrWrBKuFZjicycyrgQPwvohZvut1akfj5r
 U3X3un2pHSWwd4PZTmolzMxqYgLtp1vqBabMzraCg/8ga2rL0EFACAN+Ld6cwY7NtB/K
 qQVzf4btb9ttNtSRYJwu6TNiBgHnhuQqNKmPqoOjDaCNmsjqvB7Ckpt+DlwrxJZO8HdI
 FZ9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772537688; x=1773142488; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5NRJS8Fmj6taE+ChlPXhko7izMNTfy88kisQKe4FMyw=;
 b=gSZwh/W1hpmmYKGuFa+pFTP2z1O+F7Ex28CW2NdL6RA65m2uufJarkev5h3xPtgZdG
 iKHKEqRaUs1+d4kAu9GKUjcUndMoOZQErgbWTfCNLcFN2qb5mg903lsR5jCR0ulAYMZO
 f1xX14aU/FkedZGCYPP4T9qmLJjygFDRLJPEgEIALuDtmN2+8dDV5zPpK5wgb6KfaEx4
 +NFUC8vtOTqo0jjzIVT4BLFMgbeGmqwwADarZgX/BfaegHy+itWQSdN0nR+2bVut4Tug
 Fj88mTHOfqftqlPcQwu4tnfg14z1TDdzQcAiZymH8gZnm9ME0I+BfjKa4eWcYvX+19vb
 50Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772537688; x=1773142488;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5NRJS8Fmj6taE+ChlPXhko7izMNTfy88kisQKe4FMyw=;
 b=ZIlewLLAMIYxjxU65oYK9m0YuKPpJ8L9AkgPDC7rlw3BEmfm0IVqjczUxqUsR3e8ap
 7o4g55Egh9RlntPUSHr+7o03mAL8Rj71vAzDfZ/OQMkj1tyrQG/jxM6xBznvL3YQj6ui
 9Mhzqqdlot3Fwa0WmutbMatEOE1ou2FYYNuuS/3MFb0Q4lRGVuN8JVw1dIdLz4SIuuRQ
 fO3Gh4AVE9DkwukA93i0x76RHk4u+WRa8O7SxYf7dmtT5NtPjQsrKj2D1gNFRGMas8/+
 +5eKw3VtZpqlMuInmol5vE5+7424DkPD6UZz2td+fmKS/hogMLQXJ0zUIK0ZvjDlP8Rp
 L9Ig==
X-Gm-Message-State: AOJu0Yzni6wnf9uJG02dPb+NE0S2/7lmqsElu0gSWzfoECAoaEXCeo3J
 EgNu9fKsXnGMwx5YsmVQk3VjIJruHF8KvJl1xKzsbb1JewyNucPtUhz1YV/EfoIDHEa5/L8Sick
 gW4TH3787MUnAZ0JufDmx/6dAMZwMUbgCSDDqdledCg==
X-Gm-Gg: ATEYQzz6KnrqtOgazwFQ9nmaeQqYlb6FC8M1fKDNw4Cr1OZD3k2+t1F2OiMBu8w4qY5
 OTTHl0RnC5DK43O7i0fVB7F4EurL+dWQh4Tko8+l3tOLnjxopcY4OiY1ud0zsQ5pLB/Sf2T/AI8
 0FREYxX1LZv0yaIuagABs9dmxLzO0UqKuVW13rnriNj7hC4zW+rVf3p9HYG/YAhujsFjYj4yobt
 xThL2Uyc4JWvtw4kJVPmK3Y4k5hjMsk8M0F6jZaCjSz2HzDN3Z0kzr5jtMTmhVpw4Sa4BdzE1D6
 i5R1BbZbSbDa3uRFeUZ2PBQB5czerfImoXPilzcpJJ7VTc6q4tKQ0CFA3ohJVSmu1L8=
X-Received: by 2002:a05:690c:48c2:b0:797:bc43:79ac with SMTP id
 00721157ae682-798855d40e3mr140699477b3.32.1772537687809; Tue, 03 Mar 2026
 03:34:47 -0800 (PST)
MIME-Version: 1.0
References: <20260302220254.1166849-1-shentey@gmail.com>
 <20260302220254.1166849-10-shentey@gmail.com>
In-Reply-To: <20260302220254.1166849-10-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:34:35 +0000
X-Gm-Features: AaiRm50vj068LkwKq08-bcjNnZxLXBQBnXjc0992kjCYPkAh0Tw_P8_7kU4mSjE
Message-ID: <CAFEAcA8u=V-hn1XLMw4Q9vvH-=q7aKq1wPb5C_82+EwbDAVLbQ@mail.gmail.com>
Subject: Re: [PATCH 09/12] util/fifo8: Make all read-only methods const-correct
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Mon, 2 Mar 2026 at 22:03, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Allows these methods to be used in const contexts, i.e. where the parent
> of the fifo itself is const. This is in particular useful for Rust code.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/qemu/fifo8.h | 10 +++++-----
>  util/fifo8.c         | 10 +++++-----
>  2 files changed, 10 insertions(+), 10 deletions(-)
>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

