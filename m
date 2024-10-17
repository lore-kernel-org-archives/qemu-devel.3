Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4C4D2F7EF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 06:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1JtZ-0005T5-7Q; Thu, 17 Oct 2024 02:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1JtW-0005SR-NJ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1JtU-00063l-Kl
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 02:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729146114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=giqjdkpUbPLz91ABl/6Kih7DnOcYraZ4JaS5w4cdBMM=;
 b=OeUcYdR6JEeHDGIvNgpxYFbrz4Uu3yiZzAyq0zpcN6F6oVoLG69i13vj6mR028HG4WRE7X
 IE+rtZmMINJw2fP/Mwc9nY2Us1Oh8XCd5+iCHXXbv31msmXxWilh+R65H9QKhKYm6/DWVw
 rZ0U11H6Gyu85ep9kkY0K84AyHZ7dLc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-bdwlg5CvMpGCtHM09ECGkQ-1; Thu,
 17 Oct 2024 02:21:50 -0400
X-MC-Unique: bdwlg5CvMpGCtHM09ECGkQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 605AD19560AE; Thu, 17 Oct 2024 06:21:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 821D019560AE; Thu, 17 Oct 2024 06:21:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 45A5A21E6A28; Thu, 17 Oct 2024 08:21:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  xieyongji@bytedance.com,  kwolf@redhat.com,
 hreitz@redhat.com,  Coiby.Xu@gmail.com,  pbonzini@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,
 mark.cave-ayland@ilande.co.uk,  michael.roth@amd.com,
 kkostiuk@redhat.com,  qemu-block@nongnu.org
Subject: Re: [PATCH v2 6/7] hw/intc/openpic: Improve errors for out of
 bounds property values
In-Reply-To: <db943e63-4968-4cb6-885b-3cd479ba8962@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 10 Oct 2024 14:40:28
 -0300")
References: <20241010150144.986655-1-armbru@redhat.com>
 <20241010150144.986655-7-armbru@redhat.com>
 <db943e63-4968-4cb6-885b-3cd479ba8962@linaro.org>
Date: Thu, 17 Oct 2024 08:21:44 +0200
Message-ID: <87bjzj6yh3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 10/10/24 12:01, Markus Armbruster wrote:
>> The error message doesn't matter much, as the "openpic" device isn't
>> user-creatable.  But it's the last use of
>> QERR_PROPERTY_VALUE_OUT_OF_RANGE, which has to go.  Change the message
>> just like the previous commit did for x86 CPUs.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   hw/intc/openpic.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
>> index 32bd880dfa..cd3d87768e 100644
>> --- a/hw/intc/openpic.c
>> +++ b/hw/intc/openpic.c
>> @@ -41,7 +41,6 @@
>>  #include "hw/pci/msi.h"
>>  #include "qapi/error.h"
>>  #include "qemu/bitops.h"
>> -#include "qapi/qmp/qerror.h"
>>  #include "qemu/module.h"
>>  #include "qemu/timer.h"
>>  #include "qemu/error-report.h"
>> @@ -1535,9 +1534,7 @@ static void openpic_realize(DeviceState *dev, Erro=
r **errp)
>>      };
>>
>>      if (opp->nb_cpus > MAX_CPU) {
>> -        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
>> -                   TYPE_OPENPIC, "nb_cpus", (uint64_t)opp->nb_cpus,
>> -                   (uint64_t)0, (uint64_t)MAX_CPU);
>> +        error_setg(errp, "property 'nb_cpus' can be at most %d", MAX_CP=
U);
>>          return;
>>      }
>>=20=20=20
>
> As another cleanup we could convert MAX_CPU to unsigned.

Existing uses are all fine as is.  Perhaps the maintainer has a
preference.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks!


