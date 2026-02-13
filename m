Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D3FEF48EE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 09:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqp75-0005AM-Ep; Fri, 13 Feb 2026 04:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqp6y-00059s-Bn
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:05:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqp6v-0005FM-Ha
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770973512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f5boLmsbgxUeTGFZ+GkWG8eo4DL5J0IZbSAlWh0MsP0=;
 b=XiGNuUd8aW/07kh4IyxefBICq/X7O97wlupCoumEvgqSeTDqpw3UvUKMU1DpOG03Q2LASj
 HtaUqDazla5lmHxX6eXrgZ5zQdzyBAKpkG9lCly9nScSc+tPcTklFL1CCkcMGFwmHdq5OV
 04Kfb7s2Lrz08FG23Y2epKlIPQlbQZQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-RjekPLY5NXK9xZX93B41GQ-1; Fri, 13 Feb 2026 04:05:09 -0500
X-MC-Unique: RjekPLY5NXK9xZX93B41GQ-1
X-Mimecast-MFC-AGG-ID: RjekPLY5NXK9xZX93B41GQ_1770973509
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4803b4e3b9eso5445105e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 01:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770973509; x=1771578309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=f5boLmsbgxUeTGFZ+GkWG8eo4DL5J0IZbSAlWh0MsP0=;
 b=a6KZRD+c4/Si3HkrejQFWPCIcdS3VO7LLrz+/xK1EczhXsNneWCzcieC5op00rMgh/
 XhZ5ocBxTDHX1PUmWjrmxNXoii2qSc3itaStMK+ytlK9h080/6KSY8adkjraDa4iv4ML
 rGevAjTvLdcGgb5iCy8793U0Zhok7Tq0S6OFhVPA5wq9fNXyUoH+10R877Kyb7COPmy1
 GI1/AnQqQlW0xDYZ3JLlSzl20SW8S2njt+DhBrR5rxv7WqtjfDJKwenpRo11mQzyPPc3
 I4yYyJChEv7xY/hi9LpmX2fmuCs8YN6+TSduZCKyqRTFUAuDfuu/iGCmZMYZ+79FPk2+
 /m9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770973509; x=1771578309;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f5boLmsbgxUeTGFZ+GkWG8eo4DL5J0IZbSAlWh0MsP0=;
 b=Nwj/dOjYrEiNhGvSroirZ9aaB080Ehq3bKymFhSfSPlgktv+oMKrhfw//BZ0jBFCol
 tLFvSt2tvRfOVDwRFMmbJjtYD6yjiNgFrjVmK7u8CesDtsLCkJdJYNRNlP/uOvv8yvvY
 eti9ImC+yev9zxBfQ0a5/6IpP0QVjzJ7cxjmi2Gg4UvslAOaRb48aFVzLppdumdhVQLA
 bRES5bkza0DUIfvYEQ/B+lVKVfTAMyc0aoH81Sojqk+89BcUTS89MaFr21JcidM9AigJ
 1URRBaZWfhQGoN0LkFHS65pW6piqFvuxvnG8jpf7wsaGw2l7ZXgZrsK16VG2BgPHxBm1
 VV8Q==
X-Gm-Message-State: AOJu0YwtK3DzljAr+PFu5g3Xy0UJfE4WFWgGsUDDehGqg/RYLGrBbuLR
 dHNpdIZXnzuJYOjrb3HBhPYkbUM2xE+qxJkX1Q303JqOl9YQueifWc8xiGZSyODzo2xpFwbQa5W
 HVWdxR09CmFbp6kvqzaLo/a5uilavpKnCG4Rc/XghCIcmH5IZqvudwVTA
