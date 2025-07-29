Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8497C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 13:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugjwu-000351-Ci; Tue, 29 Jul 2025 09:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugjw6-0002m4-OA
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:00:08 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugjvx-0006ov-Ga
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 09:00:06 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so33792315e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 05:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753793988; x=1754398788; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8cArS9/nRylKOD3Huk40tSuXpNtAKJs4oRFsn3gdCtU=;
 b=R48IJ++fgu4ICHaoO7LwbX1eU5ABlQ+krLkYvYM4XCQEgOR6FLcZon3Hn3J9QmL18c
 r/2HN3t+AE/rPlHR5N1TPv4yJJ6jtDVx54BGhhuBiUl4jfWBLJ5ImA0NtLbHZO/v653v
 VkL5iuMyO/pTmJtv0KyORkKcXGZd6xlgpp1pNn4+xF5zZ/lj750zZCEmkrJr0lw6Ma8i
 lGa4YhZJJc4v7z3/MNtVNAyz7AJjZOoTnb/DIs8qj0telPqpxj9FNlPbnCYL1ao/fHEM
 SfpxrQ6qA275vBjiaiTvXtbT72PmZ/z3nFuChPUwt7EOqSqK+SRYdV/Eq6qd6CNOCQd8
 onJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753793988; x=1754398788;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8cArS9/nRylKOD3Huk40tSuXpNtAKJs4oRFsn3gdCtU=;
 b=T42s1CTGIEsiDjj7rPDSziufXElSEhY4Zn3+AvUlf8N56SW+YD/17XxymIPr7ZYLib
 jkXKQ43AgahssClPXGRGoPNkoQmQxBaBollV2DBqTw06peUuiRW34btsXO+nOOZaNzlZ
 LJVveA8gbBZ8iFZrcLPmSNLFTHpcDVLwpJ1IVE3PdTjnuJeGs2DFtkYeVf5UcRpWVoly
 /v2CCq9DEHKx9Wm39Wm+01rb0b93PGF5OcJZzhHWdcNIDWXtD06eRDIZekyLVd3U65fk
 k/O93h1AW2xmw96tSAHd1Z0ySNSGRpQmXsI4vNugLKLm9xFg8djiGeRCU+WkY3kZ8rH8
 a2DQ==
X-Gm-Message-State: AOJu0Yw/C9RTdCcwNeRtRPqQAMWTKpp9/HOuzz7Js96QCWjAXvTkr0QJ
 cX+GTq8+s7YzPwUlkQ+fJoGbRfhsuPYzp/mGMjyqE/NQFKn7W5kLOjKFK/qa5RZnGAk=
X-Gm-Gg: ASbGncsBGmrs7GGByJ6YJsUux3kpl5202h1d0J7PX+3BHge+BK51ZeRMwFBTIJHdolu
 /KiPhkiDxTdb2oof3Kp+IPkc1bYwXm8mo0hucUO1Ca3q/Lfb8Fbxewr2gVO0rT3tq4PQMsrkbuK
 VJ2gTal9Z6KbWIJFLfAmU7va215P9PBMse+Dt1YbWEUmtZ6vGcwOSG1KCQ/2kniD6I+aFYqZBeB
 k/jvG+YE35ggNLIGR4OQdGTpPhrIOcGLbfR0HmDsS6OXm31Rsm4HgsP9E2ZCkkCA/T/yyGlaBzN
 S96HoAOpyvO+NJrr3yGNCYNN6iWDu8cZsiy8TDkikqTHS5Iiil89T8SF2VRvRUFwLrlOLW8PmI8
 dDdwEWnN4j1kkQER1xrqJFOF56CyIfXkHZyy7YDAmY4GNFYflJ5nnzfFIRKZJbSPPA9LTJLxXb+
 nv
X-Google-Smtp-Source: AGHT+IEB10v4PlEVCKKxdtNYOiBMcTLcOBbKf1RgZTNhwbScPufdOsX77u3Fjs46TLXC/DBoqvBPLA==
X-Received: by 2002:a5d:64e8:0:b0:3b7:899c:e88b with SMTP id
 ffacd0b85a97d-3b7899cea54mr5166832f8f.11.1753793988424; 
 Tue, 29 Jul 2025 05:59:48 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b78d45d152sm3585536f8f.3.2025.07.29.05.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 05:59:47 -0700 (PDT)
Message-ID: <15536eea-5a66-4dff-b4bd-8a43fbfa9365@linaro.org>
Date: Tue, 29 Jul 2025 14:59:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/xenfb: Replace unreachable code by abort()
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org,
 paul@xen.org, edgar.iglesias@gmail.com, xen-devel@lists.xenproject.org,
 qemu-trivial@nongnu.org
References: <20250729111226.3627499-1-armbru@redhat.com>
 <14fff91b-7434-4d90-adb1-ebbe3f51d605@linaro.org>
 <87v7nbdwfx.fsf@pond.sub.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87v7nbdwfx.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 29/7/25 14:16, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 29/7/25 13:12, Markus Armbruster wrote:
>>> xenfb_mouse_event() has a switch statement whose controlling
>>> expression move->axis is an enum InputAxis.  The enum values are
>>> INPUT_AXIS_X and INPUT_AXIS_Y, encoded as 0 and 1.  The switch has a
>>> case for both axes.  In addition, it has an unreachable default label.
>>> This convinces Coverity that move->axis can be greater than 1.  It
>>> duly reports a buffer overrun when it is used to subscript an array
>>> with two elements.
>>> Replace the unreachable code by abort().
>>> Resolves: Coverity CID 1613906
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>    hw/display/xenfb.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>> diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
>>> index 22822fecea..5e6c691779 100644
>>> --- a/hw/display/xenfb.c
>>> +++ b/hw/display/xenfb.c
>>> @@ -283,8 +283,7 @@ static void xenfb_mouse_event(DeviceState *dev, QemuConsole *src,
>>>                    scale = surface_height(surface) - 1;
>>>                    break;
>>>                default:
>>> -                scale = 0x8000;
>>> -                break;
>>> +                abort();
>>
>> We prefer GLib g_assert_not_reached() over abort() because it displays
>> the file, line number & function before aborting.
> 
> The purpose of this line is to tell the compiler we can't get there,
> with the least amount of ceremony.
> 
> We have ~600 calls of abort().

And ~1600 of g_assert_not_reached() =)

$ git grep -w 'abort();' | wc -l
      556
$ git grep -w 'g_assert_not_reached();' | wc -l
     1551

> Whoever merges this: feel free to replace by g_assert_not_reached().
> 
>>>                }
>>>                xenfb->axis[move->axis] = move->value * scale / 0x7fff;
>>>            }
> 


