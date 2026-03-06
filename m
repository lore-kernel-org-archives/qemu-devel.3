Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD1CFCB609
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWey-0004KF-7R; Fri, 06 Mar 2026 10:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWev-0004FB-Tz
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:09 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeu-0002iL-8X
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:09 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48529c325f0so2591225e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809207; x=1773414007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mpd1fC10sURVISQkh80gCxXKmWzy9rA/S8ZrOhfrDB4=;
 b=gmcEUpJVEPQkfA5pBA6wawxttZ8HvzmSt2o6utHzCT8zETcRneeIkydBTPI1NZJ4e+
 xG6xHGkj5eyBtccom/NHwKm3XYmxjd8wuahp21UUUy+OBDrXWy+miPoq5Kk0IEA4NYzi
 FWD5fsBWc3C1eQGNC0Okj2zsMbhVMHDZGN8t6O8HZKn7m1/TCcEjvOXyiIRSARI/GSg3
 OIBdSwkxVJfUCRLwLjoHhzw2tBPtArFoaf8CjfTCLnfg8v0YxUpJBGTaHuk/cI6V2BJC
 FC6C0XjqPQQHIJz3CwTKB+RNjuEAl8HT/xnWkziS6Pp0q5gfsGZwtEuK0s5wb9ETKrEO
 LKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809207; x=1773414007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Mpd1fC10sURVISQkh80gCxXKmWzy9rA/S8ZrOhfrDB4=;
 b=DGx5ISp7GoYZVEbOt1b0xvm7CcOQgt2u3Invi05gnB9ykjJAfCC4v6DVahDfT4clgf
 ERmYFCy6ugdQqjkyN05W8uY5Fq+311dIb5TzvExqtzGLQo9emHWpTK403PPghndITHtK
 9KrHRq0hX7fnrWU4NzMukLrPVPfjAH/oHaCYbpJ1KFv6/I1eXZRNsGKKMph3sfI//Hos
 YiqvH7TrDrR1TVUCyGqtV+3+u0s4L97GzzasMAD196FK0ZAZKSH6pNDooHeEXUWuR+JG
 WsHJ40UGlaT1qVoro+gBgNMVlEegy/Hl4iIZiqMAqTYIeTxft1KNF+PKH3hhtCoGWhkJ
 SfoQ==
X-Gm-Message-State: AOJu0YxiMgDbbYrmz2sEmFwJWQ9NMUJ88BeSEXtpdnO7MZqEK4FSEOVv
 zdGIrq9uIYCOPAuzF6BOMQL84npvE09AzMkfXGso7c5SQWAkOFemCs3sGELcMqMcAqqx8lyAOGq
 v+3xK
X-Gm-Gg: ATEYQzxA5GBsdyG8CcvWsVPeVu/ay9alLlpBQZTpTjsDtxLgXvvHFiKL2v8gDL6Xcrn
 eI/nvsiJBjnf6YGDNkIsBRWE5tKjE/tO8n9djCHFISkn2Zk+OC/BQjJ0toKLGrhfTmUnNWlfoyz
 x4Wg2xn5C/FiuxXpbpzECxcquwdmMTF5CFsqsrgonI+PEgDXaxp/f8hV5sa9Ofl1wL+YuXcFQBz
 W8RgXh8emFSkXvi+7sJLbszF7EiwkbsA7f3M9z2KV/qOSLdOnGCYnvfosQmnW3TiH1DEjmiN85V
 X4Vqo4M+Tlwea0lxgIpvfBVgYXAoKOPb8YxkHMneYYRj8/n3vbXf6urnsACcxeYxg+u/oRKMmiE
 A+sFaXTaJUxNWObVTq9bpkB+3xfSNpDZAiEAndkC1aOfkMHpYnpe8R1fU+njUmV9vzfp8xb/NkT
 dyXY4MO5S9bZ2UdbjGQrQj8jNXAuNkHsF4y9X35+WbXML47cMgM1SeVilirsDMrpkJyureErvTo
 A4/Zeett48lZs8lo2vQDUWykyILdIk=
