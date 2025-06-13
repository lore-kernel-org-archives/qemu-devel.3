Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92314C61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 11:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ33T-0005xo-T1; Fri, 13 Jun 2025 07:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ33J-0005sn-Gy
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 07:58:36 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ33C-0006tc-OG
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 07:58:33 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-710fd2d0372so23390767b3.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 04:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749815899; x=1750420699; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06bdg0l26rn28k9vn8ghb+vBgTK6tLfHDh/fakpa2yw=;
 b=ntG+vYEejp3j3viE0t5I6UUVe6SsAxb31u1kZfLMDHkURaP+DrQeODYJbTXKXRlWZu
 FAjX5zRBrw2qRJX2elf2Vu7lf+RbHWREu9u+/ihhzTF8I1v+RV4YLNX/aIMvlm857+Xp
 VEuAmap7hTp18xdSYuzpGCPq8VYKRvbSSpQLIYA5Oa6fme1eFPfUJcweQTOvQby7Xz4d
 IGkhCFaxQZRZC0hSzLbzy+B2A0SvbpFUtXy0gDBmTnDF8ts1wZpTS5NT7cOpWvBytVfR
 NnKCPGTUSsscS7REciLD5MK33Azx7758oxfNuXPGD9oETuEaz7CBKu/krVv4zTnAIAfH
 eNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749815899; x=1750420699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06bdg0l26rn28k9vn8ghb+vBgTK6tLfHDh/fakpa2yw=;
 b=wGsbJxpvZpJlbJWx/PcAOBGYER0kqQBd20slUdYkOGLV8SeDIK9/Siw2IrGh6eSq2D
 2LglN0/5MC6MRioFbDLa79Pge1W2fcYMQo+mM3/zT0zl/haIm+LDzEyjr3hu9SBi0WUC
 ng3lRhK2JMNcMBEExVv2+iSiq5NC2N27HAvjkcfqeH30i+GQE/L+yAXgKRzgdHGQjMH1
 oOwxyNAt82sem5A0nsaGUe+jEwz0Rn/dPZ5duGdTKXb+rgwvQGxUAeynxyinDXq5QcgO
 h2QcNBAP5Qa6KqozOzW/2hlUE6L7H/ZqQA4lPFOo4bd6cIozu2ZwNYxZyqe3YZby2GCB
 3liQ==
X-Gm-Message-State: AOJu0Yx1iF5a+l8EgpvMk8+5aPdY+cNr3bWT9soNLk9DwLHFZSYs6zH5
 c6lFVQeKj9Pi+S8aDgivndyLbZAU/i/jO4+YMkbFfmUBqv9lrF2m9iQJDT8bUnRdK5TMNL8HfB+
 /FOxHfRrJITc4qKxwWNoxwHEhMWVawQUTzTw/BlADkA==
X-Gm-Gg: ASbGnctA16Umf2NC4RPwrmxStnvaD2QiLh2GV82WgX+yP2nF2/UChUXDU4Xuylpqi+N
 V03q5Kjgk63yPEmrKdjSTd/g9InPf8PtEFAXM5CDHzTIKsEwmxJaHt7x149nPfMxzCxWQQxaOec
 Pime4Vklc18R7aQWWI3uFD7lAbIhjG9sZ05kTovwSZlgJ2
X-Google-Smtp-Source: AGHT+IGfcYVrxDS+n0NJId/l3vTEmWnZjcmV0W+0MDY7lMGP1sJhFNQT+H/BF2nD1rDMfXIfcx6VwKXjxMdWPfQ8GQI=
X-Received: by 2002:a05:690c:7242:b0:703:b708:e15c with SMTP id
 00721157ae682-711725fed89mr5118627b3.13.1749815898847; Fri, 13 Jun 2025
 04:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250526085523.809003-1-chigot@adacore.com>
In-Reply-To: <20250526085523.809003-1-chigot@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 12:58:07 +0100
X-Gm-Features: AX0GCFucr0dj2qhX_l6JAHmBkVKcH2F5Ci89xShsAgZ_3F31NTiEw3dArLhnQMA
Message-ID: <CAFEAcA-2fnu9hsGirQ5FJGqtNktNX2X52UgQBu4yYN4WjeSVQg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] xlnx-zynqmp: add support to boot on RPUs
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, edgar.iglesias@gmail.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Mon, 26 May 2025 at 09:55, Cl=C3=A9ment Chigot <chigot@adacore.com> wrot=
e:
>
> This series enhances Xilinx ZynqMP support to allow booting on RPUs and
> ease gdb connections to them.
>
> It was validated with home-made binaries. FreeRTOS was tested but without
> success: outputs/IRQ seems broken. AFAICT, FreeRTOS is expecting Xilinx's
> QEMU thus I didn't investigate further, but I'd still like advice
> on the 3rd patch ("wire a second GIC") since it could be related to it.
>
> Changes since v1:
>  - add doc for "first-cpu-index" new property in arm_gic.h.
>
> Cl=C3=A9ment Chigot (2):
>   hw/arm: make cpu targeted by arm_load_kernel the primary CPU.
>   hw/arm/xlnx-zynqmp: adapt cluster-id based on the boot cpu
>
> Frederic Konrad (2):
>   hw/intc/arm_gic: introduce a first-cpu-index property
>   hw/arm/xlnx-zynqmp: wire a second GIC for the Cortex-R5

Hi; I've taken the first 2 patches in this series into
target-arm.next. I left some review comments on patch 3.
For patch 4, I still feel this is something that should
be dealt with at the gdb end (e.g. gdb should support
"connect to this target and connect to remote-inferior 2,
not inferior 1, and don't fall over just because you
don't know the architecture of inferior 1").

thanks
-- PMM

