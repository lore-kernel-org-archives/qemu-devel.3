Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E87ACEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1VB-0003wQ-Hv; Mon, 17 Nov 2025 10:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UP-0003dq-Nz
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:50:13 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vL1UM-0007yr-8w
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:50:01 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so33449365e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 07:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763394597; x=1763999397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khJ5PeWLk4g0+dFSwQoeHLHK625xKHwfDWmFHB0Z75I=;
 b=XQV+HxJqmdy5YwzNVQ38Pc1GG3xhqUk100p9N0WtYbsOShHcHIZmIenE7zP/68EGN9
 uOUjiizWAZZBGJc7kKvhCmfeZNodXRVYkrhoDXqcNoMcBtad8ourQM9HmN+fHwnyMrGS
 L+35nT6KbhO5PLh/T3Z3VNuIcMxMCJGE91JQbsVFkqucymdI7H//lD96/5nCPvtYURpL
 eI0RbO0eqVBZrR0HskEM5iVxZ19LJuhHnq7SrDQvAIwzMASFQ3VbV+s1RxgyC2os62Ao
 /SeWuO25yXi7JF0VsbB7fqWRZA48xw4L4TeF/hp1IYvrF/J3EfvXX3RxchnhpCsYxw3j
 BR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763394597; x=1763999397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=khJ5PeWLk4g0+dFSwQoeHLHK625xKHwfDWmFHB0Z75I=;
 b=bN0I98m//EKBeAunAX00KY1UYi1Vd5w1jWOE5hwCOhInztdkOO7IST0wDnFsExsW7p
 xDX93SUEWM5+3MvlOR/v7fAdExRd081ykz4myFwK2Hv5d7+n3ygBC970wYiKVkWzR4D9
 hTy3QpCx5sJsuQgR+JajJu+WbyWxuRJnnrjC+pklJs4msPdvrdDgf4WJVNOyvOowjJEf
 YxfXBt9zzpY0zzSr13QvOVDl2ZaV4FnQK/dmI8v1aD3efuXxfrqxrPbKFE7S+LLj7Zxl
 yT/HSOoOCkBNXmviqxbbJ0jj0kZEsF4d+aJz/zmLRL01BvTWrLHvuPMrOxH/idApwjJq
 jkUw==
X-Gm-Message-State: AOJu0YzMOFqcYKc58aFjd4n8FY0CJtfHb7kmym8v0W1WYizH27rsrFi4
 pWqwgeP1IXGJPUqXK1ajVe2t8hGmXa+4FA8b6zNVOjGUjeiFuON8H2qhqutTuoCRIDk=
X-Gm-Gg: ASbGncutD7e0ZCJfQiQOAcgSD90adT8zuqQWyGano0HKJhX92HiCQDIFWtgvv/4atUC
 Vl9hFL6rZ3OoYhamuReOxzaHzUimmWZW5t1yTRyb5iCfe2uUu6AcLBj072jGNcOck8U0z6LeatQ
 HcMvm2ZUkNc1ClFl8z0csSqcJwkEA/Z1mTWRvZjt+hbTtLZaDudiDBlUoo58xEZG06SBrOBINx1
 xH8xDwekJ3QFQgElFRqLdJ7TqeoXPsdCJ6FVpn3ZJkSMzs8n5iT7NFIFy2d9EO0Xczkf8Hh9vxv
 7iPuW6Q/AGr5zxSC+a4o9m/li7fWp2WAFuSpAEPWwvoHRcFA9CaJbiCuACoV0DvqTfcOqRf6zdQ
 Rj7+VxxsW0c+AceVR7qT4nnsUeXTZwD63bIKdpDkaxSe8gQq47yvUfqRd3rX9CejZnbb1e8Qbkh
 O9p/1+yF0vazI=
X-Google-Smtp-Source: AGHT+IEcqiC5dZ4N9gjUfE9kNvswk3GawTTXNi4rZ3H4FsCKAxiyASxQ2feksXvK40DdPlky8290hQ==
X-Received: by 2002:a05:600c:8b5b:b0:46e:53cb:9e7f with SMTP id
 5b1f17b1804b1-4778fe7cdccmr100264565e9.18.1763394596719; 
 Mon, 17 Nov 2025 07:49:56 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae2dsm27368832f8f.5.2025.11.17.07.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 07:49:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4427F5F94D;
 Mon, 17 Nov 2025 15:49:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-stable@nongnu.org,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 09/18] tests: move test_kvm_xen to share.linaro.org
Date: Mon, 17 Nov 2025 15:49:38 +0000
Message-ID: <20251117154948.4122164-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117154948.4122164-1-alex.bennee@linaro.org>
References: <20251117154948.4122164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Linaro are migrating file-hosting from the old NextCloud instance to
another sharing site.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Cc: qemu-stable@nongnu.org
Message-ID: <20251117115523.3993105-10-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/x86_64/test_kvm_xen.py b/tests/functional/x86_64/test_kvm_xen.py
index a5d445023c9..424d4b20010 100755
--- a/tests/functional/x86_64/test_kvm_xen.py
+++ b/tests/functional/x86_64/test_kvm_xen.py
@@ -23,18 +23,11 @@ class KVMXenGuest(QemuSystemTest):
     kernel_path = None
     kernel_params = None
 
-    # Fetch assets from the kvm-xen-guest subdir of my shared test
-    # images directory on fileserver.linaro.org where you can find
-    # build instructions for how they where assembled.
-    ASSET_KERNEL = Asset(
-        ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?'
-         'path=%2Fkvm-xen-guest&files=bzImage'),
-        'ec0ad7bb8c33c5982baee0a75505fe7dbf29d3ff5d44258204d6307c6fe0132a')
-
-    ASSET_ROOTFS = Asset(
-        ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?'
-         'path=%2Fkvm-xen-guest&files=rootfs.ext4'),
-        'b11045d649006c649c184e93339aaa41a8fe20a1a86620af70323252eb29e40b')
+    ASSET_KERNEL = Asset('https://share.linaro.org/downloadFile?id=UG0V8dzzHrrHb9X',
+                         'ec0ad7bb8c33c5982baee0a75505fe7dbf29d3ff5d44258204d6307c6fe0132a')
+
+    ASSET_ROOTFS = Asset('https://share.linaro.org/downloadFile?id=VwLRKDXKFl6oKti',
+                         'b11045d649006c649c184e93339aaa41a8fe20a1a86620af70323252eb29e40b')
 
     def common_vm_setup(self):
         # We also catch lack of KVM_XEN support if we fail to launch
-- 
2.47.3


