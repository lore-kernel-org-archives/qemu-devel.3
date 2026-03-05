Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254F4F47CD6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 20:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFgE-0006da-LW; Thu, 05 Mar 2026 15:52:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFgD-0006dC-Bi
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:21 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFgB-000699-RV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 15:52:21 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-5069df1de6fso71605121cf.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 12:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772743939; x=1773348739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9wEjdCX/AABVulF6oOJPhScJxDD+gOajcwluG2qx8xE=;
 b=Yo8cfj8TI/sHdAZ07bUO5wMJ6khmhgdsAwgD7r9boRuIh+uFXqLXelSpGiBO+SnSOS
 Ugqr4OHRezkbkb6/PQ327AbE4FFavQLAZbgM/Hypjw4i7v3z5e7065OqZHfTcipvNSkI
 E7fFWPGmqVss082Wj0LzhvA1d8kod/YFq0/+s0RmymaJYJK1XD346Siho++rtlIqcwmW
 6ttw7WBdSAF0BkVDnmKnccW+zpX1ChlsCqtxiVX6hAd7ZYiZ2j/c7T5hKyKetGb/6aN3
 07WbCpw7zbi0ff66c0lKC5tLveMngd1qEjmG668O0+ZyU6uT8WkA12PYfG9Xfb3NXNx+
 kSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772743939; x=1773348739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9wEjdCX/AABVulF6oOJPhScJxDD+gOajcwluG2qx8xE=;
 b=siBIkAZWRhhb9+xTomK3omm9cE7EYiu8lirFUSsnWRj3troBGFCKzwD8WpOpQ4JW92
 Tz9MoEQKJxtERpuj+fSLgS+A/Lk/UJiENfb6HKt90xu3trI9fZ7xlXtVgLekdoe8PA32
 saVwZDubgwO8yhsZeUC6rvtayE2ATM/1iDLglQtkRwGkrQns4QZTjv4OtfxuCidFPzAT
 yvDFFO1x9xa3/AuUY0abe+okXtr8k65D9yMCKAsPt+0b+1zE5v74AMdZsJcfRGeMf5Pl
 T/jeiM4mmsCOm3SC0lcUDoNxUkWdEcOOvXQ+pVtE9TykZpdgaGnpw2kMmrfdqN1MmQK3
 ZhUg==
X-Gm-Message-State: AOJu0Yz8Ml4l4S4qvTAj8NKgUa4jBzVMPjkgBrZoFGKE7sTH9j8lBpuX
 jgW1uCNo+PuD+ZV6kOUkBb5daeJLHRU+4XnMAuhhVFX+UF4ibGeYDjd0ZVbAjCGLdq1BX4yQN6l
 ijrFB
X-Gm-Gg: ATEYQzxk3hTUw1tOerZUFUdDl1IveVmluY13bUh1zj+IDw7c9eZCM+Kl8devgmszCYL
 Pon8w0yDqZiwRw8pvGnNhg6B1eVQChNSMZkduEJ4EINwvnBKy3NG+pS4PxdkxNbhfCvqPw38n8l
 19TFIxdy75wPA9e5ASQD4DQFo4Q0gZM6q8U4AMlOUFlvPxeWRLFejFwKh+a38AapHx0/UGugc6Q
 AkYKgY8HFgtmTpnCtg5IA/V3/CSLu0L5zHHrM/NUoaHHMv0MHUXAmRYVwaUEn3i11G8jL60U1hw
 P/It6R+uQHEvsqAVsM9Hz3Alc4T/huiTWoNscjzxJ2/lpD1N7UJAIuM1KQzBERqJEed4h6aQ1jc
 G5QOggJBgSu+hn1NWd3dDrCFEq1jwl7OuMS5lb6EFAxYJamlqMwaG27hRfkpf/wlVNjvnzx+2nL
 aH1bXuoABuUGi0VCFAz3fEVl44fp/S5CEY2z1sN0sqQ2yx6FRiUESnlmxpstoEdUnPRO6ggO2+K
 WVTLc0d48zR0IU=
X-Received: by 2002:a05:622a:241:b0:4ee:2154:8032 with SMTP id
 d75a77b69052e-508db291074mr100005031cf.6.1772743938685; 
 Thu, 05 Mar 2026 12:52:18 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a0e31b035sm65559396d6.17.2026.03.05.12.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 12:52:18 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 12/12] tests/tcg/plugins/patch: Free read_data in patch_hwaddr()
Date: Thu,  5 Mar 2026 12:51:52 -0800
Message-ID: <20260305205152.2121854-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
References: <20260305205152.2121854-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qt1-x832.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In patch_hwaddr() we allocate a GByteArray for the data we read back
from the guest; however we forget to free it, and the leak sanitizer
complains:

Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x56c00ad48293 in malloc (/home/pm215/qemu/build/x86-tgt-san/qemu-system-x86_64+0x1a9f293) (BuildId: 62e2a7dbe5ff146b2fa14d26e24e443f1967edd9)
    #1 0x7b3e4cc91ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x7b3e4cc54c12 in g_array_sized_new (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x25c12) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #3 0x7b3e44b06b49 in patch_hwaddr /home/pm215/qemu/build/x86-tgt-san/../../tests/tcg/plugins/patch.c:68:29

Indirect leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x56c00ad486b0 in realloc (/home/pm215/qemu/build/x86-tgt-san/qemu-system-x86_64+0x1a9f6b0) (BuildId: 62e2a7dbe5ff146b2fa14d26e24e443f1967edd9)
    #1 0x7b3e4cc92819 in g_realloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63819) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x7b3e4cc54b36  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x25b36) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #3 0x7b3e4cc55276 in g_array_set_size (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x26276) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #4 0x7b3e4cc55574 in g_byte_array_set_size (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x26574) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #5 0x56c00be2ccc1 in qemu_plugin_read_memory_hwaddr /home/pm215/qemu/build/x86-tgt-san/../../plugins/api.c:524:5

Mark the variable as g_autoptr(), as we already do in the equivalent
code in patch_vaddr().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260305161531.1774895-4-peter.maydell@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/plugins/patch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/plugins/patch.c b/tests/tcg/plugins/patch.c
index 111c5c1f169..eba2f8b8d6c 100644
--- a/tests/tcg/plugins/patch.c
+++ b/tests/tcg/plugins/patch.c
@@ -65,7 +65,7 @@ static void patch_hwaddr(unsigned int vcpu_index, void *userdata)
         return;
     }
 
-    GByteArray *read_data = g_byte_array_new();
+    g_autoptr(GByteArray) read_data = g_byte_array_new();
 
     result = qemu_plugin_read_memory_hwaddr(addr, read_data,
                                             patch_data->len);
-- 
2.47.3


