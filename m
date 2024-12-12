Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8482FE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 14:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLjsp-0002v6-IX; Thu, 12 Dec 2024 09:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tLjsY-0002uK-UM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:09:28 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tLjsU-0002M3-4h
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 09:09:20 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3d0205bd5so855069a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 06:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734012550; x=1734617350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1DWhVe3qIDN1JPJ29LWZKhrb8imTI0TbHJHSkmU2RU=;
 b=JmxKko9aRKb5ujxdP+MMF2MWWVUR/KW/LYMLVQVbuJTi2Mf23msblAfajevkIRc+f6
 T6DEAi9PjSocrq5Gnj55GIxHSCfpFMRVIcInK8V7yRTezPkdKjVaK+1aBqiVRV18ABAq
 oPIic+LFEebjRoXPNGzuLE+mW8beRC1Djpe3DHnK1gIoDe3WqcYtfbeV1XlU7HQ19yXL
 P2sJOcnCuFZOzM+Rb8IFnOsFzt/BXq54xh+kZ6BYUoeUNtdCCsp3T0xRqfs1k3ph3EyK
 kP7DKKPnlcMGPUjmiiYZzug5F0H1C1Q9WagnPSDh2JtgqAmGbK/aGz41mVev50t07Fsh
 trew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734012550; x=1734617350;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N1DWhVe3qIDN1JPJ29LWZKhrb8imTI0TbHJHSkmU2RU=;
 b=WB6tWdYF+rxA/wtf0PGI904otx75nzEBawpYgjwV6jmHpwRgx9SbpxFxj9LH5c2LoP
 gjQyjlWQhZ2Ml2WnRR0GWfTCqIwBqF0lOlspk6zLt+JIHg1wVkOZX/yDB8rW+kNkGrlp
 V0lMd/ewRv+vXQR2DCNx7U7dmt6TkRY1Qoh2TVkqEjay7xTkVzsgfW5lmzhlyM3v78iY
 BrPog27fW8UzZSDd11N5ci0ZdvvJahylC6w2iCfot0geM9SX8BFSuoWlHvlhoCM7LUk/
 aM5z0AfPW2qUUxhpVWXxzrReXXijWlKD1JeW2SLpstu6dTeYbJai8QWJTy/7A56mfTVv
 dWzQ==
X-Gm-Message-State: AOJu0Yxflc/Pi4AFjA8YaSV/lqCZj/dk9Z4WSij8UcMQyfxRG1LmoNur
 jePgviMLXgiJb6gJz0iR4a3FELHAkfOJuwATFROj/ZcSo9arTrun3ov+YYMJz70=
X-Gm-Gg: ASbGnctkA8pgIYQiHtQGwc/xUuRZHKl9v86HqLgYjUjUcq4fFFluCNtGg8R1NhuIl4S
 bcSsBobhtuURLkr5KVbVjvD8EueD+ObbA0+KuRQ1sLpBhIm7wXOffgU1wRUPzT8lnnyqg8YhmGq
 uKaozePBvEvB1XPIR7NVVh7T3ESA4oOcWIolY2c07mvdsh8XRJyLcw/BDgF81DGRzZO4pUNAKDM
 nlQdkJJl+GQ/HDOQVdmCYZPm8vCER+1ymC+8sKj8hjTGkmmtiRotFg=
X-Google-Smtp-Source: AGHT+IEUV38q83hWjV4GY5BLJs+GXwq/C55F24Prye1jvpEk5P4NXkjKjn9yG0JqqJsAfOAZfw5RAg==
X-Received: by 2002:a17:907:68a9:b0:aa6:59ee:1a19 with SMTP id
 a640c23a62f3a-aa6c1d073b4mr361658866b.60.1734012549608; 
 Thu, 12 Dec 2024 06:09:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa69964872asm485835466b.103.2024.12.12.06.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 06:09:09 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 179955F769;
 Thu, 12 Dec 2024 14:09:08 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] semihosting/uaccess: Briefly document returned values
In-Reply-To: <20241212115413.42109-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 12 Dec 2024 12:54:13
 +0100")
References: <20241212115413.42109-1-philmd@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 12 Dec 2024 14:09:08 +0000
Message-ID: <875xnpro1n.fsf@draig.linaro.org>
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Since it is not obvious the get/put_user*() methods
> can return an error, add brief docstrings about it.
> Also remind to use *unlock_user() when appropriate.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Queued to semihosting/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

