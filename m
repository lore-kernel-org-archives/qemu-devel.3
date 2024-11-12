Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3379D597A4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 21:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAy1s-00083U-1a; Tue, 12 Nov 2024 16:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tAy1q-00083H-8S
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 16:02:26 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tAy1n-00027I-Gq
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 16:02:25 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4315abed18aso52652055e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 13:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731445341; x=1732050141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mAypGFTgU/oYJ9UIgnt91i56ebpSdUHwzcep5maFo0=;
 b=gY+2NDfL3P2VwCqGt/IqxGj8tQdYeagg0o1pUkhrDujbli5stAjDpC+AiJc5xmY4AD
 Pnk57RXOuyF2KxzI0ByYQuRX7vky4TmwuXOeSnJxDrUdG4QwpqPdd5FXPVZXEazLQuUH
 37HNtS6Sp61OQL96ejJB0uRDSMTQgxspV65siRm0C/5XyfbLn4/ksShHILceLOJr37lb
 DILHCScT2/tFTR120V3tgteIXSLXTtxmfBPbBQjpT1f6RuPxnSbKtWI+vVAcXpd4lkQU
 vQsv26pH6YdSw8oUxkBAMa2PKrbHkGwlQo9vFlcdPUtKWpbwdzeaGXNfXfkBqbxJPhIM
 7mgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731445341; x=1732050141;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6mAypGFTgU/oYJ9UIgnt91i56ebpSdUHwzcep5maFo0=;
 b=PmJtI7y6qtut+NM3+0xbe5+2hfcLwiKSlfQp8SmzKxL4AFsFvstaj7UQB+TE+DENMu
 Pg3zfjWJOD2B6DJlr8U3pD/QdGZdUOuH7pWKrByVecF7k0WNhb85LZbjOf0gw4+S7K3Z
 cwxSWxy9/evTn7zMq6gM3MxmlVoOqgpzUcaf7/rIxkJUOfsz2hQDmoIwsxvQ6pEAYwoL
 L4wXsWhHnn6kl/Iv2TseaD+rx0KiYogyo4yXBS4iJMCYWke3Rra7VEyrB+fAnfC3OBMS
 t87GCfuNZ/5ebVNg4j8Mu0ATEkxEy8Seow5b7zsU+0HEYHmMcqaYrS2jrdMvnQJp75T2
 kWgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXupMpAkPnKDdKfJIwj4i2j2cBWtHE51nDIfOcaGaWAuCGhKjf0SfRg03UuMApmWJ0OH1clvsD8ztEI@nongnu.org
X-Gm-Message-State: AOJu0YybVzFoKGTFFq0iV/yk7zWzTjJ1u0DTbQRu8HIKUoVmFFQq//eT
 irsngQVm0YmwTQ6oP9RtDm5TUDBGElkPPbMVC+hAEbnjurOT669JfKUcQlCFMrE=
X-Google-Smtp-Source: AGHT+IH7cjbjXpWngtj9/HjPqnXEFolC8o9oRwcHXEp9qNwcE8F9SSx/PgjLMEM+nu5ZgxehvQLZZQ==
X-Received: by 2002:a05:600c:4508:b0:431:50cb:2398 with SMTP id
 5b1f17b1804b1-432b74fecacmr149877385e9.2.1731445341500; 
 Tue, 12 Nov 2024 13:02:21 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda04ceasm16064719f8f.102.2024.11.12.13.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 13:02:20 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 350F25F7CB;
 Tue, 12 Nov 2024 21:02:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,  Gustavo Romero
 <gustavo.romero@linaro.org>
Subject: Re: [PATCH v2] tests/tcg: Stop using exit() in the gdbstub testcases
In-Reply-To: <20241022113939.19989-1-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Tue, 22 Oct 2024 13:37:11 +0200")
References: <20241022113939.19989-1-iii@linux.ibm.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 12 Nov 2024 21:02:20 +0000
Message-ID: <87cyj0upwj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> GDB 15 does not like exit() anymore:
>
>     (gdb) python exit(0)
>     Python Exception <class 'SystemExit'>: 0
>     Error occurred in Python: 0
>
> Use the GDB's own exit command, like it's already done in a couple
> places, everywhere. This is the same fix as commit 93a3048dcf45
> ("tests: Gently exit from GDB when tests complete"), but applied to
> more places.

Queued to maintainer/for-9.2, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

