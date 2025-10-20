Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D132CCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAorV-0001sB-8v; Mon, 20 Oct 2025 08:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAorF-0001kp-Qt
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:19:30 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAorC-0006p3-Eg
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:19:25 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b660019ac2aso506002366b.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760962759; x=1761567559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyxDaz5lwldS2odq0kndOPqeaBXBOv8i/KQNeFpoJK0=;
 b=Tvqx7xhw9dwL5nNGRel532e91pX/j4uK+YPi4dc06ps6kKOlyAVqP7EDiVIGQCeKex
 9RDNATd9W5+PgElhUj6pQiARTcZFlfPaMnec58LjUdYAyeTnDnzDJblxf4KzoFoZM1VO
 w1BVuNk7A/yBS6GCLiNiKV4jOrjboZhXpLbdh+iZSLfZeI4Je43+FjicziUIuV0haSxm
 oHipAZ6hWHVyD5u+ynbz2DTIvPO1evOkzSVaW83Yot8oGyr0Mw2SJSByJmKaQy2f+0CM
 hRCwtZ9t6QkKsvVJhUAL8LGqCwmfIodR63OPFYfz0lRE+h3uC+TUEo5XY0FfQDGbr5rT
 ByPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760962759; x=1761567559;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lyxDaz5lwldS2odq0kndOPqeaBXBOv8i/KQNeFpoJK0=;
 b=mRNLVyYalnQ0MbQ6GtkH0h6dfXTSbhZ1MK3y+aSf1wND9eXENO2s72ufxpGKGajG3k
 VrEHsQzG7KR4PnqtXbVrATc6YK1hKuR8dNXHRRPErGnCztG3z4r0gFBqYEbDsnlvIVmr
 3AhRKEmCTA2ULjIRxZLidktowiEZUSS+l+rJQX1EF9Zf/o3zLi/lbZMoSPd8mve30t8o
 mY0mc3mET9oGN0nLabEUhG/bW/U4GWC+PN03d6jYQdJp61cuXAmyiiDq9tk9tT8RZh8m
 Db0snYv+eRSrzHcaAK3kz80GULMNjHnCdT7F7MhEcrXze6g1uGepT0FPcbP0T50fCa1A
 5wmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK/e9pcLTQvuODFbxbPTPWYmBZgW0zLHWUnCJGAQTfp0TeqgheRmbwi+sB/woWDFJGU1ASv9TXmKnJ@nongnu.org
X-Gm-Message-State: AOJu0YxkJf/v6+N3dJuwlRkJzzVzI0BqM9M2KSJZN2Yoknep9U+HGVO6
 doWQNzPjhRIztwSySQg5NRApsICZxOIrC8LPnOJzhNOALWNImxwpgteH
X-Gm-Gg: ASbGnctedHAHPx/gsii5wIIktdyC5ubv/HqQwiGyhyGjigY4Ce1dWOsaL1RvuIF067q
 /h5iJY/bnoJMPdfRzlF1gJONbU4pwRPrcj4MUxFYQnS+y8cw9tkmAmpJ1lrKQSZCmBs4WM+h5KO
 eZCGeaoJsFQkOHtzqsbHkecfHDoLuWyazkacHN4RhawIQ4dJ1VgTUw+A9xJ/wd/lrOmnsqyL22v
 196XZ0Nx/Lz0VnsvnLThDrYytRYiqokEFPTuDf5t7LDQRb/QnhoriaPbvWUUoQ2br6gXzPUYl2v
 t3tk2E8eBLPNo2oxX92JHyWzGsCSTIKWiRDsoAg1cJDFAl89TDmzrazvNZ/14MQC0U92B4hj6W+
 FcXe2lNgsx+gVygzS1M4ZAYTeGVspOgOw6/eVCewudJ+ueaOgdLCS5zOdMMnRJkfUwb8cZcWrP2
 /kSaitmJI=
X-Google-Smtp-Source: AGHT+IHhcoQfDqHy3+AakeQGaQU+/hpIbGCmAdGZOGxGrsj7TcbBK2Efm3v7tQ2jCa19teHBfOmKYg==
X-Received: by 2002:a17:906:7314:b0:b55:befd:8f87 with SMTP id
 a640c23a62f3a-b6474f1860emr1475435266b.55.1760962758406; 
 Mon, 20 Oct 2025 05:19:18 -0700 (PDT)
Received: from ehlo.thunderbird.net ([90.187.110.129])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65eb525d1asm779197166b.58.2025.10.20.05.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 05:19:17 -0700 (PDT)
Date: Mon, 20 Oct 2025 10:30:37 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
CC: marcandre.lureau@redhat.com
Subject: Re: [PATCH] ui/pixman: Fix crash in qemu_pixman_shareable_free()
In-Reply-To: <20251013112102.2396012-1-armbru@redhat.com>
References: <20251013112102.2396012-1-armbru@redhat.com>
Message-ID: <1C757C57-9134-4C72-8034-DEC70FFD25FB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 13=2E Oktober 2025 11:21:02 UTC schrieb Markus Armbruster <armbru@redha=
t=2Ecom>:
>Reported-by: Bernhard Beschow <shentey@gmail=2Ecom>
>Fixes: b296b29d3414 (ui/pixman: Consistent error handling in qemu_pixman_=
shareable_free())
>Signed-off-by: Markus Armbruster <armbru@redhat=2Ecom>
>---
> ui/qemu-pixman=2Ec | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/ui/qemu-pixman=2Ec b/ui/qemu-pixman=2Ec
>index e46c6232cf=2E=2Eaea09755b9 100644
>--- a/ui/qemu-pixman=2Ec
>+++ b/ui/qemu-pixman=2Ec
>@@ -291,7 +291,9 @@ qemu_pixman_shareable_free(qemu_pixman_shareable hand=
le,
>     Error *err =3D NULL;
>=20
>     qemu_win32_map_free(ptr, handle, &err);
>-    error_report_err(err);
>+    if (err) {
>+        error_report_err(err);
>+    }
> #else
>     qemu_memfd_free(ptr, size, handle);
> #endif

Thanks for the quick fix, Markus! The patch is reviewed and I've been test=
ing it for a week=2E Who is going to merge it?

Best regards,
Bernhard

