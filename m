Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB408CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v952E-00083Z-8c; Wed, 15 Oct 2025 13:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v952C-00082h-0A
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:11:32 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9526-00046N-EL
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:11:31 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47109187c32so2189935e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760548276; x=1761153076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hiY0Qjn5RIsSJpnw0hE0xXkc8WMEWGs0JeKIyXBc3Vs=;
 b=uugpUKJvoyYLrGoN3+x6/Ikyvb3TmdhdCTVpiY6oMhisFf9r4wywIOYepEsmjdeoNn
 FbzF8nHiTb9cy6RGbOoAcSEU68rxIlRs5tJ94HkhSIAarVUEiigMbFTgy1BNzZGFLs8r
 TNuuwjWxsayFROuIGjrs4kR1EYa2pUZ0x2s6bzxuMJk8Rb4wVTaXxyXZJKdBOdnTF5R8
 S31DVSwElfvb1qDuBm73xSX9Br1hsaaEagOaHfoEYoDL6P/izVI6vFbP0ZLBuNFZGr9P
 eKEEmHaDCz+Z6fJoNm9FoVMDtV4shx6iA4/46zFfT/Pt0bZ/JU8SQVUlFNeMSk/tUP2y
 3vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760548276; x=1761153076;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hiY0Qjn5RIsSJpnw0hE0xXkc8WMEWGs0JeKIyXBc3Vs=;
 b=BfqYzxkVJCPe+YTe/w9zaqJQg41yR4L0nP5Pi+ctRS1DStcsKLRE4mioXfd3Nt+xia
 8toBHpaGANypxnuW+Np55x3G+iSAjXh+TrpLTD4JWZIKhx2lfdqA1EEK93S70s490bwB
 7sj04MUc0t9bLKz6ClRJgZ9y/i1WJjf1dwl0HLSFTY+uBV/Jnrm/rmO4vI3fp2J3qbUV
 mFm/1soXVuEEeqdovQuWlBcuxdZ0zVVzwlw4lvAzeLlKsseav65TtF0j/noL0BTqUyBH
 v4tA7cZWlshFjouxqcCfpWsPHJHMuqPN/5NdOWAu2jOaztUCG4VR3Lz3/1W2lH620w9s
 Qc7A==
X-Gm-Message-State: AOJu0YzOZV52ckXAQzBy8JMd7Kc5IubhTaqbx8oqADqFG+KfI5mAWo3R
 zqDGkoESNr72DftBB/zpV+hkMCuGxitTGQy3iKHbH62S5HcmcCXqFV/99SdFwkHEqJVebvqGxWa
 SG9JH9KDkIQ==
X-Gm-Gg: ASbGncuZSOcIWNjVh7gseJPe+lPvid0Mm9aduY0ogcwvPycsySdA4OrBCbd2LaNu15/
 FuH8bFamo8YejMMLM2L1Q7zlugrkBWqUybfAwbbuPM2OEBt+7Ui/aNbLuLa+razeR2WhFzO7Qih
 09rrhGrOujkC+xTqpAxCD0TT0ZIbtNTh6Ham5JOPGd9+9Q9nW90LLafJz+QNn6ThLuh04splUOc
 j9fl514sdEI/p4+PYLmPDWYcOD8qWHYMtsG9ukpvTbpf3C8W4mxVkfqNO613oTHgfKk5i8cLUQU
 WvH50lfZVTaokQB/yEFBrYaRL+zwMqujbJk+e837hHi53ZCBBPmrlgZ2bTG13mrozcTKkKuMQ4w
 vN1DooWHKfKCypUeAVO7A6AJoCSijeaqUkTC9+xAEjF+KTolphRdWeLWjEf7urj+0DDwxtxrXTA
 7mxlhV1boD/URF+cRK0P9x9ic=
X-Google-Smtp-Source: AGHT+IEQEkUvXxPAF8+l18pD+aPUZQE2t3n/Y/vhmWy/4HHNCAim1MTOUZtGZ3v4Jgy0PmKpulpzCg==
X-Received: by 2002:a05:600c:1d11:b0:46e:5aca:3d26 with SMTP id
 5b1f17b1804b1-46fa9aef840mr220919015e9.22.1760548276510; 
 Wed, 15 Oct 2025 10:11:16 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e8141sm29739971f8f.48.2025.10.15.10.11.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 10:11:16 -0700 (PDT)
Message-ID: <66d96066-d979-40f0-a2d7-a6ddc1fae391@linaro.org>
Date: Wed, 15 Oct 2025 19:11:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/xtensa: Remove all uses of target_ulong type
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
References: <20251008051529.86378-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251008051529.86378-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 8/10/25 07:15, Philippe Mathieu-Daudé wrote:
> Remove the left over target_ulong uses in Xtensa frontend.
> 
> Philippe Mathieu-Daudé (2):
>    target/xtensa: Remove target_ulong use in xtensa_tr_translate_insn()
>    target/xtensa: Remove target_ulong use in xtensa_get_tb_cpu_state()

Series queued, thanks.

