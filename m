Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A44CC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 20:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgQD-0007Mp-Jm; Tue, 19 Mar 2024 16:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmgQB-0007Fp-0n
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:50:55 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmgQ9-00048m-74
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:50:54 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56bab906859so111296a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710881451; x=1711486251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LlQBqh60Pq4Z5fJU/5cqSfWr+/Y2J+McIdDVZLCz3eU=;
 b=uE3Id4ko4Kmnfu9wBnRNXvHkKCsUPLooQtXCwwB0N4+TAh3aI11HTWISQN6D5sG/IJ
 1rkh7nc9LizHfhLGHiWWqnDl2pMazjD5tGRWVL2XaxpNl6ArIqW4DSNV3nW0Dsb7jvgl
 SpZea6tYkGXZSBePA9DRde5LqpTCtkpR7J0SQ+eIDlzcS1+oEnON/CZW9KfvCimPPpH5
 ly1laoDZB87XdKAraiYjqHy7IuK1FZodP7SnM1gmYsG2HX4G1dC13Wv1M93GvWcEamGi
 ZGMUbu7FPH8GINUEW04KduBCV9EKIzcbJF+fkBxNGUeEc/2OUHDFDbHkjggqdo06MSLi
 hjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710881451; x=1711486251;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LlQBqh60Pq4Z5fJU/5cqSfWr+/Y2J+McIdDVZLCz3eU=;
 b=SAzrdVhCvjOP2lOJZfiJiORCtmX9cbaziZs+gI61z2X8c9YDM+rSpgH9HUDZrqvmqW
 u7Np5lzwDwvczLMaq9AoCS2JcyTNMS0izAZOQzaxImG2o0e51kVBHobjOib8aL6xZ+bA
 Mur+M9mpU1H8Z95bvL5ZQEG+rQ+UI7COetmXCLI4zKIF0Sa0N8McEcprfZQkplmUw47/
 ezmMiJgEYkyem6RvAoufB4yNTVaaHCrY18G/3JFRs+rEepkHjwaxkrL+/sqBOexNSxLY
 9AVVUnYRoCihNa7KkZgdxXvvYe6g0AXKdvlJRNsj35D/hhFsOCi8nq89tzqvs0qnkaxN
 oSag==
X-Gm-Message-State: AOJu0Ywwh/SBKMKncpnsIy1jf1ZB95J6TFOPp38wYGUFoxWomNJ1/vWf
 q1EIyEbbZRsbU5qTK1FR7DPSrVADfalGOZTjoWVyiFAVDr68F4603Ky3xQ2Vq/ScZF+/16ctWat
 g
X-Google-Smtp-Source: AGHT+IErk6QiMraFshhvEnKFfC4lqh2h3byHql/xffZfLrjsCvV5MkEbD7y95GbBCpFTLiD6NxoEzQ==
X-Received: by 2002:a05:6402:2789:b0:568:c309:f7f5 with SMTP id
 b9-20020a056402278900b00568c309f7f5mr6847873ede.6.1710881451461; 
 Tue, 19 Mar 2024 13:50:51 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u22-20020aa7d556000000b0056b9ef8f020sm694158edr.71.2024.03.19.13.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 13:50:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D3E695F785;
 Tue, 19 Mar 2024 20:50:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v5 15/24] tests/avocado: reverse_debugging.py add test
 for x86-64 q35 machine
In-Reply-To: <20240318154621.2361161-16-npiggin@gmail.com> (Nicholas Piggin's
 message of "Tue, 19 Mar 2024 01:46:12 +1000")
References: <20240318154621.2361161-1-npiggin@gmail.com>
 <20240318154621.2361161-16-npiggin@gmail.com>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Tue, 19 Mar 2024 20:50:50 +0000
Message-ID: <87cyrq2bf9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

Nicholas Piggin <npiggin@gmail.com> writes:

> The x86-64 pc machine has a problem with record/replay. q35 seems
> to work well. Add a new q35 test and update the flaky message for
> pc.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