X-Gm-Gg: AZuq6aI8H7s9BTUcZeV9Kt3RxXCcAhKtm3BeeynNKHEiOAeyad0aBOkzIg3FmUnsO87
 pfY0sZB1eRj5t4SijeTBCU0pMiiEp8FaFqb4v/SphumIMLOadIAb7L2ge+h9ys9/BeJFMtPDVXO
 COir8UnYNZSw/I5sPdS/LGTcas0ltzdCk95Pc72Ureu/gdUKmtX4iaFTluFEPrOPYSY3uYyXUgK
 lKjY6S3FqsihEOy2FKp+Am505z10TGffnQvf9Yu/EFJb91v7ew5aoc9cSfgE9ndvfNqcMBPSqw0
 JuBP1rSJoUuVBlgQ8kS2zd8PxSZ/MsS3voN+7W5MDaXwjlYJ1whW1LQwpklNOnCAUp9KxH8Sr9T
 wcZYugr7FIvTDSFPtJw0qPSbwXRGbCCUtYj+HJ/NQP14flaOi8Jw+eCDfE1Xe
X-Received: by 2002:a05:600c:474d:b0:480:1a9a:e571 with SMTP id
 5b1f17b1804b1-48373a4d3f0mr15828025e9.22.1770973508541; 
 Fri, 13 Feb 2026 01:05:08 -0800 (PST)
X-Received: by 2002:a05:600c:474d:b0:480:1a9a:e571 with SMTP id
 5b1f17b1804b1-48373a4d3f0mr15827495e9.22.1770973508012; 
 Fri, 13 Feb 2026 01:05:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4836cd7af87sm85617655e9.1.2026.02.13.01.05.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 01:05:07 -0800 (PST)
Message-ID: <4689305f-84bb-4423-8b7a-d66e6f77f6c0@redhat.com>
Date: Fri, 13 Feb 2026 10:05:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration/cpr: Include vfio-cpr.h instead of vfio-device.h
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>
References: <20260211171532.1556719-1-clg@redhat.com>
 <aYzTTrgqWTlY76m_@x1.local>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aYzTTrgqWTlY76m_@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/11/26 20:06, Peter Xu wrote:
> On Wed, Feb 11, 2026 at 06:15:32PM +0100, Cédric Le Goater wrote:
>> The file migration/cpr.c uses vmstate_cpr_vfio_devices which is
>> declared in hw/vfio/vfio-cpr.h, not in hw/vfio/vfio-device.h.
>>
>> Replace the include with the correct header file to avoid pulling in
>> unnecessary VFIO device declarations.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   migration/cpr.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/migration/cpr.c b/migration/cpr.c
>> index adee2a919a364244867ef190fdf29bd1fe7e20e2..a0b37007f55d6dac32bd6220ffe65d32c4e6b52e 100644
>> --- a/migration/cpr.c
>> +++ b/migration/cpr.c
>> @@ -9,7 +9,7 @@
>>   #include "qemu/error-report.h"
>>   #include "qapi/error.h"
>>   #include "qemu/error-report.h"
>> -#include "hw/vfio/vfio-device.h"
>> +#include "hw/vfio/vfio-cpr.h"
>>   #include "migration/cpr.h"
>>   #include "migration/misc.h"
>>   #include "migration/options.h"
>> -- 
>> 2.53.0
>>
> 
> This should be better as a standalone change, thanks.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Some thoughts beyond this patch alone.
> 
> When looking at this, it's a layer violation.  Logically migration/cpr.c
> shouldn't include a vfio header, otherwise it means when new devices added
> to support cpr then migration needs to include headers to every single of
> these devices..
> 
> Logically it should be the other way round where migration/cpr.c should
> provide a helper allowing devices to opt-in for cpr-states to register
> instead.

with vmstate_un/register() ?
  
> Now it's also awkward that vmstate_cpr_state always have a subsection
> called vmstate_cpr_vfio_devices.. it means we will migrate this subsection
> even if there's no vfio device..  that's also another point that I think it
> should be done the other way round..
> 
> I do not know whether we must persist CPR ABI now.. if we need, we can't
> change this anymore without a machine type compat entry (as we will expect
> vmstate_cpr_vfio_devices to come from an older binary that does a cpr
> migration).  But that'll be sad..

vmstate_cpr_state was introduced in 10.0
vmstate_cpr_vfio_devices in 10.1

commit a6f2f9c42f3a ("migration: vfio cpr state hook") already
broke migration compatibility. May be this is something we can
still fix without a machine compat.

I have no idea how cpr is used today, in which product ? Can the
maintainers tell us more ?

Thanks

C.


