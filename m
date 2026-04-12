Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2A0E93804
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 20:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC1sZ-0003L2-4O; Sun, 12 Apr 2026 16:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wC1sT-0003Ko-JB
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 16:57:58 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wC1sR-0007nA-Nd
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 16:57:57 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so392996f8f.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776027472; x=1776632272; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=09PqwNmU1FaK0txdsT0YCjxAuFR71lGoXBL2cRJstVY=;
 b=hPw2MiE8bOyl+Ls5//ZqiAY8zG3SEUoYsn+UdNJerctbltX77TSR2JmE9c6t/cRjuY
 1WyMpPGK/kBJ4sqO3Ka+kJb+Z8q3X6C4iiMnG160GODN19LkBOskws8DbjYt5sN++23k
 pIyQVm7d1qODamGgQTcSQtv+5P1p6yMHtkRcNLEI3RaX/QD8CTfqsAMpnYtpeRlekEDO
 J7KerP0rNon2tF4Bc+J5ZQhzDM4EdLjrc3WkWVhXfj+8DV5nxDoBuhpRQzZ+gOVwCIUB
 R9y5Po0FieYgGuUyBvjzhjMoL7fWFF35L4zHvARsjrzJt1puyRMQa4vyrk2ECNyWon7+
 fQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776027472; x=1776632272;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=09PqwNmU1FaK0txdsT0YCjxAuFR71lGoXBL2cRJstVY=;
 b=YRVE8sFnPXcl62G2Bv5o7PVnuMW37XlK9aMFe323rmLAutCv7sfRss/ArOyZrdZ5kL
 gqZfwW/kgez1fDGJWw3HJQulgV8IezezYNXZ2JOYPtmBby3vbAsJS9++21hL0Z/1Yj9u
 JqD5yrNkhD2OCoYmtsG8qgfHeBxnNsmIV0NbKVqZZqdZnm39KZinMFmijAhG/9L2FCYm
 bF0XjHFs75jeA+EzTwSXxgek6dx+dGgNTWbhJTuuym54/G4Yb4QNdgYKJfpdoyF9gqOi
 GVc11qGS2Loaf8Ui0R6UgWiWILqjw326F2m9q+kwk717cQeLK5TKaNYJRvPnP0Z70qr4
 RpgQ==
X-Gm-Message-State: AOJu0Yyki2UoFhFsFjN2aOdcmO9THLaWY+FvwR0evrEtMLKABAiqyQgQ
 aVXGDWFS3ng7dsTd9ACK07XJyrT6wDzWVHn+O1tIA5UD/ldtThZA6OSaaVVuhkG8IGE=
X-Gm-Gg: AeBDievsNsl2r/I+R74BO/e4xlXuFtPqpPL/eQ3WhkCORCYVi7bWN2uJmxe3q103zFB
 L9w/4HfLHAxIP1Hn5CqJxPU53jyfNRW3ER/psUGDLKn8UPaMzapV1MKf+jmTyjHP/EA8tceTCov
 CMu1cDOq/60svNSGEs6jzszVdLFe4bOchf/dA/oqx9IJ3wRjRGrc6GnJndigI1vJyl31f5nXHJj
 ha9tp8XFLVTEV8QC+G8z/n7uE6b9ta9xfMO7ngALTgvCLQyXn4f8TcRqdmTkgZkh9Ta+yhct/nK
 ft7ysvFQUFiSMgTCwaDEGlMiHl+aBwJk0rR8PFrZ8Pes4gY77cfmBUDJZvzrMJeXhAuO8DxZTsU
 pD5PSKnvQI9qTbqSMyRj4OsZ7A681aGUwvYvxx5lfyLyDN+XZ4iui5wFzRXScCTN2/owU/jXOxq
 HWtlzlHhtv86ydxhj1YYa6d8SNQEMblp9BlU227UEcONxhLbsunhVj1Y8pmPg+nvh8HA==
X-Received: by 2002:a05:6000:3104:b0:43d:258d:8fa7 with SMTP id
 ffacd0b85a97d-43d6492e85emr16797281f8f.7.1776027472310; 
 Sun, 12 Apr 2026 13:57:52 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63dec27fsm26525499f8f.11.2026.04.12.13.57.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 13:57:51 -0700 (PDT)
Message-ID: <fae0a954-fd89-49f7-848d-74f352036176@linaro.org>
Date: Sun, 12 Apr 2026 22:57:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 48/67] ui/vnc: merge vnc_display_init() and
 vnc_display_open()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-48-231416f76dc3@redhat.com>
 <4dabec5f-1700-41a4-a36c-526b9f096460@linaro.org>
 <CAMxuvaw9YOsJihsQDpLjhM3ohk+h_JoeHT-6S7KvPuwNCReHSg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAMxuvaw9YOsJihsQDpLjhM3ohk+h_JoeHT-6S7KvPuwNCReHSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 12/4/26 16:17, Marc-André Lureau wrote:
> Hi
> 
> On Sun, Apr 12, 2026 at 2:31 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> On 10/4/26 21:19, Marc-André Lureau wrote:
>>> Combine the two-step vnc_display_init()/vnc_display_open() sequence
>>> into a single vnc_display_new() function that returns VncDisplay*.
>>> This simplifies the API by making vnc_display_open() an
>>> internal detail and will allow further code simplification.
>>>
>>> vnc_display_new() is moved to vnc.h, since it returns VncDisplay* now.
>>> Add vnc_display_free() for consistency, and it will be later used.
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    include/ui/console.h |  2 --
>>>    ui/vnc.h             |  3 +++
>>>    ui/vnc.c             | 75 ++++++++++++++++++++++------------------------------
>>>    3 files changed, 35 insertions(+), 45 deletions(-)
>>
>>
>>> -bool vnc_display_init(const char *id, Error **errp)
>>> +VncDisplay *vnc_display_new(const char *id, Error **errp)
>>>    {
>>>        VncDisplay *vd;
>>>
>>>        if (vnc_display_find(id) != NULL) {
>>> -        return true;
>>> +        return NULL;
>>
>> Can you explain why we don't return the VncDisplay found here?
> 
> `vnc_display_new()` is called from `vnc_init_func()`. If we have
> duplicate IDs, the function returns NULL, which is treated as an
> error.
> 
> Duplicate IDs are handled earlier by qemu_opts_create() though. So we
> could assert() instead ?

That would make this code path clearer for sure.

> 
>>
>>>        }
>>>        vd = g_malloc0(sizeof(*vd));
>>>
>>> @@ -3451,7 +3451,7 @@ bool vnc_display_init(const char *id, Error **errp)
>>>
>>>        if (!vd->kbd_layout) {
>>>            vnc_display_free(vd);
>>> -        return false;
>>> +        return NULL;
>>>        }
>>>
>>>        vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
>>> @@ -3464,8 +3464,13 @@ bool vnc_display_init(const char *id, Error **errp)
>>>        vd->vmstate_handler_entry = qemu_add_vm_change_state_handler(
>>>            &vmstate_change_handler, vd);
>>>
>>> +    if (!vnc_display_open(vd, errp)) {
>>> +        vnc_display_free(vd);
>>> +        return NULL;
>>> +    }
>>> +
>>>        QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
>>> -    return true;
>>> +    return vd;
>>>    }
>>
> 


