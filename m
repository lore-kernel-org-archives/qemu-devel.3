Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8A8C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 06:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weSLO-0006iK-0s; Tue, 30 Jun 2026 02:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weSLI-0006hk-5K
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 02:53:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weSLG-0002qH-JL
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 02:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782802388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HkwYmoEvjlVNeBZwRiqz4K1gsUQVKUVKDx/u9jhU9Nc=;
 b=ZwEQcjzY1546wp9j0EyO/NMzOIpvw/ovWZHZs6eI8amd5w88t8UQCmI3uP6Gm8rGu7XdhJ
 Ig8hERLm97HYPAkX6wN/L8W9jJe3a3XIs9sVQXAFJc1BTg2MUL5dm7sFV0+2t3+6CJFh/Q
 r6FWfXg3YFC//G5AW6WDHWspq0+zkTo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-099PuK03PyCHh_LqQuPf4g-1; Tue,
 30 Jun 2026 02:53:04 -0400
X-MC-Unique: 099PuK03PyCHh_LqQuPf4g-1
X-Mimecast-MFC-AGG-ID: 099PuK03PyCHh_LqQuPf4g_1782802383
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5902B1955D92; Tue, 30 Jun 2026 06:53:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D046180057F; Tue, 30 Jun 2026 06:53:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1DECD21E6920; Tue, 30 Jun 2026 08:53:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Christian <christianslima@proton.me>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] disas: converts malloc to g_malloc0
In-Reply-To: <ivgABRYgjCAvFEp6oiNyDgt4s4XO8EYr1VBiYPbuEzRH4UFDlpqPw4AgUlgFBb2AAKdw2EybEjNzoz8S4QPaJE2cUQjs48fm4BM97KPZ_IQ=@proton.me>
 (Christian's message of "Tue, 30 Jun 2026 06:02:56 +0000")
References: <20260630005249.143976-1-christianslima@proton.me>
 <87qzlor5j2.fsf@pond.sub.org>
 <ivgABRYgjCAvFEp6oiNyDgt4s4XO8EYr1VBiYPbuEzRH4UFDlpqPw4AgUlgFBb2AAKdw2EybEjNzoz8S4QPaJE2cUQjs48fm4BM97KPZ_IQ=@proton.me>
Date: Tue, 30 Jun 2026 08:53:00 +0200
Message-ID: <87zf0cplir.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Christian <christianslima@proton.me> writes:

> Hi, Markus!
>
>> Any particular reason to initialize, or is it "just in case"?
>
> It's a just in case, the next lines initialize the values. 

Suggest to mention that in the commit message, just to be perfectly
clear.

>> g_new0(struct m68k_opcode, m68k_numopcodes) would be more obviously
>> safe, because it checks the multiplication for for overflow.
>
> When I tried g_new0, but the first argument is a pointer to `struct m68k_opcode`, but it gives me an error, so I just used g_malloc0 instead. If I pass just the struct as the first argument gives me the same result as using the g_malloc0?

g_new0(T, N) allocates an array T[N].  The macro's return value is a T
*.  So, g_new0(struct m68k_opcode *, m68k_numopcodes) returns struct
m68k_opcode **, which fails type checking.  Good, because it's indeed
wrong: you want an array of T, not an array of T *.

Details at <https://docs.gtk.org/glib/func.new0.html>.

Questions?


