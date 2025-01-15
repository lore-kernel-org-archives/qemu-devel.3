Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA78FC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 13:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY33N-00014S-NN; Wed, 15 Jan 2025 08:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY33L-00013e-8s
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:03:23 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY33J-0000EY-HQ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:03:23 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso69178765e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 05:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736946200; x=1737551000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uXr0vXyZvBjzMfRDSzxUIAPGT5tEaxPYPVCuuOs6TNc=;
 b=G/A9cZuh6U+tKOS4xWzWeeyXbvQLS+7hRgWXM4LwMlJHIdFHQ/aTMKSZ79sQxMh/nD
 JyFvzEeHJQ2p7BJu9ZKqIChIDhY5deDUO0vmOXH5pfIVc5eqeVoDDZOujsNEEqLVQ5Hq
 68vMWaPX4klsclBzfM070rH5lGMRLwYpo39HToETgdAoWfsjOf7XjjSmgVM3WZJpXgwO
 Fnl+/9Yn1hJqVVuk+8ED9nNUoD8zb4boonriNi1VtpDuuucYGddhEHzVLzLLpL6MGZw3
 CGR5O5WbcTgCaveaWCsk7s6/PlzmeHl7yUUXDdk8h9lycsX248NM461kjUxe5QFGRfGZ
 Zj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736946200; x=1737551000;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uXr0vXyZvBjzMfRDSzxUIAPGT5tEaxPYPVCuuOs6TNc=;
 b=ZyzcFPK7spsIFklrifntMFO8jCzuBjc8DJ/AXpth/iyBLo+OPmj22cVxfN8A8kB3Zw
 nwM9cMkSFNy0nMkLj+RDliuOZdZWLCEK0LHB+N4TtoWO/EuvFcCAAIACzunqGYrZT8Fc
 BHkBsP5SI0IXm7QX7jh9G+A9TO3tgyf8Ge+zq9Q2cC0KtVvEqsIXmB6uL0jcjgJEsb13
 Sy/9s8lUKIwALm5H4iyEzpuUaf9elfKZWooFMkIEHS/TW/q+D6qpOmPF6cgNp/wxkh49
 jdiA6lFKFdzEpNUIqh7RHyI1zU122GleDyWj6JoBIAVGyNHQWx+FAjfiLKSMQ3FFloe4
 iOrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7NgE/meQwbiklD6MkrJB2DsMylJP7GiGb3NXUFWI0gI80NvMAYJ7T+Svycpf8m5JJZFU8K3WnJt5A@nongnu.org
X-Gm-Message-State: AOJu0YxvB1+Az7Hj2kdR63S+xSaDT8qx24XmpHwiL4eJuOi10SL7wW5M
 fVp7sBkep6NZ+FvDjgVi/fgzBsBDMKzfPFvqCdLbZpJSEMUDBupYj36XxBzV1Sw=
X-Gm-Gg: ASbGncvlwMb/SR+eLtwrAie9DvNHDfXMZeJWHNCpC7A1ZmW0YRZv101BEOoXnXn7Yt5
 gCOA0EEGJIi5zbyrke1RLGcrahOwfl/VKSK7Za5O1Ku32m7ju58s6IVcchvqPKpc+ZrPCQw/CaF
 iIDSdIFFyKg0ZoN4wR92LUfC3+HzcPN23jTYcKhnVkz97NE/Z3CUIm11La+c/mDBnKVvnbTnvHL
 qgQooqytlhrbwYctUIJssrT+vESFe+wfoRZdYJJ8soUbmqd+mHkzT/Kl5/oQauC4dLTlbx6eCmz
 IUwqarxzkk4PpM4/uqkDl9jTLXY=
X-Google-Smtp-Source: AGHT+IEpjoBOAfcP2Ro14TWFmleLhhW2YQfBVo3h2QfaOtMcaSdR0gWjN+NL6p95cqnr/ZanpQsgOw==
X-Received: by 2002:a05:600c:444d:b0:434:f739:7ce2 with SMTP id
 5b1f17b1804b1-436eedef4e5mr187401935e9.8.1736946199606; 
 Wed, 15 Jan 2025 05:03:19 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c6799sm22757955e9.24.2025.01.15.05.03.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 05:03:19 -0800 (PST)
Message-ID: <1cd98f01-c863-4494-800c-5d73dce82078@linaro.org>
Date: Wed, 15 Jan 2025 14:03:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ufs: Adjust value to match CPU's endian format
To: Michael Tokarev <mjt@tls.msk.ru>, keosung.park@samsung.com,
 Jeuk Kim <jeuk20.kim@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
References: <CGME20250107084356epcms2p2af4d86432174d76ea57336933e46b4c3@epcms2p2>
 <20250107084356epcms2p2af4d86432174d76ea57336933e46b4c3@epcms2p2>
 <a50c2410-63a7-45b7-a7c3-cf2053eb5bb5@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a50c2410-63a7-45b7-a7c3-cf2053eb5bb5@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 15/1/25 13:53, Michael Tokarev wrote:
> 07.01.2025 11:43, Keoseong Park wrote:
>> In ufs_write_attr_value(), the value parameter is handled in the CPU's
>> endian format but provided in big-endian format by the caller. Thus, it
>> is converted to the CPU's endian format. The related test code is also
>> fixed to reflect this change.
>>
>> Fixes: 7c85332a2b3e ("hw/ufs: minor bug fixes related to ufs-test")
> 
> This seems to be a qemu-stable material.  I'm picking it up for 9.2,
> please let me know if I should not.

Correct, sorry for missing adding a Cc:stable tag here.

