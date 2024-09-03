Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8131CCD343F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUuU-0000XZ-Db; Tue, 03 Sep 2024 10:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUuS-0000Oh-Mc
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:53:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUuR-0006JA-89
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:53:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42c79deb7c4so25933795e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 07:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725375209; x=1725980009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=23eIW1kHKAzS5myirB4E/FTjy/Vsl8w9Q2gYhpWOr0s=;
 b=Llrnk2PKzF68WzrDsNk/UfW8GjbHAVObydmtHq75v5uBuavlEhPCjvG3CLU6qD9seA
 /C7+wsG1kYRWxRWB3Z0ySFhfs4HYXmTwWCvuf4ff0O+pIQ9ojzpKOm3DXkl0rGCJ8xYb
 ai4zdJX1EgAFCcxPUx2MbuMaME9GqgDTkeeKcmv0EL60wLDYZUHJLM7JIuP+ED4qMpbO
 uM5hMYN74fUhuz1dSv2Hamn9PkSYYJ9iwLAz4FxNhAOvF1YekWmOrlALAoNbtlMeK09B
 RCqLm4/D5ddvf4IoHgv1dbCPsLTii7znEa8de8p8/4lrbsZ78gKgm5kZFOtrmGgE1a1k
 Ytnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725375209; x=1725980009;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=23eIW1kHKAzS5myirB4E/FTjy/Vsl8w9Q2gYhpWOr0s=;
 b=VL7gJFbUkZA+XyGbOJnAg4EKiLeeAUh6KgG33QtnZimdWI8G0HOcepPXau6iytV5hx
 Ewtk2dsyRWZh9w0/l++4CYHD6YJOlo2DeJt/xSfI74wS4qp3ol/fwmndpDnGcV6hm0fj
 ZmmHg/78kVafTnvn+fty4EI3D2yw87jHl1tyNphv4Ds3ImLUEPkYyL0kEBnsAXSs1bp8
 7pHOWXdvOHihZ/sP31rAo8tNn1onHvclodZI2FVp9Ul9BrKprDiDN6YincN17Oqo/3zu
 w3t0cQNUK4P7pRRRI6VZYcneddVgm5Ck4JLVbP/XTgDT6/Tu261S1ij1Xxc1CV6U5alB
 x3ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0bSUxn3Dx13GNZ8KHETLsE8oPXu3kEAFOc60/y2As/eOdfOGyTvEOgeepPZw3fCETiBNeCeyrk0ln@nongnu.org
X-Gm-Message-State: AOJu0Yw1euu5D3RP7FIVk5jGWpiqwd0LvI0RFLQfPGn72jRJwKjVr4gU
 xy0bLS7PIVUxovnuNHoOKo/neFBckrAkFMdaj8W5CvzdMp2Gf42DxStLJWzJCII=
X-Google-Smtp-Source: AGHT+IFFE5mlfkBrHXMDv//VxAlslM/8FKwfvwZKGSLhu3cQNJBLGzQr0V8lt/6dWrL2qSqMHhPMyw==
X-Received: by 2002:a5d:6345:0:b0:371:c518:6f54 with SMTP id
 ffacd0b85a97d-374bf169505mr7737727f8f.29.1725375209529; 
 Tue, 03 Sep 2024 07:53:29 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee4a5edsm14573398f8f.1.2024.09.03.07.53.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 07:53:28 -0700 (PDT)
Message-ID: <67778680-33c8-4d5e-967e-11b891c99240@linaro.org>
Date: Tue, 3 Sep 2024 16:53:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] hw/s390/ccw-device: Convert to three-phase reset
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nico Boehr <nrb@linux.ibm.com>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
References: <20240830145812.1967042-1-peter.maydell@linaro.org>
 <20240830145812.1967042-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240830145812.1967042-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 30/8/24 16:58, Peter Maydell wrote:
> Convert the TYPE_CCW_DEVICE to three-phase reset. This is a
> device class which is subclassed, so it needs to be three-phase
> before we can convert the subclass.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/s390x/ccw-device.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


