Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0CEE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 02:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIes0-0003xN-Gv; Tue, 03 Dec 2024 21:12:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tIerv-0003qa-P2
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 21:12:00 -0500
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1tIeru-0005Pf-2L
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 21:11:59 -0500
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6d89dc50927so20473026d6.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 18:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1733278317; x=1733883117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mmBF5CVSuEv5Hs4OjTWSCjE9+8hQXVfJDcSidunhtM=;
 b=POw/v5ilRghSPrErURBmS+V431xPFb8cbsx3s918pOTBsSRcgkYZHksMnpqmsDuZ4f
 E+ixJWTaxaYowFIKgLqNHzrXM6cRqfMEYdGqE0+usB0PlmUDDJI3Lvizu0azbfK5bAAa
 VTKXh+jR3VGh78JmmaFh8gUNMJ8IbHiordzO4e934W37XZGMZFaA41Is95YpLaiVnucR
 FGq2b9+4MHwwUByNwepWf2X6B4a7ei2lKluXmQgnTxmJHw/G1RoFJy6sOlnfqzzQpMsm
 H6765RDuCwmUuWA81OJnwdHVjNKW75I0Bt6RrwbnubjBj2ykJx2iV7r7LcOGvI80WyZG
 TYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733278317; x=1733883117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2mmBF5CVSuEv5Hs4OjTWSCjE9+8hQXVfJDcSidunhtM=;
 b=TFxsRxRoQYpIZzQvDkxTcHpnFmOo15Q4ln0bBaUmKov6rpOwjNPaOeUSY3EL542+X1
 wR3qL3E8ZJyQ8oMa4zboeY6R7v49z8XZCu58nkPsxOnzG8EZ4zjS0OjqUYOXlqGZ7qYZ
 4MgQqrImCzziN7IJxrxKvndgrz89YsPb7yTC5n/wlgLOKQdtwmuqNtnKu80JWfC9lSWe
 OFySaHTyPsURUw+5JZQD5jgvtVJUEyNBZdq++ZF3VHelbNDY6AjcOXxDQTw+Gkprc/im
 Ryb7CBDazBmx2kRS8noHWuSUKfzRNlDV6pv+fXcJbyhWdBEHG3FwYbnH/m+qy9aLVDYX
 /siw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3hD6otX178w5uSH7UubYjPTyXkWLCeToanJm9cozrKe6KVDiCoVJaSwCd7pIwlySKrxars4/SH2Hy@nongnu.org
X-Gm-Message-State: AOJu0YwF3lImCAs7iasC8vTJOscUV+u0NG58eLmSzc8KZB8NgLrkf/6f
 Mnxs0dxrOeeDpZP2mO5+dZSoRvbU70t7vB4zIVHxZr8X6nvwjpIGGUnslg/9nzE=
X-Gm-Gg: ASbGnct998Pk/T8Hu3+M+BK4Qys/1SqE9Oc6LtudVG7cDReXeoBswVz5VPvCvSdENP2
 htq6VP5bfMc0TDRsadAgI8CLtqp6b9nek/mFXoOJEc8Ub0+D4fWOWz1rdjhhlxllbw5c2FERnfW
 x1E6rooj8nxj7BXtc7TapzOgrSLMZZFXxpyfrzC0C8TaaOgbsj4kCLuqTEgk+KRbR5Mv6HLhpO2
 jJXv7nQSNz6rQCPgrKgP9cbIroHAXl014clkVxbiU2CDK+MDT8dUPOs4XdCPVmo9dpbCR7jU6xA
 ncsOcuVVv9zEPvLZuw==
X-Google-Smtp-Source: AGHT+IGmXEgJ4230AasQ3H4vQpPTWDlSZa90avoi4T6n+fgxO/Ox8pgZDTVShHskOSyN645mUvfy0g==
X-Received: by 2002:a05:6214:529a:b0:6d8:a570:faee with SMTP id
 6a1803df08f44-6d8b737eb6emr80611826d6.16.1733278316901; 
 Tue, 03 Dec 2024 18:11:56 -0800 (PST)
Received: from DY4X0N7X05.bytedance.net
 ([2601:646:8900:323:644e:288b:2b6d:d94c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d87ec537ebsm63488986d6.30.2024.12.03.18.11.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 18:11:56 -0800 (PST)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Shivam Kumar" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v8 02/12] util/dsa: Add idxd into linux header copy list.
Date: Tue,  3 Dec 2024 18:11:31 -0800
Message-Id: <20241204021142.24184-3-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241204021142.24184-1-yichen.wang@bytedance.com>
References: <20241204021142.24184-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 99a8d9fa4c..9128c7499b 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -200,7 +200,7 @@ rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
 for header in const.h stddef.h kvm.h vfio.h vfio_ccw.h vfio_zdev.h vhost.h \
               psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h \
-              vduse.h iommufd.h bits.h; do
+              vduse.h iommufd.h bits.h idxd.h; do
     cp "$hdrdir/include/linux/$header" "$output/linux-headers/linux"
 done
 
-- 
Yichen Wang


