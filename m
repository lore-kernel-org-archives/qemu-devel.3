Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E7EC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 13:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA7qP-0007eE-GD; Wed, 30 Apr 2025 09:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA7pp-0007I3-9C
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 09:50:54 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA7pd-0002Wt-GJ
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 09:50:43 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4769b16d4fbso46193681cf.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746021033; x=1746625833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q/WGqZQYnkC6GFtxQWgqnTCiwHPYRE4g5VCfUxO60fI=;
 b=Bt6YOuiAo5Gh3y+xukgXiZFVwWFg/xCpfeIqE/JwnDFEPkCIvxq6dl2U34IkugA/c3
 jMH4n3QMxj8eP+8k3Mu3bQJDaW1Vyb60QjowjiivwEsNWKZKh4UPMnYcGIPuNiHdDZC+
 N1WVi7fjlIutTW8gNIJzHwr4nhbP/gu6Zxny+cCZ5H6QTvQmEbjrx6lg89vYtugfWFnq
 WBjK5zml2HIt6h8iTYNuEsQEzSN6izi2tP2AgSsKVO6pRDm+dn8TATIdHU8TdFcpX6DQ
 mZFYJpYhEzstywineAiZbgm1DAy7haD9Y1f3UUGFwa3PXfLf2pFNZcgSmGTAeVsKNx9h
 4sXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746021033; x=1746625833;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q/WGqZQYnkC6GFtxQWgqnTCiwHPYRE4g5VCfUxO60fI=;
 b=pyjOk+BTuKo/zok1PLVu43WF6js/7Ct/s/RKT0kiUunjV9iPHqwxe5VAxpaAr5KhdI
 c8dQgGTk6IWPLAGgvGI3tLRwvQrJfclc/DVNGQdzT7ur8A4/8TsddOKyLV0PxdEt87Q4
 y3a7EVCDOMqIxKRLCMs+IZknbgV463YH3lY4pQF+T6mPC0fMubEdWr4yT+FKnSD2Zy+F
 VlLAj2iIzBDnJCtHGmK8s2eHHGzGAoZo8mb7nPG3CK0xnFqIPV9/38Cjy5sisBviDSoa
 xI5vUmhOPocqvfc0/UckeLmAPkmO2M+09EUHGs0Ue8YzGMr3EBa85aXCir2AEZuuZCWN
 M0YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkAt9YW3kj8h/138LjvkUjp0MOJPbCHSEGgnQI1ray+Uq40kK9Zc4LMCVFTDlVlT61dwU11zNAywDx@nongnu.org
X-Gm-Message-State: AOJu0YwQd71EY5+J1gISlukpzbKur1z6CGFQkWJkk5qD/wu9Bj/rwxGu
 pnXlGmdBL789lOKWMD5rSajbwTZPtY9FFdVp0CcjEuO+wJhp/SoJwIrtFXuiVrQ=
X-Gm-Gg: ASbGncu6zKnqh4p2yRVwwn+CwUZdKnQRcjjodQ4dVs+dYvQ1QeBoAHM8wmI8VQ3tI3/
 K2xAgY1/dds6LRUleD1LliNAGx3jMxN3ISU2hehudfzlr/IugZmjvRuuAUidUjtBs0c/y0ZtNhT
 OZJXbj/9U5E9VArbZfst1qs4dbxGPud2msFTNrda7P3/CDCGAEJZdavs9l/1K07okzZDChTS8PO
 Z3YPOba2sktprIiECUaiL2Egx2oUc62d56/D3Mo2d0kR2/beA6OlDERNstLjKkRgjLCHY/DDvr6
 fzxUo8yi8n4MR63/vFVFrN+TQZ4/S2xwP67Mq3mKxFc4aUn4DnZFNqV1W48T/LEqBZGVjTR81W8
 pBo1eo+ia
X-Google-Smtp-Source: AGHT+IHqSgKR1Xm8BCjRd7+JqMOa1cqBIZr2dVejUivaKYQgvYHlQ2lCZWVgYBN8gKs6FxrI6aNd3A==
X-Received: by 2002:a05:6214:5296:b0:6e8:ec85:8325 with SMTP id
 6a1803df08f44-6f4fcf9a0fbmr57138336d6.39.1746021033439; 
 Wed, 30 Apr 2025 06:50:33 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f4fe70c491sm8397686d6.64.2025.04.30.06.50.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 06:50:32 -0700 (PDT)
Message-ID: <d315f4dc-11a6-41a9-9a19-fe96a12b07b8@linaro.org>
Date: Wed, 30 Apr 2025 15:50:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/qtest/libqos: Avoid double swapping when using
 modern virtio
