Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A4EC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x50MA-0007EM-Nr; Fri, 11 Sep 2026 08:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x50M6-0007Cb-Fl
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:27:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x50M3-0006wO-Gd
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789129662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AniVVytWrOiQcAtPHQ982ORVDQ1BdQzn9xV2WxqQDcA=;
 b=P2L7EO8rYZLGGj4oEZeWTzdz/qzunC5lIoDhOPlw+SuzLMWIZBSNBmcvG7vpy18wRMiG2Z
 59MesW83Qc4kAN9gdf7OZFgTZcrVEOQdIOTJyeTjGov7fYmMeq4zH+WIaOckfqg+ghmNd/
 E3gBoSFnUfw0V0u2DUEeGmD+v98rJRI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-bEGvFzE-MfONsnHStvTmJw-1; Fri,
 11 Sep 2026 08:27:40 -0400
X-MC-Unique: bEGvFzE-MfONsnHStvTmJw-1
X-Mimecast-MFC-AGG-ID: bEGvFzE-MfONsnHStvTmJw_1789129657
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EB8019540C5; Fri, 11 Sep 2026 12:27:37 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 943801800576; Fri, 11 Sep 2026 12:27:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 16:27:24 +0400
Subject: [PATCH 01/10] hmp: don't crash on invalid register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-query-reg-v1-1-0c04f0c02cf3@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=852;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3QX4PjQNK3reEMtW/K5efwhS/4onCXsiDW/rze/VKh4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqo/OuEqP0URcbMOc7EnaFIV4n/JLtbQKGeB9hL
 s2KJKQ3FyOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqPzrgAKCRDa6OEJdZac
 5QwFEAChA/UwBEInqS/vYUOCFXMikDEtsFOvniyvQgSNomOCzikVHobPG4QNnJ/KvrrwZCRBCmz
 cWFnlCPKdVKJn+8gxBlTENME9Th+e8B1c0crt0d0JnFB4qy5dYGCcdmwMzjrDmM6Oi6gvfgI6VV
 p3pfZzmy27RKhyU6uyYfD4h9ZyqW1p1wAorqLIA1Pi4oh3fzysQO3UmwzAfGFaejKiNi/VFUW7b
 utHb7vI88tgqRHikngCfVv64X5w7+wn3VCrOmR4yYmdQZbNivdclaJJkQ9EIsyFKwaci2+f8keK
 E6jjhQMug2/ANdCtK+HxQYgc5ZsR8CqLm/8LRsljuCrssmzaJqxSLR2JXeIFtUYdnLPcetnIe4Y
 c1vecioFK7nZnwCTqOnpBrY21ILUkkn2zCT9gNKzYNnUBuzJEsfk2LxOQrTX1iJudhbT7iTMqws
 uGn8UfKf2m9crBdqXgJx9J1BsvGmC+Q2+a23kybzblbMRmha8mtDiLM53wsUPzVlrQ5dTuj66CL
 U6+MotwnYMopmaDFdd4P9yQuXEGQGsmyyuhvrdWx3dqMNL0ggIoYXPuW/Vy0aK+ygfT5Mz3g9IN
 ZZjgweIsbKhjdNRpjZOiMTuZCSgSwA/xLAmcnIYQ2P+EIPH04JDWF7l0eEr+5dpy6zEHRioDJah
 /ewTRTHTPOtWtIg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

When printing an invalid/denied register, QEMU crashes with:
ERROR:include/qemu/bswap.h:488:ldn_le_p: code should not be reached

(ex: "p $sireg" when siselect=0 on riscv)

Return false instead.

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
2.55.0.543.g5ebe2ebe4ea8


