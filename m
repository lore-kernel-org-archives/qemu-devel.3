Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C01EC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76CM-00025Q-6C; Tue, 22 Apr 2025 01:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76Bz-0001pE-Qj; Tue, 22 Apr 2025 01:29:20 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76Bw-0007rg-9h; Tue, 22 Apr 2025 01:29:10 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b06e9bcc986so3296274a12.0; 
 Mon, 21 Apr 2025 22:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299745; x=1745904545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XLyDJb6zuVf07S+Oux/CEamJxltd1syyWyqOmnLXnEw=;
 b=gvhecGrOPzAJliflpm2tfVmJrK0ME/N+zC24q6qsKmLjqMP2DiSv3/qFNZYo9lXYKE
 A72wOolIihpK9Lmuys1o4JduASXSP3sDfNGMn+epTkWne33rbUXzZ+AV63eKpWmf4S7J
 /MQXDzwczBPrPCT9aLgqSIubfRKOYNIMSl6JJ/GGctJ+cx5gq3JukXDPxyBKXkRiXYSm
 igb6MJsGZpleRiUQKrTHVUrUaetge4xlYlIFB+PNWVBoZkx0P53QsyfWiOq8tdtVmjRl
 v8UsOK5583x2cr5H+wVGbORR1i3eo9E8ARfuqg7TOgKsQ+Py74DWQB7wWPYgxVpmxcrZ
 OXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299745; x=1745904545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XLyDJb6zuVf07S+Oux/CEamJxltd1syyWyqOmnLXnEw=;
 b=GUG/iA8i0abA79hwrNqqJyJZEXzAzMdcVVX6uEZKzO7U08bXoeqBtG+krs6vdeamaY
 Myq5oVj0Qz0aeTEOTYf0OmOjMsUSv2c3IiVQV/jS0I5uC9oAIMCqqNvNM/xjBSu18XmC
 aDMSmqZEg6DbZbRLW+ykc4ykHlSDHB6XhV+mn5Eo3skvTtAK1V8Nnvt2yL5TgBAAj2hs
 B6dqbsxkfjI49+OJ9Q+pBw5n7ZK8HexxSCmvdw9q4z0tL8qlymE4sg7FMlXIYFvEI7JZ
 Db8+G5/TV9T2NhE8KC7mSloAc1UIcJKpiW5T2SjuqnT940DAooxfdroe3ULm3OyJuUQE
 6yyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4wbPnA7ATsejZSajK900q51Lfn0xP6LjnnxOPMx6e7itkBRZiQn5L94yjaGmFfrv9/tOhVivOuNUfyw==@nongnu.org,
 AJvYcCVHdYTlhs3tMWb1/ZpAQZpmNIXuth7T7DoOE3gU60nbPvP4GIQOriLQAhjPoY48d3lpbjJ7eDjjTf0=@nongnu.org,
 AJvYcCVTdq6QRpw/il/HjeEpn+EqJjrS8WFeE8R/+L58d/dqinfmcfI+q3FLUah4yT34vq3udAVZDV5se/9kHQ==@nongnu.org,
 AJvYcCWVT3C+IllJpG1wWBiBusRLfgvnfEE1OPqoWr9xYoVHeZMCCQwJGEssMWyXiTTZpdQWrQi712aU7g==@nongnu.org
X-Gm-Message-State: AOJu0Yw0FrQhdGE/0O5xhWg7a2NX+TKZ5XrXTkKXuK8ShkRgZ6fXLt4h
 9QvTsH2NrMlwm+NrtmK5weFcNPa5guJEGjRAs1W5gerjwlerX2ioZOsX6PMH
X-Gm-Gg: ASbGncsk7yEu4UhyGJzUooiiTfwVuhHRx6IaYatorwpINFzVCliwBz7/l30G6P8/HTB
 VYx9IN2rxrIIYsFnetyuZBuAvm/vtnNUjFBC0MXsL9DgR4s4W4wdm6yCOnvk8kk7H9ZiiHLTPHX
 t2mEOLluRFylbYGXl/HblwVks6KxAxOmjVk0vvzaL5IK7TW57raB8zGWZDAgkj2gDCrqKeg6KKz
 kXMZ8rQfhBU10wFwcU1uVnmNA1uloNawqxDvEefxhTUzgAF5qc226QADyBrWnKjDF6FT4dlcWxI
 xz48v+FRiWiPMbl2mrc21lYQ+IlmY/lmezviEuwVE02KWi6RRze93ao4rQM=
X-Google-Smtp-Source: AGHT+IGli9pUmcY3KyTzbFBRjFgDu1JXXm31EwPT7XYV1PhrrsboM1x/7sb3HIGZTZeVLj7SCvEwRg==
X-Received: by 2002:a17:902:ef11:b0:224:2384:5b40 with SMTP id
 d9443c01a7336-22c535a7e46mr256405075ad.24.1745299745436; 
 Mon, 21 Apr 2025 22:29:05 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:29:04 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 08/20] target/ppc: Fix type conflict of GLib function
 pointers
Date: Tue, 22 Apr 2025 14:27:12 +0900
Message-Id: <255824200579431ecaebd32006bdf7a89d48ffd4.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Emscripten, function pointer casts can result in runtime failures due to
strict function signature checks. This affects the use of g_list_sort and
g_slist_sort, which internally perform function pointer casts that are not
supported by Emscripten. To avoid these issues, g_list_sort_with_data and
g_slist_sort_with_data should be used instead, as they do not rely on
function pointer casting.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 target/ppc/cpu_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

V2:
- Updated the commit message to explicitly explain that function pointer
  casts are performed internally by GLib.

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index f81cb680fc..f03e48ba31 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7115,7 +7115,7 @@ PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
 }
 
 /* Sort by PVR, ordering special case "host" last. */
-static gint ppc_cpu_list_compare(gconstpointer a, gconstpointer b)
+static gint ppc_cpu_list_compare(gconstpointer a, gconstpointer b, gpointer d)
 {
     ObjectClass *oc_a = (ObjectClass *)a;
     ObjectClass *oc_b = (ObjectClass *)b;
@@ -7183,7 +7183,7 @@ void ppc_cpu_list(void)
 
     qemu_printf("Available CPUs:\n");
     list = object_class_get_list(TYPE_POWERPC_CPU, false);
-    list = g_slist_sort(list, ppc_cpu_list_compare);
+    list = g_slist_sort_with_data(list, ppc_cpu_list_compare, NULL);
     g_slist_foreach(list, ppc_cpu_list_entry, NULL);
     g_slist_free(list);
 
-- 
2.25.1


