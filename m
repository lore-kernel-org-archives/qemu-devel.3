Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9203FE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXex1-0000Bh-MZ; Tue, 14 Jan 2025 06:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXewG-0008GP-PC
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:18:35 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXewD-0002Oq-GK
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:18:28 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso2846331f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736853503; x=1737458303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLUl16iu9ZaWgnMcCLuJzL1lNH5QA/MRjLUjtmH++D8=;
 b=y2vNJPhCf74oxed+lDvr4pVuViaQH+V6tCYwYysKEJCrDS5TK/b+vMDd9F6YevAxu/
 4RFuUDj9blPseQGl9DdlVVY8OO067coA5CKxuqr7Ha1klf04+hvoKPMOIqS88/J05bsT
 wejUsHgBaRCW6tH9Bmb5aDiE4rxoxyTbaUJvxTWBRx+ZlCQD8voIiZb6xS+OfWXlTEfc
 qR7V54xFZt5ZnY2JfO3SSbt0RijaFUcVzTuqA0NFu7agNdDWVL5TYPPBxBGsrS4rx9Ll
 jMHbmZmXVAK+vtErGTPNA0DR6YH6IBx9pAdy/DCE4o0tLOYrikRkqjs1LPM7zbr1enTt
 zxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736853503; x=1737458303;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HLUl16iu9ZaWgnMcCLuJzL1lNH5QA/MRjLUjtmH++D8=;
 b=JCoizEVxiZOk+wcxpahcu+TAYptcfpVgvmq3jFh1ZyUS1C/EU0MDuKsJKa9rCNnggT
 9cePuwQmzYuyGHPCOWyKcyT4z1oPcyKM/RIDvoTD2wAtLv/oiKG6TJpjDVj+Jhd5CHC2
 XPO8VvxLqxAKYtPo6pzwmVvh+bbVK8Y9YPCqYZoPkN/WBr6R11ImkXp6xljSqJw9Zt5s
 OEn1aZKBAp4kUlh/cK1m7a2d4f0+EKssTph0FC9qwJ6PVHXC2szh0lsjOFEM2u3GTjD8
 N8PPZAF3V34u9Fe/1BRIPOvblKoRSV6TerbJCuZvyCScARSZyJxLaTNAyutkGIpdLLZV
 Ak1g==
X-Gm-Message-State: AOJu0Yy8wevenqaZaI63jZ9JV4VxLTX7WzqZ+IjT+1Q3/EowAhhLLBh7
 2dTOOHTMJ87LQXzEJoDLBB2PXicQ7gR4sB0cj4LhFbOHpG9pei+yJjU/R7ydcabE11kps2hmoPe
 IAQ8=
X-Gm-Gg: ASbGncuYRYIeHjr0cuSY3eQ2yJ5Ih1Sihz2UPZFipVwlX3y8IyNGk8c+0fAAhTvNh3e
 WsavWkvk/0CTS0jOWsDHS9nZwT/6B/8nX7zrJ/vHYoZwZDLnsaDuEebBw/5cJZF5pAzXi5sZE1B
 18FfAh1oAnnueVfooElNPJHEseQajm0FgaxGoxhMvDJWzsQUANA4v1VLGeZM1RNLGiy5z6lT3IB
 QxpzQMyEreVdfuexyyCFHD0LmUd9LfFrHA02SQ6Q00/xboLvObGmhk=
X-Google-Smtp-Source: AGHT+IF/LDFzcugoWtB7jn9yQlkh0Srrk9DanrmiVjtRCSyGt9oqOKYK+4Fhgu7/KJG3gJqxRY61Cw==
X-Received: by 2002:a05:6000:184e:b0:385:f560:7911 with SMTP id
 ffacd0b85a97d-38a872c93e3mr21342952f8f.10.1736853503027; 
 Tue, 14 Jan 2025 03:18:23 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3834fbsm14388666f8f.26.2025.01.14.03.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:18:22 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 827235F89C;
 Tue, 14 Jan 2025 11:18:21 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Weil via <qemu-devel@nongnu.org>
Cc: Bin Meng <bin.meng@windriver.com>,  John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,  Stefan Weil <sw@weilnetz.de>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] scripts/nsis.py: Run dependency check for each DLL file
 only once
In-Reply-To: <20250111215244.1680931-1-sw@weilnetz.de> (Stefan Weil via's
 message of "Sat, 11 Jan 2025 22:52:44 +0100")
References: <20250111215244.1680931-1-sw@weilnetz.de>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 14 Jan 2025 11:18:21 +0000
Message-ID: <87ed15k5j6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

Stefan Weil via <qemu-devel@nongnu.org> writes:

> Each DLL should only be checked once for dependencies, but
> several hundred (781 in my test) unneeded checks were done.
>
> Now the script is significantly faster (16 s in my build).
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Queued to maintainer/jan-2025, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

