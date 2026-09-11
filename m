Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5005DC88E56
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x50MH-0007P8-J7; Fri, 11 Sep 2026 08:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x50MF-0007Ko-J9
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x50MD-00070f-Nh
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789129673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HqWC4E/c16S9/+MLB6SLnQfOu+B+Hw2yLwBbSSQj1Gc=;
 b=PDKv5OlRiKtWQnGm0FfEXov2AuZE9Wcuo16XXlrctB5jsyg2zA8XeUpftljPBFvLnLALzT
 4Xa4TkExSyEmZpjT0iOs7NhownjT1ruFaGInU8ADY75kzu7Ij/6Y/FWEpQDjCtjBye0PVp
 at2hS694+IjhkY8QCb+bWCUOoYIVW2w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-7nTTvDciMZaSbB4ISdZxIA-1; Fri,
 11 Sep 2026 08:27:49 -0400
X-MC-Unique: 7nTTvDciMZaSbB4ISdZxIA-1
X-Mimecast-MFC-AGG-ID: 7nTTvDciMZaSbB4ISdZxIA_1789129666
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EBFD19540DB; Fri, 11 Sep 2026 12:27:46 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E038A1956042; Fri, 11 Sep 2026 12:27:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 16:27:26 +0400
Subject: [PATCH 03/10] gdbstub: set feature->base_reg for dynamic features
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-query-reg-v1-3-0c04f0c02cf3@redhat.com>
References: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
In-Reply-To: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1027;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kqhJAQgP0IhPa8w0kge5ZBoIAHiwJHN65r8HJVeY8Fs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqo/OuB+pKOjc3VULyffQ2RAnuYKhnJ2OL5zwL3
 EenlVOGCLuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqPzrgAKCRDa6OEJdZac
 5QgHD/0V+UQQCOBslFtXfVDt88sirmYbd7ZM5TrCV+rnU37FX1LdFWaGl5G/50R5WrxbruoYoV2
 xLM7Jcwxl06nIjW0TR1KEZ0ZqDZR3VGS9y2Bp6ls6arfAY4rIgdw2oF0YRaTXhXYlE9UvCNyR3E
 SV6Tq7hMvWaUy2GrlE37YPDOh2DI3bUY69sJmFfH79R+ESlufQnV+uUJBPGQyXamvOhdQtz5dl7
 DVuE2MXeH54ujTNzEUFzXOE0SGU+E0N2DV9GmNe3KxJHXA8isMZrsrm70dP+P3L6Vxj9//wWbrn
 WztAeVmV/62fFqly6opmE0HFYzOrp704+EhTEqzkG+9DVHlHd3Hn6S1qHvz+4D9SsmwFcEUBkIA
 enWR8P1BWq5AzDfBMX9XCAnLpYu8B2zULg93s0lyqsmt3M7Wsrj5U4xWaFefhz3QJhX1nqXe9Ge
 6gVHmP9Vn3sCjl2KxpkwgZgrWacZ/KlnTSwu9FPhp+1eUyLtarEs4AGTLtOV4we435BamJi+LQJ
 N4EmGqDWuOSwk9LZUrj1Bk8emGlAIaXEgzBMulM1KOgvUF+q2feYWGqlfza0fWs4Xa9bz4LuJBy
 UXFSbMTP+bza3DD3Pacy2kz5jueNi+NV+hv0ctImTnl95IkUHz6ATN1IA4PSzrsZZmvwlkpDvvK
 T+o23qHpjqLBoyQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
2.55.0.543.g5ebe2ebe4ea8


