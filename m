Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE79C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 14:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH1wT-00062l-CX; Mon, 19 May 2025 10:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH1wR-00060N-5x
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:58:11 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH1wP-0001fv-AV
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:58:10 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-70c7b8794faso44071517b3.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747666687; x=1748271487; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q47yyg4oDVwxnY52rN/cVcs8y/X6eSpHam9rzR7KJ+M=;
 b=jwn0ggUmcXmjxMo3e4GABKVHDYyr0yy7K6SNm+eKF/NAaEpuQN6SJYvsoVKquan/aO
 LBdRwZyG+W9qQhAtcI/2D5ANzWpfRpE9d0m9zEGA6CuP8UE1ilfKHBkuAFDG+OA1NZXZ
 aJ0Z720pN4ocTF5Zn5Paie0B04yuFceSCaAEY74fW+L/7eoq1jAgsCScLxDBh0ZyUQkN
 OAPHDdXohwtPmpHNbcbota04K2NwICnojBOu7Z7fvwF4KdmxWtQQQxTEha2Hq7plqgyO
 1HRtF87mwQh/ftBr4uXVuQ5RtTuyB7lSQ8m75e8J9KrpKwXoJ24EluUfjsifJWvq2KpK
 ce2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747666687; x=1748271487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q47yyg4oDVwxnY52rN/cVcs8y/X6eSpHam9rzR7KJ+M=;
 b=BN2QHrS/59gGB5eD8lfjwgcIx/1ZgNzO6B5AmYeWuRYUExmgMIGo8hoAtg8bIjSYxU
 TNo4O//Or2CVu0nCUg8Dts9kIufrYboKji5af/y8eL4y/Qi3ANulHRLeT8ghiEO0vdNJ
 hGdLa0diSBr6ZpYkMJSijWjQSuLyq9BEXvzWdj4iAfZ0rDycLMTtCLjwzg+b/o/kKhGF
 bm+6QNmqNrXTmSNubRrkgLVS1XFX/jL1uAzEWcXnD+SDeKbwJGZmKLe4J62iAGtHM2iI
 zAhTWQvfl28H8oQSRbqs8/Wj3iHWAbv2OGxCzYUqn8yBmfgpwIuCUEXKKoKE/DlC9X7M
 uUpw==
X-Gm-Message-State: AOJu0YwzO3uf26WrEAv4R/yE3MpM1XTQPmJCAhiDNYGsuvLxix/fZVNa
 mojoY+t8wE9rr7EDDUyc/L+bKonGgYsZoCpicqOSbosqjnAThaenqt2kvP/LvxMa7pLYoz4tnT6
 0b1ohExzu9vd56UJhmx8q285zHMWqRuBTC05v5K/C8tVSrd/qBBam
X-Gm-Gg: ASbGnctWWz/LqFAXNrt36LqXvz65GzM3mRULzeurd7K1JYVmPY6n0V5NVHKfcsChqlZ
 PqMGEdctRNsdWwLhYwnUUMjG2GXnma9byQCHk0MyP1rAEBo5vXa1QCTHcYn9XZ24fhvpwTCX7rc
 YCSZ3h8wQwtyHBDvDxqDjA1bNA/M4VZAIrMQ==
X-Google-Smtp-Source: AGHT+IH9UU6WRsgLht4fFJ7fpc1ROIwcJzb5WQIV7zxUg2BA8OWnDD9TEtaioaPrBawf3O8IXvylvNgFNd0aPvOATEc=
X-Received: by 2002:a05:690c:560d:b0:70c:ae79:255d with SMTP id
 00721157ae682-70cae793035mr109872007b3.8.1747666686851; Mon, 19 May 2025
 07:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250513141448.297946-1-chigot@adacore.com>
 <20250513141448.297946-2-chigot@adacore.com>
In-Reply-To: <20250513141448.297946-2-chigot@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 15:57:55 +0100
X-Gm-Features: AX0GCFsf44bnVX2Sb__McfKp3vLQnJsSU3p3xxaeNK3yRm09X_jaS_06gk5-Cy0
Message-ID: <CAFEAcA_MkhLZcqWJCJhCQfinJK1DHM-cHs1-sa-Sr2YgQyq5Vg@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/arm: make cpu targeted by arm_load_kernel the
 primary CPU.
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, edgar.iglesias@gmail.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 13 May 2025 at 15:15, Cl=C3=A9ment Chigot <chigot@adacore.com> wrot=
e:
>
> Currently, arm booting processus assumes that the first_cpu is the CPU

"the arm booting process"

> that will boot: `arm_load_kernel` is powering off all but the `first_cpu`=
;
> `do_cpu_reset` is setting the loader address only for this `first_cpu`.
>
> For most of the boards, this isn't an issue as the kernel is loaded and
> booted on the first CPU anyway. However, for zynqmp, the option
> "boot-cpu" allows to choose any CPUs.
>
> Create a new arm_boot_info entry `primary_cpu` recording which CPU will
> be boot first. This one is set when `arm_boot_kernel` is called.
>
> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>

Yeah, this makes sense, and every board currently passes
in the first CPU object so this isn't a behaviour change.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

