Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61E7C3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAb8K-0004aQ-Fj; Thu, 01 May 2025 17:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb7n-0003pE-UC
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:07:25 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAb7k-0006p6-LD
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:07:18 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d96d16b369so12886055ab.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746133632; x=1746738432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WwJU5ZPxxxnKG6o6jl5mOPQrDWUSsO9Sle41Xc0jm2Q=;
 b=jXmzCvFxuGGk27bOEpVB/qF1VgR+IA3gbU7PENbjAXAjyakEAuP2ZoSy8KrPDdQIID
 VnFAUewGzFhbZ+4CqAFFIEJi+cMgoafhJQHglecqfTa+qV4zQhHZYxI2cnK4goRHwetx
 YbPlSHGE1kO7CXhXklYfAobWcZb7CNgOnF7X1uRqS5dalZXxJTpjD5+N0XbHmUG3kTz5
 nwSvR9fzOfmnpLB95nYEmJxseUrDDYNYPoT54KDi11m5z+EWRkWiqaBFiVsCPM4Kque7
 p3yQH2xKubuePDXumet9gtGkjE+U0fCMEtRUkhAcTNNxI1MNyk2EVwIYGAk+ImUd+H60
 t0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133632; x=1746738432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WwJU5ZPxxxnKG6o6jl5mOPQrDWUSsO9Sle41Xc0jm2Q=;
 b=vXfw+N9TVD+hCL8en0WgtSoSqCJ9KxflHXI5y1E8Jw/qO/XjDNncpjydjJTKBl+k73
 +dmtjwS/oFvBhNJc0hFGABczaAL3g2PQmTKgcAWc9TgAOrLnJVL72kNtb9CNXjHub0pS
 1kQwWrZnHTFtuzvP7zVRgYAvy5kjMdy2hXhz0FMPAFoRp+Ryb8OJSd1HzCNeWVurUIEa
 6WS73xAGCsdAaskTAGn4suHI0sjSLVfzBjxjaDcYqFexUcYZ9F1FuYooRRK3MD9IkfvJ
 8isKUmKTGYNfhMCDrRpEUw3xnZwMPPhgeFq6eP91I5kg89AALVm8/WB07zGQe4JPxIDJ
 iVcA==
X-Gm-Message-State: AOJu0Yy/foHAWO7fh3XAgMCxO6ZB7bBonoQCjh3OxbUU4D44AgxiP+ru
 k9xs258Lar6pZdE926hiv27fN0z6iN9YHN+xf3M5SKYnDfWkVXdp8IjWcTOvHkEgalRTHjwUgcr
 8
X-Gm-Gg: ASbGncvQA2gq4pgrez2mmI2df7k8InVUYayZb0/1runddzKjUMnqNNK4BS5vjVQwtc1
 56C/8z3LE+la0iRjsqyhMbFpP0Ro3QQwTxzJM54r7zUMR7UQEeRm4Yb5Coc5XVkljrYM5wkuRIA
 QPIt9hBtfNMq6Bb+Pqbv/H6GrPqLBdUbxWMdVLw7Brck0vml5Pw5mH2LnAw0hYMGbmFoBOileV+
 t8ClazjnL3Q8Doo/T/n/ANdTcy6q4oYgcB8P8iYYJNqhsG4/0wc49bXrDvi46FF2nOFwNRXWSR6
 OROfJOUCEJYXPJwI7HCaVTFIoWG1Xy6IkDL/XHV0MjOhDzhuZMCBjEjgd3PRdQ4/+eL7iKxT2Bi
 ZYCxOc48XoWL9crY=
X-Google-Smtp-Source: AGHT+IEr5p1LmQ9nlTOCpkroHBeFZN/OH2z1KfBspn9mGgar85WeTmUau62kPCCcvf7K5bYq5tsAiQ==
X-Received: by 2002:a92:ca4e:0:b0:3d5:8923:faa5 with SMTP id
 e9e14a558f8ab-3d97c1af64bmr5387935ab.10.1746133632331; 
 Thu, 01 May 2025 14:07:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aa58ecesm46024173.98.2025.05.01.14.07.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 14:07:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 15/18] hw/core/machine: Remove hw_compat_2_9[] array
Date: Thu,  1 May 2025 23:04:53 +0200
Message-ID: <20250501210456.89071-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501210456.89071-1-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12f.google.com
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

The hw_compat_2_9[] array was only used by the pc-q35-2.9 and
pc-i440fx-2.9 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h | 3 ---
 hw/core/machine.c   | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 84bd3735c42..513eb2a54fd 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -832,7 +832,4 @@ extern const size_t hw_compat_2_11_len;
 extern GlobalProperty hw_compat_2_10[];
 extern const size_t hw_compat_2_10_len;
 
-extern GlobalProperty hw_compat_2_9[];
-extern const size_t hw_compat_2_9_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index bc0606cf740..486d1adb4b9 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -244,14 +244,6 @@ GlobalProperty hw_compat_2_10[] = {
 };
 const size_t hw_compat_2_10_len = G_N_ELEMENTS(hw_compat_2_10);
 
-GlobalProperty hw_compat_2_9[] = {
-    { "pci-bridge", "shpc", "off" },
-    { "intel-iommu", "pt", "off" },
-    { "virtio-net-device", "x-mtu-bypass-backend", "off" },
-    { "pcie-root-port", "x-migrate-msix", "false" },
-};
-const size_t hw_compat_2_9_len = G_N_ELEMENTS(hw_compat_2_9);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.47.1


