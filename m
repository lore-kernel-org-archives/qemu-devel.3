Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FC4C9EC94
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJEH-0001h1-E1; Mon, 12 Jan 2026 09:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfJEF-0001gL-Oj
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:49:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfJEE-0000b3-D0
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768229349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Jn6JcsfnrrSV95IrbL+p7RCplR7Y9AxOoYDNZ0ZOOSM=;
 b=ChNE1nmZvruvGplLcnY3P8cwYXH1Cq+o4Ryhrpl3eHe40L7Vvu4xnQI/V581gGsZxIsXLA
 74XHNQID419BV+9+T3RTGcUekZ8DJcTUeWUUcGUEVh71e6H8qUcRcYRBrZ56BJXFZCcuiQ
 cpg09r8TxIXxVL//A6D0ZCf7MzCOzLI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-BMl6CDb5O3GMMtwbaKsoqQ-1; Mon, 12 Jan 2026 09:49:08 -0500
X-MC-Unique: BMl6CDb5O3GMMtwbaKsoqQ-1
X-Mimecast-MFC-AGG-ID: BMl6CDb5O3GMMtwbaKsoqQ_1768229347
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d4029340aso66737045e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768229347; x=1768834147; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Jn6JcsfnrrSV95IrbL+p7RCplR7Y9AxOoYDNZ0ZOOSM=;
 b=LcmAYwdZU0exOh3ZTCug3aYeM776dAP+by4YGPWcl7auzcRmKBkEmlmIi1ZEPPgiTB
 m0v0iaiTSb6gJ2GKgW2A3djMeAl5sqfd+m3e/n4Jdow1Yuz2lCZwRgglx7XC9wkMhzHb
 HCbHdu1indWOwL/G9kpK8RllKgq7/hAlFIH0jq0i50bw+72F8cW/qr7DDc9G4d/bUS6h
 R8CO60G4QtwTOAKBA8cCsYrVPtXk6HG+lPh0ZX37rqueJRFwbAUrDuY+pfZeasCHN9/L
 l3zNAhf77qucIBJqmzTLU9f5qE2P7Dyfasjl9ouepBB6B4A3NvW9/p1s9yhGqaJhaZti
 SuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229347; x=1768834147;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jn6JcsfnrrSV95IrbL+p7RCplR7Y9AxOoYDNZ0ZOOSM=;
 b=MoQmb6ZYHdhKsvzSihMCK+xQyvAsqabSRUe6rs6lNd3Km/ttuoFbCZsckN656/I4su
 +F7VhIYGLHoIkqpjaJlHofRTQyF1HAQ5oWp2vcymVMHejMu7ewPqB7B1I/CwQI4M5eA9
 6/MUaNGCoExqqmvOJ4ruIsVJ2JEEvNTAsrtuHVhYP46aaC7CL8+mAAHwjxh0DaFh8FxF
 FDMh8AQCQwstpfNJNcojyAMFaHcxq1rhod+3y8RycNHfCYE7seEyC0P/Z6b9sOuzizmH
 +URT/YhgHUXYRfxPkz8ewlHMQneQRb90lBFkDzSDzRuU5j02vFUlatrmprkR7QJOlsba
 FJBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGC5aJ9fsNANBHKkVto1txBTWxkGW04r5DlQ/3kHefRxgMukd6+rCploJKBldAvqmWP4zVr5hhsWgD@nongnu.org
X-Gm-Message-State: AOJu0YwVErG1epaDDQE9BChjmyA13M15Y91YOFPd6TcPdKGUWJxG7BnM
 Yl/pwH2fqVfbyb2LrztIk3eLJNmp+XWle7UHa6eopO37uXYiWFiNs1CklsFsE5gx1uA8DPCg57x
 2sNPb9bqyKl/H8MVOYY8LdEG5Pw7BmxrdkG4UoC4uflh7PLxNkyNVtY/+
X-Gm-Gg: AY/fxX76oyb8MJl3AUMI5Le/wGWhYC5KAdaLLyvTCPr0Uzwdhu9ZEeXtFrCbqxGOmEC
 etVQ6n7os1AiRAVByOe7fe9OhDArOqz4nwJaIxn8+IQVMDIwO83egHrw5gKvrrWv7wmtuzRPS1V
 U1aqwEB+axzqzbf8zRC1uumnkCyJwGvObUlsi6NFn8d8XcteHoVm+6XCCuB3h+bdUEn/Oe0ZNz7
 cROJKsxl1RwnvFUi3MCn7biKyzMWtOhR6d2RP7Xp9XEzQP+nz5VQGWBiE8dz/5XW0AaNa66loIE
 qBbOoFR2gcM3bX01DTJXJn6d8bX3mTW0eqPS/UdhGfvUeQv0hvFKoxvBm/QLM3LrI4NwmUyRqdj
 AK5aVRNQ=
X-Received: by 2002:a05:600c:3556:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-47d84b086ccmr220254745e9.1.1768229347320; 
 Mon, 12 Jan 2026 06:49:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHur268RiwnNs4khCvWqTFbUAEMuQkvD4FSeBl0alsywb+4WgDOZ2+M68TGzH8k7mlrna0BDQ==
X-Received: by 2002:a05:600c:3556:b0:477:8985:4036 with SMTP id
 5b1f17b1804b1-47d84b086ccmr220254445e9.1.1768229346863; 
 Mon, 12 Jan 2026 06:49:06 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d865f84besm139720525e9.1.2026.01.12.06.49.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 06:49:06 -0800 (PST)
Message-ID: <63b9adc7-c23f-4f29-83f0-b370f849511c@redhat.com>
Date: Mon, 12 Jan 2026 15:49:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 23/29] hw/s390x/ipl: Set IPIB flags for secure IPL
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-24-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-24-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
> If `-secure-boot on` is specified on the command line option, indicating

Change the "-secure-boot on" to "-M secure-boot=on" now?

Apart from that, the patch looks fine to me.

> true secure IPL enabled, set Secure-IPL bit and IPL-Information-Report
> bit on in IPIB Flags field, and trigger true secure IPL in the S390 BIOS.
> 
> Any error that occurs during true secure IPL will cause the IPL to
> terminate.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   hw/s390x/ipl.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)

  Thomas


