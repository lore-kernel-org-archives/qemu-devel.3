Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7539BC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAACy-0004xI-PE; Wed, 30 Apr 2025 12:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAACw-0004wj-GL
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:22:50 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAACr-0006df-El
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:22:47 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2295d78b433so71215ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746030164; x=1746634964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wHK1qlWy27PdCOuSloyGM8+0rvVsPn/vvUmGzvL2hi4=;
 b=lxrNMWTiR8WXUvJqBlivuAjTrre9mrAxB5m/IOtY6YWr2X1S0m4PMVa9CVv2RJJDp5
 v7mhpFloEEUMyWk2QRfzjB1jUaL8fTQQrT7sQ7V3hn1thYhPMHAEq2qrx7cKd6DLp5Gr
 GpDiWrA9jnMw/B3Dp0nH0OeI9CYbNakpDhhJ61SYA7eQ1kh8lrw0++Qrft5Aw/SMVC5u
 j/NNsMTYKCMgnhEr9Mwy6FS/YV1oEHxKND8pqaK8VzYlNDtmZBSmwGqkE2szEitGeh1B
 5j4DLnJOlMb86Sn8zcEncJy/N6gaioopu7OsoTf70Tkm5h8yo8hWptZ2cnTBKX3F6I69
 3eRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746030164; x=1746634964;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wHK1qlWy27PdCOuSloyGM8+0rvVsPn/vvUmGzvL2hi4=;
 b=wVEyekMptsNyyizoMosx+vuBcThWQO/ynaYRtAY0Vj1VUyekUtzYCP81XsxSV2Z2Lg
 1Hyu3ft2Q0D2qLKf4LGfcUy18iq4qboZdom6Yn3bGW5dzAUh5gla+mpjyRujgBtlhQ7z
 CmMkXjrQpF30078iMSdzJKwKw2sTbMyMy02lT2gKarO3QMtZjzxNL9vS/kO4ifA8PZew
 /+766jnao7hW5hEybxqU0BNszuqJsQ2CUMUNrAI1EuwrTTq2azBStCBN9kp9JUhU55yg
 h/KT6hhioMzSFpSSD9tF9p1p5VK2rOJJbkpyEqMykxsBM0JnSFf+t+2DxM3X6L6BjAYb
 k9Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJBu/1NSRDNe9P9ql2A+TxEEn6bqCBsgSxbGh3uM7I4Mh8mok+NiBsq7katsxDyzNacQDGqR2BI+xj@nongnu.org
X-Gm-Message-State: AOJu0YzPDYz92WNBCAazsgC7zm2lc6UVILbfgV6d0uqzSrx0Ms8SLstX
 4jf5F9prn9lf8P8QqXzkkgjdMimivFe0OX4Rc+YwuBhXzDbKUrv4mfJLQFwK7OE=
X-Gm-Gg: ASbGncvgVbFHCEKG8KuSO726EsOzIsn5sIFsZ+4IcU3Z8cnmPxKNXVLczvNGu9qVc6d
 WJS+j5btcxLRejtq7Y2cUTy1CRAFw2K/WIELvolk+u3hBpGAA//Agj5GDplqICN7rHaIcwtHynM
 v29QNOzhDhW+jMDKb0L0S9lTyynbDmfvKtAMbe/SEAoQFvjC6WZG/LbSMJ7eRR1NzrIzOO/5GLo
 c43lOGfltZlEEDB0PxorNFVXM5rPjdFsVTL0elg/2Lg6nsrZhkpNNummW0j2Wf5QQ0Uaae440ug
 FvrlQraF01bemikSJhcu7YYxxt8ayJPKPG7XYEeKtIkbA14HZGWgMA==
X-Google-Smtp-Source: AGHT+IFWGzid0qFOdbPr0IIyjPzpQWR8vbRiPiqNaZ5fhbhU0kA0BwAee99jbOuOmsCU9Is9gI0O0w==
X-Received: by 2002:a17:902:f685:b0:21f:7880:8472 with SMTP id
 d9443c01a7336-22df5827a21mr52449825ad.35.1746030163771; 
 Wed, 30 Apr 2025 09:22:43 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5216a32sm124042485ad.219.2025.04.30.09.22.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 09:22:43 -0700 (PDT)
Message-ID: <199b8d17-8f26-4ec2-b9e5-8ffc53f55155@linaro.org>
Date: Wed, 30 Apr 2025 09:22:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Functional tests precache behaviour
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <c83e0d26-4d1b-4a12-957d-c7b7ff4ba1b3@linaro.org>
 <7f0c4586-8a97-4e64-8abb-58a74b86afaa@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <7f0c4586-8a97-4e64-8abb-58a74b86afaa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 4/30/25 8:00 AM, Thomas Huth wrote:
> On 30/04/2025 16.34, Pierrick Bouvier wrote:
>> Hi folks,
>>
>> $ ninja -C build precache-functional
>> 2025-04-30 07:23:20,382 - qemu-test - ERROR - Unable to download https://
>> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
>> gzimg/armv7.img.gz: HTTP error 503
>> 2025-04-30 07:23:23,131 - qemu-test - ERROR - Unable to download https://
>> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
>> gzimg/armv7.img.gz: HTTP error 503
>> 2025-04-30 07:23:25,870 - qemu-test - ERROR - Unable to download https://
>> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
>> gzimg/armv7.img.gz: HTTP error 503
>> 2025-04-30 07:23:25,871 - qemu-test - ERROR - https://archive.netbsd.org/
>> pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz:
>> Download retries exceeded: skipping asset precache
>> $ echo $?
>> 0
>>
>> Since we silently skip the asset precaching, how can we identify that an
>> asset is not available anymore (temporarily or not)?
>> Should we rely on test itself failing when trying to download again this asset?
> 
> The current logic fails hard for 404 errors, so if the asset is completely
> gone, we should notice it. For other error codes, we assume that it is only
> a temporary server problem that will hopefully be fixed on the server side
> sooner or later.
> 
>    Thomas
> 

By the way,
thanks for all your effort to get rid of avocado tests, and converting 
them to functional. It's infinitely better, especially the caching aspect.

