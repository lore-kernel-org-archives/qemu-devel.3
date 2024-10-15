Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECDDD21690
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0h9s-0005gd-1c; Tue, 15 Oct 2024 09:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t0h9n-0005Ym-8I
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:00:12 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t0h9k-0007FK-KP
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:00:10 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4314311959aso4403285e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728997206; x=1729602006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DY0mf9LgIKF/AWCH0RzXkvYKoekfHo8y6WDVdpvd44s=;
 b=sBqGTHPstrVYFhxsX2jKB9UvWrOtup8oXFZERXdyo53HAcfKbAzEN0Z947HyPwvX+0
 W0BnGK03Kf5Mq88QtiV93xqHOmB0eoYCW7C/jMTJ8Nm1h9y5bwturIjdgMmfo9yUnTFW
 tlrSYjN/+xkVugvlwwr8gImt2cjDVNXS5hEW2w6PfVasAa2kppwxpUj5ByE6M0JOUcHS
 MDC1NgqPfosC58su0vbvTlkOLbpdNbDALgA/5NzNA2ebcDTdXT3IYyzCnhogzhHwWylQ
 zk8aLXC46Y8woQ07BQoX302ikq+uOZyWZXzc7As7U8/mMOPRBkVtprD9t6XQVdLZFdQA
 KsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728997206; x=1729602006;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DY0mf9LgIKF/AWCH0RzXkvYKoekfHo8y6WDVdpvd44s=;
 b=Qs3s9MeG3JFZkq2Hh0Sgj/vPlEJUh4QZXBPxZRCZJr8Hgi0LPDGGxUHhnFMco4fFTE
 BXCAl81buBv03MPlhC4fem5wNyg3Z7rgtR/QryXk9YUXjZhxvphiRhg5dgvDRJaRd/oW
 GhxByBeB9xmEV1sitRJHjslGC5umIBcXdY4FZq4FkEtdrD8s0FOExW5K5U4kquaQrJmb
 Q1shq2xvTWqBQA5r8fIRv4D40EHL1yeRFhp8DYx1B3q3E6PTN34x9pRCwrakJqJNXU37
 EFcZ1maIkDrYeicJW6aGoetccI7XrgEPByMSvHOs32ygAWDpGyJ910Gjp49wjPJztsxU
 3plw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDYHXgPP3wVQi3YTGWjiBFp6hjovbaqG1CgAHMmBham88DO5pXp4twznJYIUZj3DE2WgNZXsiR6xu1@nongnu.org
X-Gm-Message-State: AOJu0YyfekuLUbjus3FHlfzD3LxvOVGZvU2QOmuAoqNPD7pYgVsBJvU5
 tV1TxLLpmCVwZPTL6GoTiYVfIY8makaTb/suUGBVyyv7t5cus1DFVC1/HVtNUHQ=
X-Google-Smtp-Source: AGHT+IEVJUWjjnHzD2ZA7HyGw+poXazcA85f2tgniV7p9hzFAnv96zEOlgYdAFnPqTpJm8kGbDW8mQ==
X-Received: by 2002:a05:600c:3b9c:b0:431:47d4:19d1 with SMTP id
 5b1f17b1804b1-43147d41c86mr7981155e9.1.1728997205576; 
 Tue, 15 Oct 2024 06:00:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f6b1e77sm17454055e9.31.2024.10.15.06.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:00:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 49F615F8C3;
 Tue, 15 Oct 2024 14:00:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org,
 Brad Smith <brad@comstyle.com>,  qemu-trivial@nongnu.org,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Michael Tokarev
 <mjt@tls.msk.ru>
Subject: Re: [PATCH v2] ui/console-vc: Silence warning about sprintf() on
 OpenBSD
In-Reply-To: <20241015112510.412471-1-thuth@redhat.com> (Thomas Huth's message
 of "Tue, 15 Oct 2024 13:25:10 +0200")
References: <20241015112510.412471-1-thuth@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 15 Oct 2024 14:00:04 +0100
Message-ID: <877ca9a5d7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> The linker on OpenBSD complains:
>
>  ld: warning: console-vc.c:824 (../src/ui/console-vc.c:824)([...]):
>  warning: sprintf() is often misused, please use snprintf()
>
> Using g_strdup_printf() is certainly better here, so let's switch
> to that function instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

