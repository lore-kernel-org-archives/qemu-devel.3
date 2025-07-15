Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BCAC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 05:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubYeK-000180-Jn; Tue, 15 Jul 2025 01:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubYeJ-00017L-2m
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubYeG-0007EY-RF
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752558974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tVkiq47P5XoOulO53ufhWHTGMRKpI6tNCXQcYhptSm0=;
 b=CuafD+Exbly1Eo37MzaF7BrYRHfptIf3Yo5FkJGg4mXKpwU+dCOcl30U4cjX6YWKCt2yaw
 gfW443v+RyykQ1sii6dcXkXvlv5uns5BmL9FlguAdbw/WFBK4advl9KjyDtmMnhJjyv2kI
 YYdYegiHdPv6U9QUfOAwrpPCGzqZHyA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641--skKkpNyMh6SGxVZr0U-tA-1; Tue, 15 Jul 2025 01:56:12 -0400
X-MC-Unique: -skKkpNyMh6SGxVZr0U-tA-1
X-Mimecast-MFC-AGG-ID: -skKkpNyMh6SGxVZr0U-tA_1752558971
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4561c67daebso5041055e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 22:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752558971; x=1753163771;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVkiq47P5XoOulO53ufhWHTGMRKpI6tNCXQcYhptSm0=;
 b=SQfLpnVZ7GoTHFqMFAxzumXha4y+lyL/oZAUO0RstWCxUOW/DBHp9HaSrVCuxpJuqo
 hhaSAvMYu2G7l/218L4Q4ry/ze4/Y9kEc5s4CCLEAgO8KRquGqGpMcQX3cN7bPPcY7in
 4Zz61aeEv4BNh6C73qgSvhruA238rc8yGilr5w5PWTILuCHHaKgq3EGV7pdR1ZUCfjYL
 XdN/lwLBjDcRZ7txakycbVYhKce7lnDI5yqD9YyrXYDJMe0iVQ0i5f9GVc6H2LVYd8kD
 mcqmEpvLNTxKQFOT8SGfxnE1hmNBKrymmcMhNRnLSgX10lDZdRkM5X5e5ffIG9/B3v+E
 R1Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlBcRqzB7UjAy0I7VG2+cDVTMejTNuKD+JKSftFVHxEJ5GFy1t5b5DtCM5Xvn78A6/TCH0XnhcaJY4@nongnu.org
X-Gm-Message-State: AOJu0Yxl5GUsIZm3D1TSvkU1zbfDJ5+mVazmXH4MOKBzE99dwe0UzOxn
 ky6wTcw7X/klZqcKSyoXRPwIGLRFY19cZuOli+imQ7rWNQrzzeOopLgeokGYYsRjX/INLrn8CgO
 jnTPV5GCwYEfA12RQcAlz5aH5yLzrjlPyI5CznGvmv3XSU8rMJq7cjrVD
X-Gm-Gg: ASbGncsi/fzpG8HnyaemVSj28qI7XQ5xWZhxENa1hwGOFoPfdr01g5J+D+TyliKNntJ
 sofK8TXrjVSSUp/WbTQTyzWJ+2u9nPBGEJvxUQ4RpDOurksXOBzMZ+Q6BVgjQtSzl+A/MO+wqmM
 QGOA1uKGHKWCNZ0z2F2PFgHJYLtsf5yR1y5pvHj3vQ4FmrBvlVrk+Yv1Ng7hBTc8Mz6SyHTObUK
 HNUNqUmi7DHz3phs8T2DEYqTyBdGAarHRFDJC3SuOtITgv+lCyjN+3XaI1rklTT32Db32fERyhk
 SaHSukzV372DiCOprCJ1b2LQx15hFrMQpx3tFA97tIEKsC/puiU/iK5E4h3JZfwGJk4zZ2YShBQ
 =
X-Received: by 2002:a05:600c:6d1:b0:455:efd7:17dc with SMTP id
 5b1f17b1804b1-45625e663dbmr11953415e9.11.1752558971308; 
 Mon, 14 Jul 2025 22:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK/comgXml7++hUkh/U4rmkVXSnyRz7O+ZzXIZ+CPKhn4LSyhMEDZR8wK990U+8KxK14Lbew==
X-Received: by 2002:a05:600c:6d1:b0:455:efd7:17dc with SMTP id
 5b1f17b1804b1-45625e663dbmr11953225e9.11.1752558970844; 
 Mon, 14 Jul 2025 22:56:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd466154sm149203685e9.12.2025.07.14.22.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 22:56:10 -0700 (PDT)
Message-ID: <2b58e252-d3f5-4dac-8b39-c990d7240853@redhat.com>
Date: Tue, 15 Jul 2025 07:56:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] vfio-user fixes
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <20250715055246.422834-1-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250715055246.422834-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 7/15/25 07:52, John Levon wrote:
> Some small Coverity and related fixes for the recently merged vfio-user series.
> 
> thanks
> john

Mark,

Would you please re-add your R-b ?

Reviewed-by: Cédric Le Goater <clg@redhat.com>

and applied to vfio-next.

Thanks,

C.


> John Levon (4):
>    hw/vfio-user: add Cédric Le Goater as a maintainer
>    hw/vfio: fix region fd initialization
>    hw/vfio-user: wait for proxy close correctly
>    hw/vfio-user: fix use of uninitialized variable
> 
>   MAINTAINERS              |  1 +
>   hw/vfio-user/container.c |  6 +-----
>   hw/vfio-user/proxy.c     | 10 ++++++----
>   hw/vfio/device.c         |  6 +++++-
>   4 files changed, 13 insertions(+), 10 deletions(-)
> 


