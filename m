Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182C6C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 07:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1gif-0001iy-Q0; Mon, 07 Apr 2025 03:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1gie-0001in-AH
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1gia-0007Pm-If
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744010185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WxfIzGkE83UGyqDv/+lK2qyLA2imoN4lgwEd8j6mXho=;
 b=jN3o1R+ALn6uKKy72B1cfby2wshW/tEVonMuP1CgcFNARXo9wBS4UNuL4xcSPhyDzk+eNC
 JgFEMxm3I56TWdi/WTUovZGaTh0Ew1RVD4bJ9tsz8cDb5n1XeXB4j9xJK/UjKhpkQqQhR3
 jiv962DzVKjZm8JbJ5fWPR3ZeOtp5Qo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-sa3vzff7OcmLF3Dq5ay34w-1; Mon, 07 Apr 2025 03:16:21 -0400
X-MC-Unique: sa3vzff7OcmLF3Dq5ay34w-1
X-Mimecast-MFC-AGG-ID: sa3vzff7OcmLF3Dq5ay34w_1744010180
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43ceeaf1524so22070735e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 00:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744010180; x=1744614980;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WxfIzGkE83UGyqDv/+lK2qyLA2imoN4lgwEd8j6mXho=;
 b=hG3J3ZNFJ8thxGEtlgsskihYRNwfiLcDUmUcw0PRV3NQ8g6FhpvQuvnKS9PZxotAXu
 BV3DJZ1go5jdjOcLzEjkt3MsVF4MGCcPzpE/hmZQBnoexHmWhuXtmmlITazCWV0+xRBd
 uNeNMG7mKvpYNpUNMWdGGKWegILQ5cQJO5Et+sTg7/3uW04ZD0JZtbt3N2k9n7KbGXAU
 90dVuq49qCw2p188Z+6SVDBZImNMClAWuw9Al0pb9a8T8FZ/2XrRr1AOVJaroudNwI0U
 egg+HCAubCPad/8WF7tRt1MzQ+05EavuTOqoIImKeTA+wI/wypt1B44LN3kvP26YZE4t
 Fxhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMoFK1QhoDZB33zjBisQ5QUxv2XsJH9iBBJUxZFY43JIu+WSYFKkriBgTZPwFz/f0YlQ/5o9Senxh/@nongnu.org
X-Gm-Message-State: AOJu0YwStezq9cb0mfohmmXdw/OHOganAP5BVMX39ZccU76D0dpdtfb0
 m5kEr8cYPfOoLe2xt2kNHeYQ9hNnqtlt0G7EMKKzTVJoCf2vRpwqggcRjLTmp1VS72ByZACGgws
 7qvVKVgT8lvzrRbhs+qZzYMwyazM1n0T4V6phQm/z0Cz/DxiFlJH/
X-Gm-Gg: ASbGnctnfEdDdzaa5xmCa9lRmrtiiKaJMqZMEnj2mqZTbpal4YhAk6sbUVDbfkgG5EF
 LPqJpqY7DEzxQzv9k5eEGlJggxmY+S0jYcYp9ulWbWuhTBJuAG+14xCaMwoUOAm+NhHXd9bujW8
 cZoCmd4wrElv+InZaVuES/xWQ9SiSklbTfzavvtE8BW9r7P3t2S/jbSK9AVOy6AEWJTJnBh7qEB
 b4WI/Oa7GcOOUoHSaCjF/yLtwWENmZltbuaR/+2aEepkyJJeVVMDxJMVmBZzhjZuG3KTS61FlrD
 GoQVZGWI0p8LaiC2NBD97lk8Z7x9wKYHAXu6Be6mcjeLrEuP9KJkfA==
X-Received: by 2002:a7b:c398:0:b0:43d:5264:3cf0 with SMTP id
 5b1f17b1804b1-43ebef8f615mr124538885e9.11.1744010180336; 
 Mon, 07 Apr 2025 00:16:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWFJWlab0eYGjc4ekQGMOUoFAKiWbrgUYDf9prGaV2T4VoywBoutx6aMdy5Y8rCA+UOLs89Q==
X-Received: by 2002:a7b:c398:0:b0:43d:5264:3cf0 with SMTP id
 5b1f17b1804b1-43ebef8f615mr124538665e9.11.1744010180039; 
 Mon, 07 Apr 2025 00:16:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34a75fcsm119426715e9.11.2025.04.07.00.16.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 00:16:18 -0700 (PDT)
Message-ID: <0a06e747-5739-4cc7-908c-b12ab8d98bc8@redhat.com>
Date: Mon, 7 Apr 2025 09:16:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 v2 29/37] vfio: Rename
 vfio_devices_all_dirty_tracking_started()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-30-clg@redhat.com>
 <cbd73b82-2727-42bc-9ee6-a633dbed083d@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <cbd73b82-2727-42bc-9ee6-a633dbed083d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 4/2/25 15:10, Avihai Horon wrote:
> 
> On 26/03/2025 9:51, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Also rename vfio_devices_all_device_dirty_tracking_started() while at
>> it and use the prefix 'vfio_container_devices_' for routines simply
>> looping over the container's device list.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> 


Since lore didn't receive the email :

Reviewed-by: Avihai Horon <avihaih@nvidia.com>


Thanks,

C.



