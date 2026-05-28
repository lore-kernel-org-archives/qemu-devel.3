Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EC3CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 07:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSV9c-0004R5-T5; Thu, 28 May 2026 03:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSV9a-0004Pv-Dn
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:27:42 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSV9X-0002yA-Kg
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:27:42 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso5644395e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 00:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779953256; x=1780558056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0qCDPXaHxWaorpx71uSvC55Tu28UVHfzlN+uktRNtHA=;
 b=RcE3xKHYT9/SqJJrTKJOUQaDV6wu4R6871lBs+TZHOmSVOSOSM9Xdpu472ULrltZLZ
 xp6BZUnmEXzTVgNBzZ4E/uudchdfAZEvDAr5PIjvXPlsXJrclk9HUU7BECsx3Eeke8cv
 GeuFtslzaxp58OQKJYIs9KdhJSh2hjjU0bjDqXzmFWf/f9UTx+KNzd6rQuVRvyY7zL+h
 mzcgGQToslFaNmpFW2AZZ9raPTeCOvQb3zTtYGAA7FzymL3+XTjtUUwY81+d6CoiT0gk
 K6CsOEk1TBroI/i1y4r8hMJNfsfZ6p0RHPD5KksEuw8nOSXg8x1E7PKfYl2abmUVd3pd
 MlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779953256; x=1780558056;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0qCDPXaHxWaorpx71uSvC55Tu28UVHfzlN+uktRNtHA=;
 b=Vb2VScKXGLtNGho4b7P+427QbgJeyhgcgOdnIgw1M+mW4ZQzhUJm6KNPS/SQtTxEnB
 B05Rc6Y6oyVMj6ly+sXBvMs6gWlIiQB9Qvx78aTRuuZK9muzhFFXTgkWTFFNZVFrVN0v
 ZZHFrMZkCyOASHm4MWFg4rBR7YAqL63Ln8H8dsLY7+cestDe/lIGXV8fsfp+x/gDG5kF
 jz9Mp4j/2pfX1uIC8uUMGWbsslw+KYvZIJ1gzbatgoRCCAcj97ylxbP66JmtvB+JwW3f
 KrH83+fNyoGUAN9iVCISf6KeTXThmS3zE0i8zjr7E/qr8x9FdrVKpO9oL5xbr6wWiB1I
 +YPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zybkVczFTtmOCtSTtIQgUvQaIcX58rjpJqo5EvsC7j9Unf3d1wR27SvCX/tVBkutiVM0i8mKRiksn@nongnu.org
X-Gm-Message-State: AOJu0YyXSFsYEqB1pqFw42hdnm0nz1BYVZ5I8yOom2FixYhn6Qmsq9zG
 FsDH3RGdguxQacUBDL2yGr5HiHLxAn+qh5lRsKpE83t1ZS9HQUffzlLZddbnZcRCDlE=
X-Gm-Gg: Acq92OGv3i/DRxXHdkHbEdMidwqugkReQg+DU8dZ/YGW/3W2hE29NzDBGJhRkI7djUp
 ThyGUUrSZQ3lem9No7f3CWMZAQaeMhc6qIbOLj0YLDQTVXTwoBi7KHe7COr4kYLkdOll67+bvbz
 CFeSNmKGuMFnP77qmy66hsbzHrR6SFjmlUlrbE2lMaxe5o57z+wW7PxlpnluotohuipoXWGKwRf
 R4v7pPD5qMB+FHT0yEYSpFWODHVmRQ8OsYgjvWFZwgDyxztvwiDF38lHdkRpHGIPXescYAzna4I
 +bYIHKaBaSMhM8NCDFYrxFMbhvQaSwFF9VvR0uJkq9WPxTPVFhgi5cCTIAHFyDFYCsB4ra0GrPh
 Tz07oxinTWoTtyfFkH5sZ+AfOAl0DDw6u18FEnVaIs5ZENoMyaR9906LxxVRifJf2C7LiSwPpeO
 w+JyJ5RgYD4kLl0X7Lid3xfntbQ5WnWfwLM0nu/k3+y1UzgoXYswtZzWiCQmKh2xNLeJMvYKT1H
 TYHWbyBdfHQRXw=
X-Received: by 2002:a05:600c:a00d:b0:490:9588:bdb6 with SMTP id
 5b1f17b1804b1-4909588becbmr1007685e9.33.1779953255876; 
 Thu, 28 May 2026 00:27:35 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908e9b0c57sm13530385e9.7.2026.05.28.00.27.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 00:27:35 -0700 (PDT)
Message-ID: <33274371-2cab-4132-a4ef-0497c7ffec3e@linaro.org>
Date: Thu, 28 May 2026 09:27:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] target/microblaze: rename helper unaligned_access
 to microblaze_unaligned_access
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Helge Deller <deller@gmx.de>,
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, Brian Cain
 <brian.cain@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Jason Wang <jasowang@redhat.com>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Peter Xu <peterx@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260528051642.115721-1-pierrick.bouvier@oss.qualcomm.com>
 <20260528051642.115721-10-pierrick.bouvier@oss.qualcomm.com>
 <41e70c92-99d0-49d5-b233-a7f80f863f8d@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <41e70c92-99d0-49d5-b233-a7f80f863f8d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

On 28/5/26 09:24, Philippe Mathieu-Daudé wrote:
> On 28/5/26 07:16, Pierrick Bouvier wrote:
>> Solves conflict with aarch64 unaligned_access.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   target/microblaze/helper.c    | 2 +-
>>   target/microblaze/helper.h    | 2 +-
>>   target/microblaze/translate.c | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> Duplicate of this patch which you already reviewed:
> https://lore.kernel.org/qemu-devel/20260224193028.2370-4-philmd@linaro.org/

The point of this comment is to avoid duplicated work (I thought
you had these patches in your branches). Should I maintain some
single-binary-next branch in my repository with these unmerged
patches?

