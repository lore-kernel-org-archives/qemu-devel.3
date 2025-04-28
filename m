Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21293C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9IC1-00053T-Ep; Mon, 28 Apr 2025 02:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IB7-0003KY-Ji; Mon, 28 Apr 2025 02:41:24 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IB4-00079Y-4v; Mon, 28 Apr 2025 02:41:19 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2240b4de12bso66977485ad.2; 
 Sun, 27 Apr 2025 23:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822475; x=1746427275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dFmBLtca5z+k4npQ+vmJi+va4ESRCI4ZS1XYe4MkFk=;
 b=EJk08KvGMNfOIXoUNxBf4nhokM6j9ePVBt2X0okMeYstoeTWHDsUtbGFfv8wb2+kk2
 dNTr+rDcT2XkBHK0U3hzteOKJ9yl6R8+KpjSK+oGcg98hG4tNqS/p8Trn2XYghYVtw86
 l3R+/1XEBIYYYBRIJfhvmvirvHIDC5/uh//8T70Y2yvymA5xHkEjgsAqIO1p7/TwSifi
 XTd05YJx8bghzu9DAxoqjBiG+NRzSNVg16uw90PQJIBG/zShEkiVNfyHmoROrxJCZJCn
 2c9tSSSjU6sBC5WYbrZT6ZniFsZoK0kW9jf0eu7W+DSadxiHCZ7GqdLma2MXIVGv+6TC
 xz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822475; x=1746427275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3dFmBLtca5z+k4npQ+vmJi+va4ESRCI4ZS1XYe4MkFk=;
 b=HjO5wAlXLy4R4+9n2Y+440DaBFgOl7JPkp44rflL4vG3yzyhwYL9cQhR3HXnNd2bFg
 lE7WJtBbMERYOd1evFRtNDarQRZf8bu4jCDpVVJOgTwrp+p5yOrW+azL2JgsNkrBIfsO
 4CLrmHg/w3Ytlwg0HCQ4noIqMIfi+ymdsMkWmYZAaKbj6CJhwkwRzOiLDfpWMwjOWZZe
 i0Xh0Nu9sJ9emrZVg5jYGt0QFbhFsh/X9NZkg2q20GN+9U1YWvkwenytiK54Z0BH6ZmA
 p3VdPrZ5Q1jNVxC6maegKaL9wkRTHs2O8s93dKqKxssEkAoHWfSg2f/WsCdlXzl8Yx15
 C8hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9mPAVLjhxMf2iV7lFq4Ge+H/2hwWmHlLWuw6DBv8Pz6tAs8H4bcMPM3go8aAfzfJ8Sp8pvg8Hrx0=@nongnu.org,
 AJvYcCVKzECi9D44EXsrxeKG1mMV8Wi9FnkJI5WwccqYPcd5KAjO4fYd9HTx7uJIB+b5PEUca60/2AtCohzK1w==@nongnu.org,
 AJvYcCVZHTgpWlMSSRGUCCH9EveCRdkamBZU3PT+wwgVUaI3PffMWWsEx50mI7dfHmtKfPIhjIU8gX5aOw==@nongnu.org,
 AJvYcCVeFFvFydclhOqg4M8oTI0092tqtXzdXAiU9GW2T39kr5cgt4j4yZS4HyLN+NI6F9Z37hoCQ4Hj5VrC+Q==@nongnu.org
X-Gm-Message-State: AOJu0Yz51Hcofw9loDlXeAol9rZNHowNKySSksfe14pDytpzcUgyah3B
 FuxXIYgG2RSOXNq1YN2kGZlTMV/7v6PYjCxy3X7NqYEbHYpdciZQ1nB5Gsi1
X-Gm-Gg: ASbGncsQCRTLGIidDNwObDikB7nU3FR5HgJOpRlaYbHbcDM9Civ1Fk/1VZ9CDXlumvO
 9vM0tcm/ZeHg3MNmOCTIHMznbFNfX76EP8nkfzTH/VmE+CmTkcA6W+oATdGLZrJGJE/SmAgTyE0
 dTnQM/+RM7OZAoF1frjnSt5wHz/DzfI46RVULn2B3v9un1Gl8SRUViEn+shhffMOr1SI0OVbuL8
 zdJkyt+JykA1lNKtn01wnEhTbRVM3jrtfBr1Z1GV+4BtddsAZpADMOXHlKdcanFhvFYUmiF1NOI
 EqQu1euTnIEQuzTpuh5/Fg/Z+B4SJ91wY0aefQ==
X-Google-Smtp-Source: AGHT+IEV7b6RfMBnPMMkbl7l51hr/9768Z1MTLBGWF6csH0hrlzffpn8bp/f0CJci2DJqbriCeykBg==
X-Received: by 2002:a17:902:c945:b0:223:fabd:4f76 with SMTP id
 d9443c01a7336-22dc6a17d6cmr108623535ad.30.1745822474870; 
 Sun, 27 Apr 2025 23:41:14 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:41:14 -0700 (PDT)
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
Subject: [PATCH v3 12/20] block: Add including of ioctl header for Emscripten
 build
Date: Mon, 28 Apr 2025 15:39:01 +0900
Message-ID: <49b6ecdbd23ff83e3f191ef8a9f7cc2feeaea43f.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x633.google.com
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

Including <sys/ioctl.h> is still required on Emscripten, just like on other
platforms, to make the ioctl function available.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 56d1972d15..69257c0891 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -110,6 +110,10 @@
 #include <sys/diskslice.h>
 #endif
 
+#ifdef EMSCRIPTEN
+#include <sys/ioctl.h>
+#endif
+
 /* OS X does not have O_DSYNC */
 #ifndef O_DSYNC
 #ifdef O_SYNC
-- 
2.43.0


