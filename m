Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52573D58D5A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFatn-0003wb-BK; Mon, 25 Nov 2024 10:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatm-0003vz-1U
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:14 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatk-0001kO-BD
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:13 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3822ec43fb0so3565268f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548071; x=1733152871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f876UYCjxWzb/D/C1siZ0PBv6QO/F33fPkM03nCnrnI=;
 b=RfME4+iDg8873elAiS9ekAZZBezu0Pj3WhFHdg3YwbwbSJv4bMYK/EBLFwxo1axsC0
 kY403BreLd1yYYAaDnQFPI8T1BEOUwu7YS/jGcN8Xa0jmrdsbKZIjS3HLMa0pOvStT+2
 ArmVnBRLIfCEHOXsJrmqj0YbV9uZGW+s3mFXImVl9nVC7gxdTtP/hFaKXCUX/HMcAcTz
 orNJu/iLEA6L9gXUjrTDUaPEmRS1MSmzJP3Sj/Wh1VeDPWEdJlje/QIevrfBxU4qtENa
 OgL5WUIF5mUkPsp4EZvj0I0ZxrkU66myEDFRmVlNkUqFC5bMeEv48iRmjbfol6qgz75N
 64tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548071; x=1733152871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f876UYCjxWzb/D/C1siZ0PBv6QO/F33fPkM03nCnrnI=;
 b=TPcx1RA7qvjdwaylENDrE8iCgFwSmCMV9+MTNhKBKye6pD6Fx0VbdpL4zLQ5o4rNS9
 mPFa1j1chaxNtxFwOXcVjuPymvzs6HChWbnF1WiWm98qu4NXeHuMC2zeSgDuRGNYv5Wl
 tcM3Eb2BZjWogNwFAbpkfEL9dKXBlhCPeJ4gIZtY0UD5xnh9famtp6Z8X7cEDYAygMUT
 PzInLi8BL1EC6E5MWcZXh4N899KXdn0NFD9vvXBmz/TNeLwDh1qE8yn1Jth6NQOsUNo+
 ICF24X17D6Xap7wyHhUgnhwKCSSmVm7TZsEIBUWptIuHhn6IQnZq7NcFUJqqS44OFykQ
 MTqA==
X-Gm-Message-State: AOJu0YyCspTuqMbg8LndsH7b9383+ON3gKu7UfAweM3Ja6aCykOdJtPZ
 mxqParP4Kd+k+ACKukkzqS54tQrMcw6GcRTyz8SWR6ztGFVQjir5zFn7mgysyig=
X-Gm-Gg: ASbGncu1gtyNhrJExwN9BXXHrsc98wzMT7WCdtNoQbCWO7YMpLdmkFznxLeGjj92FEW
 FHl4Pee8UXjMFT3OZs47XJlM6TmN6EdN1pGS8CDXBDt89HE7SKXKp42HlSru2jW+ekqH+1I5g7M
 pLHdQmITvyaBiWr6sY7maoeydCAP76I8tZM0VFJrY8G61YOGiSaDCXPX7MoswetpPn1TDak2ZBm
 KFqc2grwyL0FNoQFqGJinZKz4PsT1HzU2GAGcZQ99mENoWt
X-Google-Smtp-Source: AGHT+IHrzjhLMuFtWxIyb1jz9gmAKrY6jeiH5/8QQirZjIU/GljGUWoQGSyRcnIqZh6zjAybZQpOyQ==
X-Received: by 2002:a05:6000:1845:b0:382:442c:2c54 with SMTP id
 ffacd0b85a97d-38260b81426mr10539381f8f.28.1732548070683; 
 Mon, 25 Nov 2024 07:21:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825faf9be8sm10674878f8f.24.2024.11.25.07.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:21:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 73E795F9D9;
 Mon, 25 Nov 2024 15:21:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 07/28] tests/functional: remove comments talking about avocado
Date: Mon, 25 Nov 2024 15:20:44 +0000
Message-Id: <20241125152105.2100395-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The first comment is still relevant but should talk about our own test
harness instead. The second comment adds no value over reading the code
and can be removed.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-8-berrange@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-8-alex.bennee@linaro.org>

diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index ee40647d5b..4c192d95cc 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -196,11 +196,12 @@ def copy_test_scripts(self):
         for filename in os.listdir(bits_test_dir):
             if os.path.isfile(os.path.join(bits_test_dir, filename)) and \
                filename.endswith('.py2'):
-                # all test scripts are named with extension .py2 so that
-                # avocado does not try to load them. These scripts are
-                # written for python 2.7 not python 3 and hence if avocado
-                # loaded them, it would complain about python 3 specific
-                # syntaxes.
+                # All test scripts are named with extension .py2 so that
+                # they are not run by accident.
+                #
+                # These scripts are intended to run inside the test VM
+                # and are written for python 2.7 not python 3, hence
+                # would cause syntax errors if loaded ouside the VM.
                 newfilename = os.path.splitext(filename)[0] + '.py'
                 shutil.copy2(os.path.join(bits_test_dir, filename),
                              os.path.join(target_test_dir, newfilename))
@@ -399,8 +400,6 @@ def test_acpi_smbios_bits(self):
 
         # biosbits has been configured to run all the specified test suites
         # in batch mode and then automatically initiate a vm shutdown.
-        # Set timeout to BITS_TIMEOUT for SHUTDOWN event from bits VM at par
-        # with the avocado test timeout.
         self._vm.event_wait('SHUTDOWN', timeout=BITS_TIMEOUT)
         self._vm.wait(timeout=None)
         self.logger.debug("Checking console output ...")
-- 
2.39.5


