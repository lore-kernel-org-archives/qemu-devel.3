Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED66B606A325
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y+DNVldL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQLrm-00047e-JD; Mon, 09 Nov 2026 04:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xQLrb-0003zk-Kv
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:40:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xQLrY-0006AU-9O
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 04:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794217225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bvkY+oSbzmW/y3ojHMGOwF6g+pk1S9NIAvBlNLL/RMw=;
 b=Y+DNVldLA26HFUOHvxsioCfwMZ5LnHnlZBI4MpYtDSldU7N/Wt1GyhwILag/xuuTZ0mBN5
 LB19kJnp/XM3Xb2OWvuc3YuBfe4eurqAIDIMKP6mPU2IWl7GuMUsYZWGQOmVvLNu4ha9oA
 PBHgcfQzKkmBc54eZaKmqb5UH4QEX54=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-lIcPECdYPdm-z1Br_QZ1vg-1; Mon,
 09 Nov 2026 04:40:23 -0500
X-MC-Unique: lIcPECdYPdm-z1Br_QZ1vg-1
X-Mimecast-MFC-AGG-ID: lIcPECdYPdm-z1Br_QZ1vg_1794217222
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 100CC180055F; Mon,  9 Nov 2026 09:40:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52AF31800480; Mon,  9 Nov 2026 09:40:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1074821E6A04; Mon, 09 Nov 2026 10:40:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com,
 milesg@linux.ibm.com,  qemu-ppc@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH 2/8] hw/gpio/pca9554: Move most code from .h to .c
In-Reply-To: <792a4d16-8318-4a06-b5b6-0122dbf4d19d@nutanix.com> (Mark
 Cave-Ayland's message of "Mon, 9 Nov 2026 08:55:14 +0000")
References: <20261106110440.3552588-1-armbru@redhat.com>
 <20261106110440.3552588-3-armbru@redhat.com>
 <792a4d16-8318-4a06-b5b6-0122dbf4d19d@nutanix.com>
Date: Mon, 09 Nov 2026 10:40:19 +0100
Message-ID: <878q32737g.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:

> On 06/11/2026 11:04, Markus Armbruster wrote:
>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   include/hw/gpio/pca9554.h | 25 -------------------------
>>   hw/gpio/pca9554.c         | 24 ++++++++++++++++++++++++
>>   2 files changed, 24 insertions(+), 25 deletions(-)
>> diff --git a/include/hw/gpio/pca9554.h b/include/hw/gpio/pca9554.h
>> index ac835371aa..1b33a8a752 100644
>> --- a/include/hw/gpio/pca9554.h
>> +++ b/include/hw/gpio/pca9554.h
>> @@ -8,32 +8,7 @@
>>   #ifndef PCA9554_H
>>   #define PCA9554_H
>>   -#include "hw/i2c/i2c.h"
>> -#include "qom/object.h"
>> -
>>   #define TYPE_PCA9554 "pca9554"
>>   #define TYPE_PCA9536 "pca9536"
>> -typedef struct PCA9554State PCA9554State;
>> -DECLARE_INSTANCE_CHECKER(PCA9554State, PCA9554,
>> -                         TYPE_PCA9554)
>> -
>> -#define PCA9554_NR_REGS 4
>> -#define PCA9554_PIN_COUNT 8
>> -#define PCA9536_PIN_COUNT 4
>> -
>> -struct PCA9554State {
>> -    /*< private >*/
>> -    I2CSlave i2c;
>> -    /*< public >*/
>> -
>> -    uint8_t len;
>> -    uint8_t pointer;
>> -
>> -    uint8_t regs[PCA9554_NR_REGS];
>> -    qemu_irq gpio_out[PCA9554_PIN_COUNT];
>> -    uint8_t ext_state[PCA9554_PIN_COUNT];
>> -    char *description; /* For debugging purpose only */
>> -    bool hw_dir; /* Honor pin direction */
>> -};
>>     #endif
>
> Is there anything left in pca9554.h at this point?

Same as pca9552.h: just the #define TYPE_...  Visible above if you
squint :)

[...]

> Otherwise:
>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Thank you!


