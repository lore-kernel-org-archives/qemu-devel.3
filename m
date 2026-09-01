Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37E6C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Tdq-0005vp-Qw; Tue, 01 Sep 2026 14:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1Tdm-0005vH-AJ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:55:26 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1Tdj-0001fc-3j
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 14:55:26 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4843e397f74so168244f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 11:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788288921; x=1788893721; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=O6B9mgNv0lUCNH/FsjR3EQTSgWnBSlCbriKuJnHUw5Y=;
 b=mF08yM8FhY7qELDd92R1qplExGGDFpMfbUcgC7eh2HK3JkfxX0thQUIMSNYLBX4Cmb
 OaRXsh+ENdclI+bcVXmKOEWqoFFM7EdOZnBPiBex8uDNFV4vAF77WU5JkI/0NK/na/Nq
 q18BW/CcPXr4O48CuG+liX1aMT0v9Q5IhkUqQzGcTcmQLNAXDr2T7MpZ2VojHC94rC9g
 2ncnla1DTU1FTeXzYgst0nowCnvZI2NeaHxItzlFvC3oJZ9H0mnSdZlUwPfX37C65tLW
 xiNzHhwgltAid8Ld+rcVN/5lUGMcOibsdUDmozpO/8YxITsYTlTM07hLQO0WhrpKplwT
 VaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788288921; x=1788893721;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O6B9mgNv0lUCNH/FsjR3EQTSgWnBSlCbriKuJnHUw5Y=;
 b=aC1khRq1R061CQyYbFQQ3WgrIBxKToK2TCZ0uSA9GgqrBV0Cgbi1lntC6QXRG2pe9E
 QfwQ5tx4GhCLMbpeFNyZEqhZin3L/x/X1myep0NmLXVOSouVkXaPbUQbWjs9NAEf7QpF
 bP3uBbLgGwiYaNlEEQha0HUDvfoLqlJp+EPWiKhwOJkr9kSAhJLuLsF3KsW9I8dX3ohp
 pGhwGrmdUANNYawIULjYQtZNgJ3Jh4ulPgmCHG951dKmvBdSiTcu8VRfXX5r0GZ8uWJn
 a60OC4xZVSgGtsAmqQbW0TOrmM/NLmoSXQp1MlqHQXrTlwecBjSaX+6j94+ayONoODsm
 8FVQ==
X-Gm-Message-State: AFuF++mC7BCz+YaAal/BHPu9+7JIgZNCdeIS1YXoPO7IT5Pt0Z5xY1Te
 ZJE56IZdiBbM4tYdZKLK3ShHWfDoUDgLGfzWRTsPEi245tD5acEaWXptGz85gbFN5hCgR7B3odS
 S8hG2Uno=
X-Gm-Gg: AYBFou2IMORI+dHUZBPDmZSxN9cprYOC8TduxjOWswAZXoYQKc0zAGGgl5WvOPR2Zp/
 plFy4vvMa9UZm7Yj7gVfo2bkAOnO+UDxN828pF9FwPa35bkRvVze5VrPvdnDkC5Lzn6uyg1hMiG
 wjDjITKvNkRbJc1chzGIWeI4ZyCEOQKojSaGbBCrb/dXR1XtfUbBMFC5T75uOFSzld+tFwqpsLg
 kf6P/t2jyE9bgVd9mECD/y2L+AOAytVjz/9uGkrCQOnXyPFXF+eU1i+isgSj6XXpwiVaTz+PNU3
 X8NW2Grnfuwpa207QMXY5KsTYfgWGXnR176xi6L6HT9K90P65hcpniMxpRbfECe/v6z0WebEhPw
 cT1v7H9RAc614MWVQ71UySUxJkc3im7L4G0LJWrosYWMi0IzJJpP+DnQDplQIL1Zlcj58MudSqq
 XF1VCcUsUuJ73BLFNQXHHIPTGi0U7dDc2s+oBxaZxPwpEYq2VDHdJJJAF1noAd
X-Received: by 2002:adf:e004:0:10b0:484:440d:f5a8 with SMTP id
 ffacd0b85a97d-484440df7c3mr10720639f8f.14.1788288921067; 
 Tue, 01 Sep 2026 11:55:21 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e80745sm919774f8f.15.2026.09.01.11.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 11:55:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 35F535F829;
 Tue, 01 Sep 2026 19:55:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] configure: correctly honour --disable-containers
In-Reply-To: <20260901163858.1570626-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 1 Sep 2026 17:38:58 +0100")
References: <20260901163858.1570626-1-berrange@redhat.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Tue, 01 Sep 2026 19:55:19 +0100
Message-ID: <874ig8u7hk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The configure script originally only probed for 'runc' command
> in order to handle cross-compilation containers. The Makefile
> under tests/docker would then probe again when used.
>
> In order to eliminate the additional probeing, we changed
> configure in commit c4ce04cfb7460d46c0262d437a7f35bb5c5fc449
> to always probe for 'runc', so the result could be passed
> along to tests/docker make rules.
>
> That commit overlooked that the 'probe_target_compiler' func
> was relying on '$runc' =3D=3D 'no' as a proxy for the state of
> the --disable-containers arg.
>
> When we started unconditionally probing, that short cut no
> longer works and we must explicitly check "$use_containers"
> too.
>
> Fixes: c4ce04cfb7460d46c0262d437a7f35bb5c5fc449
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

