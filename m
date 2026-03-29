Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC501FC97EE
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2026 20:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6wqT-0001M3-J0; Sun, 29 Mar 2026 16:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w6wqR-0001Lh-II
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 16:34:51 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w6wqP-0007sj-Tj
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 16:34:51 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-66132b22182so5433248a12.2
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 13:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774816487; x=1775421287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VzPQR6Y7fLHcPY6TwowFeY0P086BsayNAVA38vsGUyk=;
 b=lRbWvCFVBfRfFJRCoeBWqbBiUZPBNd7oaQKRl6FHOWbCWQSDDEae0ZMvOoA33cnZHd
 T617TOfw4sv2W7BnZx9t8gtn4CKLb/+L6HTT11N64WsZtRa8akeThqRqe4CUYc5YWBTj
 gWMN9GsUtoztTb88DWIokrtZ4OYFj6DeRDTJSscm8MaOhVvMWOQ13S7OUn/Qh/vD5Uyh
 OhqD4qmQx7ofpQTvZDlsoc9YIHxsdopDl4uXndICjHdpul36H4aiWFaEejSS0OlBcAse
 /cKJfc0X3XjwFgbRIinLOpGezs2f9hCjoOzqRNcG5p1YxHmIXS9r8NpjeJFcPXVcEVrH
 lKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774816487; x=1775421287;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VzPQR6Y7fLHcPY6TwowFeY0P086BsayNAVA38vsGUyk=;
 b=cZWQyjl/3kqSNZT4h1oY7Ye4HrlU+gP53ABf4v6WQZm4ci5EGlaEC7hKH2AOv2H+v7
 ZPe4ibztQ13ijfQu4RI91kf++qTWzau3H2g9eYXMHQilLW/50bOxj2FNzWM9jEQZ7wkZ
 UPTnYgOLpcSDxSLZ6eEDYo0ZDRcU/Y3hFd6eCjeFv6ncGwHJ3kviOGgp9j69XPWod4IK
 Ji9ZPHp8CaweSiSY2ATeui6FRxZstui/h73chAo6CUH3f4ArdT62NhO7qx1otF7NleUd
 +WXS4+5bzIb61Cg/kAySAsqG+7Qv+TG6ecgNCk6Vb+MzgVGbC2rTQXIDGhV71nBI8JUW
 4G9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm9f9wvJmDgjx8PUOePr2DhaxzXonkaL2yRPRHU03sOHYCZFVhil4/2bVFE3Yoh8LLIGLzxSi6bpMG@nongnu.org
X-Gm-Message-State: AOJu0YxZkANpgAaaXA6+gBPESmgC/HSmRpsLK3lhiDNqbsYu/rPwN5Ny
 +2kmhoUDLts0MugkPnNQz5sYmJZLp4zYDLc7QZZY/ZtunqvBp5qZcJZ5pj6Vf4u0DHY=
X-Gm-Gg: ATEYQzzvvrG1g/E/hBwbduBMDjyFZ7jT3oESfHrDIooWpGxPMOjprdlkz310tWTlK8x
 i/cDUaveXzHf59IoR8a/vXUflOKsxtoOLBR/a/0P4B/I0ZvfuDBLGkvMtNHbeG5QtNHT15NIaaR
 4je2816RQd2wtDzq6eOwVAC4gubL9ABA4UoDpNe+WzrBeEjXPIojmDdOV8XK+yEZW0d3oGQCxbQ
 KygbVBvIMdpW1c+Cc/7224YjbnorYCAEUa8TBaPB5Jgw1DyHMqd54W6D/X0/EQOqDx2ASOhu/5p
 MbX47OjsGz4E/ihehIAG0WYlwNPuxXV5nWMZbABBWbyw0dbcAYZAj9TpszELD3hUzA7XNY1qP2Q
 7KRUTgfL0P05Jt7m6auCx1einzb9es5Y811muUesvMP6qo3/ne0H3oHDlCfnGICczH2LE6e9xdq
 GTlPeeSagqPh6Rj6fgLWwGVKY=
