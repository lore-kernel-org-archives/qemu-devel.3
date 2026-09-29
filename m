Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3649BC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSbm-0005j1-4P; Tue, 29 Sep 2026 03:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xBSbh-0005iW-Cd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:50:33 -0400
Received: from mail-ed2-x0d.google.com ([2a00:1450:4864:33::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xBSbf-0007Hk-RJ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:50:33 -0400
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ac5ef2610aso1450716a12.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790668230; x=1791273030; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B0e1Kl1EeloPRCSvDrjLKAw0ivD9Q7nIR7NywgGoxR0=;
 b=BElo0eH/MovOKFIszSL/Dbc6ACjMAWcSuz4Lqp9r8OuOoYrQJI4DyM9y1CliovpwfS
 VEIWBxcyQrHmdRnfGHIPJ2tdbHNMu9ljtT0vDNSyOKjgn7pg1G5kMjy+HGePhNrlr0+m
 7SIKVF84Qe2za5BObFjn7DuGjwscnVc6rDjza9osj7rVseuDXbI4KhjIGc3HU09flaDi
 6GTFvZlvfMAindgTj0HtQOA0IZfr1+h3TqVB0i6fQbpQClioZXQWgewSpqFRgWW1h+fs
 8kXtBSsc7IFnfbmIffZwygOQDySc+6Pfw1XqdMOEBJA/xx+hE2v9Zgpt9hykbw9WavpH
 o/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790668230; x=1791273030;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B0e1Kl1EeloPRCSvDrjLKAw0ivD9Q7nIR7NywgGoxR0=;
 b=oqkmttsRAlBRGbqveQpL5CcneA/dWI21ZorEjhGyJE8OQDzbSw4wTbLuDkupnWBhO+
 1IVh8EdoGSQ/1vemc6YaA9X6njrOekcbNA+G2JEDBINwqAL5bDzYjPYlUNmCMlxYOyLU
 i0CdWA9cgUlYS0uID6wIXpbQnM8gqMMkpnUr89eeWFpAa0y6xncmhPi6eGBJWeXzoFbv
 3NgzPMSV/eBw/Lo1saCrITJSUPkNkSraYFX5/YJaf8NdPMvuiYbnLN1/7g2oKhWKkhk+
 ZAsPxC3TyfaqJH7PnCYTA9hqxdELOOcc5Lqp459a1zP4t6yRsPs30oBfdhO3L8Z3lbsN
 qdJA==
X-Gm-Message-State: AFq9FYKs71roJKaJ6QYXjnRFcoKAo82Uytz9hmAU8EJc3EN0WheKF1Df
 FZsEKmEZCiind5vrdADgMo+SLkDsPLmgMW/+JmgkwmQcj1kXpnspAcr5UxnZS4U+dkU=
X-Gm-Gg: AYBFou2+cwnTjwHqDD8DLglP08BaylzDCznE13R3++U2FwQ5jcjH8OFRO7uqw8MMfri
 lFYu59pLXG3+Frp02M7v9KwqTRMG8aphmLujJnpZzJ6cTolamTyhJtUpUZxbJ4i6AbkUkU3gM6F
 4SEis/bTAtFFer4Zok89V5C0tmwiU5Q8TsdnZiGctKxcOWWZLXwohM7zmAplIy8bZSQXJIeIUIf
 cIovsJNBSqlQpBPvlIx+YYGvyy4ha2iruk3UeQFJaE2SqUAM6abJn8R7U2QkcnZJdNxcjgKAqEW
 9DEgjgY/rGxK6sLAK4KnMpULnAQU/AnZIjwEpUaaJCe91/rWrr+qAY3rFAAGh4zsnkShTNfXCws
 Sbh392Bf9xZpCcnVvcs3h8gDfJUPo3a1OQ0HFWsnPZKAGB0F4jPBra247no3W1gaLAwGEMnOt98
 IFQCuSIJYku1w/79m3dmqob0mMZC5CbwMUvIohqTKcVEDaUBGyzyQuadh5Je2j/QiXPM1Z4c8EN
 rKaZa6u+WRVKaC1HFPr4QJxCWzSdAdOwohZoENSDGss+b7AO0R2I233zVpsluQ006R6T1OmS2q+
 KdOKig==
X-Received: by 2002:a05:6402:23d1:b0:6aa:f74b:dbec with SMTP id
 4fb4d7f45d1cf-6aca82a3de6mr1228752a12.1.1790668230163; 
 Tue, 29 Sep 2026 00:50:30 -0700 (PDT)
Received: from [192.168.1.39]
 (cpc91486-slou5-2-0-cust898.17-4.cable.virginm.net. [82.13.155.131])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6acb9000b34sm331702a12.7.2026.09.29.00.50.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 00:50:29 -0700 (PDT)
Message-ID: <927a489e-a70e-40c8-a490-e22df7b79168@linaro.org>
Date: Tue, 29 Sep 2026 08:50:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] target/i386/tcg: add decode functionality for APX
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, chang.seok.bae@intel.com, zhao1.liu@intel.com
References: <20260923173021.317809-1-pbonzini@redhat.com>
 <20260923173021.317809-14-pbonzini@redhat.com>
 <58073b08-9f64-400c-b8a2-acd0baa4add5@linaro.org>
 <CABgObfadcML=HsEfHXBg8ru5m2eByerxHZaKN8UOJQRoTSKTZA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CABgObfadcML=HsEfHXBg8ru5m2eByerxHZaKN8UOJQRoTSKTZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:33::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed2-x0d.google.com
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

On 9/28/26 13:16, Paolo Bonzini wrote:
> On Thu, Sep 24, 2026 at 5:17 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 9/23/26 10:30, Paolo Bonzini wrote:
>>> +    case X86_EVEX_APX:
>>> +    case X86_EVEX_APX_cmp:
>>> +    case X86_EVEX_APX_pp2:
>>> +    case X86_EVEX_APX_zu:
>>> +        /* Only reached through EVEX map 4.  */
>>> +        assert(!(s->prefix & PREFIX_VEX));
>>> +        if (s->vex_l) {
>>> +            goto illegal;
>>> +        }
>>> +        if ((s->prefix & PREFIX_EVEX) && !validate_evex_apx(s, decode)) {
>>> +            return false;
>>> +        }
>>
>> They're only reached by map4, so surely
>>
>>       assert(s->prefix & PREFIX_EVEX);
>>
>> is more appropriate, and the subsequent test for evex moot.
> 
> No, validate_vex() is also invoked for non-VEX/EVEX instructions.

Of course.  But how do you get X86_EVEX_APX* from non EVEX paths?


r~

