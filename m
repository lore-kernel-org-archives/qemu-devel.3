Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1F2C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 08:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUMcM-0000FF-0t; Mon, 29 Jan 2024 03:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rUMcL-0000F0-1r
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:03:45 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rUMcJ-00056o-F9
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:03:44 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-29041f26e28so920800a91.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 00:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706515422; x=1707120222;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SIxzhhspqMAWnYZrU4WfhbnNIInPUebmookIDK0Fz6g=;
 b=zOTM+J/MjUDd8LVcrmXF4upvr1xdhtgNyTeOdM/WvYLAAMcXELVVANPqfyFNaulUPZ
 cXn3RSSGr5hWJVRC5QowZw2g2GJ6y6I1/XvA05RRfLzNQg705VOkywmVVKkW7xc4Hz/I
 zkBxMOLKzAdD6/yzFb8OcZJrYJQ0rxi6PP82L7wFSndE5ptuL6RAZLvQK4rkJB1Z6G7v
 cXP6FbD4wLRsg9NBMlqUgEsL4fUVdWpe/v6v6TkN3GAyppPBsgfWLhHaIfaUNiuYZJxS
 QPH+diqaTkwCh4ItTd+UsL/5kTKOF80lufU+1IsuGMpWvYvXxMsoGtfWAl8VeW4i3BY6
 4lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706515422; x=1707120222;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SIxzhhspqMAWnYZrU4WfhbnNIInPUebmookIDK0Fz6g=;
 b=U+1BNgzWY4LX7Hewes7EMJn17eeqjAdCTWVLAcaJ4/FUUjMZfk4DDHCthNVWUsxqUP
 cCdq95ibA2l+lkV1KgZ0egRq27gqAhudUThVjIbTzrwmxfkn9Tl7btDCAhgxg2/OzP8e
 P8BfmY5PpzmfS6fGI5vZhhGU9rbw3OTwnQ+idQoCAhOB+2T07mRbwK8Oi4JNs3oY8vN3
 kyR/gos40GlyMetDiEPh9GvRqsXM5zK4j7zIU7+ECNJGiIFeBbG9gf46yzI8lmJscPfP
 AfLnEAGCjdEXCOaQ/4+2RPRsm3TasnYPkpWjk2cgThI66GQNDV4PnLKZovELdFV7+vYL
 woiQ==
X-Gm-Message-State: AOJu0Yw0YEfLzn/8URruE5atskrAyZQDIq57lvaqutna1Kp5WJoop3kK
 9M3XFy2Jz7ibXDQ/7PQdwGICkFcUnD1pItB6WqKlF2S8skHVfU+uP7n1lCSE4d4=
X-Google-Smtp-Source: AGHT+IEQq1Z30GAddME/mPXWOsvS4eQO3D5lcT3VbySp+Yo6UU7pAh5C/qFQLnjg9wSxbYLh+EJkgQ==
X-Received: by 2002:a17:90a:cc04:b0:28d:70b5:fafb with SMTP id
 b4-20020a17090acc0400b0028d70b5fafbmr1572192pju.32.1706515422004; 
 Mon, 29 Jan 2024 00:03:42 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 sh9-20020a17090b524900b0028c5585fb41sm5589015pjb.45.2024.01.29.00.03.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 00:03:41 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 29 Jan 2024 17:03:08 +0900
Subject: [PATCH v2 2/2] hw/smbios: Fix port connector option validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-smbios-v2-2-9ee6fede0d10@daynix.com>
References: <20240129-smbios-v2-0-9ee6fede0d10@daynix.com>
In-Reply-To: <20240129-smbios-v2-0-9ee6fede0d10@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::1029;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

qemu_smbios_type8_opts did not have the list terminator and that
resulted in out-of-bound memory access. It also needs to have an element
for the type option.

Cc: qemu-stable@nongnu.org
Fixes: fd8caa253c56 ("hw/smbios: support for type 8 (port connector)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/smbios/smbios.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 522ed1ed9fe3..8a44d3f271de 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -346,6 +346,11 @@ static const QemuOptDesc qemu_smbios_type4_opts[] = {
 };
 
 static const QemuOptDesc qemu_smbios_type8_opts[] = {
+    {
+        .name = "type",
+        .type = QEMU_OPT_NUMBER,
+        .help = "SMBIOS element type",
+    },
     {
         .name = "internal_reference",
         .type = QEMU_OPT_STRING,
@@ -366,6 +371,7 @@ static const QemuOptDesc qemu_smbios_type8_opts[] = {
         .type = QEMU_OPT_NUMBER,
         .help = "port type",
     },
+    { /* end of list */ }
 };
 
 static const QemuOptDesc qemu_smbios_type11_opts[] = {

-- 
2.43.0


