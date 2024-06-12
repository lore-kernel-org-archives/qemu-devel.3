Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E352FC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHQ7u-0001eq-A7; Wed, 12 Jun 2024 11:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHQ7s-0001e6-Tg
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:43:04 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHQ7r-000626-6h
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:43:04 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52c9034860dso12698e87.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 08:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718206981; x=1718811781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yC/iniut6MADBsLNUbX7E2zAshIKTl1wk4xczH2LqDc=;
 b=N5oEZVFbEoiXlbRwobxGAq1l32rrFlX0apQ5jNb8yDAPWZfTfCglHD9mny0H75Rzv6
 PDDSkCg7qGSIV53UVeDszrxHuCZwzG1xRoEwhsgB2FWH2+1ulLa5bTRhGn3r9aw7gKnr
 wWBWPkSQBIB8gj4xk/X5OZRQaXFd1zQmjnTqv+BdNXqfdY0jkqKZJNzCor5Xg3ll1auC
 MwsDhKXwjO3Xh5g4RcJDrwNCLnAlrXnvBLeKeOFiBAtYEOjhObiIg9MWdEqeMhNyKrmM
 zU8MaPBwrGbgmNY3hVOdzDZ8v1IR/FK+v/yG8rLyfYswAUTxJEpOVQo2QwpMSpbCZ0Dx
 Khzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718206981; x=1718811781;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yC/iniut6MADBsLNUbX7E2zAshIKTl1wk4xczH2LqDc=;
 b=Kp/GGm12ShtYlQowaHohzOg/rTNUsuLqOyd8fDaigLWmd3oCJ00lD3M/wyUtzJ/4eO
 eWrT/p+fEO+1DAg/CFt6Q46IUgTZwe6FlyTqRqZJ9CU1d6xZxMoB5NAONhzjXNsLu9Yi
 XzyVwc9ZeTfX8YeNiryO+GpDV9GRHXygR2KthSzJ6VIkMrli3CysdowhPEGomaLmEzsN
 Ev2MrrGiRxIcnxAiKYtw5IEAQwmSGKE9la/5EAm4m5easSleAYYixuHT7ap19+26fSFI
 IH8Q9+Yd7xz6maL7/EuWBuA8oPaBQkFCCs5PJFZc2I4FUhEAUkgcSrXfbTDsxEBcYdPq
 ik5Q==
X-Gm-Message-State: AOJu0YzePErlWRQnaV7NLq/yH7JjJOtzB0frJXYfDgznI+ovOvUDn+wQ
 Vh6WNGysnU9GS9SR3DyHgfJTZdDMEr9WXJIC4oHzuCRN10j3/4yU972jbkqoY2c=
X-Google-Smtp-Source: AGHT+IGrJjbpEnVjRhA1ReP0WQTTBKW8bcHNneZFY/Fm8KlRX2X7Xk70rAb9DT7bQc31TUPED4wGgw==
X-Received: by 2002:a05:6512:2255:b0:52c:8ed1:21fe with SMTP id
 2adb3069b0e04-52c9a403475mr2301576e87.53.1718206981270; 
 Wed, 12 Jun 2024 08:43:01 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f185078fesm473719766b.16.2024.06.12.08.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 08:43:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 51F9B5F893;
 Wed, 12 Jun 2024 16:43:00 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Anton Johansson via <qemu-devel@nongnu.org>
Cc: Anton Johansson <anjo@rev.ng>,  richard.henderson@linaro.org,
 qemu-stable@nongnu.org,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v3] accel/tcg: Fix typo causing tb->page_addr[1] to not
 be recorded
In-Reply-To: <20240612133031.15298-1-anjo@rev.ng> (Anton Johansson via's
 message of "Wed, 12 Jun 2024 15:30:31 +0200")
References: <20240612133031.15298-1-anjo@rev.ng>
Date: Wed, 12 Jun 2024 16:43:00 +0100
Message-ID: <87zfrqw4jf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x135.google.com
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

Anton Johansson via <qemu-devel@nongnu.org> writes:

> For TBs crossing page boundaries, the 2nd page will never be
> recorded/removed, as the index of the 2nd page is computed from the
> address of the 1st page. This is due to a typo, fix it.
>
> Cc: qemu-stable@nongnu.org
> Fixes: deba78709a ("accel/tcg: Always lock pages before translation")
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

