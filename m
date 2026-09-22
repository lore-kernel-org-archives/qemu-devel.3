Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2A3C98308
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x98Uu-00066I-NN; Tue, 22 Sep 2026 17:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x98Ui-0005kD-UA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:57:47 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x98Uh-00016h-F5
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:57:44 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so255454a91.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 14:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790114262; x=1790719062; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=62egXPdTBzA26T+t5I5KxPdayylUhigusUAqoU+43/M=;
 b=yBALZX9rIqXlFXTiOKLcVNlw3Jgxu40Py5lvgpqnubkyB8efNaff+zTHtIIyrZZfy5
 U3GzEP5EQxccrgahwZj6+GtAHo7fA5rE9nw1itIWsY0FElAVNKZaehknWIAvl0u4hspN
 SZCEV0BfTuQ5ys79X4qut6/4ZgPDaYuoi4FVDwKtz2AXVpFqfJvE4xGItAGZRXy3WFJi
 FRXKo2MI9+fOQV4e0BaBOcQg5rNGmh/OAElGa6l5+JqfckDHw9YZBGD6povQKzzpxxT6
 tmswxHZQrcFk2DYl/Xz22IYL0HPPgrPzL597VGOOzz/9XxBF3Bk4/rAIJLAQzvLZRm4P
 3QKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790114262; x=1790719062;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=62egXPdTBzA26T+t5I5KxPdayylUhigusUAqoU+43/M=;
 b=VITKwFyy5sDB+o/xD0j5Pa52YTb99qGAAqjtzoDbuNp16mIfikDUXeuke/uJp/menF
 1hnBbAiBafSg4ocr1Lqsk/Pc2Na1lLSGYeo60hQo8n2/t5WRFn7cyytwe+boaI7jZcFQ
 bTuEPK9uzx0g9KTZB7ZTyuWySkX63Jv9kIDPUewTLchv9tX8Ciw0FRmOpsVnqCEeA0FF
 qKESazJTtsnzMqlgwQ3iTkeajWamJouaFqRju4FV2GmPTl555AOglYXR7L6xbpLJWBbx
 PCMxdxx7WeaNgqNNle95f6Hm9ysHxMJrQz+jyXZf4N8qcJIXuWpAsdg8BKqqGCa3HvFM
 ZH9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDTPCuvUlBRd+M25ys4UvPO+ybfYLNlntIj9RnHVXw4rNR06zftorTZWY13cTW5Li79KDFspdUceFr@nongnu.org
X-Gm-Message-State: AFuF++k2JE4sxuMtBjcz6U1zm+te8LU0ms0kNjSz7HjLW0BE5yyb1YX9
 NJWZy4hA4yWrO56YObThhTjE2u3CNXFx5HgLcHbFPnh7CmfcppzIDdCZYprMzEtcL7Q=
X-Gm-Gg: AYBFou1XDxKYE741bmDVB3G0UGqczPzLdC+EqqiJNgv2FHbdqCIA5sCHfHrIwmhSIH+
 e8J5Z4KjwHskiHEWS3L5dOVOgfSYZ/KGOpk/E0wzVnAQJNVmJ9NjPqJDFmRxRQi56CySl3YdKbL
 lUXV5/GnrLxLCMihok8Bb3he68xc/hIgb1pNMYPUcVoUBMLPwzBGxuvBOCkB2FeHb5ZX+XD1U7D
 pIEmu8Mfzy2RPmoCbRvb9Y5Z+Os/RRJPHX3kLo4S6MjwrErgiI2aoCewqSx/qXBX7RYjDGRK+A4
 PsFFXa6lCYlBFUcChqXkFHA2FDLye2ZRXtZJgQTw8r8wSKdiqezxdbB1wHW3DC4s4iVeU7hel+o
 Sy0dz4QU/TZ0vd1P2hTJ4jkigVrY70XNDPYwbDgfSfty1UDV+O1jWUInJdrIoIBsfQnBIbpusT9
 KJANnlVevLafggdjmlxZhAY1bhthpWEHwZ2ZHIvC0pRylshRrKCnwpHljS6TBOCjZ81n31KGKZT
 T1QwS3vOIy8EQaHFYfXA7Mw2Bm/SrE2KK+pEXk5
X-Received: by 2002:a17:90b:3dc3:b0:39d:ef3e:9035 with SMTP id
 98e67ed59e1d1-3a07e541715mr607480a91.10.1790114261755; 
 Tue, 22 Sep 2026 14:57:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a07dc2923fsm1238398a91.11.2026.09.22.14.57.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 14:57:41 -0700 (PDT)
Message-ID: <a2b8a69d-38b9-47f6-8693-a5ab7c757c1c@linaro.org>
Date: Tue, 22 Sep 2026 14:57:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user/sh4: fix race in atomic variables
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org
References: <ae75af55-eb9a-5ac2-9288-aa116a3c4000@redhat.com>
 <dfa3b2ca-b87b-4581-9769-2f90aba86c56@linaro.org>
 <2845945d-4d46-3ae9-8182-7d2288ff06ac@redhat.com>
 <a435c784-849c-4a0b-95bb-182068d4abfa@linaro.org>
 <f5f389df-3865-b0de-4b91-da40a5a05256@redhat.com>
 <c621f948-add2-4e9a-9871-344906c7b662@linaro.org>
 <d1a29727-14c6-fe95-c01a-30fd63e3ec4e@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <d1a29727-14c6-fe95-c01a-30fd63e3ec4e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/22/26 12:22, Mikulas Patocka wrote:
>>> BTW. what happens with synchronous signals inside the TB? (i.e. SIGSEGV
>>> due to writing into a write-protected page)
>>
>> Synchronous signals like that exit the translation block right away, leading
>> to the signal being delivered.
> 
> So, the TB can exit halfway through?
> 
> When I was analyzing the bug 2998, I found out that Qemu marks pages with
> executed code as read-only. When the program writes into them, it
> invalidates the translated code and marks the pages as read-write.
> 
> How does this interact with TBs exits? What happens if we write into a
> read-only page in the middle of the TB?

If it's just about tracking writes to a page with translations, we won't 
exit the TB.  We'll restart the faulting store by returning from the 
signal handler.  So the gUSA region isn't affected.

"Real" faults to inaccessible pages will reach the signal handler, and 
unwind_gusa() will revert the region before stacking the signal frame.


r~

