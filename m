Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A83DC369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9IBQ-0003YR-VB; Mon, 28 Apr 2025 02:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IAd-0002mx-CS; Mon, 28 Apr 2025 02:40:58 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IAY-000764-Dn; Mon, 28 Apr 2025 02:40:51 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3012a0c8496so3428541a91.2; 
 Sun, 27 Apr 2025 23:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822443; x=1746427243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYdISxmnAJp9R0AxjdKJ9MRj5xSuzSN2i3eHaLqf1tc=;
 b=EvqzRr5Iy6Hoz8lYlW8ry9HlFYpiR3H2eU/pS6wwE7tMsmQ+ZsRxUF71A7FE0ZfMm6
 L0l7ug9yDxXsEvFFMpLNBmlWY9WM7zLwA4lPyVlE2j9Exo2ieG6gro2SH1vai7Qhios2
 QoRurXaTlgAfy3/iKiZyLDd5GyI3SxvlOXkimvx42ZQX5xgSDr5+lW6+dBcIien8lIHL
 F+yL9DSlfEFCbIwDwuAwmxWi8qltlRcP0hw1Jb4dmuC50f6aYGyhyDaJ6/aURFtx66qo
 UAfJIYfDUoBZIrqFXKQnIWJqmBuQ0URBczDXEu7fcd6ufD5Ha1ECdvMjcrsQ2b6/Y8n+
 nbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822443; x=1746427243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yYdISxmnAJp9R0AxjdKJ9MRj5xSuzSN2i3eHaLqf1tc=;
 b=qLAT0aHXfeIWoCcneztWbz723rBCzVGnt7/6ojXhyZIxs4kvJCKwK1AmUpr2cE16jW
 /Oy9R+ci86WeSCNl4DP/L4t/WCeTjtNAOXxdcZnnnc1KT3CpilVIskjlt7BP8m0xWuo2
 j056Vg+GEbMOUf5aK2XQStxluiEGgSO/2F3TohtiUlEvuie51HhaThgHy7l4EOFB0Cn9
 C8VM2dBssmlEWpu7UpVMKEDlKjXHm8B488xWr1v09buHRnIoJ7bDaW29wXpTNnWgtiHB
 WGD8nLtkNOdysG1gXteO9oP9l65nsjENrlUclMtFxqq9fKYkynujCJwwlYCqBkyLfqOl
 ZhSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY9CX/JZ0WmxXq0q32BqYje307RPetIvN/NjGCJ8eiZkjRJ0c+mWAhroXSWT+bjz31/OiIkGpBxw==@nongnu.org,
 AJvYcCWpu9ThJfYfZ6fXIbwoRRvEOuaCPv75sIrr/p9Fv97o80xYH3ocOYN4pI+KO+OEDaKv3EVsCSMtCVw=@nongnu.org,
 AJvYcCX545fwGLznjoxvPxB5ghJoB79Pk3mhD7hG+5hFNpfTOmsj/kVqre/nhQEyYkIET+LcTft7J3SJLqS+tw==@nongnu.org,
 AJvYcCXQWzoJX5g6BCDqiiyTjGbY3ot7ixFxUdBPRPAIMdT7ViU+ubTKB3Sm758YrgO5AiAco1I4PuCs2ngXFA==@nongnu.org
X-Gm-Message-State: AOJu0YzryV5DtF5IDPDgbpK22yAUWi18NV9csiNZwVTRNYMmqTcwY4u/
 UWgIDP1vPZyicwXKds6f07gxo3Ms7QJtpiDJ+3NK8ypmNu2nSDcgwt4/h49g
X-Gm-Gg: ASbGncueNns84UILY7kTt/jFTn+SqXdQaFLBzuRmAx4GU5YUj0V+rrdbDWSNUW3G4MF
 yT6iuCwlb/Wxwv8uqcZ19Nw9jb4loa2rHejT+bNWHaXVuZ1dmSrBUoFOwTk0kZErVMcCEffoA0F
 gB8eUnX/zwWAeGJkKoCeJzqDkHXYpg0S9VFGmMQ6q5EFfhkDKPvL5eAN1WhzGPr33AjBFmgXNHw
 UUiwQNPM9K4ofWAzJJeNPYlIvN1o7/VErYzIsq3YfW9GDi4qti7nt1WHKSQWxezL69cTjFz133/
 RAoJ9NnKnfEFRyegof7ZTkCOwn0KGjNXWuD8dA==
X-Google-Smtp-Source: AGHT+IGxE/qSj9shgLPWH+whxB6DllaPY4tO98UowGZez6SHfn7EbMFVoUAgUeFD8pEQ4gF6JNUKZw==
X-Received: by 2002:a17:90b:5407:b0:2ff:64a0:4a57 with SMTP id
 98e67ed59e1d1-30a01398791mr9653604a91.26.1745822443492; 
 Sun, 27 Apr 2025 23:40:43 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:40:42 -0700 (PDT)
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
Subject: [PATCH v3 08/20] target/ppc: Fix type conflict of GLib function
 pointers
Date: Mon, 28 Apr 2025 15:38:57 +0900
Message-ID: <d917055d35f5ff7316ccdcbdf57af9a7bd85bf29.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1034.google.com
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

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index fde7d71fc6..b070fcb637 100644
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
2.43.0


