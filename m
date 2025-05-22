Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE685C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI82z-00068A-9J; Thu, 22 May 2025 11:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uI82v-00061b-M5
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:41:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uI82t-0003F0-FR
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:41:25 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-442f4a3a4d6so110935e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747928480; x=1748533280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwExYfA2GP2Urz7P2OZ5xK+zCyBA34VHT+vqTc6AJSg=;
 b=srrUm+TcPzuSmix4YFsW+u9CEs2YtPJfbFqzT9rEsaEZmIVhHuHifFpHpUZK6qrcPR
 ajq7hClqdBQf8jDUl+/1GSXGHBT4ZaO+4o+vOGyOsJdVVRQ86wHMlrWm4s/XbPBzGp2K
 0Ci2XXzUqMYk/IEyaYvrpIwdBGC1bgce+73mG/XWZDNbuOTB8cH8PRwE+5IrJ5xZfuci
 Q7JQS/fnMrAmP7zXHz6aPutlVH/EuUY2rjnwYB/L9gnHAU1XowLnEnRTs9DmRymVzy9K
 DBm6wRX3DATRICIjwn//DCDHi7A9ydv4SL9cKenD+lqG2KAMWOa5RkHOO2a8upD+Ds8o
 hBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747928480; x=1748533280;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vwExYfA2GP2Urz7P2OZ5xK+zCyBA34VHT+vqTc6AJSg=;
 b=gI8lAzc/xiD2HzovKa7nTc0+X/7hwBPbz5Xcrar1yi02L82GTHK63diid4wmL+nhO/
 7ArUz/vr8O/jMLncbh6k71EZJaaTETJjSwNw7jb6zGi//O1LQS2vnqFedUAVYmcstb24
 rsoa12vcU6TMMONPeCJf8xFfwI1gmWrJmm/qYjsHBLcUAXmnx2XiCnFrLTNyMXCjqG8s
 NMNHST9QFv7wRS1E+yAATgwhVYl9GARYIyMNnuMr329jD/xW/0vjU4fvFtOk1Lr7kKeV
 80X4yu5vg+2RifyYzsesLkJoeHoNRVMKdvvVqUcVbcBAG2yfIgyxwoL3RS2dGbWnTBr+
 2N4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFC6QO0eP9PxDMi3dUaUx1GVTp/5u0rBfGpKnnEBj3FdZmD2h8He2DZN+KN13rIyDIYh/WDtMBgZa9@nongnu.org
X-Gm-Message-State: AOJu0Yz54Z4vWEpGKLW2mpMbGEa62RLFVuk/d7K24vfoq/hOTXiLJwUL
 s1gb1W8RJm1+m8oi7UdaZsOz1yDmD41oLM7MP+jqe/xK6RY4aMCbT8ODt31kc1Md+JQ=
X-Gm-Gg: ASbGncutOyjrA05g2k46I0IxXgB7F9znLfUrxQZeZv21sl6OEdOOdMfnBZvOCWeUTz7
 h82pWVMJd6Uqhbp1N5NEpIQ72S0oON5EwaDlfNJ+dWaJ3kvrlvfxKu9v+GL/KHoqG9uUOQgiBcU
 sNQbDX4ECaNPvpdhm1YDO6sRojqQav7u1GxdlXqMoJ6NrLbk7XGTpZA2UdXb1j54njJGhkqBdgy
 4rfKUv3e3eavO3rlQVdsVp8JQzn2pcgMydtce/zpyQVkWoUO27quAfeZboxDlETrj00y62CKyfK
 Pg5cHxgo3NQ71mhOJB9Y0Oo7CfWL7QBctEUt1JViYe+fFb4uEHYL
X-Google-Smtp-Source: AGHT+IH9H1cWkxlTZnzRbXBjwRPsMt++GncBalVmRLfcBHHNY0QdgmJAPdEZLNXb5EmJqm9/+8gTdQ==
X-Received: by 2002:a05:600c:821b:b0:43b:bfa7:c7d with SMTP id
 5b1f17b1804b1-442f84c2008mr276661515e9.2.1747928480255; 
 Thu, 22 May 2025 08:41:20 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a364d2636bsm20974149f8f.99.2025.05.22.08.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 08:41:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 153865F7D1;
 Thu, 22 May 2025 16:41:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] tests/functional/test_mips_malta: Re-enable the check
 for the PCI host bridge
In-Reply-To: <20250522080208.205489-1-thuth@redhat.com> (Thomas Huth's message
 of "Thu, 22 May 2025 10:02:08 +0200")
References: <20250522080208.205489-1-thuth@redhat.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 22 May 2025 16:41:19 +0100
Message-ID: <87y0uovejk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> The problem with the PCI bridge has been fixed in commit e5894fd6f411c1
> ("hw/pci-host/gt64120: Fix endianness handling"), so we can enable the
> corresponding test again.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

