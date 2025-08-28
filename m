Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD3DCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 06:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urVpw-0004YV-FV; Thu, 28 Aug 2025 02:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urVpr-0004QR-1h
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 02:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urVpn-0002FD-M3
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 02:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756361403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x7H1ynxcCuZJeYxQMzvjOfsgBe48DuSCa/Lh1JdAa6o=;
 b=PbFJFW54oSZZZlTElR3VpXMP1/vwwyFwxwMg2l+3ohXXv4+Vm7g7CPlgqzq4nPhiBIpJxm
 qZslXybI8OnT/d2kAv5la+/8dOu9QwtVFIty0SG019mBp0DZ7qn9NUq9saw/E5paRGrGiH
 OU+CDQugAcD4rvYo1sKn+VL275P1LIc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-dS_9eTGGOrmZYOHQu-IbxQ-1; Thu, 28 Aug 2025 02:10:01 -0400
X-MC-Unique: dS_9eTGGOrmZYOHQu-IbxQ-1
X-Mimecast-MFC-AGG-ID: dS_9eTGGOrmZYOHQu-IbxQ_1756361400
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-afcb7338319so42541066b.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 23:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756361400; x=1756966200;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x7H1ynxcCuZJeYxQMzvjOfsgBe48DuSCa/Lh1JdAa6o=;
 b=loIusg3FKc+oRlj97ZvmQ0bSlfHPxVjbxNslrntZuHVWku3jVE89FF/kIY/eHB7yw7
 g6ApxmbpL4hjr2/fSQjcUHRFBpOBguHXia2HArme2nj5Umqlf6q9ut7SAH3Ykx/Pv5SH
 1l4+qS0goa+ucyq8zeD8ey7zuSCJycRkhwU29C6tEpab7bMGbvamF12wjHp23fmLX1rD
 KK0Hk0X5p/lcan5hYWMkoGHCaIsFPZ0a+wVXtdYWqftiCsy5bJJ8YtiJxwUn2QeXYno9
 TrkqoIUnuZ1Ml/D1VnujM83s4VJFd9ailfUau5ogXDWMVaFQC4hsuWwJwYCsHl0rjiuF
 nG8g==
X-Gm-Message-State: AOJu0Yw5HwMa9fQUp7qNqFG/Wj5mZRFLY+bwlAla4aQA2t5Sh2O5SisH
 CtnPN9lfpmiHUM42Jo6KovE527tACrww1ME45pAQtZ/GxSXhOt8JT/QzcBrPWYLSCx0TdNChD/8
 GJK7XVh7sVw6jht3kuqERHol3HDsToj3fvo3m4tu0foIyWd5m00+7jLl7
X-Gm-Gg: ASbGncsbEOkykmoeFDR8LXjPlyKb2c46y2uiVRTShd8d8T+6+BKDB9xuxv/e9uQRoAE
 +PwbU0TRSjBwJKyGtsLgCbtkMtl/s6Hwc4U7FVBhWW+G8mK4CyBDHnkWIHJ9LsXlY1F7YC71P0P
 eELAvE3Mlt0ZBk6qoOZhhylrHE9usZRb6qz0VX0JpR0z0A6wEJAu8cFqLqaAyEQ51Cd56C+tSbU
 sQdyGzqKcPICMdOlqE2yOLmOnw5IUFfEHW0J3q4yIZRVb8uMocBNyWtcoCctbUVegsjYeYBFx3F
 GDjA8Uc5IoaQmoHYpmH8VQx2sTzILXPJ87eW9ru3Zhe7uMtcF7+TLIYKGJGuqOuv7PFb
X-Received: by 2002:a17:907:9408:b0:af9:5ca0:e4fe with SMTP id
 a640c23a62f3a-afe294cef82mr2187078966b.56.1756361399741; 
 Wed, 27 Aug 2025 23:09:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRsRVfzswU9TZMLgU8X9zbQwmh0f7uBPSkKfPZh6wavaSifURCU4c/3D0U3koIJrp+8x7MXg==
X-Received: by 2002:a17:907:9408:b0:af9:5ca0:e4fe with SMTP id
 a640c23a62f3a-afe294cef82mr2187075566b.56.1756361399304; 
 Wed, 27 Aug 2025 23:09:59 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-42-48-43.web.vodafone.de. [109.42.48.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afe895baff6sm749808466b.52.2025.08.27.23.09.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 23:09:58 -0700 (PDT)
Message-ID: <4e6b068e-e471-4618-b1fa-bbe20bde1307@redhat.com>
Date: Thu, 28 Aug 2025 08:09:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Failure for ./tests/functional/arm/test_realview.py
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <56800442-3962-43b9-9b87-1b899077a24b@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <56800442-3962-43b9-9b87-1b899077a24b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 28/08/2025 00.49, Richard Henderson wrote:
> 2025-08-27 21:55:08,729 - qemu-test - INFO - Downloading https:// 
> archive.openwrt.org/chaos_calmer/15.05.1/realview/generic/openwrt-15.05.1- 
> realview-vmlinux-initramfs.elf to /builds/qemu-project/qemu/functional- 
> cache/download/ 
> d3a01037f33e7512d46d50975588d5c3a0e0cbf25f37afab44775c2a2be523e6...
> 
> This url is now stale, and is causing the functional-system-debian test to 
> fail.
> Do we have an alternate?

Hmm, looks like the server is down, and it's not a usual 404 error. I 
thought we'd rather skip the test in such cases (hoping that the server 
comes back after a while), but looks like we don't get this error scenario 
right... So unless someone knows a different download location for this 
asset, I'd suggest to try to fix the asset handling code to skip the test in 
such cases instead. And if the server won't be back in a week or two, we 
still can consider to remove or replace the test.

BTW: We'd still need a way to enable the asset caching for those runners...

  Thomas


