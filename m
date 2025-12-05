Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9AFD33981
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXsH-0008RL-F7; Fri, 05 Dec 2025 10:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRXsB-0008QZ-Cj
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:37:31 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRXs8-0007mM-HB
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:37:29 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so18498945e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764949047; x=1765553847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QOFSSYrqeCFyByq4IbHxO8lBsCbmbRbdoXqmkmbFp/I=;
 b=b8O3SON/mUF8v4g43elvN4B8wxvd6k4b8JX+xSJA8y4TUMK6ey7pnYbLSGMfIdUwJh
 lfbUFnIkcvV/EFdJ8HT1etuFVziGW1s18NbvSPSnt09kpIC+ulNDcIHqEOon5YeSnjKe
 D6DZtGNAYqYwEVoaVQyvi4FPmibOweGbIdbFtH+q3C6ehWGO645SFl1nRxzEppY9YyD9
 bepehWpS5GOGNKTRoztgw0lbiNi0tNQMoYXL6Ppdk6kXCLf+fPmoOy8mWwDoslXKQsgY
 f2kfQ/lwIYRtzsxtqrhFuQu75ZZtyLCkFyMpGaVF/zLVwQtsnyu4B/422HmmlRm1bawW
 rOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764949047; x=1765553847;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QOFSSYrqeCFyByq4IbHxO8lBsCbmbRbdoXqmkmbFp/I=;
 b=O+Qpa53/ekXN5loINqN4SPQNf4fBheAoM4Nmsfz4tjyN5kQ87U6kq0TCtjtsJLTqus
 Aug/mwPIYMqszLXC3xpnG2bAsJiOsFOFneAj/iS1kXswW3fYgXc74UIKptqxifdMG/Zl
 kjW4WekTH3TR0mQyZEpWb9DbtLu5Aw7MmqnAz2Per+25K2wMXRryxJqPhRs0IQEPhPs9
 yA9aKd2W5Nrk2V9N4Hsjz6IroJdC1an/6XElycn8/Q/YRoJgSNtv5s9tMyEWFJuqwguo
 k58lrAXORX/KMXqgtVWREv/0ioDYAJoNyQ720Ai3CNu7+bjFu4dfJE5X6qQZyh8yRIXd
 PKRQ==
X-Gm-Message-State: AOJu0Yy7QYbxIXeAdKtqtzz22goZZ+0K+TYtm265X/s9XqsIemFcfT/G
 9HXMTPPM1kyLYrSILLg0Fz3lQzDCkQzw2UOuK3FOPY6Mljf78DinwCC36vStxp+XjJCfwheRqKA
 eP5wN
X-Gm-Gg: ASbGncsV6kHq2m/xUCru6o5fk0nokBTIvBMDevN5annZp0EBVZRxGXWS37ceQ3DJwuc
 4yhRL41Ifg9a7aSfSXOd29g5JwSSe4JyFaNRvfQ69uElGl/4OqZqHuV5wX3kwnF6cPjgjNNsGEO
 JCmhjKLArEgJSaivt/gvQPeN8IF6340coiLi84c/4sqzb6Z2P9RvYKSp8tEJtu3uDboe9n6jrd4
 27/ZA6Zoi1KovN1cc56YS75TaRJfF72g5SQ5LrI+BPL03DxVe2Czvdq2kovrY6KU0NfHe8HUXGz
 0qqS5HLffP5Gn8biz8bMHMMPECzTFBiarYS9qm5u55pP84LmaNXkwvtMgpHM0XAm+aMjxe2iHhg
 foHcvIabeP6Uv8FSZ5PqCwtOVoL+To7sW12/iLTmAI7mhN8lNR2htY34GEJ7gZAFmf6PyPDlxOF
 vCaVhJEfj8Wxw=
X-Google-Smtp-Source: AGHT+IH2uSVdAaMQRMIq/xwCCuAQkBphuS2YChjt2df3fT9ItD1XRk6JkPEKSLZdlvldl5jdIq9lyw==
X-Received: by 2002:a05:600c:1d15:b0:477:7b16:5f77 with SMTP id
 5b1f17b1804b1-4792aed9d53mr107100715e9.3.1764949046566; 
 Fri, 05 Dec 2025 07:37:26 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4793092c32asm90994845e9.6.2025.12.05.07.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 07:37:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E82E5F7F6;
 Fri, 05 Dec 2025 15:37:25 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Steven Lee <steven_lee@aspeedtech.com>,  Troy
 Lee <leetroy@gmail.com>,  Jamin Lin <jamin_lin@aspeedtech.com>,  Andrew
 Jeffery <andrew@codeconstruct.com.au>,  Joel Stanley <joel@jms.id.au>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Peter
 Delevoryas <peter@pjd.dev>
Subject: Re: [PATCH] aspeed: Deprecate the fby35 machine
In-Reply-To: <20251126102424.927527-1-clg@redhat.com> (=?utf-8?Q?=22C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater"'s
 message of "Wed, 26 Nov 2025 11:24:24 +0100")
References: <20251126102424.927527-1-clg@redhat.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Fri, 05 Dec 2025 15:37:25 +0000
Message-ID: <87ms3xq6ru.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> There are no functional tests for the 'fby35' machine which makes
> harder to determine when something becomes deprecated or unused.
>
> The 'fby35' machine was originally added as an example of a multi-SoC
> system, with the expectation the models would evolve over time in an
> heterogeneous system. This hasn't happened and no public firmware is
> available to boot it. It can be replaced by the 'ast2700fc', another
> multi-SoC machine based on the newer AST2700 SoCs which are excepted
> to receive better support in the future.

Queued to pr/051225-10.2-final-fixes-1, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

