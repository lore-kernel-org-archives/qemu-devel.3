Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52B3CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKFH-00071R-4X; Tue, 04 Nov 2025 11:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGKD1-0006ix-WF
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:48:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGKCz-00034V-J6
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762274915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eZcJIkqoz4e73+MACVEegcjaLU7TYSYOnnHYXO2Zyms=;
 b=i4pCKkuxMQcbmY6cfG++3sW5lujusK0+CBXZbXQDQZG6SS7kaygO4vB5ejp7VqyNQXIgB0
 R9oVILL6aEfdR+KQ/BeIW961EoRzu7fyspziKtOIi0jGu2m9botFKq8TH/HkOeE4sT0e0W
 f5H5zFoXO128ou+bjjM//tB23uig8xY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-s0LNZS6qN46mVBntiEAvJg-1; Tue, 04 Nov 2025 11:48:34 -0500
X-MC-Unique: s0LNZS6qN46mVBntiEAvJg-1
X-Mimecast-MFC-AGG-ID: s0LNZS6qN46mVBntiEAvJg_1762274913
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b2ef8e0133fso812672466b.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762274913; x=1762879713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=eZcJIkqoz4e73+MACVEegcjaLU7TYSYOnnHYXO2Zyms=;
 b=lkwncp8JnIjtcUiM/SRSs0x8a636/9FZa7AYXthYZSs9Hodu87c6Koy/C8NScCLEjv
 kp+h9YCIngWSyXE/ZBpdt6ZtIXOUr1Y0JAwLL+n7WuON9Kr4pYVNRtU076Z/jrgRqtpu
 9xp6uGVSzb57ZhDWqDcFX5TAhRW20JChJqYpN66f+btaJyfkAicsSEi6N/Ja8UKhKluV
 y8OWOyB57pt7r8o1UhfO+fB2IP0ME2FVS/9Q7u6AsBzvwF1NbCuVX0ccEMxpFJM0au/j
 Yp155RjLlFvFDsBWqk2QBdJ9oh7vjsXEO0mfWl+8cOflTw1DC1fI3T9R/5pvwt+3zLbb
 J6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762274913; x=1762879713;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eZcJIkqoz4e73+MACVEegcjaLU7TYSYOnnHYXO2Zyms=;
 b=LwPHOJWGXQb4aA86xVkvfg7MjUgIDtQt4/MMW5/7122/Uf0Ybh3Dk/yX1aPy5jybL3
 Vv+Z9wbtBJiiXXH9Kj5H62H8rVsV1OqCfdJmP1zl2X0ldgiX0qd7qA1jDvolp92kxr0+
 JhD5lMtc9rUGtzKaqfOkSJUZKfOR4tjItb+AdDOrEfz18sgY2a8H32sWLSfNHNMx03eh
 +p2WRZw6DMvwVdJsMz0aoQIHNYd9TX30MN1lj9qWN3HJZYH4BkoqEZJKGtc9rrgfu34Q
 dCsAQUjGy/zr19/Tr2d1vUbNIKN8GLAsDvBj4BJQNQcXOrYYNNuoxGC9eewVT1Jb5Dn0
 24VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+HOABOzZCPOLh5L73HmGQPD+1De1RNYUdSrW6c9zeWzhgW0vcxqFwCRJ8LD8nBGHOV/kszI3jAwbW@nongnu.org
X-Gm-Message-State: AOJu0Yx+HU+X8a/47fRYvOpAyPu8ReIZ1q52770uLFEcIajuXnI9oga7
 0ZBRjk6/fD72luV0bKljYz62z8M4V0DLskwnr25QG1cSYDgVMutS/ypRdf6KlFAEjz7OlCEdfw/
 LzhQRIB6SbgHdH7etc8jezjO6lhN6k/GWOmC4tY+4uCFLv+hxlwn2A3+G
X-Gm-Gg: ASbGnctH4YhVGvJRsimdHvESSaj7cNnNGbu7CShNu6Twb6nVYrKQlUiFRKXJ6Zwi+cq
 p6C2cq1rizU/ikk1q23NZkvzB88GHSXOSplVGGlA91Aw52xjSintq2v4hW/aUkqUZTthvtR2vTS
 cFDUtjvnXSxKgabJUSj2f9uXzzq44IOB0k0CG0aNLHya++EjaNhv15mHh+oehwK/YilOR5T5x3u
 K0l9AOqRznYNBU7rauZydD57pqi9vpI/Hr0jLZ/3EVttT/c77QBeftuqre+Umvc9Ql21X8ks1k3
 6pMc4qewJI+g5ld2/+cOM5YqPSA/KI+YPxqcP8PJ+ac5QZKIVkXWiHHIYHRgEcWGg8Mqio4qu0h
 wzEjSPcAFGSh5cKSENe+AhJwl/K+zgpA2HRhPNQ==
X-Received: by 2002:a17:907:3f0c:b0:b3e:580a:184f with SMTP id
 a640c23a62f3a-b70700d6d5bmr1927970966b.4.1762274912753; 
 Tue, 04 Nov 2025 08:48:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi0yeIbkpK+qPzEPHUI9/UaqIW3n3wbbT2M6aHa08JbiHV7QmU2DDloMCVGQD27Ht1Z4ttDw==
X-Received: by 2002:a17:907:3f0c:b0:b3e:580a:184f with SMTP id
 a640c23a62f3a-b70700d6d5bmr1927968466b.4.1762274912361; 
 Tue, 04 Nov 2025 08:48:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723d91990asm253188866b.28.2025.11.04.08.48.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 08:48:31 -0800 (PST)
Message-ID: <5290768e-0cb7-479b-a947-ae682cac350e@redhat.com>
Date: Tue, 4 Nov 2025 17:48:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] tests: Clean up includes
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex@shazbot.org>
References: <20251104160943.751997-1-peter.maydell@linaro.org>
 <20251104160943.751997-10-peter.maydell@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251104160943.751997-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/4/25 17:09, Peter Maydell wrote:
> This commit was created with scripts/clean-includes:
>   ./scripts/clean-includes --git tests tests
> 
> with one hand-edit to remove a now-empty #ifndef WIN32...#endif
> from tests/qtest/dbus-display-test.c .
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/aspeed-hace-utils.h      | 1 -
>   tests/qtest/aspeed-smc-utils.h       | 1 -
>   tests/qtest/aspeed_gpio-test.c       | 1 -
>   tests/qtest/dbus-display-test.c      | 3 ---
>   tests/qtest/pnv-spi-seeprom-test.c   | 1 -
>   tests/unit/test-cutils.c             | 2 +-
>   tests/unit/test-error-report.c       | 1 -
>   tests/unit/test-io-channel-command.c | 2 --
>   8 files changed, 1 insertion(+), 11 deletions(-)

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



