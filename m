Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B69EE99049
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB6IC-0004fS-MP; Fri, 10 Apr 2026 03:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wB6IA-0004fG-Ex
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wB6I8-0006wS-AJ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 03:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775806115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hJnrr/zC+83AI7h+d0sONzJwwmF2Jk/g5jqjj/CWTTg=;
 b=d7Y3Z74yx1wNzBqybZsgCRW0clpfcBTQEJ5v64sS3NhEtd38DZww1D9QUmqqMPACT0xytU
 T7nKReav9rAoae+KYqnGWjiUJu8ivlwcRNk6if7+rXZsnJtvJnif6XCS6oaCo/lsXZLaGa
 KyinGpQxX7o/kSYnNog78JsnU/SuNAo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-cqh-FpkKO2yWxN_atiRfxw-1; Fri, 10 Apr 2026 03:28:33 -0400
X-MC-Unique: cqh-FpkKO2yWxN_atiRfxw-1
X-Mimecast-MFC-AGG-ID: cqh-FpkKO2yWxN_atiRfxw_1775806112
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488bf01961cso11444155e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 00:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775806112; x=1776410912; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hJnrr/zC+83AI7h+d0sONzJwwmF2Jk/g5jqjj/CWTTg=;
 b=kVCNsG7Eh80TmNQXKPV1QnCl6yw/R3RQ6YMoyCjhwBYxH02U0ZVH2DxYOCtpHa03Mi
 Mm/EVeoRfl/4046pj2+BvP5heZBp1JXb1cYxTF37yarDPsZ/ZFxbi6yGSrdO6kRWJKyw
 r8z6ywI48CyUzA7pDNoKhNRj6dgEyBRM8010Vnm9Q87wwTkJERrij8cgV9lhtp82MznD
 4bhigVTYB4ssIk+I+mReKdVZq+rPs6SGKxITQkmfvNfnKg7oamolm6LAJF0Z9u10XAYd
 hXpjQbDXcYg7J76WBsEEfhqXPCvSAIMBzsz4n1nW22UHXHDKWnRLxt5xV4oJBYsO7ODM
 OEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775806112; x=1776410912;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJnrr/zC+83AI7h+d0sONzJwwmF2Jk/g5jqjj/CWTTg=;
 b=gtK/sg9KjyhtIq4I2H8BkddJ57nvNUaWthjbku8pzi5gLFn997vJ1CwvrIEv79U84c
 XLexW1o3rqofl/lzeWyxKx+Bj8mPRNorJHA/0flqvjnDHjCtf3TEDpvX137xcQDQQJtA
 fvYKf4/fN3yPu1n93aDh8wBm4CDheaD9n7Iu29jHTR+X8lci0OPsosbJPj3QPzDVJkUK
 6fazDjX2UWD78f5rZMCmP1UIGaCGe0kLPecH751s/VDBUx+ONzJuOVf1EGzruVcEiA2U
 3RRqXyXltaUKRcrvwB6kxmF6WlD28ZBi/OvR7LtFGBK70oTtRB1WMPNYwn0s6eRzMzFq
 tk0A==
X-Gm-Message-State: AOJu0Yxqdwqbczk+YlqHRRMieJ5vmu3snVIKLrqIWtAGEMCe0xlqJm/N
 /AcUvTbe94vJIv1OczJos5MMWjVhmsNdQRNFDyY4PmIlbD9dgpiroJTQwuHBBMIb3Y6Bv1ksvI0
 3W2Bi9v5pztqDGK3JPvwWQSeB1fBB5EXlCxIzVMkuMCDW5zrQbXGiRdOG
X-Gm-Gg: AeBDieutiOoF7bj+jvtWZzBzOclQVjc1Zn+BKQlPKEj7jlU14DZUG2wIryZzZWHM22D
 j7snEEn/hSE/4nh1Rtd+KJ6HWaOJDY0abZ90pkrTuo2+wfDaCSs9jEfB6Zi55ysIZcYPU/BR19V
 9ZIeJyQYbz+J/uTl7H6xu3marlD42y+UCKl1OgON53GwWSIuBaIlsFPc8pRVC9Ph1Sdne0vtVhj
 O1l0HO2diyPH8jJE3b7F2rJfInCHNRVMsHm+3Y29O4EfOCQalwlFFFgHEkxi6LbZ7CaXrKAMVk/
 VfCEsDQS0A6kD4SQjv2I89DSRDE1y2LYS7LZt860K2cvL/dTPpMBnwznsdC7WUZKxm7YQ372dfh
 Xb1cvNfq4nnS34tbx37QVrwj1j/o7o+OqIC9vQz+deFr5EOuQCF1Hr14l5Q==
X-Received: by 2002:a05:600c:474c:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-488d68101edmr22044135e9.10.1775806112429; 
 Fri, 10 Apr 2026 00:28:32 -0700 (PDT)
X-Received: by 2002:a05:600c:474c:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-488d68101edmr22043765e9.10.1775806111992; 
 Fri, 10 Apr 2026 00:28:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63de2a53sm5432776f8f.5.2026.04.10.00.28.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 00:28:31 -0700 (PDT)
Message-ID: <75d9ff43-6c96-4b17-a8e3-449a33237ad2@redhat.com>
Date: Fri, 10 Apr 2026 09:28:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] vfio-user: support VFIO_USER_DEVICE_FEATURE
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260409104756.465294-1-john.levon@nutanix.com>
 <20260409104756.465294-2-john.levon@nutanix.com>
 <6c5a98ca-2ac4-4239-b3aa-30e5572f2c72@redhat.com> <adecGoLC4Txe18Fm@lent>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <adecGoLC4Txe18Fm@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



>>> +# device.c
>>> +vfio_user_device_io_device_feature(uint32_t argsz, uint32_t flags);
>>
>> missing format here ^
> 
> Oops, surprised I didn't get errors with this

Can you please resend ? I am preparing the vfio queue for the
next cycle.

Thanks,

C.


