Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851C3CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kfg-00080I-46; Fri, 17 Oct 2025 09:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9kfd-0007zj-EZ
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9kfR-00019C-7e
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760708321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l0PpVsLZnztmstQVfoWafvCs5m/0bcAjmtM6Fga8fh0=;
 b=cLkMzwjOfgspoeV/oGbD1GEQPkZNULreE0ll2n8sNQ8mQg2p/R2WkX8oue2kvsKWYL1j8G
 DU9Uc1SnAo0daI6BQd1UVXsZjKR1eR9SnuL7AH/oYHJdE4mnyn7sY3d/7Dk9AG/cjc0yIG
 tiGNqaGBGDH6A7KSG6ED2QiCfHFtoP8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-la9JyGDgPNWpyYy5aabE3w-1; Fri, 17 Oct 2025 09:38:39 -0400
X-MC-Unique: la9JyGDgPNWpyYy5aabE3w-1
X-Mimecast-MFC-AGG-ID: la9JyGDgPNWpyYy5aabE3w_1760708318
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-471144baa7eso10725055e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760708318; x=1761313118;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l0PpVsLZnztmstQVfoWafvCs5m/0bcAjmtM6Fga8fh0=;
 b=BldR/NADRTgKi+88hK6yeCMIKk7hNDf2NW9uTJu3VeYJKTpGzyxcC0iAmgJ9YW1LdF
 hg6KlaZlyzmFKEIlriw0+33lTldLEuthp4kk2IlukAMc9R4+FpXNFNwsmOWaYN+AiTYx
 1NZ0MJEb310rckb+eYKOIDbb61at+w0Jidzn9Ih7IFYQNETYDWR/fEuHHsYCQ5yPbS4i
 82NTeuRUJtuTnBY7NiqvasRoa+M21iJwSdY8q1nn8tAqUMIAKw7vT9bI3kO1t3cxEmpF
 zxRDlRPtFEuTVTZL5DIlUlgyOqxjA4v2DfWiByV+FU7rB+0TJdJyS0Wkk0+KKX+vvs8V
 aQvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmD7FmW/+Gi4X2tSuds9aykjQ4LscjQbTtIWNTSYGLA63kSTgKmQuGl25eyN66XxHRoBU7qzSMBger@nongnu.org
X-Gm-Message-State: AOJu0YyDq94yzdD9Gq4EKw24ACdMSYHnu+n2ZAmT5eySgCkB3cMHIkKR
 C0UnbsdQ+uSIReQCis/aDVSmg5wWkVfMBcIbLk1N0w8k61V8fcVlzb8HYeAsEiHtM7ZiWpAwJLN
 kbng2WSvCcDvjzPODIoBQb8FrJEcvBSKjdw92Jrx6lgs62YkPRrfjpRCo
X-Gm-Gg: ASbGncsb61x+GKgRWoO+Cdld6HwtzkhneLArHgcUXrN3o5s1P1TTksY1LFlQmJKJ+I/
 XRJJj2MlgkHAt2495lTWl2mizKCFhVuYQZGdcyYoWqZWUpjGSUmLJJ6RYIp6YfBTWJuU7m3HbZJ
 OLL3KwOtfDVXFGcIqdGXZ4E4Q2bnke3gttd2PpL0DxBmd/g4np4B8m+rvJfLz1mn6aeBvVYBN+L
 WG62FEbEpCFqWVv1l1navEDOk0Gis4qEurG6QC6mkuwIWiAngOMNs9R+o0PdLeC9hcCo84IHLXE
 X+OMfgXPcqU9ACDcuKoZ+4kXVuHcJspPZXwG1JlE+KNyNtQIy8BarH2pT6KsKiJrQfKTPKJB2tE
 U/sx+bdR5p5+SOfhRetxhZUitN0AVP/UE/VH0HA5B
X-Received: by 2002:a05:600c:444d:b0:45b:80ff:58f7 with SMTP id
 5b1f17b1804b1-4711791fbd2mr28436835e9.36.1760708318025; 
 Fri, 17 Oct 2025 06:38:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXb8TDWZYD5x4UbuptLjbmhlXtoRuKEWlJ+hn8G8K7ieIHkr0Ad/t/YVhaWrk6csGxbLJVUQ==
X-Received: by 2002:a05:600c:444d:b0:45b:80ff:58f7 with SMTP id
 5b1f17b1804b1-4711791fbd2mr28436435e9.36.1760708317602; 
 Fri, 17 Oct 2025 06:38:37 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-135.pools.arcor-ip.net.
 [47.64.114.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710f2ab58bsm44754885e9.10.2025.10.17.06.38.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 06:38:37 -0700 (PDT)
Message-ID: <edfb9f1f-b375-4295-8e61-0b86bf5818b5@redhat.com>
Date: Fri, 17 Oct 2025 15:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] hw/s390x: Remove s390-ccw-virtio-4.2 ->
 s390-ccw-virtio-7.2 machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
References: <20251017133002.61410-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251017133002.61410-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/10/2025 15.29, Philippe Mathieu-Daudé wrote:
> Remove the deprecated s390-ccw-virtio-4.2 up to 7.2 machines,
> which are older than 6 years. Remove resulting dead code.
> 
> Philippe Mathieu-Daudé (12):
>    hw/s390x/ccw: Remove deprecated s390-ccw-virtio-4.2 machine
>    hw/s390x/ccw: Remove SCLPDevice::increment_size field
>    hw/s390x/ccw: Remove deprecated s390-ccw-virtio-5.0 machine
>    hw/s390x/ccw: Remove deprecated s390-ccw-virtio-5.1 machine
>    hw/s390x/ccw: Remove deprecated s390-ccw-virtio-5.2 machine
>    hw/s390x/ccw: Remove deprecated s390-ccw-virtio-6.0 machine
>    hw/s390x/ccw: Remove deprecated s390-ccw-virtio-6.1 machine
>    hw/s390x/ccw: Remove deprecated s390-ccw-virtio-6.2 machine
>    hw/s390x/ccw: Remove deprecated s390-ccw-virtio-7.0 machine
>    hw/s390x/ccw: Remove deprecated s390-ccw-virtio-7.1 machine
>    hw/s390x/ccw: Remove S390CcwMachineClass::max_threads field
>    hw/s390x/ccw: Remove deprecated s390-ccw-virtio-7.2 machine

NACK.

Being deprecated does not mean that the deprecation period already expired.
Please re-read the paragraph about machine deprecation in 
docs/about/deprecated.rst carefully again.

  Thomas


