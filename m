Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F02C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9IAJ-0002YA-QX; Mon, 28 Apr 2025 02:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IAD-0002W9-LM; Mon, 28 Apr 2025 02:40:27 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IA3-00072q-Mq; Mon, 28 Apr 2025 02:40:25 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b0da25f5216so2684952a12.1; 
 Sun, 27 Apr 2025 23:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822412; x=1746427212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDAIV3MAAhgPQVTgQ5ZP+CvmOSVz4UfgoRFflq2h9Eg=;
 b=kM6qoHO1HjK97vtVWyusdK3mmUVTsuMnfkZ59iXGE/gtsNHehuBo57yTbRgqi2DBBa
 /Bzwee7AlZyfw2LVzcUOGZlqdI1v+4oK92ubxUH7zCt6T/MBOu8Tiv29+PfVYJTZqy6k
 WzwzmRARKfTmqauxPLEnr8LPBn6uoWOXeOptJknXn871dJK01t/NI9oPWt8BkrlLTWrT
 W8cAEv0+wyo1CqjLkfJcXNsLetJlh35oAjIoKGmwZxA8q6NumCCn7xatoOKhzpiURwLr
 +8QszUBnL2ELCg7qLZ1kT/KOcWWWZVXwiM3KaX/AqFtwJoJhjerRNZm/Qk1yESDAi+zx
 f8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822412; x=1746427212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDAIV3MAAhgPQVTgQ5ZP+CvmOSVz4UfgoRFflq2h9Eg=;
 b=TdWFMgCnwqOvEpB+qYYsXA9qGH+8EcYMxtho9FH/pDhCFeR3QrLTWoQnBZ9qy56kcQ
 4gCPI0IYKZKJSX3iBaX3Fbq7UEQ0CqQwgqe6ENKCyjulbS+1v6XrFPoj5LlQaJFsksX+
 Zt8RKrAsw5eaALn0INdyADv6NXgylHpnByo4JT0NNrgGWDkgD5kJre7jTi3Y0XIkqh/7
 LXjElpe2MfDdzoLlV1MbVqNmMAhvZa0cQhdQeuO+P/ONRTu08YyFFUMPC96+8H+p37Wg
 72e3rdmYRlp947U2cJMHXtG2GQRIgxxhMqPSuJt38E1OvjmANwJaYhh5rIyKndkAyea5
 0z4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHtONdNBJ2qsoBhtQOdbK9CbybZnE2Crvw4riOKxCDD4XJnMVVVRxqy3eCRs+Km5pmSwL0DGZc4A==@nongnu.org,
 AJvYcCVAyX6fqzKwbhbQ9Q75jpBKuAouErEZ9ckrBOjnXToe5d42t19kp0NK/UwUmjUjAVvdzKYlc0/NCW0NUw==@nongnu.org,
 AJvYcCVpCsQhJFE18D0IS90Z+ezIXXN0lIrazkBqYzjPy7Y6ASEFBpoCdwwkR3Vf0tjr9ETLY1kcZzeB8+Yzkw==@nongnu.org,
 AJvYcCXyUDMI7dAKBoDsl84gSm+Dn+aboY/LCYwBSBLru2Oq6KYNlces69rJhRkkAJ6yDv2e+ZuNGkn06fk=@nongnu.org
X-Gm-Message-State: AOJu0YzLxxizOK1nPSQskWsgcCvTu2Jg82cmcX5B0J4fc1dD/iJHcazm
 nxUiVBd3Orujum5aMp6x6Yg63xqU8K/RefMPBXIHQm+5NkbAYI8ISpS6Tfqz
X-Gm-Gg: ASbGnctN3dMj/LGMiBV+9Nlr4uC0ZLFJiC9td4gyKW9Ie9yzrFlp3GkYmYzj9I2dHC7
 GY0/QRhf5c3/Ql+WzYJyL4usjeDS3AnX6XPmvjv8c02DQacSLxA6Sz7sTKLqpRvb9GmmqiPS8M8
 DAHcmxpYL6y0DCWVynKboyBecax6yjmbKZPGviie/m1thi63el50AAy6Y5VmdBIW74mCuWNpsLl
 j0/9FQUIu0qfCEaDi5anJBnd/3x2s9mEx3Sg6gzHXlkL6H9KCbOanNrgsbQtuxx648gSF/vvflX
 ge7YuLDPs25VRVp3+75S+ej0l6mi6iYFcnsMOQ==
X-Google-Smtp-Source: AGHT+IGYgDPnrfPv3dTxLkHXLjDG89KvtmfMESBMfs5U364tez7VetESFNykboa8hSQIs2v55v2j3A==
X-Received: by 2002:a17:90b:2e03:b0:2fa:1a23:c01d with SMTP id
 98e67ed59e1d1-30a0132e771mr11805766a91.21.1745822412354; 
 Sun, 27 Apr 2025 23:40:12 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:40:11 -0700 (PDT)
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
Subject: [PATCH v3 04/20] target/arm/helper.c: Fix type conflict of GLib
 function pointers
Date: Mon, 28 Apr 2025 15:38:53 +0900
Message-ID: <7d56c82382e8b4f1694b6d7883b2ce3084fdc72d.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52a.google.com
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
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

V3:
- Fixed the argument type of cpreg_key_compare to use gpointer instead of
  void*.

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7fb6e88630..c7ff9f657c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -222,7 +222,7 @@ static void count_cpreg(gpointer key, gpointer opaque)
     }
 }
 
-static gint cpreg_key_compare(gconstpointer a, gconstpointer b)
+static gint cpreg_key_compare(gconstpointer a, gconstpointer b, gpointer d)
 {
     uint64_t aidx = cpreg_to_kvm_id((uintptr_t)a);
     uint64_t bidx = cpreg_to_kvm_id((uintptr_t)b);
@@ -246,7 +246,7 @@ void init_cpreg_list(ARMCPU *cpu)
     int arraylen;
 
     keys = g_hash_table_get_keys(cpu->cp_regs);
-    keys = g_list_sort(keys, cpreg_key_compare);
+    keys = g_list_sort_with_data(keys, cpreg_key_compare, NULL);
 
     cpu->cpreg_array_len = 0;
 
-- 
2.43.0


