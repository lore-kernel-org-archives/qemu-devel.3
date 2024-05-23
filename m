Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8810DC25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9t2-0004sn-6m; Thu, 23 May 2024 10:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9se-0004J0-RP
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9sc-000471-G9
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oz7CXmEGB8H9CB1Ih3mY/njvC8uRis0RohRSCchlBSc=;
 b=JGgKpUkzA5nx3ijmFyCNVPdJ23Zixzw7MCBJpFfqNClzLVIxEq5TR91zERYZbG92Eda5Sj
 6CBq225jok1zB3aaPjfsUop00zL0hnk4nyAVXbSs8gzkCD/eZgbfQ5Xkd6gwCSMmkfYNh9
 72SF68XV5YAeABEHxVDrVKwB8h3dZKw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-qIjrN6TbPpmFyLqa2uTP4A-1; Thu, 23 May 2024 10:57:16 -0400
X-MC-Unique: qIjrN6TbPpmFyLqa2uTP4A-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-43f7dba5d72so2162851cf.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476234; x=1717081034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oz7CXmEGB8H9CB1Ih3mY/njvC8uRis0RohRSCchlBSc=;
 b=LtQJRhPkgcos9IgqkWmXi+z3NqvN3MqOR0DRar+zyjRL0Tc/xY52I8An6Tk0o1x5SV
 kBzRzTKbJ15oCET2VAfJmYADwBbDSysARQghG/remjMDDMFtNy3kKTBquL4LnBoHoNj2
 GGPkY5+djXDGu1GBdPPNLSoP2GqX23m524fjdbQ7MFEoYRsL3HQnAkvm7uNO4XIZVxDP
 1aEfcTzagKJ1b8qippTZnAl/fHEwACYVhk0UsrZMWEes2ZXJFwBZcuPYNqNh+Wr88vys
 /ltitezrRNvhzs/iZU0CS/Q4VNiMuH19tm5JUAJqDtpFtVq79IqhvNMmJZwx+gIBhCoH
 8JzA==
X-Gm-Message-State: AOJu0YxIfMsNCuxTH+10JJJcVAsN8MYV4fJTrHS8pXtjlg2tX4B8imHs
 EyOG9wmENr0RYabG+UYxMvy4Wbc9n2TMjVSn4WlCO1yBPji15TW+4CLR2CEEmLn/b67P8j6Jfus
 nYhM9asLRemNk+GpKkHxB6fhDjJ8IP1w4/FzEC/aPXZmvOE4ZrBBGauauIRszKzSjucluynw9wk
 ttCHiEI0jy8sqRrjEH5KyZzUjNLofOMbPBHOcm
X-Received: by 2002:a05:622a:242:b0:43a:d7a9:390 with SMTP id
 d75a77b69052e-43f9e0ae4e7mr49036421cf.29.1716476234169; 
 Thu, 23 May 2024 07:57:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9o75zA1DWnxNJTkg2uWIN9fVcZCsH1LHayMVQzL8KVSF8dzDS1Tkmu+0m0U9wE2qF+ecaag==
X-Received: by 2002:a05:622a:242:b0:43a:d7a9:390 with SMTP id
 d75a77b69052e-43f9e0ae4e7mr49036051cf.29.1716476233803; 
 Thu, 23 May 2024 07:57:13 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fa1a906eesm18405351cf.20.2024.05.23.07.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 07:57:12 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, gmaglione@redhat.com,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 12/13] tests/qtest/vhost-user-blk-test: use
 memory-backend-shm
Date: Thu, 23 May 2024 16:55:21 +0200
Message-ID: <20240523145522.313012-13-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523145522.313012-1-sgarzare@redhat.com>
References: <20240523145522.313012-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

`memory-backend-memfd` is available only on Linux while the new
`memory-backend-shm` can be used on any POSIX-compliant operating
system. Let's use it so we can run the test in multiple environments.

Acked-by: Thomas Huth <thuth@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tests/qtest/vhost-user-blk-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index 117b9acd10..e945f6abf2 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -906,7 +906,7 @@ static void start_vhost_user_blk(GString *cmd_line, int vus_instances,
                            vhost_user_blk_bin);
 
     g_string_append_printf(cmd_line,
-            " -object memory-backend-memfd,id=mem,size=256M,share=on "
+            " -object memory-backend-shm,id=mem,size=256M,share=on "
             " -M memory-backend=mem -m 256M ");
 
     for (i = 0; i < vus_instances; i++) {
-- 
2.45.1


