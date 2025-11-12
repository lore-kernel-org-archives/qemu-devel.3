Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7866CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 13:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJAbE-0008Uo-BN; Wed, 12 Nov 2025 08:09:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJAJo-0006Do-GQ
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 07:51:42 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vJAJm-0000jk-Mb
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 07:51:24 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42b38de7940so428205f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 04:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762951880; x=1763556680; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=teFTdwKE5i8/edD+Y7jZbc/885IAXGBXbsf5HW0d9FM=;
 b=IuJVJB9rwWkmLAbl/xmTokcf486YmW32mQ2x6bmxz8cfQFA91v7aInM6fLpbxpEWyR
 65UCtfj2LchxOaNpH3repzdCk3iWi3gYhX/5S4L8uYLkAs8ZX9PCZ5sIR3PrkfoWCP3P
 mnVtBRDiVNey2cvsv+UHK72+mQCTjCsfsr9+NCX+VMf4g3/5r6QpJirjs6iCs34Sz1M4
 jDqzhCr8rL2FvJUlGsFE0JNm+MSsiPUEXrotswSoHOyhcYZSE5kXbqf0B1X7qDKKpiuS
 yYBkIGs/csrC/zwj+1DUQMrJW+pb8WQqr9NN3X1XMkXKS5YCQwWu5Ni/3aEQLu3SXOKi
 mmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762951881; x=1763556681;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=teFTdwKE5i8/edD+Y7jZbc/885IAXGBXbsf5HW0d9FM=;
 b=guHDl5+17jEpmCOBT79jVlbVacX50wwMbgZH66OnPovH6SB1ApJjIfFZUyhe4UjaaD
 MNkTmkd0fN+FzBik2yU6xI6z5g0FWWEYNY1DEUwkqFsH3oJwM7aUsIVBYFAAQlqqGelC
 0ZDm9dfLY6SlwY35K0jQQlqYBHRm+zWNsJfpZ5DI0+uE2VUiyiogksaXPhVrYGDIL7JU
 liWJaVzeSDRebcPLYyHlvLQKPt1GCF+3D4ltAuskzyDWRnO4qiL88tFpnysksLGAtS0p
 uYuxdF7lOiZKSDpsatGYhni69rAjO3/+bhiTl50QOMWTVbRUwPg9UpLm76XxG06DaHQV
 a49Q==
X-Gm-Message-State: AOJu0YwNuiFQ1P1TSBk5PMBmGJmefvRcCe4n+1U+D4ZzA7fXxgSZ+ArV
 qPMFESVF/V2ugOIN5WC2DZLm0T3P+D1dMjBHAv3jjHuVgYvohyPKEIgBuAwoMBcH00I=
X-Gm-Gg: ASbGncuBZz+OkukW6k8xppLq0vDrHKksz3ZHXMdqMn9HPGHfV2efXVTMyj1zA0dUnSA
 TidaFKxcKproeZKEwRhrtKh5Ku4jDtj5dGpVg0pQdrqUXy4j4kfwK797Ql2KbB2rZFdBPYFa2os
 JJ1rzsrekrSfXBsKYlFAtpGaEedqeR+CGDuMcmzuGhNbzpt8waiZyIC5nKyJ9wdDs6H72mmgNZx
 Ee4s0iP+so6RFaR4wLzHyb7HbJOO20aoQjS9hQucemmdLezPiR+xvSwtn58K77nuYtK94ELvHUf
 rFDPIQ6cqUiwXJo3aY0i1xSLy5D7g/SYl4aNBBjU4v0FZeGuFl/qjlHEaGhfKGqV4kaSAwPVRw4
 ldOtylh9CbsrzN6uSbpcqdJzBBrvV3HfceuugaG8cCNAS/szCFTNwxHxN+IODtPXknLa9zVzHAz
 2Y9ozC50sijgSwOX4YXwaJJ6y2mS3UX1QOMlprRgKxiPc=
X-Google-Smtp-Source: AGHT+IFfov8/9r9f5/V0wEvV/SuNu6LXmOvGLvltUgVp6SBsOiYRNPZozzUh7YuUY3ORp3PRhVt9wA==
X-Received: by 2002:a5d:5f42:0:b0:42b:3246:1682 with SMTP id
 ffacd0b85a97d-42b4bb93469mr2636826f8f.16.1762951880632; 
 Wed, 12 Nov 2025 04:51:20 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b29e4b9bdsm30523577f8f.32.2025.11.12.04.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 04:51:19 -0800 (PST)
Message-ID: <a735e5ce-b846-4f50-b98e-68457b1fb616@linaro.org>
Date: Wed, 12 Nov 2025 13:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] chardev/char-pty: Do not ignore chr_write()
 failures
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
References: <20251022150743.78183-1-philmd@linaro.org>
 <20251022150743.78183-6-philmd@linaro.org>
 <CAJ+F1CJ4xxh-y_S89gG86gfEdEYviQ=ajvcC8OW4a8XfFW2gLg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJ+F1CJ4xxh-y_S89gG86gfEdEYviQ=ajvcC8OW4a8XfFW2gLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/10/25 14:44, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Oct 22, 2025 at 7:09 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> If ignoring this is deliberate, this must be described in a comment
>> to avoid any confusion.
> 
> Agree
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Thanks!

> 
> This is from commit 4f7689f08 ("chardev/char-pty: Avoid losing bytes
> when the other side just (re-)connected")
> 
> note: It's mildly annoying that the pty backend has still
> !s->connected and we are writing.

Per the comment, "already re-connected, but timer not fired yet".

> I wonder why the frontend is not
> respecting the backend opened state, probably some race or buffering.

Do you mind opening an issue? I'm not familiar with this code.

> 
> 
>> ---
>>   chardev/char-pty.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
>> index b066f014126..652b0bd9e73 100644
>> --- a/chardev/char-pty.c
>> +++ b/chardev/char-pty.c
>> @@ -125,7 +125,7 @@ static int char_pty_chr_write(Chardev *chr, const uint8_t *buf, int len)
>>       rc = RETRY_ON_EINTR(g_poll(&pfd, 1, 0));
>>       g_assert(rc >= 0);
>>       if (!(pfd.revents & G_IO_HUP) && (pfd.revents & G_IO_OUT)) {
>> -        io_channel_send(s->ioc, buf, len);
>> +        return io_channel_send(s->ioc, buf, len);
>>       }
>>
>>       return len;
>> --
>> 2.51.0
>>
>>
> 
> 


