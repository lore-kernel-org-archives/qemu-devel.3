Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C4FCFB43C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 23:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxEHb-0006C6-Bd; Sat, 05 Oct 2024 19:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHY-0006Aj-Mr
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:52 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxEHX-0004DT-9K
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 19:33:52 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e1bfa9ddb3so2481927a91.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 16:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728171230; x=1728776030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5CYklN5kY6AhJz0z8fnMo7i52/61zUcEwxCjMHlZ3PY=;
 b=OFGG4gZLWdA8Zh95OBZQBsTVgvkGfJOlEsAFbO2+xe15ypmhyr40Y5TF8oD16djA1u
 KUIqngAeHx0vyjHyeCu9fBFxH67+ydsoH5swH1UTmlbHKeb+Jcj0ashTk2VJDlCgaWV7
 0O885zKIe+/F5Qjcv6wv/4+hWh9RLAv6dn0AMZZyhoqFdGZ8EX1E1B5RVu75gtTvRiJ8
 vtPinvEcQK0rE7KFU/PqiLbsu/37Ud8lv52HF7JZzxabbjqHbeIBaXD3mL5ZD9i/tI1k
 7nVGXzrZOrNcYm4pmUBNk4Pt2YbpeF0OfqXL9vvB6qwb36v+I7xK+QRV5Dp6SZXLHxGp
 NWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728171230; x=1728776030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5CYklN5kY6AhJz0z8fnMo7i52/61zUcEwxCjMHlZ3PY=;
 b=DapsBxGBmJNVSIlrPMvw23EIwRk2XxOx43KUY714bxB1NchbHZF6/nFnmyMa/GvzL9
 grl1SCK9wa4PzZtD63SHXVtE2LvmCeL10cyFzmp3wmQpNPYzAH0UFv/XMTwxIe5eHU3k
 4PpPE5S2wCMQxk7+2PQomJaH0oo4pzQzTts+SK0qNEDO1rMhNOS2ycA5fsUEip4NG2iJ
 FAmFaZN33VU81n9/lSeqQaHw/GFAH743U8wfkWNA6SPaYYfTrllhmrLShYxfXyuqwz7A
 pJ5KOfeDGftts6GvAFRaZAONNrcfvb7WvMNnqo9kHlQmQQGju2KyaqQGl07X97vjXz1V
 l7ow==
X-Gm-Message-State: AOJu0YxQl8BjCthJNtxKryqu7BfsXUpxKmXBG4op4dEZHsUh9PomY7M6
 em47VG5JqsXG4+P97ah2sIH+eUzBUSmG5BVnXrCsb7ZoVKMKcKd+ygvY0Di9oe8A9BSBb8ZLpfg
 D
X-Google-Smtp-Source: AGHT+IHZ7lB2HBEEaSoCsqQ4bCfcwXtOkm38qYLhjb19Dq3r9lJ21H5uCuGJRoHYTOLEyZD2AEnw7Q==
X-Received: by 2002:a17:90a:fc96:b0:2c9:6aa9:1d76 with SMTP id
 98e67ed59e1d1-2e1e626bc1amr8125478a91.18.1728171230067; 
 Sat, 05 Oct 2024 16:33:50 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e20b129cc2sm2394600a91.51.2024.10.05.16.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 16:33:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 06/10] linux-user: Correct print_sockaddr() format
Date: Sat,  5 Oct 2024 16:33:39 -0700
Message-ID: <20241005233343.503426-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005233343.503426-1-richard.henderson@linaro.org>
References: <20241005233343.503426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

When the %addr argument can not be accessed, a double comma
is logged (the final qemu_log call prepend a comma).  Move
the comma from the final qemu_log to the preceeding switch
cases that had omitted it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240807124306.52903-2-philmd@linaro.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
[rth: Move comma into the various switch cases.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index cf9eaf71c9..dfdec58542 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -376,7 +376,7 @@ print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
                  un->sun_path[i]; i++) {
                 qemu_log("%c", un->sun_path[i]);
             }
-            qemu_log("\"}");
+            qemu_log("\"},");
             break;
         }
         case AF_INET: {
@@ -386,7 +386,7 @@ print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
                      ntohs(in->sin_port));
             qemu_log("sin_addr=inet_addr(\"%d.%d.%d.%d\")",
                      c[0], c[1], c[2], c[3]);
-            qemu_log("}");
+            qemu_log("},");
             break;
         }
         case AF_PACKET: {
@@ -417,12 +417,12 @@ print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
             }
             qemu_log(",sll_addr=%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x",
                      c[0], c[1], c[2], c[3], c[4], c[5], c[6], c[7]);
-            qemu_log("}");
+            qemu_log("},");
             break;
         }
         case AF_NETLINK: {
             struct target_sockaddr_nl *nl = (struct target_sockaddr_nl *)sa;
-            qemu_log("{nl_family=AF_NETLINK,nl_pid=%u,nl_groups=%u}",
+            qemu_log("{nl_family=AF_NETLINK,nl_pid=%u,nl_groups=%u},",
                      tswap32(nl->nl_pid), tswap32(nl->nl_groups));
             break;
         }
@@ -432,14 +432,14 @@ print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
                 qemu_log("%02x, ", sa->sa_data[i]);
             }
             qemu_log("%02x}", sa->sa_data[i]);
-            qemu_log("}");
+            qemu_log("},");
             break;
         }
         unlock_user(sa, addr, 0);
     } else {
         print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 0);
     }
-    qemu_log(", "TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
+    qemu_log(TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
 }
 
 static void
-- 
2.43.0


