Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF60CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waaVQ-0007Tt-Gu; Fri, 19 Jun 2026 10:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waaVP-0007Ta-S3
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 10:47:39 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waaVO-0008QO-Dw
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 10:47:39 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-462342ac290so2510475f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781880455; x=1782485255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pOqBdFbAfK3vtMAnPAaYACXA7Z8u8jGwEkl25FDNS6s=;
 b=sNLhMNHYWld5OE4v4n8zEMXnBOE+uA31hHZtAGcnH2fJwKpkgeZgDlKQYvbYsBpBwt
 AhYGa45aQfj03Qsvi5s5MBFJg87XO2gWGXaINoXHpNs7HA5vk4jezcPMhcaI3RzNQcqg
 Q0BXV3YzcuAQbHwoi9lke4IisU8KCiWQNJkB0pObPS3fOWOHbHrzOBiRI4hBYY4Q3fZk
 n9xnwELj9YOoRAq18OfgciCwSVFRFTJ/oQGWFdNscTEhc9nwjX8nzAWbjyC8U4K76FTf
 ZDAGLNXYbAm/rnafublLZyD5T3duzcRe45dp0wx7R3hmG5gL4xDE5wiTVn96MKZaUXNI
 x9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781880455; x=1782485255;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pOqBdFbAfK3vtMAnPAaYACXA7Z8u8jGwEkl25FDNS6s=;
 b=gPsr7ye49+7/pHj+Ko0hFRTRrLZXzpi4dfQ5I5FCEJVrAPRIdNqkHY8wc0TrjLmhb7
 nu0dEcgrlC0cpHEPzbVjNTL1kpoNmp7n/hiYuLXRz1hWOE4B8FL26xgScdhJghDOY9zi
 8F5vEscde7afjmdG5f3ww5WYdxoS8ky3cN/pe03UwJ+mq1MvDcpeLduQs4YnYY+raiB0
 fwPwWzwyOMY0+j4ZPa7qeqSJRJwmCEHXcWmMTqiltRpOUq+8BhrKSIhQ1cD0Bsrp88zQ
 U9qlpZEJYo0GYBCP8SzoIYdJFK4GE3wpHxor0Nv9FJYawXH58IlhiSu1CDS8t163lgKA
 UeYw==
X-Gm-Message-State: AOJu0YxD/qaYtn6Ank/uVs5L1BhuHBOPTJFu4XBknePtarFBNQw4Y+fa
 4iMfe/5D5m7jR2z8eWJJ8dbaHP82oAG+HKVzLSCbGcGryok4fqPR7RN+xwl8uR6BGLs=
X-Gm-Gg: AfdE7ckDBLYd6db+btyR5/1FCFMyqOS3a4MnAbMmv1XJo36gl9MGpBrX0qZmjVQ1A+V
 wY5WBPrWICqEA9wM4rU14Vk9JDEFb8dkDz3rTXYlKvim5Fx7fj0JWs7+u/iU/tCTYbv9MSw/xu4
 7N8HqssWkICDPlG/cWJtqKShDutNn5lA/pcuR0s/d/4nZuH9PUiw+T/bix6AlSRzWtMfq1BxZ31
 rL6hsrdpBOToxy+M+qqFYauoqwkJgvIZQ5IqZ/pCqqRIy25yQ5xOt/4RaiXKjsCuuZKL8i1JZpG
 UV9kR6RjFCAlb4/z60EpfuSEjD3ONE49Ith5V/7bl2pl5KeYXcrHBJN1SkimW5O6KgJjwByk+zQ
 /0c6N+wTHw9lj/EKGxq5cGfIQW9sf7fwY08ot6Zr4/1stG92mePYvXfMosxSZ4gwiTuzS7jhrFw
 BuGJdwtnE7k+LZ
X-Received: by 2002:a5d:6f16:0:b0:461:a19e:c299 with SMTP id
 ffacd0b85a97d-4656bcc955dmr4352758f8f.2.1781880455202; 
 Fri, 19 Jun 2026 07:47:35 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650bc423bbsm8585621f8f.28.2026.06.19.07.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 07:47:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9B6BF5F814;
 Fri, 19 Jun 2026 15:47:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ziyang Zhang <functioner@sjtu.edu.cn>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,  Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Zhengwei Qi <qizhwei@sjtu.edu.cn>,  Yun
 Wang <yunwang94@sjtu.edu.cn>,  Mingyuan Xia <xiamy@ultrarisc.com>,
 Kailiang Xu <xukl2019@sjtu.edu.cn>
Subject: Re: [PATCH v2 1/1] plugins: use int64_t for the syscall filter
 return value
In-Reply-To: <20260618082426.790315-2-functioner@sjtu.edu.cn> (Ziyang Zhang's
 message of "Thu, 18 Jun 2026 16:24:26 +0800")
References: <20260618082426.790315-1-functioner@sjtu.edu.cn>
 <20260618082426.790315-2-functioner@sjtu.edu.cn>
User-Agent: mu4e 1.14.2-pre1; emacs 30.1
Date: Fri, 19 Jun 2026 15:47:33 +0100
Message-ID: <87y0gaege2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ziyang Zhang <functioner@sjtu.edu.cn> writes:

> The syscall return value passed back through the syscall filter
> callback is semantically signed: negative values encode errno codes.
> Declaring the sysret pointer as uint64_t * is therefore misleading and
> forces callers to launder the value through an unsigned temporary.
>
> Change the sysret pointer to int64_t * across the public plugin API
> typedef (qemu_plugin_vcpu_syscall_filter_cb_t), the internal
> qemu_plugin_vcpu_syscall_filter() prototypes and stub, its
> implementation in plugins/core.c, the linux-user caller, and the
> in-tree example plugins.
>
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

