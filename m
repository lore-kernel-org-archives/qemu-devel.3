Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CAEC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 12:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uevJO-0006Yd-RX; Thu, 24 Jul 2025 08:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uevJM-0006S5-Il
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:44:36 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uevJJ-0001fU-BG
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 08:44:35 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-61360453fa3so1549633a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753361071; x=1753965871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oh8F1uoq45L7Y5IJ+NaXq/HzFzW76LP2l9UM4751pi4=;
 b=yKBZJAxq5DNyqA1rw3fsKZFJ8RLPGk/R++A0wR7ge3PjoGQTV49zMywVcMX9yhua8B
 qLXzykkhxxcA4uU0icm7Rw/QqphX+iVkXmHRv69GLrGZBEjWX1bQ445jyy9an5nemaIi
 PCLVXaqZRkw6ZbIBhiGOVZy9gTUzApLu0mtMgCdwxtE20KPMUqTxI/uZFyzxPq04uzOT
 WNs/XJ3phUTmrMGDzROS5KqiORgbHMh9DYyn+kE4JCc6DwrH7ZzhsfyNcmmut1jekwld
 Qy67V9NGhzMdLUY0uYWKjYGjkngSoHTV6NUm4gKN/sjwP9zSLad4S8gCJNwFvG5XZbpO
 +a/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753361071; x=1753965871;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oh8F1uoq45L7Y5IJ+NaXq/HzFzW76LP2l9UM4751pi4=;
 b=HkbUNb3PYXjrf291Fayrwx5P/JQtx8R4YzX74v19wETazlzYKEngixKY/Dpi9t3XuY
 b9jnyeE+4+iDk81HkP7TXd1jmhwlYYFm998qEV07avlNnkepKxqH32LK4RdiL0UBv9/b
 t1G6TtxDCGHdYUPZtEZ1qNdKoDYfUTm2pmPzJMtSQrcs0Nuk1MwzzNND3RgjiNYfd860
 EPqwp+D0utHwblnCeDCY0XTJQs+Z+SLGpwGfnF0JTK01ywDlWLXXPovL9V7uqVFaQ91C
 RYGJQdEUt1uKD9GXkHvAwzhe6V2drY02EuTugBWu0NndO+oYXZAjOli9hqjLFNfp+MJs
 LNAA==
X-Gm-Message-State: AOJu0YxO1Z6o4zlIwULwI9yMNxLW7Bc+xDgcnEn5qj4g1czAGnlBYjEG
 9gVRmUBvXPYCzEx3z0C1oYlkbawWHkDYa5vlAPVRtdd2p+Rh4xG2K1xk/2KLvUm5tA8=
X-Gm-Gg: ASbGncsl0UyhXbglMYu4+tVooHqxC/8mPTPPhUQ+yykkHtoWOWD1HCRucIvwzRGkgIE
 oadxGYJ8Iwg6EADLyhySHRRs3F2kNRbbL1z19tvHJhhUnYFFDr7xCGHvSw2qLiJ+vul7J6+rcim
 wRRtPHWkHmn1LPLc1p17vydxQV95rW4g8osMRBaWUq3YxjprlbRnHhZCnBByN4qSuiI+jDeJ7nA
 pyitgqN4fUPxtusJomDZMJs0UkIix+UWcRiw6rDWOh9ATjTFgpH+MhRr6hYEGND0VXaZRpOfa7i
 ZLfDUPvY1lfp/h6rPnSEcTzZAlvodk1Y/CPaeiuIPxc0hylaGTihkQ1q4WLxQofbijC0pkmoQt/
 2ALUF4/4lz8J3vjhdj8W6Mok=
X-Google-Smtp-Source: AGHT+IGyvFGKYQsSBxzehFryXmFsGzC37R3Hmc18y7SEsk87icNADMuHnqbj1Dq79qMUrXOC/blGjw==
X-Received: by 2002:a17:907:3ea6:b0:ae0:be38:64bf with SMTP id
 a640c23a62f3a-af2f9178962mr686240766b.58.1753361070502; 
 Thu, 24 Jul 2025 05:44:30 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47ff3f5e4sm107543466b.126.2025.07.24.05.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 05:44:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C2E3B5F7B0;
 Thu, 24 Jul 2025 13:44:28 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Hanna Reitz <hreitz@redhat.com>,  Jagannathan
 Raman <jag.raman@oracle.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,  Thomas Huth
 <thuth@redhat.com>,  Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org,  John Snow <jsnow@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 03/14] python: drop 'is_closing' back compat helper
In-Reply-To: <20250715143023.1851000-4-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 15 Jul 2025 15:30:12
 +0100")
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-4-berrange@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Thu, 24 Jul 2025 13:44:28 +0100
Message-ID: <87zfctu5ar.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Our minimum python is now 3.9, so back compat with python
> 3.6 is no longer required.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

