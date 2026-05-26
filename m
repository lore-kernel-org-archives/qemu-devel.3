Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBD1CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 17:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw1a-000292-Fd; Tue, 26 May 2026 13:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1X-00028V-Ql
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1W-00083A-6r
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rwl60sYUdvU2FK56rokuqANsEss1jT96qzp7KeUwX2U=;
 b=CRbzEtu9kOFKPK4EmYDWvkjyfEKMVQB3CVPJr0ZaqBmOh6j4UFdO6zz1f3p70onFsGeoZp
 42Gd3kaW4gPwkKy4pbYCGy4iZtUZJNmZs42sPuTVvOruC0SQCGytCEAz9asMqhFuuw4H9o
 prNkSTDt3NjQTBykXzpbfwDUHUvu3P4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-jtg3TwA6N263jH-W2eCZBw-1; Tue, 26 May 2026 13:57:00 -0400
X-MC-Unique: jtg3TwA6N263jH-W2eCZBw-1
X-Mimecast-MFC-AGG-ID: jtg3TwA6N263jH-W2eCZBw_1779818219
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49050c44bcdso44482695e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818219; x=1780423019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwl60sYUdvU2FK56rokuqANsEss1jT96qzp7KeUwX2U=;
 b=uE8dy8waR+6vwt4OTqdZd9aEgSY7n3PZ+jDmG6ViQpqjJfPsO1xPK9S+OQjkZf3KnE
 X4TwXHnJW+3lYxM+FV2PHrJJkY+FYjV2/eF8W91BUtVB98xlLzHxMXBrVTlEu89jDmZO
 56yg0mHsb9pDku599Ga2VvQ2WWNbuPkGP6DgRe31gFXjp7rliL9eJzPbU5f1nJEgHqy0
 vztmfYMRitwvFYyzd3i+lNJkDYX0GqGXDKPk3IO1PV9Oo+t7p4aXRIfF14eJE2nVuopJ
 00MDwfmL9H43QwoOznYxUZt7ZVt7jZ9a7b3LCHYHEEMMCmMdxF7blg9jljgnyu/se/Fj
 kr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818219; x=1780423019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rwl60sYUdvU2FK56rokuqANsEss1jT96qzp7KeUwX2U=;
 b=XGryVIU0nxsJLevoHHjz8hdxe+Uly1OtIFsJr8Tu7peH/2ifsPX8ZVCVDQyHC30NzH
 Xuy1fD8EWMKo8OnC8oWbRIDOzVf9y/IkRleCkHBg1ialP11FPKhzcN0wo1mwznE/Hfr1
 GqhXlq09z6liiPxqPmFD7DPqRfGIktxa6kFO6ghSA+RmDVTOw0evbXRM62Sh/IXPAWFD
 Xl6fPKqTUG2qHGOoP11ELGe5vYiEe6iS2Gg7SVZ7LZ52YPbawsEG5/pYzk1507AKPpQj
 cml82nddagzndziAHIiDeFhSpu1W9CFSihzxIEtRM6OvNb/prH9518vfkONDKXdmhr53
 G9cQ==
X-Gm-Message-State: AOJu0YxaZJOqSzYFED68xCzZVl+OXQlOMEkcnIQ2LpL4KeY5g7EcoD4O
 B7aZSzwqgP/NW+rjPKhWCm5qubZFGt8+8oWkmPOwCpBVNyQzVQDi8UP/alqkjtwtOt22B7kv2t/
 52qqcFZ8GFQU3weXaL4TxHUg08dvInOJ3jz/Vgxx1GoXxNkwWB6RMMLQVlIQvluWzn5nfLJTtps
 DBI0ZV5cClphAehg7P3JbGuLe1MhOVDExH6hwk5CaG
X-Gm-Gg: Acq92OGUefDqImnjf+nlPK1/1yyxFWSelcVOTgwvelsp5YNIjWMe43InTJBGcXahp15
 gpH+hXtQ6HYSbOnve5PYqLClIMlzwNVDgJECJluIupP/+cF8rdoH6AoOru9rK8xbeQ624dKwvax
 j/mxNOXkgQx8NVF9dmOZeOUOKlr1+4qoOGFS1Kou0APTLWzO4oeaLSUp3DTjRFmqVahdFMoFC7W
 /C2UMvkmocY1dQFH9e91jhIz8jckd4yqeQu/P/ya1zlVdUaK1mAsoH1ihvFsgRcSkr4SZGdOxpl
 pBIPOBWkmoeCB7azEhIROTAb52Hrnt45ElQIOxDX3U7fkxXwLTVCdsGunpdKlBdQr4I2q8k3YlU
 Kfec3MH87sRgunMRAdbBqFmOCv77Z57FDz1EVSAWqMmVCNgdM1LBx9XfbyZCoTlthocMSYin+Qe
 GXQmFQ5paYeaVUisjNEx/RChSyrcw=
X-Received: by 2002:a05:600c:818e:b0:490:58f4:ba23 with SMTP id
 5b1f17b1804b1-4905c60ef29mr193631825e9.30.1779818218768; 
 Tue, 26 May 2026 10:56:58 -0700 (PDT)
X-Received: by 2002:a05:600c:818e:b0:490:58f4:ba23 with SMTP id
 5b1f17b1804b1-4905c60ef29mr193631435e9.30.1779818218325; 
 Tue, 26 May 2026 10:56:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490452765f5sm354517775e9.5.2026.05.26.10.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:56:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH v3 13/19] scripts/qapi: pull c_name and lstrip from
 camel_to_upper to caller
Date: Tue, 26 May 2026 19:56:12 +0200
Message-ID: <20260526175618.227743-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526175618.227743-1-pbonzini@redhat.com>
References: <20260526175618.227743-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Allow using camel_to_upper for other languages too.

In particular, the lstrip() is needed to avoid reserved C identifiers,
for example:

    typedef enum __org_qemu_x_Enum {
        __ORG_QEMU_X_ENUM___ORG_QEMU_X_VALUE,
        __ORG_QEMU_X_ENUM__MAX,
    } __org_qemu_x_Enum;

Insulate Rust from this, since underscores have a different meaning
in Rust (though only for the sake of warnings).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/common.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 14d5dd259c4..c75396a01b5 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -61,7 +61,7 @@ def camel_to_upper(value: str) -> str:
         ret += ch
         upc = ch.isupper()
 
-    return c_name(ret.upper()).lstrip('_')
+    return ret.upper()
 
 
 def c_enum_const(type_name: str,
@@ -75,7 +75,7 @@ def c_enum_const(type_name: str,
     :param prefix: Optional, prefix that overrides the type_name.
     """
     if prefix is None:
-        prefix = camel_to_upper(type_name)
+        prefix = c_name(camel_to_upper(type_name)).lstrip('_')
     return prefix + '_' + c_name(const_name, False).upper()
 
 
-- 
2.54.0


