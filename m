Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF42CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 09:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utNUe-0002pg-8M; Tue, 02 Sep 2025 05:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1utNUF-0002eP-NP
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1utNU8-0000iR-Kk
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756805965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F57UfcAJDkKh69WNz/qMCvA0UazNs90Ov/T64+Ij6tI=;
 b=KPifWjyR/XKCWjVHj1WdfBDIRVb4wjayPEZ9ea+bMOroIgokZ+Q2u2B2VVpSNUmRW7rLeI
 /1X58QM8n3eIPU0/kgMjiuU/kwCnZ+SFCDAP5bhmWXCcZCx5kr/ejQjh0KQadbKjGD7gze
 DnC2GebbSrxLLeXFhNDO3NlX6ErMUgI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-8wBkoC1eODOkVhxLtQSYYA-1; Tue,
 02 Sep 2025 05:39:20 -0400
X-MC-Unique: 8wBkoC1eODOkVhxLtQSYYA-1
X-Mimecast-MFC-AGG-ID: 8wBkoC1eODOkVhxLtQSYYA_1756805959
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F3A71800293; Tue,  2 Sep 2025 09:39:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A34CB19560AB; Tue,  2 Sep 2025 09:39:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1528821E6A27; Tue, 02 Sep 2025 11:39:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Steven Lee <steven_lee@aspeedtech.com>,  Troy
 Lee <leetroy@gmail.com>,  Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,  "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>,  "open list:All patches CC here"
 <qemu-devel@nongnu.org>,  Troy Lee <troy_lee@aspeedtech.com>
Subject: Re: [SPAM] [PATCH v1 02/21] hw/arm/ast27x0: Move SSP coprocessor
 initialization from machine to SoC leve
In-Reply-To: <SI2PR06MB5041B96A9D9B2DBA14DA07D1FC06A@SI2PR06MB5041.apcprd06.prod.outlook.com>
 (Jamin Lin's message of "Tue, 2 Sep 2025 08:49:58 +0000")
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-3-jamin_lin@aspeedtech.com>
 <555f7a62-7332-41a2-a316-e0888fbc819d@kaod.org>
 <87ms7dpb4l.fsf@pond.sub.org>
 <SI2PR06MB5041B96A9D9B2DBA14DA07D1FC06A@SI2PR06MB5041.apcprd06.prod.outlook.com>
Date: Tue, 02 Sep 2025 11:39:14 +0200
Message-ID: <87h5xlmbwd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

To: Jamin Lin <jamin_lin@aspeedtech.com>
Subject: Re: [SPAM] [PATCH v1 02/21] hw/arm/ast27x0: Move SSP coprocessor initialization from machine to SoC leve
Gcc: nnml:mail.redhat.xlst.qemu-devel
From: Markus Armbruster <armbru@redhat.com>
--text follows this line--
Jamin Lin <jamin_lin@aspeedtech.com> writes:

> Hi Markus,

[...]

>> object_property_set_link() can return false only when it fails, and it sets an
>> error when it fails.  Since you pass &error_abort, it cannot fail (it aborts
>> instead).  Therefore the return value is always true, and the return statement
>> is dead code.
>> 
>> If object_property_set_link() is not expected to fail, i.e. failure would be a
>> programming error, use
>> 
>>         object_property_set_link(..., &error_abort);
>> 
>> If failure is not a programming error, passing &error_abort is wrong, and you
>> need to pass errp instead.
>> 
>> >> +
>> >> +    if (!qdev_realize(DEVICE(&a->ssp), NULL, &error_abort)) {
>> >
>> > same here.
>> 
>
> Thanks for the detailed explanation - that clarifies the intent and the
> difference between using "error_abort" and "errp".
> Appreciate your help.
> Thanks again Jamin

You're welcome!


