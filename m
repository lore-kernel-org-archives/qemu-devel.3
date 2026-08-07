Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2006C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsLBF-0001ui-Gc; Fri, 07 Aug 2026 10:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsLB9-0001tH-Oo
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 10:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsLB6-0006og-VG
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 10:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786111443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hboCjRvgjfoG+tH8rkE7D7nx7L/zzLPD6WXJAXxlz2Q=;
 b=d02R4yQAY2Te5Z1t9PGlM+yj8VRSomiLQUg00AahIYniZ28yXS9SypYHaUo4CvqqwnZrE0
 ezbx/Pcg3jMhpIFrCGYmESGfvA29AbJUwh7HCyQuT3F683FkIUnPjR0TnhrGfaoxBmj8gi
 W/9aAovyamvJI9LA8++/+wZz0XZHRuk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-pk6jyUDyOAaxn_XM5EQpow-1; Fri,
 07 Aug 2026 10:04:01 -0400
X-MC-Unique: pk6jyUDyOAaxn_XM5EQpow-1
X-Mimecast-MFC-AGG-ID: pk6jyUDyOAaxn_XM5EQpow_1786111440
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71F4A1956094; Fri,  7 Aug 2026 14:04:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2C5B19560AB; Fri,  7 Aug 2026 14:03:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A065521E6920; Fri, 07 Aug 2026 16:03:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  'Daniel P .
 =?utf-8?Q?Berrang=C3=A9'?= <berrange@redhat.com>,  Jason Wang
 <jasowang@redhat.com>
Subject: Re: [PATCH V11 06/15] monitor: track IOThread users with QOM paths
In-Reply-To: <20260806202531.243806-7-zhangckid@gmail.com> (Zhang Chen's
 message of "Fri, 7 Aug 2026 04:25:15 +0800")
References: <20260806202531.243806-1-zhangckid@gmail.com>
 <20260806202531.243806-7-zhangckid@gmail.com>
Date: Fri, 07 Aug 2026 16:03:57 +0200
Message-ID: <87mruyni2a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Acquire the shared monitor IOThread AioContext once, using the monitor
> QOM path as the holder, and reuse the stored context for later
> operations.

This describes what the patch does, but not why it is useful.

> Release the holder during global cleanup and dynamic QMP monitor
> deletion to provide an explicit acquire/release lifecycle.

This at least provides a clue: "to provide ..."

> Signed-off-by: Zhang Chen <zhangckid@gmail.com>


