Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1377C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFAGH-0004df-Pp; Thu, 06 Jun 2024 06:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFAG8-0004d9-Jh
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:22:16 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFAG6-0007j0-NN
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:22:16 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57a68b0a229so811888a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 03:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717669333; x=1718274133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GhGzkhBwYegKqiYl+X72GQkTdLUuCzB8Q+fHQwcToP0=;
 b=CZK1dj4mCJA7DUKwSF+vFhsBZJj7wQPl1mdGDZSEagO0HbJiCrFgo4B8HCOEI4HBBG
 NcVU1gjCQlUGT+Ot/FOWxfXdbD0JA8Fvgpp7L9dOXggsCrdPN7NgLI9BW9eQjf/4uY9R
 EbxAYNa96eG2bFFd8WRceXcC3uIac9Iyf7sFFSGKeNzf1rW9Dus8rOgtdOlEbEOYO48d
 +0x8FBcUbnh8+Jy1DlHM3ecHnGeRH8R8Md0wrVoVJP7xke1AG9KhaOzt0PZ6E6Hy4/0Y
 1T76KhcbqwJl1y7mu3+m1ttsuPUr1Xa8ebSRmSdNmON8GyqHdQ85SW5nCP3zrW2BMEaw
 pg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717669333; x=1718274133;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GhGzkhBwYegKqiYl+X72GQkTdLUuCzB8Q+fHQwcToP0=;
 b=XpvDuw0g/OQDtQN6OWQBiCwk7Y+oQcW7OSQqNiu93VvT8zuHCBjzDDz6tym+Q3Uxmh
 UdrcexKylalocHlZgXL0aw1QXGUH6tp36Ke0o/fhTeQtzCelxcwLT7mGIhYBNCUbF4Me
 o6+BqNeJSN8Isk98uKIrOe5sZazFDa9/FfuxcHyw8Aov51j8jRlGNoPIpnw+KI9yxzd/
 3Z0Q1C9q9gFe+s/bLmkr7/758cf5aesnHOsrBfS9UMBZCV1JFBlqE2Dm6e5fgkUtuRP4
 OVr35v9snmm5LiiM0Pc6grZvD1te7m/Rrl/ZBvMygtHWpCWCqoqQvkaCc+6c++l4e1oc
 aBqw==
X-Gm-Message-State: AOJu0YxJtt9L5db31Gjtm4fOuaqb0vm5j2/95VehM6EuTBXPYwYnkAqB
 +bcUxKDbpJDE1rJov08ZgkDk+MfPKuGpuoxq7Lgv0wnv/oeOIH8LnW8NuYvDMcw=
X-Google-Smtp-Source: AGHT+IFdbcj6SkYk5BSHtYFjV+ipl0uNgJyYoJyKJk4BlNbLSNqTzlnrpAFnczayp8xKzYNYfGDzNQ==
X-Received: by 2002:a50:d5d3:0:b0:57a:7885:433d with SMTP id
 4fb4d7f45d1cf-57a8bcb617emr3084272a12.38.1717669332708; 
 Thu, 06 Jun 2024 03:22:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aadfa3c47sm853574a12.16.2024.06.06.03.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 03:22:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D914F5F7AD;
 Thu,  6 Jun 2024 11:22:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH v2 4/9] plugins: Introduce TCGCPUOps callbacks for
 mid-tb register reads
In-Reply-To: <87y17il7w8.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Thu, 06 Jun 2024 10:47:51 +0100")
References: <20240606032926.83599-1-richard.henderson@linaro.org>
 <20240606032926.83599-5-richard.henderson@linaro.org>
 <87y17il7w8.fsf@draig.linaro.org>
Date: Thu, 06 Jun 2024 11:22:11 +0100
Message-ID: <87msnyl6b0.fsf@draig.linaro.org>
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> Certain target registers are not updated continuously within
>> the translation block.  For normal exception handling we use
>> unwind info to re-generate the correct value when required.
>> Leverage that same info for reading those registers for plugins.
>>
>> All targets will need updating for these new callbacks.
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I'll note there is a minor merge conflict coming against:

  plugins: Ensure register handles are not NULL

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

