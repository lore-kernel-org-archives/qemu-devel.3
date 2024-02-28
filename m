Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA46C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 09:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfGMw-0000F0-Ss; Wed, 28 Feb 2024 04:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfGMv-0000E9-3e
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:36:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfGMt-0004uI-RZ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709113011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nIchHhw8jz82aZ76lOSTaq38aq40qrRilW9JAKl0N1M=;
 b=T64/zyBw7+cNPZnhBtDu6B5EPuhl7egOBKflNnvrPc7GX3MehR8lG9PkdcAFrnPFsMS929
 fHowAbuKA6sPILopqCH5Aad8DTRan5D29dJrVAzl2JBa3kAgII9BGMY1JMsyeYQGjaT9iG
 b0HJxfQP27XHAYgrf4aYcaKs+38/2xI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-HHHGvXFuOf6ml7h0-ZFMXA-1; Wed, 28 Feb 2024 04:36:46 -0500
X-MC-Unique: HHHGvXFuOf6ml7h0-ZFMXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF20A85A58E;
 Wed, 28 Feb 2024 09:36:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8817120155E6;
 Wed, 28 Feb 2024 09:36:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 571B121E66F9; Wed, 28 Feb 2024 10:36:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com,  berrange@redhat.com,  eduardo@habkost.net,
 peterx@redhat.com,  farosas@suse.de,  eblake@redhat.com,
 thuth@redhat.com,  lvivier@redhat.com,  jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com,  philmd@linaro.org,  wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/7] Introduce multifd zero page checking.
In-Reply-To: <20240226195654.934709-1-hao.xiang@bytedance.com> (Hao Xiang's
 message of "Mon, 26 Feb 2024 19:56:47 +0000")
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
Date: Wed, 28 Feb 2024 10:36:43 +0100
Message-ID: <87r0gx0w2c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Needs a rebase.  But let me have a look at the QAPI schema changes
first.


