Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1250C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 11:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubdwL-0000cc-W7; Tue, 15 Jul 2025 07:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubdwJ-0000aj-TL
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 07:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubdwG-0006JQ-Cs
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 07:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752579310;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EsKaO+JXM4ANnH5YMPMvq1/OuHOpRMAwj/k61ttwst0=;
 b=LPJvCjP2oYfxalz4S3ZrxN1rny8eYtFyhZa+GBuQomIZ7P4D4n+7nSIENGb3FKTgBl2p2+
 cgj6u+4j/JGtUCzZnG7U9i+YKrEnHhc2esn6yT7tFyF6to7KAAo6Qy+6HXMv33p2+uKNai
 yTRxHr9ndHOzY1OeOL5IlixMwTQsBQQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-jXgZge-0Mk6MYNdPStv-cw-1; Tue,
 15 Jul 2025 07:35:08 -0400
X-MC-Unique: jXgZge-0Mk6MYNdPStv-cw-1
X-Mimecast-MFC-AGG-ID: jXgZge-0Mk6MYNdPStv-cw_1752579307
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5496419560B4
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 11:35:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 684A919560A7; Tue, 15 Jul 2025 11:35:05 +0000 (UTC)
Date: Tue, 15 Jul 2025 12:35:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: jsnow@redhat.com, crosa@redhat.com, qemu-devel@nongnu.org,
 mhroncok@redhat.com
Subject: Re: [PATCH v2] python: Replace asyncio.get_event_loop for Python 3.14
Message-ID: <aHY85U9W6yYuLIq3@redhat.com>
References: <20250715112846.799288-1-rjones@redhat.com>
 <20250715112846.799288-2-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250715112846.799288-2-rjones@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 15, 2025 at 12:27:52PM +0100, Richard W.M. Jones wrote:
> In Python 3.14, no asyncio event loop gets generated automatically.
> Instead create one when we need it.  This should work with Python 3.13
> as well.  This change was suggested here:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=2375004#c4
> 
> See-also: https://docs.python.org/3.14/whatsnew/3.14.html#id7
> Thanks: Miro Hrončok, Daniel P. Berrangé
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  python/qemu/qmp/legacy.py  | 5 ++++-
>  python/qemu/qmp/qmp_tui.py | 2 +-
>  python/tests/protocol.py   | 2 +-
>  3 files changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


