Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEC5C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 08:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl1v3-0002U6-8n; Thu, 20 Feb 2025 03:28:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tl1uz-0002Td-KM
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:28:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tl1ux-0000yv-7X
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740040097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LAHHo/pJTKWjmU0RKAdLzuja+TtGwGihbD+pkKwKvtc=;
 b=a6dRDiGDV7txVB7FFDqSZ1ezpX0bdBKTGsmqxMOdUuyD5/ECDejvDUopcql0xtG/w/bOyU
 7JRnB172w1BIbDROOQO3mjDP6XGBwNno0wQWfYrQSsm0+n3eYEkOz75daUMsHvVVu3Hlo5
 OCcbeBkOb2wzzbKj1VMouvzOnVZuav4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-PhJqJh9OMQG4kEMR_RNtvw-1; Thu, 20 Feb 2025 03:28:15 -0500
X-MC-Unique: PhJqJh9OMQG4kEMR_RNtvw-1
X-Mimecast-MFC-AGG-ID: PhJqJh9OMQG4kEMR_RNtvw_1740040094
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f4c0c1738so627924f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 00:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740040094; x=1740644894;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LAHHo/pJTKWjmU0RKAdLzuja+TtGwGihbD+pkKwKvtc=;
 b=YDt/skhgRLa26F4SvHhZEQyXkzRidMz3lS5M+LCdtUnd1umu1SVMQSGtudmiTIexh1
 99lAHwMdTaS8bGmgChloPHj4ucZMd5aWNfhHChr+4+BOKC2M0ee7opgoO+gVN/9XiWVI
 8bFlDCAfbPMSrEBfy/j5H1XcpJqyVxljoQnmjlr3L/4GvPUQkmp+/mSwt0oFNX2Ri/n5
 IAwJV6kC+ZXJmbVASq/7ROv3mD1M41zwWbYWwIHd5RNIq1C2AKilynHoOjQzTabf0ikm
 IKMuyc4iyxKCp1h7HDu6rZ2nHr4WC78sXWRhdN+K6i3xFknOpNL4UAyLtW8VKeVJ6DK3
 1Vew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXa+rpElBgjn5AqniSbLuTHs9Sg3sMere51ji0eBbf/QiXksBoGjrJ5+O2k4OVpjg9jpVps9fnoaZj@nongnu.org
X-Gm-Message-State: AOJu0Yy7wRLffHHvm05jFrzxcaH8cCiQ0x9LV55nTRfo01VEJKoRUMHP
 nv382Dbeb84xbtLXXPbt9rOdFqm6Ucr3ayS4ihIG6ZQdDXffYdY4u7MVvVwQo/U0QZagbhG4IAL
 9mZbM2XrBZeKOzvQoLiR0gxUpn4+3BdwsFZ9mcHfb+PJ1LyUnDCNG
X-Gm-Gg: ASbGncsBYP+BpkDp5dltGv5/96tbcUc9yuD8ajso5uhOChmm91j6yJWygxtY7PvK5+9
 AZvxJsYnrUjrlP+2bEBMdWrbTLNptVjqAqH+Zxj75xr5Acwb5oj4UT387FT3dO+6YbGCkjJCU5K
 AvW4svRS69r5Rcfa/V5sSSYxCxqhikVoieP+ondMnbbFZY6wkfFqQ3F6bkoRo14NYh2VGP0wgaJ
 2en4+6OUNKxUsKxw1LS8jU0lWD+1u0MnwWaISk8m/iR1cuviDb/PQCZLWKnEOY4frH7kLa2waqG
 pTYzTPcjPTsnzWqtom9ZATn+qq+bs6Xhs4OY
X-Received: by 2002:a05:6000:1a86:b0:38f:2ddd:a1bb with SMTP id
 ffacd0b85a97d-38f587813a0mr5233517f8f.8.1740040094466; 
 Thu, 20 Feb 2025 00:28:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdaqb7A0SCen9FLfL7o0v+2iGhJaZQV+sFOKjXw9jeBeeHKKu/lnT4WHtc+9yxDhFfPwAG8Q==
X-Received: by 2002:a05:6000:1a86:b0:38f:2ddd:a1bb with SMTP id
 ffacd0b85a97d-38f587813a0mr5233494f8f.8.1740040094137; 
 Thu, 20 Feb 2025 00:28:14 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-157.web.vodafone.de.
 [109.42.51.157]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4163sm20220212f8f.19.2025.02.20.00.28.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 00:28:13 -0800 (PST)
Message-ID: <88f104a9-b3dc-4211-b1ae-17bb6800538b@redhat.com>
Date: Thu, 20 Feb 2025 09:28:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tests/functional: Allow running TCG plugins tests
 on non-Linux/BSD hosts
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250220080215.49165-1-philmd@linaro.org>
 <20250220080215.49165-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250220080215.49165-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 20/02/2025 09.02, Philippe Mathieu-Daudé wrote:
> Not all platforms use the '.so' suffix for shared libraries,
> which is how plugins are built. Use the recently introduced
> dso_suffix() helper to get the proper host suffix.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2804
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---

Reviewed-by: Thomas Huth <thuth@redhat.com>


