Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81700C27C65
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 17:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH5dU-0000Iv-Vs; Tue, 11 Jun 2024 13:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sH5dT-0000Ht-BL
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sH5dR-00037Q-8m
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718128216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sAUjnMz8eHEoX4lTMd9RO51MMzPmRqWk4z1sgk7dwcA=;
 b=HcUTuFMIVyz0LPqXOmn7Xrjjz8gOvKs3ayKPERRcNpBqmv+oUPQRsYP38HpOx2WXb3NMzW
 xsJjKklp/WzapQX57wAJKdc4H/8cpHqnfFSKLXsH4AF8nEXC7uK66iD63wk22bHuO0jmfn
 eY47F+DMDlZxknOr8LxaaOI6+M+e+qI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-4hrYrfxvMXeDvFMiW86i0A-1; Tue,
 11 Jun 2024 13:50:11 -0400
X-MC-Unique: 4hrYrfxvMXeDvFMiW86i0A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E7611956095; Tue, 11 Jun 2024 17:50:08 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.130])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C92811956055; Tue, 11 Jun 2024 17:50:03 +0000 (UTC)
Date: Tue, 11 Jun 2024 19:49:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, hreitz@redhat.com, jsnow@redhat.com,
 f.ebner@proxmox.com
Subject: Re: [PATCH v4 5/5] iotests: add backup-discard-source
Message-ID: <ZmiORpYFHEWUXQRI@redhat.com>
References: <20240313152822.626493-1-vsementsov@yandex-team.ru>
 <20240313152822.626493-6-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313152822.626493-6-vsementsov@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Am 13.03.2024 um 16:28 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Add test for a new backup option: discard-source.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>

This test fails for me, and it already does so after this commit that
introduced it. I haven't checked what get_actual_size(), but I'm running
on XFS, so its preallocation could be causing this. We generally avoid
checking the number of allocated blocks in image files for this reason.

Kevin


backup-discard-source   fail       [19:45:49] [19:45:50]   0.8s                 failed, exit status 1
--- /home/kwolf/source/qemu/tests/qemu-iotests/tests/backup-discard-source.out
+++ /home/kwolf/source/qemu/build-clang/scratch/qcow2-file-backup-discard-source/backup-discard-source.out.bad
@@ -1,5 +1,14 @@
-..
+F.
+======================================================================
+FAIL: test_discard_cbw (__main__.TestBackup.test_discard_cbw)
+1. do backup(discard_source=True), which should inform
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File "/home/kwolf/source/qemu/tests/qemu-iotests/tests/backup-discard-source", line 147, in test_discard_cbw
+    self.assertLess(get_actual_size(self.vm, 'temp'), 512 * 1024)
+AssertionError: 1249280 not less than 524288
+
 ----------------------------------------------------------------------
 Ran 2 tests

-OK
+FAILED (failures=1)
Failures: backup-discard-source
Failed 1 of 1 iotests


