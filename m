Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A4BC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 16:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfjTg-0005mQ-KN; Thu, 29 Feb 2024 11:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfjTS-0005ln-Ab
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 11:41:35 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfjTQ-0002qQ-OD
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 11:41:34 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412c37a8001so958655e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 08:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709224891; x=1709829691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q//wVcr39OHwtxYkhm9EbTLOajZlZjqqsoGwV6Wtzl8=;
 b=Qil+PJucUzcud6FyAcuyheVogHOMbsA10dMbN7RpN+a1+1jetHp5ShFh7gvMYiU9Lb
 eKJAp5voYeciAr250gRfcAYy1IqlLC1bgs1P8c8fv7BtWY2noGskDjOzOPqqtZjtePFS
 EiBJmm/VojDB3xjrPXuY6Se8Lax/1ZAm0mvlpwzRNNYu/zcJFe3M/KHuw3XoZ7ruEDjb
 UTkI0Rz6Wz/LItvmPn2GbUHGapy4sjgLelDu927r+cz7JFu4wRyiCnlhucGpHN7Rp35I
 P1hSiT1egoppi0+2IG2Xt3lDcgUfD6m0wTKuctGt7BCltoA6h7tfSguj92EXHb0/dqds
 CqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709224891; x=1709829691;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q//wVcr39OHwtxYkhm9EbTLOajZlZjqqsoGwV6Wtzl8=;
 b=Ob57rZP+mj0jCKNc2tCnbT05qzDkg+8+k24kyFUQJzKZqbW1BELtT2XZ7MBuBJ9soh
 tttCmYdpvLGfEe8t2vVcg797BHh+1EVIh04HSAp+RbWRwFUKLi7Gkt72DQpI2ZWM4hXX
 KK8B3OvgH/sdcJj7LJ8wsjfL6y7lU3Bu+B0GImkoYIXe/4hjgFd6kRD+hiAHFNpjXSiO
 6RheZuMJOwTABOpt68C4BHMpo/btI4ClUf+0Brkg1j09WwTkoi59yz3vQWfbDqwIlb9e
 OrQ+I48f9718AoESrlo9gvMgZ0bei5uEGPIUDyCdMu/zsG4KaEvsjB/BMTJQEBIgCjCC
 OqZw==
X-Gm-Message-State: AOJu0Yxchu0MNckKLyjj5gC1cXJr5De6eGqSF2jUbz/V6imOvtxjCPQT
 DgbtNjM8O5j1y6xfTLLrk1snl7JZfGkI3hi54ewgfB8Ki8tm2i1Utr9bMO3r9ag=
X-Google-Smtp-Source: AGHT+IFGi6EFcabNCX2v7GgwYRejNrG1y29oZKFq5Xejy2CGaAYkrm1dAea0dbqfX3E9P/Pg73ksqA==
X-Received: by 2002:a05:600c:19d3:b0:411:a751:322b with SMTP id
 u19-20020a05600c19d300b00411a751322bmr2359405wmq.18.1709224891023; 
 Thu, 29 Feb 2024 08:41:31 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m24-20020a7bca58000000b0041298c75ae8sm1841708wml.1.2024.02.29.08.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 08:41:30 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 44C255F873;
 Thu, 29 Feb 2024 16:41:30 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH] disas/hppa: drop raw opcode dump
In-Reply-To: <83e2986e-3c80-4cf3-93ae-5e578051c98b@gmx.de> (Helge Deller's
 message of "Thu, 29 Feb 2024 16:02:09 +0100")
References: <20240229140557.1749767-1-alex.bennee@linaro.org>
 <83e2986e-3c80-4cf3-93ae-5e578051c98b@gmx.de>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 16:41:30 +0000
Message-ID: <87wmqn6x51.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Helge Deller <deller@gmx.de> writes:

> On 2/29/24 15:05, Alex Benn=C3=A9e wrote:
>> The hppa disassembly is different from the others due to leading with
>> the raw opcode data. This confuses plugins looking for instruction
>> prefixes to match instructions. For plugins like execlog there is
>> another mechanism for getting the instruction byte data.
>>
>> For the sake of consistently just present the instruction assembly
>> code.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> This effectively reverts commit 2f926bfd5b79e6219ae65a1e530b38f37d62b384
> ("disas/hppa: Show hexcode of instruction along with disassembly").
>
> Sad, but Ok.
>
> Acked-by: Helge Deller <deller@gmx.de>

Well its an RFC for a reason. If this is useful we could just sneak a
flag into disassemble_info that is set by plugin_disas? Or maybe move
the insn stream to afterwards?

>
>
>> ---
>>   disas/hppa.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/disas/hppa.c b/disas/hppa.c
>> index 22dce9b41bb..dd34cce211b 100644
>> --- a/disas/hppa.c
>> +++ b/disas/hppa.c
>> @@ -1972,10 +1972,6 @@ print_insn_hppa (bfd_vma memaddr, disassemble_inf=
o *info)
>>
>>     insn =3D bfd_getb32 (buffer);
>>
>> -  info->fprintf_func(info->stream, " %02x %02x %02x %02x   ",
>> -                (insn >> 24) & 0xff, (insn >> 16) & 0xff,
>> -                (insn >>  8) & 0xff, insn & 0xff);
>> -
>>     for (i =3D 0; i < NUMOPCODES; ++i)
>>       {
>>         const struct pa_opcode *opcode =3D &pa_opcodes[i];

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

