Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0C3FED3F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 18:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGKqP-0003Ez-5c; Fri, 24 Apr 2026 14:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGKqB-0003EL-JG
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 14:01:23 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGKq8-0004zR-SR
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 14:01:22 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64e87a81639so7456259d50.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 11:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777053680; cv=none;
 d=google.com; s=arc-20240605;
 b=Mq0r5eqQAJ7WEUhEJzYpGTfKUgK0hHPqRdey9kvy1bfiGjHGsyPQoWiIt9Spd3xxZh
 NCyG1zphIljHRXaE4IgCh8yegzxjfVOotomdhPZos69pcKp+nLYfmHDW6Q+ZmTdY7WkP
 tFq0YMNu23VwmGQUFcxSOnqLwRYAcJaM4l0IlmR7q2UGVnrk6Rdcsztc7SvcEHlwbp33
 /iCCBi25IwThXM6SvzOwgl+ZLD2W5tsaxArpxUHXSpKjHnZ8WkDF4J8fUS6Iu1oVjxnY
 BGRlgIoApPPduyLmCEmwWV2fAAsC1V4Ivnf8gMWFEZM6uN+OBL6mhtZYIw5NKeX4Ngey
 LMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=H6xKs2JcMzQ9U+izquUmflV6O2vtt6hKMo3n/a44qso=;
 fh=qZLBSPzoBei/je6oSGvPCoqtBpEDiFx/ngtzin+1j0Q=;
 b=Ll5Zgjd/GHOcQzOCmx5IxnqfWugKm8zVryehNIzwOzf0KKYB58JLur5471brIBXk9Y
 lPcai8GvfDp1ilylCy3dNTJ8I7Npxui0J+xpTE0HFjqwQXQ5mPk2kCg+U/6WJqfQxI7G
 0ti/nK/xBV1UTVZ7cXImNqP/6Y/DlBtOtdXCToEP+obUBebhw5waCWa4zY53+HeDhZZS
 t0gRTFIly0XqChSrpBec9hD3WQ141LywLd6f78wjpv3pStwhGWpANBdy9rGQpGLH9I8j
 IGmA2ZCDWU53cHZkhqtxg4uEnfMGW03mBWoEj6KWlp5/B8ZTvLMnlItVOpmMf1m3hb2i
 jHTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777053680; x=1777658480; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H6xKs2JcMzQ9U+izquUmflV6O2vtt6hKMo3n/a44qso=;
 b=lIdGQEzHw30Sy0Wj2u/qhipoapIEt2FdI/olA4cDnU9GZ6eDfjMj/1lPsDoELDkhRX
 BuaTn/tfGpXLkBtUUrv9jtwpjoiGThccS+i9dahYOfGpDS/QG3YQt/2fHPTF2gg47Xdb
 Eyd/D4sIyew/BAgBSMpkiLeJH0luc67wKZQzBW8VKb2UGqiIcPB3v6HkqjkIZawD5vCj
 ILHRdX33lS0C3BnHHnfQesNjyOY1wrNnFEavqjxUXQd5W78TvEbE6qQepxKucpawfh0d
 3alFR9xBTJMUDuJxDxLnzzIBlUA30tI93xq00TxDfccmOVodQvC6sCndwXcPT42BX+L4
 NaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777053680; x=1777658480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6xKs2JcMzQ9U+izquUmflV6O2vtt6hKMo3n/a44qso=;
 b=CUrzW5QUeiifqDuyJm6dRotaqYdkJe2U641nktjJMs5OCIGgiGEjibFDr0NcpSRJ6a
 oSSxb6YmZixurXBW21qgB5cskDPyvjOG+VjfjLAjNdzz7VqpvYE+SyFUSGfg5mJPXhzZ
 8R2sB7XEnnb+Y1TYv+BaRYxzsiq7gTVpFRbc2QqVupD95W77NcizAmKtBi1+yf+33yre
 YUbsSH2L+0yeFNQSBOrI8Xn7H/EfZhLbIXKxY+RFaiynnPemRzSmVs0oe/T3magZO7Wp
 om3it2sHSStOabIGYRBVJHosAAxIk39tv+fuU+CthHR4FZF9hZCDxx0suCFIBLnig8so
 Zqtw==
X-Gm-Message-State: AOJu0Yyy7skt5GAMNG/bP2J5oi8PKy4AVndC+BQVh1tFQ9m/MlG2MP2x
 fR9odjR/gEB+MpopR75gUZ0QUDk5tkweYcnLvMVhbngmZpREkFbugGKwJOpomFuYa5W/SQ2GNkR
 RNooHnj0lta4cimF081mM82qWeKJnIJufpKeECaDD/A==
X-Gm-Gg: AeBDievWuccz8KkywMFH+oJMPa85LTKZbThnTg81wrdJLRS3E04XzUmZcZKC4V0KZv3
 HrcacIOb6fbHaKKTAaDAaPRjylI8VmfR+YoRxW4Y42NoshKj+iJPkBQzYhzpFGg9eYDva7xYDkk
 +Z8DJKvfEPpHJ8llPMymvBe5MlJetYZxQfl0vKn/WBnHYpfCcddlDW+//nQP00cCc2oW5vxDNk3
 8AV0VO6HRaz1GbYnVgXbLnu5lOXL7ktXrFwrPwMbzZ9TyiwwYGByYos84pTA7bq4gGznY9a0rzR
 iGOsJl+KN0Jd/FFWTo2c60NMkZlKtGHH8ca4Ac37GkqHuwEv5nrVXoIH1rxy8fKvWHB3qgT4GLf
 p1A==
X-Received: by 2002:a05:690e:138b:b0:652:738f:4461 with SMTP id
 956f58d0204a3-65310aefc52mr30861629d50.58.1777053679378; Fri, 24 Apr 2026
 11:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250822092410.25833-1-cjchen@igel.co.jp>
 <CAAMq-Y86UY7LNe-p2P_d8mw7FgTqLm=HQdqbMvV8xxTdsZmx1A@mail.gmail.com>
 <CAFEAcA_EZxgnSHOEwdF5QayAxsncYnGGe4RDPP-vwYTqwU+dNA@mail.gmail.com>
In-Reply-To: <CAFEAcA_EZxgnSHOEwdF5QayAxsncYnGGe4RDPP-vwYTqwU+dNA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Apr 2026 19:01:07 +0100
X-Gm-Features: AQROBzCWjR3L1uL0RP9JA_c0WECdOHMhhjXkWv8Bfxkxy6uMh5lBSjMdEW3O5yA
Message-ID: <CAFEAcA_-XVMWr2ksaypuCiAZwU3GUKnvK26e35W-Tne8+BMNCg@mail.gmail.com>
Subject: Re: [Withdrawn] [RFC PATCH v2 0/9] support unaligned access to xHCI
 Capability
To: chen CJ <cjchen@igel.co.jp>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Tomoyuki Hirose <hrstmyk811m@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Wed, 3 Sept 2025 at 10:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 3 Sept 2025 at 06:03, chen CJ <cjchen@igel.co.jp> wrote:
> >
> > I would like to withdraw this patch series.
> >
> > Sorry for the inconvenience, and thank you for your understanding.
>
> That's unfortunate; I think it's an issue we really do need to fix,
> but I entirely understand if you don't have the time to work
> on it further.
>
> I might pick it up if I have the time to do so.

I eventually found some time/inclination to have another
look at this. I have something that I think is mostly good to
go, but I need to chase down the last few issues with it first.
Hope to send a patchset next week sometime.

-- PMM

