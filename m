Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401BBE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 12:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVrYm-0002LD-PO; Thu, 09 Jan 2025 07:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVrYh-0002Kf-8U
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:22:43 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVrYf-0000Ih-5m
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:22:42 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaee0b309adso150099066b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 04:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736425358; x=1737030158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bi8q+/8KOOtB/mPHR104e5FE0utg9E+MUUFRCW0Tn6s=;
 b=l+dPkd1AXY9Spyh2VFnlhEaBLoLEXLs1Gd16s8gP5pEv9GttoxFOru+m6gSRmgLRaR
 L0ivgrILIiBzABvscjPU3smVWOOnVPEjD9VYTPu152gSHui+vPFr0uf8QF3bwI4nrZlf
 98CLfaWNq2RxL3NiXjtj7WVtlmqNDWkGRvl63ui/Oz49N4nR/3pAwnkndtvvtn965f5p
 SIDMbMgkM7zOMqR1LiruJDE0bbXKjEvNu1uJ8dsTmydChsEfKB96b/hqanNfC2xEhoBm
 e3FMb8DCuSwt0OOEVe078IaurrN4HuG1Q7cLH6/PD6Ni1y93L2K0h2+puo+11wn8U8sz
 ZFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425358; x=1737030158;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bi8q+/8KOOtB/mPHR104e5FE0utg9E+MUUFRCW0Tn6s=;
 b=Lzp3q/zvLKQ1t1ggbQbevufwYDS7G0Aa/pS/TjSnO3BUs9YvnhGWvJxhP1l8/ktF8m
 NwliMBlRH+XF7pBa546Bolq99GJKvDx4mO6Lo/VsJngl3gdUkmWpvfe1/gEV8f/NOl1Q
 UFtbp/R3zM4qa7kH46dJLARweTS3kh+4pL0B7FL3v2jjrKYaDMhIElHPU83dBsz3oaW3
 sACuQ+Xy619jWvU2AMfyNPk8eH/4z7F8S7cGyic7JimxOiazNsyzhBwnE7uV+eh/vGo8
 DbdN0R16WAh4WBKdFe0n+jN5ohCeNNNqXdpLhkMGbCz+XWAXVHzNvrMh9Ax/nNbvbRuf
 lygA==
X-Gm-Message-State: AOJu0YzjJt2pKjUEYiQCQIJ0btbLOhHy8Y4ciMc+jlLj2C+wiwUOnN/F
 Si4wEP/VqoVsW0tJ7tai1Snrp1smuGknYjRYqG8ViLsNbBCMHHPDZv0ygV1aUaQ=
X-Gm-Gg: ASbGncvs1eGR39N0qSnHtY0QU6BI/r/VxfLiNiyzEY4TkSARzjZI/MYInEKDAQZjvcw
 BLfJq2OB77eqxC5ouWxqG4dVxal3Oiu8mSh0mUxkIz2uKFASt7Sm0Y47PVC8U4qqkaEc5VD+rm5
 JYnnjmCVEwAAX8y7s55Repz80290ifK9HoDRD8vyEJLZKsDYsb05hTQLmYr7ecBeksulBb2K166
 HT2ztBFGQB8P1darst16hrqMBFbHzZQQZg+esg8eKYOFdnfkrejdFU=
X-Google-Smtp-Source: AGHT+IHOwnRKj6NRfWJ0QgQ7EbIAaeGxxw+OhU5BHuUul7TnHsOJmW2MJQ7PqzY8Q/9GNFDmd/CdKA==
X-Received: by 2002:a17:907:2d2c:b0:aac:1ea4:8410 with SMTP id
 a640c23a62f3a-ab2ab70ad5dmr584549566b.36.1736425358404; 
 Thu, 09 Jan 2025 04:22:38 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95ae536sm66439666b.139.2025.01.09.04.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:22:37 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 53A0E5F87E;
 Thu,  9 Jan 2025 12:22:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Rowan Hart <rowanbhart@gmail.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 2/3] Add plugin API functions for register R/W,
 hwaddr R/W, vaddr W
In-Reply-To: <20241206102605.961658-3-rowanbhart@gmail.com> (Rowan Hart's
 message of "Fri, 6 Dec 2024 02:26:03 -0800")
References: <20241206102605.961658-1-rowanbhart@gmail.com>
 <20241206102605.961658-3-rowanbhart@gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 12:22:36 +0000
Message-ID: <87ed1c89df.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

Rowan Hart <rowanbhart@gmail.com> writes:

> From: novafacing <rowanbhart@gmail.com>
>
> ---
>  include/qemu/qemu-plugin.h | 116 +++++++++++++++++++++++++++++++++----
>  plugins/api.c              |  66 ++++++++++++++++++++-
>  2 files changed, 168 insertions(+), 14 deletions(-)
>
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 0fba36ae02..b812593e7f 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -65,11 +65,18 @@ typedef uint64_t qemu_plugin_id_t;
>   *
>   * version 4:
>   * - added qemu_plugin_read_memory_vaddr
> + *
> + * version 5:
> + * - added qemu_plugin_write_memory_vaddr
> + * - added qemu_plugin_read_memory_hwaddr
> + * - added qemu_plugin_write_memory_hwaddr
> + * - added qemu_plugin_write_register
> + *
>   */

In the next version please split up the API additions to make it easier
to review. For now w.r.t. hwaddr I refer to:

  Subject: Re: [PATCH 1/1] plugins: add API to read guest CPU memory from h=
waddr
  In-Reply-To: <20240828063224.291503-2-rowanbhart@gmail.com> (Rowan Hart's=
 message of "Tue, 27 Aug 2024 23:32:24 -0700")
  References: <20240828063224.291503-1-rowanbhart@gmail.com> <2024082806322=
4.291503-2-rowanbhart@gmail.com>
  Date: Thu, 09 Jan 2025 11:38:48 +0000
  Message-ID: <877c749pyv.fsf@draig.linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

