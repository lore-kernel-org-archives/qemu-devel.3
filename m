Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7A0D4A613
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgfWb-0005JF-Da; Fri, 16 Jan 2026 03:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgfWY-0005Iz-EX
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:49:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vgfWX-0006kO-53
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768553380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uR1AgGgjMArvKgtYLxN2w/wO3Fdiw9TqKqnPdY4UlD8=;
 b=WDYkmEI9TOmqdRkWYENiWnMvhOZcfXSggGyyxE68yR8m3ITJDYpInjy5kOi03HYRJ7+68C
 6IYtFUu/XopQ93szZdO8vKcQXm64rEqd9YwAVVVQWrVp5ArKYd16kYDMzAsaZPoutg2fxy
 D0u57PYCJd0O6eZ/mVcdkE4qeX3ZsSE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-3LPg6RbgOaeFEkkD9h0eNw-1; Fri,
 16 Jan 2026 03:49:36 -0500
X-MC-Unique: 3LPg6RbgOaeFEkkD9h0eNw-1
X-Mimecast-MFC-AGG-ID: 3LPg6RbgOaeFEkkD9h0eNw_1768553375
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03AD41956095; Fri, 16 Jan 2026 08:49:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0996195419D; Fri, 16 Jan 2026 08:49:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 457B121E692D; Fri, 16 Jan 2026 09:49:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juraj Marcin <jmarcin@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 1/2] migration: Remove zero-blocks capability
In-Reply-To: <20260115225503.3083355-2-peterx@redhat.com> (Peter Xu's message
 of "Thu, 15 Jan 2026 17:55:02 -0500")
References: <20260115225503.3083355-1-peterx@redhat.com>
 <20260115225503.3083355-2-peterx@redhat.com>
Date: Fri, 16 Jan 2026 09:49:32 +0100
Message-ID: <87jyxirlgj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> It was declared deprecated since 9.2.
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


