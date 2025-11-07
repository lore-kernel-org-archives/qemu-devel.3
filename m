Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A44ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 20:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHSv9-0000vq-7B; Fri, 07 Nov 2025 15:18:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vHSv3-0000vX-Vc
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 15:18:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vHSv1-0008R5-1E
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 15:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762546724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=1YOnvZ7QRftWr+JfAaLDU9bS62Mbz50FJI7AidWug3M=;
 b=N4pbtptK6ASI+X6w7ll2xIa8uc647PRUC762z6F3WxhBZs10ptYXf15XX8BHaisnZ68Unw
 04RfRt8XEZSQoamjnL4M0DIUy7gAi+wkZs0O8ol87xkk593N88ijzvO0WsK8GAzd6f0fDu
 6K1EfQOmqfeFiAxJxbkiBy6d0hefe0w=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-xA0orE4NNu2UifaBcPPkuA-1; Fri, 07 Nov 2025 15:18:42 -0500
X-MC-Unique: xA0orE4NNu2UifaBcPPkuA-1
X-Mimecast-MFC-AGG-ID: xA0orE4NNu2UifaBcPPkuA_1762546722
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-786a7bdc438so21517567b3.0
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 12:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762546722; x=1763151522; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1YOnvZ7QRftWr+JfAaLDU9bS62Mbz50FJI7AidWug3M=;
 b=Un8fiVrPzDOwJ8HxFNqDMp6FQLlCGdzNKn0CvkxMbDFHYz/vVpOxADirE264RV22J2
 qv+qtBSHv/yzsyaLeGg8E89ZasDXvrhziSJPdDawD/8QRfKjdKyk/XPKzI+27IBi1VRB
 pUnr1ZAve7TQIrEdXkIkOVfoCTMiWD5HeoMQIzd5WwhymS+9MkEeS8pW6TdDSvDVz4vr
 l9Ju3NDaQ0xWk/Xs7ms/8Ki9cgOVDizp72uUI2kX9/JLt/0N6gfjUIKt07seE94hT64o
 nW2NitIKkNB7oW0YAwG2btfCJVI5a+lH5qNQwjfmn6IdImWWl9szpKj31H0rmxcfCvci
 ZlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762546722; x=1763151522;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1YOnvZ7QRftWr+JfAaLDU9bS62Mbz50FJI7AidWug3M=;
 b=EebEyxLqbAD4iiry6s8/61Cn/2QdaYJl4cm7t7BVZ50ElWAgz6e2hvuSQ/0K3OxZW6
 gAscCW5Uqoi+IUJvOSDEBPOCjLnBhfVT6r0v+MU4EU4uAw36LYkJWvtNesWO/Tnt5P/X
 A4rYphV2qvPxVgEg4T2F8O2CwS+5o4GRF2nK+rJxkqSEft6c0BxvHqUaaVp7oeJHByAZ
 PfJY95BF1qMljcHPSQLLrckr61/mnO4aGwbFLnJz0TvLpuFyprXPoxDbEodJbKrGO1Dg
 7hjfaD5acAIIdFNOvFi0n9wS/Km09VwWaDA7zs+wVla1JZyZPu2dlDIAjwlpXsT5QLr9
 FUGg==
X-Gm-Message-State: AOJu0YyZRKMsGR8G2zYoxa/01bhVpz3NrR4WXWYRsHxfEqCtnFfrZSNf
 f/cQ+CGmDsOHOIxAiQsz2T3htox6UlOoSHbZxGAvs1P0Hsm5PxwCE6zd5Lv/jXCONuyxFNM+KVR
 VFgdruqU4Q2mf4uJhVjBkzU9wP+E02TpChUB875GyHuEjXB5MHxOFYT0ekJwqTpbcOoabP2zFTQ
 Ws1kbikUl7fh1fBFn8BYZoXJP8hHGIFeg=
X-Gm-Gg: ASbGncuECxhG1t5/zLruFzudeR/Bo0dBGfqAx7T8AbGToiMMZXaUce4UwkxTbtc8C0Y
 a4svrskakm1BJznzCzbvwY+jLaXfv50BeCa76CC6n8/Bqt3/+1BOPHz5BNreRKhnBTZH2YSDYkd
 iW9/DMBbi1hbvwbSOee2MIX0qxrePr2a2AUnjLXQRQU0D2fUl6hQ1z
X-Received: by 2002:a05:690e:419a:b0:63e:1f42:a469 with SMTP id
 956f58d0204a3-640c9d62439mr2516307d50.16.1762546722228; 
 Fri, 07 Nov 2025 12:18:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmvoRiACBDBjhQ6ua9BX6S64yRmsh0cz4NCgEiGki3NjNcC0tqGPm9mbu33vNW2PYl2xcAnkeySWWHco+sK88=
X-Received: by 2002:a05:690e:419a:b0:63e:1f42:a469 with SMTP id
 956f58d0204a3-640c9d62439mr2516288d50.16.1762546721927; Fri, 07 Nov 2025
 12:18:41 -0800 (PST)
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Fri, 7 Nov 2025 15:18:31 -0500
X-Gm-Features: AWmQ_bmM_xZdyBB8u2_2uKM_6XCd5SQ6HS9QORA1LonO6lzq9Z1pApXFgKLNm4s
Message-ID: <CAFn=p-ZqLCJ2uRm4MSeewPbKyN8g+B95ELVkP9qaXdE2tObf_Q@mail.gmail.com>
Subject: Meson help
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hiya;

I tried adding a test dep in meson to execute an ensuregroup command
for check-functional tests; i.e.

commit ddb9ae03e1a29a036aa708016fcb747d77b1fc6d
Author: John Snow <jsnow@redhat.com>
Date:   Fri Nov 7 14:41:04 2025 -0500

    test: add pyvenv test deps to func tests...?

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 725630d3082..dd9a1be18e7 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -66,7 +66,7 @@ foreach speed : ['quick', 'thorough']
       target_tests = get_variable('tests_' + target_base + '_' +
sysmode + '_' + speed, [])
     endif

-    test_deps = [roms, keymap_targets]
+    test_deps = [roms, keymap_targets, pyvenv_test_deps]
     test_env = environment()
     if have_tools
       test_env.set('QEMU_TEST_QEMU_IMG', meson.global_build_root() /
'qemu-img')

And then I tried removing the "check-venv" targets from
tests/Makefile.include; but now it appears as though running "make
check-functional" doesn't work; it doesn't invoke the ensuregroup
hook.

What am I missing? Do I need to change the way "make check-functional"
invokes the test suite....?

https://gitlab.com/jsnow/qemu/-/commits/python_drop_qmp


