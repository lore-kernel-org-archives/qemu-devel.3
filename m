Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8E9F9B60C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUrq-0006xQ-3w; Wed, 22 Apr 2026 06:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUrl-0006uz-E7
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUrj-0007B8-DW
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776853890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANIkrkW9qLCUsv+omUO8K8xqyF/8AkJPe/ZW6RWrjNo=;
 b=VhLdJGo5hzWqWWDIzIgx+BbtmP9YYP24v/1NyXz0ethWTyKdrqA5kiwWb1Njxt3+bjsc8V
 bgkBO3OuGZInaqfmVkdISzWxir+vM1y2Yl7Oe3MJ+vBbdRfJS4Q+yurVxPAcd4Sod71O2R
 drLQxf/5MTr8NXs5MqVbK19MPokbmHw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-xo2EI-hIPTuvxmIOjWeRrQ-1; Wed, 22 Apr 2026 06:31:29 -0400
X-MC-Unique: xo2EI-hIPTuvxmIOjWeRrQ-1
X-Mimecast-MFC-AGG-ID: xo2EI-hIPTuvxmIOjWeRrQ_1776853888
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-358f058973fso6470328a91.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776853888; x=1777458688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANIkrkW9qLCUsv+omUO8K8xqyF/8AkJPe/ZW6RWrjNo=;
 b=Rd6lJlbzDtg6nV1SI6yxLEte+nI9sgd/Y9UTVT5A2hQB06YGis4bHr439BnvyyBFYO
 wALTNB/vyvc8QMpuM1MXNKgWTkbT+9uHr0+j2KXT6U+llYdS1SVV8vAYALGXCxk/1LFl
 nR0JMuuFSPosTGJAvgTOcjHU155GN1F7mAY5an+aNU46ft9aTPuJMOCwuaMPAlbD8G6E
 IC2IIuQLawJ8rUjHAo9Lx0EvTBNnEpzAOq47O+mXOdPsJm0t9Z4ZnhhmkT5hLGnXcBwZ
 PLkbhFs8/emO9B6CFfYY77pvwkbkVjwbXjYaQPepqcSsWR1DHbM7iDOQFJEaJ0wnDjGQ
 MX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853888; x=1777458688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ANIkrkW9qLCUsv+omUO8K8xqyF/8AkJPe/ZW6RWrjNo=;
 b=oB5JClw16lQKg8zj/BsNC0WyBYfm4Ck33dlxCIRpuh/DiOxOwbrVG5/kmxftptJ5FK
 BGN+CNZYRYQNfP6yh2jmLKGXR2YBKYoxPF90ccO3io6z6R0AM4UPMauQJtR0L9q4rVev
 3aLbR8JyFWmZ/W84Q4zzu1zYWS6RUqSrG3gJ2DiGx+zGuFfzOqFYC0C7eqrhD5a5RxjQ
 bel997PwCd+TNnOtIr6FxwSs8duM+kxvUxakMzK1JIPR7G482cNeU+gTK5OXFaqscmlp
 BXg0w/UMxxXNuR+T5gSvRMuUm+NmJAwZkk5F1wjeRyGljoBIFCdGzMYCcSux8UkmmEEF
 ljLg==
X-Gm-Message-State: AOJu0Yzji4igOnYUHBmVgX4mbJ747FMGNKcQuAJPSzCtW75A6rqD8CA/
 AzIUIJa3sLGD4RK385W23JiTmv+d3gu88pNJvS4vyghjUzgdnpeAyB8Z3jeRwJ7OeospNqAUD8y
 Bsq3SRPo+u305rWtiNNRiqRScMGXr+yIlMa1e7rNfx9a6NtrlxVkf8g500JaAvNyN32FdgCs6TA
 DyJTidRsVAYcrYaM80mhnl+jTfFv4NOewO22Cj+hw=
X-Gm-Gg: AeBDietTW1CoECzneyK0Bnk+kD/WPSfw6GSBBwj/gT92TxV1/VUkIYVgWtcvDfXRbt1
 Z4Ic7eG0TPUySzm3nKxE27wSR4vrlyKVRDWROdUTV0BjnIRwip89+pQczHJW1ZZtnWUSFb8tb6c
 Nr3eLNEu/m+kQ9VaSk18sNHEFEWC8tkOa8bbAMAofnoOeIcZ7XgPrZyW/E2w8QJftN4ZUcddmFA
 feLEF4Ip0mUT+7c76rGWCDtdl9ZqD7gzSKaYBSXS5ofik6VgVdrrssfoWTQ5LhuUw+EZORsAFqa
 /GPPsssuO/tE27xSw2Yg1VWlqUzlJxKHcvRERrJPpwo+GgA4DQXK9b/V6vTB5jpgmCBr8lxaXXC
 P2jIY6Usl5MMf7mfRg8O4XjNNFIXPTftaL3QxClQZuw9NAgKKyN1DO7G9bSHcqGef3FNob/mLqQ
 ==
X-Received: by 2002:a17:90a:e704:b0:35b:9896:cbcd with SMTP id
 98e67ed59e1d1-361404b9b70mr20767884a91.27.1776853888160; 
 Wed, 22 Apr 2026 03:31:28 -0700 (PDT)
X-Received: by 2002:a17:90a:e704:b0:35b:9896:cbcd with SMTP id
 98e67ed59e1d1-361404b9b70mr20767828a91.27.1776853887513; 
 Wed, 22 Apr 2026 03:31:27 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f920e1sm12589666a12.2.2026.04.22.03.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:31:27 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 marcandre.lureau@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Ani Sinha <anisinha@redhat.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 10/10] tests: Use ML-DSA-87 operations to caused large TPM
 transfers with TIS
Date: Wed, 22 Apr 2026 16:00:18 +0530
Message-ID: <20260422103018.123608-11-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422103018.123608-1-armenon@redhat.com>
References: <20260422103018.123608-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


