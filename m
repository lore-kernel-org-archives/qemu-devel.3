Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED358FF60C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 05:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7S32-0003FU-Mo; Tue, 31 Mar 2026 01:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w7S30-0003FM-T2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 01:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w7S2w-0000Iz-Rh
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 01:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774936429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=ZZrZXl6vgDhx6eyElW1CA/vtV0wnvCqQ9EAlkjRZpt4=;
 b=BqK3Ck2FXMBujnXWrX5Uj17sORC1Ed1/8TLtItaL5/fOZxe0znczryLDRhGrkkTBjKm/UM
 kF+na+dsHrRs0mUOZofj4cc1++oTUo8Y5YUSelBDum2pVUsSnxLMm44cVANayvT0chKCZY
 oy6PBe9quO5PN0CguFgglkb29XTCadY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-EIPtMZDHMXei0EiDz0L48g-1; Tue,
 31 Mar 2026 01:53:44 -0400
X-MC-Unique: EIPtMZDHMXei0EiDz0L48g-1
X-Mimecast-MFC-AGG-ID: EIPtMZDHMXei0EiDz0L48g_1774936423
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B678180034E; Tue, 31 Mar 2026 05:53:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 723B6180035F; Tue, 31 Mar 2026 05:53:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DDBA421E6A28; Tue, 31 Mar 2026 07:53:39 +0200 (CEST)
Resent-To: stefanha@gmail.com, zhangckid@gmail.com, qemu-devel@nongnu.org,
 dave@treblig.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Tue, 31 Mar 2026 07:53:39 +0200
Resent-Message-ID: <874ilwy270.fsf@pond.sub.org>
From: Markus Armbruster <armbru@pond.sub.org>
To: Zhang Chen <zhangckid@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  Stefan Hajnoczi <stefanha@gmail.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Czenczek <hreitz@redhat.com>,  qemu-devel
 <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 04/13] blockdev: Update tracking iothread users with
 holder name
In-Reply-To: <CAK3tnvJJKUgmJQ0oV4kOX7Lppo4=90EHUUzyGiTOMZjX44fevQ@mail.gmail.com>
 (Zhang Chen's message of "Tue, 31 Mar 2026 01:43:00 +0800")
References: <20260305142459.52559-5-zhangckid@gmail.com>
 <20260309081502.GC39949@fedora>
 <CAK3tnv+HfV9JCR7whLRDcXpfp6ZAdbw1AhWzT1RSdTVevtyvBg@mail.gmail.com>
 <20260312052422.GA116604@fedora> <87bjgtxv9b.fsf@pond.sub.org>
 <CAK3tnvJc2U+c=sx=RASKHCAjcTQMx9dg0iOpe5eEui9U0-Ft_g@mail.gmail.com>
 <87jyv9fyn5.fsf@pond.sub.org>
 <CAJSP0QWnRRRATvgRtWss_hw4ygqB_bHgBuWQd3mqUcbb1q48KA@mail.gmail.com>
 <CAK3tnv+9pdVG_FzEYbux3JDHv8T1ywbwLBvA6j4xJ=ATdNtxAQ@mail.gmail.com>
 <875x6dzo50.fsf@pond.sub.org> <20260330133155.GA154632@fedora>
 <CAK3tnvJJKUgmJQ0oV4kOX7Lppo4=90EHUUzyGiTOMZjX44fevQ@mail.gmail.com>
Date: Tue, 31 Mar 2026 07:14:35 +0200
Message-ID: <87se9gy404.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
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

Zhang Chen <zhangckid@gmail.com> writes:

[...]

> By the way, It's strange that I didn't receive Markus's previous email.
> Anything I missed?

Technical problem on my side, sorry for the inconvenience.


