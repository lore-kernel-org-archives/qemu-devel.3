Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397B1CD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMN8v-0002UF-A0; Mon, 11 May 2026 05:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMN8K-0002Bt-QX
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:41:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMN8J-0001uU-43
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778492462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bfg/+jg0r60Rjkxh9p2CB0/L865iyV+87KCuJ8I3YXU=;
 b=ER9uhNjZZeliss6fZsbikuhbdLEwZjWbvy7vwLWofLDMlou75kX/5RcaY5g0JUD3F//V0v
 aGNEgetk7fYYgY1qUTlUjIUHltvFFDtt+t7KdCpm3jwZyBgY35nSpaV2pkZgWnTcG2wqc6
 0Xj13qRAEENNxl+4hxL5y9SrLTKXRNc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-SHxAAzQlMCCG0UAfF5jWkw-1; Mon,
 11 May 2026 05:39:02 -0400
X-MC-Unique: SHxAAzQlMCCG0UAfF5jWkw-1
X-Mimecast-MFC-AGG-ID: SHxAAzQlMCCG0UAfF5jWkw_1778492341
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C97D195608E
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:39:01 +0000 (UTC)
Received: from berrange.com (unknown [10.44.50.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EB3618004A3; Mon, 11 May 2026 09:38:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] scripts: strip leading './' when searching MAINTAINERS file
Date: Mon, 11 May 2026 10:38:58 +0100
Message-ID: <20260511093858.82753-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following two uses of get_maintainer.pl should return the
same results, but do not:

  $ ./scripts/get_maintainer.pl -f ./hw/net/vmxnet3.c
  get_maintainer.pl: No maintainers found, printing recent contributors.
  get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.

  "Philippe Mathieu-Daudé" <philmd@linaro.org> (commit_signer:4/7=57%)
  "Michael S. Tsirkin" <mst@redhat.com> (commit_signer:4/7=57%)
  Xiaoyao Li <xiaoyao.li@intel.com> (commit_signer:3/7=43%)
  Thomas Huth <thuth@redhat.com> (commit_signer:3/7=43%)
  Zhao Liu <zhao1.liu@intel.com> (commit_signer:3/7=43%)
  qemu-devel@nongnu.org (open list:All patches CC here)

  $ ./scripts/get_maintainer.pl -f hw/net/vmxnet3.c
  Dmitry Fleytman <dmitry.fleytman@gmail.com> (maintainer:VMware)
  Jason Wang <jasowang@redhat.com> (odd fixer:Network devices)
  qemu-devel@nongnu.org (open list:All patches CC here)

In the former case, the leading "./" needs to be removed before
trying to find a filename match.

Blindly stripping the "./" is valid because the script already
enforces that it is run from the QEMU git root directory, so
canonicalizing the filename vs $CWD is not required.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/get_maintainer.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 00a0870b26..76be402e11 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -384,6 +384,7 @@ foreach my $file (@ARGV) {
 	} elsif (!(stat $file)) {
 	    die "$P: file '${file}' not found: $!\n";
 	}
+	$file =~ s,^./,,;
     }
     if ($from_filename) {
 	push(@files, $file);
-- 
2.54.0


