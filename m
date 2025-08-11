Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CC7C87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 12:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulS4t-00079L-OJ; Mon, 11 Aug 2025 08:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ulS4o-00077d-22
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:56:34 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ulS4h-0004ls-8D
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:56:33 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b8d0f1fb49so2578592f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 05:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754916984; x=1755521784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MEwTbiMmgOCDfG4V/dHV2qWA8Co9Gded4SX9LtmBzak=;
 b=ABxAT7cszZM+baLNHhR1cUydBI2E8dWL/c3cpHtT2IddEbLtXUcCgct/PmgUUXgB5T
 WsayxiWzQJjEppu2W8NYt4RAF+Kgu1yaVg3UteyFItBcRBRjdKJOf13NcmVkf1ADW1fn
 wo+qOGERtyJMAT9OfdPrI+Bsdnoj8GOQnVh8Xm2ro+SpPz1mbClK24yrSRTlWJoZDo/W
 gNLVgUfKsktgtt19/6QpGfJMJixio8/ZihDfp4g6vi8ITrx1MStxb4KM3CDLxTCFj4M8
 8fv1w9Jawf/9Rg4o2filQTN6+GkeerlGhxswtpuTN/3zofSy6zsnTF5nN2se7JI9Sr9c
 VkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754916984; x=1755521784;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MEwTbiMmgOCDfG4V/dHV2qWA8Co9Gded4SX9LtmBzak=;
 b=hvb3xaPQbmN+U82KJm7MaF54ljjUSXNRwXGSnZrnyHdDvmFSNRzpscy1EqFUfXlfsP
 H+aFbT6YVjN+C2GpFcNj6mboBDiEDVM4cF+UmueAV1or8l54khM12enkE5DI9eWCA54B
 YtcTXiQoGNHjrlRhibGeoffKnLq0nXhTS4lEBkZBgOT5G+9cMjraO2BNWYv12G1Yra79
 +nBSbZXmIJYORPO0et1mGkXGyEhZ5s+UecK0Ug3BFjRGv7xor+pxQQ7AX+5VoD1tqL24
 771vcHT+2EsLjYkCG/fO+ZFG4cIGy7DDpbmQAe2ubh9s+JW56zrMjMOqnm0bKJXH6vOg
 CWIA==
X-Gm-Message-State: AOJu0YzNEy+UHB4ABuVtY194Nezq3xYUTAL+0s0c5rUZeSd0TaXqQyNH
 Jjv7oDcvneWznWIYuYAiSWgU+aa8TH7i/hX7LnWaycmYrPS3O1GkumrCJlp2JzaxF9s=
X-Gm-Gg: ASbGncs3qQHIi0zyztToDAMs9BZyrxc95xdiRtarWxPAOEKP3WjvD++3botGTgopGGn
 ZOVnZ1oVYDu0N2hmKRmIUW/zHk2PJn+DmKG2/IMVmmrhQ7waq0Q3ijd+7GULXkZouMIbmEfzGsT
 4rCDvzw66PZf3u3MxSMG/318aIN5jF58qzB/ztblCX1rliAeDcwZ3gnw/Gh03s4P3H67Xx/yKDp
 JUkSrX77VyrE7Ie1U/vCWSkTqCeVlaOpdr9jJ+0xyjzWwu8vA5RIcwECvsWpelNJxwpSa8D4fK/
 sGXnPUe1h5Dzto9r4SDT0qeo1GcmdA5TwcpL/gBKJvaI2QWMsbTJzvgf7dmna0w5kgcu3YS/LjF
 9Ncq+JrcPIOg49WEPdl7wXjA=
X-Google-Smtp-Source: AGHT+IFsF4fthC2BlqsjDHd8K/DEmwvbkYjoh3s5+jJM7cRyBmdrOIKwNXsjeHU0VUaFW5cfEb3gVg==
X-Received: by 2002:a05:6000:2482:b0:3b7:90db:aaba with SMTP id
 ffacd0b85a97d-3b90094055dmr10780584f8f.24.1754916983805; 
 Mon, 11 Aug 2025 05:56:23 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abed3sm40419650f8f.10.2025.08.11.05.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 05:56:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E6DCA5F834;
 Mon, 11 Aug 2025 13:56:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  imammedo@redhat.com,
 richard.henderson@linaro.org,  peterx@redhat.com
Subject: Re: [PATCH 6/8] cpus: properly kick CPUs out of inner execution loop
In-Reply-To: <20250808185905.62776-7-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 8 Aug 2025 20:59:03 +0200")
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-7-pbonzini@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 11 Aug 2025 13:56:21 +0100
Message-ID: <875xeuc8zu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Now that cpu_exit() actually kicks all accelerators, use it whenever
> the message to another thread is processed in qemu_wait_io_event()
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
<snip>
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -509,8 +509,8 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
>      if (!cpu_has_work(cs)) {
>          cs->halted =3D 1;
>          cs->exception_index =3D EXCP_HLT;
> -        qatomic_set(&cs->exit_request, 1);
>          ppc_maybe_interrupt(env);
> +        cpu_exit(env);

Should be cs

>      }
>=20=20
>      return H_SUCCESS;
> @@ -531,8 +531,8 @@ static target_ulong h_confer_self(PowerPCCPU *cpu)
>      }
>      cs->halted =3D 1;
>      cs->exception_index =3D EXCP_HALTED;
> -    qatomic_set(&cs->exit_request, 1);
>      ppc_maybe_interrupt(&cpu->env);
> +    cpu_exit(&cpu->env);

Should be cs

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

