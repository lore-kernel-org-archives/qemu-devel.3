Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BF4C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTsV-0005eg-SX; Fri, 06 Jun 2025 06:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNTsQ-0005eD-Jb
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:00:43 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNTsL-0006aW-7h
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:00:40 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ad1d1f57a01so349659566b.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 03:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749204034; x=1749808834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkSdhljgGoiVECxS1odw/ksMcF+lXFdlvfkxTMlwjkg=;
 b=XflmqUDYLyJ8khuQx6BYoc9dismEivepGkDrsSY3TzHsKDwgi8RrzNWFq+GMHIXVcq
 3gBUHhsiL/3puf3+H0JXC8ecvOU3W6HQlVQ2sIMAVaPe76aWyfNpLuPqREhKLQ0Mdl8p
 0mkzks+Wam/e+b4l/uyJGMVN+neZ4V3GLMx+59A/1Q/152IE6y8Nqc8PFJgFVq0uuFu+
 bFyqZEEhm3fJChJPdqJ/JK1PpU/s7ITvr9k+qHAmDH/oapgTm0wZO/AhjNqvFO8+eGmy
 OT5pFitFMQlZdA+j7l/lQhg15+LKsaG+O5f7mVLJH4EJBix0MzZzJeGe5JFK8tEIx6nZ
 r0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749204034; x=1749808834;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XkSdhljgGoiVECxS1odw/ksMcF+lXFdlvfkxTMlwjkg=;
 b=EoAscygFEm8tnOjIoFwHGcLkOrGxVhd4sKqZ6SmhKYuFsr2b4IL8orkd+L24S8PFKN
 jDu1qHFR8cnZAFXfYW16d0p0zYpcOSAf8dSS88sz6eRPOXmSKc4osdStXBFPBz3lMAGm
 AFHGcQw7O6C60rOnNL3hshTnpEXT5YgwaateezGkaRBBRNBFY/U5LF/59ut54anZ0Jad
 JQNTY6R6JOWEfrB9+34SVBYyFsoCxm4bUP1q1o+2jS5epJAgzCbly9mV+vGMV9xQNzCv
 lEyo2BYFpDh68lcTYQ/U+6bWDK8ieIp061maAbgxt6/WOKQ7XSF1bUXkW15L+9t+yn2n
 zX+w==
X-Gm-Message-State: AOJu0Yx6eNJBNL3Eyc6IN9pWS2OKxsXfRLWoFQK2fNppC1kIjgKfgicI
 nI7Y+e3PmWPEahrKtY7dHs4iQ+dMwlZt7MkFYNAUJr3lrf0JKwQeJ00ypxIVXFGKC8k=
X-Gm-Gg: ASbGncufWFdroQ4cqkOnXw4DlemKZhNwBCy75u7dXlKUQv98/GW5ZQp6s5pMe/+P3ZA
 axRGuitGth/4RKSzE1zNLFX67zsN4QhbBMUeIAo417lU56PB1JiCSSEAyp/JiTMlz6QawHSw9Br
 nO6hqdIVpvzpXz4k53VadkycxD57jYD+W+2osB1F4jTPyJ64Fy2buKEfslLxx3CYueEq27lYk6r
 tFkb1A8xBr36xCK5U7/nS5j8Sx5I/KbyultGAslZV9d0AkWsB1PTc0fyW1ZIhYlRnXmcBErBoe1
 pxX53EtRex3NpFCJnOBYxo2F4EluXEPakUiRZnsDv2hwfr6M5dioPtb6KwC6iAg=
X-Google-Smtp-Source: AGHT+IEehVjMywej87NeqIMWG3vZbzr7SVBs2Im0Xsn+lKAiIigMPGo3lUSFKp5znD7faQtipVdinA==
X-Received: by 2002:a17:907:1b11:b0:ad5:7bc4:84be with SMTP id
 a640c23a62f3a-ade1ab5edfcmr224203666b.52.1749204033951; 
 Fri, 06 Jun 2025 03:00:33 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1d754653sm92006966b.20.2025.06.06.03.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 03:00:33 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9CAE35F7E1;
 Fri, 06 Jun 2025 11:00:32 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v3 0/2] semihosting/uaccess: Compile once
In-Reply-To: <15c88fe2-ce7a-47ff-a20b-14ceee1e9d6b@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 3 Jun 2025 13:17:16
 +0200")
References: <20250526095213.14113-1-philmd@linaro.org>
 <15c88fe2-ce7a-47ff-a20b-14ceee1e9d6b@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 06 Jun 2025 11:00:32 +0100
Message-ID: <87zfel42bj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> ping?

Queued to semihosting/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

