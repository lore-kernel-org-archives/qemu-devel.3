Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB40C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 14:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfgbS-0002gn-Iw; Wed, 05 Feb 2025 09:42:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tfgbR-0002gb-9z
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:42:09 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tfgbP-0005rq-Pm
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 09:42:09 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ab39f84cbf1so1231427266b.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 06:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738766526; x=1739371326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DnZpx+xBJfnYbEfPdWQfL4n/lCjqo+Fj8BMqvH0vgss=;
 b=POBGIrgT+LschW0Ypw1CNbz1yBVi+5Mxsrg29rSf58PTupR3TL/yt3zpHjgc7Nwrzf
 FQKDJ69wkrjpwADJT0X7wunavyWz7emHe2OPHcE7F3E1+X+0vzHBX5cPTOCtfYywlxdQ
 oSr8wjTphbsFKuhfKIrRJsol0TSWmZwZ/XJai5YP7nCtZCMNHc3GVpDdCbGgGK/INIVy
 mR5NNawTmz+83KBeATmgtj1OKfufxSUPZU3mrpZ/z9dnLWSc8NRhebFOqdyGg/QEANCJ
 t2AVt2jbT9kFh18s1ogOqh+PMekaUVDxl8rO2JpST4TLiUn9WAnLshcAwml4YGKHT91i
 o4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738766526; x=1739371326;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DnZpx+xBJfnYbEfPdWQfL4n/lCjqo+Fj8BMqvH0vgss=;
 b=YNBBfWAF7epzMFHTa3cfKRyiwzKBSvYrBRBQS/l+TKOA65JLt7WptQm/hVaz0R7Wjn
 elL90AULXeaZzDoYpwJCDaslYU4N/E+ntFvOeXqcaUP6zhLAjkQNn9+8YZhZ6xyRz5nX
 UL0myn8R+XAK+ORh4ql8O9pnFZ1g3XFzqM7ku20VeXdtjxHny9QvyD9AuSXZfJHHTZll
 sPWpdhC0BYiA8s82HT2kqDKJV9fZO3k+TjoT0ogpsOa0oiIXSVRnO2WU1Ud+FdxK+eYr
 3T0E7mSA3Am8YAsjyC7yu8yen6avBR6FbTxfY4yCRiCnuSs0RwAZgmAJEQt+uj09wYUY
 SYmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwmokbPUMhaczd8SxhMT/dMoXeampUW7f3hDgwoYkSaNZyWFiyptnmwvcRGBDDKQJ5BBEkuUvFXD0q@nongnu.org
X-Gm-Message-State: AOJu0YwkCO4w1O2f/CXsNoXzfXwiMVgeWC5zCieLmcs7gEpDsRdFacs4
 Upu5vgq/G5QakWjDAXUYo5mCDtLQHjLP2TZueYtk8xvMiHImttmT5uto8ySFz/k=
X-Gm-Gg: ASbGncs7kMF8EWSIz5zuYDyM4+Sb75trFvpw6JVm4VNo/hJjGXb9QQEV68kf9TbFvPd
 1JUZWQWI3A+TpXybHneDDcIJ9DaLsYXfQ7h0bedSTmIb3cuEiBkWZeaCcrhOEa4QxMO7wFzc8Ey
 gf3W8Z0376Sa4UwJvD6uERu/MkfpsZse+DBfXHeOXrKuLQUK3dvud9uC9Mm4RpdxEDVoAdpYMwK
 D7eLF9ROuV9AqF7DE/2sAzsicENo+2OrirLXEKfz3WwX+nmkS7asRhfquJ+np4XtbryHeMGSIa0
 Gki000GrPMBWcrkgkw==
X-Google-Smtp-Source: AGHT+IFcFXl2MTySkKlt5jaaplqYtsY1G3DD/sG28mx9MUY8M+7NSV1VeUfhs0qdv8deCzZwJxexwg==
X-Received: by 2002:a17:907:3f9f:b0:aa6:4a5b:b729 with SMTP id
 a640c23a62f3a-ab75e2a98e0mr333551466b.33.1738766525913; 
 Wed, 05 Feb 2025 06:42:05 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e49ff3e4sm1107392666b.110.2025.02.05.06.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 06:42:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9727D5F90B;
 Wed,  5 Feb 2025 14:42:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH 08/14] hw/intc/arm_gicv3_cpuif(): Remove redundant tests
 of is_a64()
In-Reply-To: <20250130182309.717346-9-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 30 Jan 2025 18:23:03 +0000")
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-9-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 05 Feb 2025 14:42:04 +0000
Message-ID: <87msf08ncz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In the gicv3_{irq,fiq,irqfiq}_access() functions, in the
> arm_current_el(env) =3D=3D 3 case we do the following test:
>     if (!is_a64(env) && !arm_is_el3_or_mon(env)) {
>         r =3D CP_ACCESS_TRAP_EL3;
>     }
>
> In this check, the "!is_a64(env)" is redundant, because if
> we are at EL3 and in AArch64 then arm_is_el3_or_mon() will
> return true and we will skip the if() body anyway.
>
> Remove the unnecessary tests.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

