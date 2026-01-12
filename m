Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5839C9EC9A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 16:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfKUV-0004j9-Lc; Mon, 12 Jan 2026 11:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfKSJ-0003qi-TD
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:07:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfKSH-0005ka-LC
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768234062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PYpz+O8lJZSKQUa/nfNCsHnTFzQexT46n+Ad3AeOqTg=;
 b=AAZOZkgdqSRmcEZo3RQcUHgD6JCjekAiRCc99Jms39X2kQqLVhFwNDtwKUeU7boOkF5jTP
 sgBqM/XsZYrxSdtmroPRxRnArr1sJ9ppVaP/QG49vgA5NSK9q5GU0nlQ9QkcpJjIqGw5XC
 zEbnI9SY91iPVf8bQ6/g/S9R6vv+/Fo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-nnPzKtisOoKjeOtVG695DQ-1; Mon, 12 Jan 2026 11:07:41 -0500
X-MC-Unique: nnPzKtisOoKjeOtVG695DQ-1
X-Mimecast-MFC-AGG-ID: nnPzKtisOoKjeOtVG695DQ_1768234060
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-432586f2c82so3280257f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 08:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768234059; x=1768838859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PYpz+O8lJZSKQUa/nfNCsHnTFzQexT46n+Ad3AeOqTg=;
 b=MPuoEQ7+NUBEFg8HjXgQ8f2wN7lAFvVlD994rXSRX/0bGFiCdjFD4wUVgGAUISKBQl
 ZAwqXFjuLEFiXtOYAECvSod/KbJw98nXnuoTQ8FPGs7/03cSmgtOEYJElQVgaclRoqNI
 KsBBNhoiGJKrWGjgR8I6U4zvP7M8bf67uGMiQ7WK0e+vqJXGAwoWYbVPmV0S1LeRL8Nb
 5xurSRR/OFlDfcR2Oe7rzKXl6DcIScZatKfz9KIfrIKzot48ZSSqtx15d5LNGN/GNcI2
 FXt2VrvdG5IQ+XbNZfL/ywqNS4bGKgjoA/lfumvR1b/vbfVcWvqwSII9ahiJiBnYP0qG
 7hDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768234059; x=1768838859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYpz+O8lJZSKQUa/nfNCsHnTFzQexT46n+Ad3AeOqTg=;
 b=HzxgpmoJhTDV4F+Mdqyj4VM1ZOsGfjO8UzRqskaKvqLWKzzS/VpETLxTdsei5bg55M
 +aDdqaXuSIhnB6Ms7yo/OTyMEqtQZgBrg77SJjhmKhb1EZmnnVtExro8iVn/oJ2/yIGe
 QFW4bsew8VkaXAwdEkj/1V9npxdqvUTDIBEfPEIJNnEjoveJ+hY3xV9pyAI06Y3WWPCn
 GCBvNZTXl7ZfXvjOeoLj1DoHHUyqWKbKJiDpy2qxaGK5tx/sXnltnErPx1Ni6wCV4iAU
 SifzmnVsncj/pRVLCb1wxhbIcwqjQ3VdpIvQq9WyYzRSf52+YVmoVeXolvz8xzD8ZSk7
 ahqA==
X-Gm-Message-State: AOJu0YyPpqLM9Q3QbI7Da37hwOD3HotD6qBjVaf8YgptxV/6RgtZ0TCN
 RD3gXdyBBjx7eorT06IRxWOZ3Rlct5Tq29Phzp8OxsiyWWsrsUaBA8RQGbwxOg85bTM9kucaVFp
 h5xOKQtwEEL4e5DNqpIvapJKyMi4xszJufLE4hUKjb2ANhT56IEJ7jl3f+xojNFJClfcjG2zjZs
 8c5fYE0SwPu4uVFzNH/SLS9h/s7784MO2YSEvjgvT2
X-Gm-Gg: AY/fxX5IKeXTfhniOAp3rQo73v9V5SKHwj9s4Zk/kWWX5pxo/l67hshGaUG5ZiaxN5p
 PrVE11DUy2z9AeZpkoquzEdPg4gZtIGOtzOTMwOd7YOYk5tnVTf5GA3EEpbHZnKfiqLR+R3Vk7c
 aD92cruyfDAxgR0Gl+/jqaYZGe9T+tV5akAOtJn1MRPR4YutXCmrgUkFl6wQEQifusMGiIgyK/H
 oq+OSvlwyScK8v6F3JR97mmvlPEUvD8fF5uFdk4Lc0RcQsIoJbzEco4Gv5xIMEGx6/0xZV2j9ml
 hoWw63T4KRNr6S4oeMabHMin31TXnrQ6GfiWf1JNz0VroZCmQyWYCKphX1fkdEH62vIxaLzbY0u
 Un+p4rQqzrvrMaWrcS7speHnmfskNeMaONY5gK1/m7GteNkuti+1Kcx5VqmQjjQF8BkIQhalDJ6
 1XcOOcbZfQ4clJww==
X-Received: by 2002:a5d:64c7:0:b0:431:327:5dd6 with SMTP id
 ffacd0b85a97d-432c3634312mr19910321f8f.8.1768234058680; 
 Mon, 12 Jan 2026 08:07:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0b34FLTyiUFVwNaK4Np3gYvrRaCjVLi8HwLFBBAQUGTLtM25/vW8+dn9NXKjT1wj0H1JYcg==
X-Received: by 2002:a5d:64c7:0:b0:431:327:5dd6 with SMTP id
 ffacd0b85a97d-432c3634312mr19910261f8f.8.1768234057976; 
 Mon, 12 Jan 2026 08:07:37 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ff0b2sm39262069f8f.42.2026.01.12.08.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 08:07:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	qemu-stable@nongnu.org
Subject: [PATCH] configs: use default prefix for Windows compilation
Date: Mon, 12 Jan 2026 17:07:36 +0100
Message-ID: <20260112160736.1028280-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The update to Python 3.13 causes meson configuration to fail, see e.g.:

   https://gitlab.com/qemu-project/qemu/-/jobs/12672816538#L397

   meson.build:1:0: ERROR: prefix value '/qemu' must be an absolute path

This is https://github.com/mesonbuild/meson/issues/14303.  Remove the
prefix='/qemu' line in configs/meson/windows.txt, since commit d17f305a264
("configure: use a platform-neutral prefix", 2020-09-30) says that the
NSIS installer doesn't care.

Cc: qemu-stable@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/meson/windows.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/meson/windows.txt b/configs/meson/windows.txt
index 55b192e71b1..9ef0fb3c8f3 100644
--- a/configs/meson/windows.txt
+++ b/configs/meson/windows.txt
@@ -3,7 +3,6 @@
 
 [built-in options]
 bindir = ''
-prefix = '/qemu'
 
 [project options]
 qemu_suffix = ''
-- 
2.52.0


