Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B651ED185EF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpnX-00084q-Rl; Thu, 08 Jan 2026 08:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnV-0007uW-G4
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnT-00083P-CL
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767877886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0E5oaa3MQAn5B2LP1tawJrB7fiKlLEpjdtNPCmWmE88=;
 b=QrOcyNKcZxVWdsizXLHbmrHP2CavuAsb1Loqm+WpdGFvLiCZ2WiPrOvx8OWe4apyuPVcCf
 KIp5KdNG+7USERc8KJBR5oGeEPtBHhCfRJJ25ltGJOfCq79iv+e1f7rtlqmM1nxERu0aN8
 Na95J1az4Wlwat7XxK8a+7Z7UsDChWM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-ELlq0_tvMayRkvZVl1v-vg-1; Thu, 08 Jan 2026 08:11:18 -0500
X-MC-Unique: ELlq0_tvMayRkvZVl1v-vg-1
X-Mimecast-MFC-AGG-ID: ELlq0_tvMayRkvZVl1v-vg_1767877876
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47d28e7960fso35947975e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767877871; x=1768482671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0E5oaa3MQAn5B2LP1tawJrB7fiKlLEpjdtNPCmWmE88=;
 b=OJuYeurXGa+IkSAPshSs52qR7qKTfInqZXu86zUglLOSvYhn8l4Xs0d/DJQM3FYlGs
 bZqXxm6T8PPS5iM3ZATNAxPou88H8Q6GwfqX5rU+luabhiX7vXKRGl6aNG1j8AHSo2Fk
 FrHhhaTuGc6QFRjZitrCSKJN9D3/ZAMVgGwRgi56MlTDWe9MXSuAlMKuOAoY4jEM2heX
 Y5KSwBO2TjQA8dAxX4CtSsDzA1+BlEyZ4HxSVhDkGp1BvCklmtr+CP1kGaKiR5a8EB89
 n2oS8vSOpMQwhIZHc8e2Wsi0uchtYxrTu1jiVDYOqfD+eRxgmit741zuI+Jk6JKW1fyt
 9eAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767877871; x=1768482671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0E5oaa3MQAn5B2LP1tawJrB7fiKlLEpjdtNPCmWmE88=;
 b=amAKsLL1B5OQgYStFumMH3b15zpsTBYYhPBCgC+/RLkXDCRZrjgFDl0/BjXHrs2fBk
 j5uErK86T6rpJeD7gLMkoFBo5r4P0F7WdoNkgGEfXry3Oh7HnGsoTt9ywwIQcJ2lDAo3
 PFLkOhnSsSMqzuOVzKRpTU6lYg11e+FR1FyUWLkr/QfQgcXSQkt5hSa+q5L/1IhlpTIz
 HzXZ88oAmgzDeVd4q7ndRgSPeacNqhxqP3MGt1Xmzqw23vd/3/oN/lMe8f7TtnlMQmgF
 Zoc0Ve664c2UmzChx1OgGwTOpEIGKRLWaJ53TO8XraUvuK1AwTzygSvV1icFKVt4QQ9U
 sUYA==
X-Gm-Message-State: AOJu0YwAaNrtSJDl9KBzaDzEUDpw0pOjNXEhKWswrfuvqQLvS7NBRiLy
 8cNK2DnSIk3BJfW+oMDGvBBdxH9ooL3HtBEN5FAOVI9eAR+E9IglJGHvS0soa8ybQL6I6QZ6qUD
 BmgmXXSYjUmh4a26r/DYoAD+IJ76Q1dZ/ZqswZkUaj6QDOgFTM+QHJ5xiAXyYG5ClfNZOab8Iqq
 RY0ETYcoILybB4gMiXDKCEix4WfFSUAdyFjuXLnfNS
