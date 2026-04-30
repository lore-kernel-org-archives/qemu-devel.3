Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3BCFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINrE-0005JJ-Ll; Thu, 30 Apr 2026 05:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINr2-0004uj-LL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:44 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqp-0002aU-3A
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:44 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43fe3e22e33so399778f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541909; x=1778146709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jeiJLcMiad4H/zhSQfsPf5Zc6NaSRLrWE13Uwy30mq4=;
 b=QYzET7K/BBExjVUvTgwvJEpwEtDC0IFg8J0Q3EJho2IlgA6zOvCKKEYlHQrcV+5bwA
 XgcvpzwVCZYedSSZbaYsO9SzOCpWU+/7x1QSDsSv5HON7T9uhWX3WheCv/abUe36vZMN
 Y3B+rlyyH8hpaT4o31kwzo0ukY3uJiw+6A0Hg+AKYuKMbB1Sp1fu8OqxF2VE4gbnvY18
 Cc+VUxqSqY9etv5a4lBwcqkqs/bzL396vOFjl2VRlwjgItZkXmzWMKRdvB+h8Aax3NZJ
 RPa4w72p37XYVmxlCDtwS7PlqHSGvEWhab8RIuIP03TfyCuEQwXYjJZb6SqRq9S8dpyP
 oKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541909; x=1778146709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jeiJLcMiad4H/zhSQfsPf5Zc6NaSRLrWE13Uwy30mq4=;
 b=V355W07vbJE/Qz6HBo3grz0kIsK0ZWVIF+KWJc4jsfPk1jZNWz3oDX5AFtd5O9j3ik
 3qCoqg5aKgvJEzA6NfY3AWjRoazSKMqwOUP0omxc50+r+SOqLGzv6ABqzMI+VDNBgcDD
 YI1fRQaTjGgCN70MlGdZYDdSFP0ZVMgvK4BlKaCt52ev3bXKGKcYS7Y4YnQ+Frdt2Wfx
 G2NBPwlJzUrcN+pi7JiwmHD0631lrBgaWeOQHufauy7I9Dhj0cj8OmY9sbUBcXSKT4G7
 a3ZMKsxVB+DCe2T42pTgGhw0mb+Wff7SdW2v9x2XU47pSuBv1TMr9zqnpRoUkiZGSQw5
 QZWQ==
X-Gm-Message-State: AOJu0YxqDRVJMxz13gMAeWOq8vBwtYL+r3ywYpjerpAnmmtL3NwUehwK
 FZZuJxF+e6H1hRN46w+wiYQgEv5VGWBjONn/rGaxMzhxRYIS1UWXGZiBxnWyINYV4SBXjd5O4mp
 FGrh4
X-Gm-Gg: AeBDietY0XMqbFiHM0vPtFRmaFkUOeFWgUeVAj5u8z6yseOMDED5Q560eC7EGu+Vwt2
 S28nC5iMTrQ2Wbm0IVCdIG5b/JEJSFEW6Q1IFxXvsqVRYUXmybjXkDbwE7OWrfMSDz5hS5lJXUf
 /8Ddvtl2UTisw4i7Fauap2LH+lM1b3akHTyiKqO8yICzBjewQzk7IkuN5GWUP5leFsj3+pSqtPP
 ohJFFbmAvtXoUT6kV/6QCIwCSSQRpl5mfxRQZJZHLreay9arrb0JrotUJI1P7qbgdlwIVRhB+pW
 MP+dNaIWCnus0lMNwbogkHklW/NZKupc6ie8pJ9BUTVkBXacUzH99v4zy3IrwhrHKR1+HFD++sk
 KsVGCJUmPwxjUGoyFJeO50ALimpbetEAzpkj4MPVhjkMf3tO8DivH7js1E+i4z81gJlQP5CNeT0
 sTq5gEzQs0mBSoUy7P6OXXem6Ji6WSszzizz8svX9kYQyIlBxQ6R8FQV8LioGF7TVILe0DiPxuI
 Mr3A3v6ZA0plky3nWxysCkoWJjMOCFlea8GHJkcSA==
X-Received: by 2002:a05:6000:4310:b0:43d:733f:aee6 with SMTP id
 ffacd0b85a97d-4493dcd3444mr3263214f8f.10.1777541909076; 
 Thu, 30 Apr 2026 02:38:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 13/25] monitor: hmp_gva2gpa: Don't page-align
 cpu_get_phys_addr_debug() arg and return
Date: Thu, 30 Apr 2026 10:37:58 +0100
Message-ID: <20260430093810.2762539-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In hmp_gva2gpa() we currently have a workaround for not all implementations
of get_phys_addr_debug handling non-page-aligned addresses: we round the
input address from the user down to the target page boundary before the
call and then add the page offset back to the returned value.

Now that we guarantee that all implementations will return the correct
exact physaddr for a virtual address, we can drop this handling.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260417173105.1648172-13-peter.maydell@linaro.org
---
 monitor/hmp-cmds.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index e6d8322bcc..f8380bda58 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -720,12 +720,11 @@ void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    gpa  = cpu_get_phys_addr_debug(cs, addr & TARGET_PAGE_MASK);
+    gpa  = cpu_get_phys_addr_debug(cs, addr);
     if (gpa == -1) {
         monitor_printf(mon, "Unmapped\n");
     } else {
-        monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n",
-                       gpa + (addr & ~TARGET_PAGE_MASK));
+        monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n", gpa);
     }
 }
 
-- 
2.43.0


