Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3636CF53D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2CG9-0004H8-Lz; Mon, 16 Mar 2026 14:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2CFK-00046a-5K
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2CFF-00074w-P5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773684046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ETbYlLdLt5X7B5dkFLARaHKJPerUjDbSPxxlEOs9awU=;
 b=Qe/s/IpwS4HGNrLygIjWDjJ9Chqgcj2X94muCvXdSCO20Pbou+0qRcbms3UxQIAjbXlZDK
 HvN1IzGOV/7YpyBXe6wCqNK/Z4Qlc29cApjvFU/c1vfLO7LswMfSYB5tSLBFTG8BBI2olP
 MqWJmZLbE4t+Zpom9p+euE6O4QkzYFg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-64LAyekCMA-pOfwHzZgwIQ-1; Mon,
 16 Mar 2026 14:00:42 -0400
X-MC-Unique: 64LAyekCMA-pOfwHzZgwIQ-1
X-Mimecast-MFC-AGG-ID: 64LAyekCMA-pOfwHzZgwIQ_1773684040
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A09B919560A7; Mon, 16 Mar 2026 18:00:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A073230001A2; Mon, 16 Mar 2026 18:00:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0840C21E6937; Mon, 16 Mar 2026 19:00:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Markus Armbruster <armbru@redhat.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Thomas
 Huth <thuth@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Mark Cave-Ayland
 <mark.caveayland@nutanix.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Zide Chen <zide.chen@intel.com>,  Dapeng
 Mi <dapeng1.mi@linux.intel.com>,  qemu-devel@nongnu.org,
 devel@lists.libvirt.org,  Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track
 external user input
In-Reply-To: <96b88815-b01a-8d9c-0400-5d881bc9e6c0@eik.bme.hu> (BALATON
 Zoltan's message of "Mon, 16 Mar 2026 17:05:15 +0100 (CET)")
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <877bricy97.fsf@pond.sub.org> <abFqwbCCf7rNDEWs@redhat.com>
 <87tsufpyo5.fsf@pond.sub.org>
 <96b88815-b01a-8d9c-0400-5d881bc9e6c0@eik.bme.hu>
Date: Mon, 16 Mar 2026 19:00:35 +0100
Message-ID: <87341zpscc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Mon, 16 Mar 2026, Markus Armbruster wrote:
>>> More generally anything we can do to bring qdev & qom closer together
>>> feels desirable. I dream of a future where -device/device_add are
>>> obsolete....
>>
>> That would be lovely.
>
> How would normal people add devices from the command line then? Do you expect us to use -object or something like that with JSON instead? That's very impractical so some command line UI should remain.

-object and HMP object-add support key=value,... syntax.

I don't want to get rid of the command line.  It's good for doing simple
things, and many things should be (made) simple.

> Also is it practical to force people to learn some QEMU specific language to be able to write device models? Otherwise what advantage this gives over doing it in C? I think these are questions to answer before getting into the design.

That boat sailed long ago.

I wasn't a fan of QAPI when it was added to QEMU.  But it has become an
integral part, with tentacles almost everywhere.  Moreover, what's worse
than a less than ideal way to define an interface?  Two less than ideal
ways: QAPI and QOM.

People already have to learn basic QAPI to do lots of things in QEMU,
including device models once they have complex properties.

QAPI basics are easy enough to pick up: find something similar and
imitate.  I doubt it's any harder than learning the C interfaces for
QOM.  It is harder to screw up than in C.


