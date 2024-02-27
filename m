Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A494C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 21:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf4f7-0000HZ-L0; Tue, 27 Feb 2024 16:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rf4f5-0000H3-Sc
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 16:06:51 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rf4f4-0002fo-A0
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 16:06:51 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-412aec2505dso7051485e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 13:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709068008; x=1709672808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q9ClAUN8lfwCX3rP+trtdOSmG6qfgj6tt48eU39JBeI=;
 b=Uuxd5Zo5RpVLbUIwHhnn+6ACMXz3Jttmo6R/LT0p+93u3wzFM8X6sB4fb6UuppUhQd
 DIRoQXZS8MizPJGXQ2RrBEztnH+cEe5W7GgYRIOUijUVYnZTmJxQs3bA6OrbmLZIME8p
 g4ApQ3KF5/NQEO9G4FaOgBteprewnIti0MxkVQ/ICZqJnqdGOFv+ry1hQzSoSdsBJA+T
 TIPjntRNGWPefqKj0iMmUKq6fM0zk54ADq5C565Bj12+WdVgJV8nfaBIDfaNnFoXzoA2
 opMFlQYGuAHjtAJcUZnOJyZ/0GLdH+OQWH06tDkSPO/0Y9bGYch0Ttv2HPoi3z4lXlcn
 qFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709068008; x=1709672808;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q9ClAUN8lfwCX3rP+trtdOSmG6qfgj6tt48eU39JBeI=;
 b=P+sgSG36v5L/J3+BYQjdZtiknmol0mtLMh6O6RBx7XzRMfRNcneyY5RXDLzTYQaxte
 huUQteMU7ThJmZV0OznvWbr9XelCE7rSo9o8hkRzV4NTo1BfCZt9ArQ+6gia6OYLTCjO
 FgBUmnJF+Q/jw8OxaLdbHjfsdFqeBQeQ2r8W+lozQzIxI0ZT07G5kMSYsoZe+UATUtur
 rX7QsIJxiGPsRmvj6iEpeV2e8R6FnIX1KIldM7c306hiSuouN874OaiOjMAnFuT1xGki
 lCAKZgP1VlEsgMjZG449yVKi8GtA1tWVW4r30em6JQiJMNW+ZuHGB7GfyHK8gxbDLdvv
 +dYw==
X-Gm-Message-State: AOJu0YxbgZYvGEIJsfa7NGsVfSYu6008Im6Em1esx8UsiDJlw2eqtiwd
 +XMGEE6aSpmBv9a7y1gV9pOGeZ1XjTTswoTZ0oHYzCNk+zywyyCpN0Ev27PZkP7CRIJIEHhTfyz
 k
X-Google-Smtp-Source: AGHT+IGxTNbMe46YrPN0pWXXHRfnwg/C21vVGNz47KR8VfPmTtRe8FE4r8BMh3g6PtYYZS4JUuUJXw==
X-Received: by 2002:a5d:694b:0:b0:33d:1591:c936 with SMTP id
 r11-20020a5d694b000000b0033d1591c936mr6596700wrw.33.1709068007995; 
 Tue, 27 Feb 2024 13:06:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b3-20020a5d4b83000000b0033df1f1dabcsm2598719wrt.90.2024.02.27.13.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 13:06:47 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 579285F754;
 Tue, 27 Feb 2024 21:06:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 08/14] linux-user/elfload: Lock cpu list and mmap during
 elf_core_dump
In-Reply-To: <20240227184833.193836-9-richard.henderson@linaro.org> (Richard
 Henderson's message of "Tue, 27 Feb 2024 08:48:27 -1000")
References: <20240227184833.193836-1-richard.henderson@linaro.org>
 <20240227184833.193836-9-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Tue, 27 Feb 2024 21:06:47 +0000
Message-ID: <87msrlborc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Do not allow changes to the set of cpus and memory regions
> while we are dumping core.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

