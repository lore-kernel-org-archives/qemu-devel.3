Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A56EEA853
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 00:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqhH0-0003nD-6h; Thu, 12 Feb 2026 19:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqhGy-0003mC-4e
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:43:04 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vqhGw-0000qO-CR
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 19:43:03 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82491fbf02cso233182b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 16:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770943381; x=1771548181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qc+ukIsOiKgzsRkLbscq45ZmsrUzNjBvF9i+XTW1u7g=;
 b=Ny6j6GIN20839aWicWJy9zRpQdIocQzNKXdPTfjUoNvrP+H5NxcgwyXJn5J2GWBOEG
 mc5N31Qxsj+jEmXEYz7Be+GYEkZiNoo2gsr/Rkvc/vfGG6FqO9SeiWb0h+bm/FBntdyT
 N7wG2/5/WED8o1HqKSgO6Zh32F17+cjRdEtFlEaUtMXNXagru1UqPA/5BX9af6cGnjKE
 jwQxbH/WzxXeH9PEb8bTtfHmpvGx5vgr4lv8Ndkj8UBAc3U47Exzqoyox/UaOpEyq6ZT
 nafOXILFCGxwdnAyB9FQth+le2FPYQve4R7zjZaN+XeEH4FRnDVbKAmeXgNFXhJpnDyB
 6Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770943381; x=1771548181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qc+ukIsOiKgzsRkLbscq45ZmsrUzNjBvF9i+XTW1u7g=;
 b=op7jkYR58oEcYFMO/Z0q5NM08R5ECI8fUYvXItGQg8tIHiQMev037ub0alcggTJHeO
 4D/UU6GWOirxcRobSP13995hqA/q2Zh1Ml3etnyXVTEP2ZJp2ScoL5DNyFPkYos1CcRQ
 0g5RZQeXLFQgECAyZxuRvPQMwUAw0DDqYMTQH98Kb1CXhNha+NXjCvbJqzFP8vqoFi0/
 Ti7DM3J6k5h2iOALu1XIMSM3Py97fxJUPgQa8SYDd2m7VpdKUgczx4eICp4I8EA5EwDl
 bFbO6c9atUhVIpHoCsIq6yH+uW4oYyBKzAaYtgfLysicsotXzugLlKaWncHZZ/Jdx3K6
 T/EA==
X-Gm-Message-State: AOJu0YyfVJyQx0GUEztAgdQIPTRKQmMlBrK3CxuSDOAb6qONg0omasfY
 1sLDSwt+5m3z5m6U2XpcnzDMcC8+BRekk94SM5xwQhLeyz8zm7vgDN7uK7F6yNXW/GRD7FcueoW
 PgioN
X-Gm-Gg: AZuq6aLziFwonuX190HKU/rHLmvCy85TtywK6dUOiylqg2j+irrnXvHn4rw8UkydYwi
 nwWHkp6P/ubZN/+HVSepbrTCJ9FMwl0xdC0ocY+pZBGvSspwPcBc2F4qdxJc/nqTzjYcS7Q+C9z
 FeEirB+5Dg3xCrbKOlHjQyx5Af9EoLFzqGokjSIoGeCGGW3cIs+JjmwtOUX8TcsMOVcK3B4F+V4
 Gxe4ASGIxswMdFCSoaUrV/EwlGgjepAMYO/1cmFJGt+7u9kdEmlbsSFormXt9Ho/niZW4NsdqlC
 4VBAU9pYDKNYkp355DlB6uqUpPiAdBbyQyzMQAzUpAxGnOjgW/con1ICx5VxW6BFKTIiUSJ7yqp
 5Vwmm/zj+hVXIutGZRBl2xaBk4y4g0jUB+5VT3chn4VOklQPJa7ccNv7/5sd9OnKmuqNk0nVP7G
 AAP51PYqffaDINhkqE+Ikbf4PYY94w/TPyrnU7AXFmdNmSMqJLBZVrBlgfOa+s+go1vVvkqlt2E
 KEe
X-Received: by 2002:a05:6a00:1706:b0:824:3eb9:11e2 with SMTP id
 d2e1a72fcca58-824c95d5ae5mr230697b3a.46.1770943380796; 
 Thu, 12 Feb 2026 16:43:00 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a431f2sm504326b3a.22.2026.02.12.16.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 16:43:00 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 1/4] contrib/plugins/uftrace: fix infinite stack unwind
 detection
Date: Thu, 12 Feb 2026 16:42:51 -0800
Message-ID: <20260213004254.493059-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213004254.493059-1-pierrick.bouvier@linaro.org>
References: <20260213004254.493059-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

So far, we were detecting infinite stacks but not stopping unwinding
since break only exited inner loop.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260210201344.1403613-2-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index a7e21b5b87a..1ed982999ed 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -443,7 +443,7 @@ static void cpu_unwind_stack(Cpu *cpu, uint64_t frame_pointer, uint64_t pc)
         /* check we don't have an infinite stack */
         for (size_t i = 0; i < depth; ++i) {
             if (frame_pointer == unwind[i].frame_pointer) {
-                break;
+                goto after_unwind;
             }
         }
         CallstackEntry e = {.frame_pointer = frame_pointer, .pc = pc};
@@ -456,6 +456,7 @@ static void cpu_unwind_stack(Cpu *cpu, uint64_t frame_pointer, uint64_t pc)
     } while (frame_pointer && pc && depth < UNWIND_STACK_MAX_DEPTH);
     #undef UNWIND_STACK_MAX_DEPTH
 
+after_unwind:
     /* push it from bottom to top */
     while (depth) {
         callstack_push(cpu->cs, unwind[depth - 1]);
-- 
2.47.3