To: Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250430132817.610903-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250430132817.610903-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=philmd@linaro.org; helo=mail-qt1-x82a.google.com
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

On 30/4/25 15:28, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The logic in the qvirtio_read/write function is rather a headache,
> involving byte-swapping when the target is big endian, just to
> maybe involve another byte-swapping  in the qtest_read/write
> function immediately afterwards (on the QEMU side). Let's do it in
> a more obvious way here: For virtio 1.0, we know that the values have
> to be little endian, so let's read/write the bytes in that well known
> order here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   This also decreases our usage of qtest_big_endian() which might (or
>   might not) get helpful for the universal binary one day...
> 
>   v2: Use leXX_to_cpu() / cpu_to_leXX() instead of doing it manually
> 
>   tests/qtest/libqos/virtio.c | 44 ++++++++++++++++++++++++-------------
>   1 file changed, 29 insertions(+), 15 deletions(-)

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I tried this on top:

-- >8 --
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 930a91dcb7d..5e01c1effc7 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -731,8 +730,0 @@ int64_t qtest_clock_set(QTestState *s, int64_t val);
-/**
- * qtest_big_endian:
- * @s: QTestState instance to operate on.
- *
- * Returns: True if the architecture under test has a big endian 
configuration.
- */
-bool qtest_big_endian(QTestState *s);
-
diff --git a/tests/qtest/libqos/virtio-pci.c 
b/tests/qtest/libqos/virtio-pci.c
index 002bf8b8c2d..98b35ceb9e3 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -389,0 +390,20 @@ void qvirtio_pci_start_hw(QOSGraphObject *obj)
+/**
+ * qvirtio_pci_query_legacy_endianness:
+ * @s: QTestState instance to operate on.
+ *
+ * Returns: True if the architecture under test has a big endian 
configuration.
+ */
+static int qvirtio_pci_query_legacy_endianness(QTestState *s)
+{
+    gchar **args;
+    int big_endian;
+
+    qtest_sendf(s, "endianness\n");
+    args = qtest_rsp_args(s, 1);
+    g_assert(strcmp(args[1], "big") == 0 || strcmp(args[1], "little") 
== 0);
+    big_endian = strcmp(args[1], "big") == 0;
+    g_strfreev(args);
+
+    return big_endian;
+}
+
@@ -391,0 +412,2 @@ static void qvirtio_pci_init_legacy(QVirtioPCIDevice 
*dev)
+    bool big_endian = 
qvirtio_pci_query_legacy_endianness(dev->pdev->bus->qts);
+
@@ -396 +418 @@ static void qvirtio_pci_init_legacy(QVirtioPCIDevice *dev)
-    dev->vdev.big_endian = qtest_big_endian(dev->pdev->bus->qts);
+    dev->vdev.big_endian = big_endian;
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 358580361d3..4a29a8fd750 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -87 +86,0 @@ struct QTestState
-    bool big_endian;
@@ -552,2 +550,0 @@ void qtest_connect(QTestState *s)
-    /* ask endianness of the target */
-    s->big_endian = qtest_query_target_endianness(s);
@@ -779,14 +775,0 @@ static void qtest_rsp(QTestState *s)
-static int qtest_query_target_endianness(QTestState *s)
-{
-    gchar **args;
-    int big_endian;
-
-    qtest_sendf(s, "endianness\n");
-    args = qtest_rsp_args(s, 1);
-    g_assert(strcmp(args[1], "big") == 0 || strcmp(args[1], "little") 
== 0);
-    big_endian = strcmp(args[1], "big") == 0;
-    g_strfreev(args);
-
-    return big_endian;
-}
-
@@ -1561,5 +1543,0 @@ void qtest_qmp_fds_assert_success(QTestState *qts, 
int *fds, size_t nfds,
-bool qtest_big_endian(QTestState *s)
-{
-    return s->big_endian;
-}
-
@@ -2000,2 +1977,0 @@ QTestState *qtest_inproc_init(QTestState **s, bool 
log, const char* arch,
-    qts->big_endian = qtest_query_target_endianness(qts);
-
---

But it doesn't work due to qtest_sendf() and qtest_rsp_args() being
local to tests/qtest/libqtest.c:

../../tests/qtest/libqos/virtio-pci.c:401:5: error: call to undeclared 
function 'qtest_sendf'; ISO C99 and later do not support implicit 
function declarations [-Wimplicit-function-declaration]
   401 |     qtest_sendf(s, "endianness\n");
       |     ^
../../tests/qtest/libqos/virtio-pci.c:402:12: error: call to undeclared 
function 'qtest_rsp_args'; ISO C99 and later do not support implicit 
function declarations [-Wimplicit-function-declaration]
   402 |     args = qtest_rsp_args(s, 1);
       |            ^


