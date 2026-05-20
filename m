Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C9ECD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgW1-0001xv-KH; Wed, 20 May 2026 08:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPgVw-0001xB-8s
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:59:09 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPgVu-0005lm-F9
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:59:07 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso51502795e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779281945; x=1779886745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NfFVXk9zPzwACKkYzWPwHDJ3Uglaw/xAjnVZUJOJ1I0=;
 b=QLcbN0WITsWTG3qs+evtiRfibUtDMk2jex26s41YtQ2Gdg0ZnSrtz2+8SaLfwP5E8g
 sZnXmCbByP96J17DttKVykhiACZp/BE+u+V/BMop8BNMVwRkQojUARXRNM+qLmJ3t0y/
 2UAnjZA2GkDaZfSHHuyJodO4++nW7tRAMIvWMDwOyFkbP22L10wkeB+8CcPeNnbTAQGe
 z01c9n+z0Zx0SwTuhJ2uoRnJr9UR/HphB+92eE3g2VmIjey8gFZn1pd9dhlghmzFHzLQ
 nx5rR/MSJxRPWZry34p3Ok/gMVckrr1GYR7EC59MyF7zU82z9VCSP4DsrYaWlBLUcTZv
 cULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779281945; x=1779886745;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NfFVXk9zPzwACKkYzWPwHDJ3Uglaw/xAjnVZUJOJ1I0=;
 b=N2q+pyvSVyz1VZPsOFcAGAGzQsDwhYDp6c5telNmbnVeO/z/WmqvKsXX4pG32cL9Zq
 TlNTi9xelhdAg+oNSzBXvGBX9RO4EF0Jwd90eS2vL8bqc+8ojAYsmFZVdkChlIPeIl9b
 Q+uUckPSnYR5KvOPxbguV3yj2HnMhRm9hIbORE0KI5omxUhUXtVCRSaey6pK4IKsKi/w
 Xizv696JA5A9ohF7UHGzPJvglXpzd2sO+Yc1UNdE8suoOk41zOLQk8pzg/i8jPC3jme1
 TU/MkmQewCPO9Sf2eClVvH+LOeqUiWT1+GKYf/q99mI2MMNxVGUGXBB65iCXWPMuQ/ch
 5blA==
X-Gm-Message-State: AOJu0YxE+0dYwkvUErPKa9k2oGtqtFd2w8oMeMHCl4jLaWXbTcDxLFkt
 8VEr/rdD6hlkVKFSpijaZpBpaJHGpaEU+4dTO58wFVQvPBn2EATg+HnH820i+Bc5Ny+pCRc+QuQ
 uU2fEqN8=
X-Gm-Gg: Acq92OG7kZ8jmT/C04Wkpx+M3Jh9JrqmNFdiYQAvNRXo2HI82cF6LvvJQ1Yjv9/vMYo
 5OsefKn4bc/I9aEqhwTNovZEBMB/4aJdqfdyOcxGJXbuppgGrDdUKSmcZAf5O9Lvtr2ij0U/LBx
 MRLeqvAJwjm77+4GY2TjCsHUpsnKE2kSKkvJ5HcaZPeHlHhwWyyOrDjOgNr710+OG/XKhsUVwO0
 EOxCFtL7Q5IRJAUsx1x/FALkaP3XAvKd2PDzVw7HXojaR6DeizJky6CEND2bmSMo1KCLmuB6oxR
 zqZztApEyHinEQXOECqEiF14GOytkFjNYpPttXreDEoVS7rSxpNECstm07+ilvw4TQHQILxgiwT
 gC2a94s4xZcrCF7kx0N0Sh/xfWTkeAmRBgyaTk+7t3BPZiYsDXjxyBgQIKrjiJ9tO/kRpC7cZrD
 5K59n8c0osDZeJdJmjZmOWvuVRWNM+5bhWkBfMuobkpn6WsEUrC/OoPkq0bPcPwsdaAGLFR8z/L
 HSJ
X-Received: by 2002:a05:600c:6094:b0:48f:f64c:c2fe with SMTP id
 5b1f17b1804b1-48ff64cc4b5mr311472095e9.22.1779281944611; 
 Wed, 20 May 2026 05:59:04 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fffb9aac4sm530631585e9.9.2026.05.20.05.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 05:59:03 -0700 (PDT)
Message-ID: <57f7a25a-dce1-452f-8529-187d66a6d8de@linaro.org>
Date: Wed, 20 May 2026 14:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Fix hexagon-linux-user.mak path
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260520123947.12711-1-philmd@linaro.org>
 <87fr3ms0oi.fsf@pond.sub.org>
 <f52ebf28-1921-4ada-a7c5-ec3342cd3acb@linaro.org>
In-Reply-To: <f52ebf28-1921-4ada-a7c5-ec3342cd3acb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 20/5/26 14:57, Philippe Mathieu-Daudé wrote:
> On 20/5/26 14:52, Markus Armbruster wrote:
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> Fixes: 812b31d3f91 ("configs: rename default-configs to configs and 
>>> reorganise")
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   MAINTAINERS | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index b75f3222f2f..2a4d124fb3c 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -256,7 +256,7 @@ X: target/hexagon/gen_idef_parser_funcs.py
>>>   F: linux-user/hexagon/
>>>   F: tests/tcg/hexagon/
>>>   F: disas/hexagon.c
>>> -F: configs/targets/hexagon-linux-user/default.mak
>>> +F: configs/targets/hexagon-linux-user.mak
>>>   F: docker/dockerfiles/debian-hexagon-cross.docker
>>
>> This one's wrong, too.
> 
> Already fixed in Alex's tree:
> https://lore.kernel.org/qemu-devel/20260518102222.80735-2- 
> philmd@linaro.org/
> 
> Pierrick suggested to repost patch dependencies already queued in
> maintainer tree when posting series; while this seem counter
> productive it could indeed have saved us time.
> 
>> I have an unsent patch fixing both.  In fact, I have an unsent series
>> fixing *all* F: patterns that don't resolve to any file.

I looked for your series without success, then realized you mentioned
it is "unsent". This patch is still valid then. Why mention unsent work?

> 
> Oh :( I already sent various patches about that yesterday :(
> 
>>
>>>   F: gdbstub/gdb-xml/hexagon*.xml
>>>   T: git https://github.com/quic/qemu.git hex-next
>>
> 