X-Received: by 2002:a17:907:3e07:b0:b98:47a3:b41 with SMTP id
 a640c23a62f3a-b9b507a652fmr621821066b.29.1774816486806; 
 Sun, 29 Mar 2026 13:34:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7b1a5803sm199879066b.40.2026.03.29.13.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 13:34:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DF74A5F814;
 Sun, 29 Mar 2026 21:34:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: Zexiang Zhang <chan9yan9@gmail.com>,  qemu-devel@nongnu.org,  Nicholas
 Piggin <npiggin@gmail.com>,  Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
Subject: Re: [PATCH] As reported in qemu-project/qemu#3324
In-Reply-To: <acjT4ENff_tcJQtz@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 (Aditya Gupta's message of "Sun, 29 Mar 2026 13:01:05 +0530")
References: <20260326152733.344926-1-chan9yan9@gmail.com>
 <acjT4ENff_tcJQtz@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
User-Agent: mu4e 1.14.0; emacs 30.1
Date: Sun, 29 Mar 2026 21:34:44 +0100
Message-ID: <87tstyxtln.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Aditya Gupta <adityag@linux.ibm.com> writes:

> Hello Zexiang,
>
> On 26/03/26 11:27PM, Zexiang Zhang wrote:
>> From: kiki <Chan9Yan9@gmail.com>
>>=20
>> A malformed IVE value can result in an invalid server field being
>> passed to icp_irq(). The function assumes the server id is valid and
>> may access invalid state otherwise, potentially leading to a crash.
>>=20
>> Fix this by validating the server id before using it and ignoring
>> invalid values.
>>=20
>> Reported-by: Zexiang Zhang <chan9yan9@gmail.com>
>> Signed-off-by: Zexiang Zhang <chan9yan9@gmail.com>
>
> About subject, can you change the subject to decribe the fix, something
> like 'ppc/pnv: Fix Null Pointer Deref in PHB3', what do you say ?
>
> There's a build error:
>
> 	../hw/intc/xics.c: In function =E2=80=98icp_irq=E2=80=99:
> 	../hw/intc/xics.c:226:9: error: implicit declaration of function =E2=80=
=98qemu_log_mask=E2=80=99; did you mean =E2=80=98qemu_log=E2=80=99? [-Wimpl=
icit-function-declaration]
> 	  226 |         qemu_log_mask(LOG_GUEST_ERROR, "XICS: invalid server %d =
for IRQ 0x%x\n",
> 	      |         ^~~~~~~~~~~~~
> 	      |         qemu_log
> 	../hw/intc/xics.c:226:9: error: nested extern declaration of =E2=80=98qe=
mu_log_mask=E2=80=99 [-Werror=3Dnested-externs]
> 	../hw/intc/xics.c:226:23: error: =E2=80=98LOG_GUEST_ERROR=E2=80=99 undec=
lared (first use in this function); did you mean =E2=80=98MOD_ESTERROR=E2=
=80=99?
> 	  226 |         qemu_log_mask(LOG_GUEST_ERROR, "XICS: invalid server %d =
for IRQ 0x%x\n",
> 	      |                       ^~~~~~~~~~~~~~~
> 	      |                       MOD_ESTERROR
> 	../hw/intc/xics.c:226:23: note: each undeclared identifier is reported o=
nly once for each function it appears in
> 	cc1: all warnings being treated as errors
>
> Add '#include "qemu/log.h", maybe after osdep.h include, to fix above
> error.
>
> Also, I will recommend running 'make check-functional-ppc64 -j4' to test
> the patch before post.
>
>> ---
>>  hw/intc/xics.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>=20
>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
>> index 1d40c4386d..25c7b0c8a5 100644
>> --- a/hw/intc/xics.c
>> +++ b/hw/intc/xics.c
>> @@ -222,6 +222,13 @@ void icp_irq(ICSState *ics, int server, int nr, uin=
t8_t priority)
>>=20=20
>>      trace_xics_icp_irq(server, nr, priority);
>>=20=20
>> +    if (!icp) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XICS: invalid server %d for IRQ=
 0x%x\n",
>> +                      server, nr);
>> +        ics_reject(ics, nr);
>> +        return;
>> +    }
>> +
>>      if ((priority >=3D CPPR(icp))
>>          || (XISR(icp) && (icp->pending_priority <=3D priority))) {
>>          ics_reject(ics, nr);
>
> The change looks good to me. Can you post a v2 with the subject and
> build fixed ?

The bug fix link can go in:

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3324

just above your sign off.

>
> Thanks,
> - Aditya G

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

