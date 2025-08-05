Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB082C87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 10:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujEuU-0008MJ-6v; Tue, 05 Aug 2025 06:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujEuS-0008Kr-PC
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 06:28:44 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujEuR-0008Oc-3i
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 06:28:44 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b792b0b829so4215383f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 03:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754389721; x=1754994521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TcBKZd9bBK9lnvhZMdjEDwyGW8HfM6EGtB0NMF0rDZo=;
 b=oUvGljxOtEwORmkfreafJ3uZo2VCuKo2APz2VgBFQ3xsjbK8fbmwy0FMudlCNS0WbP
 SG9/odVle5ZU0ME58OUTjLwsApkNKUivbgnKeP5dUXYbbBwwLY7BYSfZThqrqkSnkxTf
 V4rUlTMubZoolK3ipypxhuFLdnhNVfi5zi6HJdlgOvwTd9hNcCu9uRIEkMNyRh8wybr/
 Yzz5qSLCtqQBDpaZH7cXBTAyYFs4RLnUTaR4Ky69ZnPf21vH4b7YUmIK9L+YAFeboir+
 aq4kcuMZUFI0A6833q6G7IsFYeIh17yTeZDMR1JPdWJWln0BFzxoZ9XrYVr6eVvoSHM/
 rDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754389721; x=1754994521;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TcBKZd9bBK9lnvhZMdjEDwyGW8HfM6EGtB0NMF0rDZo=;
 b=Nr9CdTNwE9qATBqeJEUKk5cmLDC1Wy+sK0PDIfnkV0QeJW8RVoA1z0VPe+7d3nr2vy
 Z3z2tGkxyRRH4tPlt8XkzMSUdue43lAWxHlbZS1hZ6WNwlHoaKhjZEotOFBsGX3zbRqM
 O20gq10vQtU+nz9WAWhuzr4qpQfL9vKQTkxgHLe/gcFrrtyWbk8pJ9fdbHDZBfsb28/R
 E99nrv7OHGOM3yqf/vABwkG+2yE9LX+nxYjm6zBgl8xoHDOOzXhKEmzRWOu6ezGtIOrz
 wKXN4JYoWJdcirCVhkkWdltH49CFPpIlgvPeCnJb5nvQyrPSJk0Jz04kjWzmaXVU5+/J
 c/fA==
X-Gm-Message-State: AOJu0YzERtmI4pXWg1vxTyhuo0JkxzdZWtcVZfMbcMUivVjOCk/4vprZ
 X6Z0qnT50kDz/1w3N4se3d5KjVKvqW2OEQgPP9HDLjRJQEmWFq7DxGeS4g/wuJ4zV4M=
X-Gm-Gg: ASbGncsXmGGjKNhC6d5/dpstjuGvp9U9hiXHWA2O7LK0r5H2mp9x0VZFCgeqlFGf91d
 OGctVwEO4mMynPnDOsWn9U8AVj4LdoT29uofGqMs5bdhohZl2vZ/48RkOxFiWd3AQ1lSdLR24Gr
 XaRzmyivN5VZ+DUbXhhX4WvBbbujYh9CUd55XBd4m2gvXRNoEN74uUy/1Vg7WuQOlKX8aD2gYhc
 jdob6LWibAE8cVMxEbqghrQk/+cz3uLbNWsutRpYJOn7vm7Ad9DAkCGddW2l1sxByN9Mph7jjNI
 hyUTycWFrdhk6rsrw+sSnh64BfegTYQ+rLOqdRo86MCIDgNSUHzYPVasiiPFXKfqIH1DlSsCpAz
 kjawq8ieZzgv0Ot+62Bdsg/0=
X-Google-Smtp-Source: AGHT+IFv8aH/KGdH9yiYB+STQMc5YpAW39oQim1r2IiQ8DH8j5pfd5ybXKZWRjWE2k3Khp5Wf9/nzw==
X-Received: by 2002:a5d:5f82:0:b0:3b4:990a:e6 with SMTP id
 ffacd0b85a97d-3b8d940d4c2mr9095170f8f.0.1754389720884; 
 Tue, 05 Aug 2025 03:28:40 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458bc1f62e7sm127537625e9.2.2025.08.05.03.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 03:28:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5456C5F7E9;
 Tue, 05 Aug 2025 11:28:39 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 rowan Hart <rowanbhart@gmail.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 5/7] contrib/plugins/uftrace_symbols.py
In-Reply-To: <20250724204527.3175839-6-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 24 Jul 2025 13:45:24 -0700")
References: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
 <20250724204527.3175839-6-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 05 Aug 2025 11:28:39 +0100
Message-ID: <87plda3vvs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> usage:  contrib/plugins/uftrace_symbols.py \
>         --prefix-symbols \
>         arm-trusted-firmware/build/qemu/debug/bl1/bl1.elf \
>         arm-trusted-firmware/build/qemu/debug/bl2/bl2.elf \
>         arm-trusted-firmware/build/qemu/debug/bl31/bl31.elf \
>         u-boot/u-boot:0x60000000 \
>         u-boot/u-boot.relocated:0x000000023f6b6000 \
>         linux/vmlinux
>
> Will generate symbols and memory mapping files for uftrace, allowing to
> have an enhanced trace, instead of raw addresses.
>
> It takes a collection of elf files, and automatically find all their
> symbols, and generate an ordered memory map based on that.
>
> This script uses the python (native) pyelftools module.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

