Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11B2C7115D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 05:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjXzy-000588-SA; Thu, 29 Aug 2024 01:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sjXzt-00056b-BD
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 01:47:05 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sjXzp-0006hl-Hu
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 01:47:04 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2d3b5f2f621so189347a91.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 22:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724910419; x=1725515219;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u3FSzHTIyXcfHIxGCRaEHpptSHk8E5Ni4Ck22whaWa8=;
 b=p3YSiEiUjeSUwtb00fJ2D33ogT/gEiwHwk1eddwaP4o6S4hQcJETW4HasDINTtzOt0
 +o4saMYM9Y4FjK6XlB3ug7PnKWyueYNeCeImUYxf6iqM4moEkRafeRBY5MNP7Iu6Gj/z
 zkcq8pcQdoM1pN2TRrX/+e09jWMJd1xeSL4vk6DrzTI44TFqo5uHi/bMBCLWJxM6LIQf
 9evf4OSBExPcdaiHKad3XXc+MPqY8W42IaUZpz9yXocO40s5rS4iJ39k/SWcKmD5Af2H
 WVQ0kBlSwpVfYDMGq7R3TFPW45F0OYLGdfCWdt7tPaSa7RCw2m1Z+BasDvYOBEuao+EF
 uptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724910419; x=1725515219;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u3FSzHTIyXcfHIxGCRaEHpptSHk8E5Ni4Ck22whaWa8=;
 b=uLmYrSnte149YBR1jmhTkocd5xDH/VAJIzhgdUKRXl5OPp0s6DPwdOzuxa7ENSa8XE
 v39NX/xfxezuOF2tK+bsduYmKgon9LM21AIADjWFVuZGKIidmGz4wuraAAs7gGBQX/mL
 882klxoXMmwTsNUhgeHWDVGeV8Uw7WZZt8SHRjceZ9ume++reoyx7MaePvT6URrq/0Zu
 j3lURM5sHQn8eGnUy69XBdR2PPNVdjOM3DjJl7bbVNsnC7VLILnPgANLj4GVvdwwv6Lv
 1Z0caByEf8Ih/FKiOl5MFNqJv/3wke5v0gSFgGOi8jlBVAjdsOHQCrs63X3V98CjcuwN
 OqbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR6jbGmPVWWwNQkFqEmDsqHZyrG9bkQxMzkpzYDPB7DgzSXXyn17Xl68OaVrJqdHZxLcGPfD02Ysye@nongnu.org
X-Gm-Message-State: AOJu0YxgTNWMt8GHS820wOjq269GMHcrI4W15ke4IjZ8cI9Not1Vmu8Z
 T7KspAYvj/vW7sWV1VvecZPjxlmMgZmCGHubiMI/vDXeK/RhHGFDyk8lc18cmqQ=
X-Google-Smtp-Source: AGHT+IGVpmY4OdK34c6uPFSPLSDrHHXmZuvci/qD+Anv933tFTIOOerTzezM8zKAhaUsI5SmqgQ1mg==
X-Received: by 2002:a17:90b:1c05:b0:2d4:924:8891 with SMTP id
 98e67ed59e1d1-2d8564a502bmr1672252a91.38.1724910418634; 
 Wed, 28 Aug 2024 22:46:58 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2d85b39ced8sm497434a91.46.2024.08.28.22.46.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 22:46:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 29 Aug 2024 14:46:48 +0900
Subject: [PATCH] docs/devel: Prohibit calling object_unparent() for memory
 region
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-memory-v1-1-ac07af2f4fa5@daynix.com>
X-B4-Tracking: v=1; b=H4sIAEcL0GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNL3dzU3PyiSt3ktBTj1FSDxDQTkxQloOKCotS0zAqwQdGxtbUAkeZ
 CH1gAAAA=
To: Peter Maydell <peter.maydell@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::1031;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Previously it was allowed to call object_unparent() for a memory region
in instance_finalize() of its parent. However, such a call typically
has no effect because child objects get unparented before
instance_finalize().

Worse, memory regions typically gets finalized when they get unparented
before instance_finalize(). This means calling object_unparent() for
them in instance_finalize() is to call the function for an object
already finalized, which should be avoided.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/devel/memory.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index 69c5e3f914ac..83760279e3db 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -168,11 +168,10 @@ and VFIOQuirk in hw/vfio/pci.c.
 
 You must not destroy a memory region as long as it may be in use by a
 device or CPU.  In order to do this, as a general rule do not create or
-destroy memory regions dynamically during a device's lifetime, and only
-call object_unparent() in the memory region owner's instance_finalize
-callback.  The dynamically allocated data structure that contains the
-memory region then should obviously be freed in the instance_finalize
-callback as well.
+destroy memory regions dynamically during a device's lifetime, and do not
+call object_unparent().  The dynamically allocated data structure that contains
+the memory region then should be freed in the instance_finalize callback, which
+is called after it gets unparented.
 
 If you break this rule, the following situation can happen:
 
@@ -199,8 +198,9 @@ but nevertheless it is used in a few places.
 
 For regions that "have no owner" (NULL is passed at creation time), the
 machine object is actually used as the owner.  Since instance_finalize is
-never called for the machine object, you must never call object_unparent
-on regions that have no owner, unless they are aliases or containers.
+never called for the machine object, you must never free regions that have no
+owner, unless they are aliases or containers, which you can manually call
+object_unparent() for.
 
 
 Overlapping regions and priority

---
base-commit: 31669121a01a14732f57c49400bc239cf9fd505f
change-id: 20240829-memory-cfd3ee0af44d

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


