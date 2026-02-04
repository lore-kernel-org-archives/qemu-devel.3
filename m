Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA28E95399
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 12:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncNi-0001le-70; Wed, 04 Feb 2026 07:53:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vncNg-0001l8-KY
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 07:53:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vncNf-000461-BU
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 07:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770209593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EKAJ6dayu+Gy2/vZKleuyObDkFVtj63oP93ypgZDX8M=;
 b=ikfIuJXGdKrbztTFHZ76clmGbQmYKbd0pA45ivGPwHNAZAEOege6TMpcr1Zz1lK8DR+tRE
 fTOET+JG+DysZXtOtJ8a3gTkCB+l5A0yIfSJh0S14KSDEBG0NCz3jAjcm3nv5w/m6x0IGb
 h7ejWoSe/0yQ7o4e7vaFae/2s61H68I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-AGf2kyegOf-Jb5hrB_TZpw-1; Wed,
 04 Feb 2026 07:53:10 -0500
X-MC-Unique: AGf2kyegOf-Jb5hrB_TZpw-1
X-Mimecast-MFC-AGG-ID: AGf2kyegOf-Jb5hrB_TZpw_1770209589
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6221C18004AD; Wed,  4 Feb 2026 12:53:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BAA919560A3; Wed,  4 Feb 2026 12:53:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ABC6221E692D; Wed, 04 Feb 2026 13:53:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [RESEND PATCH V3 1/3] qapi/misc: Fix missed query-iothreads items
In-Reply-To: <20260126094422.23116-1-zhangckid@gmail.com> (Zhang Chen's
 message of "Mon, 26 Jan 2026 17:44:20 +0800")
References: <20260126094422.23116-1-zhangckid@gmail.com>
Date: Wed, 04 Feb 2026 13:53:06 +0100
Message-ID: <87bji4y8jx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> The example is incomplete: it misses members @poll-max-ns, @poll-grow,
> @poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
> (monitor: add poll-* properties into query-iothreads result) and
> commit 1793ad0247c (iothread: add aio-max-batch parameter).
>
> cc: qemu-stable@nongnu.org
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


