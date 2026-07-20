Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A4CC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlnw9-00008F-IN; Mon, 20 Jul 2026 09:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wlnw7-00006W-6w
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wlnw5-0001eF-Qh
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784553693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W5z2Ohxy7/Q5eBrsLALenjrl3v+cRnifwfhebLHHq1U=;
 b=T5TVW9XBhmYIteDLZA3zHfQjjfh4+W6zKrUmdJMc/XRxi6eC8PazAgMNDbZygbANoQkyiJ
 MOHkR3R2EkN1ltK/i6PSIR9KJxMpW/KQFBbfNxg/8oQ6iLCqaYpTMYq+ws0RKUUeyFeCAz
 fglYWqG8brG1aYm7T98EorkpEeOyDdM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-gEwwTBEfMXm4o1YdaonVbg-1; Mon,
 20 Jul 2026 09:21:28 -0400
X-MC-Unique: gEwwTBEfMXm4o1YdaonVbg-1
X-Mimecast-MFC-AGG-ID: gEwwTBEfMXm4o1YdaonVbg_1784553686
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27FFA195E92E; Mon, 20 Jul 2026 13:21:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 344B5300418F; Mon, 20 Jul 2026 13:21:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8295B21E6920; Mon, 20 Jul 2026 15:21:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  kvmarm@lists.linux.dev,
 eric.auger@redhat.com,  cohuck@redhat.com,  peter.maydell@linaro.org,
 richard.henderson@linaro.org,  maz@kernel.org,  oliver.upton@linux.dev,
 berrange@redhat.com,  abologna@redhat.com,  jdenemar@redhat.com,
 gshan@redhat.com,  skolothumtho@nvidia.com,  sebott@redhat.com,
 philmd@linaro.org,  yangjinqian1@huawei.com,  shaju.abraham@nutanix.com,
 mark.caveayland@nutanix.com,  prerna.saxena@nutanix.com
Subject: Re: [RFC PATCH v3 16/19] qmp: add query-cpu-props-info command
In-Reply-To: <20260716213858.609699-17-khushit.shah@nutanix.com> (Khushit
 Shah's message of "Thu, 16 Jul 2026 21:38:55 +0000")
References: <20260716213858.609699-1-khushit.shah@nutanix.com>
 <20260716213858.609699-17-khushit.shah@nutanix.com>
Date: Mon, 20 Jul 2026 15:21:22 +0200
Message-ID: <87y0f5u78t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Series doesn't apply for me.  I need to apply it to be able to check
rendered documentation.  Could you push it somewhere I can pull?


