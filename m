Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4088C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 13:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWaf4-0004cE-QI; Tue, 01 Jul 2025 09:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWaf0-0004Z0-Cp
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 09:04:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWaes-0001Kl-Oc
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 09:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751375061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siEVzg54bB6hMR8nN+g1PnrYQnh9N6S3zyer1vy2HG8=;
 b=FkK7lV2kMaoky5CL1wvOxnGb7+lovYL9QvFYEVHrSSSwqvhs4GBeiqUpS+8fJkIezIiBcM
 7YHTPFp1isGo148x+fzgaxnnDAg7y3IkWTmBeuePqwMPwjuWPwTAR2cbMU2VXISHg9QkCY
 i4Uaxp/e+0jLYhZfDQiPHISCSY6wbVw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-5fhMzWKJNqOYL7agxNOBGQ-1; Tue, 01 Jul 2025 09:04:20 -0400
X-MC-Unique: 5fhMzWKJNqOYL7agxNOBGQ-1
X-Mimecast-MFC-AGG-ID: 5fhMzWKJNqOYL7agxNOBGQ_1751375059
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45359bfe631so27003495e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 06:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751375059; x=1751979859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=siEVzg54bB6hMR8nN+g1PnrYQnh9N6S3zyer1vy2HG8=;
 b=asLUNBuoRFGX2XnT0PG1KqDvZQQWXsqA6r+qtmdE45LVVxvL4VGhDW1yLnREklEITF
 6MUiD2bhaozV9kseJ8bfL1WHhCfg/Yu3dx3alWCWyjw567LEhFW9a+E8bNlkbsnvkBEr
 RsdkkFHbDY2hMCbek75ANZ8cok4dBjPq+6MgB6IVGVsRfQZAl1q+hpUR8DW8AbHlwtgL
 2iPpPODe6iq6ad2RmyOAAdmlS8Je2u6BHWlbDBw9OCLNtcxvyQDPI0a+zkKaniG+eFll
 h7w38w43Zd7AHGUq1nx9aYDrdWXAEWsxHuH1iw+wq0TUb9zNHwj9K24iI1FVknPpUa89
 SQuw==
X-Gm-Message-State: AOJu0YwNfk4Ht93m+jgAH9fGNF6apUPQ+xDbmPxthOcei+7WA/t9pc6N
 vDk4GEId4uDnUK+J0bIp3M1AZyg1S2dg232H3S8bLdnMsRiw9oABL/+98VBjqwRifS2muJFRujh
 k9HlWegylPO5D5Wq+FvqbYiU6mkIOrkvA3BSqZqsIw3uyez2jCxIR82Nj
X-Gm-Gg: ASbGncv7zskwFZbAGo485eCCTsQ6w0i6Pe8d27RXiwfNLvzJpPznQplGJQnQ8G6qwbD
 ge1WLHi59f4raNE+p8YHoD6bwnhiWJEDYNi16x028m7MYEyg4LE78BGii/p2lmaBmtgkaV+5sGo
 x4TrQEKVxR3Kizug9Y82fqtjMGmd3bqlkruRtk0hNZ8MSeorLQel3+DA9QYcgAbOq3bgmz8xCnZ
 Cg8Zx5GP5PtJOSP9Q5ciaZlDhGCjpOVgMSmabsrDKsFZmp81PRcuGZaqWKssp2qLtCi7e3jebaR
 UZQRp6JBoAeaqe8FG22nb4Gy7eeOblNc8jn92q4yifyioVdqJ1R2HVAsCovdxwRP3SaBtTPv1aL
 n2zdh6NiFYRv+6R6PRKh1NAgf4DZSeUW3IKwvgSUfI9TFOyoTrf8=
X-Received: by 2002:a05:600c:3590:b0:451:dee4:cd08 with SMTP id
 5b1f17b1804b1-4538f883693mr153009805e9.23.1751375057307; 
 Tue, 01 Jul 2025 06:04:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH90mAniEuFaMl8XapX2vVvRNW6cht8KHUnbg+FuxKMdxRVnumLFz0GTcL334dYoI5HkQG4kA==
X-Received: by 2002:a05:600c:3590:b0:451:dee4:cd08 with SMTP id
 5b1f17b1804b1-4538f883693mr153008795e9.23.1751375056339; 
 Tue, 01 Jul 2025 06:04:16 -0700 (PDT)
Received: from ?IPV6:2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f?
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a423abbsm169354085e9.39.2025.07.01.06.04.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 06:04:15 -0700 (PDT)
Message-ID: <81cb7080-cf5e-4049-82f8-e009aac93cdc@redhat.com>
Date: Tue, 1 Jul 2025 15:04:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: include 'file' child node name in block device info
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, eblake@redhat.com,
 armbru@redhat.com
References: <20250630141421.1558724-1-f.ebner@proxmox.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250630141421.1558724-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30.06.25 16:06, Fiona Ebner wrote:
> In combination with using a throttle filter to enforce IO limits for
> a guest device, knowing the 'file' child of a block device can be
> useful. If the throttle filter is only intended for guest IO, block
> jobs should not also be limited by the throttle filter, so the
> block operations need to be done with the 'file' child of the top
> throttle node as the target. In combination with mirroring, the name
> of that child is not fixed.
>
> Another scenario is when unplugging a guest device after mirroring
> below a top throttle node, where the mirror target is added explicitly
> via blockdev-add. After mirroring, the target becomes the new 'file'
> child of the throttle node. For unplugging, both the top throttle node
> and the mirror target need to be deleted, because only implicitly
> added child nodes are deleted automatically, and the current 'file'
> child of the throttle node was explicitly added (as the mirror
> target).

Why not return a map of all children?

Hanna

> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   block/qapi.c               | 4 ++++
>   qapi/block-core.json       | 4 ++++
>   tests/qemu-iotests/184.out | 1 +
>   tests/qemu-iotests/191.out | 8 ++++++++
>   tests/qemu-iotests/273.out | 2 ++
>   5 files changed, 19 insertions(+)


