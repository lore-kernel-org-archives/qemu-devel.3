Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95184C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDGr-0007sP-K5; Wed, 26 Aug 2026 09:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzDGm-0007mF-K4
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:02:21 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzDGk-0008Nt-Su
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 09:02:20 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6a173ad7cf4so1539158a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787749337; x=1788354137; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xdIse+755ESEtXAf8FTGrtnACDo5SMWBhg0NlB1V6wU=;
 b=KzwHncMrRZxpbcRLUwbXxxBjvcvPjbC0aHT6GdnxdWqy1V5fqzmkBCaRx0ZB7o46eV
 RM7omz0VLQgvjEYcvhiK2HDFUeEJd1CRyzePWmwRnWHvcUSGNYacKqbo+ICKahpN28oK
 eOx3MMLotGD90WiqBOUWw0zCMMtnxyflk0WOI0cPs5llps9+dNJjZsZkmLAVTCMOIEnV
 CDzybTgDxeGTORp/6AkwkCwadA1I7XqS/scbPMI6E6T5EDy/QtqMXb/3GJyDcxrv5Zv+
 fH7KdSnhpDr0BePqAZk6g4ewCxZnT8SqgZQLpcOD2sH0+79zxCc+/AIaQwwavcuYv8Rs
 g2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787749337; x=1788354137;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xdIse+755ESEtXAf8FTGrtnACDo5SMWBhg0NlB1V6wU=;
 b=OCEGGFmwFaZpEufzYLq2djWwXsrr0UNXzYsvPEqV15+o93EezBx4/SaC3dg3zda3vt
 Fe+gJufKmquUhXzOfyz0s1FEJeW+lQeIJHq3h++cjW1oeAFQT+dmE0fYBFebjBy3useR
 jbwvwCKFpZKeFeiMXdBtjKFgkEJWxn2BQLmZr3brYuTLEyU1ASz2kZJnCL89HRPWcTUy
 3EO2YvQfOfQvFn9S3VppZDK6MfpEYRilAloB90W/lZHkvHbIOrfXXqQ7U/LibNpsK5t9
 6Bq+uREWDLkJKI8wViDX7Bb4pxl0FSxdOGmoEkHpnh+3SsPlxei+2daDxklvhLIi+vCO
 g1bg==
X-Gm-Message-State: AFuF++kkFyA8QzWMKkf62xZSIXie9C/RfiBMcZILl8suGF6LFkNUAW8U
 S5unK5ZFISwDRCvYeji1PIANX6vgPGMvlJ1iMJwfBxAw8w79q2QEkRbgDf6BVBT4R1BeBz7bXc2
 q0d9ZIbI=
X-Gm-Gg: AR+sD12gNK6ZFvrgZRhn1/RkZ1NXL8svtDh3qbih6KaZi/c0QZcO4rLAivOa843tgcf
 8gSF6rWtzFJsHcwDu8/BjZrzEQogwNa4XF80SZMIttTIa1JHH1d84hanOONxesfqsED/LFrZxx8
 +9WEhx1vdnxoqtreNvtvpFPUxtAG1jIwKOejM6nv7a/mAqpkDHx+pd94aRoxlIXpfyd/ycC2o29
 /RZCWNh6gNkCriCgzBMQrSyUQpe0AJhWpdr+dGKqKNNJ5SYOtXZEFrozIHpnBXvYqMCuhGh1hXx
 l0mCTuaDE3tzyRuYJ8UN94iBnRJ/qbV3M3g7q1wzNYfUv9HvTeWoW3ZI1HQgnU6QqTYbsbhd7G3
 jql0vXTJFZm0bpT/7P5X2NCk7uy2IPu+WQrNEGYUNBziu/BMHbFO+tLZla0Xkv9xHnQE1D9tEER
 pa0ZGFsbe3SP0GXMyaACqhs6Cx2nW5F3XuREK62oUh6DshOFgmWFl6ocLgFoXA
X-Received: by 2002:a17:907:1b23:b0:c16:4df6:176b with SMTP id
 a640c23a62f3a-c250c6751bamr664718866b.20.1787749290006; 
 Wed, 26 Aug 2026 06:01:30 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25271e4cbcsm291581666b.18.2026.08.26.06.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:01:28 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 759265F81E;
 Wed, 26 Aug 2026 14:01:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Helge
 Deller <deller@gmx.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Aniket
 Sahu <asahu1x@linux.ibm.com>
Subject: Re: [PATCH v7 042/104] tests/tcg/aarch64: system tests
In-Reply-To: <20260818192309.22169-43-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 18 Aug 2026 19:22:06 +0000")
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-43-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Wed, 26 Aug 2026 14:01:27 +0100
Message-ID: <87zey9nihk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

