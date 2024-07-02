Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95035C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOg1D-0004SM-32; Tue, 02 Jul 2024 12:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sOg1B-0004Rq-00
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:06:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sOg19-0006rb-5y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719936366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=unFyEi5ouy7xaXRXujvrgHxcqRcNuTxVBthd4DmNfi0=;
 b=Z+XN2LhfnGvV3SNEQkDvawJcyg1ZsGZ0cMjZvu8zU/5CQ/eEqCa30wvsV42GINing+TTRA
 jsEiSJ15LmIJDwLO4eDYb+Ce9FctDMls2f4bYS15owcpvr5u5+DkYKbw1BiCYe11k3kgD5
 EKCAkgiYDnQAhj/OzW331A6uxPOS0b4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-irgZAwirO-aSphHDEsb5Ng-1; Tue, 02 Jul 2024 12:06:03 -0400
X-MC-Unique: irgZAwirO-aSphHDEsb5Ng-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52d174e26baso6009515e87.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 09:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719936362; x=1720541162;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=unFyEi5ouy7xaXRXujvrgHxcqRcNuTxVBthd4DmNfi0=;
 b=lDDjzYIakBwns1TMk8kKF7Qi0pZN2o9CbhA4SnZ1dCBrXegtuhNOQvMEOoirCEuB+L
 35lMz+Z51mpM5AkBmbv+L5DNOQOCocZlg2ba1+BWdA0vmRFi65zest2SKyvnAKGlW7Y9
 mPq2TcE790MaZOrQciyVuY1zpDyO/+DXn8vytQ8wmVA8y7IzULNcVRaSOhW6QPK02F7x
 Iio2oz4LsidHCaa9+X2m56sCnfdCARmXbpSAT0pTf/TTcN5FOV+dcbHJVHcnQ52dTsjp
 w5kX9y0+3l/ma05Ba0YlZS2IezrXsUAvx+MjPIlcNrlAH5jNkGoFEfl+/8dcx1bRwoa6
 4e2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIFZQQJ9sMi6K1hurfKtDu8H2XP/Cw3kZE1Lr3kIoqfpzwZc5VktdLqU+eGWHuUSs/WdYWfXNVvG99G7FRr/PnS4V2PhA=
X-Gm-Message-State: AOJu0YzbnVCSyOwy00wut312pXKl9+IG1XUFpVZQahVMAjMcJi0n4Sr/
 OlCB5MVeCzKYgQkjekeGXL/dwhkTcfuvtPS64g/usXooCnzLujfB/420J2UJ9MlaM32FQLhxNa2
 nD5P93+b7fCLF3mhMk3Gk4K1e76S4J280LJxAiArl+9+CDYn8rCx3
X-Received: by 2002:a05:6512:15a3:b0:52c:8fd7:2252 with SMTP id
 2adb3069b0e04-52e826467aemr6461462e87.11.1719936361749; 
 Tue, 02 Jul 2024 09:06:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEFg9gJgxwCsy76XfkEhTu1JhJdKXL+EgouCVskiGkKD2p5rmSyCC74mbExEKIUw72xXmfhQ==
X-Received: by 2002:a05:6512:15a3:b0:52c:8fd7:2252 with SMTP id
 2adb3069b0e04-52e826467aemr6461441e87.11.1719936361154; 
 Tue, 02 Jul 2024 09:06:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36788e37b53sm2152772f8f.45.2024.07.02.09.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 09:06:00 -0700 (PDT)
Message-ID: <700534b2-0439-4236-be7f-ac75234d57aa@redhat.com>
Date: Tue, 2 Jul 2024 18:05:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Misc fixes on vfio display
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, marcandre.lureau@redhat.com,
 kraxel@redhat.com, chao.p.peng@intel.com
References: <20240701014809.255682-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240701014809.255682-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/1/24 3:48 AM, Zhenzhong Duan wrote:
> Hi,
> 
> This is trying to address an issue Cédric found.
> See https://www.mail-archive.com/qemu-devel@nongnu.org/msg1043142.html
> While looking into it, also found a potential memory leak.
> 
> I'm sorry that I didn't find how to test this fix, because it looks
> a GFX card is needed. Any idea on how to test or help test are quite
> appreciated.
> 
> Thanks
> Zhenzhong
> 
> v2:
> - set dpy->edid_info to NULL in vfio_display_edid_init() err path (Marc-André)
> - remove a wrongly added g_free(*info) in vfio_get_dev_region_info() (Marc-André)
> - add R-B on patch2
> 
> 
> Zhenzhong Duan (2):
>    vfio/display: Fix potential memleak of edid info
>    vfio/display: Fix vfio_display_edid_init() error path
> 
>   hw/vfio/display.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 


Applied to vfio-next.

Thanks,

C.



