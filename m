Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6526CC6B2A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 07:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHz3s-00073l-Eh; Sat, 17 Oct 2026 03:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHz3p-000730-Od
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 03:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHz3o-0000Ws-28
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 03:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792222951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MYhA9Y2wSljZOhPLto4bwXslRzijsfuLGB01qwOkN0Y=;
 b=BrNhvG4kj511clUTdUQcD/yFReuy2mkw+SASiiMUHjhk4CkctqqNjp4VEmg6pfNO8jy2iJ
 Pra4gR0rINyYl6L2P3903K5kUuOG7oJ3zzkGDUeHeV3M+wf+tV7zKgOrBXoWv2ayJF1adS
 qbpSemKNF/G4XlEViWtmTPlozInnL0M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-39fui9voOuO05z5_zSTpKA-1; Sat, 17 Oct 2026 07:42:29 +0000
X-MC-Unique: 39fui9voOuO05z5_zSTpKA-1
X-Mimecast-MFC-AGG-ID: 39fui9voOuO05z5_zSTpKA_1792222948
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a01d1fb07bso6354235e9.2
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 00:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792222948; x=1792827748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MYhA9Y2wSljZOhPLto4bwXslRzijsfuLGB01qwOkN0Y=;
 b=rt+dyC9kUvYYduNnbj6IAFwap9IeDVSURlDs15ytxjcZ5WYr3pTLdRo44stx0NCMK8
 aVEU15Od8LbGfOyjq37PqbOGFennWlp0UV3g+1F5+Sg1awgKa5ngBYg0Wsq3AG+cbcv+
 8aB9ZhohpCNPrtiqsk2Mpqa702tRXuPa073o+jLi2VBtqwmV/AvA/1Xu0vC8HIO71TYi
 fGD7VEoRdN679n4LvqkeyUlC0yAD3nR3Fq3hXqbEK2/VErn4XZazWD3qD6WNlI594czw
 ohjmzzEmGS4fF/czGuYxeJa9e6qISTRwrzgOIpGonj9hWqFg4mKETxlNmT4vDBOR7DAa
 M7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792222948; x=1792827748;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MYhA9Y2wSljZOhPLto4bwXslRzijsfuLGB01qwOkN0Y=;
 b=ZWlEjLkSPn0MW1FLFdKVuOJ8XUXpOgmR64Pz8Fb6BYB0TEyz82xPZxnXEX64oJsR4u
 Wq/qvoq8EiXkvd0UY/W7JpQYdj1f6KGVnLSI/CW081LzgSB3q3qwg+c31T7Pd03PXCix
 l20OEzW700XCwUItJzXV97SIOjYvVx9zm+/JiY4XtLoQpiXjURoH998ULoTTqnqKAaAE
 z4OSJRPq0nHIF7TgNFddTDMWYy0leCq/jv386x7WXQcbMnbcoJqatZ6Su3KmyodXi/5+
 yPQJUF8cMranrjISZfmMGlK2rpeL837qwDmq3Yc+S3thLH7G6fvDFI3Z/t2kSybAodZ1
 DfmA==
X-Gm-Message-State: AFq9FYJ5V3vjA40rVGaDyABZhCGHwvwvFb0gkXSik4UhiUsKGV22tVuI
 KGYuBwpkyomhdxqEWAdp7+1YM6+pk5f+WDJIXJmiBc02yyCj3PIh8g4DHPmKlvkGRqMYjPMBBS3
 ygtLREQlm1E2SAihK4nVoDEsCHOAkZUMLKy68n+dg3x4OhtoPLrwuJmXNvErlxq4QtZ+vyauZEZ
 RE1RJa6lOsQJTexoiCRDdoesBOeLqXfR3iHHQTnBWP
X-Gm-Gg: AYBFou1UgmLPXIjUwG7baNZoApsjXGiwmw3RxWukt35WtD39goduUP6Sd2yz8FGFW+k
 8FtJAsiIAzPtOomBNCZUC7JBzDob7c3zwd4Eu/4CXWq8A2lNBoXgq0FPkr/KlL9sOlmncmytQKc
 qmsq7knl79dYSvScZpDXndK+5yjMun39YcU9tG6B9PY2cIOvCyvkr/OfDrE+YopCMFYpLVtyp4X
 X2Nyh7XsOyMSWLjhT5XhV3O57l0KD500x31pgVLBYzKvoS64O8V+MUO4NMTLNxZ7py3KqECngq9
 d5T0Ce+FuazobdSHNkWl4cPzZXmDUQxLxHCITY8gMzqxUYxvI+6MeP0G7akAN29ZlwhbEaz/A+n
 V4BgAybmgtCCTEZ+GGOTeRCggR4ikgoq4p/HY/IeIlB9sBsIqnH/ejPfoonFmeLgV4ARp3kxdxZ
 y7bwTc
X-Received: by 2002:a05:600c:1c09:b0:4a1:df2f:ae8f with SMTP id
 5b1f17b1804b1-4a1df2fb8abmr3639925e9.6.1792222948234; 
 Sat, 17 Oct 2026 00:42:28 -0700 (PDT)
X-Received: by 2002:a05:600c:1c09:b0:4a1:df2f:ae8f with SMTP id
 5b1f17b1804b1-4a1df2fb8abmr3639635e9.6.1792222947914; 
 Sat, 17 Oct 2026 00:42:27 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8a81587sm224102745e9.1.2026.10.17.00.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 00:42:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH] tests/tcg: match custom target name to executable name
Date: Sat, 17 Oct 2026 09:42:26 +0200
Message-ID: <20261017074226.1347492-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 43886ac9269..1ea218c7531 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -433,7 +433,7 @@ foreach target, plan: tcg_tests
 
       # build executable if needed
       if exe_name not in built_tests
-        exe = custom_target(exe_name,
+        exe = custom_target(exe_name + '.test',
                             input: file,
                             command: [cc, '@INPUT@',
                                       '-o', '@OUTPUT@', '-static',
-- 
2.56.0


