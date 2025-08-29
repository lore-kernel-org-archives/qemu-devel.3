Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77448CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNOa-0003vQ-Dp; Sat, 30 Aug 2025 11:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us14i-0001ni-GN
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us14f-0000Ve-UX
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756481492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wHiXTdD+JdkJ3K5Wgrb7J368fVXnGUo4N+Ao9AD46aI=;
 b=YXlOI1TEWGP48olXruYUx3CWUR+hHxtQt53bES/r/YOJuKZgUfyp9pLcl5poWWs20nBKBj
 kj99YdN5VHGUDDqEJMRG7TgLo+gY7k1t7DpyghuJeR+Gq3dHwx15isp69wayNuch1s2FeF
 SSjNKpmlwKJaT6yIkOMRYgZrYqksHF0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-gFFm9Sz3Pp23zpMc3XgYTA-1; Fri, 29 Aug 2025 11:31:30 -0400
X-MC-Unique: gFFm9Sz3Pp23zpMc3XgYTA-1
X-Mimecast-MFC-AGG-ID: gFFm9Sz3Pp23zpMc3XgYTA_1756481489
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b05a59cso14966165e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 08:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756481488; x=1757086288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wHiXTdD+JdkJ3K5Wgrb7J368fVXnGUo4N+Ao9AD46aI=;
 b=Y46A5wUnyzSFdB8wb8xumvOSNcZcM/zkmptZNFkSbsYpukc5sf0kIkNLj+qCs6MdU0
 nmf/J2oX1x2Ew+8hU0HH8FdxqOWqcscbx9g0YCLIDJlEHuN/MbGvSkQzcOFi5r5hpv7M
 ND9FGmM8Rz9JlXVKU23UstSo3wEufhk9e5RcG1olYflwqX+waPpMbaDic+elDnuSZyOs
 oECk1zwDEOQC6i7gYoT78nD0kq9u1/I2G/6hZGBeoEr4gM/9FlQgqeFe/SU9O7U25nzQ
 Vk21uR+plXtKJ/pATYeiAgunjY1Luj5WeEoBrcJKZ5SPkDwrsf752u3zEHftjpgMkbAJ
 OODg==
X-Gm-Message-State: AOJu0YyqLD78ZMZjrcRUqmFG+PeV0gA0Ro2BOhjBg8swun8dH1Q6yvfk
 tBDaRZ4PX+rcP5P0x/2lmOmhg/IbLoJSDj70L4J/jCohChrkUd+AIyA168RqckYWYIIGf/wmfKL
 qcbYiNCRydII6b+nkwBVTjYzHQjhE/6jd2WMPgHlU/tJTT2NzBdAC1igsI5GmGEuJB8OJTyDo1Q
 SrU1drrMUDsv+aGbj+ikc6tR+/NRD4aPLBjZ8d68yR
X-Gm-Gg: ASbGncux2ZNjJphdGrbmGfoLGc6Zg01dsJiaPsMvWmmWl6TEgrw6k5+ZzagS2TYT1Jb
 8hKW72xJtwzQVzItMHeYY0kNDFgN4okRsoXJOKLkh5pgIJLK35nZY3d9pBfvLgF8Pr7tQ++pTX1
 p8ST4aHrTqDwlKAlfjWl/tjFGSAqt+3Fg+jOGwe2tEOOpkvjqIskp3b5Vbxb+YGGg2Tohy5iMx+
 J2ufhZUQchkyVCrAkZru8EySN69UujBesjIPcJbieMpf4Fg4+ldTnJOVFhPZ1xcAp0YwZw7BPCb
 pNZzZ6vBFOicpwK6sg6dPSi3vfsMtZHxsn7NrRDR2PZ3nabZQGTXLbeL/Uiz6O+/l0qWb5QI5qr
 TR8+DcT5Ozv9CrITJplnFtS6aGVAQ6Z5ZrlkWOUPfyR0=
X-Received: by 2002:a05:600c:4617:b0:45b:7deb:3f07 with SMTP id
 5b1f17b1804b1-45b7deb495fmr29290095e9.5.1756481488635; 
 Fri, 29 Aug 2025 08:31:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqIpqtDTEzUzErYWJ417I16eY0x9D/bMIsQx2SY1DYNWVLkPhv5Owh18nRxW8wOpwO1kCo0A==
X-Received: by 2002:a05:600c:4617:b0:45b:7deb:3f07 with SMTP id
 5b1f17b1804b1-45b7deb495fmr29289835e9.5.1756481488143; 
 Fri, 29 Aug 2025 08:31:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fd2dfsm3926917f8f.3.2025.08.29.08.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:31:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	richard.henderson@linaro.org,
	imammedo@redhat.com
Subject: [PATCH 08/18] cpus: document that qemu_cpu_kick() can be used for
 BQL-less operation
Date: Fri, 29 Aug 2025 17:31:05 +0200
Message-ID: <20250829153115.1590048-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829152909.1589668-1-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 23bd02277f4..8b57bcd92c9 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -829,7 +829,8 @@ bool qemu_cpu_is_self(CPUState *cpu);
  * qemu_cpu_kick:
  * @cpu: The vCPU to kick.
  *
- * Kicks @cpu's thread.
+ * Kicks @cpu's thread to exit the accelerator.  For accelerators that
+ * can do that, the target vCPU thread will try not to take the BQL.
  */
 void qemu_cpu_kick(CPUState *cpu);
 
-- 
2.51.0


