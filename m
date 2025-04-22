Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A99C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76Cp-0002Mh-1j; Tue, 22 Apr 2025 01:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76Br-0001hW-JH; Tue, 22 Apr 2025 01:29:16 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76Bo-0007rF-AI; Tue, 22 Apr 2025 01:29:03 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22438c356c8so49303975ad.1; 
 Mon, 21 Apr 2025 22:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299738; x=1745904538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jka831lyyEn5TBrC/KjMd2fj+rwDsw1v7du1qQ7OLBI=;
 b=JZYqWP55604SsNw11vMz1qGlXZt9v1Lbk7BSOo3pUeW0i1SDUE3QC8kpGPGfUz8gy/
 qBRQWr1BZ5fJCKPEz8kqVSP6tiUHsKdm6NwkJ+29lFJ5NSYS8oq1d9NjxCjomOnwBAPn
 1ueAUr4/or9leo8a5wv2SMNeXskrL3zKDrmYq904v9r3dh6W4+hBVouOCMqqwL4nYIGL
 aoIm7YUlK7zs3N4vY370agW+B46hQDebt8L3tGiF8WfYse9PUtCmr2O8i7U3TXODDWvD
 COs71eLVsZcoTg7qfFTNpEREHWN2DIDOpeWF6Z9SsWdSbdndHd1+jcxSkhl4MPS0dteG
 Lp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299738; x=1745904538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jka831lyyEn5TBrC/KjMd2fj+rwDsw1v7du1qQ7OLBI=;
 b=HLxdU04r8oHAN+d+T5B/NvQy9l9A5AjJ0l3op149ORKC8V4N7YZWFEHkLheMILLT/S
 EdN2quxcCpXnuVx5yqHE8zLNBi8UL5nNgvcn3Ny5WjUHjzrzLG0YrC97L2A/tgUAWUxz
 ahK77GwKeaj5Z+/DZ3KdFnndJBAOWxTEPG8ysftuItx3RRvu+4Yv9raQgInesBFr4p4k
 YWYcpFNaVWK0ehR+wPyYpPtBtI6bEVH9s7qqGMyvcrVXDP0nCDYcEUKLOqPPW1yKByQR
 M12htfDT/fzJrZE8vO/Ue88BrwgjD7nrgszsEut+LLyuJ1C6ohi2IIBQ+KiCSsZWGH7l
 LLxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHpQ/eisHP1V0VyDHerX/S1/Oqxt/fwYy7BWRNw+RTjE08clvvq173XGPKnE2POgP3zUArWad0LMcIBQ==@nongnu.org,
 AJvYcCXDL3Y3WkGk6H35fzqvl6Xm9+/AI0kl8QBGzolGrRIkBPoZXExkQ5y83SRGX6MAKSvj9IBscIjjzms=@nongnu.org,
 AJvYcCXaLFSe0CrzK1AZYbLo1U7257XoeZ17nFrOOZakpy+H+4cS4g/5gXSs6lxWRDn/xA5w9e032OufXg==@nongnu.org,
 AJvYcCXoqs4wVriehNZRReyjS8zWTQqFruJsCV1WTvsit32jTiEFfpamI2rPN1yzWSf17dv4ILwejzcr37WSFg==@nongnu.org
X-Gm-Message-State: AOJu0Yz3pL5hvUADxzDpxWwwPqV3WiqRdMLDrdEWa6ut3a8xCCSpx1b6
 WylcEwQGUxOkVH6t4nZ8+cI9JrpuA6cTpJHOntlrDXPhl4flt7dPdRvw4hi7
X-Gm-Gg: ASbGnctLglXeMQWufSpekGf5f56FB6IhI77rM6dgOSPUWEt70fXzZPOokVQHlDfiHSV
 kqxYSNaBqrdew20PnszaI/3WIwtwvQp2x83SYYkQXoI1au2DzPzo9Yzr9bdrZfKjmbji97oas94
 0KAPk80ftPew4XoN4HPj7l3vuSTIWL60cyHyHBl/Iz/BNwTvPclZW2kf5V/RUDRvL3p7f5pU1R1
 vHDifvPZ84v/mgEAL5nH0dXljiY13lP+SB+sJOE5ciw9ZsEv6rEnLu3+v5NajAsVCBVMFTVJpKj
 5zKVZoEndBeP66PR99VVBCCqQyFz39rWtF+/jzVqIl25UCaAhyrYeZ1BhSg=
X-Google-Smtp-Source: AGHT+IGaXHMDzxoqNDfNho02Zs6s6BdUjSAFaf5W8QD0EenDq6q0h00TKwY1MjsG5jasjF+nnumjcQ==
X-Received: by 2002:a17:903:298d:b0:220:e392:c73 with SMTP id
 d9443c01a7336-22c535be3a0mr241851615ad.22.1745299737701; 
 Mon, 21 Apr 2025 22:28:57 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:28:57 -0700 (PDT)
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
Subject: [PATCH v2 07/20] hw/net/can: Fix type conflict of GLib function
 pointers
Date: Tue, 22 Apr 2025 14:27:11 +0900
Message-Id: <4d47a75c5768c9a6dc5d8b3504e78837577ad70d.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x632.google.com
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
 hw/net/can/xlnx-versal-canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

V2:
- Updated the commit message to explicitly explain that function pointer
  casts are performed internally by GLib.

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index dc242e9215..013ebc10dc 100644
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
@@ -1318,7 +1318,7 @@ static GSList *prepare_tx_data(XlnxVersalCANFDState *s)
             temp->can_id = s->regs[reg_num];
             temp->reg_num = reg_num;
             list = g_slist_prepend(list, temp);
-            list = g_slist_sort(list, g_cmp_ids);
+            list = g_slist_sort_with_data(list, g_cmp_ids, NULL);
         }
 
         reg_ready >>= 1;
-- 
2.25.1


