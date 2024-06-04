Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F68EC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQJJ-0007aa-So; Tue, 04 Jun 2024 05:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sEQJI-0007aI-Ct
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:18:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sEQJG-00046l-MQ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717492705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KJxLCaBaIuRGcA0TH+Rg+hOm7JhuMGzVkNLWQKfNTtc=;
 b=BIwjng8Iu2B8fG+E9TD2jePoFx7Op+mkKNwke9Y4eyzd5Lw4R85mMeRPui94LwZBcaf3RE
 DVA0upQYnW7I0QgG/nK0BFBO7UcmRkXdjpdKnl2UbFRD8dIsr2jk37HbM+7yx1fjKyezCG
 Rax6AL2SjvBXBk0ow7ic9Fnm/TCd2I0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-fZA_7lFZOYKinfcPFuq64Q-1; Tue,
 04 Jun 2024 05:18:21 -0400
X-MC-Unique: fZA_7lFZOYKinfcPFuq64Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6074E3C025CE;
 Tue,  4 Jun 2024 09:18:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5591A4D6D;
 Tue,  4 Jun 2024 09:18:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 61B0321E668A; Tue,  4 Jun 2024 11:18:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: fan <nifan.cxl@gmail.com>,  <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>,  <gregory.price@memverge.com>,
 <ira.weiny@intel.com>,  <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>,  <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>,  <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>,  <wj28.lee@gmail.com>,  Fan Ni
 <fan.ni@samsung.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
In-Reply-To: <20240501155812.00002ec3@Huawei.com> (Jonathan Cameron's message
 of "Wed, 1 May 2024 15:58:12 +0100")
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-10-fan.ni@samsung.com>
 <877cgkxzal.fsf@pond.sub.org> <Zivk37xBGPsL_yo5@debian>
 <87h6fkob0t.fsf@pond.sub.org> <ZjEnwPeoivsW8y5Z@debian>
 <20240501155812.00002ec3@Huawei.com>
Date: Tue, 04 Jun 2024 11:18:18 +0200
Message-ID: <87cyox9icl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I finally got around to read this slowly.  Thank you, Fan and Jonathan!

I'm getting some "incomplete" vibes: "if we ever implement", "patches
for this on list", "we aren't emulating this yet at all", and ...

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

[...]

> Only thing I'd add is that for now (because we don't need it for testing
> the kernel flows) is that this does not provide any way for external
> agents (e.g. our 'fabric manager' to find out what the state is - i.e.
> if the extents have been accepted by the host etc). That stuff is all
> defined by the spec, but not yet in the QMP interface.  At somepoint
> we may want to add that as a state query type interface.

... this, too.

In review of v5, I asked whether this interface needs to be stable.

"Not stable" doesn't mean we change an interface without thought.  It
merely means we can change it much, much faster, and with much less
overhead.

I understand you want it chiefly for CXL development.  Development aids
commonly don't need to be stable.

If you're aiming for stable, you need to convince us the interface can
support the foreseeable purposes without incompatible changes.  In
particular, I'd like to see how you intend to support "finding out what
the state is".  I suspect that's related to my question in review of v8:
how to detect completion, and maybe track progress.

There's infrastructure for background jobs: job.json.  We might be
better off using it, unless completion is trivial and progress tracking
unnecessary.

[...]


