Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA16CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGMjg-0003Ie-T3; Mon, 12 Oct 2026 16:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMje-0003HV-4V
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMjb-00037f-Ha
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791837298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jNzV6BaWVFq1+/O7YYwswt0SKLovTH7A3DMoCwLjQZ4=;
 b=h9kX1yVsHSbtvecM8KiupXC53x3BxWnKL5/DaMxGXC4NIL2UfLUqE6054IjZWYh8RGTBYR
 8d1N5Hi6suS+DHoTjMqNAMdGSUPtQx2HrcmLVnkxfPG5mYBqrNeg1pfk1V3lW099mvBleD
 uZtrMa8Nlck5wML1CRi4mble2MXFZOY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-92agaLgGMI-s9tS3xb6N_Q-1; Mon,
 12 Oct 2026 20:34:55 +0000
X-MC-Unique: 92agaLgGMI-s9tS3xb6N_Q-1
X-Mimecast-MFC-AGG-ID: 92agaLgGMI-s9tS3xb6N_Q_1791837291
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B7A2195FD3B; Mon, 12 Oct 2026 20:34:51 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 82D3A1956040; Mon, 12 Oct 2026 20:34:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 00:34:06 +0400
Subject: [PATCH v2 03/10] gdbstub: set feature->base_reg for dynamic features
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-query-reg-v2-3-6f95a2e139a9@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KuwHJGXyije9XLDEqL0xZ9kuS8FmeuZ9mxj6XXAIhZs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzURBwZRSDhcCAoMZkB2EtH02KuMEo0tEaNjid
 tMPLj6NxIOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas1EQQAKCRDa6OEJdZac
 5evdEACeCvJfaUCGsnrVzZnggk7sBhSnBTQU+iiDbjMtNa/SNfR4HkWm/KbKe/UKHR02UDWNMWp
 2km/jpfUFNfwey8Pavk6TjgO+ed5zu3946/mEAd1WX+s8gisStY+byI5qFwAZpsMyQOzuQOpS01
 3DZaisVqCTYd3yRi1Dxgb4VsscNkDGZULEFm3gBZZMQulFR8TNIl1cdLYJ0tiqTCyR5gRKUyZoi
 8Yl8uMEMKNwmHPLA83YC6ew+HlCQLRpdqBGSTvrvw7ti4w0v3y+bmi+M/RTqUsXTZJthPFGfN8P
 A787E0WfaaZ3hvGuErShZhq7vP3MJxQgByIDKUQHfW+xM9jdZYVotP8mt3dgn5iyGRVWiS8GW6S
 EWopHWGiaOP+iwVq2BkvF5giGqm+zU0iQD6fI+bH7KK1sl4bfjeGljoeQbkhQnLXkw9ekJwMVkj
 z9/9thamThc+McAkFp9WjO59CE9vl7WWx5GHT9cLd8xaeEv4woDqwu5aRTHISyyAqHVF6NvrJRs
 agGb4uUjKgYvH6ATfhYbqBZaYECXgUrSa7ddze2OXh/UXAarEBwZVjDnp81z//2XS86M+xuzDtq
 7n8ZkiJP89VS9F2nCW+fahm8gwdmgpkGF2bKybz1k0Unpqgicqiixxp+UmkdW+T29SPGOv7LYIK
 gFBTx+OFyq91rCw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

gdb_feature_builder_end() never propagated builder->base_reg into
feature->base_reg, leaving it at 0 for all dynamically-built features.
This made the trace log at gdb_get_register_list() report an incorrect
base_reg for dynamic features.

GDBRegisterState::base_reg was correctly set, so this doesn't fix
an actual issue.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 gdbstub/gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 0ce871d74929..912e31b66744 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -476,6 +476,7 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder)
 
     g_ptr_array_free(builder->xml, TRUE);
 
+    builder->feature->base_reg = builder->base_reg;
     builder->feature->num_regs = builder->regs->len;
     builder->feature->regs = (void *)g_ptr_array_free(builder->regs, FALSE);
     trace_gdbxml_feature_builder_header(builder->feature->name,

-- 
2.56.0.116.g6de20f6092dc


