Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CADC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 09:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsHCk-0006RZ-CD; Fri, 07 Aug 2026 05:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1wsHCj-0006RE-3S
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 05:49:29 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wxchen0913@gmail.com>)
 id 1wsHCh-0000Hu-JP
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 05:49:28 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84874b52eabso4282182b3a.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786096166; x=1786700966; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+3VBkwCw6t8B4YZFfVBDh43NXf0CXsweVCe+7Wnt4r0=;
 b=q7yJW1YqK76qj0AWNy+IQd195fK3N+AEA629ayAHnAWTUHoz+GSQ+pZwPpoyJZ1i4i
 W87Eo6wrsP6KQwQgT+QxFdEaL4pOqep9sNOfgwnDHuos7/6k7wiYttuqFUsBmrBuZXWX
 dEPKfVMIdEA4aKaR4jJaWK34pHwRo4JbNrAKw4V0FjiuvcKuLhvdivXxEbO3EDSrh+Gt
 90Y9ta54pfz2Y5IKlaqmQp/YWA79qsPIHZpal9b/rYGrqcg4Oe2SBjva8VOyid1XC0fL
 +Vzv9z7gqd3EcRikARsRMhtNKVuve4i1G+mik5cOvBgG6gms3cvDosGc0Rvb8gjcr6+z
 OHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786096166; x=1786700966;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+3VBkwCw6t8B4YZFfVBDh43NXf0CXsweVCe+7Wnt4r0=;
 b=nVRj3SNAdESn3+sHYCyLKdtr2hOONUrhfUUSurXzipamyZ/gDxRlqC0LZi4gc8AOnq
 vtJ3nAW5SjUxmbGOG4W2unPcb2AqlQRV6jvr3RmzWcw0ZxR98YOh5L9mGOEMPB2xU8Y0
 Uu1ZVfLpYk+Ki1x8a+QftmkXvoRe6ECqffFHg4F+kP4jMDyICetMlt29S1wdzR300vfF
 I+rLntYpKRKqyi4nrUN/SGwIRYOxmnEx0cLWrblIz+kjrfbZUtALtFEVQdt9Wf5s66fF
 fv6aJfomslmkviL90QLCe6W820/xis+vy6azBHl69vtI4K6FgVOLdcq2M43rqrygrPIx
 r+xA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOxcdq7mBFBur78+O+S2V6B2GoQrj7yj13TS7Qs6ejB1qyEqFyCvupCYWSFr9hIkEVR6wAvgM9XUJ1@nongnu.org
X-Gm-Message-State: AOJu0YyxNrLN9Rlxg8Tg+oGAFOVgdOrvQW+mjvuJL7uin5kHKSZpXh47
 kbbmJRxDjv+l3BD6X56TkKU0yEUb8XR75Ku/IZHikjZ52eNzeVHSnZtm
X-Gm-Gg: AR+sD12u9xQEuEoRbj2dONzrpEpNVBo4Yfjqe4t9RKSTdQQCF4hbVB3Og//L2f7b+Ml
 Q6VEk8LikpRIPFZPj4wugbfhuFu3sBDut0cZ81qDeYeXUZNRUa533a4SB3JYwP4fbdarAldUShd
 U3OnQQFN68aEXvJjbk5yvGOYMtq2gOUKh8eT7hP1k9OvoY1n3FoNftcLYS9DyUPq02HTgr/NS/3
 kMIYKNnnmdXghqtNjRudUfZpRhiPU4GpcMurq7+RZ0S679CsHmuMEUSz+GU3Cd2II1xSdBxebQL
 ZsbjXqfS8+NOI2TibLXW+V7TmCbtPKMLi8XrpsBSFQpoesr2j5HBnyvmUqoc7tOZAAIb4rh1DxS
 JyhAL4OwKCVjzBMtFYWKYvccjNNoHfwg5vyn/1sL5LWBu9RpIGf60NyQpiwlpno7A8Ghq92unw4
 OaGRN3R2nxIsslHy3MHBAlnL/aU+IwSaouOJm00qwgZ5q6LpeL8kbfUlAYzQMR8Bzu
X-Received: by 2002:a05:6a00:4b56:b0:847:8650:69cd with SMTP id
 d2e1a72fcca58-84f5e0d2cbdmr2561907b3a.33.1786096165753; 
 Fri, 07 Aug 2026 02:49:25 -0700 (PDT)
Received: from [192.168.200.57] ([14.19.80.247])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f0ae02dsm467925a12.0.2026.08.07.02.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 02:49:25 -0700 (PDT)
Message-ID: <33f15edb-9bce-4f12-b205-eaa4b4d5290d@gmail.com>
Date: Fri, 7 Aug 2026 17:49:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 1/3] hw/char: add K230 DW 8250-compatible UART
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
References: <20260725-feat-k230-uart-v2-v2-0-d5fe82c47c28@gmail.com>
 <20260725-feat-k230-uart-v2-v2-1-d5fe82c47c28@gmail.com>
 <d079904c-e1c7-4495-bb3c-88c133bf1508@oss.qualcomm.com>
Content-Language: en-US
From: zhenbaii <wxchen0913@gmail.com>
In-Reply-To: <d079904c-e1c7-4495-bb3c-88c133bf1508@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=wxchen0913@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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


Hi Daniel,

Thanks for the review!


On 8/6/26 04:01, Daniel Henrique Barboza wrote:
> I believe a helper like 'static bool k230_uart_receiver_status_int' that
> encapsulates it is more idiomatic. 


Agreed. I'll make it into a helper in v3.


> If I have to make a guess I think these macros were being used as easy 
> knobs to test
> the emulation, i.e. manually enabling/disabling things in the header 
> file, rebuilding
> and see if the behaves as expected.  Which is of course fine, but 
> unless we're
> willing to make these knobs available to users (either by making these 
> available during
> ./configure or create device properties we can set in the command 
> line) I think we
> shouldn't use them in the logic since they're all hardwired.
>
> This is more pronounced down there in k230_uart_read().  We have this:
>
> > +            /* DLL accessible only when not busy. */
> > +            ret = (K230_UART_16550_COMPATIBLE || 
> !k230_uart_is_busy(s))
> > +                  ? s->dll : 0;
>
> K230_UART_16550_COMPATIBLE is hardwired to 0, hence this is equal to:
>
> ret = !k230_uart_is_busy(s) ? s->dll : 0;
>
> I believe we have more instances where we have a hardwired macro being 
> used
> as conditionals in the logic.  We should eliminate all of them to make 
> the
> logic simpler.


Yes as you say I use them for testing the emulation. Indeed it shouldn't 
be left in the logic. I will remove them in v3.


> These are all hardwired thus I recommend creating a macro in the 
> header like
> #define K230_UART_R_CPR (....)
> that encapsulates this value. 


Agreed. I will fix add K230_UART_R_CPR and the UCV macro in v3.


Regards,

WX Chen



