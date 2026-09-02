Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76FCC624D6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1k4k-0006TO-Nj; Wed, 02 Sep 2026 08:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x1k4Y-0006RE-P3
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x1k4X-0004sy-10
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788352088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wv18segry+Lgnkcn+qSHeXfR93B1lxBaPzY4XZJZqnY=;
 b=SvezbZgqTf3K8VSBufuB0a4JYYTP1aZLC8iKsbafS4Cz7RwiVZQ8SxVTTIvJobTt4MDznl
 mUgB6B76rSSXOJzdynSq12ARpCAwMrLpt4pe5MbFYRbwfnQnNSU9duUVrLJR9++hKEv+gt
 7sP/ISqgMWryQFqT8dKQumJVIsj5di8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-7qow3BWuONSuQ0N_6eR2Pw-1; Wed,
 02 Sept 2026 08:26:52 -0400
X-MC-Unique: 7qow3BWuONSuQ0N_6eR2Pw-1
X-Mimecast-MFC-AGG-ID: 7qow3BWuONSuQ0N_6eR2Pw_1788352011
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC66619344F7; Wed,  2 Sep 2026 12:26:50 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77A773000223; Wed,  2 Sep 2026 12:26:49 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, leif.lindholm@oss.qualcomm.com, eauger@redhat.com
Subject: [PATCH 0/6] sbsa-gwdt cleanup and fixes
Date: Wed,  2 Sep 2026 14:26:40 +0200
Message-ID: <20260902122646.2848464-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


Series picks up dropped gwdt fixes from

  [PATCH v3 00/17] Add watchdog support to arm/virt board
  https://patchew.org/QEMU/20260624102830.1355552-1-imammedo@redhat.com/

patches were basically rewritten to make changes simpler/easier to reson about.

patch 6/6 is partial fix with open question:

sbsa-gwdt currently mantains WVC in since VM start ticks, which works fine under
TCG. However under KVM those system counter domains diverge and CNTPCT in guest
starts to return host's value. As result WCV reads/writes got mixed up with
QEMU still assuming VM timeframe while guest using host's one.
Question is how should we fix it?

Igor Mammedov (6):
  sbsa-gwdt: reduce code ident
  arm: gwdt: consolidate clear WS0 and WS1 on explicit refresh
  arm: gwdt: simplify WCV update condition
  sbsa-gwdt: rename sbsa_gwdt_update_timer() to
    sbsa_gwdt_wor_update_timer()
  sbsa-gwdt: don't arm timer for compare values above INT64_MAX
  sbsa-gwdt: reschedule timer on direct WCV load

 hw/watchdog/sbsa_gwdt.c | 81 +++++++++++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 27 deletions(-)

-- 
2.52.0


