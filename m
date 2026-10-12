Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF48CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGMkI-00044t-3w; Mon, 12 Oct 2026 16:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMjy-0003eP-0V
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMjv-0003Ov-TO
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791837319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5H/haMw6tiIt2E7cR+zPeNBh8CmooHi6puFYTBy0SvU=;
 b=LVRiV7fyJnOJLrjrv5WZiLZkqLF0vsojv0VQrC+zpz5T0gEJrjGGvhvU2nWPVYhq/VxaUU
 yl1Wfv0RA4sDvasSOEgMfLQMqG8FXsf2rIftR0uVyzIdHXaK/fXU5BT4Jg5yUvwtEzigmn
 9pRhn32LgjzxKV0ngC2OAHSz97ZB9fw=
X-MC-Rep: binary re single
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-_JxoJYqxMjeoRXqwfDpHWA-1; Mon,
 12 Oct 2026 20:35:13 +0000
X-MC-Unique: _JxoJYqxMjeoRXqwfDpHWA-1
X-Mimecast-MFC-AGG-ID: _JxoJYqxMjeoRXqwfDpHWA_1791837309
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9541D1955EB9; Mon, 12 Oct 2026 20:35:09 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6BFDC180034C; Mon, 12 Oct 2026 20:35:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 00:34:11 +0400
Subject: [PATCH v2 08/10] target/riscv: bypass smstateen check in debugger mode
MIME-Version: 1.0
Message-Id: <20261013-query-reg-v2-8-6f95a2e139a9@redhat.com>
References: <20261013-query-reg-v2-0-6f95a2e139a9@redhat.com>
In-Reply-To: <20261013-query-reg-v2-0-6f95a2e139a9@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=898;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=roAD8lZ3bak3GtYlRrCGDQC517ZgrKZMcWsjgpCj3lM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzURBPZi4c03VMIsQ7QXKN83zWjtSrW00UwCAS
 IWxDK5e/QCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas1EQQAKCRDa6OEJdZac
 5XgVD/kBaNVNAPd/djIRnyHtGpHUwV4vt7qxOdMWWAQQe8qKHD1XI7y++EkftMEnBOUWrwtmAKI
 MoE89ox7eBXN/iy+jlTvT/NvU5jieQ1GAUa9qvU62/AFh9Z/s1b3+OAJWKcS7HAiEn0a9A2BJrw
 kfvCZGCay4kSrDzuNBwCq+r5MlSpV/deXN2mmZfa2UM1nbjnjzi5IMTLis0vVTD2zzCEUQIcP6v
 hG/1wPJsK+xLbA079JnymTPszy16FS561CmGhFKV60DHeV+MHoFRhv2R7qzt7lE6B52S/y950z0
 gIGdPtfwFxNhrVV9IU0hDoeUzAqokF5yx6CBVtB55gbiWalWSaOrskZAE6cm+uF9k8ANS0Yr+mq
 8X1haxU5VfWvn6+ULBSbyLIjDWtBHBZ9qHXs6Xdr8/Tiw4a9xdCK8CNbdUNINlvwoyncALH1Uqt
 7kAEpjUehDs5qEDEEPhIZ7Du4URKH7k3dPtHDWkfjEA4wvF+8DaYVqjkYIT8w83VXWucV8JQK4S
 QJ65biDJXNawcsjZHEYa+gvKTh+YVmBd6jTqOWZsC+W0DlnFN0PQWmileGYWp5XUNItMj5EBLXU
 87KGw4d969576r1KJdeLSCh9ScopqBptn6QNaOJHtIA58wpiomQZHLp94uUAI318pp7RMtEG/kF
 GLOcGaFJo2p2/8A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: x1lF7UrRPtxfakKIlqslkF3NB-Q6NsnoUEhurBFsIns_1791837309
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Allow to read CSRs gated by Smstateen extension when env->debugger.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/riscv/tcg/csr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 061bc9db77b3..9da05a0507d5 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -53,7 +53,8 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit)
 {
     bool virt = env->virt_enabled;
 
-    if (env->priv == PRV_M || !riscv_cpu_cfg(env)->ext_smstateen) {
+    if (env->debugger || env->priv == PRV_M ||
+        !riscv_cpu_cfg(env)->ext_smstateen) {
         return RISCV_EXCP_NONE;
     }
 

-- 
2.56.0.116.g6de20f6092dc


