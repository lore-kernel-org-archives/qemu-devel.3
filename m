Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A85F55456
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6ho-0005ks-Ua; Tue, 24 Feb 2026 23:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6hn-0005jE-Kt
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:40:59 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6hm-0007mZ-29
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:40:59 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-45f18e8f2f5so4570783b6e.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771994457; x=1772599257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/grfVgWGKdD82Z+UmJYVxikCThVfQdCR5f/kQEWb0h8=;
 b=c7q/F2jTVQfy+Gb7A4Tv+5Xc9/PONdXlaDo0vSDuUnC6/SmqBurlozcRFIS8F0UM5o
 P7hhK053XNuuHWy9NX6IFftx86PgntVowxeP4wzy1dB3Q3BnnVftopnH3eKqrybZjCs8
 YtoyrTAMnobx6oqPQQSFecG5ycbSbbZG9Jw0LruBzHNerGRWawsXpkLzZOIE6jqBAcl1
 xmgvyDCMMMHLc2iEJX1Xfb3qJJukauWfuQ80x5hwk3GW5uD0ssg4EbupK/o9lD6MV+Of
 PQiZI37f9qbvnBPSoP2FhTKjpJsKCTAYx1Ha2e6OIcMMyAfNo1Fwn70L0eVzwIggBcsP
 q6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771994457; x=1772599257;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/grfVgWGKdD82Z+UmJYVxikCThVfQdCR5f/kQEWb0h8=;
 b=KZO8XGSBtZdtaPf87TgbmFHTsoIMXdZt6dq4EsRQMTd56IJQbwogMEV/aYqVmcdbfl
 39fVenc+lkMnrbkhcAnvqp5aZz1K74uWPEDSPsjo2QkiR1VfIgW+mEUh4Kbw+OTw6QWl
 fRe2piNGNs6Fu+yed+i2fn5j4WPYXWnxnwrHD4D8G/uX8WR6hp5HxhmhjaTtf7BJWHGu
 6ZvcBDhX1t7nRKj02QMxn83wYunwwQMe/AwqU/ltMbleZ+4zu/a3trpXxrmcN2AGi1f0
 57DQ+G86yldr8LZ5I4VxLUOCQVD4B4qw+QfQPIXyPoemIMrwPqrNszIRJSvMdR1iFZ2V
 pFjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIGYGOgJJRozCzxaDlqM4w3d0gW5ayh4nRPKW2Q9eUvyGwM222uAFQJtH8eggxqmVL/5RT6gfjwYJo@nongnu.org
X-Gm-Message-State: AOJu0Yyw2RBxKgScqt2DHDQS0ufcsNcF3Q5fZf8OKLTYqR5IKgS304m7
 fnqeYJ5OEpN1ZXwVjYXQMaW+jcK4v9TnJDplNKYYYOpuqE/BFgQ6Sme7bkTgZHLxD64=
X-Gm-Gg: ATEYQzxBao3YQg+GwkzwAR+uWXpcRl/2Q5kj9hzb6Gcx83J3zwcPcPE2rYiEbd6OtSi
 16vG4Ye+TUGUWJnX4HJFSrGwPBMJjf2995vNULkSXPbF7HMrdmlcOTnOK5RuGGGMdpaQ5+4J5ZZ
 iXCozFXpAuPFpUBmRqaVDAPUXfmyeWeTCsIZptSW6/pG0zjub7NtZc/ONkCM6zF2ZS4v37xUm+G
 VgXmEB0Oh8zXXrvjA7QVMOavEVDDzqkSNFeef8JYIInHJpRPNzq86hQJWd1RD0cNR0RDoA8Kp8c
 kUKETmkQ82j8SUbfrKeMt4sdTiX+xcZbh0hTuQL3oRoUcC7J2vXey4+JxD/USu+mHDyC1mwVkUA
 1stXMK6hG6KVaS5R0K3Q37hYAuozcPui38zGT/t/80VFcMwZdY0he0UoaMHnAohdobDf0EypnCp
 YHuMGyhcD2VTUwUMBGz+GhGmVMgurGX+jwZZkuZ26EOtwZeQipO7a0VkvcIG2G8y4=
X-Received: by 2002:a05:6808:c1b2:b0:45a:769b:2157 with SMTP id
 5614622812f47-464461c691fmr8827560b6e.26.1771994456661; 
 Tue, 24 Feb 2026 20:40:56 -0800 (PST)
Received: from [10.34.149.227] ([172.59.192.107])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a010a61sm8484089b6e.5.2026.02.24.20.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 20:40:56 -0800 (PST)
Message-ID: <8480050d-d114-44fe-89ce-222a25b4b1fe@linaro.org>
Date: Wed, 25 Feb 2026 15:40:46 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/iommu: Avoid including CONFIG_DEVICES in hw/ header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org
References: <20260225031658.32095-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260225031658.32095-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

On 2/25/26 14:16, Philippe Mathieu-Daudé wrote:
> By inlinining the stubs we can avoid the use of target-specific
> CONFIG_DEVICES include in a hw/ header, allowing to build the
> source files including it as common objects.
> 
> Philippe Mathieu-Daudé (3):
>    hw/arm/smmuv3: Avoid including CONFIG_DEVICES in hw/ header
>    hw/i386/intel_iommu: Avoid including CONFIG_DEVICES in hw/ header
>    hw/s390x/s390-pci-vfio: Avoid including CONFIG_DEVICES in hw/ header

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

