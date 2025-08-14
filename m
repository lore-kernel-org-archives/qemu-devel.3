Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF86CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 10:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umUzo-000591-1K; Thu, 14 Aug 2025 06:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umUzl-00058Z-Qa
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 06:15:41 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umUzi-00044C-Ok
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 06:15:41 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b47174beb13so478121a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 03:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755166535; x=1755771335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=phIvjDKlGlv1Saxi19QXKIlrYMyfCqI3wfoEDdW1mLg=;
 b=L7Mf4f6df5UxlCErlKhkFOFQ//pNVpLmpZCcEnEoY32DCXRLlL3NtGRRLjr+ZCZugx
 03kuga9NI5oMxeDVUd8ZlD90MKgKDTow0OXIM+4vbH591NH2r3c44CF0xjVhZPIX4BN7
 5r2XbPM1CguLOCtWB3LuotTsH91/iGatOo4J5QPmhYoN2XIBziYZyaAyYON8eXFMZQCe
 TYe/AYyemYzuT2VAwTE5DmT4mDjitM6UKnqyI8Bc1KIygFdQTb1hzJbObZPzA+D6b+Pt
 SFJQMMtcYYrgs+xIKuDp2wlThgsStC2n/xmSpcGrFgivcp+cTGbY2i36vgwyesQ+JzWV
 /Lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755166535; x=1755771335;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=phIvjDKlGlv1Saxi19QXKIlrYMyfCqI3wfoEDdW1mLg=;
 b=VcAjBuTprQ+risE5wG2PuzZTq9Y7W75aVeHpF+s404qLED7r2M/NqLKzBkEheRmyuw
 cWTH2ENSU2iyWUWUdmnfns16ba9wS1WhjGwZqvviAg9Ck6HRMD8XkHh6d4d2TMqYpYk+
 0Afd6rX56c+ttW5NdiC5tkBDgQ8u0daKJECse4OLP8qnBWnGjN0OVr/6p334rZvpbFOn
 LRgFi+fUOVkRTvaeIqC4P2WLzGUnuTUvvRZTgykG0Ng7/nJ09mz8hU/HOnwKS3mtf+Q8
 xqxdqyk48//jxIwslH69JnRS6Jh4Fy6tFL/ZN06j7U2vgtkFMk4RhE57QSD8SQzrWAbe
 ffOA==
X-Gm-Message-State: AOJu0YwwilpIwjOwBhct/X8F+gVDq+D4JjUtQlN98VmR+zvk4eYne07c
 nwRC7LHI7lhI9rwbo7sRByTzWixPbKSofPTBbVlD8purb7UnThGExVPb8Osgr9l7Ayg=
X-Gm-Gg: ASbGncuFQK4wA3z1Ul8ka5Im6bVfZFu1rbC2sFwuYToKchdxL+KWcHcXWs0BF0tlNym
 PEcOywB6yeoH3SpFwgAa7SbketCbmceAJsIskNE8sa4fdein4J90ywX+YFOTDIt72PhkOjhXey1
 fj1WKweGqPFSjlscieU9USVbZ6UK8ELfytc+nyLvR7J3B4ae6wRLiALu3Ck+Y8Cn8wFCUnp9iin
 M4sRFBQK3Ddm1TqUZd+lhCwZcF2NsLgOz4xL3HilVOP2HH2YNCZ0tN7MZxS1QfMPZOkXwbHohnu
 PaFVllnwU2qKFD9CJ0lpEDe6/CSb6QgAkMqlF/3Wxz1AQlRtsPQ6oWo0Zu26O6nhpinJtM6CdjS
 yuW24gzXKqIp27X/t/zVPDRuREo5nwJ+DUpEBhM4iBiZWq0wZ7sY8u7G0/sQxV5FepaKV6rUL1q
 ZXgENrYx0zPGooMQRq734UtH18AUMoqW/9rNWlB9wFx0HJUynOreOHu+c8nb9ydXgB
X-Google-Smtp-Source: AGHT+IEJgMn5UghoKXvah9AA16ZOATQc+ms4pJvvU7jkdG7iHuDnlKvJXT5hPxX26XOx1un8pVkX1w==
X-Received: by 2002:a17:903:138a:b0:240:4d19:8797 with SMTP id
 d9443c01a7336-24458a50a4amr41739945ad.22.1755166535345; 
 Thu, 14 Aug 2025 03:15:35 -0700 (PDT)
Received: from ?IPV6:2401:d006:5c08:e100:bc49:5c3a:83c2:8ce7?
 (19r3hzjy9klp0jf5b7z5.ipv6.originbroadband.com.au.
 [2401:d006:5c08:e100:bc49:5c3a:83c2:8ce7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-243099fc184sm53035355ad.144.2025.08.14.03.15.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 03:15:34 -0700 (PDT)
Message-ID: <5540d49c-e8f7-4622-8363-f53226271749@linaro.org>
Date: Thu, 14 Aug 2025 20:15:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/85] target/arm: Implement FEAT_GCS
From: Richard Henderson <richard.henderson@linaro.org>
To: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <87jz39mcbi.fsf@linaro.org> <411c904c-c2c4-412f-940e-5a9782bf58e3@linaro.org>
Content-Language: en-US
In-Reply-To: <411c904c-c2c4-412f-940e-5a9782bf58e3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 8/12/25 22:07, Richard Henderson wrote:
> On 8/12/25 13:46, Thiago Jung Bauermann wrote:
>> Most of the GDB tests pass. The only failure is in a test which sets the
>> GCSPR in a process to a bogus value. This causes the process to get a
>> SIGBUS:
>>
>> (gdb) set $gcspr = 0xbadc0ffee
>> (gdb) continue
>> Continuing.
>>
>> Program received signal SIGBUS, Bus error.
>> normal_function0 () at /path/to/gdb/testsuite/gdb.arch/aarch64-gcs.c:121
>> 121      __asm__ volatile ("ret\n");
>>
>> In the FVP emulator, the process gets a SIGSEGV instead, so that is what
>> my test expects:
>>
>> (gdb) set $gcspr = 0xbadc0ffee
>> (gdb) continue
>> Continuing.
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> normal_function0 () at /path/to/gdb/testsuite/gdb.arch/aarch64-gcs.c:121
>> 121      __asm__ volatile ("ret\n");
>>
>> I don't know whether this is a bug or just a different permissible
>> behaviour, in which case I can easily adjust my test to expect either
>> signal.
> 
> I may have forgotten to set the gcs bit in the iss2 field along the unaligned access path. 
>   I'll see if I can verify this hypothesis.

Thanks for the off-list test case.

I now see what the problem is: there is no such thing as an unaligned GCS access.  The 
pseudocode for GetCurrentGCSPointer() forces the low 3 bits to 0.

Thus your bad pointer 0xbadc0fee becomes 0xbadc0fe8, which then produces a SEGV 
referencing a bogus page.

I'll re-work the patch set to correct this.


r~

