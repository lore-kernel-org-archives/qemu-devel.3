Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC200C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNxR-0000EV-5n; Fri, 26 Jan 2024 10:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rTNxP-0000E1-8L
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:17:27 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rTNxN-0002z4-Ib
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:17:27 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e60e135a7so5403015e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 07:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706282244; x=1706887044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bq2z33z5DSeMW5IsANON1BbdGUbhwXA9KER9nVj2bpY=;
 b=s27FAqZd5gXFHR9QyjscZk1WHhmDApP8QVm9TXyB1D/45LPz1LxylCs1nfUEh8JspJ
 +ZHOFdyHW000OFg+1ECjBFbJ3fbIFqHzpRJClrumUbU7bbK5ESW0cFLaBPKGEsh6aA3y
 MKG2f/9JauIoWdxMiKHPnYEMcZQ1jdVNxsvBeMzaF9R+A5GeVyemh/kePH9HHDvnfM1S
 86tuoCChMZhHYvxYkgMvjTxmGzYKoyW1Mx9WOH2KkdnkUS6SCVVpe0AEUD8xaOt3xnK/
 cOpf7KZciBSR3lS09Tjwb5iwFOQeiNWDM8EoG+B6UW3vL1tIpZ0zEsDMYveumQcSV4Jn
 r+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706282244; x=1706887044;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bq2z33z5DSeMW5IsANON1BbdGUbhwXA9KER9nVj2bpY=;
 b=Lpy2yxK6MmGxxw9nY+t15cpIwcfhaxfwcd/pldB1FcMacbqu1DlbkYarxqkq5is+Oa
 HvxHdip6363jI8rZDQyvGezAqfdKUgaEbeCrd5TL6YZky9GKJ2zXvK31qZpFMcNwhW9s
 Fw1sui2gcbuE6Vmc3DFDvudBdI/OV7uv1lrayusZqu3GjibLn87ahvJP1jKfipyWSqjA
 pqkPZLQLGfnozxAy8MIHng8XTBFqCaQs1dmwEDZLeJWgI/HLOpa2X7FkWfsTIcutTdi0
 p6ePDPeQPJpIL2SoWdKcCSBBJ4SN9z+r3EbHrCcEiPQdbVd5kmXTcMxYQrGfqCNR3vV8
 6P0Q==
X-Gm-Message-State: AOJu0Yy+AiONqlHygiXMmyp4h3JgLzOFaPh2Wx1Uo524VluFjtGcZD4w
 L/G/bJFenDSoL3TFG2ibjZwn1cotVvCmWxOtWbwMGqmXQ9Sh9Bwi005v7kb2c9U=
X-Google-Smtp-Source: AGHT+IHWNHN7lBJwY4bjorgZpSo2i8pPFvkQCPw/Bb5nliX7qlxYbNJ5QzG+Jh4OUuA9kqKq+9rSsw==
X-Received: by 2002:adf:cc88:0:b0:339:35a4:7ca9 with SMTP id
 p8-20020adfcc88000000b0033935a47ca9mr1801496wrj.31.1706282243849; 
 Fri, 26 Jan 2024 07:17:23 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o8-20020a5d6708000000b0033927ccc725sm1462002wru.50.2024.01.26.07.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 07:17:23 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 341A55F78A;
 Fri, 26 Jan 2024 15:17:23 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH v2 04/14] plugins: add inline operation per vcpu
In-Reply-To: <20240118032400.3762658-5-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 18 Jan 2024 07:23:49 +0400")
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
 <20240118032400.3762658-5-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 26 Jan 2024 15:17:23 +0000
Message-ID: <87a5osrunw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Extends API with three new functions:
> qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline_per_vcpu().
>
> Those functions takes a qemu_plugin_u64_t as input.
>
> This allows to have a thread-safe and type-safe version of inline
> operations.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

