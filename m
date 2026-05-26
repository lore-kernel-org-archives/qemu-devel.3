Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB92CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 17:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw1O-00025V-22; Tue, 26 May 2026 13:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1L-00024G-UZ
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1K-0007y4-01
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+AGiBNwzTm1U9cZQLheRtuzZRE/8QtBdPokO2fQmR6g=;
 b=LnvqHygsd1jyohO4TRyGSHus+mrHAmkd54UNOSJovnQJ9t/ch9sfaM4oTYyObJzSI8s9Ja
 Zvo0Uw6wRlPM6MG1x2RG+TwHmv1J5LewQJWR+jd/bKpzjq66OPyGNf5rrft/VSbutR8yHi
 yJTdSJwunyTq0izKwLszKl83zhvEomg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-QHgF-NfiOA2LBkwo-nG82g-1; Tue, 26 May 2026 13:56:46 -0400
X-MC-Unique: QHgF-NfiOA2LBkwo-nG82g-1
X-Mimecast-MFC-AGG-ID: QHgF-NfiOA2LBkwo-nG82g_1779818206
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4411a2c034fso9936558f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818205; x=1780423005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+AGiBNwzTm1U9cZQLheRtuzZRE/8QtBdPokO2fQmR6g=;
 b=Iu0XRWMuU71By9Iw040a8/ZC+koqyrPXgcVJv7Z41mt862CIq5dzJkWGPL/t4q0gcF
 6wHKQMRk0TxE7Pql+TdvtRvvec7LZIi9Eux6SxXUo6kVoIhia1vzbEdFUMz7YztqxYBC
 GsnDlrXAxWAuRLOKEi2tFlR0u+ONkOLOnDsLv72rMCreZpF6WrqZFp4Mhcp9X5Pjoz6W
 8uPitjScbqCfT8U3UL5d/Sf23eQ8yLG+fnlxOwGvZdtFkZ3QHze/4pAhbsXkine/Fflt
 888uthe116uULOahSXS3FIfHLmn37DmhMXLCaLUTKEKcPjSQXkiwQLjd5CrnlfV9vDPL
 uBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818205; x=1780423005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+AGiBNwzTm1U9cZQLheRtuzZRE/8QtBdPokO2fQmR6g=;
 b=oVQt7JPDWXKuhEXInNSoKU7K5tugI8twU0m2CceCu/Doj0s+EbTCogPpri3hra0516
 tWCvkixzVntmgXU1SdEG1588jlZzD03I+CZZJrFT0nB1sGbQHJQzm9FcgCwtPmHi5wEn
 t1eCMRnAdTjrVvF5iGWOSA0ob20P93JwrawENDZyVOuRgpZ+Ms8fWjOtUF/JCeTeKJYl
 KXWONb+c0O+DQSx6BYQCge5owHFd7oPoAcRRttSCTRGJrwQ/IgNAj/MnH3xnJTiC4X3H
 0OCVe5tflGhTyVi5OvLtI/+d5/gNCdoDwkO5Ra7B/21c+a9kQVsPFfVFNNgR0RwIixR4
 S9iw==
X-Gm-Message-State: AOJu0YwQrghOMN4W0Rxxp1nJA7b5xmmy9r6LiM6POSmGJKn/igydsiGL
 wudYhqlQraskAoBZhTGy0z65jVrR1wI+XfiJOiJX8/xqRrwkUeJ22SKVCikPNqxcaBORPrmYSn2
 bA3xxQkroCFXjEfWgchpAOOXLd0U36in9uVSLni/0Nll6T0HraU3VxI+GBuJDmSvHoXsY5KtpUw
 ZmpA7ubLl2fLi1CGVKMBxl53Mq05SHdRnqEiU7hiR2
X-Gm-Gg: Acq92OGp0W+gC8b0AO8f43UmaY+934Srf/D2VuQq7KvngZ9Vh7zltGtsX/ERFOoFGRb
 guZR/mSZgHyb0lCiQx8eT51COS/2kqxqvu6RG7xPLhDzwSoWuLV8vDnhO6oOVsWBggjcTECSbHU
 3wiOwRadYkPdehX6RIrjhyjQiTJPpH1Tqivzvf1LPhP8CF9XniJNtA18CC5HZzNxcdh0d8f0I9q
 d9aG576iPAlNCL5Zcp0Uw9KbzkTCubFz6OpWLHi+dQSkiSgdmgBVMrt5yTi3oBjPo3ufXKtT15S
 dHP+I/Zwg59wy1AqGSBBtxsHLtElCk6D6hf6HhKfigZagNDciN88laIkE7MUVwRPOb/IFzWTbc+
 gVcfrkGu/UCiZpNp9EK+XyK2xygkwWB66RouKLGJHb9qd0pg6/rciP4MXbpZwTYbTFLbIyfPCje
 949+erocdZJBnKEutPDCmgOjHJcdc=
