Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75678CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXT-0006M7-H6; Tue, 13 Oct 2026 09:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVv-0003ak-RB
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVr-00052v-Lx
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hdoWJn0Y2zJRM919VomiIg9Z+oEuJL8Ypr3roy49HKg=;
 b=N4p+7ZzQXIywC27tdW3QGMf9f96v2LpvCmthm5T5jxuT4qL9FothhOouH/LvvBOYulH3DG
 uUE+f81J6h7apzYrMe3XAe43CxtRLh24m06KWjJPoN/HmHuBSI/MlqvXwh2YpFyJuqWYNM
 uUXMIXc4hle1KzjY77Q2fYny5CuqtSA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-SSAWBKQLOty4SLYP9LlyYw-1; Tue,
 13 Oct 2026 13:25:47 +0000
X-MC-Unique: SSAWBKQLOty4SLYP9LlyYw-1
X-Mimecast-MFC-AGG-ID: SSAWBKQLOty4SLYP9LlyYw_1791897947
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7CCA1801339; Tue, 13 Oct 2026 13:25:46 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6BB09195608D; Tue, 13 Oct 2026 13:25:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:37 +0400
Subject: [GIT PULL 40/40] chardev/char: fix use-after-free on mux creation
 failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-40-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gdFkFZhN8YrtK+WU2f55DAfsxaFN8HX/Pcrp+C1v1so=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDEbAWEXiQboHK7EE/mo11Q7lT+URKSCTcNy
 1109IXWM42JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wxAAKCRDa6OEJdZac
 5cGMD/9F1u2OabaDttPiQAY+WCu5Bf8gxOclnFzrvVy35D8MnR0C6kGSDcmhFYoRrEG5CXxeIxQ
 7EqnmOzDIPlWSXPui+ZCWCLVqrMEBAfEW08TUpKCqVfMJn6k7c2cQ73X62BZsJ8Wc0fgjsTXZAJ
 8PzptriX6ySmsDNl49/xZXKgduMZ6Aoh0lR2kaJu6ZwYE9S3tAoo11VeAbnlqkWQXDZ+TurgRek
 aSXKxMMfj2sdGAcl87hwAgJc2xZ6fkYL3UFShi+D3z+athov0bJIt/BdMzm98qQarScvzKlM9By
 +tXJjuDvcFcKZqwBDI+zGxB97sdag00tv0AGxLAvh33/ecwvaKlCdVQGejyOMOf5GZIF9UGVjmU
 Sw2ZlZ1VHEXvM/OB4DWuNNaMaNgmL3EVE53pQEHUvif56GlZrbzMCDk+MyjpT2ne1UX5vq/69k/
 IowkJRfSS5BrXc23t8f3k19UuKhgYG/K8+nxCwdsCoe7J8OSTEGjyp/Clihe2lnD400dNwouY3i
 8Hj8xT3aSp7mAw50mjJMuB+cHdmMapEZIlLW3VDGlXMfaLVM3he3+HQd5KdbxTYiXahyBfHNFab
 X3pPSvyzXgqD65UYBzXuKTEowSK4XvEfUt29GpM7AW0q4ClcSEwNHR4k6s4nIH3Cr0y7tWQ/+wk
 PU6UPaoubTtMzUg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When mux creation fails, object_unparent() drops the last reference
on the base chardev, but 'base' was left dangling. The 'out' label
then passes it to qemu_chardev_set_replay(), causing a
use-after-free.

Set base to NULL after unparent so the replay path is skipped.

Reported-by: Hui Peng <benquike@gmail.com>
Fixes: 4c193bb129da ("chardev: set record/replay on the base device of a muxed device")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-23-ccbef537cbeb@redhat.com>
---
 chardev/char.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/chardev/char.c b/chardev/char.c
index fe513ae9621a..972550ba1f80 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -759,6 +759,7 @@ static Chardev *do_qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
         mux = qemu_chardev_new(id, TYPE_CHARDEV_MUX, backend, context, errp);
         if (mux == NULL) {
             object_unparent(OBJECT(chr));
+            base = NULL;
             chr = NULL;
             goto out;
         }

-- 
2.56.0.116.g6de20f6092dc


