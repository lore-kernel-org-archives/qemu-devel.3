Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436E2CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rM7-0006rE-D0; Thu, 09 Oct 2025 10:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v6rM5-0006ql-AW
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v6rLw-0008PJ-K8
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760019039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5SO3PKJ8r+otzGF6e0D7l8xW5jR+APmtuKc0tjsdoSs=;
 b=VTibc3nPKO9UNvErbRNjcgQW/ZBpZUWdsJf0saK7Kx5Qc++XpntNdl+y1ltoSzMoqx2vP8
 HSutxho9pU4JwtnwmxVbWIJ3nobSOKzo2sYlNbTySU01uix5R6y1O/dpnwDqAMe2poA/yv
 Jo+K4BEZkEh2X4Dh5op6t2Zb+AJXnTE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-81bc5C-1PPyFwRQAi9iyfw-1; Thu,
 09 Oct 2025 10:10:36 -0400
X-MC-Unique: 81bc5C-1PPyFwRQAi9iyfw-1
X-Mimecast-MFC-AGG-ID: 81bc5C-1PPyFwRQAi9iyfw_1760019034
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E6F019560A2; Thu,  9 Oct 2025 14:10:34 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.45.224.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5DAF1955F22; Thu,  9 Oct 2025 14:10:30 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 viktor.prutyanov@phystech.edu, hreitz@redhat.com, kwolf@redhat.com,
 maochenxi@bosc.ac.cn, berrange@redhat.com, peter.maydell@linaro.org
Subject: [PATCH v2] block/curl.c: Use explicit long constants in
 curl_easy_setopt calls
Date: Thu,  9 Oct 2025 15:08:30 +0100
Message-ID: <20251009141026.4042021-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

v1 was posted here:
https://patchwork.ozlabs.org/project/qemu-devel/patch/20251001124055.2743244-1-rjones@redhat.com/

In v2, I incorporated additional changes found by Chenxi Mao.

Rich.


