Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E921E9A04E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 07:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsyUX-0000Na-KP; Thu, 19 Feb 2026 02:30:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsyUV-0000NH-C7
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 02:30:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsyUT-000131-VE
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 02:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771486225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rywLuWFroDPqSLp7woSKRTvNYIskp2lHKVja3jz+Zg8=;
 b=LrTQsRFczN3hzk4cnPlYRbAUiFbcP+D28mSdrIAr8wXhY+1WmqqXXNWU/I0q1Vo5KUmEVX
 JWQ04axRyOp7qRlrQi0rmip9AcAnnQT6yUMa5M4HdHz0nmZqZe4MG02xLb7VvU3+hdYSgh
 uTjpb/hsx6/cTzS90pbhUT+mN9qBUJo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-c81mLXl6MTG5C1pQJwdyYw-1; Thu,
 19 Feb 2026 02:30:23 -0500
X-MC-Unique: c81mLXl6MTG5C1pQJwdyYw-1
X-Mimecast-MFC-AGG-ID: c81mLXl6MTG5C1pQJwdyYw_1771486222
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64E90195609F; Thu, 19 Feb 2026 07:30:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0378E195410F; Thu, 19 Feb 2026 07:30:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 933C221E692D; Thu, 19 Feb 2026 08:30:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: John Snow <jsnow@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,  Daniel =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: CentOS 9, Python, and other Fairytales
In-Reply-To: <CANCZdfr-ab65iUD488H8BVPUfCaNP2NP8HJGcQMZi5FSLNsNJw@mail.gmail.com>
 (Warner Losh's message of "Wed, 18 Feb 2026 14:23:01 -0700")
References: <CAFn=p-YGckyEF8GCOviMJ-FfWsM_dDa6nqEBJChPmUxP7Ydi_w@mail.gmail.com>
 <87wm0afsnh.fsf@pond.sub.org>
 <56a8affc-e786-4dc8-81bd-c1f78a224afd@redhat.com>
 <CAFn=p-YqRu3eaR+RvpCi3uaq8Y7s0pGtXwOLztqMDCqYG6McPA@mail.gmail.com>
 <CABgObfaRzjaGTdXGHG=BeHFgGJaC4tt0eKOJu=L=SYWpQmm+6w@mail.gmail.com>
 <CAFn=p-ZdzRuisd6g65A+VXyDKXnTuBc0gnt0ApbhVBZG5GhJZQ@mail.gmail.com>
 <CANCZdfr-ab65iUD488H8BVPUfCaNP2NP8HJGcQMZi5FSLNsNJw@mail.gmail.com>
Date: Thu, 19 Feb 2026 08:30:19 +0100
Message-ID: <87zf555gxg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Warner Losh <imp@bsdimp.com> writes:

> When I asked a week or two ago, the FreeBSD python maintainers were busy
> upgrading, but there was too much fallout still going from 3.11 to 3.12,
> but they'd hope to work through it soon...   I didn't press them for a more
> refined version of 'soon'.

Thanks, Warner!


