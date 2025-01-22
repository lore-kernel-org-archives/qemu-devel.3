Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D54C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 20:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tahlW-0005Ue-86; Wed, 22 Jan 2025 15:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tahlT-0005Tz-RE
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 15:55:55 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tahlO-0006un-La
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 15:55:53 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436249df846so1174615e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 12:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737579347; x=1738184147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98CkmyIOrvR4LNxrWX7nL5TEc7tkomh5WxY0XitPJ5w=;
 b=DU2f7bLaRKkwmVuEehj0nRXVwqtSkmSHVnvkLXfUqDr4X7cYec3vQuIwmc7PXqgtDA
 cP4OjIc3gIeAVO3ann+FF2GCc4efUDR75pEw4akQlqEqeMp4KyxAo7E7/of9ULWlrrEq
 tOaDKFIOVntg+JROEcKLgxN8/A3j8bb53ZkZV7hqRw4H9h9KYR/eoZAUjUFiSmLqZxUj
 +qySz96pyiKq4QJ7KBo7/l7PIjwfTWlspVc1aSnVe1En/BgGCxdbJZbrLfcF97LxuN3y
 01AFVHjd12XdujZr5fxqHq2dxrL07lYjW3MXJwQxbBnMhqoNauI0ZXFPUisBXCZyxE9x
 T1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737579347; x=1738184147;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=98CkmyIOrvR4LNxrWX7nL5TEc7tkomh5WxY0XitPJ5w=;
 b=whp7ktxREV9PYyb/ddooZLXyui/uZ7RWDTmzmIlQEV8ySc9wPBncUNRtZXHHaqg5ul
 +MgkI2WnZ3OUODoE0dd7UxKHEHVkCfhgFCmLGasbIb+b2tqZ5KuwMU8u9Vf5i+6MbFS4
 NVkRubYrRwPYdMgWQnm29yIbMhUmoD0vJnneABYixhYcosv/cx7wF5SVJKciyj9pK6tG
 Gv/hziL6e+Cya2AdIK6SSUKwRTU2WF7Xu11lar1iDqCFKIiNZDzdI1FCvAe9bP5vrnF5
 idQrWw6tOnOB8obrGCmo8s0X00/EjWp2CtA/GlW83UkBn7j0j4Q0CSD9LEfY64JMyKhA
 AWCQ==
X-Gm-Message-State: AOJu0Yz/E3TGHBP2RLicrnXYjuY9lSSU2+VlIaqaTMu3vfBMp9fe9o9S
 u3rhZqIoAhwTwWE5zE/iAIEsmdD9LwV5fzexqQrTF9uGT4VOInZ999V2K/RMXqg=
X-Gm-Gg: ASbGncsh1Ur2NO/upygHtecliplmcYqtf/cMny8R5t7F2UwPsH87/Z2nceZgT/722ll
 i7+pvib1CZRhmRPkdbXfyOxmxtLitNqbWl53tJ2nWYC9pFjyzYulskIO6CdneqdQcenOopIYgIh
 orKQvrXR5i4xw1UYmNNMey2PcofwAYRm/zWobF0AI4+YLps9s+fNyJB9gU5zRjV/AAN+zJA6WSB
 MNKNNqrPWoEl4bZkzi8avEMmrjxCA3uD4DJyvrZBD8TkM1udNJCiiyNOJMGheRm2cL9
X-Google-Smtp-Source: AGHT+IEQVryiOv9n+Lr5gCdwPxyHm3myhY+elUrkpo8c7m5g3waI3/b+/+cyv7KS+jtKk7Ojaj7JfQ==
X-Received: by 2002:a05:600c:a03:b0:434:a902:97cd with SMTP id
 5b1f17b1804b1-438913ed350mr225943275e9.12.1737579346652; 
 Wed, 22 Jan 2025 12:55:46 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31d987csm36879745e9.27.2025.01.22.12.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 12:55:46 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5CE485FA4B;
 Wed, 22 Jan 2025 20:55:44 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 02/10] gdbstub: Clarify no more than
 @gdb_num_core_regs can be accessed
In-Reply-To: <20250122093028.52416-3-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 22 Jan 2025 10:30:20
 +0100")
References: <20250122093028.52416-1-philmd@linaro.org>
 <20250122093028.52416-3-philmd@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Wed, 22 Jan 2025 20:55:44 +0000
Message-ID: <8734hamuun.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Both CPUClass::gdb_read_register() and CPUClass::gdb_write_register()
> handlers are called from common gdbstub code, and won't be called with
> register index over CPUClass::gdb_num_core_regs:
>
>   int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
>   {
>       CPUClass *cc =3D CPU_GET_CLASS(cpu);
>
>       if (reg < cc->gdb_num_core_regs) {
>           return cc->gdb_read_register(cpu, buf, reg);
>       }
>       ...
>   }
>
>   static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
>   {
>       CPUClass *cc =3D CPU_GET_CLASS(cpu);
>
>       if (reg < cc->gdb_num_core_regs) {
>           return cc->gdb_write_register(cpu, mem_buf, reg);
>       }
>       ...
>   }
>
> Clarify that in CPUClass docstring, and remove unreachable code on
> the microblaze and tricore implementations.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

