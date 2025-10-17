Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFCFCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kXh-0008VL-LD; Fri, 17 Oct 2025 09:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXY-0008Rz-FH
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:30:42 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXR-0007ww-WB
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:30:37 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e42fa08e4so18008295e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760707825; x=1761312625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVdMxvU4zOm3LxJuUKvCUnGY81c6LCFhSfSScZbUVig=;
 b=RNFukF4aXpmvNQ6uOphTmH0EMiRnuj80MQj5t7TaYgj1E7FdFgz8q810PcvCMy5uG6
 XW45alamizlx9B4BW0SFsqG2X88ybh5YQnKG/sa3CwG/25K4YV/PwziQTS1BYXaBYK/2
 pOo1iyQloXfsRhcgYgXfWmTE2whFvjs5c9EHoidv0j2ySOfj+mb4hej4q3hjabdikv2Y
 /s00MAwIgoNSJPYdmDvAuvULdakZ/1TzlThu7witM+/IYFTzkMzXeOoSLeNkeIrc5kkH
 IpDDJOQfs/EC/aIKRDVFUsKuAyi1EiRk+OmBPLgNmOmlFMMAQ82fDMRADaMFrIDU2K6m
 xfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707825; x=1761312625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uVdMxvU4zOm3LxJuUKvCUnGY81c6LCFhSfSScZbUVig=;
 b=e6Uz/oDoXkM2k1TLYWESv7LdjTrA4lbIZmYXA977P2hOUEjcMxlnQafhFmRMLvZcai
 u4zcqhVmf/eDG0w4PDZkkXrm/dJToHnfPjybeDKTvDr+kOX0l3SL9yMhJ0hKc14nu9gU
 HGpz0Fgs5I7leLmH+OmifzSEIwSOwZqDG7QgOmWyOZ/zFQgrLocmG5bDCr3eur9ssYaP
 +zhbWIRz0M41WmdqE3Kdr39aJngDZO/1BKBRxibb0ygWSr5XLS4pdIfjgGl2RE55pJ6x
 HMiOl21f0c6cbMfco7fU9D2r+d2UcTgAomA+xEFaNFwzVZuXTPZA7Q7z+sW/S1W3SNqB
 4QRA==
X-Gm-Message-State: AOJu0YwVyZlfejiLWxexLDdXsSVUmJxXVVP0w3oB1Bmt7Galbga19iED
 /o7KvHKwU+tpvxRf/U+hI00PW/2p4/mgbWX28U5Err1uS6G8Jes1BLb8O452QukEPQcf7dDcjaU
 sGFoF17U=
X-Gm-Gg: ASbGncvEXVawQxdyfsqW0a+WgaRkfXkhvfxcg8JNrxKtFw/hzHWuHf611J6iCYo7h3t
 KeKC1qHpG3xCC+KzUTg/hoyT8hlT9PzfpIGq1x1+Dlk6Jgnnu1mmulwAOfW7jH7vt4U3tVwVIuA
 oygSp42SofxayHzbCFnZIWxdr6y0mixDFeQ6r20mDIkb0OmD2L/7x68qoIgZMdRVEJHrWTBKNdN
 yrnMcO+htj2Ru8/agjTtFX+wZMgVya/Hfh0hPenDcEmyjUoSb2Je9Nt0sVWhTIFgsyUDpBz15iA
 omn7Qwd7A8X7TBS581W00ey3862kNDojzpY6DtBG0wdD0ZUmiJPx6sk60sWNa0vsNOc2mBNN11a
 vkmvy7CMFoTCMReyJ9AeChshbDFSxJkXJAuIUSX64hg127K2r2SNDRDzBdrJrW+p+nZx9aF0L+B
 Ges3Pjq9jPDGZB1TzrkRhdA2MPiKz7CKy/HTICoKRMLc7kVjupQQ==
X-Google-Smtp-Source: AGHT+IEBkGeXv4i4nViSeHAshYqIqORZq/y1PuipgDzHDyX1qp/Ce9eQnUgMsiVo9VgKak4yGB0KlA==
X-Received: by 2002:a05:600c:3b0c:b0:471:669:ec1f with SMTP id
 5b1f17b1804b1-471178785e1mr30099525e9.8.1760707825475; 
 Fri, 17 Oct 2025 06:30:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144239f4sm83162505e9.2.2025.10.17.06.30.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:30:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/12] hw/s390x/ccw: Remove deprecated s390-ccw-virtio-5.1
 machine
Date: Fri, 17 Oct 2025 15:29:53 +0200
Message-ID: <20251017133002.61410-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017133002.61410-1-philmd@linaro.org>
References: <20251017133002.61410-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-virtio-ccw.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e1868eb7cc8..7be998168e8 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1121,18 +1121,6 @@ static void ccw_machine_5_2_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(5, 2);
 
-static void ccw_machine_5_1_instance_options(MachineState *machine)
-{
-    ccw_machine_5_2_instance_options(machine);
-}
-
-static void ccw_machine_5_1_class_options(MachineClass *mc)
-{
-    ccw_machine_5_2_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_5_1, hw_compat_5_1_len);
-}
-DEFINE_CCW_MACHINE(5, 1);
-
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
-- 
2.51.0


