Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFB2D3C922
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 15:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTM5K-0002gc-8N; Wed, 10 Dec 2025 10:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vTM5J-0002gT-Cl
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 10:26:33 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vTM5H-0004kg-FB
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 10:26:33 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1765380376; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HJUkloLmRsNfCRn6MUzT3ssK7F9hyfBdZGZ56ToYQVCYCZRDsT674kGkmqaVZjA90zpxR9G7eSmfMCalujzHNVfw7FOsGSptvcw6z3zXDJ3tfGenyHIJjVqMqQLfTkQ3QdwJpbuHJDdX4wMTokkeXtV5epqQjSS7GSOxADbvZgs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1765380376;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IVq8CGO1uuc/ONwbjokHWG/sXSQGNoXrsHG5ocfUeAQ=; 
 b=PhaeqYBN0k8LRAanrdeDnMjoDtRGpxRaDbei96ff2MRDtJN3hNs4xw0272sR5Q1NSIf/2jFKU8ZX5/8tK73sF0mG/5GAo0XIUlcfpTZpudWhCZ7DfKqtJbfLZsC/9rLcErZEAAUF9cgGa5YTIcM0kp7bd8xd72wzL7nwlyqE/9Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765380376; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=IVq8CGO1uuc/ONwbjokHWG/sXSQGNoXrsHG5ocfUeAQ=;
 b=ESqUuQg047C1IJmR0jY2W01QIQ05srqo6zQ3hB0e+Xt1hTjxe0cxJptcbnrzrm5V
 l1J1rJ+cP+xS1JOf4FmEyoOLAW1xoSTMZqv0WefkqLHeMlqlEsYNlxysJ2heNBqUhaK
 xOYOLQamr2/TIQtHREEAq9azYqj6oClKLZmbb6X0=
Received: by mx.zohomail.com with SMTPS id 176538037369410.067759934722972;
 Wed, 10 Dec 2025 07:26:13 -0800 (PST)
Message-ID: <8bb35bf8-2efe-485a-92a2-3d06dcab6b76@collabora.com>
Date: Wed, 10 Dec 2025 18:26:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu: create drm fd based on specified render node
 path
To: "Irshad, Luqmaan" <Luqmaan.Irshad@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "odaki@rsg.ci.i.u-tokyo.ac.jp" <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "luckmaan21@gmail.com" <luckmaan21@gmail.com>
References: <20251205184906.110927-1-luirshad@amd.com>
 <06bd2abd-e554-4ec8-8ffb-256d33af95c0@collabora.com>
 <SA1PR12MB94923FF5E9A4A4B8A1F902DC9DA2A@SA1PR12MB9492.namprd12.prod.outlook.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <SA1PR12MB94923FF5E9A4A4B8A1F902DC9DA2A@SA1PR12MB9492.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/9/25 21:57, Irshad, Luqmaan wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hello Dmitry,
> 
> Thats an interesting idea!  I would be curious to look into that further, however my ability to do so may be limited since my contract ends at the end of this week.
> 
> After my contract ends, I won't have access to a multi-GPU system I can test this on.  I may be able to work out some way to borrow the system, but at the moment this is uncertain.
> 
> If this patch looks good, my suggestion would be to merge this change, and we can look into adding this as a separate patch on top of this if I can get access to a system.  Let me know how this sounds 🙂
> 
> Sincerely,

Thanks for notifying that you won't work on the patch further. It will
be merged or amended.

-- 
Best regards,
Dmitry

