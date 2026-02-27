Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2E6FEFB54
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 14:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzBs-0001DE-R8; Fri, 27 Feb 2026 09:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvzBq-0001Ax-O4
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:51:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvzBp-0001EQ-4c
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 09:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772203896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Z/sfhRwgBOOgEWI414zciIKfmxd145wY1bYO0Xn6Dg=;
 b=JK/UlGy1m7AWSD+57TXCwtGWhlvzAg5f6G7sWfmW6pfgEC+LEzxza1TsIqAvjS2AkivoQd
 gzQVV2OYYr2c9sq935bEbML4Gce85FqKLOMZ3GTWCEAMqy9lgOefv9/g4Kn0okIHoptFrH
 SBPKkvlwAfLwHCFA2kfq5gytYx2fLyM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-ATHDHtvpNz6YS3pgQrKQBg-1; Fri,
 27 Feb 2026 09:51:32 -0500
X-MC-Unique: ATHDHtvpNz6YS3pgQrKQBg-1
X-Mimecast-MFC-AGG-ID: ATHDHtvpNz6YS3pgQrKQBg_1772203890
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 374751956067; Fri, 27 Feb 2026 14:51:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EA36180066F; Fri, 27 Feb 2026 14:51:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DDB6D21E6932; Fri, 27 Feb 2026 15:51:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  qemu-devel@nongnu.org,  mst@redhat.com,
 anisinha@redhat.com,  pbonzini@redhat.com,  shannon.zhaosl@gmail.com,
 philmd@linaro.org,  zhao1.liu@intel.com,  rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
In-Reply-To: <CAFEAcA_dXNiXCeYdBimBMR-hWvt6+DB1FdJ9iZ5q8zoejyRWeA@mail.gmail.com>
 (Peter Maydell's message of "Fri, 27 Feb 2026 13:14:26 +0000")
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
 <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
 <20260219131751.4e4e4e0e@imammedo> <aZ8THMubft44Q3E-@redhat.com>
 <20260226135648.4c1a4009@imammedo> <878qced4xx.fsf@pond.sub.org>
 <20260227104227.3d84f0d7@imammedo> <87ikbi9yky.fsf@pond.sub.org>
 <CAFEAcA_dXNiXCeYdBimBMR-hWvt6+DB1FdJ9iZ5q8zoejyRWeA@mail.gmail.com>
Date: Fri, 27 Feb 2026 15:51:26 +0100
Message-ID: <87qzq68ck1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 23
X-Spam_score: 2.3
X-Spam_bar: ++
X-Spam_report: (2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 27 Feb 2026 at 12:10, Markus Armbruster <armbru@redhat.com> wrote:
>> The larger problem is that we generally fail at documenting device and
>> machine properties.  I'm not asking you to boil that ocean :)
>>
>> The narrow problem is providing guidance on watchdog configuration.
>> What and where?
>>
>> Regarding where: you proposed to add a machine property of QAPI enum
>> type.
>>
>> The property can have a description, and you give it one.  Sadly, it's
>> basically invisible.  As far as I know, the only way you can get at it
>> is qom-list-properties and such.  I doubt anybody is going to read the
>> description there.
>
> I think it also will appear if you run e.g.
>  qemu-system-arm -M virt,help
>
> (which produces a list of all properties with their short descriptions)

You're right!

> For board-specific properties, we should be documenting these in
> the manual page for the board. For instance "virt" does that here:
>  https://www.qemu.org/docs/master/system/arm/virt.html#machine-specific-options

Every board should have such a page.  Even if it's just a placeholder.
Placeholders would remind us where the gaps are.

> For the global machine options, I don't think we have a place where we
> document those. If we did, we should perhaps have each board's page
> also link to the global-options page.

We should do this.


