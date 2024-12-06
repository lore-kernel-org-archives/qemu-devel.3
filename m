Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B603AE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJYx1-0002e0-Ni; Fri, 06 Dec 2024 09:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJYx0-0002di-I8
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:04:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJYwy-0004bI-KT
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733493895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ipJbe4q00WCZ/9mfA/P0qe+8ydHbkJxCBXQFNDvTGjE=;
 b=f2Nd4rfYkKwSOwk2qXNg1pG/d/wbKxuR2Yew8O1m6IKVRseLZvmGmaadYBXBUFUGfaXuk+
 nPOGLhH/6tRchihBSfNhhUhZcTBaQOTfsyEd3p9fcxvpTWpRW8CtAYmt1C0PEHr08kO7g5
 FWtstjov4V7Gi70TVxRcwFfjUfQZpx0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-RjpAPn0mMk6COtPKPuqvWg-1; Fri, 06 Dec 2024 09:04:54 -0500
X-MC-Unique: RjpAPn0mMk6COtPKPuqvWg-1
X-Mimecast-MFC-AGG-ID: RjpAPn0mMk6COtPKPuqvWg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4349eeeb841so1124195e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 06:04:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733493893; x=1734098693;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ipJbe4q00WCZ/9mfA/P0qe+8ydHbkJxCBXQFNDvTGjE=;
 b=nFq3S46SJF8hZZ5jktTDe3o+HjK/e1a/XTrGBAgRhr4nh0WaeFxSurch5D4zIu+VmO
 Up8jhx3dp9VqjCUW0eQMN94aykopNWJs2hefy08mX5AwHB3PEKObd6jFypYvfaLL9mzw
 8gWXfLydyjDjxPinO6URySNRi780L7LRWdgx+SCSiE8KSuKoI8ORF6+frtKGmIhAEIVD
 n7AcGKV9RTCTpQ0UCjVcgBm22j+8q0dksn3a+bz4Rz2oCR63Yb2/adHXTE6rC51Swbx7
 4eFjwdsh+MT7C9KN/H/Z4uwjW4CKOQFQjzaMq0Q3g8qiVzB9Q1svWJW8MG+QzUsp/9Rg
 B/jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmg+ilV02951Pw5sJojaBlKyzK4oh0tEDNuhY1zEgttwHudwUDNK8AR1qz1LXBQp7uy3RBxMX2l34m@nongnu.org
X-Gm-Message-State: AOJu0Yy1mV16OHH0Ob0T/4xdlDLKFU9gicgIob5yonDJ5sb2d9H23ZOg
 OHMfv3LpZicksY9jC8oHFjP4uM4hUMmuQpKo8vpQ8dQ6DbcrsuRhOUFNlMbkla18OA5u6p9oAdw
 w2BQ38al+ypHC6sBTofJporqa207vaCsJqORSQffyaRv5nVjz4PSd
X-Gm-Gg: ASbGnct9/t7plHZXzuZzPNMD83HkKHfNYZWHSlTy014i3ENbKwhMgr2GOwt4eOUGFd5
 HnaHsgnm5MLss3mFtfNBfub7t9lAY7hbOiKFWBDNp4G+JlwbDqE+9km5KnRRxMrRVotdjbw5WNH
 V6vhg2gmY4H/SmMss9rb7BvMsyj7qKrvT8cr54Kgpd2j3jrQpXHAv+2iDnGLcWdUlWDJhkzL6oU
 Ifq6xmLP74F/2Oo2PCiD/DhboKSb1Hys46knFilwtwaceKdIiVsPfEOW7jhE4YeO0Qf3H/64obV
 puWkNA==
X-Received: by 2002:a05:600c:4f51:b0:434:a83c:6a39 with SMTP id
 5b1f17b1804b1-434ddead992mr29931225e9.3.1733493893280; 
 Fri, 06 Dec 2024 06:04:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW2VD5ztOHpCY3S0CIE6r5CViUPfZ+D411ICenZdsfF2XrteQ+7fBofBV+brHf+idulP6prg==
X-Received: by 2002:a05:600c:4f51:b0:434:a83c:6a39 with SMTP id
 5b1f17b1804b1-434ddead992mr29930755e9.3.1733493892875; 
 Fri, 06 Dec 2024 06:04:52 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-244.web.vodafone.de.
 [109.42.48.244]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d43b8557sm69263265e9.1.2024.12.06.06.04.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 06:04:52 -0800 (PST)
Message-ID: <1caf237c-5af5-473e-b2b8-8329ae22e3a1@redhat.com>
Date: Fri, 6 Dec 2024 15:04:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] tests/functional: Introduce a specific test for
 ast2600 SoC
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241206131132.520911-1-clg@redhat.com>
 <20241206131132.520911-6-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241206131132.520911-6-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06/12/2024 14.11, Cédric Le Goater wrote:
> This moves the ast2600-evb tests to a new test file. No changes in the
> test. The routines used to run the buildroot and sdk tests are removed
> from the test_arm_aspeed.py file because now unused.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/functional/meson.build                |   2 +
>   tests/functional/test_arm_aspeed.py         | 155 --------------------
>   tests/functional/test_arm_aspeed_ast2600.py | 143 ++++++++++++++++++
>   3 files changed, 145 insertions(+), 155 deletions(-)
>   create mode 100644 tests/functional/test_arm_aspeed_ast2600.py

Reviewed-by: Thomas Huth <thuth@redhat.com>


