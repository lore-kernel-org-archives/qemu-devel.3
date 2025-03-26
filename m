Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD38C36010
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 11:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txOuf-0006IH-5c; Wed, 26 Mar 2025 07:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1txOuP-0005vR-35
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 07:26:57 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1txOuI-0006Iz-28
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 07:26:51 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so40297895e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 04:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742988408; x=1743593208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7g2IKnrBrJG+N9GY0A6+8nTLCF+vCW3XpzFaL6k+rbk=;
 b=RUzN208g7h3kaD8LK2lUYtCF29lM3SPRHl6UQbJtC926xr0pqLevBjwkN+WB6YgN75
 1XhNiCSh0xeQKbfV4YS/1l2HiVVdBJjLcFR/nwx492+VSrnGJanqVrMXyWsZOzD7cSur
 FSXmwlzVCgnuJQNfo6Ughq7m9u0kJn829WrayAzw7hRHcbpMsFAGFXI+lmdtq7EA1xLd
 41zIWi0kRt8BAS1I6MzOgtYU8VYMkRg4dhHpffHa4sJwUNr5d1gfXqGBNjCg68H27ZfN
 K0ntj052eZ1jM1OSpHJax+fe7zVv3/JnWDxigka7K4IyJ47TAy0GVXlIcFoQxTX9H++7
 Q3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742988408; x=1743593208;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7g2IKnrBrJG+N9GY0A6+8nTLCF+vCW3XpzFaL6k+rbk=;
 b=S41MivjonWIp0byXvx6IfYYOyE9k+FTHnmxKNiRTSpNHc17D0j1QccZCX6aYi0lncU
 IFubYqnKRAAoabp5zuRnrIx+jDFafSOx/CmUDxDVs+/7H5vvVjksg72iAfJclHfJRH+E
 vf4hpnQBFbmFBG7w5WyX5qXz2lGBw65JiPhk0VUHgFqtEJd1lvTKlypKoAXvfcm3AU0q
 v6xAV+QsIvjEg5ZzEjuLT6ZkeJeF6z0NPDWzSmyYn9pHvDJMn9TZlrCONFveECpQ5b98
 gpDRo/D/pRGZQl7DIiLM+wSmiWh4e4xH5zmqNfWRwH6uCwvEBaoJSIcrk6agJz20/2u9
 qYaQ==
X-Gm-Message-State: AOJu0Yz7Seva2NUu0/mLUC3kxXJUosLO7EAR2ycr0gKN51ysq2araXPw
 zH7HAAIVEhaEOlRTDNyOQuZKAmctGbVY5RPvzGsU3+si9k2pY3UoL9Ua1S68OmE=
X-Gm-Gg: ASbGncuRahDzv4zxtvLZxiZ3PiIcB0J6+RI9sFQDM3890B9xM2vBO1Fu0PAzaLvhrax
 cfCeCjEw2wHgbBmZ+3CxHIchcLYAKkn8FYNnG6D3xXdEAwmf09eoHOIVzOT49LTw0AFHYg8HxPW
 1dfICQIJzyCBS3f9gtYHy6TN2GkOB5wEgu7knsdQegIblUr/QmT0eIRL2C3IRe59DXkFKXOD8W9
 9GRcN9tMgYKHpqgrMlCv7IjmvmT/hBhfjDa291KBNef8+32UtVRorfIJgNI5KBm/iwnXjNhFhau
 5X+il5HVIQDmxLcHyqYFIDjcFVoVT1HuwYIWx6NUeFl0i04=
X-Google-Smtp-Source: AGHT+IES2Re9pQalUvHFOUIYdRBm5Y1Mc23ubaKSfKumPKaNKusbkFVeGI0CfdWa28ukFmWzNyDulw==
X-Received: by 2002:a05:600c:3155:b0:43c:f81d:34 with SMTP id
 5b1f17b1804b1-43d509eae2dmr169841015e9.9.1742988408129; 
 Wed, 26 Mar 2025 04:26:48 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fceafacsm183483745e9.6.2025.03.26.04.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 04:26:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EFFAD5F90B;
 Wed, 26 Mar 2025 11:26:46 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Alistair Francis <alistair.francis@wdc.com>,
 qemu-riscv@nongnu.org,  Anton Johansson <anjo@rev.ng>,  Daniel Henrique
 Barboza <dbarboza@ventanamicro.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,  Weiwei Li
 <liwei1518@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH-for-10.1 v2] target/riscv/gdbstub: Replace ldtul_p() ->
 ldn_p(sizeof(target_ulong))
In-Reply-To: <20250325154913.95283-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 25 Mar 2025 16:49:13
 +0100")
References: <20250325154913.95283-1-philmd@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 26 Mar 2025 11:26:46 +0000
Message-ID: <87tt7g118p.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Replace the few ldtul_p() calls by a generic ldn_p() ones.
> No logical change.

Queued to gdbstub/next, thanks.
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

