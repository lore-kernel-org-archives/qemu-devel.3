Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A2BEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzpZ-0001yF-Qc; Tue, 10 Sep 2024 08:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1snzpT-0001x2-Vx
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:18:44 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1snzpR-0002QW-5o
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:18:43 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f74e468aa8so59400761fa.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 05:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725970713; x=1726575513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jWiYCPZ9HU9ov7/MxvTLRBGhdCUUW2rUUjjcfMpyqqQ=;
 b=NCxes9a5A7ThqPnnY+l3Af+QBgLuB1+WdZAyprO4L2/ARhcXOFbzjs2Hzedqhbi9/D
 c0WfGHebgI8oihR3Bw1nC8IS3zc7xvzAj70CbxsNZoBElPTu4toWOx0Ij6OWTmdLlHvX
 6dn2gQuJwRdtFS3PRQUZkkdq4kNYr1CULqYRRtNJFdFoNoXVB2ImJs0XtIXNt1LrOlH7
 EaM/AG4r5pQ6srgTO24lzwKRxPRAR7brakgofQs4QHamPG8Tiv2RnJTNQY3B8P005WTD
 OKR98r7CEXRdoViy3J7IgazeFjCdogUxpTzxl8sppfvkC1pM4FlHBGZRC87Gu1qfc53g
 3q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725970713; x=1726575513;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jWiYCPZ9HU9ov7/MxvTLRBGhdCUUW2rUUjjcfMpyqqQ=;
 b=PZi1UH6fAZvVDDDt/BiOj/zwAOwavikYSR8kcWVCZL0PGuaxLKeBnLueaDacq4yFIk
 bggv1eZ1awZHyW2wMXqdOc1s3nBNdrITPPj0FsK+2k7g6k8iD27PHMLMQJbi6XsROoju
 I7WTlWlE3Yg50BfPnbB+L+LX8BHsLuxgJaqjAU748BeqY1YkZrEfN5hrMJGrcCwD+IcM
 YorHlv5aURwOeK12gRCa4rHaTQmk9Pr3S96qANB4zkTX1FWKcDtEVs9XvmTSPgyvO4O8
 F+N2g8lhaLI/P5fgiKkcKN0k++H2aZQISJ8Y0eOUOuBQF6LF3fekam+wGIJia1/mBhcb
 CBhQ==
X-Gm-Message-State: AOJu0YwcOVKQHyncfyph9njjK01HCRWytagh486cKsrISu5hR8kxDLyJ
 8x2gL+aExnWocVOg4S4dWHUtHcD0wZuOgNrXG5NRlv+WGEeXVVd2FmE0ABt4RYE=
X-Google-Smtp-Source: AGHT+IEvr55LTatmrMDZpWtF1DdVpdvPwZl6i0wzXnUl0g5ov/cExvloXjcXcVqscoJE1jJpcE7Ltw==
X-Received: by 2002:a2e:be1b:0:b0:2f5:1fa7:ac7d with SMTP id
 38308e7fff4ca-2f752495fdbmr79052941fa.37.1725970712466; 
 Tue, 10 Sep 2024 05:18:32 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41ba7sm4222530a12.4.2024.09.10.05.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 05:18:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E22665F762;
 Tue, 10 Sep 2024 13:18:30 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,
 richard.henderson@linaro.org,  peter.maydell@linaro.org
Subject: Re: [PATCH v4 0/5] gdbstub: Add support for MTE in system mode
In-Reply-To: <20240906143316.657436-1-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Fri, 6 Sep 2024 14:33:11 +0000")
References: <20240906143316.657436-1-gustavo.romero@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Tue, 10 Sep 2024 13:18:30 +0100
Message-ID: <87seu7wvl5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x230.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> This patchset makes handle_q_memtag, handle_q_isaddresstagged, and
> handle_Q_memtag stubs build for system mode, allowing all GDB
> 'memory-tag' subcommands to work with QEMU gdbstub on aarch64 system
> mode, resolving:
>
> https://gitlab.com/qemu-project/qemu/-/issues/620

Queued to gdbstub/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

