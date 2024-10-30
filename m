Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0172DD5CC87
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 10:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t65wD-0006zz-W3; Wed, 30 Oct 2024 06:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t65w6-0006ze-7M
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 06:28:23 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t65w4-0006JE-MD
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 06:28:21 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so60069375e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 03:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730284098; x=1730888898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OdGpkY+IZSYBeN9zJJflyw2VSPVt9gvA9o/Gu45fqtc=;
 b=sskv1N6u4MeKO+xilvC99JXRYdUVt1j76DH1REXDVtZdALoLj7vMiOyPgttLLIatJD
 3f8mJS3xBmLy3zBcwyqCMxVMXXC28xv+9IhNnf1mBcU2SS0FLTxkA3PoyNR1mTQ/Bhz/
 VTbwO8zRQyAlZju0NrnwIq1TmChbI8S4L+gmZT4UAAVtU0UuK0Hto3FYZrT/1IXu3A5n
 +POnd5UvV5K4AWyaERKHC4I8w0r6+apDEXbmUzWmILHds8NEvaebVeiAUrhwrOqzmP0X
 R9/hSo0GDYvW62qBtBruJL40PZ3UkovLE0fJB/cCo9KWuNz56PRh7s6rVrjwI1uXzGEv
 YNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730284098; x=1730888898;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OdGpkY+IZSYBeN9zJJflyw2VSPVt9gvA9o/Gu45fqtc=;
 b=YUoFKyzjY+qlbgReo4YQA+y9nZruPVhgtc3VABx603JiO+pnQhdLtc6tWli+JTb9P8
 NrydUSwdyfQhMUETsIF7IV4z6ZhvR29mNpKUcP19H6ZL0Xw8CG9AZxMALFfR5Lbjvqk4
 e31+jE7WFBdC+OxK+sThbufVynFbzEapd5MbgrkY+a3dSmdLYPCpQUkC/3gMjKuitgma
 jH4QKf411rHWbVSS3W8w+yJxdm7hgMiu6Z4eksAW6z6TNBnY/DDGT+OQK6+Ca3A7zo0M
 v8JhhdtVP/l/1HKRVTwAO85JXiWRvO4KO2rTcGlFdk0TdCwZPjh8pX1g9Bjm0UOWiSTC
 o6mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbKlXJgD9L7TYSKgDXv7aFO9wLR6h1wEVCSTRSE+Chy5N7FxoAwGxAk/8yCwuJ4Dpj76wQpbbfOEj1@nongnu.org
X-Gm-Message-State: AOJu0YznRkDjSbU+ckjzIPD/yKZCOpnGoJ5gjhIPrnHFoyLRK8TQPSuE
 48Vj6vpGI4oESvn3VBWQ8BaJ1Vh0oWj3AoJVRVKh82Rh9VfzrshY2rFMeYBHCLQ=
X-Google-Smtp-Source: AGHT+IG3CF7Bz1So+LTGgahIkcxLRJfGaOwgyl3oyWbvoLYskHrQtiufS9+z4OhSPK82P9BGeDy+6A==
X-Received: by 2002:a05:600c:1f82:b0:430:57f2:bae2 with SMTP id
 5b1f17b1804b1-431bb9d14afmr20044305e9.23.1730284098590; 
 Wed, 30 Oct 2024 03:28:18 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd98e6aesm17073495e9.32.2024.10.30.03.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 03:28:17 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 044F95F87D;
 Wed, 30 Oct 2024 10:28:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: peter.maydell@linaro.org,  huth@tuxfamily.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH] next-kbd: convert to use qemu_input_handler_register()
In-Reply-To: <20241030091803.1315752-1-mark.cave-ayland@ilande.co.uk> (Mark
 Cave-Ayland's message of "Wed, 30 Oct 2024 09:18:03 +0000")
References: <20241030091803.1315752-1-mark.cave-ayland@ilande.co.uk>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 30 Oct 2024 10:28:16 +0000
Message-ID: <87cyjhkhq7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> Convert the next-kbd device from the legacy UI qemu_add_kbd_event_handler=
()
> function to use qemu_input_handler_register().

If that is the last user we should probably remove the function as well.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

