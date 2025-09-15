Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758DACAC58E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy67A-0007SN-N1; Mon, 15 Sep 2025 06:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy679-0007S6-1Q
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:07:15 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy66y-00062r-H8
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:07:14 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45f2c4c3853so3938285e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 03:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757930811; x=1758535611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t7Cej6W9Z+heWxnF9n4qOiGD66PtXt1v/jqyKpsxBpY=;
 b=G2Ww/qX61hg/0U7SidYoepA9VyCh0Cy8jViNcOb5rQl7ndL6Gr1Y15Cjj/G4IG/Pzc
 88+OAYeOKQlXjwqoS9K8OETnpvFt7Wx24QAA70wnnM8guTYvz0cSFkqDxYp3sJgFdS+r
 pSxCriIMlauKEj5H0NPMP4s9WUW3HylnO2MAm/ZO1III0mEU0kmnKJ8MtiHWfTSM079r
 eeMONwMTzVT+2E3xV0M5BWXTkdbKhw8eE6Bzg2qfebPnbvIp4wZW0iPDBilReaZRndOy
 clugZbADOFnWoyXvhe8+H+AFFJMceIQgtEeo+gErdZHe+KTrDaEzXEnnzRzjYIY0b4Os
 mkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757930811; x=1758535611;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t7Cej6W9Z+heWxnF9n4qOiGD66PtXt1v/jqyKpsxBpY=;
 b=FoeTbhNSgtvJLAWu6pBBDrOJztn4S3Fl288lw4RPO95dw79GumAdCKL7x82cyp45qC
 QSfpg7kh+BHsUqp1g3kF/UoLxZpUXoFbutNFdffR6mMyxmZDZoYKH7qDnxkT7djQRvTl
 WeOu2TA9Y3BNVtXNruHLT0qufKM3izA8o0vpkw44Cm7dxiRztKAUcxHxgpgtzzD6JCZz
 2g8tZoiGO9KUStS4lbh+B2t8TpxcGr2HBya0PaA9ZA2UPb6cEJ9RzTe3zYTcEU8xKe/6
 /C6S9nCUmWPJ2k+WaigQqQfSVmbgUIsiufDCpC1ZhK9ikuUF6DxeZa7SZdW9dbVAlqUJ
 JT6g==
X-Gm-Message-State: AOJu0Ywoq/5WZdz/USqU2b7zt+PFwLRg4auhwxXdf2GqyKCIcaACWGt8
 QOEjnj8WaZVvwLUhlSXrbrVDTX1sp+o2MyMcqV+bFODBp6Yg4og8nfjSM42yk22xC0ZnXQbEwEL
 diKDDkOk=
X-Gm-Gg: ASbGncuREH/8Hq/V5v+nqH6c9Jjvp83PUT9YfOlrhHAMv/JWDzT8dParbCVm/kZMa4E
 mmM0m22NvD0PoWjSjUlJi8AZRCU5msP6aicPffRO4fA+vdJEXlTC32nZMTH/98n1MhVaBfG2i04
 /EX8AAYUYzDfDikucXlTQpIngT6YZrp5FvBq8eWUgikfgRsw6abToaBnwAo4QduapBnxM3fdf7g
 Fa6bEtByc/YKz8Jz5uNB+HfYFZfaGnlvVQoKjbIDl0ZyFoxUta7fStxq5qVS+VFMbGt2ZnPPcs8
 M9tAWSXRNTxNOJ21KThQ3HekZEsAIIItOgi9CKhvqI+UdeDF8xHEXTu6tvVGeBVGffTcUQtaN93
 c9ScaBn+FTWt3mDcFxErabuA05oDYuCfSKg==
X-Google-Smtp-Source: AGHT+IHUJF+VoEvtB2q/RoUqOFnj+VExusJGirA+izpNv0lujdO+L0bUAD+TQeil5NHrxTQzsR/WEQ==
X-Received: by 2002:a05:600c:4ed2:b0:45b:8ac2:975e with SMTP id
 5b1f17b1804b1-45f2c410b69mr34903565e9.26.1757930811185; 
 Mon, 15 Sep 2025 03:06:51 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e037d638dsm166153555e9.22.2025.09.15.03.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 03:06:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 04B105F867;
 Mon, 15 Sep 2025 11:06:50 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/6] tests/functional: convert reverse debug test to
 local gdb module
In-Reply-To: <20250912182200.643909-3-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 12 Sep 2025 19:21:56
 +0100")
References: <20250912182200.643909-1-berrange@redhat.com>
 <20250912182200.643909-3-berrange@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 11:06:50 +0100
Message-ID: <87jz20rpvp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> This replaces the use of Avocado for the GDBRemote class with
> our in-tree copy.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

