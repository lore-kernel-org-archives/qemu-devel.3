Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86FDCA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMrq-0006M6-4p; Wed, 07 Oct 2026 04:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xEHKm-0003EG-Ln
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:24:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xEHKZ-0008An-H1
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:24:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a180fbeef5so907665e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 19:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791339747; x=1791944547; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0VdAFjhLSQ0qYTLZ/KWF4f2KzUr8JCGRG8XMPOs/pjU=;
 b=q5OzLM2KfvbViMeI5sEpAVfDZbyoiDG5HC6517s6cSn3kCbg8Va2yTUheqKywWN7Am
 bdMjV+bHc11eB1DRGPl8/B02j0wxgniHPbfmVbojtmaxxtFvlrwbFNAzqKVbfJ4vr/+Q
 XrzYgvIyTZ3CoqUXBtwveoGy8TW2vEpwG8hl+ciBv16Jqa720Ld1t5nRYn9zYYhPOLZ5
 NAAUG/Z+6rZ6igaJSo78rWy+Awd7jjC2NDDPACJZh1eoEBC53WIF97N9srYbc51ekZ/b
 hL/AN9nJAseDqoCkmJXCt7FQhlstIRekQp05N88leOkCP3XtkhMRAXe9tkPjGo0vKRKL
 veJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791339747; x=1791944547;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0VdAFjhLSQ0qYTLZ/KWF4f2KzUr8JCGRG8XMPOs/pjU=;
 b=HT+gqGiNXb0Pep3NjE13MUU2oPir47JyJqJU56IK6/JJyVV9hFqtlUiffgtSD6z+q+
 hgf+HDWFP7MUZYTAz0371Bu8bQnjv/ay/r+xmXMHjmiJqd1BecpYmNvB/5Bi2XxmTotT
 dG+Cx05lXZq4kwEfZ+Awt+t+vXrgpyJdtN7ekkC1Efj3Emne0sXneKwqpRQpBAZw6RJO
 jtNtYsXbb6OjSjOGVtyQsXuGjFT4T+X22R5bNCDi5Y/4yU0YntZRhT5MN8cbwD6+Gb6V
 m57N9MXD2xYy19il+6/wNTw8U/Xafnw/rNws0DZihFEaFHh4oYpjfvatFi3tYBoypLe5
 JhCg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxs8SoiOOGtfkBD6yM2OtDWIS48w9mJUb6//00rM9M0Ud4EaI0cQ9x+gWzAo9deaoAjtwgFb+eMeGsi@nongnu.org
X-Gm-Message-State: AFuF++kyoBsSCo7dIJuOzCqnSpC8jY9ApEQc+7QwT3R0Hak9GsqFFgnI
 bt2MGUYDCpiq/dbJcwviMwmCWcn6mk/OHOypUmrRBpSs6/p8R1lrKh+igPacVNhGX04HGlXkwlK
 t6Jb20lQ=
X-Gm-Gg: AYBFou3RzOsJrXk2Z1hxoOjtkkA2Pd80qC7vMjRzfszhQV1hNfqMlihOJO72Mt7JZNY
 RklLLzs9Uy4PLWnqw0B2RKSVgJMe6iOr7EGZpqYunChAWoPUolLxRN/8PLBTn2oW99JBRhhMgPu
 OkF8L88Oy4RG2VbWH6JjmoJbVgBRTrrZwCVl4UwM9KQbnXgBKQmXPFI1WOsHhgwaxc0SKUrXYNq
 Vr7Vw+HPnSsT2AWmf+/TS76aqixttGtBsz321pp0UdTUPd1U309qBjmoxpILQIb3U+LFbS0eKTm
 SKGIfqTKNGeI79kif/kaxvw6GQtF51K01DZ0dtWZp7oOFZO/if46O7OgEvbHBViU2vrKo1qLnUr
 oki1PO6wnD8MjGJgrLl0ejdEMn5kNx4w26YKR2DZiwAM9nXVCgHWoA8LiEW1JC8On6Yl4nEY1Xp
 lGeJqkesslD6N/RfgZZUTAACubp907l5CzvpXEH50YUDgVj6ppcBAhk69qsJ+lknzAgvnx27YjC
 VvarKD3bxmNMFOe7OV5OzoY33RLPRGe64s=
X-Received: by 2002:a5d:5f53:0:b0:48b:437:8fae with SMTP id
 ffacd0b85a97d-48c6d16d17dmr1910947f8f.9.1791278699504; 
 Tue, 06 Oct 2026 02:24:59 -0700 (PDT)
Received: from [192.168.148.60] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1782126f8f.55.2026.10.06.02.24.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 02:24:59 -0700 (PDT)
Message-ID: <084389ce-329f-4cee-a159-8f8503eac291@linaro.org>
Date: Tue, 6 Oct 2026 11:24:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Linux user next patches
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Aleksandar Rikalo
 <arikalo@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261004114311.3874-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261004114311.3874-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

On 10/4/26 13:43, Helge Deller wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit d7a65d1793d691d356a56833620f7d1e6f5d653b:
> 
>    Merge tag 'hppa-a400-updates-pull-request' ofhttps://github.com/hdeller/qemu-hppa into staging (2026-10-03 14:17:49 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request
> 
> for you to fetch changes up to 8e021b85cc06caec24a24302aa68f040a0970c12:
> 
>    linux-user/mips: pick Loongson-3A4000 if a pre-r6 mips64 binary needs nan2008 (2026-10-04 13:32:14 +0200)
> 
> ----------------------------------------------------------------
> linux user patches
> 
> Some patches for linux-user, which
> - make it possible to run pre-r6 mips64 binaries that need nan2008 without
>    requiring the user to explicitly set a compatible -cpu, and
> - copy the executable's e_flags into core dumps on mips and riscv

Applied, thanks.

r~

