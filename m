Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B23CA1012
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu54X-0006CM-Qb; Thu, 04 Sep 2025 04:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54V-0006Ab-Nx
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:11:55 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54H-00040M-U0
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:11:55 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b0428b537e5so122683866b.3
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973499; x=1757578299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNutAIaXOMQtmCL/HAblUioHloxc8S7R+7KvtZJ66hg=;
 b=WELSlFtnFMupd5sqLHWtp02i//6odsSXXrotDo50BaGuGqhK6gx47RO6P8p80vgWyi
 JTx/DoQ8vbPmIog8yXfdjSsPBzoq9Y4apzi3aMh6dzF+67TDi3jrs5vIwa5ecXt0YznJ
 zUgN+4D4Z/jWn7WSPbBAZWWwmQPZXyQVbHbFWD2z4WvKVpHLK3g+ei/Di+7/3SAgKzbN
 2+03SqGkQ5vc0MDwP4j/ViAxhkQkRg+5ZQj9oOem3yS6hb0iwcDj0nFZH/LJgvVSQyIk
 kOv2yRCNB+EaS3HqFiEs54QJVL+ZblJTvFOZIDrRm28enddR0AfRuQsCNhCg+L9xKtq0
 JQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973499; x=1757578299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JNutAIaXOMQtmCL/HAblUioHloxc8S7R+7KvtZJ66hg=;
 b=IZXNnxIscOLGvM6tV/Wm2jabt8Vbuj/DUsVMOdL1c21GSB/UDmkDmJwsNtVLs27/JO
 G4aDosHQ+9bOHzYvQOlB5zcb9ne9jz9CBdUeTXcNvyP8g2c7NiGf52KTwV9mQ/JNBmXX
 TgszNanxqSUXnGwG28YG+OA/7W0oOWEow/LdIYardfBCptgxngou+zKmNG4m3EvrjNWb
 7k78hC8MBP/WtgGWMtfGJtY8IWaxMgwqvhWSNYqdgfpLpQbp9KkHXvYUDGlHUM9t9E0L
 7Htmzix5LJ1neA0xc+7XDDVjK5bpVxWy8mQ0diBe6XCBFW9quJ4vjMdMl7J5zsAI1QzR
 RZpw==
X-Gm-Message-State: AOJu0Yxsshv0+/qn93WZ9SlQS2S+S6Uf0JbINLl7xTkcIs86VfClB+K0
 xAJWDLdXHOtYdLl8cZuMUIZnghCoPNv3BrchLqcaRPs4+2LnQzlRkxSRC8avhRkxOHWtEjfQH1f
 qZvIuKL8PaA==
X-Gm-Gg: ASbGncuM8vSqJfGFAgFJFoJlcd8K1NukBeVHQRZVTjDNo8sYbngYa1sgYuJp4emUQE0
 saQmSdunnR79jZqdodFRdr7uWwF9ASjT11I7UP0ueOnA1cjdHUc60zYEP5bjvTOEXD7nDNjREKL
 6v8O/AS9/ggj7hT6cHNntNKxcvqDTcWJOZcQ/e7xY/wOM57XvijlAv/jMq8gS/pmUvMj9qsfiK8
 bgX2W/ID3ssNZZvYnzSs/CMc6gKkp/yP72HiWFl6I1hFDnq/u7PrjdYLKUZhu9THMXzxLjOQaEb
 TkyQNUrSmw7IAd6bSufM/iMX76wWLTkyaKLcZxLPi6FDVWhUZZ9cZHlZbWDTTFnSryC2vNs/qzA
 WWIWFGp0B5QYKuL2KjXsMkCj03+NGp89r6e5l2lYUSJOw
X-Google-Smtp-Source: AGHT+IFJkCbW6+YbkwCqXH5HqGu4cDJmqLYEEKmaO7rAylz2zE8LC1W+s4a2pcKUaXmJqvD/qrocUg==
X-Received: by 2002:a17:907:948a:b0:afe:93e2:3984 with SMTP id
 a640c23a62f3a-b01d8a321f3mr1572672866b.8.1756973498594; 
 Thu, 04 Sep 2025 01:11:38 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff0971379esm1438937866b.102.2025.09.04.01.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:11:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EA7D95F93B;
 Thu, 04 Sep 2025 09:11:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-rust@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 qemu-riscv@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Riku Voipio <riku.voipio@iki.fi>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Laurent Vivier <lvivier@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, devel@lists.libvirt.org,
 Mads Ynddal <mads@ynddal.dk>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, John Levon <john.levon@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 007/281] Open 10.2 development tree
Date: Thu,  4 Sep 2025 09:06:41 +0100
Message-ID: <20250904081128.1942269-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 VERSION | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/VERSION b/VERSION
index 4149c39eec6..9856be5dd98 100644
--- a/VERSION
+++ b/VERSION
@@ -1 +1 @@
-10.1.0
+10.1.50
-- 
2.47.2


