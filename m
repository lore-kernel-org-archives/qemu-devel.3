Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48502C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 12:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH01c-0006tk-N7; Mon, 19 May 2025 08:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uH01a-0006sp-Lg
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:55:22 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uH01V-0000un-Tv
 for qemu-devel@nongnu.org; Mon, 19 May 2025 08:55:21 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a3681aedf8so1654941f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 05:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747659313; x=1748264113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cuPGGM3xklU+nOYz0hUiWBY1E2jdTVg1HnyCs01vxLk=;
 b=sDmiXJuehnpJ1hfIOYKWptjWJ+3beEbLB+qPk8+27MbaIHFfhqCjJqwCRuFHp+qumd
 pgWkR5uSNs+iYa0Fv+/3mR0CEovV1LnndgmsQbQNwyIqeIe836HWnukQk1PgHKTrDO7v
 qg59hQe6YrLVRVb+fxujlcuevvJiGe9Uib5t7cG1BwFHnCOKIN05KXBM2D1JcTx6c9De
 fOVIw2jPiZ4eZf4KLCBSTgIGM56UR1IXMCL79WbbLIX1C89JkynEN/cGVQHXvVHjuBPs
 zMsDzB/7sUjMJBUw8642Ym0RXwAGW9FEbNJH2TFpUeS17a8CyFM6LzriCouQCXixY4w5
 nNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747659313; x=1748264113;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cuPGGM3xklU+nOYz0hUiWBY1E2jdTVg1HnyCs01vxLk=;
 b=azOhyQCy/frN3/77BsqUk4hO7IuH/3RDXWgf2JQa3qqIGhiqqFmX2IV+RN+mCU2Z9W
 iDS+fRKlmanvquhRbKi2Gunv5oU1hTYoO8ei51ah4IXqRZA2pHIc9l5UFlMv8uFSSg6H
 o3GqklgqTYamYybzFmBv5r0+xeV+0ySNxH4A7SaeA3sGli8NTqFeG1G78X8w0xwLSii7
 0w+9KDSzv2hL0dVqAYy77k1e2JjLEWZ1l7SdKmf51uuvuhQR6TQ9BwJaXUC71mtL1HXS
 lliUtLDCwbZnD5zY4su59Ou0vrQgvNuIr/+rb+kOTMH6gOVfBHY3B5tfv13/TMCpickJ
 WsoA==
X-Gm-Message-State: AOJu0YzbmwWkt/ImUXvqHwKmgDM2i7QQycy8Kef0P0TqoG5i8COlEc1E
 ESz6uAnDsWypKXSFpy6wkFJk+EGww7OJs8DI2tUK8cmQEsojzw3ZmunMuP40ICirF1o=
X-Gm-Gg: ASbGncsAtTdyfLnojPJN0nfdEjq6zGUTAUxlXLNVl91r5KC9ldkG3It1BDgtR6Q9mXb
 6yk8MLBO1b535LBAK97XbpH71k3eU2FXemERCIzWkqWw3wg7y0TifuLI54b/aWN9Xr7w3Fps/lK
 wBki3QNb0sagu0CTw9Qhg0YPqnuHe4S5q3xrTnVrWSnaMHlVk/qzDnSiFndmysbFlxV4PyXLfOT
 ODxJywrMNYKP9LlK+ZwpCaA+yrhAHa3hG3iXlnoQ6rnyCG9zqTZvS6UGOMqq25ejT0F5SBbHteK
 Z8bH0shIuMwTWYHKVBz5LsVq+YFtvdOUQUtJaZ6EJgm2RYagmZW+
X-Google-Smtp-Source: AGHT+IHwhSHB9V9GlkjskLAInSN4ALgA45oKZsQqN9ZmROqMGJSMBhwZevy9p2NxFb2/EOshDM0UNg==
X-Received: by 2002:a05:6000:2281:b0:3a3:64b9:2ba7 with SMTP id
 ffacd0b85a97d-3a364b92cedmr7598511f8f.56.1747659313019; 
 Mon, 19 May 2025 05:55:13 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd515130sm135699655e9.18.2025.05.19.05.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 05:55:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 97E6A5F87C;
 Mon, 19 May 2025 13:55:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH] gdbstub: update aarch64-core.xml
In-Reply-To: <20250519-gdbstub-aarch64-pstate-xml-v1-1-b4dbe87fe7c6@linaro.org>
 (Manos Pitsidianakis's message of "Mon, 19 May 2025 14:01:47 +0300")
References: <20250519-gdbstub-aarch64-pstate-xml-v1-1-b4dbe87fe7c6@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 19 May 2025 13:55:11 +0100
Message-ID: <87msb8sqts.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Update aarch64-core.xml to include field definitions for PSTATE, which
> in gdb is modelled in the cpsr (current program status register)
> pseudo-register, named after the actual cpsr register in armv7.
>
> Defining the fields layout of the register allows easy inspection of for
> example, the current exception level (EL):
>
> For example. Before booting a Linux guest, EL=3D2, but after booting and
> Ctrl-C'ing in gdb, we get EL=3D0:
>
>   (gdb) info registers $cpsr
>   cpsr           0x20402009          [ SP EL=3D2 BTYPE=3D0 PAN C ]
>   (gdb) cont
>   Continuing.
>   ^C
>   Thread 2 received signal SIGINT, Interrupt.
>   0x0000ffffaaff286c in ?? ()
>   (gdb) info registers $cpsr
>   cpsr           0x20001000          [ EL=3D0 BTYPE=3D0 SSBS C ]
>
> The aarch64-core.xml has been updated to match exactly the version
> retrieved from upstream gdb, retrieved in 2025-05-19 from HEAD commit
> 9f4dc0b137c86f6ff2098cb1ab69442c69d6023d.
>
> https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dtree;h=3D9f4dc0b137c=
86f6ff2098cb1ab69442c69d6023d
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Queued to gdbstub/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

