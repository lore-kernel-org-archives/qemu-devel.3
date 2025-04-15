Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC652C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 11:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4eno-0001BW-Pg; Tue, 15 Apr 2025 07:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4enV-00016e-2k
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:49:50 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4enS-000248-0X
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 07:49:48 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso42090905e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 04:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744717782; x=1745322582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k+09kxgt2MM4odUUJteA52aWUfo2G2zDbB2kYCEXr5U=;
 b=EYqpD8MY6Cg0vctKOuCzTFCSJPyan0egYxHZMa91ShncsOfEYPXY8o/5Pxp5Le4qmX
 F+VCCnOOus8hVBjKxqG5yGiiSxhPgqJRavzI9FOI/3+EF4tKGcr/bnLjK7vxScw21t0I
 DaXgRr7gECGJUFjIn9ERRjOepdwkn2BxdWCAExAyRsXy7vBObiBg21YQUtRMvsjF/5IK
 aBKlBr9S8az7/P1zFYCoSccyT95MiW6poIbbJFEGhP08yY8ZmJF98ssF3JEkwE1wWyIh
 6ccD8xlF0cXOcvKbCM7z3mRZJMbF0ZhwvUF3GgPNTBmO2UVVjaRh0f+7TPqb+yeQtg1a
 DpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744717782; x=1745322582;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k+09kxgt2MM4odUUJteA52aWUfo2G2zDbB2kYCEXr5U=;
 b=JfruIRzw4Q+wqBeD7MM2Y1uvceDRYXjzxIsFUQ431NkJB8fVzR79srLP34LiSoK9Wp
 kX3TWOnBJN3Tbl6gjetNrSupyYpKwnDXbLhftazZFxN2zbYq+OgfgnghM+0vK8BCEQ/m
 jiYRhpzanUTr15IGWLEaJPcV7p8UIMws1mFAGxPHZF7+I7rb+uAMjZxIfyQ86gi7SG/t
 pKdo8KAF6qa+PMyI9c8Ag1NB3XXtW23TCq11Lgp/Tamct16SjnOAI4Gi9ln1hpZITqJu
 5SwAaeTwi83xoqSluKHgroKrtxhlNFQWFfgt49l9Xx815vISLPBM7ghM6tK9c3sEEzyu
 bPQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjMvg1tDMH7JV/hwaM5tTn5xqDHe0wLuoNrlCy0BNiCBDercy34KeiS8qbQUZ1EK8H4DFjjlir+t9P@nongnu.org
X-Gm-Message-State: AOJu0YwIe190dk13JSyqmPNksuLuLVwL8qsngLEPK03yan8ar6VfmndP
 QWv1Sd6a+oNfe6q4kGwWk0vauMGceDfTTl9SIHK+CTf9wKjRkOv17ghD5EayQz4=
X-Gm-Gg: ASbGnctB7bNVVdvT5TedDlN77amUhMgh0zvA8XVNkRAqAMx7An9RRTMq4uabrrspTPC
 MyYKlFXfnFbVITrtcuWMgszCMJOQOA1uv67yUwqgNgx8u+WYQbQeshIEsyloGkTOheiDMsWA6Re
 T7AoXURM1GvzyeT7fWXJZ+s4MzqjuA5VXsiQPeOiuQM4Ip1+MmPyroYXLCjTAKlHEdH4ycV4V2C
 Gd2djw7o1xMgj6hlULofTY3PkSaYt0hJxUZmKtNbn0U7jxJ5+Lf7eo737RkY5KGmDbyT+8wxahv
 FIUlXaGzB61AFg6HLgh5SLbZxYdMpe6bcknIVOsCXwiEc+v/JWYaFSm5R9PifDCfsF4fDLn8MgI
 qKzq/rRnCPHJgSufu+YD6haE2
X-Google-Smtp-Source: AGHT+IEGlhTAXU/PXLKFZeGDJEwJSAXzBkXToRD4nxvlOdX48SbzPjcz1cpD8mnFQXqKjhYIYYNGPg==
X-Received: by 2002:a05:600c:4e47:b0:43a:b8eb:9e5f with SMTP id
 5b1f17b1804b1-43f3a9276a6mr162409985e9.3.1744717782647; 
 Tue, 15 Apr 2025 04:49:42 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39ed1652a91sm8984819f8f.75.2025.04.15.04.49.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 04:49:42 -0700 (PDT)
Message-ID: <5e993b14-d94f-46cc-a6bb-b6f0c2057f2b@linaro.org>
Date: Tue, 15 Apr 2025 13:49:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
To: Paolo Bonzini <pbonzini@redhat.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
 <c6f8ace8-6dfe-4ca7-992c-2fd10faa6127@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c6f8ace8-6dfe-4ca7-992c-2fd10faa6127@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 15/4/25 11:30, Paolo Bonzini wrote:
> On 4/15/25 08:18, CLEMENT MATHIEU--DRIF wrote:
>> Address space creation might end up being called without holding the
>> bql as it is exposed through the IOMMU ops.
>>
>> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> Please use a separate lock instead of the BQL.

There is already a IntelIOMMUState::iommu_lock with
vtd_iommu_lock() / vtd_iommu_unlock() helpers.

> 
> Paolo
> 
>> ---
>>   hw/i386/intel_iommu.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)


