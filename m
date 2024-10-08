Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05455CEFC41
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 18:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFJQ-0007Qd-VZ; Tue, 08 Oct 2024 14:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJL-0007QL-W2
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:51:56 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syFJJ-0002SU-67
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 14:51:55 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a393010110so2653375ab.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728413509; x=1729018309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5CYklN5kY6AhJz0z8fnMo7i52/61zUcEwxCjMHlZ3PY=;
 b=XtdWt77C+X/VuILR9Fehp0IopcAy93KLFGIXKECKQ7JAZE3MkouIabQAwQ2BMe05iW
 Hucdiw3Un2R1+fwm/lsCMRjiSEehgPkR58oYBAKKBQNhtc7PO4dhm0os1pN/f2PLjZjk
 cLAEK6kTe37Mn8OCuhrpGqdH83lxlcpy8BSje+zRJt3nQBhHESJr4PeGWWjCjwfwHuoE
 2yPC0SNmvcZCS2TM+4V2IqpiZ7t8RjnsInrzovmywdkcOyLO+raF+jkXoRDtOjssILQc
 MDNNTN67twIxFUzpNOE+KzAKm8pIWWZP2LAD03yuIXJeDusqDPxjLbMwu9nql4ngjaXK
 5fPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728413509; x=1729018309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5CYklN5kY6AhJz0z8fnMo7i52/61zUcEwxCjMHlZ3PY=;
 b=LMlnVus3uBkfpRTDKEaHI1UuIDGf+Ypg+zVbQy003IH8uvAqklzKVebzjGTwTx06zG
 3JoIkKzz0IlvuOP3CTGD/Cgbs49mSgCXrbbyAFyod2SJULNN4jL1IjRJUd3ghJPq8nV4
 J2DEg4ZVpRf85bEggUZwtvCHgtOyKhhl0j8Qf5qBXXlmzypnL2nDnStlHlIM+zGhlnWS
 5KOjK4NBZ7zEzntjcDuRf69WG484gCaaea+GCysVyN70OFiN1wLtGqadqyV2XpWz/0ZZ
 XVlpE5GSL0b01g49wRcQySes/MZ4QF5StqYpFNtbWf8qOSDyzcb6XZuq8UYK0K9Dsg/X
 fhVg==
X-Gm-Message-State: AOJu0YwMYrjqfCCiNBJ1SV5fGxVFmWUh7/8+IIq2xrwAHbt9kVoqtDRP
 94RfQn8UaloUVvdCvO9Ak+Vg0DwmLofZXRwD5xSsiRyvEHvpZPJNjlS6WLFWees4JHuDHLb6uuy
 x
X-Google-Smtp-Source: AGHT+IEop1ZYVznbDmJpaafr5oWWjpnY4qbqdCFV0xd0bUvBvOEbfIr+Vc/3AH8waRMz9p7CzzbJmQ==
X-Received: by 2002:a05:6e02:b29:b0:39f:60d7:813b with SMTP id
 e9e14a558f8ab-3a375bc6844mr162725195ab.22.1728413509277; 
 Tue, 08 Oct 2024 11:51:49 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6821c32sm7186818a12.33.2024.10.08.11.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:51:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 06/14] linux-user: Correct print_sockaddr() format
Date: Tue,  8 Oct 2024 11:51:33 -0700
Message-ID: <20241008185141.20057-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008185141.20057-1-richard.henderson@linaro.org>
References: <20241008185141.20057-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x130.google.com
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


