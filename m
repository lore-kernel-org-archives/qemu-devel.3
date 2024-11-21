Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C4CE6400C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECkx-0006Ou-MR; Thu, 21 Nov 2024 14:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECkw-0006Nd-7D
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECku-0002XV-Qg
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732216940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNGi4ej7Fg7tteZhHhZhqwNjB+z3TQfwwETPIXYXWJc=;
 b=cIYRuquorjffOkKxoSseRZRjFK7IvsweeTmUUfVcEY+Ea3te2ddXSVLTv3db6a2QCZWYAE
 7OlmkoxC/oh4krfFywvLlYCm9R9yiXiJkk7h7YyxMLrqwGwyjj5JDo/DuE4MZKyp+SFefU
 yhq//u6BorzjevkVEXIgoyqZHulIVJc=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-ymKFAnaQOB2JH-T_x_bVfQ-1; Thu, 21 Nov 2024 14:22:19 -0500
X-MC-Unique: ymKFAnaQOB2JH-T_x_bVfQ-1
X-Mimecast-MFC-AGG-ID: ymKFAnaQOB2JH-T_x_bVfQ
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a6b9f3239dso15371455ab.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732216938; x=1732821738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NNGi4ej7Fg7tteZhHhZhqwNjB+z3TQfwwETPIXYXWJc=;
 b=Ekwn3vJhEk6VdmR9eA8vbPZBpFODiY2fkJNaX9XYT8LMaF8qQEnzzVcparU/kqWJNW
 EuasaAFBykNW5G+1PJZGQc9EaFrQXP/YJZUuo/TPk+U1hrHG88lpTEMNZecXMbAQ75O1
 tmSTQY2LO+n6WFdQt6NTfOJ9SlKkesOCUv1L317yU3xLKkJZuV9KA6tW4/ON4wRZikZF
 lLgX/NtwnhA8GZn2hEKEqMJkP/dBkNoBAf8vRn034Yo6eg/FZb/n8Ar2L+GfaFTA3vcb
 bxzX6hRNI7aJTrqPsww4Afd/Z6kBxpWOmlt3cuk1N+5Efr9dob64BXQbbDsPjW+kEejI
 0I5w==
X-Gm-Message-State: AOJu0YzJWgEgpP6OMP0kqm4ShJqK0cVXTfp+nXhuh/uvyZ/9R7Xr3dQE
 GFhLbIx4GmXi7WxCRdiXusAxMYJHtTEf6hPBouY+3PGZNd23SLtPaa7nvqvTumMstRq/kvbWa8P
 lgiIPjbNM2kw+eGscxwqH0BbBLYE05KKmNEdMEFlcRGowNmkj6AOiWEGMWa6ExdxrMeTztDP5Te
 eAq1HmfLhl9TVVKPempii64aUvOerhLwz9vA==
X-Gm-Gg: ASbGnctOEa2RKLoY3SVbIkLahqz+61jyMdUOlBVRCC7aQtYkrkhymBGfPeu7QMZoftj
 D28kKi6qmS1S4EJD9yB5bhlA21js7cukv9+U840hPp38BbT97AiGYFftxryhC2TWd7R/kbsjsRH
 Uvg7KsBFhhtreByYC3jgsdqgg+LcaIq1ehDYUDZ5k9wwI1lyQv0ngZWtHszuLc6Z6by1Ltg6uAm
 NWdictGgYv22HYHnTzol8ubBr81kr5zQCjvPRARVBIO31z4sHD6G096P5eJJtD5IcjPYfKgO12e
 QUNiU5CwGtB0+m8GBlR82hTK1g==
X-Received: by 2002:a92:cd8a:0:b0:3a3:b45b:fb92 with SMTP id
 e9e14a558f8ab-3a79af36205mr2876675ab.23.1732216938009; 
 Thu, 21 Nov 2024 11:22:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCi+Pj7dPKfs3PacewTfRe6i2e4IKQWd9yM8AWlvX1od0kORirM6HVAIy/baI5mfV1pnEQdA==
X-Received: by 2002:a92:cd8a:0:b0:3a3:b45b:fb92 with SMTP id
 e9e14a558f8ab-3a79af36205mr2876115ab.23.1732216937538; 
 Thu, 21 Nov 2024 11:22:17 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfe345f0sm102939173.45.2024.11.21.11.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 11:22:16 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 08/13] qdev: Make qdev_get_machine() not use container_get()
Date: Thu, 21 Nov 2024 14:21:57 -0500
Message-ID: <20241121192202.4155849-9-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241121192202.4155849-1-peterx@redhat.com>
References: <20241121192202.4155849-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, qdev_get_machine() has a slight misuse on container_get(), as
the helper says "get a container" but in reality the goal is to get the
machine object.  It is still a "container" but not strictly.

Note that it _may_ get a container (at "/machine") in our current unit test
of test-qdev-global-props.c before all these changes, but it's probably
unexpected and worked by accident.

Switch to an explicit object_resolve_path_component(), with a side benefit
that qdev_get_machine() can happen a lot, and we don't need to split the
string ("/machine") every time.  This also paves way for making the helper
container_get() never try to return a non-container at all.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/core/qdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 5f13111b77..b622be15ee 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -817,7 +817,12 @@ Object *qdev_get_machine(void)
     static Object *dev;
 
     if (dev == NULL) {
-        dev = container_get(object_get_root(), "/machine");
+        dev = object_resolve_path_component(object_get_root(), "machine");
+        /*
+         * Any call to this function before machine is created is treated
+         * as a programming error as of now.
+         */
+        assert(dev);
     }
 
     return dev;
-- 
2.45.0


