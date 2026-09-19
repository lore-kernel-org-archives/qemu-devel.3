Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B51C982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7y4L-0001b1-MK; Sat, 19 Sep 2026 12:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1x7y4H-0001ah-Q8
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:37:37 -0400
Received: from mail-ej2-x0f.google.com ([2a00:1450:4864:34::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1x7y4F-0005yQ-WA
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:37:37 -0400
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c2a1a631f6aso195112166b.3
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789835853; x=1790440653; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=N6wnGmKgvjVVHMQ06XeVIkpnoPx8IDty374UJRSfqRI=;
 b=jf27IMJdq618u+kRPp/VmwEZ8qw2hphDWrVtBqJPM8u/tMGiDa3kkeBYLDOJo/m5p/
 /wTtbQeak8HWK8j9B3+6cQqneYax42UtCNjSlJDPZmczrL+7BQ5BlIIpKAYs1Y5Lmksy
 y6U84M2v9x3eJtVKM0jZJBEdqVvcstat6sjMPfp//e/h6vromEnDD5dby0GbU31GjKc8
 2gRnRS3sm1G79hlzGqeWcwSDik/ltaV3SCltWAiULf+Q/K1oedoPRfJbvYKt2ZD0YsKs
 dhwMX5JWUb1XV03VyLHyw0oX+sugiQRjvIuXxv1akEsx0MJn2TEcrf7sh31IDddYX/2+
 UmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789835853; x=1790440653;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N6wnGmKgvjVVHMQ06XeVIkpnoPx8IDty374UJRSfqRI=;
 b=OQai21VtQvIni2wxAYRXOXVGybQXsdP6EzzQkjkz13Y2JYaw6/rWC714IdKF8Jhu+I
 kFVsKORtGmbB2ueoCC1lM/yrBG14k62/Vu2A+0VmsjhFsSPl8QeaqyF798p3sNkA9n33
 +BBQMMC4su3sCL3ydloh4gK+32S2Trwfz65vnCqnQc3VC0422jefRcPiBLbF+HiR1w3u
 qHhL+FygxFssFsVjGEx7RcdmyAuyLg2f6qa0qa65TtnXP7LDSWL9dTtMxq0dWTnzDFr8
 bT7OQZubpyx+P/q8AgP4kurAyZyJiOeZ1Eic1SdXd0YLZmQ4kKECI3scWpqEq294IVGf
 tuHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5edMOK0aI2DYaaJNw+7C0YwGuebCXuiTiHKI3eh2yJuGdD72m3ORhO0aOfK/zAsB3+te5WMY8orbT@nongnu.org
X-Gm-Message-State: AFuF++n/3VgxAAZ7zKEI1Ft7GiOnLf1UVdOnf4x8heqyt5O8U64lQe2U
 BI6VXMBpC1su3LEp00sWI/DJwnzhdiKZzW2I5E0h+GA4QiPYZ9NvqBql
X-Gm-Gg: AYBFou2pMZs/HYPWexXLXXjFferJi8Yh+sPePab7G9M0cE6ZqwYMFRhudi2ucyGmNrU
 3xSJVSY+0vR9Btgczv/a+JZ2WAydYO9abTryHPmex5fUhY+dDe8a3xwy7MOyDIkPHabjdh9z1mP
 u7+pKJ2PK+ZgKJHylX0+lUsdZqqUhuP1WgW/UXHEoZdVzVTrwdGh9dexa0sjMnl6JNbrkGQe3LF
 RN+XZ62wCCjvWqRkUo+AMbYoNXLrcKfFM6XWInX39LZ7umX/tAk9d8xU2IIfKs9dAjFUcyOZl+e
 oYwaijdowlpg+8Cn7RIF1wpSDeXJJhED6aBah+UhpjrjFUSEVSJ73qXFCdFmy4VFH3BL74l7lZi
 U19hUiXT1opb9SjlT0qaHUHJeNyIHvhpk8q+AukzZ779FftlydIogSiCUKPcmnIpVpphhGXfvu0
 FqoY8W1DbEE+nO0KmmI3w1TsvG5N9CBqtb+pGO2D6/2nlAVM2hc/pehyWn5xCJzskrT7zEiMtPy
 G5BoTzxrIEshRjwtR1ljx7l
X-Received: by 2002:a17:907:971e:b0:c25:fdbc:52df with SMTP id
 a640c23a62f3a-c2a15699d4cmr457733866b.10.1789835853154; 
 Sat, 19 Sep 2026 09:37:33 -0700 (PDT)
Received: from tulp (84-25-144-101.cable.dynamic.v4.ziggo.nl. [84.25.144.101])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a35239716sm101318066b.3.2026.09.19.09.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:37:32 -0700 (PDT)
Date: Sat, 19 Sep 2026 18:36:21 +0200
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: Brad Smith <brad@comstyle.com>
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] qga: implement 'guest-get-fsinfo' for NetBSD and OpenBSD
Message-ID: <aq66Bd-9wa3N5Zn8@tulp>
References: <aq2m9yuSGK0m2zRb@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq2m9yuSGK0m2zRb@humpty.home.comstyle.com>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:34::f;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  Brad Smith wrote:

> qga: implement 'guest-get-fsinfo' for NetBSD and OpenBSD
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>  qga/commands-bsd.c    | 19 +++++++++++++------
>  qga/commands-common.h | 12 +++++++-----
>  qga/commands-posix.c  |  4 ++--
>  qga/qapi-schema.json  | 12 ++++++------
>  4 files changed, 28 insertions(+), 19 deletions(-)

Look reasonable and does not introduce regressions to the FreeBSD
implementation, so:

Reviewed-by: Roman Bogorodskiy <bogorodskiy@gmail.com>

