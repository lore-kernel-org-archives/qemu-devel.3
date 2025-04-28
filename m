Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A49C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9IAL-0002YQ-Sz; Mon, 28 Apr 2025 02:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IAF-0002Wv-SG; Mon, 28 Apr 2025 02:40:29 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IAE-00073C-9Z; Mon, 28 Apr 2025 02:40:27 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2295d78b45cso63358825ad.0; 
 Sun, 27 Apr 2025 23:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822420; x=1746427220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bvi4Lt8goFH4Fe3VIBwH2k0EDfUx31JuXJkL+iD5/SM=;
 b=fK8a96rdeU99YgotPr4h8btF7tT3z/i/RjsUP7ewXSZj8zG5LAjIbcAKOMbIUgK24R
 SoxjSalqZG/PcNvXG2+w4ipc6wVtJhsB5eFhzUIttPJ/rN/C8lygRewcQHNYqMKfxSgk
 LGW7aryksuHKJm8HVD+DPOAuoxjwmkqOKzXzwXLMeyDWJmvIKMAWCyKzrZDHLIwCm+Io
 4WiIwir+okM+MDv8Cokp46K/0UJsEkvtqQwP/YBKexECFVk6zFXkvEzY3LjFEaCGNgak
 L2mhHIj56tFBY6VoojPJFoWv/kJ0X1YDQqyyg8Q4LFRTJZNtPee+DGiOUhk7L7hxHfhT
 jB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822420; x=1746427220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bvi4Lt8goFH4Fe3VIBwH2k0EDfUx31JuXJkL+iD5/SM=;
 b=iJw0OyRkH44BtlHkralzOvryhtlfA90FDEOfCmIfotpDUO5jDKEDxMiFHhh68n47i7
 hOa3AjjY9s0w4CreliQCqwEDsYkD7uZRTfpwizHOujogL6ysomh3lLKkQnE7vWueWSjs
 b7QXG6Tbxh4eMRZ7rOZTh3NLAmiuxqdOb7czoOHPetgHcX5vL7kS1Ck7i1go2hea6H2g
 uJpPPnF2o3GPFqNGClPr/IWQ6UhCaV2rp6haeANZU0Qw55cDuFWMnksWeJsYfTFY8z/S
 dZQHiWXGLX0ZyFI5ig8DAmgmrS94M2sCGA4wa6Fa1Qv6BNaa/iaazISs+S/PMEcnmO1p
 uagg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQV8UPBqSGkxqjbgrFjSRunKu4l3jTWTgX/rRFlcItGGiD2f/OEYES+wcDcwGOKh7/K3lCV5i/KYtsNw==@nongnu.org,
 AJvYcCV9Hgz21hJOK1NXXV3dwA0n2j9Om5SkqgSm59WqA/h6vbdSCMOKj75sWwV7Qp440gZvaoTa2rUAvA==@nongnu.org,
 AJvYcCV9mMkA1MsdzJFfvSPVa2wX0XOeXdk6zrV3AyUwzGbEW1UZcVq5jGVYp9CU1+jAVYfAFLb7XgcFfzA=@nongnu.org,
 AJvYcCVBO8fmClqjOcjqwpJqEUr9+qdlS9PwIlel8kllpwwSz2Jb9o9aMIURYDNGXtwLsuh5bXU0gvQTEKQDtg==@nongnu.org
X-Gm-Message-State: AOJu0Yy5nDAWSmeNPIIG+Mw1zopUtLbyKaAolQ2N9Kx7XC/hZWMz1C3s
 GsGnB0E93KPAupPQRfSZb3CWEqnDXkSz25Jrz4CzzkCEzGoaPdhGcgY1ix7g
X-Gm-Gg: ASbGncs9HXJ6dzxX8qSdp/QSgogW/C3G4YQeRBVvmW5KHdySZ6fd3Ir+BYDuUtevsHu
 k9t+2+Ft9cv9wyv3DZfSzdpgSD7NBKM1Lg0W11DV9Eg6ZZqAEncyzk4dsL0O2RDrKlk9ZoUGgZc
 5Qgie/HrshjeeQB7p1/3b0H1bXPCtUOuO+RGTgpnbIGIVZhxUfm548uEMciovnyQG7kUXrAe0Da
 2KIuxIr0ilJ4Ul3PfEK5UZHekcUrCLithWrNNDe+vrKIly2kIT9fxgjbicr+iGh7bz5er/XL48d
 QzGmq3+zH5PmxN3vZ13uJXVF6225EkS6xoiTqA==
X-Google-Smtp-Source: AGHT+IEKXQ8XAG9aG4IJKUQ0712Vhcc3ATE2DfxiXf5irIpidBAU+HevlQue4r6tw4Q6Rs89//wyhQ==
X-Received: by 2002:a17:902:d485:b0:224:1609:a74a with SMTP id
 d9443c01a7336-22dc6a6851emr115611895ad.34.1745822420006; 
 Sun, 27 Apr 2025 23:40:20 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:40:19 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
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
Subject: [PATCH v3 05/20] target/i386/cpu.c: Fix type conflict of GLib
 function pointers
Date: Mon, 28 Apr 2025 15:38:54 +0900
Message-ID: <8ee6c2b02c97d5db358c3eb290d00afe71d1ceb7.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x631.google.com
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
 target/i386/cpu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1f970aa4da..fedc47ea84 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6240,7 +6240,7 @@ static void listflags(GList *features)
 }
 
 /* Sort alphabetically by type name, respecting X86CPUClass::ordering. */
-static gint x86_cpu_list_compare(gconstpointer a, gconstpointer b)
+static gint x86_cpu_list_compare(gconstpointer a, gconstpointer b, gpointer d)
 {
     ObjectClass *class_a = (ObjectClass *)a;
     ObjectClass *class_b = (ObjectClass *)b;
@@ -6261,7 +6261,7 @@ static gint x86_cpu_list_compare(gconstpointer a, gconstpointer b)
 static GSList *get_sorted_cpu_model_list(void)
 {
     GSList *list = object_class_get_list(TYPE_X86_CPU, false);
-    list = g_slist_sort(list, x86_cpu_list_compare);
+    list = g_slist_sort_with_data(list, x86_cpu_list_compare, NULL);
     return list;
 }
 
@@ -6318,6 +6318,11 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
     qemu_printf("  %-20s  %s\n", name, desc);
 }
 
+static gint strcmp_wrap(gconstpointer a, gconstpointer b, gpointer d)
+{
+    return strcmp(a, b);
+}
+
 /* list available CPU models and flags */
 void x86_cpu_list(void)
 {
@@ -6340,7 +6345,7 @@ void x86_cpu_list(void)
         }
     }
 
-    names = g_list_sort(names, (GCompareFunc)strcmp);
+    names = g_list_sort_with_data(names, strcmp_wrap, NULL);
 
     qemu_printf("\nRecognized CPUID flags:\n");
     listflags(names);
-- 
2.43.0


