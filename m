Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFC0C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 09:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt1F7-0002QV-PT; Fri, 14 Mar 2025 05:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt1F5-0002Pu-7B
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 05:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tt1F2-0004Ix-45
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 05:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741944125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eK/XlSO6+t6QHTBTE9W1EpezGenuPWsZVQTmhGSZrSc=;
 b=HD+PxRF3mmdPKwWWAcOj4VrKFrn1emf4aCzOU/1vNGFsg5hsVn9TM4b4BFSvegjdbzjkC2
 ZIzvlFS+bAw/7Yhqs1A+UV75abzKMl11YY2MiBDzO7sDlSrbZ0BrFVB0NvTv4ghNGQfI/Y
 lVZRMYvBzLttiP2lPd11o6Bn+N6fieo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-G5LD245ZNFWAhI7CotwyQQ-1; Fri,
 14 Mar 2025 05:22:01 -0400
X-MC-Unique: G5LD245ZNFWAhI7CotwyQQ-1
X-Mimecast-MFC-AGG-ID: G5LD245ZNFWAhI7CotwyQQ_1741944120
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7EE4180025E; Fri, 14 Mar 2025 09:21:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5271D18001E9; Fri, 14 Mar 2025 09:21:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 90EA221E675F; Fri, 14 Mar 2025 10:21:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Konstantin Kostiuk <kkostiuk@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 00/11] docs/qapi: enable new guest-agent and
 storage-daemon docs
In-Reply-To: <20250313044312.189276-1-jsnow@redhat.com> (John Snow's message
 of "Thu, 13 Mar 2025 00:43:01 -0400")
References: <20250313044312.189276-1-jsnow@redhat.com>
Date: Fri, 14 Mar 2025 10:21:54 +0100
Message-ID: <87a59ormq5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

John Snow <jsnow@redhat.com> writes:

> Add namespaces, turn on QGA and QSD.

I'm queuing this as is, with typo fixes in one commit message.

There's some followup work:

* You wanted to think some more on reference resolution.  In particular

    (With maybe a bug or two for trying to find module names in some
    circumstances. Will have to check that over...)

* I had a hard time understanding the reference resolution algorithm
  from the commit message.  Whether the code is sufficiently obvious I
  can't say, because I didn't look closely.  We might want more
  comments.  Not today.  The user documentation on reference resolution
  in qapi-domain.rst looks sufficient.

* I have questions on the QAPI index.  They may or may not lead to
  followup work.

* During review, we realized that the introduction sections of the three
  reference manuals (QMP, QSD, QGA) need work.  Not this series' fault.
  I'll see what I can do.

Thanks!