X-Received: by 2002:a05:6000:4308:b0:449:a07a:9676 with SMTP id
 ffacd0b85a97d-45eb38c1a3fmr36810708f8f.29.1779818205623; 
 Tue, 26 May 2026 10:56:45 -0700 (PDT)
X-Received: by 2002:a05:6000:4308:b0:449:a07a:9676 with SMTP id
 ffacd0b85a97d-45eb38c1a3fmr36810655f8f.29.1779818205137; 
 Tue, 26 May 2026 10:56:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4903bsm34573469f8f.21.2026.05.26.10.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:56:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH v3 09/19] scripts/qapi: reject empty enums
Date: Tue, 26 May 2026 19:56:08 +0200
Message-ID: <20260526175618.227743-10-pbonzini@redhat.com>
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

Raise an error if an enum has no members.  Such enums cannot be populated with
a valid value.  Do not extend the same limitation to enum whose members are
all compiled out; they can still be used as optional members.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/schema.py                  | 4 ++++
 tests/qapi-schema/enum-empty.err        | 2 ++
 tests/qapi-schema/enum-empty.json       | 2 ++
 tests/qapi-schema/enum-empty.out        | 0
 tests/qapi-schema/qapi-schema-test.json | 3 ---
 tests/qapi-schema/qapi-schema-test.out  | 1 -
 tests/qapi-schema/union-empty.err       | 4 ++--
 7 files changed, 10 insertions(+), 6 deletions(-)
 create mode 100644 tests/qapi-schema/enum-empty.err
 create mode 100644 tests/qapi-schema/enum-empty.json
 create mode 100644 tests/qapi-schema/enum-empty.out

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 8d88b40de2e..78c2a25fc9a 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -428,6 +428,10 @@ def __init__(
 
     def check(self, schema: QAPISchema) -> None:
         super().check(schema)
+        if not self.members:
+            raise QAPISemError(
+                self.info,
+                "enum '%s' must have at least one value" % self.name)
         seen: Dict[str, QAPISchemaMember] = {}
         for m in self.members:
             m.check_clash(self.info, seen)
diff --git a/tests/qapi-schema/enum-empty.err b/tests/qapi-schema/enum-empty.err
new file mode 100644
index 00000000000..6070bf62cbd
--- /dev/null
+++ b/tests/qapi-schema/enum-empty.err
@@ -0,0 +1,2 @@
+enum-empty.json: In enum 'TestEmpty':
+enum-empty.json:2: enum 'TestEmpty' must have at least one value
diff --git a/tests/qapi-schema/enum-empty.json b/tests/qapi-schema/enum-empty.json
new file mode 100644
index 00000000000..3b3dfb2e3d8
--- /dev/null
+++ b/tests/qapi-schema/enum-empty.json
@@ -0,0 +1,2 @@
+# An enum must have at least one value
+{ 'enum': 'TestEmpty', 'data': [] }
diff --git a/tests/qapi-schema/enum-empty.out b/tests/qapi-schema/enum-empty.out
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 8ca977c49d2..195f1c4847b 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -23,9 +23,6 @@
   'data': { 'enum1': 'EnumOne',   # Intentional forward reference
             '*enum2': 'EnumOne', 'enum3': 'EnumOne', '*enum4': 'EnumOne' } }
 
-# An empty enum, although unusual, is currently acceptable
-{ 'enum': 'MyEnum', 'data': [ ] }
-
 # Likewise for an empty struct, including an empty base
 { 'struct': 'Empty1', 'data': { } }
 { 'struct': 'Empty2', 'base': 'Empty1', 'data': { } }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 4617eb4e98a..ddd8bf80d66 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -18,7 +18,6 @@ object NestedEnumsOne
     member enum2: EnumOne optional=True
     member enum3: EnumOne optional=False
     member enum4: EnumOne optional=True
-enum MyEnum
 object Empty1
 object Empty2
     base Empty1
diff --git a/tests/qapi-schema/union-empty.err b/tests/qapi-schema/union-empty.err
index d4284399621..c07dcf32a5a 100644
--- a/tests/qapi-schema/union-empty.err
+++ b/tests/qapi-schema/union-empty.err
@@ -1,2 +1,2 @@
-union-empty.json: In union 'Union':
-union-empty.json:4: union has no branches
+union-empty.json: In enum 'Empty':
+union-empty.json:2: enum 'Empty' must have at least one value
-- 
2.54.0


