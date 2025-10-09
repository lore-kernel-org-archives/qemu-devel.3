Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00511CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tIv-00044z-Qx; Thu, 09 Oct 2025 12:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v6tIs-00044X-Pt
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v6tIo-0000I0-5l
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760026535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JwUmODPtL0cp8yFxC5zPnfG8pp+pK8Rn8MoTSDyh76s=;
 b=X4X8zF0WE/xqxOLfCZA0i2ghZxCNo4zaNysWOCgfRYHKI0iC/kvXvanSLF8Q4T8P+Jz2UN
 5iYTDQ6RWyopbEfX8ZOCVeYwbOlGNn02AQ9lc4cgStbW4nPwxk/t7N1eYKuLYbD7d/TfmQ
 8XUhmRJ1c/Fsp/aevNeN2/cK9qnOl0w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-TgtbAfocPe-t4V9IGjzjtQ-1; Thu,
 09 Oct 2025 12:15:31 -0400
X-MC-Unique: TgtbAfocPe-t4V9IGjzjtQ-1
X-Mimecast-MFC-AGG-ID: TgtbAfocPe-t4V9IGjzjtQ_1760026531
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B396318004D4; Thu,  9 Oct 2025 16:15:30 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.45.224.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80A171800447; Thu,  9 Oct 2025 16:15:28 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-devel@nongnu.org
Cc: lvivier@redhat.com, farosas@suse.de, pbonzini@redhat.com,
 berrange@redhat.com
Subject: [PATCH v2 0/2] Implement -run-with exit-with-parent=on
Date: Thu,  9 Oct 2025 17:12:45 +0100
Message-ID: <20251009161526.140497-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v1 was here:

https://lists.gnu.org/archive/html/qemu-devel/2025-10/msg00762.html

In v2:

 - Fix unused variable warning.

 - Remove the #ifdefs from the libqtest.c code.

 - Add the missing S-o-B in the second patch.

 - Rebase and retest.

As before, one test fails both before and after this change:

  4/405 qemu:func-quick+func-x86_64 / func-x86_64-bad_vmstate               ERROR            0.15s   exit status 1

And as before, some questions:

 - There's no way to find out if the qemu binary supports
   exit-with-parent=on except to try it.  Maybe this should be exposed
   somehow?

 - Or should we have exit-with-parent=best ?

 - On macOS I wasn't able to find a satisfactory way to force
   shutdown, except calling 'qemu_system_killed' and pretending we'd
   been killed by SIGTERM (which does at least emulate what Linux &
   FreeBSD do).  I suppose it'd be nice if there was a "killed by
   parent" reason which also forced shutdown.

Rich.



