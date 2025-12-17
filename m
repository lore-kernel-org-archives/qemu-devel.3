Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1677DD66B81
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 18:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVvwS-0007fV-Ii; Wed, 17 Dec 2025 13:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vVvwP-0007ek-Ph
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:08:01 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vVvwO-0001M7-7m
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:08:01 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so40961975e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 10:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765994878; x=1766599678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aadshIW0PlgRVnPU7Eie2ul+wCylfqQfywPzFg6Rotg=;
 b=YIhA+DwtlNIjLWGjk5lmIY1ZrS8BnXqyQwEW2ZgRqwF/1Ha3Yjp7SNBuqhnFMEd19J
 2UHEkp5KSX+2qQeKwHkGMMY4DEw9bkFQon+W9qU2OoAukkYq9VJhZqIsABZDjaJuXOeT
 dfurYjLJzgfqhGqB2tA/88yK1r6AhAodbhiCDthfd3PLcN81o4TTcPJ7od4iDORO7RT7
 p77a0U9m2Pd3U1MGMGtOZzLl/r9ZpHdlmknpdpIKZ4U4qyD5YF/tShWIVz09pTJBWkp6
 AF1xCZjSNfaNBTZITtGN91bKBAVnWY4Tztg8CdkhRzxtmdUUM8aiB5rk3MdtPvQvPRjp
 w9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765994878; x=1766599678;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aadshIW0PlgRVnPU7Eie2ul+wCylfqQfywPzFg6Rotg=;
 b=M2b+TmfiK8lF0jO0UBfvz3HCdIdXh6eWGbXR+kjmAmaBnGml4oB304kSCm5njyI8SR
 mZFdcfdb2+X4CH7Gg7vWokjK+DXPjjtPjqQuFK8568q1ISHdbyqPP7bVpf2YxKpxPZqC
 GBy+hlHr7/FhEiXhjQDXbADEAFLsyUglClKjMtnf8W5gM3iI/3xNtLKV4ar44ra0/IRa
 QPPST3aEQquTsq9StuQ00xA/QPFMS1v4D+iPa2JMXwREiIpNnY4o8BxsFYmRZTFXaE0l
 zOhJJKBGAtrEyfU0a+uyhAsQR6iq8kUGmn8Zi2hCjgANYPOYJtD29D1N4r5GVa3vBrM8
 fsyg==
X-Gm-Message-State: AOJu0Yy1yDRbXrObWDTgzkobRvu3WvFHlkLw+Das5cKdbbL6vx4JlVN5
 /G2k4C6bUbWlcjslBnz7rZy8ZdDIgLMXWVlC+96EvMbcOfrIVMrlZgJHY/q1XH/0lgc=
X-Gm-Gg: AY/fxX67IXoJ6OtoGoQqzgCEho086FBeI7+/qhmk2Ut3Z+HtBSCEEfRzLqC7HThmDys
 QuAArk/WCbEseYY8jXffdhqiPqMIgUAzZbiv0MOah54gyAOQTb7d1dlJZPYm50ww5NqVmWYnntZ
 S3EZaBH4DcMOtn9MOa0YI0299ajebwdC/rt36iTOw4Iu6ZJSef6O8hnldZtisw9apsv07qPa6yx
 N/Y1tFWnvn0GjIdDLW6Gwe/QiVWnBxd9vVTy2m2dsBG00wbYcDEr0YFif92vhwXzBS2b/IkBkuX
 TgsFBut88ocG0rQFMqrCkdCCnaDU16PKpWZPH4zYSS7AfwGJMxhthBtNGCjGamqn1Cv2Z9yN2qq
 VkPYvgiU+Thr7zewBZ3tOgC6t2+R9CZ68ZB2Ufp7eY4OojgpIv3udL/UstXKsWLIPalx+qEwkLy
 L77rBsf/vrQFs=
X-Google-Smtp-Source: AGHT+IF02QQ9hMIVvcyQBd6XAA6nki9+OKz13UmD8ySTH+5y5OUkhZHD/svqboUKDvhofO0idijB8Q==
X-Received: by 2002:a05:600c:8b71:b0:479:35e7:a0e3 with SMTP id
 5b1f17b1804b1-47a8f90dc36mr191808775e9.30.1765994878368; 
 Wed, 17 Dec 2025 10:07:58 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bd8eb5702sm37468445e9.0.2025.12.17.10.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 10:07:56 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C212C5F828;
 Wed, 17 Dec 2025 18:07:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ziyang Zhang <functioner@sjtu.edu.cn>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,  Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Zhengwei Qi <qizhwei@sjtu.edu.cn>,  Yun
 Wang <yunwang94@sjtu.edu.cn>,  Mingyuan Xia <xiamy@ultrarisc.com>,
 Kailiang Xu <xukl2019@sjtu.edu.cn>
Subject: Re: [PATCH v4 0/2] linux-user: introduce syscall-filter plugin API
In-Reply-To: <20251214144620.179282-1-functioner@sjtu.edu.cn> (Ziyang Zhang's
 message of "Sun, 14 Dec 2025 22:46:18 +0800")
References: <20251214144620.179282-1-functioner@sjtu.edu.cn>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Wed, 17 Dec 2025 18:07:55 +0000
Message-ID: <87wm2l0yo4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Ziyang Zhang <functioner@sjtu.edu.cn> writes:

> We choose a smaller magic syscall number to avoid the illegal instruction
> exception [1] on qemu-arm.

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

