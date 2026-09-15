Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185F7C88E7B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6R7X-0005N1-8c; Tue, 15 Sep 2026 07:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6R7V-0005Mf-HF
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6R7T-0007cG-So
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789470874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y2FHDy233jSQ0MflIxmvlmfT4HcWxCHiBCAFzBPjrBc=;
 b=bs4yLffsbKfJeCmr9VgkXq9S8208z+Ft7Pg+V2oXJiNVUdYVfGjKGn5IcLAFxuJpaqw2Ib
 ZzF0SLH95UKwYVXH5jJ8/XNgGl3x2wwOvMCJoXdr/1a6o9Zw2RK0H9wfZpDe/DCFRqR3x0
 Jj2H/5ZUOWcZEKPJ00+xO0zZLoeYPYU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-W5NgKwZhM_6GXsCkSVB6YQ-1; Tue,
 15 Sep 2026 07:14:31 -0400
X-MC-Unique: W5NgKwZhM_6GXsCkSVB6YQ-1
X-Mimecast-MFC-AGG-ID: W5NgKwZhM_6GXsCkSVB6YQ_1789470870
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6EA21955BCE; Tue, 15 Sep 2026 11:14:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3786C1956045; Tue, 15 Sep 2026 11:14:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B7CBC21E6A04; Tue, 15 Sep 2026 13:14:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,  Fabiano Rosas
 <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH] monitor/hmp: detect signed integer overflow in
 expression evaluator
In-Reply-To: <20260915075312.50612-1-guobin@linux.alibaba.com> (Bin Guo's
 message of "Tue, 15 Sep 2026 15:53:12 +0800")
References: <20260915075312.50612-1-guobin@linux.alibaba.com>
Date: Tue, 15 Sep 2026 13:14:26 +0200
Message-ID: <87zexipy0d.fsf@pond.sub.org>
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
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Bin Guo <guobin@linux.alibaba.com> writes:

> The HMP expression evaluator performed *, +, - and unary - on int64_t
> values without checking for overflow.  A malformed expression such as
> "0x7fffffffffffffff + 1" would silently wrap around to INT64_MIN and
> could then be passed as a physical address to the "xp" command.

Isn't that a feature?

It wraps to (int64_t)0x8000000000000000, is put in the argument QDict,
passed to hmp_physical_memory_dump(), which implicitly converts to
uint64_t, then passes to memory_dump().  Such cavalier signedness
conversions are endemic in old C code like this.

The same conversions happen when you write the expression as
"0x8000000000000000" instead.

[...]


