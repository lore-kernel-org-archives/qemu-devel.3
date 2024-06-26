Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A017C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQVE-0007Bd-L7; Wed, 26 Jun 2024 07:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQVC-0006wT-NL
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:07:50 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQUx-0004rT-7y
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:07:50 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-71884eda768so3148265a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719400052; x=1720004852;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Yvl4pAdGzIA/y7zkDQtF9iZK7ptxPpuy1nIWlUirby4=;
 b=RaX/RR0RVcL47N6gFfw+ZCUD20pZ5aYjajuvAQCLLup4OzYcfm7ziRV6vXpR4yL0EI
 DsM2KzHyFrpfpHHPAV6/5XgUUbciw6PhXKEJn1pe5nfVoFthpw0mfM9mPJxq1NDZhM51
 a4yMRmyZ3wfIp1AIW/S0KBl8AdlZXoQrLVrPFsA6jcjhHQc1bnP0Urqc2/vdi+eOAQ9C
 D/iZQa2/+3wT+49Hpk87Q7iiSb+yRws9X7xDQBMqv2XS5WOsBQJRl2Z+3tdGwxo0jsKO
 xNESN9n5BeCJ8Gv7E6zZ8yLgIM1E1Qmuk4N94bUSfEqQRW3JBmlK8tPY5FCK0m62941Y
 gjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719400052; x=1720004852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yvl4pAdGzIA/y7zkDQtF9iZK7ptxPpuy1nIWlUirby4=;
 b=qAXb5NoekInFXwnCIzxEXoNOIkX3QYMdMpX2laVfIXWs0xswZ75q07FOLhKh9tBK8O
 2IXb59lyHT0B4Q5YFLbyYGs9Q5YMkNGsxzvMDq5Wr0/HxWg3z5vO/thLnhae4et5Vh8N
 oJotljoo6zNHEA43YnUd5likB6h0zwhDHGa71JUbqbw+SJHOCZrek7gnKUZks9DMGxnV
 7Jzhgh4HuSlHm09HSHSES22MPSosAEqUCitGZID6erI04rEHGz6v8qCYTjCbhsNnAMB7
 NffrQoNWtudzNEmHkOZZ6exlwim8RMaWbIF8UQ1Fmt23s68hwLWRDrzabywvjYjeXI8n
 HrjQ==
X-Gm-Message-State: AOJu0YxmW+C05MilVwiShVnXncjRdLQJPb1pdnyp7AGTCXIxZ+NAFF1C
 Unv6+WpUfdXKmL198k0idmmNaDqckajdysjC2wqFY7Ub+SZa37uArNf8fZKPh7o=
X-Google-Smtp-Source: AGHT+IGNy/dg4U98Mw6L58Fmy/xCAk1HTRjbu/c/K6qeFGwdBgIn6n/Pydp7aNAArHz0d6fsSKBO2g==
X-Received: by 2002:a17:90a:c28c:b0:2c7:cf90:bd13 with SMTP id
 98e67ed59e1d1-2c8613d2058mr8807637a91.26.1719400052622; 
 Wed, 26 Jun 2024 04:07:32 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2c8d81d2a9dsm1370410a91.54.2024.06.26.04.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:07:32 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:06:32 +0900
Subject: [PATCH 09/14] tests/qtest: Use qtest_add_data_func_full()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-san-v1-9-f3cc42302189@daynix.com>
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
In-Reply-To: <20240626-san-v1-0-f3cc42302189@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_NONE=0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

A test function may not be executed depending on the test command line
so it is wrong to free data with a test function. Use
qtest_add_data_func_full() to register a function to free data.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/qtest/device-introspect-test.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-introspect-test.c
index 5b0ffe43f5f4..587da59623dc 100644
--- a/tests/qtest/device-introspect-test.c
+++ b/tests/qtest/device-introspect-test.c
@@ -266,7 +266,6 @@ static void test_device_intro_concrete(const void *args)
 
     qobject_unref(types);
     qtest_quit(qts);
-    g_free((void *)args);
 }
 
 static void test_abstract_interfaces(void)
@@ -310,12 +309,12 @@ static void add_machine_test_case(const char *mname)
 
     path = g_strdup_printf("device/introspect/concrete/defaults/%s", mname);
     args = g_strdup_printf("-M %s", mname);
-    qtest_add_data_func(path, args, test_device_intro_concrete);
+    qtest_add_data_func_full(path, args, test_device_intro_concrete, g_free);
     g_free(path);
 
     path = g_strdup_printf("device/introspect/concrete/nodefaults/%s", mname);
     args = g_strdup_printf("-nodefaults -M %s", mname);
-    qtest_add_data_func(path, args, test_device_intro_concrete);
+    qtest_add_data_func_full(path, args, test_device_intro_concrete, g_free);
     g_free(path);
 }
 
@@ -330,7 +329,7 @@ int main(int argc, char **argv)
     qtest_add_func("device/introspect/abstract-interfaces", test_abstract_interfaces);
     if (g_test_quick()) {
         qtest_add_data_func("device/introspect/concrete/defaults/none",
-                            g_strdup(common_args), test_device_intro_concrete);
+                            common_args, test_device_intro_concrete);
     } else {
         qtest_cb_for_every_machine(add_machine_test_case, true);
     }

-- 
2.45.2


