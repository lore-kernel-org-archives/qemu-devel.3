Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1B5CF856D
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 08:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swGvM-0000p7-Q5; Thu, 03 Oct 2024 04:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1swGsh-0000oD-9H
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 04:08:19 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1swGs6-0003QX-Tx
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 04:08:10 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso8413885e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 01:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727942795; x=1728547595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vvBKTO3dP+NrEQD+3clX7ZfukCYX41HRIF/EK8j55EU=;
 b=Kp5c+nIiD58vkxUMBo/XCaDxEI5CGLwsye5d3dRLXz6apxUMZevicGGkZ9FxA6qiJz
 U74C6DZxT0cqOIhL/ihrM/zzxjGyG14LE4nw+TsREbEyPxkJDf5cIfHqO4ex98+U9yrv
 1hqF4X5JSyhtE6vul49ARf31feygTOVptT/ihgPyGLRynEPereGstyQYVu4D6Y9bc9fX
 I1wBGrZXMuQ2p1Jon8aib98MOcp/mjRvXM1eYYOzlnspvn+4Jy+Lw3JlXLnowmsRelTH
 WIbGg3Ohp5LRex+PULWnA3Ng69QkF0PtC16t19Dww1TZT74j9pSaf2rCmyZ8AnK4tepp
 y6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727942795; x=1728547595;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vvBKTO3dP+NrEQD+3clX7ZfukCYX41HRIF/EK8j55EU=;
 b=WjYAws2nt9idl4e6F6TcA6ZoZGTIKMKt5QYNVMIrkiiwemj8jg1BBZ+f9/5wq+TN2L
 7V84rKg5yohJKRjZpJLqX5DkHJWvj+U78AZSbuUV9rEXlzWrobGuGqw97TY2YnD8deFl
 4DD8rYO/u3MPW/vxbIiuzhDggX4OUdLbliGHgOq6UY+CUFxY84eqgYUKIHo2w7y8j0Nc
 jgE7iwSqrKyyiI00+zCVlOqqFmK1r+N77iJboZBV7nytFrNPu8h3UyH65hdqFtDeSxtr
 rtf2hGGJrySg0LHtn/EojDun/cSjgYWbVAMQZV1KSyy7XjoKYN26sZzt8EmrYLjV5JlH
 JSLQ==
X-Gm-Message-State: AOJu0Yzh01jQ3DosZz4LuOA/d2DMTTh592Zyjg20ptUQwaPsmKAg81gQ
 u4Mjxcp6AMFecRvOAxWXDQhsNCnbb1JqhjKpmfuftTHZqmZYfC2p1RQBpfDEE8c=
X-Google-Smtp-Source: AGHT+IGbKlZmsIpMAvqQRIQbLdehGpnfEC1XO6nnn8XK2JCZ0OAr90xiHAjwG7CqYMw+iXS00j/XPg==
X-Received: by 2002:a05:600c:3b11:b0:42f:6878:a683 with SMTP id
 5b1f17b1804b1-42f777ef1a0mr59134725e9.22.1727942794771; 
 Thu, 03 Oct 2024 01:06:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f7a01f539sm38206725e9.31.2024.10.03.01.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 01:06:33 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7BB6A5F756;
 Thu,  3 Oct 2024 09:06:32 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org,  agraf@csgraf.de,  peter.maydell@linaro.org,
 pbonzini@redhat.com,  rad@semihalf.com,  quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org,  stefanha@redhat.com,  mst@redhat.com,
 slp@redhat.com,  richard.henderson@linaro.org,  eduardo@habkost.net,
 marcel.apfelbaum@gmail.com,  gaosong@loongson.cn,
 jiaxun.yang@flygoat.com,  chenhuacai@kernel.org,  kwolf@redhat.com,
 hreitz@redhat.com,  philmd@linaro.org,  shorne@gmail.com,
 palmer@dabbelt.com,  alistair.francis@wdc.com,  bmeng.cn@gmail.com,
 liwei1518@gmail.com,  dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com,  jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com,  berrange@redhat.com,
 akihiko.odaki@daynix.com,  qemu-arm@nongnu.org,  qemu-block@nongnu.org,
 qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 00/14] macOS PV Graphics and new vmapple machine type
In-Reply-To: <20240928085727.56883-1-phil@philjordan.eu> (Phil Dennis-Jordan's
 message of "Sat, 28 Sep 2024 10:57:13 +0200")
References: <20240928085727.56883-1-phil@philjordan.eu>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Thu, 03 Oct 2024 09:06:32 +0100
Message-ID: <871q0xmwzb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Phil Dennis-Jordan <phil@philjordan.eu> writes:

> (Apologies to anyone who has received more than one version of this
> series of emails; my git-send-email was misconfigured and this is
> a new attempt.)
>
> This patch set introduces a new ARM and macOS HVF specific machine type
> called "vmapple", as well as a family of display devices based on the
> ParavirtualizedGraphics.framework in macOS. One of the display adapter
> variants, apple-gfx-vmapple, is required for the new machine type, while
> apple-gfx-pci can be used to enable 3D graphics acceleration with x86-64
> macOS guest OSes.
>
<snip>
>
> There are currently a few limitations to this which aren't intrinsic,
> just imperfect emulation of the VZF, but it's good enough to be just
> about usable for some purposes:
>
>  * macOS 12 guests only. Versions 13+ currently fail during early boot.
>  * macOS 11+ arm64 hosts only, with hvf accel. (Perhaps some differences
>    between Apple M series CPUs and TCG's aarch64 implementation? macOS
>    hosts only because ParavirtualizedGraphics.framework is a black box
>    implementing most of the logic behind the apple-gfx device.)

We don't currently have TCG CPU models for the Apple Silicon processors.
They are not too hard to add (basically setting the correct ID register
bits, c.f. aarch64_neoverse_n1_initfn for an example). However that
would only cover Aarch64 architectural features. We do no modelling of
the extra instructions that Apple added (although in theory that should
only be run in Apples own ML libraries).


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

