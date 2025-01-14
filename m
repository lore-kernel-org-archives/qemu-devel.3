Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81916E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXf3Y-0002DN-En; Tue, 14 Jan 2025 06:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXf3K-0002AB-Hh
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:25:48 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXf3H-0003fC-RE
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:25:46 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso36926795e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736853942; x=1737458742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=djprjdiDqspsX8wn/1ny8XGbs6DP6kUUIR1JL9po5/0=;
 b=v9UU0zO0uIYcodJklXclwPHV5Qo0r2e1o+hwX9pj1xi3rluUlZDQBULockUCWRO4YL
 z3Hz991dkAta98kiQsrqSkO4R7JuJHzgFJyrBXBOrXeohHsPPoXxQL6o2Ra4HLRjqy4k
 x+pyFPFpfyLKoCi0mHSd4p4DLGNfeGNd0N+BBLryXC0G39+oP8o8e0H6HgTt65tWAsNm
 Nnw0zqFT9PfnHH3EEbl9PNpPQ3BDb280dfK6PMFCOCLKIcfwhfylNN8TyxIx8zOxCBmy
 M5eEdfUGPH4XVUpvu/rJAu1ui29L5/hhF/vHxsENF97DT3qwmb+N7K3L2TiyCpXlQSMw
 t0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736853942; x=1737458742;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=djprjdiDqspsX8wn/1ny8XGbs6DP6kUUIR1JL9po5/0=;
 b=qCslIVmwFm1f2wqJtdyIUSghfZPaASnqpXnFlhv/YTGg4pPcDKe3d71Ph81VT5ArOp
 gUWldZk2oPBHJ2QKE+ZyoF0j++HwCBRjwDNxjzucKX2HvCtTKHMCLPkuZupJnlDqyvw3
 HeMbNMDF8Imue9/G1639Mtu8IQehsOIUR1gZYX1EpRcGlVNYnydf8pSQjuOUaI+TojAD
 BFe6naWyCh4CrjL3T5ejbhbpF4Yx8W4HvNGmTbUrBeUjkoc4p0YF91TvjKYExxEzLhWb
 im0AEeosqrytdCBcPTy0y9L7DA2+xrPu3kSvO3sLBrrD7M0rgHlTuzpvHMXsz1aPlfNY
 yoOA==
X-Gm-Message-State: AOJu0Yyv8M3bmhFZwaUCjmJfUtpgULKFm/awS5GXtXW4NfKmPbTB6qG7
 QV+iMYXrE0+t+ihhG06bKRa3xxHFN6q/3WMVMTZ+TTgMY6f2nSa/AwxHcD8APWc=
X-Gm-Gg: ASbGncsF/Ve/Uompv+TvyjakkrMczeHpsha+BckLk+R3PbVc0u6fvOxwdGfSYGH7IQE
 QZry5aDXHl5Nof8FeLpOenxN9DcoPVc4r0ec7L+bSL79d9gmlvPYvuNGppEEkvNQC2Mwl1Lzv8v
 y7DpJxD3mZfeVHCqXNOwAnE8pI0Ky/FQvQcrduRjf8+5eufSAfzNqXmceir31jjLfmI66P9KBLy
 zB4CcNbLezaKM2Z9ntflTu5VlD/75HF0A1zIgkVBDctF2MO69jhGuI=
X-Google-Smtp-Source: AGHT+IFwxCpnCKkVx0D8vHgGEu7IZuMFQqAkf0a/9xkpehDd7ft+m7VnMZWXq/JAHBxU9iv9Vm6TAQ==
X-Received: by 2002:a05:600c:314b:b0:436:5fc9:30ba with SMTP id
 5b1f17b1804b1-436e26ebb6fmr109211025e9.29.1736853941795; 
 Tue, 14 Jan 2025 03:25:41 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e8bea5sm205895255e9.31.2025.01.14.03.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:25:41 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 580185F89C;
 Tue, 14 Jan 2025 11:25:40 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  manos.pitsidianakis@linaro.org,  Andrew
 Melnychenko <andrew@daynix.com>,  Thomas Huth <thuth@redhat.com>,  Michael
 Roth <michael.roth@amd.com>,  qemu-block@nongnu.org,  Jason Wang
 <jasowang@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Yuri
 Benditovich <yuri.benditovich@daynix.com>,  Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  philmd@linaro.org,  Fabiano Rosas
 <farosas@suse.de>,  Konstantin Kostiuk <kkostiuk@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Markus Armbruster
 <armbru@redhat.com>,  gustavo.romero@linaro.org,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 0/6] Enhance documentation for new developers
In-Reply-To: <20241209183104.365796-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Mon, 9 Dec 2024 10:30:58 -0800")
References: <20241209183104.365796-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 14 Jan 2025 11:25:40 +0000
Message-ID: <878qrdk56z.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This series extends our documentation with new pages to help developers
> onboarding on QEMU. It focuses on providing a big picture of QEMU (to a
> modest extend).
>
<snip>
>
> Pierrick Bouvier (6):
>   docs/devel: remove dead video link for sourcehut submit process

This was already merged.

>   docs/devel: add git-publish for patch submitting
>   docs/devel: add b4 for patch retrieval
>   docs/devel: add information on how to setup build environments
>   docs: add a codebase section
>   docs: add a glossary

Queued to maintainer/jan-2025 and docs/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

