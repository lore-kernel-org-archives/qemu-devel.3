Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED46CC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 09:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8FIr-0002g8-AF; Fri, 25 Apr 2025 05:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u8FIo-0002fY-Sd
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u8FIn-0007Rf-1S
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 05:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745573094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+SVSxrDY9usPF+nh2YsD+NxEqirQp5jCaply9kzINU8=;
 b=Rvv3PuHuL8MXTUQ0R1WpPRHwgcla5oWSpG/Wr61ETulXmSgy1S6+MosPxU+3aEgIZ1swv0
 gKdyuYlHl9YbS1CbWbOUsK9V7scI3D9GjTAiR9faSv2wobLFeruLaBsHYGWDS4qvR3cZSR
 H5iW2N7pNaWe1d5vghRNXUPLIl3/IHk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-GDlAct7zPSSYjVbLCJoLBA-1; Fri, 25 Apr 2025 05:24:52 -0400
X-MC-Unique: GDlAct7zPSSYjVbLCJoLBA-1
X-Mimecast-MFC-AGG-ID: GDlAct7zPSSYjVbLCJoLBA_1745573092
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf5196c25so9792365e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 02:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745573092; x=1746177892;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+SVSxrDY9usPF+nh2YsD+NxEqirQp5jCaply9kzINU8=;
 b=NCQCaTW1L5pDy8NawvIzszYHK7TX1JlNC7rIeb0m/mvl+ChR3TvixSl2m2AUp/+IuM
 J3KcscC/3yd1kPfvERVqYopKDGfHcBiegG82qQbzUQGwLavia5wspShGak0oQrIhEIQ+
 TJwTOoa/1PtO2c2pV+p6VYG3gH0hvTKHIsa8E/1IviHzR88qqjsTCkWL01SzXRl2r8jL
 fQbYuSM2Nlfk7HtLdnzy1zmFYApo38yEk60ZvndY5agIsianrZEtUS6yDuMgsi3J/AIV
 4+B8Lgiqmd1m6kMscL7fy0xMkAiYNlKyBE7abP7NRjzOoT2eVkcp91Utt9V4H8v1f56b
 vCaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi7z3Ws5CACtRSVg6OoSftz4KUPH+Bxmo/r7mrHXhxWWzmCEKljHC6C531JLzrG3FQqIhCPnUzGiKA@nongnu.org
X-Gm-Message-State: AOJu0Yx1eEiAdxhXrDLmtkhwk2i4BHqrHTW1Wysz4R98dNPL86czbC3R
 GgV5BFhr6OLObUx8K93ImoNeYrnpRLtOOy8pB+N9UZ8uYjRs4Nzf53rjjykac95PQD7JaTrOS86
 zB3UcmeFa6CDZT1H/yf0RaVJLYbgKOVq+b10o+D9iEP3PhB6aGeVhYKt1Hwbyg6E=
X-Gm-Gg: ASbGncsVa/RYsUjU1gVi0LgLmO5wHomIKQC7PA52BfwQPCmt9SfD2T2tIyJo4tezKkl
 bnieuYisxpbiR2I8iIoVT1v3PPr7UhL9oz5HhEoAeP21oUNIcq8W1WAOJdQpT4WUvu/FI0ABr0D
 UiR1twxYp/nESZg0SOTUfeD1deFeH+um96dfWWi6tUtn6KIrC/RCxcYMOjujDFs8YVpFr380BGf
 ozj0VTlQji0si1CgU5u30wsMrEShos4oEM2FWeFGwEmNio9EnBY0JTTyHKW0AmFQUv57tRdINPN
 vpMSTPo56wqECZDTpBP8UowmgYNvzw1XI5Axm3+j9BlakQ==
X-Received: by 2002:a05:600c:1c91:b0:43c:f050:fed3 with SMTP id
 5b1f17b1804b1-440a65dedfcmr13399095e9.11.1745573091749; 
 Fri, 25 Apr 2025 02:24:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvPkWuK51XO5l8m6s2eBi9FK7QCOD3qW5hbwbczl+u5/s+wcc0EIZwuOMs9AghLCgoiZORsw==
X-Received: by 2002:a05:600c:1c91:b0:43c:f050:fed3 with SMTP id
 5b1f17b1804b1-440a65dedfcmr13398935e9.11.1745573091362; 
 Fri, 25 Apr 2025 02:24:51 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-178-177.web.vodafone.de.
 [109.43.178.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2a1dc3sm49688565e9.13.2025.04.25.02.24.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 02:24:51 -0700 (PDT)
Message-ID: <fe17213a-388e-463a-a2f0-4977c5e86197@redhat.com>
Date: Fri, 25 Apr 2025 11:24:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Enable QEMU NVMe userspace driver on s390x
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Cc: stefanha@redhat.com, mjrosato@linux.ibm.com, schnelle@linux.ibm.com,
 philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com, fam@euphon.net
References: <20250417173801.827-1-alifm@linux.ibm.com>
 <15457df6-11fd-41d4-9cb1-14e4473c1866@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <15457df6-11fd-41d4-9cb1-14e4473c1866@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 24/04/2025 18.24, Farhan Ali wrote:
> Hi Alex,
> 
> Polite ping. Please let me know if there are any concerns with this version 
> of the patches.

I assumed that Stefan would pick the patches up for the nvme/block tree, but 
I can also take them through the s390x tree instead if that's preferred.
But please address/comment on the nits that I found first.

  Thanks,
   Thomas


