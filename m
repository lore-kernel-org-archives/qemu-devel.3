Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06FAC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 08:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTzxL-0007jT-34; Wed, 17 Jul 2024 04:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTzxJ-0007hK-Nc
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 04:24:09 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTzxH-0004KO-SS
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 04:24:09 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-585e774fd3dso7978914a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 01:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721204645; x=1721809445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6eWBGH/dgdCzw/iyIayID0uWmrwqasP4uIAUsSJZRcM=;
 b=mlX9T2h004jSCScm8KwAMI00Y84f+6iFW3kkqo3vy6UcCIub1leFDHaIMcLEiy0Ylf
 epCOkmeyaGV78STDY08KZ2cuvNq20XSew+JFQtkqMQ38t0XNKaJBCu4gQ4+8BCWHMZtc
 Lo5jFAsNmNhrjBnTVJ5JFMv7e6ql0PlYjC/cUGmQyaIx8Aahh7W/WnkW0Ld/ji5/l6hf
 OLBaKTPhguwFtFfmVn6dumwAScqQ+btt1oaJ3FD6oKRvOTYGDZoKOF2mwfERlJskYvVH
 xRAI2+WdIzVMUOoa8pJL7yvMAq3zF9Texr+PUXWAdiW39mxWbaXXWKxqS9OaXrNt1qU6
 m+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721204645; x=1721809445;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6eWBGH/dgdCzw/iyIayID0uWmrwqasP4uIAUsSJZRcM=;
 b=Dqsic+8paytZlj2yNKeOgNhbA9fubJbsytpO8mZpk/28ZomaPRd5i8kA5FdkXdmReG
 STLbuwa+u3MqJGMVihYNnxBe1errZmuqeZhQwl9xgi9jCx4G3iGyIpal4afSwHWDYNK2
 4XstkbqO/sWSLzOOxBXCxqhBLDKcFI4K6Jvg100xRIbk7DUkm1MTGZ5Lvo/BhOpF8CAv
 SJAxyH4/bNdwO3Q9rBbm4D9OtK2wiIZ8vOjruMMFQ8YAqKuQEaVrefxx2umWigssUAAN
 Yj5djvm9Gvc6nr+KDnOreyiMzUFY2slI4kNnwkcCkpWoWjDMcRnHY2njP2AIVbJ8uNoE
 ezvA==
X-Gm-Message-State: AOJu0YyRn+iKC4UZIWW7hKRqDS4sXe2bwEh2mqq4jYe8q4GI4jL7cvJB
 PdLaDNognu3uB4ANCku0/BUhg4047Y0kUqU8W0xRyYyhYtpUPBCpVVLm06aKSJn3qZnkntP4gO6
 Q
X-Google-Smtp-Source: AGHT+IFW4xqqgLEIigsqFye+Ap2nzUGzwaYAzOQacPR04xk//B+jEW+1xXRNfumtwPRWjHgKqaZA1g==
X-Received: by 2002:a50:aad2:0:b0:57d:3791:e8e4 with SMTP id
 4fb4d7f45d1cf-5a05ce11c1emr615162a12.32.1721204645264; 
 Wed, 17 Jul 2024 01:24:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-59b24a770c3sm6490450a12.20.2024.07.17.01.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:24:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 239605F738;
 Wed, 17 Jul 2024 09:24:03 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [RFC PATCH] gdbstub: Re-factor gdb command extensions
In-Reply-To: <afa432f7-ed06-4074-8849-796984be0bc5@linaro.org> (Richard
 Henderson's message of "Wed, 17 Jul 2024 07:53:01 +1000")
References: <20240716114229.329355-1-alex.bennee@linaro.org>
 <b9b178fc-04f5-49a6-992a-f6920408b41f@linaro.org>
 <87cyndgtui.fsf@draig.linaro.org>
 <afa432f7-ed06-4074-8849-796984be0bc5@linaro.org>
Date: Wed, 17 Jul 2024 09:24:03 +0100
Message-ID: <878qy0h1ek.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/17/24 02:55, Alex Benn=C3=A9e wrote:
>>> Are you expecting the same GdbCmdParseEntry object to be registered
>>> multiple times?  Can we fix that at a higher level?
>> Its basically a hack to deal with the fact everything is tied to the
>> CPUObject so we register everything multiple times. We could do a if
>> (!registerd) register() dance but I guess I'm thinking forward to a
>> hydrogenous future but I guess we'd need to do more work then anyway.
>
> Any chance we could move it all to the CPUClass?

We would have to move quite a bunch of stuff, including the system
register creation code. I don't think that's a re-factor I want to
attempt quite so close to soft-freeze.

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

