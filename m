Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C9BCA5FE0
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 18:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCiRK-0004uy-D5; Fri, 02 Oct 2026 14:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xCiRH-0004uT-Vo
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 14:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xCiRG-0006T0-FZ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 14:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790967417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=48REw7lvlectdgG1Lnb/yP9HHfswJk3EkSJ4NxO5j+U=;
 b=Z5bDvEk6eWI5O5vWMGvFq38oEq/EEwAyT/vvR+OqBy5B9NXtTAW1seP0ebuYE/kHPOINNG
 WTr2vbYvnpbtwZvToOzFeOL6prLwlnrcMJrUTzalE0Irv1WuQIs/L/8Hp8ll3+kZMaTInR
 Z7xdN31lbiIysOda7TT/afDqI7rYl/w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-JEgqaIM4MYWhYPAOfXuC0A-1; Fri, 02 Oct 2026 14:55:47 -0400
X-MC-Unique: JEgqaIM4MYWhYPAOfXuC0A-1
X-Mimecast-MFC-AGG-ID: JEgqaIM4MYWhYPAOfXuC0A_1790967346
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a027f2e364so1146765e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790967346; x=1791572146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=48REw7lvlectdgG1Lnb/yP9HHfswJk3EkSJ4NxO5j+U=;
 b=cwBEihdK7nPQWFRc/9BK85AnI/V8qBdirRpCpde7wmQpET/U4OR4PmAxl2SFfsSR3s
 JfE+XulJN1GmxIYIZ6rPmvnrDQ1ybKZdVO+tcevzxwOC17rHaY9hakoUbqoZaREDxSFk
 0+2KEeE/EotkKAsyHrluij0ZwN76rXV4AegPuyQ5gvB0SleY2GeeDanh2n+P31Bw0IJJ
 Tbr1ED1+WWT142YE7wAN0E3x+SSz/jCVBfhtuQkghha5azfSBSZ/e8Y0sYQOHyuQujjl
 tl12XLBzCQMQYuago4NSD7IRyc/Z12EInZM1XVA/ZEHp9hm+HPjFuqsd1VmNiwofeFDI
 kUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790967346; x=1791572146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=48REw7lvlectdgG1Lnb/yP9HHfswJk3EkSJ4NxO5j+U=;
 b=Q3/bu8Zv+Q9feO6i41pwUt8vTR9gOJ0A8ccAkBPXQi44htW40E8Jnlo7BerdeEQQji
 guDkHqG19NlyARQifygw0eLnpIiZkUVT5sfIxHjQeqDRQAPJUAbHGYMg8xPUESQmGq1m
 1sjrVftooIZ6PHYqy7ptTcdIzG0OInl9lDJeQAocb3hAd1CHaK8tZC0iMLHlTMMf4FTP
 8sOSTd0kR4/h1G9H7iFCK5jsbj4AEGknsk1jYkqOjv+ODUBHWL+p1PJC4I+J/xGuAKxl
 GgzqqxB6LOX8pruSa3Jjzioyc8oGfvsBcC2dyuXffehZundEq/Tf5N3mcPB/4ShzCKYY
 1ntw==
X-Gm-Message-State: AFuF++nnhgix5tn7xfOlBlrIUqc+JPYZHAQqrvROZtmEpBGuKZkH+Nxb
 qbeC/eCngPL3Tt9SU6r0fHztJ8cIYxi72AvdYJ6xr6PX6A4wFo7zIKgSETu353n5ilJWgMp4JyF
 PNHaYbPES6P+WQ+HpUIUV+zeQGlWQBmPHmVijd3+GJoAJA8HAeOY3F2YSwQgKfpX49KW8uTnJKR
 EpqGvPgivc11po7POq0cK7zjfOU8y+kAfhgeYCyNIeVg==
X-Gm-Gg: AYBFou1vdDQ56E6D67adwyCMCFeg5AsoUqLXgkiF9I/Lb50qZiJs7YickzRuKEKS+m5
 EReWRv+GbO2s+sieKBnMH/6TXxZUDbbJFJGX5XT/kvIQFmocK/HcclBnQz8gMaXcNXlEOW0TQpo
 VF7ip7Jl4uDN/5QQDh9V4LJkaBC6/feEx5vnM5ixAENAjbNTlhmz89HaD/wNodcNSYdtApn7s2l
 3SwMYBk8VFQ7PEine+1mfUYsTxZN3GCozxCczaOjTQ8qjgajr5M/YpkfXYAGDf8N3ILNOR8jeJ0
 fkd+HA71EgDpp8tzagDScTG8o4X1zWmx5aJYToQImUNoX62be1McScpyeMPP0GtvWcI51oo1Vg=
 =
X-Received: by 2002:a05:600c:1552:b0:49b:d03:8d3a with SMTP id
 5b1f17b1804b1-4a02755f84bmr64880255e9.11.1790967346071; 
 Fri, 02 Oct 2026 11:55:46 -0700 (PDT)
X-Received: by 2002:a05:600c:1552:b0:49b:d03:8d3a with SMTP id
 5b1f17b1804b1-4a02755f84bmr64879965e9.11.1790967345676; 
 Fri, 02 Oct 2026 11:55:45 -0700 (PDT)
Received: from x1.redhat.com ([37.103.72.168])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280d924asm114636695e9.14.2026.10.02.11.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 11:55:45 -0700 (PDT)
From: Gustavo Romero <gromero@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	gromero@redhat.com
Cc: eric.auger@redhat.com,
	gshan@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH] MAINTAINERS: Update Gustavo's email address
Date: Fri,  2 Oct 2026 20:55:38 +0200
Message-ID: <20261002185538.1020233-1-gromero@redhat.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gromero@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Update my email address to my current Red Hat address.

Signed-off-by: Gustavo Romero <gromero@redhat.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1312bbd1bd..c52493ede7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2279,7 +2279,7 @@ F: docs/specs/*pci*
 F: docs/system/sriov.rst
 
 ARM PCI Hotplug
-M: Gustavo Romero <gustavo.romero@linaro.org>
+M: Gustavo Romero <gromero@redhat.com>
 L: qemu-arm@nongnu.org
 S: Supported
 F: tests/functional/aarch64/test_hotplug_pci.py
@@ -3147,7 +3147,7 @@ F: include/hw/hyperv/dynmem-proto.h
 F: include/hw/hyperv/hv-balloon.h
 
 ivshmem-flat
-M: Gustavo Romero <gustavo.romero@linaro.org>
+M: Gustavo Romero <gromero@redhat.com>
 S: Maintained
 F: hw/misc/ivshmem-flat.c
 F: include/hw/misc/ivshmem-flat.h
-- 
2.47.3


