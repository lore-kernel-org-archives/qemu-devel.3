Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1680E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 09:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNqf6-0003rU-JO; Wed, 18 Dec 2024 04:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNqf5-0003rI-78
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 04:48:11 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNqf0-0005AD-CC
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 04:48:10 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9f1c590ecdso1082053366b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 01:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734515284; x=1735120084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BumaceuE9S6jgIcPf8KbDW6sSqY3vpe9MBM3CVi+E9w=;
 b=ksH7YudAZyrt2MFCYKnqqLmbcnfjEjmma/eykS6JNDSlwTo+LQKhZfcvmLN8x8VM4p
 htmRzyp7TQTuKJkAcAeAZL/Xe1AC812T90Pxt4dBMgsivw33SKD+98WPqcMaLE+vdMC1
 fP/mNyKtKTWKR1pHO/NH5FR6dXbaZID1BFTqe+JVyS1rk5NbSs80Kq2A/jpnK0dEoUxR
 ZjB6rH55GiStdqk1XfSzpwu78dZ/gJbmFDHavi7HOVjxQhzWENmqffUm+31/s1K/FwhM
 NbISJT7Q5/ojaO8SZEt3UBxAuECza655uscXiMA6kSlvncZvJG4UHoqfltaSRqD6NzKa
 topA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734515284; x=1735120084;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BumaceuE9S6jgIcPf8KbDW6sSqY3vpe9MBM3CVi+E9w=;
 b=t42pHP1HPZ7RfSlmUCxewY/Ff9pql8t5whjmjDUeYCQtgwCl3W29UyZi6Tn1DlTepO
 TSEM1s/sPUpA+h70f7FK0F2Ws44WZMMp33ODUw08seXSSLpEkgiOoSryvZnGV8JRuyaU
 QFZF9l0laBpADHkeu9jcCs46SJdRokzPlMxeefK98358QGjjwNqmHH7QNLWH+Mgqeo4p
 3WTdFZ8Ivk/1BmPUt1+VYjFTh68lPmysBLGiWdf/BxvS3gGlc8fDAtVjtbdn/4hhz9Ci
 fds3LCEpiME0q9x1dUEIgFEdKvQqzNUu24rgp9V/5UZD7ZclzgsACjKei5IgKwjZd7sG
 aLXw==
X-Gm-Message-State: AOJu0YyMs+7dPVhEJYD3oO//anrhebSZs7F8ZBBoOL6gZUPMBI7Vw4D3
 /6sTXYqe3WTTjjfeOgjPL+wFlPE9/TOTq0tmSHclOBDjMOBDYH9DiS04j75rbww=
X-Gm-Gg: ASbGnctEtczsfCVNbY0MlhGKOlgP4cpfvcfilwV6Es3hAz/3J1/qK4CRd146xFlWIOb
 RWtNYoG4SwMMqcVLS1kq5/AQPBoUNKNsbZIyIFBbYS9BteXLjhGKLjW28Gt24tJ/H0/gJlifo+C
 J/1oVRGnEyRV9UssEvXjQpcZyGsVdYnIVsJnMbDL1leVI7ODgWbngLUONRWwJ5tc3J9oV+ImPrE
 ZvWC2N+ntKYrJ09tDPq5X2QKbDzIEeFuL9KFcqLj4lnNowrVZfaYZc=
X-Google-Smtp-Source: AGHT+IEGhl5qeB+DBYf7kZThqnQZqDIRpT6VsLiltajbBS/0Hw8cz6qHG1mjiEn8TGjKk65NznigWw==
X-Received: by 2002:a17:907:770b:b0:aa6:88c6:9449 with SMTP id
 a640c23a62f3a-aabf474fb64mr182448866b.19.1734515284552; 
 Wed, 18 Dec 2024 01:48:04 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab96068d8bsm552136566b.65.2024.12.18.01.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 01:48:04 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2CE0B5F846;
 Wed, 18 Dec 2024 09:48:03 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Wainer dos Santos Moschetta
 <wainersm@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] tests/lcitool: remove temp workaround for debian mips64el
In-Reply-To: <20241217133525.3836570-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 17 Dec 2024 13:35:25
 +0000")
References: <20241217133525.3836570-1-berrange@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 18 Dec 2024 09:48:03 +0000
Message-ID: <87wmfx490s.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The workaround applied in
>
>   commit c60473d29254b79d9437eface8b342e84663ba66
>   Author: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>   Date:   Wed Oct 2 10:03:33 2024 +0200
>
>     testing: bump mips64el cross to bookworm and fix package list
>
> Is no longer required since the affected builds are now fixed.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

