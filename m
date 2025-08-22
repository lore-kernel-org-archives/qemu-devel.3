Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1313ECA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 13:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upSDX-0005vq-3a; Fri, 22 Aug 2025 09:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1upO1f-0005pj-G0
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 05:25:36 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1upO1a-0007Bo-UH
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 05:25:34 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-24458272c00so20901255ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 02:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1755854727; x=1756459527;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LelFaXu4nBaY9dT35+wlto5FIYzudNjlsl9EfmiZ5M=;
 b=2R5rzeR8InbtkyQo0P+AOoUt6iDP30ONkSIVG/0yTNb+ahyVL0I0n24yUL8floJWOU
 WTmXAuUX7mtKzkIDdmZm9zJ10BxRXHsvJvGyf2Lni0cZGrwKP2sWZciBCGXBPhs3iDr5
 rTtW3UXJ8w/eaAnit5w99PBOG9wHZTgWHwijCwuHJo7+NbLs1YQ/Rz62tfkNJ8IwT812
 XQ79chaVxbocuAHWZa2pY5QOvXI7iHVjCKhi/7/CimleexWo9qRWCXwT8T+Mf7lxyvML
 kDi0ieP6vfq71M7V6Yt9wMb9lTcgXIp3o/6iiA4uheBEKLt5bObQd3J83LvFsF/nsUj8
 pXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755854727; x=1756459527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2LelFaXu4nBaY9dT35+wlto5FIYzudNjlsl9EfmiZ5M=;
 b=WFFzsZL4lX21ocrpYtZRXBfGk7wkJA4URwUlLwIrns04dQrGH5ZnttGCMfBKBeKGUQ
 L+CXHSthov1LDgX7W+fTZ3n66WtfScVmQjvYON3qdnajLCCwTKG8HhrIvuN8WRVo2x2L
 juiCEhqdKmCR46JAN7f7bpEkrY2YT0LMCu5VXLtex9+T4sacbp7g2If0xBcyAo39Xs4s
 UW0r9Losyd7qbzvoOJkVq2jBWVEQQNjizgF91o2ypQvFFDJq6mtfEXUvcJ+J33hvkX3L
 3L8+cFsSJkIt4H9zprscooQJqG3jsCz9uEGGgO6Vex2l4nTxxhfNT0UVY5PMlhZZYktN
 N/ug==
X-Gm-Message-State: AOJu0YyQQRPFHdm6kX2kkF6K80vrAOy+YJh/ry3Ju4LnT99XI9jwKAKz
 d6aG7MLbuur1sOA9A+W9iDwC6UV7SXejraUj1Bi7WlBBoMW190Oev5NTWHU+LhRFSdCxGeGnr2o
 rtEqzsDQ=
X-Gm-Gg: ASbGncvgwPTQcRIOva4EaTULeaeD7qx+tbxNKVcpIrv5FrayqzXMJW8VOLNzdoNciAF
 RBu8o80WHhEp7lyeN/+oPh/C9MD6E04RPz92q9pMI/pZ28xjkjEyeXtDUYoUJDFA7qnPIVbDO18
 +1p+ofiCphh/KpVCAd80XVutBlpaPIAPi7HBZ9Bxln3YvcrBQ9191MjZrvjPKVcZ4qpYjuwM5Rx
 bxFEpA1RoP0lj5CpbZWIZ5syM4NhirIIrehicPqTAzZ+BDhlh3hB0WfQz+5i7xi96fvkLkmte/y
 DI3JzKHwANWCSoMs/ZNBhxUAhB8Hqr691OyN1T3xb9e2FH0WwlNEqFcFv4za+gm/9hPvbsZGoWs
 egBogQymOjVQf9FFaxUWIONwNivuR0YS0rd5z2agOxZ5x4/35o+4j
X-Google-Smtp-Source: AGHT+IHwO6/ISB0j/F3Fu/FL8iXEouvPElKuNTjaAa80YP6la6HrQCx45MOnxFn2E7Ame5lgK/uVxw==
X-Received: by 2002:a17:903:94f:b0:246:4417:db76 with SMTP id
 d9443c01a7336-2464417dd58mr21785165ad.5.1755854727321; 
 Fri, 22 Aug 2025 02:25:27 -0700 (PDT)
Received: from warg.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed4c6fb7sm78560215ad.89.2025.08.22.02.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 02:25:26 -0700 (PDT)
From: CJ Chen <cjchen@igel.co.jp>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Tomoyuki Hirose <hrstmyk811m@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, CJ Chen <cjchen@igel.co.jp>
Subject: [RFC PATCH v2 4/9] hw/nvme/ctrl: specify the 'valid' field in
 MemoryRegionOps
Date: Fri, 22 Aug 2025 18:24:05 +0900
Message-Id: <20250822092410.25833-5-cjchen@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250822092410.25833-1-cjchen@igel.co.jp>
References: <20250822092410.25833-1-cjchen@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=cjchen@igel.co.jp; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 22 Aug 2025 09:53:58 -0400
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

From: Tomoyuki Hirose <hrstmyk811m@gmail.com>

'valid' field in MemoryRegionOps struct indicates how the MemoryRegion
can be accessed by the guest. In the previous code, the 'valid' field
was not specified explicitly. As a result, the CMB area could only be
accessed in units of 4 bytes.

This commit specifies the 'valid' field in MemoryRegionOps of CMB and
the CMB area can be accessed in units of 8 bytes.

Signed-off-by: CJ Chen <cjchen@igel.co.jp>
Based-on-a-patch-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
Tested-by: CJ Chen <cjchen@igel.co.jp>
Reported-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
---
 hw/nvme/ctrl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index fd935507bc..9dca718ca1 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8272,6 +8272,11 @@ static const MemoryRegionOps nvme_cmb_ops = {
         .min_access_size = 1,
         .max_access_size = 8,
     },
+    .valid = {
+        .unaligned = true,
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
 };
 
 static bool nvme_check_params(NvmeCtrl *n, Error **errp)
-- 
2.25.1


