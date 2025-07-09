Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E943C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 10:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZRkh-0003VB-Qn; Wed, 09 Jul 2025 06:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZRkf-0003L9-15; Wed, 09 Jul 2025 06:10:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uZRkb-0002dw-UV; Wed, 09 Jul 2025 06:10:08 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so38818955e9.1; 
 Wed, 09 Jul 2025 03:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752055802; x=1752660602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=475jB6MdlCNPNFuOqNsxLmjn1XeoERrEy/4fED6c5Go=;
 b=cg1caZK4l1M3xZVhMMbtZ7cBXR0Ny+1NnLUvaXvlsuSSPKDCOl7zTMTIGY0Oad4Vkx
 J7L3XrNaLwZs+lFVIp4kMwm2MZOpk5XUHKHc9HkmMI1CF9/7ogbBOrNIEjdsUrUxF+3C
 Cp4GvnsKweR1IPkyWAVb4i2YFCj0TRmVH2o9bcESoSj30fK1tX8BdaQjgxHR1FC+0FB5
 4FyXvuWzDmYn6dvZ4kzJPhtRDsE7zeVP185kutgAZ/BNiAOF9LEiukr4/IijnemXUgsy
 CYM9rptjzsm8e6YkajevcfsVhsQfGPnxFyGRBv60wPIH2bIH/qcaa3s5FAsUNcNPyEhy
 cQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752055802; x=1752660602;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=475jB6MdlCNPNFuOqNsxLmjn1XeoERrEy/4fED6c5Go=;
 b=rA27sPRe7Qtd3086ESG/oiVWqVpDwtM08+rMmXzSdtHnEFS6fNIYw1jEsQWSPU14RJ
 DUetynqbidsBAzOsPMy6buxligho6uvP4T9R+15dqVv1Ev/ZFHI1fzW0CzTMs+341otm
 a2dZg32Gs0BG+uO9ea3FOeYPf5F2ga3hZCDDDCE71pBRoy0fWI/1JfnmGhG14fYIQNwb
 1sWV27+S1BLqh/dSeDDOHkp13NEDFv+8ViNjvuEEsB1iIQb7VBDPIDZIW3iKqYrPxNW2
 Iy9W82t0QY+PNEELOiZ2YP/bxLdq7D0XdcGWWQpCeWh2htPxL7hmrtiLsjwVl79qUzpi
 wa3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6CIT0JVlFLghiqFHAJjhcO9VtwSkBizYYPZPHpROFUoVmBwQWi529Bhr0KFfmkzFSpjMOiNmYV0E=@nongnu.org
X-Gm-Message-State: AOJu0YwKKBtl6uR7srEKxMZ6nV88/TT7FFx1MT2dghyg8GnTeIxMDjc0
 SECiCSHJUNVm2IlhqMq3jFtzV06g8KEBK6QknIgm/m0Zq3kCDQG9kb/v
X-Gm-Gg: ASbGncvKtwOG4wqhjzXoQkRVm2HkYfOX2rd/KdMEP8NhuxVcZEvHBaii1mVnybPc+NI
 kjhs6G5kwdc0w0fG7iz1nIZYG1sMK3rB22EHvGy3vGkpucC1+iGXbdMrxf7AoGoabe6FuPaP/ag
 ty66kwAyGYodqWfA0Kp38QGZGxl1NX74SpF8BOPv/DAo4zauC1OuVAkoh9jmiQG9wirhn+DQJaE
 X/HvIo1XMxIb5+XdM21+MZf4vHF43pZRQD2CyirxxYvfulhYE/VrMpINrl74mThcWWWyK2F8jaf
 Y/CpsprG4KWAAxgGuhesivVmQ6OIOzW1iwYRRsyjrOBpp7cJhIo1rYoqvQ==
X-Google-Smtp-Source: AGHT+IGmMTKrOLkSjjRplwY5VMXYp7WIo9uDU0KNKUOHL+ZFbXbjg/YUfgTxu/zuq9tR64Jsmrcghw==
X-Received: by 2002:a05:600c:1e0d:b0:442:d5dd:5b4b with SMTP id
 5b1f17b1804b1-454d53bc8c5mr18512965e9.31.1752055801901; 
 Wed, 09 Jul 2025 03:10:01 -0700 (PDT)
Received: from [127.0.0.1] ([185.238.219.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5103082sm17677955e9.29.2025.07.09.03.10.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 03:10:01 -0700 (PDT)
Date: Wed, 09 Jul 2025 10:07:57 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
CC: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] rust: Fix compilation with rustc v1.88
In-Reply-To: <CAAjaMXb+eo5uUNV6=RjKqf2mQgNeeYxYbt7oj-j5k3ToU=zEJQ@mail.gmail.com>
References: <20250708204907.2178-1-shentey@gmail.com>
 <CAAjaMXb+eo5uUNV6=RjKqf2mQgNeeYxYbt7oj-j5k3ToU=zEJQ@mail.gmail.com>
Message-ID: <B2503DB0-7984-4C4D-A2CE-2F9D0679691C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 9=2E Juli 2025 06:22:11 UTC schrieb Manos Pitsidianakis <manos=2Epitsid=
ianakis@linaro=2Eorg>:
>Hi Bernhard,
>
>Thanks for your patch!
>
>There was an identical patch last week on the list:
>https://lore=2Ekernel=2Eorg/qemu-rust/20250703-rust_bindings_allow_unnece=
ssary_transmutes-v1-1-692ca210d331@linaro=2Eorg/
>

Oh, I missed it=2E I just added my r-b=2E

Thanks,
Bernhard


