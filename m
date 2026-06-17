Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3CACD98F2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrIa-0006hY-Iz; Wed, 17 Jun 2026 10:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIV-0006hD-GE
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIT-0007pC-MK
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bNIHpR9IFlXY0dlvDQpu7gjzQcEnusGYAFFIvpgdOpA=;
 b=PEcbeKow08e7IrVFn8Pbwr64MfNODMVA04Qp4JbNhpeUg1UPybz8D87uXZlPID9ebYUEWV
 FtRPNPdXTG2W4PQYUqa1TZiJ7Etzz4Tdo5L6Ogu5fr4fzc9p+jdrOYRzWHw8hunuif3Wa9
 +e9yLYS0rxds0C8jJ7/8FwWOTVklkWs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-vqR4QzDwNDSYkbKApcobeA-1; Wed, 17 Jun 2026 10:31:13 -0400
X-MC-Unique: vqR4QzDwNDSYkbKApcobeA-1
X-Mimecast-MFC-AGG-ID: vqR4QzDwNDSYkbKApcobeA_1781706672
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b93debc8so56438015e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706671; x=1782311471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNIHpR9IFlXY0dlvDQpu7gjzQcEnusGYAFFIvpgdOpA=;
 b=nopz0lwDFwJPS9SIzq2nqm2KXtiOuucchiOMq/TygJ+cNXq+LWcWe95Jh5NMeA4l6d
 cemJ+jE5kKGeCSo+nv8WjbfhzB90XwKJcOuJOaHybNKk9yGw+VmgXyYYQ7OwbHpnYXH7
 j32kEbVWYET7oHTmbA2ZrKiSnsXDpzD6AXGFfEdAACyx8qNp1fLMNDr6NUECkvzh5h6Y
 S6825S4DtnINj28DEGeTKt9XA9Jh3JYD3agE3QKUEMnQfVvCvJpSvOW1n34DCuLZQlX9
 WLdKlKvNCWGuOWf/cYYhlTXKuklYT5d9/x/uiioOXONLyAhGEu2HZh/kYZN2hAbJ3KPv
 Tgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706671; x=1782311471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bNIHpR9IFlXY0dlvDQpu7gjzQcEnusGYAFFIvpgdOpA=;
 b=fnpIQRFXaKvep/kfKRZJOt0/9NMMAZAK/Cux29McxIP4N0VWUpeMmcQBctFhCNBuRK
 KG/cUFIP48ALUk/Tv04oUOFLxzFy+d/7IuIXWvPjGPyfyNmPgpjnoeojED4n/wbmO0Jg
 kZ84QegAxCVqyTjdfUwycaPryXue8EcJhLz/XV5DxCnV1oOsJGVcWW8rErcFMr0bujFQ
 L/qmFfOoevXqwZbnbmlzw+RBZyQwm1Z1JYO6bpw+vd6R9Wf81GOwBLUKCJfFeCq7duY9
 oFJTTUpxDi6wQOEMwEbC1PdnF3n9sJ8QhYewKYOOQcP0t6dGbotWRaY0gTXCAdCzL+/S
 QFkA==
X-Gm-Message-State: AOJu0YwQK1q3yCZfsOMFrM44RRXX7ixqc81J0g/SFGGqNA2mt8e6iIZ6
 EsKqkVNTuO4X5UkRYSwhShN5kjkg1HIxeCJGtdD2wMMsJ6dKkU334PU8REtcMy5SoUV7AKW2ops
 kNul3QjXE/Y1J9kO7BX2LnCR4InUFO8WS7FjtEzKWSqF+Smr3Pf0KRChp4VoGbwRWTtMOIRCqUf
 6RhQTRSAqrLFfN6b1SAZK63LXg8b9HrxD996k7Fa7w
X-Gm-Gg: Acq92OHltMVUgSNbXlhTmuSyiGSwN0QOIzUD8DyHvwang15e9pHMVtteMe6jeKeMwuk
 tPdiSG1Ky6noiMTCgKm7oFoUZm9nSSD15GqxBcR2p0OhqkqLEVN1TIagtk8z0ZMo8oxAtn9/WsI
 TSPOjANtuDgvP1Q+6deVi6jiont4ohouwN15MKEXFNHBDiQc2/eQVC6q9QzWz44k8iFkyWPIRkD
 fAm6QcOBPkTWHim2mwyooHqoM1qRhj/Cx6qTEH9eemoezzDPY7/u0NfpqwykhRaOGlTNE6oHrep
 cWiPUnDjHHmEQrGElRBkKMQmQ1UVultfvUwlDcmHaHP+nejVl+j2J8AzN02Bffo3fLcdElhTBTi
 ypkgOtTl9NqTrmdxPuw6E3ZkI+nKoh7nDWGejLsrnMe44phb/m0cJE+HR+c+JPAj5jIJaZzaAGP
 W82TOG8kaIdqy/b0tQ
X-Received: by 2002:a05:600c:c113:b0:48f:e26a:1744 with SMTP id
 5b1f17b1804b1-492333bf7efmr64477375e9.9.1781706671310; 
 Wed, 17 Jun 2026 07:31:11 -0700 (PDT)
X-Received: by 2002:a05:600c:c113:b0:48f:e26a:1744 with SMTP id
 5b1f17b1804b1-492333bf7efmr64476795e9.9.1781706670739; 
 Wed, 17 Jun 2026 07:31:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4ff67sm164433035e9.6.2026.06.17.07.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:31:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Damien Zammit <damien@zamaudio.com>
Subject: [PULL 09/16] Make copy_file_range non-static on GNU/Hurd
Date: Wed, 17 Jun 2026 16:30:39 +0200
Message-ID: <20260617143046.445322-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617143046.445322-1-pbonzini@redhat.com>
References: <20260617143046.445322-1-pbonzini@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Damien Zammit <damien@zamaudio.com>

glibc has a stubs mechanism: a function can be declared in the
system headers, but only implemented as a stub that always fails with
ENOSYS, for example.  Therefore when implementing this function
we cannot use static.

Signed-off-by: Damien Zammit <damien@zamaudio.com>
Link: https://lore.kernel.org/r/20260208055858.2166524-6-damien@zamaudio.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 5998448b1e8..3c985da94f5 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2091,7 +2091,7 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
 }
 
 #ifndef HAVE_COPY_FILE_RANGE
-#ifndef EMSCRIPTEN
+#if !defined(EMSCRIPTEN) && !defined(__GNU__)
 static
 #endif
 ssize_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
-- 
2.54.0