X-Received: by 2002:a05:600c:45d1:b0:480:4a90:1b06 with SMTP id
 5b1f17b1804b1-48526978962mr39186815e9.34.1772809206597; 
 Fri, 06 Mar 2026 07:00:06 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/49] chardev: Don't attempt to unregister yank function more
 than once
Date: Fri,  6 Mar 2026 14:59:16 +0000
Message-ID: <20260306145939.2162189-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Fabiano Rosas <farosas@suse.de>

tcp_chr_free_connection() can be called multiple times in succession,
in which case the yank function will get as argument a NULL s->sioc
that has been cleared by the previous tcp_chr_free_connection() call.

This leads to an abort() at yank_unregister_function().

 #0  __GI_raise (sig=6) at ../sysdeps/unix/sysv/linux/raise.c:51
 #1  __GI_abort () at abort.c:79
 #2  qtest_check_status (s=0x513000005600) at ../tests/qtest/libqtest.c:209
 #3  qtest_wait_qemu (s=0x513000005600) at ../tests/qtest/libqtest.c:273
 #4  qtest_kill_qemu (s=0x513000005600) at ../tests/qtest/libqtest.c:285
 #5  kill_qemu_hook_func (s=0x513000005600) at ../tests/qtest/libqtest.c:294
 #6  g_hook_list_invoke (hook_list=0x55ea9cc750c0 <abrt_hooks>, may_recurse=0) at ../glib/ghook.c:534
 #7  sigabrt_handler (signo=6) at ../tests/qtest/libqtest.c:299
 #8  <signal handler called>
 #9  __GI_raise (sig=6) at ../sysdeps/unix/sysv/linux/raise.c:51
 #10 __GI_abort () at abort.c:79
 #11 yank_unregister_function (instance=0x7fb26f2ea9a0,
     func=0x55ea9bcc0a10 <char_socket_yank_iochannel>, opaque=0x0) at
     ../util/yank.c:151
 #12 tcp_chr_free_connection (chr=0x51300000ffc0) at ../chardev/char-socket.c:385
 #13 tcp_chr_disconnect_locked (chr=0x51300000ffc0) at ../chardev/char-socket.c:477
 #14 tcp_chr_disconnect (chr=0x51300000ffc0) at ../chardev/char-socket.c:495
 #15 tcp_chr_hup (channel=0x514000000040, cond=G_IO_HUP, opaque=0x51300000ffc0) at ../chardev/char-socket.c:536
 #16 qio_channel_fd_source_dispatch (source=0x50c0000b5fc0, callback=0x55ea9bcd6770 <tcp_chr_hup>,
     user_data=0x51300000ffc0) at ../io/channel-watch.c:84
 #17 g_main_dispatch (context=0x50f000000040) at ../glib/gmain.c:3381
 #18 g_main_context_dispatch (context=context@entry=0x50f000000040) at ../glib/gmain.c:4099
 #19 g_main_context_iterate (context=0x50f000000040, block=block@entry=1, dispatch=dispatch@entry=1,
     self=<optimized out>) at ../glib/gmain.c:4175
 #20 g_main_loop_run (loop=0x502000055690) at ../glib/gmain.c:4373

Commit ebae6477dc ("chardev: check if the chardev is registered for
yanking") seems to have encountered a similar issue, but checking
s->registered_yank is not a complete solution because that flag
pertains to the yank instance, not to each individual function.

Skip the yank_unregister_function() in case s->sioc is already NULL,
which indicates the last yank function was already removed.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260302092225.4088227-7-peter.maydell@linaro.org
[PMM: rebased]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 chardev/char-socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 5adeb90865..4e82915cf1 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -370,7 +370,8 @@ static void tcp_chr_free_connection(Chardev *chr)
 
     tcp_chr_set_msgfds(chr, NULL, 0);
     remove_fd_in_watch(chr);
-    if (s->registered_yank &&
+
+    if (s->registered_yank && s->sioc &&
         (s->state == TCP_CHARDEV_STATE_CONNECTING
         || s->state == TCP_CHARDEV_STATE_CONNECTED)) {
         yank_unregister_function(CHARDEV_YANK_INSTANCE(chr->label),
-- 
2.43.0


