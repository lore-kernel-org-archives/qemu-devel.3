Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFFCC77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 14:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU4bd-0006CQ-Kz; Tue, 24 Jun 2025 10:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uU4bZ-0006BL-KV
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uU4bS-0004qF-Uu
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750775183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eu+B+N/ewWxC60XSSpDbg7tc8ZeIeBvsO6fyf+FrIJw=;
 b=P+te6UD1y3uivgWkwowC3oRfQxHBliL7mAdJCbqJWK7txw4vmGOenUpOunWwmX+dXaWfHR
 70DMXxj0L7+Gc0HfQ2OYPa2aJX1cOunknkmTZvWxek7FBZ+zUWHB5vfZuZOtTznMsYMj7V
 g1tE9QMQ/i4EvyEB697+Iphs7kl3An4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-eNxZNsLWMiuoRzJo15Xojw-1; Tue, 24 Jun 2025 10:26:21 -0400
X-MC-Unique: eNxZNsLWMiuoRzJo15Xojw-1
X-Mimecast-MFC-AGG-ID: eNxZNsLWMiuoRzJo15Xojw_1750775180
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450eaae2934so46598945e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 07:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750775180; x=1751379980;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eu+B+N/ewWxC60XSSpDbg7tc8ZeIeBvsO6fyf+FrIJw=;
 b=VZTon2t4th0wgj4uZSVMxM8XiQVi/wBMuzOyZG83jQXTnNWFHMgMeyaXGT+kBjhFXG
 l0FlfUeNi2bAQ6bxBzm6aC2R1bLGf76XsmDuYzhajI7V5GBvNFZtmDk4KxuqvoBFJerr
 2RBITYFJ0wqOlQZAsyu3FRzW9tjjMGQc+WcQo/s8Y6lJmrEDmsBVnmJ+BfNiA9ZL4me9
 7CeOuM7pJMd9DlmnrDM6xs+3+wiym6TaprSaMji3CLEG83AhtbKPdcRpR9wuRWQ2gAny
 ivgOMBAW9GYHoHHzRftpHcLoFKLy9hlZTKw3C+6UgLsDp437CAiZWt7eJ/E48aB+x8ry
 i1xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7CJP3T1nkByjeuD+nzKGJ48mmZtlDjyvXcSVnjVu3QkxXaYFThEJEsn+UZW5aotwQu83Pg/W9VfJ5@nongnu.org
X-Gm-Message-State: AOJu0Yzm7I+R9zMSHWCXnX01twqeZ8VfdCgMd4kCN4o7zfp0cFuxpiGa
 CvSx7OfamhWiAii0Z2mJz1oOri3z0ZaJV+68fznVWLVumBFvsL26V5lFPyWo7GjJ9/BSAPBkEHP
 hcfD3SLw4kNQgQGjwIeZvsIpRv8mujgPBpsJDwPhWH32JRtj/QezP2vtQ
X-Gm-Gg: ASbGncs6XJDyhGW5UMkdi8St0I0tPV1t53gAGomsrV4p0hbbatcvxTau0qDIChDbZ98
 onxi3pWkxKFSUc9nP7tKOIltJy3cBhB5aKjJL3GEakrIrNC/J6KeE3Wv/aHmT+gNl4HpMk3YmMa
 ssuYTHStZ9fdB2r3qbZ9m5VI8SyJFn+etNv9l19wSPkUpjhF9Eu/W5w7Xo4ywz81dojjghdrvGN
 HAfUMUznyWiGXJzI63XZxXRbiZi4l5MmHNY43FuyVXaqChLNROxyIdkwSq5q6maeE2X/zub/x9t
 YcpelKsMjMc2XZKrlBsp7n3k/aV351xZkT65SZXtdxmf88XbkWMwBZt9STRGlug=
X-Received: by 2002:a05:600c:458b:b0:43c:ea36:9840 with SMTP id
 5b1f17b1804b1-453659ef74bmr154627375e9.22.1750775180303; 
 Tue, 24 Jun 2025 07:26:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr1Ux5V6+kjdiqy8m6lC5M3GfPKtcz8rp8Os1k72405GO3AC9iuiNyz5vQiAjJyaBvbq4VAQ==
X-Received: by 2002:a05:600c:458b:b0:43c:ea36:9840 with SMTP id
 5b1f17b1804b1-453659ef74bmr154627035e9.22.1750775179921; 
 Tue, 24 Jun 2025 07:26:19 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-198.pools.arcor-ip.net.
 [47.64.115.198]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45364703f1esm144649985e9.32.2025.06.24.07.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 07:26:19 -0700 (PDT)
Message-ID: <ac5282d5-0b23-40f8-8625-472fc7844303@redhat.com>
Date: Tue, 24 Jun 2025 16:26:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add reviewers for some s390 areas
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 alifm@linux.ibm.com, jjherne@linux.ibm.com, walling@linux.ibm.com,
 jrossi@linux.ibm.com, qemu-devel@nongnu.org, zycai@linux.ibm.com
References: <20250623160030.98281-1-mjrosato@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250623160030.98281-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 23/06/2025 18.00, Matthew Rosato wrote:
> To improve review coverage, assign additional people as reviewers for
> multiple s390 sections.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   MAINTAINERS | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Thanks for your help, guys!

I've queued the patch now for my next pull request.

  Thomas


