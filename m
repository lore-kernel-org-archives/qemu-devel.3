Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7672106B50F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5N3n-0002lG-7f; Wed, 25 Mar 2026 08:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5N3d-0002hV-WB
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 08:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5N3b-0000rX-Vd
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 08:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774440593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MMDUiO6svuyuPOoL0sZz5EfuZlB3kadk9In3iy3E0JQ=;
 b=QZUz2EVgMPEji3hLrI1ceZMCi8RTYBm2RtPJ7GDee8D9s3OGt332lZChipZXa85OzbJdvB
 qdtiYoIQ1hk9+lg/Xu/vbjQjxbrNrs100nVbVASOgyCqwFgx4Et5CUPKJnP1nk1JYeh1nr
 Kti9VGoQ7TrXfMtjlpbImcOrg5jrUpE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-XrrAT-R0NUGjMIqu8Zy3Pw-1; Wed,
 25 Mar 2026 08:09:49 -0400
X-MC-Unique: XrrAT-R0NUGjMIqu8Zy3Pw-1
X-Mimecast-MFC-AGG-ID: XrrAT-R0NUGjMIqu8Zy3Pw_1774440588
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF95419560B5; Wed, 25 Mar 2026 12:09:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.139])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C2E41955F2E; Wed, 25 Mar 2026 12:09:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH for-11.1 0/2] target/i386: Allow 32-bit SMM code to be used in
 the 64-bit binary
Date: Wed, 25 Mar 2026 13:09:42 +0100
Message-ID: <20260325120944.29391-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Here are two patches that I just resurrected from an older branch
on my hard disk. They might come in handy when we finally switch
to an universal QEMU binary that contains both targets, the x86_64
and the i386 target at once. In this case we need the SMM code for
both, 32-bit and 64-bit mode in the binary, and select it during
runtime.

Thomas Huth (2):
  target/i386/tcg/sysemu: Move target specific SMM code to separate
    functions
  target/i386/tcg/sysemu: Allow 32-bit SMM code to be used in the 64-bit
    binary

 target/i386/tcg/system/smm_helper.c | 104 ++++++++++++++++++----------
 1 file changed, 69 insertions(+), 35 deletions(-)

-- 
2.53.0


