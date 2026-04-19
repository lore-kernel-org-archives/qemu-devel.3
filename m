Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB032EA719A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 16:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEUjv-0006j5-79; Sun, 19 Apr 2026 12:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEUjT-0006iD-GJ
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 12:10:52 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEUjS-00080U-1N
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 12:10:51 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso1274365e9.1
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776615047; x=1777219847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8HL80pioVPrcP9MAPQXRilyJEi0wxBmY35dvijnyGIE=;
 b=xTzwx1Xit/mUoINfyesIE6Yq0s6YUDCzWHTDW8cSqQ6xT3qPS/ejyadLQf4HWyGJUk
 WOi7sgdDKta7Qb/0n8qt0CuVR38Bv2hPzL+iq5naqH2SxMppx1RzJnBOFNe0QGnb07pS
 tYVd3s77CK3IQvCwsc2paJYNv+Ri1yNla8JIB3r9lsylioZu6WpKMjf8cNlYjg6VL9Qh
 2pvBeQfn1bte8AmRod46BrFBDwmsU/Wb+ZrbZG30ZIdxHbYpBaPg9q4EujvAWfSZLDWP
 4vDvxLaxi4gK6YkzJMfmvQed18R9Y1VfqMxdFkCSpXaqToEYDUf63Ctt4wSgu22N/iGp
 DFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615047; x=1777219847;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8HL80pioVPrcP9MAPQXRilyJEi0wxBmY35dvijnyGIE=;
 b=YDxFjiwUZOCLZStCGykQPUZIhZsIJBk5BIjZhupjrXQpBs725Nm0wtRSBybR9zrk+W
 71amm/kE4Ia402P6QWMwa/CHEnDmqbyNe5Edh7dQigZrfdn9JULpsLDv3Lfsz2tcMAba
 DbyLbQnl7TI74a+NmE4JmGAZn39Vw1ZzDfgRdIQwWUj5DLJ/taWXR+tsPpSJh9gXofrD
 xPSM5bTlC+PuuUFmBAZssQYRiZ6KLvaNxCtXMva1q+Q4EBOB6Ip/s1tdjccMHjKW7C3l
 IdyzuomW9Xw88HYEYRPY+k4mh6RgOm0CZYtwbBUFQOz3zuqDQbqT+C/wva6wjAz1lvtA
 Byug==
X-Gm-Message-State: AOJu0YyEkPpZlmuTIjeMPDHeA6KrVCY1p84Mnp77x3QAG2JHGs9YXcz3
 5Znv9IIxxPB9/U4NHR+mmXK4wZ7tGwcleu2XdVzOIFmRAaCHLVrQce7rfb/j/zfEYRQ=
X-Gm-Gg: AeBDietth+6c6OGgMA+JGUKsScy9fljVwrQeO/vH6NrJ68yeVPnbtUGaYvhTz9gLv58
 pW9B8UWKWLoOJiatQxfDDprlazegwxiZF7LW3e+kUTfNgBfUFiLxibGTh74+eJjA6CnMMB3jS+I
 JmMirNb5FCil12AWfDkgpD24zqTR9xi8JaiBO3LcW1v3etDtbzp5SdSSFitzHG5K1lSeBuWWR1I
 tLaPKHC1VYV5/BWyvpFA0yoPPevFcS/jOMrI4lxoa2sGryqMlypAMzITZ2mukwj0fb03e3r23Vo
 08BlukU56mmmBXdoNxhtQvpLkeXEV2KeYaIt2aI2qkQWx2n48xpYHkloQmBECy28+aPX3TLDh1T
 AL8kD5ZUERb/kBOhwOoCWiLScQSaVxRveYj+A4o9EMfYKrq3k9KAOAfPqGheuw1eXXteO7jT8/7
 e0kf5iIg5H4PNr8SqPaIxymVOC0pHb8NbdZ1dIdAmyWNSnBqc4eLivzD0P6FmX2xLtgqcUnYr6F
 t0t
X-Received: by 2002:a05:600c:8b38:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-488fb796fa0mr137044735e9.25.1776615047261; 
 Sun, 19 Apr 2026 09:10:47 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc375dsm19669804f8f.14.2026.04.19.09.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Apr 2026 09:10:46 -0700 (PDT)
Message-ID: <d64dff93-7129-4c39-bf9f-d2a8cf2ee4fb@linaro.org>
Date: Sun, 19 Apr 2026 18:10:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] target/ppc/mmu: Replace legacy ld/st_phys() ->
 address_space_ld/st()
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20260319111936.68041-1-philmd@linaro.org>
 <20260319111936.68041-6-philmd@linaro.org>
 <0749ae60-f6df-3cb8-bc5d-b46f4c20995c@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <0749ae60-f6df-3cb8-bc5d-b46f4c20995c@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 19/3/26 13:59, BALATON Zoltan wrote:
> On Thu, 19 Mar 2026, Philippe Mathieu-Daudé wrote:
>> Prefer the address_space_ld/st API over the legacy ld_phys()
>> because it allow checking for bus access fault.
>>
>> This code however doesn't check for fault, so we simply inline
>> the calls (not specifying any memory transaction attribute nor
>> expecting transation result) per the definition in
>> "system/memory_ldst_phys_endian.h.inc":
> 
> Recently when trying to remove _nomigrate memory region functions I was 
> told if some convenience function has more than 1 use it's probably 
> worth to keep it. This looks like similar case even more so as the 
> replacement is unnecessarily more complicated. So what's the problem 
> with ld_phys in the first place and why do you want to replace it with a 
> less convenient function? If there's a reason maybe say that in the 
> commit message.

We want to remove the legacy API because it does not "allow checking
for bus access fault." The cases where we can safely ignore it are
rare, and often ignoring it led to subtle bugs.

