Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4324C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAoG-00020Q-7q; Fri, 28 Jun 2024 08:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAoE-00020H-EK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:34:34 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAoD-0005Hc-26
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:34:34 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57d4ee2aaabso671852a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719578071; x=1720182871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pzd7mrp7BEmqBDcmjm1ZP0EpZd14wWVQOzDv+oX3G1w=;
 b=yyAK/girQoHkDnQc0mxux9fCHwVSFPIzd/eqxkv0dpd+Y1/Rgeo02jEKx6pm6/qCTw
 sANlSU6ifyq6Olcue/JrK7u7cIu09uT2ywfHl5AiSdmI/axiRvTPkDNhusWMjXSbNNXM
 ync8Gzws5qfBPwU8v6U5Sh2OVjYK5NcS2J5hfYl5q5Hxbp4mTn9UYithOdMLP/pnBnue
 SAD7QQ2BeFxTqz29JHdAymAcOw/7lI/oYaOP5cn/8hfE0v8JnpKbasyP5UijqH8MXFmH
 CUnMO1ZIw0EwuPLbShw7CGZz7gmD1exDjsp5WzjiUToaBpUuCzE37D9XZi45fLQjFKw1
 Mu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719578071; x=1720182871;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pzd7mrp7BEmqBDcmjm1ZP0EpZd14wWVQOzDv+oX3G1w=;
 b=fnId0bkaPDZRbu5WzQn6UdOCHXC8NqiGUewaQ1ymsB/VmRr8JBntWPCX7wYQCAS7X7
 DawugNIMko2Lwg0ZA5G1+R0DAfb5ynQPVb8IV/n87Yv3OfPassrSKhLa/IoOSGTGKyEV
 qkJtRNRNM6lOjUlcNS4z97arhOdfBTHuGisZ6uZzBeaYlHwvBsYHNxnRpczJ6motX8A5
 801vnY3p/BEuE+QmRDtKjJZavsEP//WYk7gTGQJP0mhkBkCmbMajPeLJ6jVKkPsdjCsJ
 r5uf4BeQwcw1SOgERe2gbRo36EHTO/LAzgSIifCAiKK72hhH9E04fTYi/xbvjHP6NasX
 DAzw==
X-Gm-Message-State: AOJu0Yx7M9r0wbMhaZ6mDNiRqhVl8NP1pIHBBpnlCFFzNMqz6I1xcI7S
 Z3ugHQAykPtChTAlWpjkQ83ylK4yTB3faeRfUarXtZd+clDGTj+qFKf+8fMI2Vc=
X-Google-Smtp-Source: AGHT+IGO3/fpUJ+Hf4xBvOrDSXcqHKclNZFnD0mz7xWDzVSvvD6oyKiU7z9Tt9KZOW2psnjzEEF9UA==
X-Received: by 2002:a05:6402:40cd:b0:582:ca34:31b1 with SMTP id
 4fb4d7f45d1cf-582ca343627mr7934819a12.16.1719578071284; 
 Fri, 28 Jun 2024 05:34:31 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5861324eb41sm983612a12.30.2024.06.28.05.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:34:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1FC5C5F7A1;
 Fri, 28 Jun 2024 13:34:30 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,
 richard.henderson@linaro.org,  peter.maydell@linaro.org
Subject: Re: [PATCH v6 00/11] Add MTE stubs for aarch64 user mode
In-Reply-To: <20240628050850.536447-1-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Fri, 28 Jun 2024 05:08:39 +0000")
References: <20240628050850.536447-1-gustavo.romero@linaro.org>
Date: Fri, 28 Jun 2024 13:34:30 +0100
Message-ID: <87msn5nt49.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

> This patchset adds the stubs necessary to support GDB memory tagging
> commands on QEMU aarch64 user mode.

Queued to gdbstub/next, thanks. I've manually fixed up the include
issues and moved the PR defines to avoid using prctl.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

