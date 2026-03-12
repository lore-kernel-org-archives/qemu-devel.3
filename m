Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC59FED2F3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 09:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0cEB-0008VE-50; Thu, 12 Mar 2026 05:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w0cE5-0008R4-Q5
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:21:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w0cE4-0002pT-4E
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773307263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zESzfcBl25WWrCWr9Oi6ybD+oE2mIobPfzu8j5WOx1M=;
 b=ijIWSj0N7S0nvo83o20v2XPm183bHnCbFJpvwo3Ii2YuOGh2EghH9VGWIY2vRiJwPa7IaO
 IsNthW6ValE2IxHv2scjXV7rUHPaDf2K/8u88ZIBH0SKG1yMf+NipdRQca7Lh4lDlHZieQ
 ovmAuQEC7INSztbGqUsnnK7Fe0nbU1A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-75MCgWCjMS--IRpfj92CyA-1; Thu,
 12 Mar 2026 05:21:02 -0400
X-MC-Unique: 75MCgWCjMS--IRpfj92CyA-1
X-Mimecast-MFC-AGG-ID: 75MCgWCjMS--IRpfj92CyA_1773307260
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20F9C195608D; Thu, 12 Mar 2026 09:21:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DE8B19560B7; Thu, 12 Mar 2026 09:20:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AFDAB21E681E; Thu, 12 Mar 2026 10:20:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Nathan Chen <nathanc@nvidia.com>,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  Yi Liu <yi.l.liu@intel.com>,  Zhenzhong Duan
 <zhenzhong.duan@intel.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel
 =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>,  Alex Williamson
 <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [RFC PATCH 2/8] hw/arm/smmuv3-accel: Introduce _AUTO support
 for ATS
In-Reply-To: <fbf594fe-dc8d-4747-94e7-7398749f03ef@redhat.com> (Eric Auger's
 message of "Thu, 12 Mar 2026 09:51:45 +0100")
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-3-nathanc@nvidia.com>
 <87pl5cnp06.fsf@pond.sub.org>
 <98e7dd71-6669-4a82-bec8-f1dae2d861c3@redhat.com>
 <0bdcf7d7-136e-42f4-9fa9-d31f6ae6e19f@nvidia.com>
 <fd34b7a2-65ac-486f-bc17-23dd4f96a3df@redhat.com>
 <87o6ktxwzn.fsf@pond.sub.org>
 <fbf594fe-dc8d-4747-94e7-7398749f03ef@redhat.com>
Date: Thu, 12 Mar 2026 10:20:56 +0100
Message-ID: <87y0jxwghz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Eric Auger <eric.auger@redhat.com> writes:

> On 3/12/26 9:39 AM, Markus Armbruster wrote:

[...]

>> We promise to follow a certain process when changing external
>> interfaces: docs/about/deprecated.rst.
>>
>> This is why I inquired about external access.  No external access, no
>> compatibility worries.
>>
>> I specifically asked about JSON, because going from bool to OnOffAuto is
>> mostly compatible in key=value syntax: values "on" and "off" keep
>> working.
>>
>> Mostly compatible, because qapi_bool_parse() also recognizes "yes",
>> "true", "y", "no", "false", and "n" for convenience, and these stop
>> working.  We have a knack for inventing convenience features that later
>> bite us.
>>
>> JSON breaks entirely, of course: all values stop working.
>>
>> Even with external access, compatibility worries start only after we
>> shipped the interface in a release.  Did we?
> those options were introduced in qemu 11.0. Fixing them in -rc is still
> an option but it is a very tight schedule

If it turns out to be too tight, rever them or declare them
experimental?  Then you can revise them without process hassle in the
next release.

[...]


