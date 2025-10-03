Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0BECCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 13:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4ftd-0008Bl-57; Fri, 03 Oct 2025 09:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v4ftZ-0008An-N2
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 09:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v4ftP-0003Ug-5I
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 09:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759498326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+YiZ1KG+fNWWlPTR/w/1LINOhhRpcZm9hPqL4USv7bI=;
 b=U6drptO6gvNDP1C1MruSVz1OwWf3tnxS+ls1bQA/T9vjEq/ACV7omN7aJ/mCw1KAQ8ud+V
 g3+V2WUNFKb1Y2hiEM1lMwlSOJk8nsEURxMzQpD5Z4SlF3MQ8kBH1AV9JzUFoLiJlpepVv
 ibu4bbYV5O2K9LXsyWMxZ+HfPVNUz2A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-eoIqdAFQMLOVm_UqZ_eHRA-1; Fri,
 03 Oct 2025 09:32:02 -0400
X-MC-Unique: eoIqdAFQMLOVm_UqZ_eHRA-1
X-Mimecast-MFC-AGG-ID: eoIqdAFQMLOVm_UqZ_eHRA_1759498322
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF397180035C
 for <qemu-devel@nongnu.org>; Fri,  3 Oct 2025 13:32:01 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.45.224.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FBB81955F19; Fri,  3 Oct 2025 13:32:00 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v1 0/2] Implement -run-with exit-with-parent=on
Date: Fri,  3 Oct 2025 14:24:36 +0100
Message-ID: <20251003133158.3978333-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

An earlier WIP version was posted here:
https://lists.gnu.org/archive/html/qemu-devel/2025-10/msg00309.html

In this version I have incorporated all of Daniel Berrange's feedback,
and I also tested the change on macOS.

The new second patch modifies the test suite to use the new flag
unconditionally, instead of open coding setting PR_SET_PDEATHSIG etc.
The test suite fails for me both before and after this patch in the
same way, so I assume this is nothing to do with the patch itself?

  4/405 qemu:func-quick+func-x86_64 / func-x86_64-bad_vmstate               ERROR            0.15s   exit status 1

Some points of note:

 - There's no way to find out if the qemu binary supports
   exit-with-parent=on except to try it.  Maybe this should be exposed
   somehow?

 - On macOS I wasn't able to find a satisfactory way to force
   shutdown, except calling 'qemu_system_killed' and pretending we'd
   been killed by SIGTERM (which does at least emulate what Linux &
   FreeBSD do).  I suppose it'd be nice if there was a "killed by
   parent" reason which also forced shutdown.

Rich.


