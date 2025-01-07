Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B625CE77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 11:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV7QP-0007Ox-7P; Tue, 07 Jan 2025 06:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV7QN-0007Oc-Rf
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:07:03 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV7QM-0008Ua-8c
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:07:03 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3862a921123so10372295f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 03:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736248021; x=1736852821; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HbHrdKWWQSfrIGWU2jvqyv8TSkK2ZfCE6JDdw/3vyf0=;
 b=A9k7Nmd+hOMGxz7YPbUPmqkgE3AZtFuZZGEvr3TnKle4L4CYKFpfz/KEWHpAclXYJC
 mRBFPKJ3lJxllEDSLm7OExNEleyAUmTBcMHcBEPsl17iEx83/HgDi31KTTwOThpoMTvY
 LmyteeG/yKYBjUqT0vtOTlU5xXsS3Wy8pDPJ8b+6JP7vxUKQpSAawc1i2Pl96019CfuK
 pFlEbO/X33QyDDfP/fXYgCaLQENLZFnQMxm/12CjZht258YCE7cTByu2jIJKVezqsNKd
 mKQT01lJiA7a/wXoMBo2vIWUFOQJufqOpOHC5bKcDnJlYLj4hBgJIpYC0MjLm4qnEAwk
 xeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736248021; x=1736852821;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HbHrdKWWQSfrIGWU2jvqyv8TSkK2ZfCE6JDdw/3vyf0=;
 b=c4+hkFlu/AgB/me535wk75sBsf9hKlz3Zkq1frEtl4x+/7wku1dbktHDzJVtDgbSDZ
 QHKRapZORGSThVtzaJO1dQUzxUFST0Mgoe/i+3WN0n3DjpTjTASm6tim/hWUqPOPeXvW
 8Ag+jk5xUa0J82JQxy2eDOgKRXCP0SoRs4EUzBPFuiUEmSU35dijs3ROA968BeYdCmLq
 8J6VRpvokR8rqgy9xcX1NO4+4CdyQCuKlHokkyooYVqLAwR52Md8HoOMdRk2JD3XEUUx
 vM+TbbCE1UpqV6lI3iJXjBlXXvmRWpsNFa7OCvbUybUT9L7o5C1gaqLBhtZzUmIGaE7y
 ibHQ==
X-Gm-Message-State: AOJu0YytNhsMZK3whDKxO4AgLIJTIQyGJRaGSCc/5HX4WpPOSBK3LPyT
 9KL2DSwm1OFJgNu/KOEN//fX10UJ7r510gRELAn/EbwCs2rtqV14OfnXsWdLDbo=
X-Gm-Gg: ASbGncu74+889kKD4ZVgJTp+VPxezfiUHH/KA55kue+dMJztHq6I53GFl2kJTFgAVsR
 NMzk5Y+sJ12OLwZgYHceCgeuNtCWDETN0OxyLKpr8IQ+f+qD57Ji3+2t7iKXwKj6cYwcKOzQBCN
 rF6dYEx4KbJMJX3t7eMu4ejDhLODijpFBh9Gt84TcT6xZOVfN1hy9wjYGFtXcIlPTCtfHXKcXjS
 ze+hO7dXbof82lFDR7WQCa5Hsd6LEvOx0Dr83iWS+70J6WkSMuUHFL3aY/6CKSGAOVCf71IXYv4
 BvlkfA6wtD7kIlevTQpA8LZM
X-Google-Smtp-Source: AGHT+IHOoq8RQbId2eGblDDLYZFGlay79dqYEToH4LuhkVASAfUB4b3eIuZR9aw+j7gEEb5Z4P7QTA==
X-Received: by 2002:a05:6000:4024:b0:385:f349:fffb with SMTP id
 ffacd0b85a97d-38a223f5d8cmr47228199f8f.45.1736248020711; 
 Tue, 07 Jan 2025 03:07:00 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e2dfsm50760085f8f.74.2025.01.07.03.06.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 03:07:00 -0800 (PST)
Message-ID: <172f81ca-1555-4657-8828-0580337c1170@linaro.org>
Date: Tue, 7 Jan 2025 12:06:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] hw/s390x/s390-virtio-ccw: Remove the deprecated 2.4
 and 2.5 machine types
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250103144232.520383-1-thuth@redhat.com>
 <20250103144232.520383-2-thuth@redhat.com>
 <b467ee64-274d-4e69-b5b8-4b92ecbf428d@linaro.org>
Content-Language: en-US
In-Reply-To: <b467ee64-274d-4e69-b5b8-4b92ecbf428d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 7/1/25 12:03, Philippe Mathieu-Daudé wrote:
> On 3/1/25 15:42, Thomas Huth wrote:
>> They are older than 6 years, so according to our machine support
>> policy, they can be removed now.
>>
>> This removes the requirements for the storage keys "migration-enabled"
>> property which will be removed in the next patch. It also removes
>> the code that sets "max_revision" to 0 for some CCW devices, but
>> the relating code in virtio-ccw.c indicates that 0 could have also
>> been in use for other machines types < 5.1, so further clean-up for
>> code related to "max_revision" won't be done yet.
> 
> Please mention commit d55f518248f ("virtio: skip legacy support check
> on machine types less than 5.1")

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/s390x/s390-virtio-ccw.c | 37 -------------------------------------
>>   1 file changed, 37 deletions(-)
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


