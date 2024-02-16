Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D945C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb0Qj-0002Xr-0R; Fri, 16 Feb 2024 10:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb0Qc-0002X8-1A
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:47:06 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb0Qa-00024Z-8v
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:47:05 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4122a8566e4so12108925e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 07:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708098422; x=1708703222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JkUHQhfSifO0i3zFVHEM05VEE/CKxYmqTQXvW8S86gs=;
 b=UDMGIO+SKLf7lAddAeUquO5g7xbhPBhterNQKB5Ayqm9qpOP9ntbqEWW4rGdivhkz+
 nI8VvV4Dbz7UmgPxwIgih6ERwdwq1bgJZnEM0C0ioRPDCVyDWVfowdPwYTmcM/eeugHY
 V54iAyfd489PDxAOcAVndUKJlEaJxGK/GWwSaZS+MOoZ0bPA2VhpWwtUWW7av3PYhLen
 Q3Ct3qGAR6Ek7ZRVz5sq3Wf8L6utmy7RhFys0uvMNib8RxZnZQAEBae/butKnoVGeUs+
 9juGH0UHBnNEKAg0aFElmJHaR5bqQ6ZI+4nhoDTLAlETPlZmFWaslJJv3oKBV0jn+ZDd
 xKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708098422; x=1708703222;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JkUHQhfSifO0i3zFVHEM05VEE/CKxYmqTQXvW8S86gs=;
 b=o9xIpxkCT+xn26dHUbr52FA8Mgl8BirLEQn6gRFlZ9b9GfeC05uSpTKnvUp21K359k
 NS2TmoOLbsg3XJZEEcQTVSoZhcfZguy5WAVgR+qiTsbUVNTgZ4bsOv1truoxOYVVs0QL
 FWuKE25ih4m3rFnfLD8n8tOVvQrn0xde+Q7FwdyqKoANoGarWwosXOwekPxCObJ0JE5X
 qYUvIJRCZWoOKRSW+a7Yfa5BFcHwbNGa5vI1MZL74vF6HUWfW2B2HRBySO226NlFK9cn
 GjbtB6vWs4l4xgMmLsWcoa1E7ouEYkDZQWCpDpsborGmuAnVmEHY1nEKopOS7b3EEzOO
 nSTQ==
X-Gm-Message-State: AOJu0YxZb3BjPpiRfodqjZgvacN9M8TK+7qvfCx1m/Uy30Mz90WKfJt/
 oTI01a6DSZDs6CQpx0E0joncEW708NlG2buWjKfP2zjbZ5QGD8DwyyPmNurPrVE=
X-Google-Smtp-Source: AGHT+IGPLnTb6uHNKBYa623FL3pN/uaaDxd+9Zq93RLQmuBVLRTpqwlQGiY02+IfDAfEbnsaqUvnFA==
X-Received: by 2002:a05:600c:470d:b0:411:e4d4:8fd6 with SMTP id
 v13-20020a05600c470d00b00411e4d48fd6mr3855854wmo.12.1708098422130; 
 Fri, 16 Feb 2024 07:47:02 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 13-20020a05600c230d00b00411d640085csm2663305wmo.43.2024.02.16.07.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 07:47:01 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D1685F83F;
 Fri, 16 Feb 2024 15:47:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-stable@nongnu.org,  Yonggang Luo
 <luoyonggang@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] .gitlab-ci/windows.yml: Don't install libusb or spice
 packages on 32-bit
In-Reply-To: <CAFEAcA-7S7QOBzDBS0UmWDxK=2AWuX1QFZ-TCfvCOOhJpL-wng@mail.gmail.com>
 (Peter Maydell's message of "Fri, 16 Feb 2024 13:19:54 +0000")
References: <20240215155009.2422335-1-peter.maydell@linaro.org>
 <87y1bk4pfz.fsf@draig.linaro.org>
 <CAFEAcA-7S7QOBzDBS0UmWDxK=2AWuX1QFZ-TCfvCOOhJpL-wng@mail.gmail.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Fri, 16 Feb 2024 15:47:01 +0000
Message-ID: <87bk8g4dje.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 16 Feb 2024 at 11:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > When msys2 updated their libusb packages to libusb 1.0.27, they
>> > dropped support for building them for mingw32, leaving only mingw64
>> > packages.  This broke our CI job, as the 'pacman' package install now
>> > fails with:
>> >
>> > error: target not found: mingw-w64-i686-libusb
>> > error: target not found: mingw-w64-i686-usbredir
>> >
>> > (both these binary packages are from the libusb source package).
>> >
>> > Similarly, spice is now 64-bit only:
>> > error: target not found: mingw-w64-i686-spice
>> >
>> > Fix this by dropping these packages from the list we install for our
>> > msys2-32bit build.  We do this with a simple mechanism for the
>> > msys2-64bit and msys2-32bit jobs to specify a list of extra packages
>> > to install on top of the common ones we install for both jobs.
>> >
>> > Cc: qemu-stable@nongnu.org
>> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2160
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> Queued to testing/next, thanks.
>
> I'm just testing a merge where I've applied this directly to
> get our CI back to green, so you don't need to take it via
> your tree.

Ok.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

