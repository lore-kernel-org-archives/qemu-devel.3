Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D38FA3726
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 10:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbcnx-0005GQ-NV; Fri, 02 Jan 2026 05:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vbcnw-0005G8-AW
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 05:54:48 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vbcnu-0002VM-Jc
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 05:54:48 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-430f5ecaa08so4877579f8f.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 02:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767351284; x=1767956084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cvA24UCb1BQ4rrxKxQC0TQW6uLCvYvHsgCYYgGiIop8=;
 b=BWkldZHE+12aHN2p3Uriof1kmJzEUtxPHAxwzh8QgpZiUoiG4GcGqVZH75kBNIPEQm
 3yesmkXzYF4doe+jqiQjUzPVKgfxlxsmZNYPGQcKgyZLwgsLMO1lXK6Reu3+JQ2rCXJZ
 Uor8jfSAcezvzf5YnOQEUEd2MjXngSerhCq7KC2MwLP++m3aQJdQ7aoW/e6ITVLJ6xnf
 INXzj+Jzw173gD57WlNSTt86BrhYruTClQeZzI2vq551eI4Nsd27NUaB/e2ksB93rP46
 1raPqf7UmdnGjX+tZCexaitd5IIrnYataGgtGbd64EQO0MJB1/OxJ0BfohYkZ6Psm9VN
 BrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767351284; x=1767956084;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cvA24UCb1BQ4rrxKxQC0TQW6uLCvYvHsgCYYgGiIop8=;
 b=gqG0btMD2OYFLwB0cD/Eidj3jtRTOpXVsRK3IC95fFVLWoRo3xBLBznKp3TJe1mrZ6
 yfiJ/onqxuKJzYowGfqYiXrIrP2uvILN2O66BnI8Hp9y7vRCeZRiBbbCIr2/5y14Dkhy
 cHpnCCp1NFkVbgXlSjtVD0PTrm1TDLNThXwr+64um/qCLT8SiE20C8N++pgVj08YdE+V
 Zi5xgyhv+3pfiwChYp9ceXi7SdvVP79I8RK4r3v8vzWdpZa8370vPORcNdY4vohdnY+D
 s8t5JnuQQcWQAwiuv+xnC/mOVi4dKoOsVc+CQjnLVQ9FFSzjqTck/t/rDnL+anzQj8BW
 WZrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV5WWHHPvyf8aJmpyYzQqB+1I67k1Y6V0Zad1iF6nTRMIc1IV9ulTuhrObkBC0wa80e1Vm/QkwiJC+@nongnu.org
X-Gm-Message-State: AOJu0YzrLYvWweT42kZss1J2ELFyWk0FidrvCZLSTa90Z4tzFN1dqZYZ
 i6aIj0xLkjuZ1Lzk83erPF52H0afXBHDKtq2J5GqMkNI6y/VYuIzhP+Swj9i/z8Wb80=
X-Gm-Gg: AY/fxX5qZwuW9M8qIUbjtffcgArWD0aair9qw1Ose5nZao3taldsbGKSaGAEhT91RoA
 te0Xg8OfcnAiF5AmMhGtH2iWzciLZf74Pjsth5EJQ+oUUMoE0EtRHU1Xx7GZTb9reL0HwNPlEJ5
 QS4dpRmgYkevkxPeYq8/aMaumBGt8ecF+2JavMqfYJ19w6UwNvUAmGM4UFyLXEh8HckazkVq17E
 y+laPsMRKNftOGRv0o0UqBr3yQxqGIKAXoVM7U3CDpW9b2mt4m/zYujgRuQtr63AOe0pCtsTHFx
 MLZyxRpfbyjOrEdaCLpLiuivV1usXiSZna4C1mhQZ8uVUt6OdUkYxJO9w1hpGxYvtgpBZ8v8KjT
 8GK8MSY3o8Dpv5McP+QyDvnHTUvB0MabAWz5M7eK2lruomuRpPa9WWS+lnnq6SmWsCepQTy/ydE
 iViJOlTzNtQtk=
X-Google-Smtp-Source: AGHT+IE72CPlldLITCA6YAYZZ+WQci5D6RHe0gUiQTZwdyEtBKUoXPi0Xr0EJ/TsxwwxbkfQd2Y9gA==
X-Received: by 2002:a5d:5f87:0:b0:431:a50:6e9b with SMTP id
 ffacd0b85a97d-4324e4fce39mr48266209f8f.37.1767351284560; 
 Fri, 02 Jan 2026 02:54:44 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08efsm84664884f8f.29.2026.01.02.02.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 02:54:44 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3B9015F7FE;
 Fri, 02 Jan 2026 10:54:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  John Snow
 <jsnow@redhat.com>
Subject: Re: [RFC PATCH 0/9] for 11.0 conversion* of get_maintainers.pl to
 python
In-Reply-To: <CAFEAcA8X04aDqKO0S1cq-7V=4JbjaRQ4CTQhPh8CRxUKMxHE6g@mail.gmail.com>
 (Peter Maydell's message of "Fri, 12 Dec 2025 11:25:23 +0000")
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
 <aTvPDXZjfp4_egTa@redhat.com> <87zf7ot170.fsf@draig.linaro.org>
 <CAFEAcA8X04aDqKO0S1cq-7V=4JbjaRQ4CTQhPh8CRxUKMxHE6g@mail.gmail.com>
User-Agent: mu4e 1.12.14; emacs 30.1
Date: Fri, 02 Jan 2026 10:54:43 +0000
Message-ID: <87bjjcxp1o.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 12 Dec 2025 at 11:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>> We can certainly add the ability to dig through git but to honest those
>> doing archaeology are probably better off reading the logs. The default
>> it just to match paths to MAINTAINERS which I think is what the main use
>> is. It's not called get_git_blame_info.py ;-)
>
> The default of the existing script is to start with
> MAINTAINERS but to fall back to looking at git if
> there's nothing in the MAINTAINERS file.

I think a more useful policy would be to ensure all code is covered by
maintainers, even if it is a fallback. We have checkpatch tests that
care and this script is amenable to being used as a CI task.

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

