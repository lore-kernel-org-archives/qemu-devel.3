Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB81606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FwaJ8Cl7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqTu-0003B8-UO; Thu, 22 Oct 2026 06:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqTs-00039o-SR
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqTq-0001Tp-O8
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792666626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jNzV6BaWVFq1+/O7YYwswt0SKLovTH7A3DMoCwLjQZ4=;
 b=FwaJ8Cl79se6ZsCicH41523+X88umq8iOccKxDbGXyURgS7ICSp7nC+dlfQpoBu45oS4Hj
 lyVQd1TwwtJgHhdN+Z7D8gsCAuLmZ4Pke2ntiUW9FqkJIE8rZtfSAteZICfyf8pJEYzGLY
 zobRnEkg4YrZsjkVgfIUtrdZU3NgrVw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-0lVj2VoDOqSAg839h2mVxw-1; Thu,
 22 Oct 2026 10:57:00 +0000
X-MC-Unique: 0lVj2VoDOqSAg839h2mVxw-1
X-Mimecast-MFC-AGG-ID: 0lVj2VoDOqSAg839h2mVxw_1792666617
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE7F11955F24; Thu, 22 Oct 2026 10:56:56 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9894546C; Thu, 22 Oct 2026 10:56:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 14:56:30 +0400
Subject: [PATCH v3 03/18] gdbstub: set feature->base_reg for dynamic features
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-query-reg-v3-3-7ad902b9a7cf@redhat.com>
References: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
In-Reply-To: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2evl28uSxci1PaCBSIw47bA24Vcvlpn1p2N5E
 8vWHyVaBEOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatnr5QAKCRDa6OEJdZac
 5cxRD/9coUpLre38IRaw8b5iPk054If8CTCdOQm/ZpNkWjjzEti1TWzQ6IW662Ratz9MvqpYb+8
 VuNslNygDFmquGrxCrKDn+AH1Bd6g7ZQ4wh9vMZudoP2dCGxf/dhFyIsyvHVBjNntulEpUcpqY1
 X0giyN9AjnKl6kjF6j5ZQe95E9kthKqGty3clm4SMOND/DAVkBS4qfY0U6KQeB6ihJi0qtprM+q
 AqHHQjwzifKGbcWFxNVwA0XNfg1L47gdgIT01cwWFKZVoS3XUKzATgJnPB0twE+kuU0LmSiucty
 R/odHak3P4VZeCGmWFcCcj26BvSZ8RGl6CCmrKFqRdVttUg38g346uJgODjCt/vv91EzTkCtLAt
 gK0yOntuLtKM7vEeB29feLU7NBjhz0L2GjlajqEaCNzV/4AsZevlVjhCx4FGnXPHbJLQkRVLIPl
 I5Luwy5JjSxB8cTsep+M/6BPIx1y42g7HTZGFsOEggUIXbCEpOKq9hDvBTTl7HqKITDsMAnjyTx
 9JcUd6OJ+KIfFNqXKSk8TGZAyd0znn6wFHV2O4eHpRl0C6D6D+UQmKCj7vkrSUxw/9B3OJCcQ/t
 nNh+50xnlOjiEj46kdasjfrFmJunlRRD3j8UMnSvw3CJdm3jS2t5Tim4zRNj2m6HMSXl0vwZSdm
 gYty5AFMeQfHdAg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


