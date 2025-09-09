Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB52ECAC58C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 08:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvtsI-0001wA-9H; Tue, 09 Sep 2025 04:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvtsG-0001vf-4n
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 04:38:48 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvtsC-0002t2-DT
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 04:38:47 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6188b6f7f15so5913212a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 01:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757407119; x=1758011919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hqm3r4uhdQChug9ehIuSW1zkd4FZ/AgDodGsnf/Ajc0=;
 b=pZ9H70AZTGTDNg1devsu1Bn2J0YzgGORJwpWv1Amix/PVeUS5TdpCkPBudXk00H8Qm
 HWQBmFX1W0rqg4Fy/iul42SQliePXp4SVzjq7sd70tTZzi7J+TcBe2TVCe8n1gCPe+Rr
 8nBypiqXpjoP5Rh+RX6g0N5sHd4fDaMkZGypKD2HyF+jKZo+ZuMc9CdKTSGEJNvlgoGu
 R1Iz4Gc2sJDT4/jjkuXO4nBB3pzBwD2FCenqHEYMviubw0o4Aw3IiBhSnGS95KTzAKr1
 jazMvs027x0dB1WJvjJyDq7KyuOgSsyA/vm6ledDoprZEPpYK01TTE2FW3CWGTsATGjd
 2O9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757407119; x=1758011919;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hqm3r4uhdQChug9ehIuSW1zkd4FZ/AgDodGsnf/Ajc0=;
 b=TTUSry0yfJzD1SgxJozcME1Dg2IGkoD3naPhPcJo5xRqWkyUNSeLmaaCsrVsUKMWMZ
 ypbXOqxdchRsCgfSAWZpcFWJaZ5tC8ghUtPwFlUfupLB/COdSKLNjqc7cNVYCicCTKQ8
 goKHKxlMarI8HzFplL1YGEwWGdyaJohV5qwr4FMYSORcuWMckYVypr8Vp+4s5mRAa2Ne
 g2NKX5QKA60TgiGzg0IGMqd6AQgmiW4Vnt8ONHK83iqhxqjlf1rIiMumGOdKaQNAUtJK
 1GIYqzxkln04VRE2ulK1QjL7tTvoseXgcSgYL2pXIqdyEt+QEl0zcbkMhyF7HH1ato4o
 dBvA==
X-Gm-Message-State: AOJu0YwiYCXWcDBE+nsZEUDIBX9hBJd8PRKWsZbyBli33ye4XW47KItJ
 J2vVq55mg4eXTH0TJwY/efIqrh/SjHT475idzVxLsKKKaqgWst3y4Ssku4bSbZzbS6U=
X-Gm-Gg: ASbGncuw80UHvsUfEMsKpHdVvMehn/u72W4ug9fNc7oNtu+XvV7y/Jc6CYVu82D/Hlz
 tuEDN/QE6f0nt9fw8UyyLdJVIC2+4+UePdU/vybsi51njtZaqleO2N2iSF2FS/+kr3fEe6HEjJk
 BCFLUcvQZzHs/iCFsuwjMPDNxmUksXxVNk2VyLnekHam9zkXFdkqt4SrEpdISarmb/13Gib+Eix
 nY4++h3uC2ijK3o47xyLZZzIaaaeWHIOpbyxk6NmvLs68EV3cRx0+uHUhFKuu/eSntFKKPNqrwa
 pUrl7JOcwqJCzTyK3dfOLVHw0vtC4Y1wUujExjnp7SznxuKrX4/s62EtvV00aA4fN2Nqbst7Yf+
 YwdviGiL5wD6F/v+auE7nNO8=
X-Google-Smtp-Source: AGHT+IErxRWe8e9sgpsxjW7o1SDQ9Hdyg+1WdQTlFCZsikxea7oXDHQuRwVQQk4rNvS95V2vqGFfUg==
X-Received: by 2002:a05:6402:2343:b0:61e:ca25:3502 with SMTP id
 4fb4d7f45d1cf-623771096b8mr10603846a12.17.1757407118991; 
 Tue, 09 Sep 2025 01:38:38 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62c0123f23dsm864641a12.25.2025.09.09.01.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 01:38:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 24DBB5F829;
 Tue, 09 Sep 2025 09:38:37 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  Philippe =?utf-8?Q?Mathi?=
 =?utf-8?Q?eu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] scripts/ci: add gitlab-failure-analysis script
In-Reply-To: <56baeaa6-b274-457c-931d-4ae76535f6dd@redhat.com> (Thomas Huth's
 message of "Tue, 9 Sep 2025 06:37:26 +0200")
References: <20250908211859.2678847-1-alex.bennee@linaro.org>
 <56baeaa6-b274-457c-931d-4ae76535f6dd@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 09 Sep 2025 09:38:37 +0100
Message-ID: <87plc06mwi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 08/09/2025 23.18, Alex Benn=C3=A9e wrote:
>> This is a script designed to collect data from multiple pipelines and
>> analyse the failure modes they have.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   scripts/ci/gitlab-failure-analysis | 65 ++++++++++++++++++++++++++++++
>>   1 file changed, 65 insertions(+)
>>   create mode 100755 scripts/ci/gitlab-failure-analysis
>
> You already get a nice overview by visiting a page like
> https://gitlab.com/qemu-project/qemu/-/pipelines/2019002986 ... what's
> the advantage of this script?

Not having to click every link when I want to see what the pattern of
failures is and what might be a candidate for making flaky.

>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

