Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3A8CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G9I-00015J-9a; Mon, 29 Sep 2025 11:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8d-0000jJ-4E
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8P-0000K7-4y
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759160989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YG+Kj4OjUTaTT7jTstOf3QwSS6l76vhdq2cWEryDBwk=;
 b=CDuOFUtD0gjhrCx3Xkg7ZKw28nosfrtHRBYq+ewN+2rv5393f1xpL8P84HjZZsz7q0cT76
 6Xa2BG5cCKMtyjfPUItLkuf422ZBo1txTbo+VxLrmU1y2JjcVc0KFFKgU/GZk5Dfyve9gl
 mFcdOOXmIJxsWinRQoGExAXUzd5C9gE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-b06jOwYNPySgIoI6Y6dCJA-1; Mon, 29 Sep 2025 11:49:45 -0400
X-MC-Unique: b06jOwYNPySgIoI6Y6dCJA-1
X-Mimecast-MFC-AGG-ID: b06jOwYNPySgIoI6Y6dCJA_1759160984
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b3f2cfc26edso106279266b.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160983; x=1759765783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YG+Kj4OjUTaTT7jTstOf3QwSS6l76vhdq2cWEryDBwk=;
 b=CPgWAKp6w++t0fQWKox6u3bcVGAjHhg52cxphcfjpFhG1EdWU7kGjHYXRHFl727G62
 vAkUi2DKDR4WGwmOobDQJwHm4In9e7zBK9m5HJDtYiroRs2qkJkpT+cT4CtHH7VNqRwC
 D0gn2V3MTR6mqkp10C2TDaf2tmwheW5UHIUOMdZJs23yUfS71icMbM9ZyaoJWdBHoQ+Q
 V00KPfGdfw4AqktFj2ZZcDNlUuHaUlUR7rrbwULsu5JnMEnXKuecqYHC1jUN6Z/CraIm
 MmF2pdHWku/gqIYeJg9tyavw5ZqYuhMlg7TWqB/FyussZwyY9hL1h0BJwsmcDLpUSX5R
 KKMA==
X-Gm-Message-State: AOJu0YwQTbap5AqvBZKIgemrmCDVZT3yoBDNSlwpdlDKaS3Su3ZZy8vM
 ZavBQQcMSBOagyOtkp0Bbn53xF7GfTWDHewVtn6RaX/h8oH8UrjOAGghIW8Xisoz2LSJ3s865gM
 YYPe1zosnlYxnfo0iVu3ZAm6oad1e6bDbYucOOUnbcba7f4oK2xQBSXQxscO1dzwNjgGLdU3KuK
 zlH/zEvzGZC9/aixuczcL6yDXwv2hkzyaLHaaJtOnX
X-Gm-Gg: ASbGncvouYa6XHCe0qsn9JohHQjzbBA4lRplwjGekilWyM8+tyGjQU9yG9ea8Yjl3D9
 QYelD2SwrgCSLMb9TctO+BFeLz1gENwcyq4SBQkSPpEzU2oq15LADt1qFDeu443XO0C/yhv5g6h
 C8h1OiNgWsfCscYFNBh647PUAyB3UaVdaP74N7aPwnC2LibYqfXkui1WvYTOQ2Jzr67/T/T2ouE
 ndStJx/GlLIvaRo+BMyNmBooKPPTlIj8GdYFAIHGnjX7iaAeuV4qmXJniMGq2Trfy18MdKOz5Gg
 uVNaviC0XptO1GFvrotZpyWAh30Y1Y078saVTbbS0FY61Weehtw6YpmmOhTWOURnhX3vJETwFEy
 o8LffdxoDFB1AnXN5ghcwHEKMldH6CoGsFyGifeHphc8Lvw==
X-Received: by 2002:a17:907:1c95:b0:b2b:2967:5550 with SMTP id
 a640c23a62f3a-b34b684a607mr1735538966b.5.1759160983459; 
 Mon, 29 Sep 2025 08:49:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkRZw+cjfBjzE0zBl+cVMYhsnOi4WHvU6zVQt1fLSJa6I869c6OpqPg8aJnTuvr3X9qp11FA==
X-Received: by 2002:a17:907:1c95:b0:b2b:2967:5550 with SMTP id
 a640c23a62f3a-b34b684a607mr1735535366b.5.1759160982983; 
 Mon, 29 Sep 2025 08:49:42 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3d27759835sm326470166b.13.2025.09.29.08.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:49:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: [PATCH 01/16] tracetool: fix usage of try_import()
Date: Mon, 29 Sep 2025 17:49:23 +0200
Message-ID: <20250929154938.594389-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929154938.594389-1-pbonzini@redhat.com>
References: <20250929154938.594389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

try_import returns a tuple of a boolean and the requested module or attribute.
exists() functions return tracetool.try_import("tracetool.format." + name)[1]
but they should return the boolean value instead.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tracetool/backend/__init__.py | 2 +-
 scripts/tracetool/format/__init__.py  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index 7bfcc86cc53..6c6344deddb 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -94,7 +94,7 @@ def exists(name):
     if name == "nop":
         return True
     name = name.replace("-", "_")
-    return tracetool.try_import("tracetool.backend." + name)[1]
+    return tracetool.try_import("tracetool.backend." + name)[0]
 
 
 class Wrapper:
diff --git a/scripts/tracetool/format/__init__.py b/scripts/tracetool/format/__init__.py
index 2dc46f3dd93..042fe7d103c 100644
--- a/scripts/tracetool/format/__init__.py
+++ b/scripts/tracetool/format/__init__.py
@@ -70,7 +70,7 @@ def exists(name):
     if len(name) == 0:
         return False
     name = name.replace("-", "_")
-    return tracetool.try_import("tracetool.format." + name)[1]
+    return tracetool.try_import("tracetool.format." + name)[0]
 
 
 def generate(events, format, backend, group):
-- 
2.51.0


