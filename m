Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED27C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQVB-0006lC-Fs; Wed, 26 Jun 2024 07:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQV9-0006cX-CM
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:07:47 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQV7-0004vX-QE
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:07:47 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7066cba4ebbso2765697b3a.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719400064; x=1720004864;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G/iOJJ9D9CGegt9ZDP3YD3xuz4pE7vwllWj27SOZguk=;
 b=EoPcPHJVhc/enXxpDLynjBEZ13Ft3pNHK41k79SWX//jb+y1wQJ3J7sSMuamI8UOZd
 XMUGVaC3S0XNiRsF79Cn6EZ3bZSoZSbGv4O2OjjloXYJag1tQzKIgP3BFYGjhMcKDTss
 DFlXZTpzw1sFXDs/zhCvuuuOmLGAsnZlEOxSluIX8plw+sNVVAP3gbwneBF244qh6f22
 BE1TulEoSVEiyXuYD+I77o6jQnsP36/oXokjv8aTwjkW3GWZaPuCjZPwBd9E/Ol1Mmvy
 q8nUhv/t3fiaR+jQZOUPg2/lfK5n6lR6wHiBzthhZK+QvYJj1E/KbE42iptsc5vXa0Pf
 wgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719400064; x=1720004864;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G/iOJJ9D9CGegt9ZDP3YD3xuz4pE7vwllWj27SOZguk=;
 b=czeY657mwSTRy/jn0ArcSdeYzA0JIQkpx9z7rjmyc26vGQ89iRBJPAmJYGQ3llJmDy
 OhdRno6YKi5YMfNsxxqxA/1Z0ycsPrhje+ty5vR68acK4hVLE/ENDA8YC0Midk34btrX
 BYaUkmcykC/wEb68DP8RMtWAY9g7BywnEGVXJHliXyDyaBJ/FI57OyCqJanj/I1Uwb11
 RsWM+tXvEnaBI16T/m+Qp7kUCbGBX2QoJc768uWjNyT8M4KnhfZBQx792lyRhkFMJzjT
 fl5BJ+ZZbh+grGq15MgrMAeuNTnBH2BClWVqAjfJp8IOksjKWvtdN4ZXrShkyniQC0Xk
 jD1w==
X-Gm-Message-State: AOJu0YyageoVoYFa/dfEkLnBEDl5ZfA4r+6B1duIt+6xWoWCoFcW3XuW
 bo9uMDw0WPNMmwYUygkwgWJS85BedN8RSTRxNzXkAOhJuEfviTfTkRzOEatuXts=
X-Google-Smtp-Source: AGHT+IGZ7q5EdE7Yacjqa7EIZYyiK5wDOincTnN86B+2e41NepYsx4hlo3KnhsM/EmQA310DcZmMlw==
X-Received: by 2002:a05:6a00:139f:b0:706:3204:fa4e with SMTP id
 d2e1a72fcca58-7066cbd0820mr14170890b3a.0.1719400064484; 
 Wed, 26 Jun 2024 04:07:44 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7065107b425sm9667624b3a.25.2024.06.26.04.07.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:07:44 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:06:34 +0900
Subject: [PATCH 11/14] tests/qtest: Free old machine variable name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-san-v1-11-f3cc42302189@daynix.com>
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
In-Reply-To: <20240626-san-v1-0-f3cc42302189@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This suppresses LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/qtest/libqtest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 28683fee28b2..06585104c7af 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1502,6 +1502,7 @@ static struct MachInfo *qtest_get_machines(const char *var)
     int idx;
 
     if (g_strcmp0(qemu_var, var)) {
+        g_free(qemu_var);
         qemu_var = g_strdup(var);
 
         /* new qemu, clear the cache */

-- 
2.45.2


