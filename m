Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB0BC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 13:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUoF0-0007ET-4X; Tue, 30 Jan 2024 08:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUoEz-0007Dn-0K
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:33:29 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUoEx-00066s-02
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:33:28 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3394bec856fso2858026f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 05:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706621605; x=1707226405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzVHIGI4arE+MRQ0dv5WNEvXMHxRV5RUONYa4znsl6U=;
 b=ZPPIw8jVh7ckVAuX7w6gd1fRAXuQjYfezQo/uah2YjA/hGfQ/0ZB6Ii3uDemlmijZm
 JX8yXT4NWUqX1rwEP+qxHp5+/+B9wtmEFyUI9B+UKlx6u1M9Sj4pLFD20cXwPYm9lrnZ
 U+mkGPFVrWh0mVouWCnxgrBzDRZrK8N41pIyJ4uJVJtXVsDirAIpnuT+aZlZhOhqQ+Ax
 6XAzV4Vj5uVcMI99NQyPafEgFr1hgJOXq7x3T0ilUDck2XDKumgoKFXzq9U3nmmUpR1R
 3UypBjqoUD3mWxWRAuhBt6KAHPeo5K72zLxqXSvJllJ5z1SLPMGUgaVTQxtbeZRDZ+Ky
 FcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706621605; x=1707226405;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gzVHIGI4arE+MRQ0dv5WNEvXMHxRV5RUONYa4znsl6U=;
 b=JfIYNTsG4nmRxngnryKElrcX0GxA5yIiqg0lLMzuUxJE7D4urT9qIvWzJ7L7ghHP+W
 hAOJZVD5L9mY56Nk84HmdF+3NPxj42qVt+XdZppqlChCLfPOl2MTfTTriPMTdpfebDne
 l9mtbSiEFHys0OqDouVVmNfX5Bp3hj5rLrKlzHG/cdgAwoEehqHgXeqIU4H6UqBgzhA4
 aDkbcXxrgq5cbatHObedWUdg1LXsqVMs4/HXdnRSMwBAB1SKWT3okzjxJkT4b3fMQ0Zk
 zkruHEelZTAdw1cJROez1bijmT/rAlxt3vjOq4Q8yuK4wwp+1aoVD8fKnGkSd4Ll+Cm+
 AA6A==
X-Gm-Message-State: AOJu0Yxhf7x8Rj/Oehy76vnMtYEqq1A8JcUlts+3y9OTt2y8cSFM9r6B
 lfXyBsuUL5wGb3poK9dbnyPWyW7hOz86K6RrKKeFO/pD0e88v2Fsrex56vaehBU=
X-Google-Smtp-Source: AGHT+IGnAR1yW1nNoYUZ4dKcpx6swDZCPLIZETIzHENmsVHscB3o3a2inAeLpEuL6FQGXKsOudORRA==
X-Received: by 2002:a5d:4a4b:0:b0:33a:e2d8:aceb with SMTP id
 v11-20020a5d4a4b000000b0033ae2d8acebmr1373843wrs.9.1706621605453; 
 Tue, 30 Jan 2024 05:33:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d15-20020adfa34f000000b0033ae9f1fb82sm6497820wrb.48.2024.01.30.05.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 05:33:24 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 700815F9D3;
 Tue, 30 Jan 2024 13:33:23 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  David Hildenbrand <david@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: [PATCH v4 2/3] tests/tcg: Factor out gdbstub test functions
In-Reply-To: <20240129093410.3151-3-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Mon, 29 Jan 2024 10:32:15 +0100")
References: <20240129093410.3151-1-iii@linux.ibm.com>
 <20240129093410.3151-3-iii@linux.ibm.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Tue, 30 Jan 2024 13:33:23 +0000
Message-ID: <87il3bosik.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> Both the report() function as well as the initial gdbstub test sequence
> are copy-pasted into ~10 files with slight modifications. This
> indicates that they are indeed generic, so factor them out. While
> at it, add a few newlines to make the formatting closer to PEP-8.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

