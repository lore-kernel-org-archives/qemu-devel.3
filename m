Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBE4C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9IAk-0002kP-AP; Mon, 28 Apr 2025 02:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IAT-0002eV-5V; Mon, 28 Apr 2025 02:40:41 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IAQ-000755-Jr; Mon, 28 Apr 2025 02:40:40 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227c7e57da2so36448995ad.0; 
 Sun, 27 Apr 2025 23:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822436; x=1746427236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5KG3ys+zAj0YETOqmeP7cGbdHvPb7QsrrfQymJd8O+8=;
 b=EPDNQYd60PCvUwkp1CsqV6gD5WnbbXNCi/9z8aJLBBMiK9WK61y4cM+TxzjvDZtOQK
 quwk1XRp6K/ouTvHFrrLC6VazNxp3msnrNuOq+RTOHepMeH6VbQ3mosUq05+81t/ysOi
 vzc8S8wjeay9x1YyLtfRyMe11ffc6E3qeNs67jT6mgF3C0maUtXpJ1Yi5sN23spUsZRl
 F/8U8JLwZePfZT9TBQ0QzqK/58msdfqPIiXTk9v3Qr/MjnoL+M+1COVxgkEX26EVXMFp
 PM415MCNnQIqmZoakW7gsYtryfjtVJRZyI2f9tOKIv7+wBst7xqIIZvb4YO3Q0oFBV7v
 at4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822436; x=1746427236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5KG3ys+zAj0YETOqmeP7cGbdHvPb7QsrrfQymJd8O+8=;
 b=W1y7EVh6kmk1/jl+7JL79bPbaSztM877Fh6ILVCwfHQziPlCAZmbtLzAtBw/XBlFTL
 2DYbHBmftImiQ0wb7N+DSyzpWnpztctaErDnUDHwCUYB9j37xMDZPKa0rdkRoPRIuoqO
 auTe1T6q0qKxrk4tsd7+SS4Xvc0DeqTbCXqpEO7Tw1Xpv8IZufLsGgH5vebEuiBdtLKW
 0xA1QSNQdb3f7FZfzvLq4GR5P3JFg6Vrjm3dpffD4Xr3IR4bvpIsVE8y+DnTrqmjbdKG
 1NefXzol+/iwUCG5LTgtBKd1wPDgLV7z7hFuZX79pD5A9tjDdm6i40PHRlElGeYx0St2
 cJbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWqvqZ26jWUXXjE8oZ+i+aIWl+3dll1dqapS2GKrqJN1MYAQ+PAIBYWNRilPuLd+i0nqGaomzhnDs=@nongnu.org,
 AJvYcCVQovasqbWGeX2WPtGWhz/HqEhmgesV0sq/UQ4ALw33Iv05mj75pfI5Q7yodqOPDJx90Xq0ASF6E3+yCg==@nongnu.org,
 AJvYcCVhYT+bPwOycZyZHwxV9dFPm2ZbzdsHMnT0L/nEZmjWfXsU5XznwIgK1TbQPmKjN1YK0Zyf/LLtO4EcRg==@nongnu.org,
 AJvYcCXq/+s+qxKqLK+SWAgUuFaoKyc6hCFIRGm9oraPpwqEqqdSVEuu4X9TK1Nh9FVKmrQWuOIuJ4ynhw==@nongnu.org
X-Gm-Message-State: AOJu0Yw1ttKAc1tvxZRjJIQEe7SrQ0XSO3wJTTzm3+/8Scbk93aOolxR
 I8X61pTFJhT4qmFAQQm5DkSYQGmjjr3N6gj+A6B2LbCg3nJQ/RhKrQBidHsq
X-Gm-Gg: ASbGncuDVcaxJiTVCTvk37sQ6G8pu8S1zKf3gwERCFwkxbGeu+Lue6rdLtMI+O79gzr
 KaqPZGY9zqE7zW+7a3YCa4EWuIhE7Mx5bkr2WBGNZQtJg0SIdB7Q/A6QLQwVmgltJOrtLd51mtv
 YlDg8EVvELsRz+jQ0J5waAp/6R9qjfm8i+nW30Uzmx6gi58u0I5Cwvaf3sfiWnE7c4lu5YUyY6t
 kKkEbriac6NN7UCp6LK1Pm3FThM9/sVzVTcI3rG8F5GI6x9YoJlsdYKwrWRL2e6CSVGzUDy7OcW
 EZdlw6JfEWbbvrslf7SjslW1nR1TuL5/evKABA==
X-Google-Smtp-Source: AGHT+IFwGC6KPL901dNt4Pvf1ez+6eS9Jh4yCu/CPGqZj0aBAx1/EXuIDBkRhG8Nw3jpPT3vkP9g7Q==
X-Received: by 2002:a17:903:189:b0:224:18bb:44c2 with SMTP id
 d9443c01a7336-22dc69efad8mr95438035ad.6.1745822435857; 
 Sun, 27 Apr 2025 23:40:35 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:40:35 -0700 (PDT)
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
Subject: [PATCH v3 07/20] hw/net/can: Fix type conflict of GLib function
 pointers
Date: Mon, 28 Apr 2025 15:38:56 +0900
Message-ID: <937d1feaa739a8f5be8d55084231f085ac9553b2.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62d.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/net/can/xlnx-versal-canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

V3:
- This commit is included in this series sololy to ensure successful
  builds. It has already been picked up by a pull request, so please ignore
  it.

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index b5a4a4af7e..bafe50f5a7 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1278,7 +1278,7 @@ static void tx_fifo_stamp(XlnxVersalCANFDState *s, uint32_t tb0_regid)
     }
 }
 
-static gint g_cmp_ids(gconstpointer data1, gconstpointer data2)
+static gint g_cmp_ids(gconstpointer data1, gconstpointer data2, gpointer d)
 {
     tx_ready_reg_info *tx_reg_1 = (tx_ready_reg_info *) data1;
     tx_ready_reg_info *tx_reg_2 = (tx_ready_reg_info *) data2;
@@ -1316,7 +1316,7 @@ static GSList *prepare_tx_data(XlnxVersalCANFDState *s)
             temp->can_id = s->regs[reg_num];
             temp->reg_num = reg_num;
             list = g_slist_prepend(list, temp);
-            list = g_slist_sort(list, g_cmp_ids);
+            list = g_slist_sort_with_data(list, g_cmp_ids, NULL);
         }
 
         reg_ready >>= 1;
-- 
2.43.0


