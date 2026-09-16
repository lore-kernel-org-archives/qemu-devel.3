Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5582C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jYH-0002Vh-3T; Wed, 16 Sep 2026 02:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6jYD-0002S1-So
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 02:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6jYB-0006rk-DS
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 02:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789541722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DrxzflWO+sJDx9IQn/gmdCq+2s78ZWoL+GSaAaU5Ba4=;
 b=RCqh4GHmXKDDwSlkNZhdfmPjLijMBrZmgZd3hLTWb2muJ55Now+8rH1+xbQEpkS23xRp5H
 latznTBDGA5g6MTHzFNuVm0WLH+LWULqie8X6k+Z8YkS7DXyBwS08B1R3nexvrxO2+GGjA
 uKdjmq6JiGM208aRVCalIQOmMLgNLRM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-MvCpIx7BNXCYAitj4MX-DQ-1; Wed,
 16 Sep 2026 02:55:18 -0400
X-MC-Unique: MvCpIx7BNXCYAitj4MX-DQ-1
X-Mimecast-MFC-AGG-ID: MvCpIx7BNXCYAitj4MX-DQ_1789541717
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A525189F071; Wed, 16 Sep 2026 06:55:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 207741956095; Wed, 16 Sep 2026 06:55:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C7FE121E6A04; Wed, 16 Sep 2026 08:55:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel
 <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V17 12/13] iothread: make legacy AioContext getter
 explicitly unsafe
In-Reply-To: <CAK3tnvJa6rwyQWTYRQr3Zv7V95_PaY5Abi8_Ndwv4aw917USQw@mail.gmail.com>
 (Zhang Chen's message of "Wed, 16 Sep 2026 10:24:47 +0800")
References: <20260915101655.3216101-1-zhangckid@gmail.com>
 <20260915101655.3216101-13-zhangckid@gmail.com>
 <87bj9yrda8.fsf@pond.sub.org>
 <CAK3tnvJa6rwyQWTYRQr3Zv7V95_PaY5Abi8_Ndwv4aw917USQw@mail.gmail.com>
Date: Wed, 16 Sep 2026 08:55:14 +0200
Message-ID: <87ld91eld9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> If you have time, could you also take a look at the remaining patches
> converting IOThread users to the holder-aware API? I'd appreciate your
> feedback.

Looking at my patch review queue...  seems unlikely at this time, sorry.
I hope the maintainers of the files touched can take care of it.


