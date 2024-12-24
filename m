Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C8EE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6cw-000670-98; Tue, 24 Dec 2024 10:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6cu-00064p-Lw
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:15:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tQ6ct-0003vY-35
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735053314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M6VUdP95Va8KaMkFvPzKmBqHBh0Dyilq54vKex3dFdA=;
 b=VHJMN+E6Js8vlORI2hSYzUAdUuhbmF2WKnkb0J5rq9WZe2oW4dFMNkG5rp7eHuRQ1z+WDJ
 3UWX+jmc+IEgCVDe8w85ECGj3wkWKZHzszfgkCQy5p1mWcWam3m7Bua8kOQcmH2nhfDszm
 EV6PSI2s+1qSZqlWk3hIkc5QDWHMRiI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-4-x_LsmMOF6s4d5hkNrScw-1; Tue, 24 Dec 2024 10:15:11 -0500
X-MC-Unique: 4-x_LsmMOF6s4d5hkNrScw-1
X-Mimecast-MFC-AGG-ID: 4-x_LsmMOF6s4d5hkNrScw
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-46790c5b1a5so129467851cf.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 07:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735053311; x=1735658111;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6VUdP95Va8KaMkFvPzKmBqHBh0Dyilq54vKex3dFdA=;
 b=sq1YJ/FBdmpO54JuC80FQb3cED5qxqrn5qxq+hNWLWw2GrnuSsfNtSKcXlJiP5PCJ+
 1Qh+PoD6REgk9KvkHa3cmI75IFD26ANBf8bOsHVpJx4/J+AfUAoeWzkYpCqKAHknKpnq
 xxzOMCoWZYS96BcHC2+vGYzD59dXiUr+4wv5t9WHQhtQiIuhMZlAsKmPSyKd/RvaDHUA
 k8gXqQtz/+pqpghWByxkMV3FwQXucvv68haxFIbo0E3d5OtitYEuIhnXYFFhDkuxNAQN
 KIHmaEs3ZwiHpCykmnLF6ji37RuP01+qDnN7p+Q5C3ro6q7YxkCIlLC5nLWeC3UMgK1P
 otgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfCZ9M07UP7RsnPs11R0wczLVeU1FBfa7e78izb5UFdhsqMF+fZQVO8QTxmnBWq2Q/CyEPOYsRXs1W@nongnu.org
X-Gm-Message-State: AOJu0Yw22zl3Cdo8LtvntkM0mdTslvsaqaGHLgpPAcZE6GaatI5tMo2C
 U73L2MQOMBEq4VNSK8w4e+tEB9HHBYOEWcWP7ePPavP5ZgG5sOo0xHa3DvK1UUBRX3GMDDdcxqO
 O9uv+93eQRocDz97vPb5Ni3uIRf0H4IXOV8ZAawglH5tZI1pcMXIF
X-Gm-Gg: ASbGncvIvD5ekuP9h6t67l9XW9dyHKh9K6PqyV488cq2s+OZeWIORNrnr+Uy1fMl1bD
 Dioky+dey3e+ahCikXDm+ZNBnxJ1yOgO7mKvB4BObrUHfCrjeGUl8Xp3dkbAjex/VRCbKuPymu3
 6shELAqiSccML/A39M7rm+A8z43DGa/phR+UBYw1wshM0S+9kH+t288/7sdaYolKkbxr1FjaAbu
 Ggj8LAJxVXKa2hFLQg+3v/93jRyhKMGsquGc6MuLvihoubQBjIc+rEJuOxSDRTPY5gFutAT2r4n
 0uw5o+sGSQzxYphn
X-Received: by 2002:a05:620a:26a1:b0:7b1:19f4:c6e0 with SMTP id
 af79cd13be357-7b9ba850570mr2821575485a.51.1735053310972; 
 Tue, 24 Dec 2024 07:15:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFo+Qur1D6LTZLXrc+RcNHuDgw4UJ5ZN50K16gyyhH+j2v1HemMFEIyk6QHtp+WJAZcQuELgQ==
X-Received: by 2002:a05:620a:26a1:b0:7b1:19f4:c6e0 with SMTP id
 af79cd13be357-7b9ba850570mr2821570985a.51.1735053310560; 
 Tue, 24 Dec 2024 07:15:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2d0df8sm476289385a.28.2024.12.24.07.15.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 07:15:10 -0800 (PST)
Message-ID: <9868a48a-feb2-4ff0-a98f-373608d98720@redhat.com>
Date: Tue, 24 Dec 2024 16:15:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] migration: Drop/unexport migration_is_device() and
 migration_is_active()
To: Peter Xu <peterx@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Hyman Huang <yong.huang@smartx.com>,
 Joao Martins <joao.m.martins@oracle.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20241218134022.21264-1-avihaih@nvidia.com>
 <7e89a423-14ef-4b6e-b1ae-9b2e6e947a38@redhat.com> <Z2rPRxla5iBczNm4@x1n>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <Z2rPRxla5iBczNm4@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 12/24/24 16:12, Peter Xu wrote:
> On Tue, Dec 24, 2024 at 09:20:08AM +0100, Cédric Le Goater wrote:
>> Fabiano, Peter,
>>
>> On 12/18/24 14:40, Avihai Horon wrote:
>>> Hello,
>>>
>>> This follows up on Peter's series [1] to simplify migration status API
>>> to a single migration_is_running() function.
>>>
>>> Peter's series tried to drop migration_is_device() and
>>> migration_is_active(), however VFIO used them to check if dirty page
>>> tracking has been started in order to avoid errors in log sync, so they
>>> couldn't simply be dropped without some preliminary cleanups.
>>>
>>> This series handles these preliminary cleanups and eventually drops
>>> migration_is_device() and unexports migration_is_active().
>>>
>>> The series has been migration tested with the following:
>>> - VFIO device dirty tracking.
>>> - Legacy VFIO iommu dirty tracking.
>>> - vIOMMU + Legacy VFIO iommu dirty tracking (migration with vIOMMU is
>>>     currently blocked, so I used a patched QEMU to allow it).
>>>
>>> I also tested calc-dirty-rate as now VFIO dirty pages should be included
>>> in its report, and indeed they are.
>>>
>>> I didn't test it with iommu DPT as I don't have access to such HW.
>>> It would be great if someone with the proper HW could test it.
>>>
>>> Patch structure:
>>> 1-4: Refactor and clean up VFIO dirty page tracking helpers.
>>> 5: Refactor dirty limit code.
>>> 6-7: Drop/unexport migration_is_device() and migration_is_running().
>>
>> I can take these migration changes through the VFIO queue.
>> Is that ok for you ?
> 
> Fabiano is collecting things for this cycle, but just in case he's in the
> middle of a party - yes please, thanks!
> 

Sending the PR then !

Thanks,

C.




