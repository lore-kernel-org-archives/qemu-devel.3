Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E76CC53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woKm4-0006Dz-QR; Mon, 27 Jul 2026 08:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seungjung0711@gmail.com>)
 id 1woKiO-0005ub-4Y
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:45:52 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <seungjung0711@gmail.com>)
 id 1woKiM-0003gr-H5
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 08:45:51 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-381b831d535so3278181a91.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 05:45:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785156348; cv=none;
 d=google.com; s=arc-20260327;
 b=IU7Py3F09GXTF41UeAGrIYco75yYLKrmtXH7kwNsMrZOBOotKdLXpzEkXu48Cmhu0Z
 /AUD0W2/JIHWYRyPrct1dOH7weN80cR4tAc51/UZYt2jFI3sbm4y/OjffrbQYokZSgPE
 mf0oUiewlBiqQR6XdpdwVbPgkyxCUvlQ+WChEFxSSJTMlaYRVSGQCSBfndDOkb7PBe5c
 Qz+t5pxT5wu6WagcEc/2dUEN9c2qqzZtfCp41haRfrWSgLPQpwJC2c262w9xHWO2jt30
 jlVYkCS3/oAMfKWeqStuagS5qFu0zII5kRNviqcN+jww5UnQ6wtuk/T/cqwb2yHvtmsR
 TUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=wwCqdZWoKmCDiSYdlzKAqb0XbGc4aYSYnJDqLUQiyt8=;
 fh=bx5HbowjsYhp+PVwexRlaZMLSaqQzrN9uN/Ep+SDAP0=;
 b=DLGB8Iq4djGr9dG1joYWfgwmhOzVq6BJPhQf5Rg7nuw3vZl1F1iB//+/wAxMow17uy
 hjXxYJcEHQ1vtTIlEOKJ/Q6pWMkK6+tYyuCQ0tkIawvFqc6sIVeyqcb/uQ2okdy4lHKx
 ff9fD3w0HRPMtLOW6T2SH5uBt3X3/uIluZrx0wjK37ExxA+PoHrMo3Gjhe3qpFJLnW8T
 JOk7CZ5vJzJoonQqsO4KrOmQp1byq7h/a81sttFOTCbdhPOLVT86h51XkFwvZUOsiHTZ
 A/2VDNoD/CQPEr+obz+dG4loIHFwIXPaR7ms3bC21IHhaOB6WPYzf5+kGn27k8XPDiVF
 v4wg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785156348; x=1785761148; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wwCqdZWoKmCDiSYdlzKAqb0XbGc4aYSYnJDqLUQiyt8=;
 b=nRefWol2VHpIawCgOcCu5WqQfGDM/5zjGh9E6rgXnh2/P5w+DeD1vAYRkThQQqD2tZ
 +6zCOLq2OQzm8rZxTUF1BiDW0AAgQiArF9yJQTnm0WrgkHUdqFy7BfT29c8C+vMUZ60l
 KURqsk+v6bCjZ41Y3Jf6L/GsFvrW5ZoeU52XR9G8dIefnYz6eH8UtsRGY9fYMiq1mafK
 QKV9776zpiWnEnyaYwaRdsN+uq6Qqj6bn3VCr9kNaktaKMvv1dZZf+saFZNb4diwUWx7
 /ena1ZXPwDr7RGodo6RN7W/RAz/A3owa/oYeSldL0twAee1blGEAYfg+jQmKL+fx2Jox
 7WBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785156348; x=1785761148;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wwCqdZWoKmCDiSYdlzKAqb0XbGc4aYSYnJDqLUQiyt8=;
 b=ipHoztwB/mJrx2vWN7QmiXgoFxHmoUyXa5dAnq2c5PepnWw1nMvrdrnyBxsxV+nqrb
 XrgWsQknykLaOEUvCiLuWSgugkgU8hxG/uIk3JRQlcv+HV/UStQPQeF30o5tNqea5j15
 j0Kwmbl7q+U4YEmaNWQLCPr+gUHzvHqxorJ66LIBP1cMLJGidMhAaWA1qa5YxnjAzCmO
 gsR++lkmx53c49aGIkwfDtuBw93t0Xa7mOw4HA1k/JJeUXZB3zhBTWhy+aDsJPjIEszS
 qFOR5JFMnlkGZG3f8zf3ggf+R27iHIdT08P0mbYgVM8PvMEUHfz1LSXKHtles/aGSwip
 rqQQ==
