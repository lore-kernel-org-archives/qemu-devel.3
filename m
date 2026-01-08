Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0281D232C3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 23:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdz3N-0007Bq-BR; Thu, 08 Jan 2026 18:04:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1vdz3L-00079O-IG
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 18:04:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1vdz3K-0003Un-7l
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 18:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767913464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ekEeGNhYf1wo4cndvv34o+xcugaOgiL9C4rrO036rJ0=;
 b=Jfeb6XpgOjO+JATfcw+0wtWJqkozaEtcw55wpvQYrakm9eXIKkvibzHjWtgU31s6x2jqzb
 2CRbChKF3MD9zdrKdFG73XIszGLwzOiS1ak5JOd04ZpshxHivWGxxdKIHhsDRaZjqT47xy
 z4D/hCUcvGRe3XWBfBAN+MKt5HIs1lE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-vyZbpPxkPfeMoMiOZYkzug-1; Thu, 08 Jan 2026 18:04:23 -0500
X-MC-Unique: vyZbpPxkPfeMoMiOZYkzug-1
X-Mimecast-MFC-AGG-ID: vyZbpPxkPfeMoMiOZYkzug_1767913463
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8bb0ae16a63so433169485a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 15:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767913463; x=1768518263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekEeGNhYf1wo4cndvv34o+xcugaOgiL9C4rrO036rJ0=;
 b=Jva3wNaYXRoaa+LDvXYa/U8o2MpiEp+kZQZ5XYGO4dza5neRAzOM2NHWh/ZFdvqHun
 UC8N2eBvrbEGxeptJe9G+aLle6rcbQ7LjhDo+Ld7sXM9SQ9buvzkJUO35un3zFCoxxW9
 KPIJGaZQxsit147dTrl8CpLHEo+h3yiCdmEZpT6kswfsRf4GgwRLdrFWBn5fPDjZSTcN
 QoZlegty+XGlOyeybonpdSmA81prFzQD45aaKbLKnL5Y4eyQYPnC8+ibcv85ZaZKAaHv
 IjVUyPXg9cRZYD436DjUo/lSn2DLpc767iZ3eBYsYj/tAzCWzBH2mfuNWEGNhRABVqpM
 nUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767913463; x=1768518263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ekEeGNhYf1wo4cndvv34o+xcugaOgiL9C4rrO036rJ0=;
 b=NDWk21Xf9oSxNZAuBAocZBoGdmU7Dd4pafyUuZpYJSMfKtXCjzfRnwW83qgA8czyWQ
 T3HVrd4dmrwfbW3x/KfvDZ0lXUEHlh/tym84No2Prqn17K+4gnAZvdwugroMN4xyCI02
 O6pNdTqJgF/lsfcAoHZkFiq3AtNpOSBWlFjJq4FiH+DLruRCzkFSyyl8urPOOcjR/UUH
 JOas9m0nP1Bkq1sJIvmT/EN6x1/9LOWNoHcstlm1ccs+p4DY2CE2jlOO8Oz+UhXomqg0
 M3maFQbkABgR+qD7h0LB/zNlBo6TCNUp+SBySQXsW14uFLx2LN+93TbCfmbWG98+pzax
 gWgQ==
X-Gm-Message-State: AOJu0YyI1l4L/o17i99HfGE2lqZVS98qzJS5Og7v/gM9PtFZg/sUKPnz
 rNNmr8BbV78ZKejFCIP80wWXC8OxHGNrkxsprGRPrcgao4aZS2rVWsS5PYMAzPAhtbwnVkrb4ta
 fa+3JB0jHmDu4SQrrmmzKYUcCu2LA+aVzotiilUW33xVCkReHGd5+JkOyqdku317tkFqC8rMFvK
 9GR6Od4vBpWIGILldYjhbdDnv19rjeHfnC6Y8f58E=
X-Gm-Gg: AY/fxX6abRkTyas8YIUlTXs2eXjmhaVkIHipgw1dYN7ObRe6mhp+lG2omWM2xkrQr8d
 gYrn9ggaC77I52zd10jQmJYivsjrEgaVqEzYID9yxsPZxF2/c6Czzp5va9/9yZ5bdYVDhYjODDs
 XiOXPeWCfdRHEHi4OMa3gyAwHYGuKsLlEe1vILICYWj+udgG9jWqQZ6rsXkaZpfkgKIhvQTIW4G
 Ux1kNKUdrDe9L/CsB9sRmLyFMCxBmfKSsGdf5+W0sxDlPgIXNovpULF1Ir9niE37qmtPr70kYv+
 p1880LxkzRtUCrVR+rMbaMW3jtk49ocTYDnItrZlOFRslCKVLZxCDRbjrDLVIh2H+OpjYfgf2Yq
 Ary72PwtQpW8hmiRtv8aoZiKFY4T3Di5t0Sm1Hb4=
X-Received: by 2002:a05:620a:bd5:b0:8c3:650d:577e with SMTP id
 af79cd13be357-8c38935626bmr996316385a.4.1767913462749; 
 Thu, 08 Jan 2026 15:04:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtNa9F5T/ZPQsam91EtBOSONlUmlt1eVw72/FDVleaBJ6UFyiYc3oh8d8KrXmxMjIygpTBsA==
X-Received: by 2002:a05:620a:bd5:b0:8c3:650d:577e with SMTP id
 af79cd13be357-8c38935626bmr996311085a.4.1767913462080; 
 Thu, 08 Jan 2026 15:04:22 -0800 (PST)
Received: from csomani-thinkpadp1gen7.rmtusca.csb ([47.153.136.179])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c37f51b787sm680000685a.29.2026.01.08.15.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 15:04:21 -0800 (PST)
From: Chandan Somani <csomani@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 2/5] qdev: make release_string() idempotent
Date: Thu,  8 Jan 2026 15:03:08 -0800
Message-ID: <20260108230311.584141-3-csomani@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260108230311.584141-1-csomani@redhat.com>
References: <20260108230311.584141-1-csomani@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=csomani@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

So it can eventually be called multiple times safely.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-Id: <20250429140306.190384-2-marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index c8379fda9d..aba55c02b5 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -551,7 +551,8 @@ const PropertyInfo qdev_prop_usize = {
 static void release_string(Object *obj, const char *name, void *opaque)
 {
     const Property *prop = opaque;
-    g_free(*(char **)object_field_prop_ptr(obj, prop));
+
+    g_clear_pointer((char **)object_field_prop_ptr(obj, prop), g_free);
 }
 
 static void get_string(Object *obj, Visitor *v, const char *name,
-- 
2.51.1


