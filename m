Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6370C55ABF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 20:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrhx4-0006ID-IH; Wed, 05 Aug 2026 16:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wrhx2-0006Hm-G9
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 16:10:56 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wrhx0-0007A7-Qf
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 16:10:56 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso15563995ad.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 13:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785960652; x=1786565452; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3HWVxrfjB32fUIjrhqE1Ewirc2pQXdV8XRcpSjkwdfs=;
 b=iTO6DOrD7bZyCpdBKYOO8x30mVYZFwZxOQt7ZeDB5Wy31I0bi/iQkxCMPTbV4iuV3r
 JmVAW2nEy1xY+SnA5IY8I17cubk7Ayw4q5ArTcrC5Gf32UN63N1Ptx2JU2AHig5lHGYN
 C2DO60Q2ZXldiNr6Am8L9dU6Yk4e0gfboTQ+/eTBDYJWO3hWFQ35DwGgPg+fn3FdBXxD
 yRLdj3xc4EuAbrZHQ5M4PhtXk5ZMKlIB2hpuAz/iuDyhqqhaGyOkM13m3kFD3cKuZ9GY
 8myzrq3IrBbGkfm1/3HBrqFYB1Bef1rDo1CANdj064Tga0VSaTWA6nJQIzqftLBdPd+0
 EnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785960652; x=1786565452;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3HWVxrfjB32fUIjrhqE1Ewirc2pQXdV8XRcpSjkwdfs=;
 b=IShcucIZOM0mozIF4iNmjfoqA7xqQB6b+0miHTIP7MTQbsrUBbhoWOHblbcXpOwaA1
 LFqmAgvbMTu+EGymc4RvX+F0FCfznX/L7DPdgXvj4iWftR2x1sAeqX0T0KYr6V22bJob
 waGCRw0gkcV+vT9gy9eVMezfa+nCWgB5Uw19q5yMlWXu8aXjNWM8Hdd5qm5HK1L1+4OK
 s8U3DbRCwef8TkepUbshVG0KdJZ4ebsLBXc9qzwQPhz0NuXIXgUdLNXkDQ221lBVGmAQ
 1AORaMqhgJua2qksZlVLsuBSxmF2NUoqub+0XqxxYIRyRcRXg7X8RaJoCvnb5RY+KJy9
 RHFA==
X-Gm-Message-State: AOJu0YyQMAQbDsKIRYTpKd+BNH9yBqYcHIEbmgikRnRK8xTP7KP7Up3E
 YBUqoeKqpcP/4hejT34/w75QBTG75XslyRCgqzIDFPqpT7JWLlIjoipZrYJKF4Q8bP0=
X-Gm-Gg: AR+sD12JiJVNTV7pE1l1GSBhPxgTToak6t/cBEwYPpb97GwIBdDz1tN6Ke8z9L7CfQL
 8s2Mi4UxfRwOyyjb5EuHvOvTlOV2lsG6DconBMAJVylECqIraCglEpDZZ/QUkiu1Vib3lVZQKmL
 SU8GhXR0JhXrIFDVshWpWCDzI/N3larDMP3MZr6GSsdHnvbMwzi9/oMbX0iqAatMrzBrvLw7l88
 jol6y2DPj9afWPE+1srCaqGpYZLEipyqdZj4ta63zUrCu+4gw6GqdtZ7swyiADSTsqm4S47D0ya
 apGirIU/u2XDYiKr/hOuN0NNctdJ8veQRhj6S3dv9DSbT+qFgBFVNG4XYXX1xRi+vyp//PTIEjO
 hbZBhfVlK2AVupjdLgarmaeuV6EjGk5V7nVmcG+pHtcK2JMpS/LscSeNR0mxkUYywwN36XvTfbb
 WuSW8S72JiuogHV8Woj6vKzaGEXxBPknoVPWb918mtwYQiOoyOy/DVbLUh2Vz6Ngy4vQvu+wAnE
 ocWnICXNPO/MZPvw3VqzqOZ5P+F
X-Received: by 2002:a17:902:d4cf:b0:2ca:106c:7122 with SMTP id
 d9443c01a7336-2d0ca75764bmr103303365ad.9.1785960652083; 
 Wed, 05 Aug 2026 13:10:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0aa4d8af6sm20260495ad.74.2026.08.05.13.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 13:10:51 -0700 (PDT)
Message-ID: <627613e7-22c7-489f-a919-011fb767e1c5@linaro.org>
Date: Wed, 5 Aug 2026 13:10:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user/sh4: Deliver SIGILL on invalid instruction
To: Mikulas Patocka <mpatocka@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Cc: qemu-devel@nongnu.org
References: <9691a731-5d0c-15b7-e773-60bac1f54fc8@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <9691a731-5d0c-15b7-e773-60bac1f54fc8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 8/5/26 09:23, Mikulas Patocka wrote:
> On invalid instruction, deliver SIGILL rather than crashing the whole
> process unconditionally.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> ---
>   linux-user/sh4/cpu_loop.c |    7 +++++++
>   1 file changed, 7 insertions(+)
> 
> Index: qemu/linux-user/sh4/cpu_loop.c
> ===================================================================
> --- qemu.orig/linux-user/sh4/cpu_loop.c	2026-08-05 18:05:44.000000000 +0200
> +++ qemu/linux-user/sh4/cpu_loop.c	2026-08-05 18:12:12.000000000 +0200
> @@ -64,6 +64,13 @@ void cpu_loop(CPUSH4State *env)
>               cpu_exec_step_atomic(cs);
>               arch_interrupt = false;
>               break;
> +        case 0x180:
> +            /* Illegal instruction */
> +            /* fallthrough */
> +        case 0x1a0:
> +            /* Illegal instruction in delay slot */
> +            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC, env->pc);
> +            break;
>           default:
>               fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
>               cpu_dump_state(cs, stderr, 0);
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