X-Gm-Gg: AY/fxX5wdhY3xHAXg+m8mqcI8TLetzOQPilxcuNvY54HaVbGtrC3ZdiR2qJqUkgXP1j
 upo6UqpsqQB8azpUJgjSl101zPKpBJViq3y7wnewm3tn9tK7DAJaIz8Zp4QeLMlM9uxqXI5YMPK
 dBZ+Oo8S0xXDqCxeDnwgdputg2XJYqwl8HjCF8tFceMhoMA1Y95L24DEXC37EwjDp/n7Q3OR0sO
 HtWQJDO80H7zcfXp2s36ci0wo68+LC4aZoOvAZq6oi1PHjRYgWnIWTQK9f2cAw92eveFT2T3o9I
 nCt12uvHtiWyaRCc2IPw1tEoSEnj/QUbbE51HzxY4yVRR2Qh3uPgNmKitOEGXgnjJ++6Fqa+RGX
 fx7RoQZmKuG6ULlbOg5g/SnLM+pki1vP/0QoBkvAwuyG3MDJE68lOvkYbLkidpzLJRYHzsJFg5J
 MjVQDn8g+W9rvO/Q==
X-Received: by 2002:a05:600c:3110:b0:47d:3ffa:980e with SMTP id
 5b1f17b1804b1-47d84b4101dmr63206555e9.28.1767877871238; 
 Thu, 08 Jan 2026 05:11:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEORBF3pH9Z8JBQv2ifgXj4MTlDYGlTPRH00T6XtzFVSNi6ECYe8urA1hTRN7/M++9RelRR7g==
X-Received: by 2002:a05:600c:3110:b0:47d:3ffa:980e with SMTP id
 5b1f17b1804b1-47d84b4101dmr63206255e9.28.1767877870746; 
 Thu, 08 Jan 2026 05:11:10 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d87189e54sm36061825e9.12.2026.01.08.05.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:11:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
Subject: [PATCH v2 09/16] scripts/qapi: add QAPISchemaIfCond.rsgen()
Date: Thu,  8 Jan 2026 14:10:36 +0100
Message-ID: <20260108131043.490084-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108131043.490084-1-pbonzini@redhat.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Generate Rust #[cfg(...)] guards from QAPI 'if' conditions; it
turns out that they are very similar, with both of them using
not/any/all, so just walk the tree.

The next commit will put it to use.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20210907121943.3498701-15-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/common.py | 19 +++++++++++++++++++
 scripts/qapi/schema.py |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d7c8aa3365c..14d5dd259c4 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -199,6 +199,25 @@ def guardend(name: str) -> str:
                  name=c_fname(name).upper())
 
 
+def rsgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
+
+    def cfg(ifcond: Union[str, Dict[str, Any]]) -> str:
+        if isinstance(ifcond, str):
+            return ifcond
+        assert isinstance(ifcond, dict) and len(ifcond) == 1
+        if 'not' in ifcond:
+            oper = 'not'
+            arg = cfg(ifcond['not'])
+        else:
+            oper, operands = next(iter(ifcond.items()))
+            arg = ', '.join([cfg(c) for c in operands])
+        return f'{oper}({arg})'
+
+    if not ifcond:
+        return ''
+    return '#[cfg(%s)]' % cfg(ifcond)
+
+
 def gen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]],
                cond_fmt: str, not_fmt: str,
                all_operator: str, any_operator: str) -> str:
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 8d88b40de2e..848a7401251 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -37,6 +37,7 @@
     docgen_ifcond,
     gen_endif,
     gen_if,
+    rsgen_ifcond,
 )
 from .error import QAPIError, QAPISemError, QAPISourceError
 from .expr import check_exprs
@@ -63,6 +64,9 @@ def gen_endif(self) -> str:
     def docgen(self) -> str:
         return docgen_ifcond(self.ifcond)
 
+    def rsgen(self) -> str:
+        return rsgen_ifcond(self.ifcond)
+
     def is_present(self) -> bool:
         return bool(self.ifcond)
 
-- 
2.52.0


