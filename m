Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D61C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 04:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4WcT-00072y-DT; Thu, 10 Sep 2026 00:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4WcQ-00072j-1l
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 00:42:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4WcO-0001kn-6h
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 00:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789015354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=16dTpAgii/gt7n4YuqHiTEifSmZ6zbNPUr5UroWv9cw=;
 b=KakCulFFptZM9npSDJrU4uXmBHAsNG6lLGrYFoGWZrUs9dgS1Yf9txyYMsO8JpqKDHuMNr
 9gl6QdoTFJonOoRke0vRTuZXGNDHhzrp8tHR70T1/PMi93w1DY24aKX6LtAl42zu+lDbFb
 x/bPq4xJ/tyip9eU7Oj4gKMvZOtPq8Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-PkZuOHRBP_SKVVriYup3DA-1; Thu,
 10 Sep 2026 00:42:30 -0400
X-MC-Unique: PkZuOHRBP_SKVVriYup3DA-1
X-Mimecast-MFC-AGG-ID: PkZuOHRBP_SKVVriYup3DA_1789015349
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6C931956054; Thu, 10 Sep 2026 04:42:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44DDC418; Thu, 10 Sep 2026 04:42:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB51121E6A04; Thu, 10 Sep 2026 06:42:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Jason Wang
 <jasowangio@gmail.com>
Subject: Re: [PATCH V15 05/14] monitor: track IOThread users with QOM paths
In-Reply-To: <CAK3tnvKo5LAR+YBsChTeS=BBpG32QsFQD=1SjL+dpuLRefLewg@mail.gmail.com>
 (Zhang Chen's message of "Thu, 10 Sep 2026 10:24:24 +0800")
References: <20260907063725.626685-1-zhangckid@gmail.com>
 <20260907063725.626685-6-zhangckid@gmail.com>
 <874ig1xmbi.fsf@pond.sub.org>
 <CAK3tnvKfeJK-p8POfzDoG2NLt=NWgKnF_WcmAWAHWXnuQdCWTw@mail.gmail.com>
 <87fqzin1wc.fsf@pond.sub.org>
 <CAK3tnvKo5LAR+YBsChTeS=BBpG32QsFQD=1SjL+dpuLRefLewg@mail.gmail.com>
Date: Thu, 10 Sep 2026 06:42:26 +0200
Message-ID: <87ld99hg3x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

Zhang Chen <zhangckid@gmail.com> writes:

> Thanks for clarifying. I'll use mon->iothread consistently for
> per-monitor checks and accesses after initialization, keeping
> monitor_requires_iothread() for the decision in monitor_complete()
> and the global mon_iothread for shared thread creation and cleanup.
>
> By the way, any comments for other patches in this series?

No, I'm done reviewing v15 :)


