Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40680C0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYjkC-0006T2-9C; Fri, 17 Jan 2025 05:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYjk7-0006PS-RQ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:38:25 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYjk6-0006FV-At
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:38:23 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaf6b1a5f2bso596708066b.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 02:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737110300; x=1737715100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dA4cABuQ7O+G2L4wqAZH5Yk7B1njb+jBnA7h7zxdLc0=;
 b=gu8VNU2nGT+879hPnaBGYD9v1UQ1ZJpmDV9/HZo8mbpchPNqxHVzZH85VI7rAKxzGu
 1KB5CHCSZOIoThnuEAMfd7Vn7nPcE/zQT/S1X2lY8whuPPde2k9vSCCZuSDqNUCJl64M
 qPGKSeNUMnGoIBORZ0L1NjnY84vKI+Pwc4jV1iY0Qjyo24xbtK9TrNwFwifdjjFVdTE9
 zTXnyKc0L1JcdIfEhPKEUwrrBlsfX+uzouU72g5BCC5iHNOlpDFY5PsStJpbjQsTGEjL
 abLgR6U3xGay8aImVjEGHfy+lgWDUXf7If7zFL7rhvcORSQmCkTsSdg2OVniaPcuXpPR
 CwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737110300; x=1737715100;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dA4cABuQ7O+G2L4wqAZH5Yk7B1njb+jBnA7h7zxdLc0=;
 b=c4eOguoaXuO+VNqNRGohrK5u+/L0i6FYlIRPv6tE8TjOrwR5KMiCVYvCMbD6x/jKgU
 5qCyAQt9IlCCOlPR+a6ywkePNg6jHJpwotb5kJ+lkPqmsnpxdDHWgUhP8bPtAGCVLyX9
 6/Et2eNwW65q7LX16Xu6KO5z8tQoPoL2wQ6Nbbp9UVcg+N6+gYx5R73/ZiSo9p1fkK6k
 YMJ7xCivOlLazL5hjoOIk0j/+JwzeNRhvQV/ve8jkTcBR1CEmBBmfe1ZeriiAB5UTdsd
 A/HvNvtYqqPws5n+qwz1e7E87VQLh2PHI1YmKEfbbTf8Gh6vV3X0CS9l4XTNuvF7v9As
 115A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUskNiAoIcHaPEdGMB1OH4leqaAypYlu2fH9eSLWfbABj4ew7ezfkyIwLxUUvkCYEM0onDI/SlP6xpr@nongnu.org
X-Gm-Message-State: AOJu0Yyl3syeIIXjA0O0+e0mqvwNEp/Sm9LoatjsIonbfKORqbUpm+Ot
 jM4N9QxsGT/aCA+2qqnlGghhVJ0VpEv5xYdF/aiX1bEA0BHC8trxJ7Kj44NjOPc=
X-Gm-Gg: ASbGncv55TF4XArG9HnM9CICEJPqPofGeNhnG8OyS7bQRsGL2oC9P9ELAoJ/eYjrxQQ
 kmzEe4fq5PuVTyLAAX5iVD08DWjDZM8CU/QaOp2stQyB8mbBDji3QW5glM6BDlCw5Ws+n8Y6RR3
 GhTzmfBAJ1rBA2nBtAwfLDnbyDD3pfgBqI+rYnHTH9g5mHXQ3IIEuLRxQZ/yuk4+FHLw0Tvg2ug
 +WjNkCH4mv+J5d4xfp7YTJudYGHPV+ldc1fUmWRoSGh74xl1qCDwFc=
X-Google-Smtp-Source: AGHT+IGXgDFRNs9z6PqN/p7CZqgDgbhAKhdlLrOza7NKJNlUe1L+MTg6HmNN2PJJujI5g68DfaKvCg==
X-Received: by 2002:a17:907:9729:b0:aa6:9d09:b17b with SMTP id
 a640c23a62f3a-ab36e49ef53mr464378166b.28.1737110300322; 
 Fri, 17 Jan 2025 02:38:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73edccd4sm1293037a12.77.2025.01.17.02.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 02:38:19 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 396E56083E;
 Fri, 17 Jan 2025 10:38:19 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,  Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] accel/tcg: Call tcg_tb_insert() for one-insn TBs
In-Reply-To: <20250116213214.5695-2-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Thu, 16 Jan 2025 22:31:33 +0100")
References: <20250116213214.5695-1-iii@linux.ibm.com>
 <20250116213214.5695-2-iii@linux.ibm.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 17 Jan 2025 10:38:19 +0000
Message-ID: <87a5bphgis.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

> Currently one-insn TBs created from I/O memory are not added to
> region_trees. Therefore, when they generate exceptions, they are not
> handled by cpu_restore_state_from_tb().
>
> For x86 this is not a problem, because x86_restore_state_to_opc() only
> restores pc and cc, which already have the correct values if the first
> TB instruction causes an exception. However, on several other
> architectures, restore_state_to_opc() is not stricly limited to state
> restoration and affects some exception-related registers, where guests
> can notice incorrect values, for example:
>
> - arm's exception.syndrome;
> - hppa's unwind_breg;
> - riscv's excp_uw2;
> - s390x's int_pgm_ilen.
>
> Fix by always calling tcg_tb_insert(). This may increase the size of
> region_trees, but tcg_region_reset_all() clears it once code_gen_buffer
> fills up, so it will not grow uncontrollably.
>
> Do not call tb_link_page(), which would add such TBs to the QHT, to
> prevent tb_lookup() from finding them. These TBs are single-use, since
> subsequent reads from I/O memory may return different values; they are
> not removed from code_gen_buffer only in order to keep things simple.
>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