X-Gm-Message-State: AOJu0YxqUKM1goO6GzlfJ+sYjOLEBhoZUw28A/dCBTuhtr4tvkan3QlM
 opSzIAMkBtY7RShN0ISX/ETP3n9gp3QecgwmhS+Lp8lo0+WNRmTrxbDGt61WLsejZoxEWAad9nA
 7vQmJ2r8P1Bx2rf22LglcYt3pvXCzkmOfcQ==
X-Gm-Gg: AR+sD10ocCmOof2TrMsFDSMWbikZM19jJwOef4icY/II1Kd2XpcVEjNCYKPRFDEycVP
 UYljuFOEW7iezGxVzUHdbDu9ctRqD6hTa1PLOtYkjYqM/VUtWEDIJIS3vwPYwRHXhr6DbAKWZyb
 6ld2JA72Yrc7pS55mIqIBE7wpiUvS0jmC2Eu/RBU/ZO2RHriCZqeK25lGn0j2vQ2s4nU29eCdIQ
 aT0dfwYH1Cvr5cl6E7lqoq12Sk5e5cHfy4xsg3zOBNxhTF2brgMKPVBpxxrN7II+AcBGdQj1H9s
 ClJM5iYFLm5mzk+y4vBrVpJMsAc=
X-Received: by 2002:a17:90b:4c8f:b0:381:792d:f993 with SMTP id
 98e67ed59e1d1-38f294f144fmr8321541a91.17.1785156348319; Mon, 27 Jul 2026
 05:45:48 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 27 Jul 2026 05:45:47 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 27 Jul 2026 05:45:47 -0700
MIME-Version: 1.0
From: =?UTF-8?B?6rmA7Iq57KSR?= <seungjung0711@gmail.com>
Date: Mon, 27 Jul 2026 05:45:47 -0700
X-Gm-Features: AUfX_my5o-ut9k4dhEC3yjVgW9VsV2jSTf20Cf_XqRevZvTIXHdZUy1epqKb3OQ
Message-ID: <CAHntc+O1jaJhj1_k6kTHDp7u_1DdPUCKZNA_AxWYh+SKraXS8A@mail.gmail.com>
Subject: [PATCH] vhost: Reject oversized inflight migration buffers
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Mauro Matteo Cascella <mcascell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=seungjung0711@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 Jul 2026 08:49:39 -0400
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

The inflight buffer size is migrated as a uint64_t, but vmstate_size()
reads VMS_VBUFFER sizes as int32_t. Values above INT32_MAX therefore
become negative and are converted to a very large size_t while loading
the buffer, allowing writes beyond the smaller memfd-backed mapping.

Reject sizes that cannot be represented by vmstate_size() before
allocating the destination buffer.

Fixes: CVE-2026-6426
Reported-by: Seungjung Kim <seungjung0711@gmail.com>
Signed-off-by: Seungjung Kim <seungjung0711@gmail.com>

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index af41841b52..82eb9407ae 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2022,11 +2022,18 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
 static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
 {
     struct vhost_inflight *inflight = opaque;
-
     int fd = -1;
-    void *addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
-                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
-                                  &fd, errp);
+    void *addr;
+
+    if (inflight->size > INT32_MAX) {
+        error_setg(errp, "inflight buffer size %" PRIu64
+                   " exceeds maximum %d", inflight->size, INT32_MAX);
+        return false;
+    }
+
+    addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
+                            F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
+                            &fd, errp);
     if (!addr) {
         return false;
     }
-- 
2.50.1 (Apple Git-155)

