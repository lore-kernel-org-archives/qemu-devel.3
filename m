Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B84C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Y7d-0007Lz-7c; Wed, 23 Apr 2025 07:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Y7X-0007Fr-FE
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:18:28 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Y7V-0001yv-AE
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:18:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso46661735e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745407103; x=1746011903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7N3hNMJsgG2HpDOwquclnTwwqXmvkDgooi0S4bttT3k=;
 b=DnCN/LhqjK15XQrOjMJXqN6XyqQxdf2FxzM38qQ95MjUjLCrGskknQvdE/C5I/oA01
 Q/TeAHqMvyKIO8wEaICOLkzvBLYEGhTkdqlPPEFNq+WA98Wi1Hyp9znANpq/y5Zz3bOM
 yw4jQhhb/ShAhim8/I7WncU2lcGI3XKQIOOX6S+jA+mfM2sMdhnIHcmd60io3UDEwbIE
 rPQEdBJZ1ZJUfHqlDTugyTFn1UBEuWjMrKufJay7zR0emAvMaQ3JE4fIT9oz8RvJW8z4
 VIZZTJKP4mDFJSo4e4beKy669CCwlW+LsmZcO8WzWoXzkkwkbg+5PisEB33NKGBB4/x2
 U4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745407103; x=1746011903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7N3hNMJsgG2HpDOwquclnTwwqXmvkDgooi0S4bttT3k=;
 b=W1qgiuEn8ixUg5WaIk/cLO5GcvZLaTIklYjbGXLzwTODzSckiqMM4oUGzxpM4wajAn
 SvRSqN9rigHPVC7huphsykIxqKjwOTgPJ7Tm03C7T0qPfc3USYk4PiA6zqnncPHuWcWx
 JG0PJyWGv08z7GfaFn3CIhg0fLWeccw+CSOZl/6VD7xobKEf6yDt7BuZDC4hPWe+3oQe
 r706/cLOnvlCFjLS+iwv5oLfYXwjh6ONI/yAe8oltDvyv3vigaAzII1Ky9A03Jd42Mmv
 uR0wLOW9AriYyJJm/ULJ3pQ91iL3a+ELnXufeLHsRKXOJORQwviXlhhAMfYbj+Lq9qrE
 Awsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEaEuHxGeQGJ7AnQ7SdEaLASBjblTVj22GFlTCpyJvMfceX0d4znPAXLzcZ3PzjvCQ16nWqg8eMDRn@nongnu.org
X-Gm-Message-State: AOJu0YwcDnJG5bbbWZn2KndXtw5mAgC+Z49rqYGXD5+67boIL1F09Mre
 5oFyvETy7xx2Tl67fMVA3icX8XHfojLuDUbmOiGHvi97XxIDoo2a2iiMSg7RAMDGcJbv05DYAOx
 M
X-Gm-Gg: ASbGncuBbZWIQjPV8CxoLUkAFwDpLeYWXk6W4wFHPymsJZIg+ZLH6Zjxgww5TG5tng5
 DnhU2DCJ0EKaKc1FvNRzLAhMDVEQhstEYNKyUata2FfgCMvFUe14eZbQDs2kTmaaixdc75mT5x0
 hRExOd/bp2eexlDkGOOridnsvsROZJEpYE4sJpbuSgk6fzIy2A1eMZySQfv1M0mYnbnwZEpONaL
 SviGj1cyAHAqmpCC9cps4GMGkfeDwO+W8ZpTwsAulm2Ve8clDue8Y2Kn+hMBuVSgexrPBaF1ohE
 aI5VonK7XgVM6UpVS81Vdc/3drAe2h9bCUYCJw0aJicy0bFlue1NitfkBCJI5OkcgrTPiayOY8y
 iYTlH8UYl
X-Google-Smtp-Source: AGHT+IGwG8CisdruU/i9T7o2FxRa/KuMKcQgzYQPZL1b+Ha1bDPL3gODvXwlM0nUznZMv5YQ8f+XjQ==
X-Received: by 2002:a05:600c:a009:b0:439:9b2a:1b2f with SMTP id
 5b1f17b1804b1-4406ab8144bmr188853165e9.3.1745407102840; 
 Wed, 23 Apr 2025 04:18:22 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d2f0b5sm22229625e9.23.2025.04.23.04.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 04:18:21 -0700 (PDT)
Message-ID: <4257e231-b12f-4845-8593-5312c3c6a79a@linaro.org>
Date: Wed, 23 Apr 2025 13:18:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] system/datadir: Add new type constant for DTB files
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
References: <cover.1745402140.git.balaton@eik.bme.hu>
 <ae793d1f81e3577605759c43871722324a1ef2cb.1745402140.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ae793d1f81e3577605759c43871722324a1ef2cb.1745402140.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 23/4/25 12:02, BALATON Zoltan wrote:
> Currently DTB files are mixed with ROMs under BIOS type. Separate them
> under a new type constant and turn defines into an enum while at it.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/microblaze/boot.c   |  2 +-
>   hw/ppc/ppc440_bamboo.c |  2 +-
>   hw/ppc/sam460ex.c      |  2 +-
>   hw/ppc/virtex_ml507.c  |  2 +-
>   include/qemu/datadir.h | 11 ++++++++---
>   system/datadir.c       |  3 ++-
>   6 files changed, 14 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


