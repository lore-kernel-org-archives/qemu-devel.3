Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0580CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VeS-0000uR-Up; Tue, 30 Sep 2025 04:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Ve6-0000Q9-Ea
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:41 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VdU-0001ET-Pa
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:35 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so959462f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220576; x=1759825376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+NTzU/IHsRou1TdenwZChnEmNZiK1YgxaNrzj3kN60=;
 b=cyOvLoKobdu9y47zyQRojkNNMFuD6VdGV/WjupHLR2YTyCSnxEkAbbxvJult0I/obM
 sLzbZcIWcK+ka4M/HH+D22PIxV6DlnO3umLZsjObmzxiZFMb6hXVQetaOIWbgrGR2Ylx
 orkjPtKVb+SIyED8H+ZTlRRPwABy/qDWP6fEuxKIwqL48RNLN1lGIpR+tvslPU4Gnhs4
 nvJYBGOyGTrKMnRnAWLWrUcW4uO9W4sBbDVliKsBvcx/MBKfeGjOThaYBgfTQUQkQSjo
 OqFeej/rujzsHyt18UhqRzgJTTLetvkjrhi4xDUMLHMKhYojuiQ1l1OBloXR3mF+mlD6
 OWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220576; x=1759825376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w+NTzU/IHsRou1TdenwZChnEmNZiK1YgxaNrzj3kN60=;
 b=IDlVXiac/0d2m0VOS+CYp1xjKPvdrNy73bIgIGvVSMrHJknW4gzH2N+xQoeI+U5t71
 1ZwzB3RB1+17THyDxFt5JGe4aYZ49WP9H4XazuDC+Yu2WXmqPNxH/PBaCiOnx5vf0Nc1
 SVy15E1YdVDNfh/pSDsYXFpVAkMFng03/LRiz9vE2KvZXR0JRY9GRp/u3mj0FZFXqyI1
 dyvYIr0X1LzOBpYkkqG0zqJmUn/9ejZWQTov1tfap3Fyhp3SEQUK1Ulg1rUAncZuSPDi
 NV2N6i97BQrSnSE+AVplUgbPQEdUmQyN0K/jBd3dHUs8/aO/gJB+3e+5XZ31NGt1DZcD
 sVEg==
X-Gm-Message-State: AOJu0Yz/6+aLUKJmJIzTmoxNNM9bWso9eubPT4fIYFO6h/2lPVEjvszR
 TI4IdlBp1GHkl0Zy0xIyDjii4IYL1YSOa7Zi9ntXhB1E5nDsoPG5CbxzMOMNsmAi1UtDdjcrDFl
 cKvyWiWByQA==
X-Gm-Gg: ASbGnctUyZXu4Iip28ACHdwfwcejvdKVJdLNEzN/ZBboIiUqsCRVJalzvPVn+0kdzpF
 2vwcIWlNI1r6cR742ySCCXcBehHLSVlQpcmyqt7n1132OCS1bTDYoN60qABjTQ6xvgKChowCYtS
 NeZngR9XUcj09XJzdev8n+nq+Dwc+Xa+CTtLj8O9PkKaoijGS42YfUVmBzRvoQFmzFL0v9VOJki
 SKdhgVXm1JpnT/UTSPqmt+Nrzs3kROW5s0uEV0sl0MSFVN6IuJqzWJJgnfYGEiwFdt1rq6JKVQM
 f8raKyz9iCMCE4DXwF+Q5/LFtmRmTa163eEQrXbhaiQkXz5YdJ67cEsIPjTX5X+4mho3i945enE
 fgnedru/z1keEOZy9AYM1XFUvUWz2p9alv+grSjIANdrmFFrIR3c8dIiMDxQcWVKh/5Kzp5aZXb
 TiQnRAuZspY5f9vSBFlgAq
X-Google-Smtp-Source: AGHT+IF6MOWO4c82B+adWYsw2taxPQCQZ7xaYbsT9FR7waxJpKF5wSL8PK2fRqDT9d11Kh1Y1Hd+uw==
X-Received: by 2002:a05:6000:2509:b0:40d:86d8:a180 with SMTP id
 ffacd0b85a97d-40e4a71159emr18168445f8f.20.1759220576446; 
 Tue, 30 Sep 2025 01:22:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab31f1dsm257299105e9.13.2025.09.30.01.22.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:22:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Jason Herne <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 16/18] system/physmem: Remove legacy
 cpu_physical_memory_rw()
Date: Tue, 30 Sep 2025 10:21:23 +0200
Message-ID: <20250930082126.28618-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

The legacy cpu_physical_memory_rw() method is no more used,
remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/loads-stores.rst            |  4 +---
 scripts/coccinelle/exec_rw_const.cocci | 10 ----------
 include/exec/cpu-common.h              |  2 --
 system/physmem.c                       |  7 -------
 4 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index f9b565da57a..c906c6509ee 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -460,10 +460,8 @@ For new code they are better avoided:
 
 ``cpu_physical_memory_write``
 
-``cpu_physical_memory_rw``
-
 Regexes for git grep:
- - ``\<cpu_physical_memory_\(read\|write\|rw\)\>``
+ - ``\<cpu_physical_memory_\(read\|write\)\>``
 
 ``cpu_memory_rw_debug``
 ~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
index 35ab79e6d74..4c02c94e04e 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -21,13 +21,6 @@ expression E1, E2, E3, E4, E5;
 + address_space_rw(E1, E2, E3, E4, E5, true)
 |
 
-- cpu_physical_memory_rw(E1, E2, E3, 0)
-+ cpu_physical_memory_rw(E1, E2, E3, false)
-|
-- cpu_physical_memory_rw(E1, E2, E3, 1)
-+ cpu_physical_memory_rw(E1, E2, E3, true)
-|
-
 - cpu_physical_memory_map(E1, E2, 0)
 + cpu_physical_memory_map(E1, E2, false)
 |
@@ -81,9 +74,6 @@ type T;
 + address_space_write_rom(E1, E2, E3, E4, E5)
 |
 
-- cpu_physical_memory_rw(E1, (T *)(E2), E3, E4)
-+ cpu_physical_memory_rw(E1, E2, E3, E4)
-|
 - cpu_physical_memory_read(E1, (T *)(E2), E3)
 + cpu_physical_memory_read(E1, E2, E3)
 |
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6e8cb530f6e..910e1c2afb9 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -131,8 +131,6 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
  */
 void cpu_address_space_destroy(CPUState *cpu, int asidx);
 
-void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, bool is_write);
 void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len);
 void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len);
 void *cpu_physical_memory_map(hwaddr addr,
diff --git a/system/physmem.c b/system/physmem.c
index 51abc4cae96..000bde90c2e 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3182,13 +3182,6 @@ MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
     return error;
 }
 
-void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, bool is_write)
-{
-    address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
-                     buf, len, is_write);
-}
-
 void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len)
 {
     address_space_read(&address_space_memory, addr,
-- 
2.51.0


