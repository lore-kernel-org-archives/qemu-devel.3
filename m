Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F695C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSenZ-0006SJ-FO; Fri, 20 Jun 2025 12:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSenY-0006S3-0j
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSenW-0000Dh-H2
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dg0lyWp/iYHR0SwtBFKYV9jsMjYg3PofI7llGsLHSMo=;
 b=Ivse6f++J6dORJMzQ2RYxJJpO7LhAnKw7fQnT9bbQiy7V70XZQ+1V79AsAAZTjFR56G1C6
 Q+9nRMSuxGQE4XzEV39WbROiLwXeGx72d3MrkvabKdZgHA/FPmEJ5G3yacWHr79peXooW9
 ZB4538DTGcR1ePDawZ1aQPIzIlHPzX8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-5hRGvIxhPZO3mPkV87cNbw-1; Fri, 20 Jun 2025 12:41:00 -0400
X-MC-Unique: 5hRGvIxhPZO3mPkV87cNbw-1
X-Mimecast-MFC-AGG-ID: 5hRGvIxhPZO3mPkV87cNbw_1750437659
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6077833ae13so1591842a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437658; x=1751042458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dg0lyWp/iYHR0SwtBFKYV9jsMjYg3PofI7llGsLHSMo=;
 b=R1VwaQ/l3DuyN8BqkTPWmJ2EBe6lw07t4M+f4oO4TAQQkrRIhhfEVXopl89jtCkjOY
 dR4RXcuW7w1CQXkGYw20gl/oZFshuPPoUZsaoMC8UDBsZYo/aoe0H0hoeBUOUlAHLB6w
 +6jgkCF/ezPn9mfcUg+mAKOgTcPSPK06hOW05qyOjYtfSSKgEtcg2XamRCVYc1DDeIzK
 8J+SwED90tnDVlqMtN1aQU9SEYI6/I+6pzAEwwwOdf8dhNqB3YalMo72lN+HonZujEys
 C3g8t58DJYKBb9uhuE1wlipHmBdh++yNofpADzmluDKg5TA9vJ6kZZKnnpB6JesGq3Ng
 j3kQ==
X-Gm-Message-State: AOJu0Yzgymvd0icox0gHFfOUNQYFBooDwALJrq5Hgfcn6E4osrNvHIRB
 7y3HRCcxp6L4lXEt+Z1OkVToy36PI+pwK/EQxhZo22G30E8I9Rg0o6nZnP4luj/aYbLJ4Y+xSIp
 JAnocbapwvv7oPBf+7ljhOn5uoA0ik/ZZM3J+wA1WSDYMxcqoSlZKaJeyVzLnRhW8muWz/HuLj1
 X7s5nhK68DO6U7bbNlAtnydow9bJKOJaUtf1UiyBUQ
X-Gm-Gg: ASbGncuekzB70p2fR2YadSRYnZAjxFr3RHs9MLSxRNRLeuWu8rRzG58yqjmpK1Mstby
 i6Jv2NO2bwgzHuZfjakg9RxkKm5sWImkwSce9cvZzof7ecJa+8A4JsPUWY/j29higzENVwlRRYF
 VXQLl6L4zohYqfB2Gfa6DE4CHC2ksLLXSvaUAGANJy1dWGUpKUAZ6I5U6ZusJdPXdBhHlYTic5y
 0dbqIdjVyyrB28XmjCbIt/DSOWsXbc5Pzkb8ObPr/sXWxXrdZ7TtuqHP2k5dwVcwq0wHi2gtEtH
 aNXeQuHXnIg2lRC5sMZ0KnEU7w==
X-Received: by 2002:a05:6402:1e89:b0:604:f62b:4118 with SMTP id
 4fb4d7f45d1cf-60a1cd1a88emr3115268a12.5.1750437657882; 
 Fri, 20 Jun 2025 09:40:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm2Vv9lHQkXerKFiYB2TIpO23tiNUC8NS/3eSZHdis7Z++pIOlykAucgDZysigDUg15X+mfQ==
X-Received: by 2002:a05:6402:1e89:b0:604:f62b:4118 with SMTP id
 4fb4d7f45d1cf-60a1cd1a88emr3115246a12.5.1750437657375; 
 Fri, 20 Jun 2025 09:40:57 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60a18cba650sm1591266a12.55.2025.06.20.09.40.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:40:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/24] meson: cleanup win32 library detection
Date: Fri, 20 Jun 2025 18:40:29 +0200
Message-ID: <20250620164053.579416-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As pointed out by Akihiko Odaki, all Win32 libraries in MinGW have lowercase
names.  This means that on (case-insensitive) Windows you can use the mixed-case
names suggested by Microsoft or all-lowercase names, while on Linux you need to
make them lowercase.

QEMU was already using lowercase names, so there is no need to test the
mixed-case name version of libSynchronization.  Remove the unnecessary test
and while at it make all the tests use "required: true".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index 34729c2a3dd..ed60be2a2d0 100644
--- a/meson.build
+++ b/meson.build
@@ -843,15 +843,12 @@ host_dsosuf = '.so'
 if host_os == 'windows'
   midl = find_program('midl', required: false)
   widl = find_program('widl', required: false)
-  pathcch = cc.find_library('pathcch')
-  synchronization = cc.find_library('Synchronization', required: false)
-  if not synchronization.found()
-    # The library name is lowercase on mingw
-    synchronization = cc.find_library('synchronization', required: true)
-  endif
 
-  socket = cc.find_library('ws2_32')
-  winmm = cc.find_library('winmm')
+  # MinGW uses lowercase for library names
+  pathcch = cc.find_library('pathcch', required: true)
+  synchronization = cc.find_library('synchronization', required: true)
+  socket = cc.find_library('ws2_32', required: true)
+  winmm = cc.find_library('winmm', required: true)
 
   win = import('windows')
   version_res = win.compile_resources('version.rc',
-- 
2.49.0


