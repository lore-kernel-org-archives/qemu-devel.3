Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C88E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLIbX-0006uV-DX; Wed, 11 Dec 2024 04:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIaj-0005uu-Op
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLIae-0007sT-8F
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733907663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbiMEoxU6MrYfb/yIFm2dbLnVIXoNmjPXR3qh6mwIS8=;
 b=hKDKQA55P1VObeA7KJhgVlykVMNcPWtXyGfPULFkuFlMcPF21guCv88FfwzGyJnNzEE3FN
 nNaMVqzMszJnxIfkeUYnlofOPL0APrPwtTuv2IwBhJL52kXmVySLIBIz/Kd6LXRf6ceSzF
 t/Jz/NGzS0wBKvfu3R4kAxBZL2xFH7c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80--7mFsScYPaeu4hCY8_kipw-1; Wed,
 11 Dec 2024 04:01:02 -0500
X-MC-Unique: -7mFsScYPaeu4hCY8_kipw-1
X-Mimecast-MFC-AGG-ID: -7mFsScYPaeu4hCY8_kipw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C791D19560A2; Wed, 11 Dec 2024 09:01:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.186])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D942F1956089; Wed, 11 Dec 2024 09:00:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Subject: [PULL 12/26] s390x/cpumodel: add Miscellaneous-Instruction-Extensions
 Facility 4
Date: Wed, 11 Dec 2024 09:59:56 +0100
Message-ID: <20241211090014.619351-13-thuth@redhat.com>
In-Reply-To: <20241211090014.619351-1-thuth@redhat.com>
References: <20241211090014.619351-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hendrik Brueckner <brueckner@linux.ibm.com>

This facility introduces few new instructions.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <20241206122751.189721-10-brueckner@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_features_def.h.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 0b7be0e6e9..8be2e0e46d 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -90,6 +90,7 @@ DEF_FEAT(EDAT_2, "edat2", STFL, 78, "Enhanced-DAT facility 2")
 DEF_FEAT(DFP_PACKED_CONVERSION, "dfppc", STFL, 80, "Decimal-floating-point packed-conversion facility")
 DEF_FEAT(PPA15, "ppa15", STFL, 81, "PPA15 is installed")
 DEF_FEAT(BPB, "bpb", STFL, 82, "Branch prediction blocking")
+DEF_FEAT(MISC_INSTRUCTION_EXT4, "minste4", STFL, 84, "Miscellaneous-Instruction-Extensions Facility 4")
 DEF_FEAT(MSA_EXT_12, "msa12-base", STFL, 86, "Message-security-assist-extension-12 facility (excluding subfunctions)")
 DEF_FEAT(VECTOR, "vx", STFL, 129, "Vector facility")
 DEF_FEAT(INSTRUCTION_EXEC_PROT, "iep", STFL, 130, "Instruction-execution-protection facility")
-- 
2.47.1


