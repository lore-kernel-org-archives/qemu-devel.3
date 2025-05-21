Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056AFC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 17:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmpb-00008t-1n; Wed, 21 May 2025 13:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmpZ-00008g-Sy
 for qemu-devel@nongnu.org; Wed, 21 May 2025 13:02:13 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmpW-0000Cx-8S
 for qemu-devel@nongnu.org; Wed, 21 May 2025 13:02:13 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-442f4a3a4d6so45801745e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 10:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747846926; x=1748451726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wljp73RKnJculDNVmvqipa+xygRy3W2lnXrNd1zudmc=;
 b=YCB1T7INyZJbhoelp1+R1byOQXpK9uJPV5rlB1HlHlUfyaUa0r1vgSmkVabqEGqRy5
 uuO6kc50C+yTKQHz6E6cz1Z6dle6Hy1rn7cHlmttePjskI7MpV4x3EB+2tNINixtk55T
 qRnEvTGBmTceI1X8v33jRp4zMBYVWgRrhU3u51VYKVjO0uX3wiyjlAtIux5ghsrRrYCK
 eHxoHd+eUUOX85cT5a7VhXh2zUTbVMKJOl8ZYgMm3hYupCGl9DMmp7iUl0VZZzn2Z0DX
 fA9tAIJVVZ1f2R19rMpGrUyudHtA0tC0ndBOvS4hZ0FQANR6ItH5UVPuI7h0UHAauG7F
 1a2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747846926; x=1748451726;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wljp73RKnJculDNVmvqipa+xygRy3W2lnXrNd1zudmc=;
 b=gXEadCKnDAOMj7Cpkuwe/hdfPKNUFdI43nmCLuF5xgoz7UWCyOnxgG+m/gNwEj41HX
 A6JR9Y8+D71SRHz1fd8n7qd5bCcNJOCv+7I4Hi/r4E4qVG4Z1afKF9Wo2spfEcMyGNZR
 Ra//0U4wf71L1a3Pt9DW6+j6di14Hvp+PjFKpjG1Kb6U7PT6ZTg4xZjgOdiFOq+DUAX3
 yCtVCKxnIX/lT7aZBo8bSzINUXaG/FVEfccGwTvCs+Ygi9h90Qn0K00JkrWqRT3S7mPu
 d9yIsdGa7EstS7W1amxbgQEP60wtR0tFoN2GhxjJ3tvyhppMjFEBfVGefTPyVXsPcTmk
 7kzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX46Vlt6LBq7JEcIXUC/iOc10DdxK1Dlx6cTmUZvFm3VIkjr/MsMxRgd9fwLFGbPaKBwtRcTMu+bMz/@nongnu.org
X-Gm-Message-State: AOJu0Yy59yVOQ2HRX9Bpf8CWpR4FvNuLbgoYdKItEvuPzu+FF/+4v8qu
 sL9qCkgw4yKqRsbv5d2JbfLSu2HJvJKvbhVtzjWLipD/1c5YSegGzxSH3oOQkH5zTuM=
X-Gm-Gg: ASbGnctgsDujON4HvTdZTldofKHsf+sD5XmBbZ10p/uiqfCFpWApRL7G+5M03e4mQIO
 2XKG9fGvo5X/+2BTP09LV6Gy22j9E2q5QWrjhlxtpRB/gRWn8vDGE+ZBcpI85Ix8M1HfCChHhed
 t+lFAQZJW0R9NUAtZwQRounYSeCCZcqOW/GKpDURUq2WjbhlfThRymj6E4PibB4/cgyVsdpABZ8
 bSOWXEI/zpzL7di5i6uxwaWG9zXb6bJ0PJmIS4nwLO9Bi4aPDl8+2nGlezim11tmnAZc/xWygUp
 RWmsGcijVbg7eVkuql82HZ1fmRgFpuW1HbEhwjlfAEgQwIoupUYG
X-Google-Smtp-Source: AGHT+IFW7uRJifF0n03oQfFxWfK9RrcpFgsRbo1L3FUb6kuGirAavcznR46wUpi2pAHFpjubmgNVNw==
X-Received: by 2002:a05:600c:a08c:b0:442:f861:3536 with SMTP id
 5b1f17b1804b1-442fd94e353mr192506455e9.7.1747846926173; 
 Wed, 21 May 2025 10:02:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6b29633sm80423155e9.8.2025.05.21.10.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 10:02:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A00FB5F786;
 Wed, 21 May 2025 18:02:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH] tests/functional/test_sparc64_tuxrun: Explicitly set
 the 'sun4u' machine
In-Reply-To: <20250521145112.142222-1-thuth@redhat.com> (Thomas Huth's message
 of "Wed, 21 May 2025 16:51:12 +0200")
References: <20250521145112.142222-1-thuth@redhat.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 21 May 2025 18:02:04 +0100
Message-ID: <87h61d99tf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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
> Use self.set_machine() to set the machine instead of relying on the
> default machine of the binary. This way the test can be skipped in
> case the machine has not been compiled into the QEMU binary.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

