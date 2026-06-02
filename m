Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A400BCD6E5D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 18:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUTzl-0005gm-Fx; Tue, 02 Jun 2026 14:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wUTzh-0005gY-VB
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 14:37:41 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wUTzf-0006li-V7
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 14:37:41 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso10186615e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 11:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780425458; x=1781030258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5C5XqSBwJNVPfqoMYAK09se0L2oDeo3kuqNcbA9DMQ=;
 b=G3QcQG6eYB7azxI60pLSdavX4NSy8bRe6Bc7Ak5eWaf/snBSFFTfse3fmT7zI3xnUC
 KrZKHUfZHJ28J8/yMPbO9MS3nZoIb3pAIahj/IwtPomUH0IfLUOP1TpuNjtWcqyhKfUB
 k6itA7RcAjKOWxghLX4yh0dbFALrk2GFj6+IK3N+dNfQBk608cuiPtLfcstWueurIUwN
 kve8+p6rwb3lefwQzN2sTJGPUggiR+6vjOh00oQMVeWZuXZAa9Qo9n45cMpWO3VwQLXH
 X7Od8zd4DNWhDZG+vs2eRXGANKLRLgbLcN1VoP/Skhvj30v7A2Np9aErbTfPlQmnl4uI
 VawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780425458; x=1781030258;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W5C5XqSBwJNVPfqoMYAK09se0L2oDeo3kuqNcbA9DMQ=;
 b=hINxVPfdx8wg7TW1tsN/0TOw/5cfJI3lXVFcR34KOgpR5D1BP3EOVP12Co6pPNlPi4
 mpx9e/DFYYfOdL0PypAUthZ93LPEndQRUrYv8nAd1wOEQy2a0O9VNwYEOWWt5STHwKEJ
 zkNNUb+6lITBufzn5x7JwXH0+SAJaJIm+aUGMA2A6z1J16H5C0k3NSgKuETOcR3iXnmQ
 NpT7V9ElWtBSTlqV2+1aMMWjJh/Fni3p7jXenJrH12wOSAWW2K1wzjragg+A8GvUshrt
 8bW/lSnFoWQgOCFm1a4PESoPtOmj9l2RfFfOSknVGXmx7hw0g2bDW8I+UJKsWhqXZ5bq
 bSgw==
X-Gm-Message-State: AOJu0YxTw0faBeAt0fMpB+VADbLhC0d+mVFBK8uC1ADQ1VBKsoALL6sF
 K0HX1BtgxA6QUJHKTCUCxiqo5poG4Pqc9zDK4CbL8lwrYI+chtE6h5arYZ0r2Ml+CwE=
X-Gm-Gg: Acq92OF8bp813NZoxpBzkp2MU7TqxLGNohKhTu4xYkLzvbVG7CDQvbJTT6P2ksjTV1O
 oiAbusTRXbx2bO6v3Iccho8rXbelVKtBosVMCEGdzD2pRPLX7jm0/z84bX4QDQQ3kWVGZQ0lonb
 D9OEX+Y2BKNfBhHpJ3rGayD/ybv5gF+eIR0Y4OBMxEPFTtVI4C22tOBj6KXIzOwYsM7H4c38bCe
 PcuU99JSilITL9uCZpJ0sy8rXgBbLvLrzDMHWfQWRs/Jjev3bKqU6seWvbJd0xZBrszTePFh7I5
 C88djC3vPmhLOE235EHhy9D8u/cqXE3jEoSZ0la9kHlIAmwuTxNrRM2tc9cK8MLAD+pqQg4N1Vp
 1eJVkdOYZ/i9AZYqWNyBNtsjomvgwnLYC1d19OJhQqsGFUARLc4pVpYu0SP73IC+sNkGxk5ZQWz
 Cu88XMGFVcjUv/Q++GRY/DorU/ywJiP+aroA==
X-Received: by 2002:a05:600c:5288:b0:490:5191:6e26 with SMTP id
 5b1f17b1804b1-490b5ecbd41mr230935e9.18.1780425458375; 
 Tue, 02 Jun 2026 11:37:38 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcad5sm1250397f8f.5.2026.06.02.11.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 11:37:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BE7345F7F7;
 Tue, 02 Jun 2026 19:37:36 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,  Li-Wen Hsu <lwhsu@freebsd.org>,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?= <philmd@mailo.com>,  Warner Losh <imp@bsdimp.com>
Subject: Re: [PATCH 2/3] lcitool: remove Cirrus CI support
In-Reply-To: <20260602162457.828969-3-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Tue, 2 Jun 2026 12:24:55 -0400")
References: <20260602162457.828969-1-stefanha@redhat.com>
 <20260602162457.828969-3-stefanha@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 02 Jun 2026 19:37:36 +0100
Message-ID: <87cxy8vle7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> Remove GitLab CI integration for Cirrus CI now that nothing uses it
> anymore.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

