Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A047AFF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH2S-0004M1-Ro; Mon, 27 Apr 2026 04:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH2Q-00045J-VJ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:54 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH2M-0002Az-SB
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:54 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso99990025e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277389; x=1777882189; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xY4l3Br8VldKR3mDFA59KHY/IuQKoOYprjbC6B0KEY4=;
 b=k+RYA3RHzRXx7QgW4BpFerOEzJCdz0hHiCC9QeQPAYb3CcaFzTKJ3h3WonUWHWbwpM
 1UxliXQReZZFehOBg+gojfSxNz9P91UX/bhoci1Zcpi+/X6JS4hO4vJtP/A3IkgZHNcG
 3ljJG+AIlar1J9TaRfmogFezxBs31tcCP+sxMGHmSG1PN1xbW2AdLHpGiy6eJtdAWb1d
 sH3PdMKsjUcnGaB+l4FWNSCiDk5FDUgKOatcdGMPVCV9PCF4AgfCu9ki7e6JYBjxFZ/6
 eyA2ClLKwhiSUnRZsiYBcH3bRJ2ezb8uCCBSFC1eO6sc570RavQbx1Q2LxW+Jjrx4VtH
 bzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277389; x=1777882189;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xY4l3Br8VldKR3mDFA59KHY/IuQKoOYprjbC6B0KEY4=;
 b=nq53vckfeZUi91vjN90Cl21faPgaXXAF61WGNsXLb0tTFpAOWVlWTPkUb+rK2qx6i/
 SJQNXPCfyT/W9tH3HZ9YdCti8FuABXNPOefoUUKOtrzwnU4ngrcJReIqolPye2WrPWFJ
 xIFDI6641R8kIisg1zCwHBKowUdteTzlpJizkhtj2eo1UEaVdC14RDZ/HTRw59hn/mOA
 emodQA2KoBdfvoPcbxKBxFdvk7IAqfDhqrmqeK/begKRpzKvd5MKL+Ql0InuA4KBcNfG
 Puuq2OHaVrtmbWMIXLuBJbGkBsuROrlI84TgzREC1Vd5IEk+XVpRdBIuNACUKfN4Bm1C
 yIhg==
X-Gm-Message-State: AOJu0Yx8HkX4qbhJabEx2QMAcNOHGWpiaK8vxO3yrkGs83rGPPfGo8Ef
 5/o69GQKO2Lx00P5PD5hOLoyVnoWx1mDH+L4iPPEaJGDa9dWwj9jqLmfmIUCnvm4VQkgNnB3oRt
 YI1PypKI=
X-Gm-Gg: AeBDievPNDeK5wT7gC/n/I88er+Yerzd+8eBcwCL/MTJGfHl26zd0Z21GBMhIKLa59W
 HKQGKmh3ldHrwMyut/Pq27vEx2WtoeVFfeFNqvx54N3dvdKq7oP1ewtdhCkMFHKW4Kc0YklN2wA
 RvDpaPmLTnCbqcpmbqNuICAg6IVu+0vlAFtm1jcUpPQuMFU2Sp0w+1WR/TEXTMiJABwmbdzcG/y
 UYHBylAXbnQcqPf+0Psj1CSsQtwfNBhnhsXX/EUd1GqdR1U4/41a7WS7TCaPZQQIZLXY4drMhqj
 GIv2tiG5Z1WyKfHL6slzu8krIj2KbKKyFPDcL4iNQaK/G+Zzy94rZnP1H1NXF9pkbph3KkhDJED
 Oq6Jnb82wq05QIovpg5PxcDxNlXcubro5V07UASmifU4jTy7TB9G3UHa4r7jylgeYH+20fOQnRw
 tlgJa3uSdfq/nQvAL1+xZ5n2MmBbV9OjpPw9yl2YHhPMeXYLbNfZZWqO1GAkIOGr33+8drwppUN
 jWr
X-Received: by 2002:a05:600c:a410:b0:48a:5821:6006 with SMTP id
 5b1f17b1804b1-48a5821692dmr305090515e9.4.1777277389299; 
 Mon, 27 Apr 2026 01:09:49 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a52d232afsm162741295e9.31.2026.04.27.01.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 01:09:47 -0700 (PDT)
Message-ID: <d434b8b1-e79c-40c7-984d-1164543c7069@linaro.org>
Date: Mon, 27 Apr 2026 10:09:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/27] monitor: Remove need of per-target handlers
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260414003001.97571-1-philmd@linaro.org>
 <87v7dgsn5x.fsf@pond.sub.org>
 <fd5734e1-b4fd-4020-808e-90773d8d9403@linaro.org>
 <877bpwsj45.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <877bpwsj45.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 24/4/26 13:17, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 24/4/26 11:49, Markus Armbruster wrote:
>>> Doesn't apply to current master for me, and patchew couldn't apply it,
>>> either.  Got something I could pull?
>>
>> My single-binary tree is having various dependencies on this series,
>> do you mind if I merged it myself?
> 
> Do I mind if you take work off me?  Hell, no!  ;)
> 
> I asked because I'd like to give the series a quick eye-over, and I need
> to compile locally for that.

Rebased as v4: 20260427080738.77138-1-philmd@linaro.org

Thanks for the quick eye-over!

