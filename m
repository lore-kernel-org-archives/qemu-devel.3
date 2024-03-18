Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F4AC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 13:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmCee-0005PD-Ff; Mon, 18 Mar 2024 09:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmCca-0002RG-RU
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmCcU-0007fz-NE
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710766895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6nWAzz1RAVU1AEDOfP3SmXehriEBqKGen3g6vfNyr8Y=;
 b=T40V0oOEKCen+WSqMjIrspf1XeQ1Lo08a4yXN73rsTc7p74mqo6SNGQl0xO8tkMb424nBl
 bpH/1X51S21O7X/s1e4DMtfcVYqx+y/GjNXo64eFQi0hz5JqId44ZIgJdAF+KgtfTThiHu
 dK1GxICp4DRNfHsenm4o0ue9d0egt4I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-N5p_8Do-Mfu5_pSFO43szg-1; Mon,
 18 Mar 2024 09:01:32 -0400
X-MC-Unique: N5p_8Do-Mfu5_pSFO43szg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 732C61C01429;
 Mon, 18 Mar 2024 13:01:32 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D53702166B5D;
 Mon, 18 Mar 2024 13:01:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 08/15] tests/qemu-iotests: Restrict test 114 to the 'file'
 protocol
Date: Mon, 18 Mar 2024 14:01:11 +0100
Message-ID: <20240318130118.358920-9-kwolf@redhat.com>
In-Reply-To: <20240318130118.358920-1-kwolf@redhat.com>
References: <20240318130118.358920-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

iotest 114 uses "truncate" and the qcow2.py script on the destination file,
which both cannot deal with URIs. Thus this test needs the "file" protocol,
otherwise it fails with an error message like this:

 truncate: cannot open 'ssh://127.0.0.1/tmp/qemu-build/tests/qemu-iotests/scratch/qcow2-ssh-114/t.qcow2.orig'
  for writing: No such file or directory

Thus mark this test for "file protocol only" accordingly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240315111108.153201-4-thuth@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/114 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index de6fd327ee..dccc71008b 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2
-_supported_proto generic
+_supported_proto file
 # At least OpenBSD doesn't seem to have truncate
 _supported_os Linux
 # qcow2.py does not work too well with external data files
-- 
2.44.0


