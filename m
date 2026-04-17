Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C7DF436A9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDk2Q-0007rd-62; Fri, 17 Apr 2026 10:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wDk2O-0007rM-BF
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 10:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wDk2M-0002GU-DZ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 10:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776435552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jJ6yNxltcZCB0nNM0CNbFcTC5M4eLAzy5v7Fsd+como=;
 b=a2sXLqQL1UCZ8ek4omAHwdNYW1YKv513LH2S2rgMvHVLU69S+o7xCtJuP4DlPeat38Ayji
 5TyRRvUx04udm3/K3RzzsONDaEhvHAWqRHkDkSXpcjkqsTcXhQ1lkCwpp+uqT6VBiqIoDU
 ebHhZI3ffqtZwAsHIfGswhB0QWCSoBg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-PvjP1JSOO5SQv-Gw0zcisg-1; Fri,
 17 Apr 2026 10:19:09 -0400
X-MC-Unique: PvjP1JSOO5SQv-Gw0zcisg-1
X-Mimecast-MFC-AGG-ID: PvjP1JSOO5SQv-Gw0zcisg_1776435546
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB16618004A9; Fri, 17 Apr 2026 14:19:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C06C819560B1; Fri, 17 Apr 2026 14:19:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2ECD221E6A28; Fri, 17 Apr 2026 16:19:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  pbonzini@redhat.com,
 stefanha@redhat.com,  fam@euphon.net,  eblake@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  dave@treblig.org,
 sw@weilnetz.de,  mjrosato@linux.ibm.com,  farman@linux.ibm.com
Subject: Re: [PATCH v4 3/3] qapi/iothread: introduce poll-weight parameter
 for aio-poll
In-Reply-To: <20260412215011.326196-4-jhkim@linux.ibm.com> (Jaehoon Kim's
 message of "Sun, 12 Apr 2026 16:50:11 -0500")
References: <20260412215011.326196-1-jhkim@linux.ibm.com>
 <20260412215011.326196-4-jhkim@linux.ibm.com>
Date: Fri, 17 Apr 2026 16:19:02 +0200
Message-ID: <87qzodk6uh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Jaehoon Kim <jhkim@linux.ibm.com> writes:

> Introduce a configurable poll-weight parameter for adaptive polling
> in IOThread. This parameter replaces the hardcoded POLL_WEIGHT_SHIFT
> constant, allowing runtime control over how much the most recent
> event interval affects the next polling duration calculation.
>
> The poll-weight parameter uses a shift value where larger values
> decrease the weight of the current interval, enabling more gradual
> adjustments. When set to 0, a default value of 3 is used (meaning
> the current interval contributes approximately 1/8 to the weighted
> average).
>
> This patch also removes the hardcoded default value checks from
> adjust_polling_time(). Instead, poll-grow, poll-shrink, and
> poll-weight now use default values initialized in iothread.c
> during IOThread creation.
>
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

I reviewed v3 instead of this one by mistake.  Fortunately, the relevant
parts are identical.  Please check out my review of v3.


