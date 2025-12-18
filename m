Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58C1D6D232
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 15:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWGPg-0006Wx-8Z; Thu, 18 Dec 2025 10:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWGPZ-0006Wb-4k
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:59:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vWGPX-0007z7-QL
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766073566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FErgdqg0Owcl+68IiMdBX3370S0DESPSKsYk+qF5iLM=;
 b=R2ciWmNrMHzgcbuiWdl1XwJe2SvkorxO/9/1KOLUR7P90W5g7nPndOobzC7WvDXB2eOFMz
 1XykpqkZ5NajlALS1DRidWALhIL8A6cRuj+KS+RQiN09DKrKT5SoozphA+wWxvNUfy8Yfm
 P7p0+/sFFlQfzcOUnNu2OrbBfvbsAEw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-m70ZaGMIOL-DMHb7eywSVg-1; Thu,
 18 Dec 2025 10:59:23 -0500
X-MC-Unique: m70ZaGMIOL-DMHb7eywSVg-1
X-Mimecast-MFC-AGG-ID: m70ZaGMIOL-DMHb7eywSVg_1766073561
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC6FA1955DC5; Thu, 18 Dec 2025 15:59:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19A1B1956056; Thu, 18 Dec 2025 15:59:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A380F21E6A27; Thu, 18 Dec 2025 16:59:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,  <ira.weiny@intel.com>,
 <alucerop@amd.com>,  <a.manzanares@samsung.com>,
 <dongjoo.seo1@samsung.com>,  <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>,  <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 3/5] hw/cxl: Allow BI by default in Window restrictions
In-Reply-To: <20251218154832.00000159@huawei.com> (Jonathan Cameron's message
 of "Thu, 18 Dec 2025 15:48:32 +0000")
References: <20251103195209.1319917-1-dave@stgolabs.net>
 <20251103195209.1319917-4-dave@stgolabs.net>
 <87wm2ki1wm.fsf@pond.sub.org> <20251218154832.00000159@huawei.com>
Date: Thu, 18 Dec 2025 16:59:17 +0100
Message-ID: <873457aii2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Jonathan Cameron <jonathan.cameron@huawei.com> writes:

> On Thu, 18 Dec 2025 10:18:17 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Davidlohr Bueso <dave@stgolabs.net> writes:
>> 
>> > Update the CFMW restrictions to also permit Back-Invalidate
>> > flows by default, which is aligned with the no-restrictions
>> > policy.
>> >
>> > While at it, document the 'restrictions=' option.  
>> 
>> I'd split the patch.  Up to you.
> Hi Markus,
>
> As you note below the interface hasn't been in any release anyway and
> is part of the long backlog I'm carrying and slowly getting
> upstream. Bringing this in from the start with that restrictions
> control should be fine.
>
> However, backwards compatibility does need addressing
> as this changes the default for things we do create today (with
> no restrictions).
>
> In this particular case, I don't think we care because there are no
> BI capable devices before this series - so there can't be anything
> using this feature for the host memory range it describes.
>
> As such, the only result is the ACPI table says we have an extra
> flag set which no one will care about.  Will need to update
> the ACPI table tests though. I'll check.
>
> Migration of CXL topologies is horribly broken currently anyway
> so that's not a problem here. Given current usecases are strictly
> software stack verification fixing that isn't a priority (yet).

Good to know.  Work into commit message(s)?


