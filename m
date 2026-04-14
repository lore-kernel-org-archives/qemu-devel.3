Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21855ED7B82
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCZB8-0001l7-S4; Tue, 14 Apr 2026 04:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZB7-0001eY-94
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZB4-000494-U1
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776155479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANIkrkW9qLCUsv+omUO8K8xqyF/8AkJPe/ZW6RWrjNo=;
 b=O5l3uCDIANjvXt/QBDZlnlyy/3n1a05DtAkkYj0qDYdYMq0mQX771RrRLpzG/NirS0/RXB
 6qpiq3wW6L7XImmrfAz7xiuvWD4IvSpxr51N3onMhpLHQoMqOPfE0hzeFEkfOj8JGPYUHX
 xIZ4eogd7J/N+NJEKXiNOyWD4tc7TW4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-2Xx4-2bzP-OhiiMjVVfHzw-1; Tue, 14 Apr 2026 04:31:18 -0400
X-MC-Unique: 2Xx4-2bzP-OhiiMjVVfHzw-1
X-Mimecast-MFC-AGG-ID: 2Xx4-2bzP-OhiiMjVVfHzw_1776155477
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2e91add2aso24774695ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 01:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776155477; x=1776760277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANIkrkW9qLCUsv+omUO8K8xqyF/8AkJPe/ZW6RWrjNo=;
 b=Q+AsBfMC0Lg5ChthbHKmnlLrjOIH8w0jagpcDhUxm5jv25D6I9hlsim5d/Tol3K9bD
 3f9u7L5/rh8EhdnQut8yygLuMQDVqTmarQEfJH9T9ysBAwq/Tc9Wksqkni0Xy2GM0cID
 HyV22A1U5AkRCp2B8WZ5M5r6LMrJHW7X6aK761FEARHQti9ruXfb4eLevZVmZvXkybwV
 sfTWdSXegKNr3o74cgqiQg16h6RpLhIHgTSnBvlWyvAwsAelJ3hd9NQc3+MSY+IgpzZ2
 Nn2lSryXHxVmIHvk5d4cHeKVRblN8TER4OrL4MyzlxA+hr1jPF4QQjnW20VV0q0N1bE5
 r4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776155477; x=1776760277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ANIkrkW9qLCUsv+omUO8K8xqyF/8AkJPe/ZW6RWrjNo=;
 b=hzKSmuPqNaT4FnUIF0mjsfsJL+KnYSslraDIXDdJzIU+5pZHP14VYebI4MkecPqFH3
 a9TACe1on0B66fAgBWA8BXBygdFYi+uOXanW5DvSBfQmBXmgqkVuUVOknVRIXHCDxjGB
 lceM25/x/54y4aXrUv5zsWg4qfTV1G3boFXRzocCYdPI76lrOFpNFHUJJcSTBJ7eECXL
 kP42kfTR1Nj0AbozZvwweSuHtBVEAvz5pT5Ph1jTj6xMas3PnzHeK75POri0MddHJhXP
 Mp10+MNd+s/0QXF4iE/fzt07V+luGAIqd011CAzp/f5rKpqgDoVV7Z/KpDxTI/LLztOH
 zeCQ==
X-Gm-Message-State: AOJu0Yzr4dyFf3A02//nW9K3aeESd6r8Z9MCW9y1CdZjXuegfps7FyO5
 BWK2bz+DtlqX7fa27x7m0uPzTqk2yhRFTNIu1PhGuuez9bbM+Mx4FQsTcxbBl3vDaIN2IswdC1/
 4Zyg4E6TqBsz+1C0gIxdT37kiqj0XNwSCO7VJyLoNshp+evL7uQfCViuWsYJcNgDgEL6WyslAbg
 Sw3QXA1ltOZIXmKleFyu6+aNCsKyOOejnqIfrB06E=
X-Gm-Gg: AeBDieudIE7P3zz45jfkbFouiipuq6oPJ3bbLqQl5AhklHEVHGryV/zCyKn8p59tObH
 3e19Yddizt487+3SHUXr1IIBr1nAdPqZsskMncYBeeiXuUJdCzHcO/+HXx0nU0kwCiL6X2oQMYd
 ++fZD4y+jesgp7GwgnZU/sAWee/P/7buX77XpMAnBUJ+qI6Eu2qCamcsnSVfud+JsH1bdfFQr5H
 3KkeOF8JQ1zi+wMsEeSHsZNVNxA0NKfSjHYoY/Y0PySYVYfmukwAqR27tegDdPnmag6ggWAB4kf
 KJJidwwOUzmIQWhKohnpQ3IknRpxAGTQuYbhKCgQ2VWdFXhgqX4goTqigb3lN3I7vjiS9/pKdaF
 L1s/RZcoMXGWVXAi9yh0Ed1g+rDlIBD7eh81ZORs7NuE9tP25d7UYOjAHTKQGuCs=
X-Received: by 2002:a17:902:ce0f:b0:2b0:708f:4dc7 with SMTP id
 d9443c01a7336-2b2d5a2a1a4mr184843275ad.29.1776155477071; 
 Tue, 14 Apr 2026 01:31:17 -0700 (PDT)
X-Received: by 2002:a17:902:ce0f:b0:2b0:708f:4dc7 with SMTP id
 d9443c01a7336-2b2d5a2a1a4mr184842705ad.29.1776155476430; 
 Tue, 14 Apr 2026 01:31:16 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4e0f909sm181493785ad.35.2026.04.14.01.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 01:31:16 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, marcandre.lureau@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 10/10] tests: Use ML-DSA-87 operations to caused large TPM
 transfers with TIS
Date: Tue, 14 Apr 2026 13:59:15 +0530
Message-ID: <20260414082915.112122-11-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414082915.112122-1-armenon@redhat.com>
References: <20260414082915.112122-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Stefan Berger <stefanb@linux.ibm.com>

Test a large data transfer with the TIS. To do this, first create an
ML-DSA-87 key and sign some data with it. Then receive the 4627 bytes
signature and then send the signature back to have the TPM verify it.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 tests/qtest/tpm-tis-swtpm-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qtest/tpm-tis-swtpm-test.c b/tests/qtest/tpm-tis-swtpm-test.c
index 105e42e21d..56d2a340c9 100644
--- a/tests/qtest/tpm-tis-swtpm-test.c
+++ b/tests/qtest/tpm-tis-swtpm-test.c
@@ -36,6 +36,15 @@ static void tpm_tis_swtpm_test(const void *data)
                         "tpm-tis", NULL);
 }
 
+static void tpm_tis_large_tx_swtpm_test(const void *data)
+{
+    const TestState *ts = data;
+
+    tpm_test_swtpm_large_tx_test(ts->src_tpm_path,
+                                 tpm_tis_transfer,
+                                 "tpm-tis", NULL);
+}
+
 static void tpm_tis_swtpm_migration_test(const void *data)
 {
     const TestState *ts = data;
@@ -57,6 +66,8 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_data_func("/tpm/tis-swtpm/test", &ts, tpm_tis_swtpm_test);
+    qtest_add_data_func("/tpm/tis-larget-tx-swtpm/test", &ts,
+                        tpm_tis_large_tx_swtpm_test);
     qtest_add_data_func("/tpm/tis-swtpm-migration/test", &ts,
                         tpm_tis_swtpm_migration_test);
     ret = g_test_run();
-- 
2.53.0


