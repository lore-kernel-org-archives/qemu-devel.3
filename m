Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D41CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyQfL-0004WR-V3; Tue, 16 Sep 2025 04:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1uyQfJ-0004VY-RD
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:03:54 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1uyQfG-0002E6-L0
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 04:03:53 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45a1b0ce15fso7497865e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 01:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1758009827; x=1758614627; darn=nongnu.org;
 h=in-reply-to:references:to:cc:subject:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cwu5KEUH2m6Jpze51fqVpmKcc+wlK9DmKGIIelwd8g8=;
 b=lUEoNytlP+meQTDC0Rr5jLgHH5/pfZAbSK40fNbVBXavYT3lEBBMMGSIgTriDpLn4g
 9GktdfZUDnw4kJnq12TJDEytbjFf4/8WDvzYDTRW29yOX2Aq5evei0PpEdsZBNlXc6Mt
 SaKJ5xQeewxyB5rIbohlIab0d9Shz/RtOQjIyMgO609YL9WLydYlHBCjVVnblgu6kymb
 T+qyKcmiBZA5vwzuU0z0UoaryEpjg0/n72IFLmGFgSLQ30bRiZiQnpR00TTyTQ3qvVJ/
 hsUDZ2UFDHEiXM3WF2K+4Q/aO//uWFLPItWNqW7zDLTW8Bju9DIzd+9r6Nrw0vv91TR7
 796Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758009827; x=1758614627;
 h=in-reply-to:references:to:cc:subject:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cwu5KEUH2m6Jpze51fqVpmKcc+wlK9DmKGIIelwd8g8=;
 b=ZMrzQpofmm/sZ+p6KJQ0T9tno81tbdo6HtO63E7rhYDou1Eid125ZsKvwOXauCljrP
 sknFc0sU2uxz53z0lEYo+V/YxUqr8Los1hw1JkfVMdGCJ0eIy73psoILte7p+ULl4HPU
 z6o2+Lrm9a/jsEsblFW9V4aWqfZDRBmpHoll+qQOLc5AoeNt4BXKlY9oRMJd5cf9rWfW
 9EF6W7hT+jqykvqQlzTD4ZOzZXhP4Q7dGY+ONgKnZewDIstrWgC4kN1wUMwe3FzUTDEm
 a10p6MwlwXRi81BNsu7YydQCb8ebqLLaHAu88BcyDW6jVL/zh4luawHpPLulexK9FkjA
 FpFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQUxWQKTQuNpq00FqlGYxCfrKmAdx9DRcb+y/0cbds2afO773i00QtAitzBlq1Qn4CscBdA+LnAto0@nongnu.org
X-Gm-Message-State: AOJu0YxLiHU/15H1SkGTeqzzWfJ3e5PvqMcOGYpsffzCvxWIs3h53HBx
 NHGTfeAaWQaYY5+mnrPem8hAAdFEuZMb8wRen0KnRHpUWVxGA8aJbNIdaocESl/AcUA=
X-Gm-Gg: ASbGncuFfi6AzXwiuUWlndo+4iyQxqMpLFYkCtaHQSU3oEFh4iU7VSkSaujBji4OARk
 d8iQbsfV4UwuFoi3gG0D7piEGPDmfPi2fe1jwcu2gQCsnyt0rrPncbry/N9nRokPYr9MOB4zIFe
 m4iuvF7618KFvcrGOXClWR9XU2SRYj4pdh2SsTG2x1zQYPp27sAepf+SuFsaP6QiLXK1J4MaZT9
 Xm5T+ZD2wTwElC1FoTSvLwY9gfiv7Idzn4yEy22VVSF1IgmtOPuviheVEYSySK9dwI537v/joSi
 vOuW3WIxAwd1WvdcZiTI+qBuVMtairKaI1tvOgf/yf3TSL6LfGEglUtcXCCVXA1cFOL9PyCvrB3
 nMBnBZM3B1W/SX6fz6FXDwO84mDzByPtWf/TSGuFc4BQd6jhJM4YRimSX+g==
X-Google-Smtp-Source: AGHT+IHA2GPbDrgEsz2MrXTI7M4w39dhPlYTM3e+lLvtoySdqtNemPgIYLOci+L2JPclB0jvvU+B1g==
X-Received: by 2002:a05:600c:4691:b0:459:dfa8:b866 with SMTP id
 5b1f17b1804b1-45f214afb6dmr78761675e9.2.1758009827291; 
 Tue, 16 Sep 2025 01:03:47 -0700 (PDT)
Received: from localhost (ip-89-103-73-235.bb.vodafone.cz. [89.103.73.235])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-45e0372ae57sm205872385e9.8.2025.09.16.01.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 01:03:46 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Sep 2025 10:03:46 +0200
Message-Id: <DCU2H0SG4WG0.10TIXQISFI07A@ventanamicro.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
Subject: Re: [PATCH v9 2/2] Fix VM resume after QEMU+KVM migration
Cc: <ajones@ventanamicro.com>, <qemu-riscv@nongnu.org>,
 <alistair23@gmail.com>, <pbonzini@redhat.com>, <anup@brainfault.org>,
 <alistair.francis@wdc.com>, <palmer@dabbelt.com>, <xiamy@ultrarisc.com>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
To: "Xie Bo" <xb@ultrarisc.com>, <qemu-devel@nongnu.org>
References: <20250915070811.3422578-1-xb@ultrarisc.com>
 <20250915070811.3422578-3-xb@ultrarisc.com>
In-Reply-To: <20250915070811.3422578-3-xb@ultrarisc.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

2025-09-15T15:08:08+08:00, Xie Bo <xb@ultrarisc.com>:
> Fix two migration issues for virtual machines in KVM mode:
> 1.It saves and restores the vCPU's privilege mode to ensure that the
> vCPU's privilege mode is correct after migration.
> 2.It saves and restores the vCPU's mp_state (runnable or stopped) and
> includes this state in the migration sequence, upgrading the vmstate
> version to ensure that the vCPU's mp_state is correct after migration.

This could be two patches, each doing just one thing:
  * fix mode
  * fix mp_state

And the mode hunk that I pointed out in [v9 1/2] could be put in the
patch that fixes mode.

I jumped quite late into the review, so if others are fine with the
current split,

Reviewed-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com>

