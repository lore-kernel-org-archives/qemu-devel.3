Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF89C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kk8-0007J2-L1; Fri, 04 Apr 2025 13:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0kk2-0007IA-0a
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:22:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0kjw-0007bA-P3
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743787316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PN/Dbtzmj2atcQvXEb9nZfcMpTwPnZ79bXPZGNpKRMg=;
 b=Y3GH1mmHBJCQqnUVQFsjiUeTB3yCteuVIe6+tVCCXR2kxVlrZfdPJH8La0epm5aUF2TMLs
 EcBXmJ7+u+PuYzDKUJlhlfI83DIutlSxkf/ee1+JQRZxEOzWkYJkQIEBMB4VObLvtwDvIM
 Xyfok3am8skmz+6asndLKjKRUKMwCeg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-3J2DrKe-MUOMjLdvO1M64g-1; Fri, 04 Apr 2025 13:21:54 -0400
X-MC-Unique: 3J2DrKe-MUOMjLdvO1M64g-1
X-Mimecast-MFC-AGG-ID: 3J2DrKe-MUOMjLdvO1M64g_1743787313
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-391492acb59so1413997f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743787313; x=1744392113;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PN/Dbtzmj2atcQvXEb9nZfcMpTwPnZ79bXPZGNpKRMg=;
 b=PAjWSP73ZR6lvaHw0Av23x/6mt4CeqnbvSBxqViXZnpdmqCXpPMaxtQ3mJuoALSFQC
 5d1iFc2Qj6dwkaL+MykqPGgYezIBjU6Swp1VgALhZv8Y3eYAWy1Dt6g3ynH5oxZ8Fs1i
 ZxKLlbeeLQ+SYA+TwXoYyz8unUWKJ8tEP/SBZXj64piF0e1h9M22D05ZLXzF2HIfi83X
 gsvk1i6sGqQh33UmgUutw9ygZIy9Y7EuxBVvXDrmG9GLjX+kmkfFl0XUfeq5opN6uVuc
 hHioRsYrpA/tSvth9ZUf27sLgQ/PjA5ieQ6ZwXwR1lZ3aPRoOZ1okcxu8zuEx8ZaxSoX
 DbCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt7HQ+EQFdoFWKf/VhHdYj9ltOvhyAclsVnjBBmcA3VYvD89pTTvWcYU1yJAE2q+7CQurZLX0n85bT@nongnu.org
X-Gm-Message-State: AOJu0YxKvsJj02ACvYKzXCk2r5J8NzdDnlUACC5p3XRf4mpJjF3JUIhM
 R9elxrhweT+QdQM0TsmrsMblYSEjgdSNSePW2gItypqAhO4Cd5pstHZfNYAA5L21yQsfDIIVdp3
 23I+/PVTeVZ+XFTfAc8r8vYv+7a8TwqLDax7QaDmRYGYo6DrRgcOw
X-Gm-Gg: ASbGncvdGBGtrXTxP3K8Bm7AkBbVHcon4OVWj6gYfyZNlZlMpxw53O/Vo7pkXQFmAKB
 uRnlmXpU7LTawRCeXzVqT/2xerKs5OsYYWXOFr5Zhxnwh0iHI1zuJMTN+MGK9giFpEpNSOAZ5zw
 9arXjAm9tBRSAwXk8X7rKTYdfmVLKXGo16NlBT0/OZKimIHl5dWm23mp/fVV6FEgqqVqQQ0qRAA
 zLsU55EjQ7n844mnQR+U/FY8JGfQGeA3Lr2vn+mLqozJ/rmDhj25UASIQ2yV+XPKMVqC8CRwZp/
 u9irP3T2rJXfsuPhidT9Op6s1dvTFULJzdD5te/Yl/ZuEkFafBd67Q==
X-Received: by 2002:a05:6000:1a8d:b0:39c:1f10:d294 with SMTP id
 ffacd0b85a97d-39d0de28a44mr3268245f8f.26.1743787312982; 
 Fri, 04 Apr 2025 10:21:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOI6nvqE9I/U9+S5Tut41mBKTUFKiH4fWlx6u/ETewouFQYgJOcS32//CS8KBPb9EZIpWDeA==
X-Received: by 2002:a05:6000:1a8d:b0:39c:1f10:d294 with SMTP id
 ffacd0b85a97d-39d0de28a44mr3268223f8f.26.1743787312596; 
 Fri, 04 Apr 2025 10:21:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30095ea8sm4788287f8f.20.2025.04.04.10.21.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:21:52 -0700 (PDT)
Message-ID: <6917b256-cfb2-4b14-ac6e-6b8836a2174d@redhat.com>
Date: Fri, 4 Apr 2025 19:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/28] vfio-user client
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250219144858.266455-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

John,

On 2/19/25 15:48, John Levon wrote:
> This is the 8th revision of the vfio-user client implementation. The vfio-user
> protocol allows for implementing (PCI) devices in another userspace process;
> SPDK is one example, which includes a virtual NVMe implementation.
> 
> The vfio-user framework consists of 3 parts:
>   1) The VFIO user protocol specification.
>   2) A client - the VFIO device in QEMU that encapsulates VFIO messages
>      and sends them to the server.
>   3) A server - a remote process that emulates a device.
> 
> This patchset implements parts 1 and 2.
> 
> It has been tested against libvfio-user test servers as well as SPDK.
> 
> Thanks for previous reviews & comments.
> 
> Changes since v7:
> 
>   - split up pci patches for easier reviewing
>   - fixed lots of device ops error handling
>   - vfio-user code now in hw/vfio-user
>   - improved commit messages
>   - various other small cleanups

Could please resend next version on top

   https://github.com/legoater/qemu/commits/vfio-10.1

This is the branch in which I put the experimental stuff for the
current cycle. It contains today the  "spring cleanup" v2 series
I plan to send when QEMU 10.1 opens. Well, not exactly it because
I am waiting for some emails from Avihai to reach the list before
doing an update. It should be very close.

Also, could you please resend the vfio prerequisites only ? The
first 10 patches or so. It seems these could be merged soon. At
least checked for functional and performance regressions.

There are still relatively big changes in VFIO to discuss in these
patches:

   vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO
   vfio-user: implement VFIO_USER_REGION_READ/WRITE
   vfio-user: set up PCI in vfio_user_pci_realize()
   vfio-user: forward MSI-X PBA BAR accesses to server

Something for later.
  
Thanks,

C.


