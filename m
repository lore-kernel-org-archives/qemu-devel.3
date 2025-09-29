Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16DBCAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3F5q-0004hc-3h; Mon, 29 Sep 2025 10:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3F5a-0004Xn-Lz
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:42:56 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3F5N-0001kQ-7G
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:42:53 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e30ef74b0so33650495e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759156953; x=1759761753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZrX7Vo8XSH76EQy1j2jEGEf72QI55jtj06tZ0QnpNTs=;
 b=jguHtIegfdmeGFSZ5DxFeI/ls5miKwp6WGZNP0LDHx0hwpK1knjPDA2eoIDGSefeBE
 Rqi5B394TQf9pYoIkdpmEDD50yP47jZc8KV+X5f7Op/1lGd6xcg71m/8FOCgCGzviWI/
 A7StTv8hMHf3qdT1VCndT2I7dYwJ0pN+myvZjaVtt5ya36vViRIusxUcm58C+bFpA+di
 lT0+MiN+4bppz3U9gWyL6tEJrexXFfwfkb7SAgD48IzSkifEUCz2gS3q+LJie9ocllRa
 l+8Zd5xmEctDT1v9rOT+LatcvNM+5BHjha7a7eJYQpJH3/nTbmNXRgBV8WUgMkLKnx0k
 SRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759156953; x=1759761753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZrX7Vo8XSH76EQy1j2jEGEf72QI55jtj06tZ0QnpNTs=;
 b=uDsYSqeGyomR7IADfsNIG4ZezTTOCSiwx6lR1zrGa6dxJkMID+ZaVHWqJMJTIACehB
 URr6FfEfnN2bPj7zxa8qHJfh9acpYEp6I2+1JF/d2UgbvNVhUGsYybUh9Aak2B3U3pD9
 +eKjW8h+xu3Mti3+h9jXw9067x1ZKNAPU/jLbAxdIixi4dKHwq/kt4OtMAu0bCThuQ9F
 So+6wUVokocO6LM/4POTw45VJ0T95SCMoUEvIz3/q5SJDO6kcyPmco7jLPqIhS8R3Bbr
 JZVIAN3lo32jCLcAJoh1tcdkPDno3GKJF8K50xUssh5VSwBRDpkPc24FYUpRZ+Ht2oT0
 8p0g==
X-Gm-Message-State: AOJu0YxY9mr3dskkHeAThA1CpGxc+dJmsW+mkSHihF8yPD7EhD4Yqq0m
 XCDY6GHqsXy51is8xYQ7a5m5w47AOIU1sq9SDimf/RgUAj9u0mYnnRMyKjJSo2MY7y0T77nXXn8
 1kYbu
X-Gm-Gg: ASbGnctLHirL9kqIrHHsZcbEe3ttMKY9i5g0I9jSQx6zqSw9FslrzMb7vsIeKUH0KDP
 rYvmhf1kye9zIKBVptrM+cghR+rq2o5lBvNhVc4Oeb3Iky5f4forKtqUSgej3h4Q711SELk+O/L
 rn+HavTXzpad8QxTA7+l7ancTuZbj8KH1r0kLd1fIzZg/5bQA/vwff7jssrtJ49dqdQd3Kd+F6r
 RkIXKjfNu3pWiMaeiC6FtRuBVQlbL/DHFg3sX6nuWUV8tXt3CEncwKQ9kH9qQ4ee11l4TdzglxL
 Ea/0MKvGrtCkePCaqIn3EKOcnV2/gWcia5wnnBYNzUlp7+GB9SsowOiMrx/Y0mjVNcLFc0EteSY
 km2VP6XUGSTA2dFrxeDr2jvdJ0FPUd4fE7yiqMPsAibAe0gP/jw==
X-Google-Smtp-Source: AGHT+IHYibHFXHHpGPIiYV4Fx3cc9LdlMEGgQ5i2EbAfoV7jc4kgFVqxpCDsP8m5YombICwDiv4yNQ==
X-Received: by 2002:a05:600c:4192:b0:468:4350:c84d with SMTP id
 5b1f17b1804b1-46e329ab0bamr102474895e9.7.1759156952637; 
 Mon, 29 Sep 2025 07:42:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f64849sm15893885e9.11.2025.09.29.07.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 07:42:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 1/3] include/system/memory.h: Clarify address_space_destroy()
 behaviour
Date: Mon, 29 Sep 2025 15:42:26 +0100
Message-ID: <20250929144228.1994037-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929144228.1994037-1-peter.maydell@linaro.org>
References: <20250929144228.1994037-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

address_space_destroy() doesn't actually immediately destroy the AS;
it queues it to be destroyed via RCU. This means you can't g_free()
the memory the AS struct is in until that has happened.

Clarify this in the documentation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/system/memory.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index aa85fc27a10..827e2c5aa44 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2727,9 +2727,14 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name);
 /**
  * address_space_destroy: destroy an address space
  *
- * Releases all resources associated with an address space.  After an address space
- * is destroyed, its root memory region (given by address_space_init()) may be destroyed
- * as well.
+ * Releases all resources associated with an address space.  After an
+ * address space is destroyed, the reference the AddressSpace had to
+ * its root memory region is dropped, which may result in the
+ * destruction of that memory region as well.
+ *
+ * Note that destruction of the AddressSpace is done via RCU;
+ * it is therefore not valid to free the memory the AddressSpace
+ * struct is in until after that RCU callback has completed.
  *
  * @as: address space to be destroyed
  */
-- 
2.43.0


