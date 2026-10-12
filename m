Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222E3CA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGMjY-0003EM-MI; Mon, 12 Oct 2026 16:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMjV-0003DL-4T
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMjT-00036C-Ma
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791837291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PTTPkYhZcTXqszlszTcoD/ScoBEHuOmQgrpc/syCHeo=;
 b=g7eFr4sRLZgM0e49zstuSvhasCoSA6sjjL/9qX3Ag9Dq0W5UvgOSREBo5WJTJ8gmMaKFt3
 t9cN81BKn1QgW2yZVLDNe4DBj+WTfw6T02iBvFjiQ6KZRSii1pFKB2DUDi7u00eyd4RyjJ
 4JLMNRHdDUXYpI54vPjdAQCflfDJyq8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235--cAsVN1APfiYZ8UE1wROng-1; Mon,
 12 Oct 2026 20:34:46 +0000
X-MC-Unique: -cAsVN1APfiYZ8UE1wROng-1
X-Mimecast-MFC-AGG-ID: -cAsVN1APfiYZ8UE1wROng_1791837283
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80987193E8B2; Mon, 12 Oct 2026 20:34:42 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA077180057E; Mon, 12 Oct 2026 20:34:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 00:34:04 +0400
Subject: [PATCH v2 01/10] hmp: don't crash on invalid register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-query-reg-v2-1-6f95a2e139a9@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=916;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=E5axQ8TcsOtin8JJPhWlfcIJLYtGSyXxmVu6jnqWvwY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzURAbaVLqtPcFOAyQxeabOhS5ZvtdpW/QdlIA
 G2P5tErKRSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas1EQAAKCRDa6OEJdZac
 5cOvD/9iheeLD4/B4Ie0ayW7/9o3wMp0D6+5jaa1I1mi5I4QtJBU1jQUf1xM3fxsxR7Qw0TD8d0
 FOjZXftyQUPYWMYl2e8HAMySJxoX+VlJCQlFL9tzN4Ti8SyhxMDgS/EcYF4kHnmheXmWWL+ONoo
 q6b8tCxOCeFZOa7roKRvgMWdZ0BBUqpM1MbA1El1excFDaRdtRDspo0VGrKoK7mqlh2WuIivbtY
 keZTyNxVaQbQQbTgKbkkbTrHckss/N8HPENY3wj8w9Xd+eHhDzYuGNIVPaJ/fVvbifZyNpLdQjm
 BKvR1u/poMyp/0D7jowaz6845FuVOI2SbKiQOgBYVwp5d5XWGS6ruK/QCzNbF7oYQOThVU5NcAZ
 IGR5/bVMEn0tohnebgBvzoYmC/Bs5pfh5trh/KRv1tg6onmmLneyQVniYcJRt3K6TCyG0cHv7Wp
 ooSyPxHcJHeS6K9hxKGAOIW5ilEdd8A3oQxmnHerummTBJvOYPGOuOLNow+YKsLO9QDYteyOy7A
 Eu7Vc01xq5dsCPd5QAt01+aY8mIjyKZfPTUvFbDqhmfDRIlwuNLGSGVaHWCu6/JLzVKalwsK706
 4a0tHUDJWDdJVFM/2hdCVJjY1WmwT/blLrfIxNMvNUtIPi6a11jFeB/pDhAcoYIYppu3s+JxLNP
 e6D80+DgYJHilbA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

When printing an invalid/denied register, QEMU crashes with:
ERROR:include/qemu/bswap.h:488:ldn_le_p: code should not be reached

(ex: "p $sireg" when siselect=0 on riscv)

Return false instead.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 monitor/hmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 488ec23937df..10e19e417aba 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -424,7 +424,7 @@ static bool gdb_get_register(MonitorHMP *hmp, int64_t *pval, const char *name)
 
         buf = g_byte_array_new();
         reg_size = gdb_read_register(cs, buf, reg->gdb_reg);
-        if (reg_size > sizeof(*pval)) {
+        if (reg_size == 0 || reg_size > sizeof(*pval)) {
             return false;
         }
 

-- 
2.56.0.116.g6de20f6092dc


