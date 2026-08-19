Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE9AC5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfds-0008EF-M3; Wed, 19 Aug 2026 08:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <opensource@fvhovell.nl>)
 id 1wwfOH-0004cs-Pf; Wed, 19 Aug 2026 08:27:33 -0400
Received: from outbound.soverin.net ([2a10:de80:1:4092:b9e9:2292:0:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <opensource@fvhovell.nl>)
 id 1wwfOF-0003Ay-1i; Wed, 19 Aug 2026 08:27:33 -0400
Received: from smtp.freedom.nl (unknown [10.10.4.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by outbound.soverin.net (Postfix) with ESMTPS id 4hQ5S14mHqz1ygm;
 Wed, 19 Aug 2026 12:27:29 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [10.10.4.107]) by freedom.nl
 (Postfix) with ESMTPSA id 4hQ5S03HSNz40; 
 Wed, 19 Aug 2026 12:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fvhovell.nl;
 s=soverin; t=1787142449;
 bh=+UNopd3rEpoOE4vhf7HjnT3fdOZb12RXY49c0YWAI1Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cZD5r3s8AS6KopDgw/Gbqxc1D+ucrgCQbgqRqUmrslTxItfaLCQq9fU+U0KciAp2o
 siCWSrdEwGA0ceU8cPUBiNa5J60uUd/DGg/3EyEp02/tcghbDsyCyR86C94qYm5LMW
 84SrXdmhHSUB9F8glz7WODR+JdGEjNmcbCbh2H1JEoHKRUopCfilVJZ5k5Z3/EHU21
 AzNLRlDA0foAbvbLdxxdDRjS7m7pIIrt9gG6g0cppTg2mSeAuboGb09p1Vuw3R72e4
 BoTIaGOb7+fkpvcAeurGxcd3uu7HoqH/+FEtOV8+OXuPnFUavB8IJ71opzmH4k8YSh
 pnkXPoghnzEhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fvhovell.nl; s=soverin1;
 t=1787142449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=84PrhzbeQahLUde2Vy+bAnQx9PYAr4wkmcY+KvX6SBY=;
 b=b7JLbtG96XXgOyLkSDVGg4Cag4hXQu1Z5CXLE87XWQYAggVqITYb+1wBJGvlGJqQ7hkYCt
 qu7uBCBH9ntVhwLTAXlbcehaHs/q/k/XVuWG8pQT9i85MiO0fUqeMKsLQL7wBW9WFy74GN
 2lErwwqAwnSVH4Zi3m8xT6PyOWgEXhQLo5i4YoJZarXO6QjCL3n338Nzk0gPnBqLjDP6X2
 RWoKfe0DzdIKAJIWPa44kg2v5byowkza7uJOetZudgBYS4K7LB7t/NsMWPZBo/jyWzgD0W
 Le72nfE6qrU7TyHKtkRLYgEhvCMWYS5D14D+rjjns+58B7J5pWbVmTzowi5xDw==
X-CM-Envelope: MS4xfKnf/a1B+YrJV4mjQ7BtiwshbKr7ED2zFcnQwbo7DRzOZ0kV804VpDK0i3AlLyofBCOeclsNb8brXGViID94JQ9CPJ6zEqpp2hfkh+y+1duQ0q+HcEG2
 pULPJPU0+rHZDJQz4UedVZopMIRHqjFQwAMPfes/i7uKEVcJgJU96WKr0zl4zB+hjgXChPC1eI03FMo/WJm2F3L6fBd8o8Q5c6CeYv7GKi0ERfvtnOArnRsb
 xW6u78lOrAZQRIrfZ/rb/fAV3jKgS6KrtxxEclllwOTr4wA4Ynq8UbAn82eeRHH76tjSzxY3Y6OS5Cq3qEw+hxxPaCqDc2s+Y0ztcDT40dOlumypKfEADioA
 InR4Ef3bFz8wSFhAj/yZhfJ1qPQt1h5Meww06sPx+0NnmbD9fBM=
X-Soverin-Id: 01a019fd-a768-793f-9339-1ff1f212d531
From: opensource@fvhovell.nl
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Peter Maydell" <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Frederik=20van=20H=C3=B6vell?= <frederik@fvhovell.nl>
Subject: [PATCH 4/4] tests/functional/aarch64/test_raspi3: update firmware to
 v1.52
Date: Wed, 19 Aug 2026 14:27:02 +0200
Message-ID: <20260819122702.54173-5-opensource@fvhovell.nl>
In-Reply-To: <20260819122702.54173-1-opensource@fvhovell.nl>
References: <20260819122702.54173-1-opensource@fvhovell.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spampanel-Class: ham
Received-SPF: pass client-ip=2a10:de80:1:4092:b9e9:2292:0:1;
 envelope-from=opensource@fvhovell.nl; helo=outbound.soverin.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 08:43:31 -0400
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

From: Frederik van Hövell <frederik@fvhovell.nl>

Signed-off-by: Frederik van Hövell <frederik@fvhovell.nl>
---
 tests/functional/aarch64/test_raspi3.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/aarch64/test_raspi3.py b/tests/functional/aarch64/test_raspi3.py
index 709c7221fa4..ffc6f2517fd 100755
--- a/tests/functional/aarch64/test_raspi3.py
+++ b/tests/functional/aarch64/test_raspi3.py
@@ -14,8 +14,8 @@ class Aarch64Raspi3Machine(LinuxKernelTest):
 
     ASSET_RPI3_UEFI = Asset(
         ('https://github.com/pbatard/RPi3/releases/download/'
-         'v1.15/RPi3_UEFI_Firmware_v1.15.zip'),
-        '8cff2e979560048b4c84921f41a91893240b9fb71a88f0b5c5d6c8edd994bd5b')
+         'v1.52/RPi3_UEFI_Firmware_v1.52.zip'),
+        '20b894d15cdb42e055872a7ee6a850aa9373aedcfefd27f19767d975ce4f7371')
 
     def test_aarch64_raspi3_atf(self):
         efi_name = 'RPI_EFI.fd'
@@ -27,7 +27,7 @@ def test_aarch64_raspi3_atf(self):
                          '-nodefaults',
                          '-device', f'loader,file={efi_fd},force-raw=true')
         self.vm.launch()
-        self.wait_for_console_pattern('version UEFI Firmware v1.15')
+        self.wait_for_console_pattern('version UEFI Firmware v1.52')
 
     def test_aarch64_raspi3_bios(self):
         efi_name = 'RPI_EFI.fd'
@@ -39,7 +39,7 @@ def test_aarch64_raspi3_bios(self):
                          '-nodefaults',
                          '-bios', efi_fd)
         self.vm.launch()
-        self.wait_for_console_pattern('version UEFI Firmware v1.15')
+        self.wait_for_console_pattern('version UEFI Firmware v1.52')
 
 
 if __name__ == '__main__':
-- 
2.55.0


