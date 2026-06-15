Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71364CD98C7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ4zM-00046G-5I; Mon, 15 Jun 2026 06:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wZ4zJ-00045f-NQ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:56:17 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wZ4zI-0003Jp-2B
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:56:17 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso28396775e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 03:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781520974; x=1782125774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BlpeBgIASY+9tAhOV1MNVpKTHhND3x1qs7SH/yICdUU=;
 b=wRc/nqFjJmQ5ss0oHejt0zlGZ58src1JnDFjP8Z5FrLO22vln2Wi97IjoMDBjA/XVU
 Domh40GAnDqGKYtUBLk9UyUtr53UDrJKgsV0bqwETRftx/BBn2R3YCUkKLPpZ7zkdsiV
 FT+e7maU5AykfcyfkhC4kk5gw1YoYJB/k8YKgp1cchwn3tDwDAaIaKvNNv0kJhLxT4ju
 uv6JI2iAKYjQj9u6rcpvfw80WiCmjDsmM90eToaG4ULXF/gmUDasy+mTEEZmxDfmTEK7
 ezXx+ox55T9gwWqDGtTVVNR3R0R54K4X6cxoP83hzC5clznanRS8BJQWkegAf3nge1cQ
 M4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781520974; x=1782125774;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BlpeBgIASY+9tAhOV1MNVpKTHhND3x1qs7SH/yICdUU=;
 b=Goe5Su5SsZM1PL3Q86qgiEGXu4d9rqXGz/VOvxOg8nnStY4JLdpBbIReLvqxQeoAgO
 xU3CZLTATayzfv5wwJ1fKXyDgtYnUqKvpNLvUtQiM49IT6GE2uhfgI0UM9juzL+qeL7A
 r5CTmQRMfv4D98BBLobcI+ojuCFZ7mca3V0WGIUKuG/DnC7wXvI2cZJ9DzSvWqjDUH8T
 UZN85BupO6+jLMYvNtPHGfOIjCVsWzJrVcZoHUWpxpDDDRVSFRVLjzFltgji+JM/V9G2
 bLnhJjbzoJB3S3qzt3+LtSG9cd82T0ZqoutjmOwJ8KWrXQYYROxNYQBaROIoqyI73Ixy
 QYoA==
X-Gm-Message-State: AOJu0YyMUaSnQ80YzLsbyiHSpDcN5KfjE3YzsNBXG4SPGoSgXOdCTCuN
 p4ly8tZoAMVHEF2GVRb2aaMul5joCVS0IunfAYrcm5rGCAEguot32C6jx/Xgbodpm48=
X-Gm-Gg: Acq92OHkddMaajQUK5Kl14vAzLgjhRQ7p2VpH/jWfXwhRMFpP1pmhvlCo8Ii6AXJyxH
 yNWHz6D+BAyJNQFxm+MZukNNZ1JXEIz+Xdg4xISAGAJ7w7dU2UKplsQb9+daFI4KConmeW9HPaD
 VQAfvsOS85hZlkDnJdzgEXK1OwdZBftrFkqduwOB5+it+Se60UPplkDeK/5X1qQGg9u+eXoXCAq
 lN66A9SJ/LJYdA0a/R2jUU7dKN4AEZ/l3cICnYHI2JEmXFlWZg3Oko0VmlwLj4/bhg2W+dyh+Vm
 lTlmj862cDYUo1Xv8jc1hHdtgSCrtq00rq7lD30/fLyWJpDW74wBWHt1zPMlZ0EhYkTmEbB9hkb
 AG1E2M526FJJF6ytM4l3ap5d2yQfpgO3WiBkUWI41iGBJpA330bEWQ6Af889fqmQ/dDNFWLiMer
 HAABl1qSsg78iCoLafplc1eLp2aWoI0AFCQQ==
X-Received: by 2002:a05:600c:ad9:b0:490:b58b:a4a5 with SMTP id
 5b1f17b1804b1-490ec50f800mr123708325e9.31.1781520973992; 
 Mon, 15 Jun 2026 03:56:13 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492201fad25sm250300855e9.0.2026.06.15.03.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 03:56:13 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CB79C5F857;
 Mon, 15 Jun 2026 11:56:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Alexander
 Graf <agraf@csgraf.de>,  Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,  qemu-arm@nongnu.org,
 kvm@vger.kernel.org,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v7 7/8] target/arm: handle the WFE trap case
In-Reply-To: <CAFEAcA8719Q=VCwOm790V6FPA8FyaFZEux=N-7PmOGaaq=O_sw@mail.gmail.com>
 (Peter Maydell's message of "Mon, 8 Jun 2026 16:53:25 +0100")
References: <20260529082948.363931-1-alex.bennee@linaro.org>
 <20260529082948.363931-8-alex.bennee@linaro.org>
 <CAFEAcA8719Q=VCwOm790V6FPA8FyaFZEux=N-7PmOGaaq=O_sw@mail.gmail.com>
User-Agent: mu4e 1.14.2-pre1; emacs 30.1
Date: Mon, 15 Jun 2026 11:56:11 +0100
Message-ID: <878q8gjcms.fsf@draig.linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Now WFE can actually suspend on A-profile we also need to handle when
>> its trapped. To do this we need to pass the instruction size so we can
>> deal with the is_16bit syndrome encoding.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Doesn't this need to go earlier in the patchset? Otherwise there's
> a point where WFE can go to sleep but doesn't honour the trap bit.

Hmm - the way I read the description was we would only trap if we were
going to sleep. Pre 6/8 we never sleep so we can't trap. I could merge
it with 6/8 but then that makes the patch even bigger.

>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

