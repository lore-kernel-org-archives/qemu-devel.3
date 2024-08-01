Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B10AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 11:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTcV-0003vQ-TT; Thu, 01 Aug 2024 07:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZTcP-0003uE-9f
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 07:05:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZTcM-00043A-Hn
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 07:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722510309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vor81E6SV1BHftd6M2LcHtgWsFdF43Jkbgf4+3Ox3mI=;
 b=imvO6F2irY6YplTeinSqhqyjTCgSzwaica44F73Fmi6dpNcM4fW+C9h2XqLs0ef16er05b
 ibkABdJCkk1u/nrgZdPcYGpuWe4tjrQE4mgD/PlDDxfK47kNPFdGNVqyGyqQQ1LNlHNuoP
 LUgOfs9yW8+nUmPO9vLA/GT6GQDvJJg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-3H5XHWN9OBGGW99AHyQmeQ-1; Thu,
 01 Aug 2024 07:05:06 -0400
X-MC-Unique: 3H5XHWN9OBGGW99AHyQmeQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78E5B1955BEE; Thu,  1 Aug 2024 11:05:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DA4319560AE; Thu,  1 Aug 2024 11:05:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 69F3F21E668A; Thu,  1 Aug 2024 13:05:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex Williamson
 <alex.williamson@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>,  Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>,  Klaus Jensen <its@irrelevant.dk>,
 qemu-devel@nongnu.org,  qemu-block@nongnu.org
Subject: Re: [PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto
In-Reply-To: <6746a403-ce09-4dfb-bc03-d8b57aa4798b@daynix.com> (Akihiko
 Odaki's message of "Thu, 1 Aug 2024 17:39:44 +0900")
References: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
 <87a5hyj71o.fsf@pond.sub.org>
 <8ee4464e-f9b3-48bc-9fa3-0b5f0d2a5faf@daynix.com>
 <20240801035118-mutt-send-email-mst@kernel.org>
 <6746a403-ce09-4dfb-bc03-d8b57aa4798b@daynix.com>
Date: Thu, 01 Aug 2024 13:05:01 +0200
Message-ID: <877cd0fqqq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2024/08/01 16:52, Michael S. Tsirkin wrote:
>> On Thu, Aug 01, 2024 at 04:01:44PM +0900, Akihiko Odaki wrote:
>>> rom_bar_set() and and underlying visit_type_str_preserving() are ugly, but
>>> we can remove them once the deprecation period ends. On the other hand, if
>>> we don't make this change, dev->opts will keep floating around, and we will
>>> even have another use of it for "[PATCH v5 1/8] hw/pci: Do not add ROM BAR
>>> for SR-IOV VF"[1]. Eventually, having this refactoring early will result in
>>> less mess in the future.
>>>
>>> [1]: lore.kernel.org/r/20240715-sriov-v5-1-3f5539093ffc@daynix.com
>> I don't know that this should worry us much. Is there some project that
>> requires getting rid of dev->opts for some reason?
>
> No, but I just thought it is too ugly to add a new reference to it for the aforementioned patch, circumventing the visitor code and the QOM property.

Use of dev->opts is an ugly hack.  I'd love to get rid of it, if the
price is right.


