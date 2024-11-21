Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D5FD7879C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAfQ-0003MG-Df; Thu, 21 Nov 2024 12:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAds-0000iS-RK
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:06:58 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAdU-0001e0-Kz
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:06:55 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53d9ff92ee9so1185275e87.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208790; x=1732813590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKSlp2StJiDHmkXzo7470MDoOcCvf0WQxR2JFqIuwaU=;
 b=RmnxEn99mgYdc/9UfQyjYZjqYetXA9btr49kj9BOtD4fhcqhiQgivlluSejKtkwtIF
 nv2YpFG6nQKYD8CxsZD4ZepIYyQgzJh2k5tLUH7B8EefivN42HReVzDBcNKJWDwarlOf
 N7AzpJETTegMceqW6PYi29Xx/QMmR/HbqltbTPYyksxY4E9iwmnos9kHvI0OisLP6pG+
 zzBRpw8hL3cMVs2xyQxke6FHwBLMdRJqYhTG78BN1ejAnXqlBl1mcVrLMlIPnW57Uq/0
 /FQetGEE7vio8fUq94ZNYN3rjjbhkkk6TGdcF679dKlKeuENQuQD2pYsnH99QwscoLSg
 pRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208790; x=1732813590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lKSlp2StJiDHmkXzo7470MDoOcCvf0WQxR2JFqIuwaU=;
 b=WFSa6J4sPqV0q7hBdHWNVexuUMkBv4nfNnA9+o2LkVNHbhaxSiChlJXg7sJ1SdRMj6
 87dB8klOulIEQU55InRmEr/GhoaVdOjhtB8SBjBHcMdy8jrQo44mWk3u3+oIKUDtR5Kx
 te+/TO6wQwiGWInBMjkvOP8e5MHMk7GhvZGcXz6Wq+Uwr1oWCww8hSphN5oMeWYd+m7B
 CjzFI05tzmPYagFNq1rJh1hypEWUUEgXQzBqWO5Hc6pp0yeKbFWxDK8ajTsDZ5J7nAiP
 EAPqziH0VkjTbEvvOSklKbDTHIFcQprSf3/tFY8KU3dkNskLlompS9KXFksq0PNrq6U2
 1ECw==
X-Gm-Message-State: AOJu0YyCcdHSPj54EXjElfU2nIkz8qLe8l1KuNDSgbb5Rxk1ZGd7Jln5
 0eTTrKjO11TBz+LGRH7lyCqhjDC8Hxzy4zP0T78TPr6g01pnHfqiWOFA3Zbp/lg=
X-Gm-Gg: ASbGncvyY4XnMuBj7v+07AcZX6X7pYr77EqkfHJfZLwR6v31tV53bsQOt7X+rzy/Taz
 LkE6ahXT7q2o87PAwcR6lcG5uDV4usrNN1PCLs9VZZm9b3qEplpIV6O4qhwNrWBslxcDNh/HGGd
 ubZGNokFTlSXeMaEtCv0bwD2Ds+9ZqsHT2HZJLiz4IVlECCGg8VVwco0NfBsBeALZkrUfh8joYW
 urZ9lOCxdU5uB3ZlRvsFfzhqAvg4BX+KCr3MYtTp3dqAIWq
X-Google-Smtp-Source: AGHT+IFzgvZj8BpFhjW7oQ1YcXyB/eXTGw2Wn6FwaN94Z+jLXJ1sebzEliD5C63SpEklKV87rV5/lA==
X-Received: by 2002:ac2:48ba:0:b0:53d:9ff9:d63 with SMTP id
 2adb3069b0e04-53dc13291e0mr2757628e87.2.1732208790182; 
 Thu, 21 Nov 2024 09:06:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45f5c33sm61927565e9.10.2024.11.21.09.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 09:06:28 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 77C8A604B6;
 Thu, 21 Nov 2024 16:58:09 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 33/39] tests/functional: update the sparc64 tuxrun tests
Date: Thu, 21 Nov 2024 16:58:00 +0000
Message-Id: <20241121165806.476008-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x129.google.com
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

Now there are new upto date images available we should update to them.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Anders Roxell <anders.roxell@linaro.org>
---
 tests/functional/test_sparc64_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_sparc64_tuxrun.py b/tests/functional/test_sparc64_tuxrun.py
index 1c2c005630..3be08d6102 100755
--- a/tests/functional/test_sparc64_tuxrun.py
+++ b/tests/functional/test_sparc64_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunSparc64Test(TuxRunBaselineTest):
 
     ASSET_SPARC64_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/sparc64/vmlinux',
-        'e34313e4325ff21deaa3d38a502aa09a373ef62b9bd4d7f8f29388b688225c55')
+        'https://storage.tuxboot.com/buildroot/20241119/sparc64/vmlinux',
+        'a04cfb2e70a264051d161fdd93aabf4b2a9472f2e435c14ed18c5848c5fed261')
     ASSET_SPARC64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/sparc64/rootfs.ext4.zst',
-        'ad2f1dc436ab51583543d25d2c210cab478645d47078d30d129a66ab0e281d76')
+        'https://storage.tuxboot.com/buildroot/20241119/sparc64/rootfs.ext4.zst',
+        '479c3dc104c82b68be55e2c0c5c38cd473d0b37ad4badccde4775bb88ce34611')
 
     def test_sparc64(self):
         self.root='sda'
-- 
2.39.5


