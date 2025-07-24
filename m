Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF5EC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 13:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uew9D-0002hd-9s; Thu, 24 Jul 2025 09:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uew9C-0002fh-4E
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 09:38:10 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uew9A-0005EA-59
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 09:38:09 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4561514c7f0so10030565e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 06:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753364286; x=1753969086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5KVM6yg+2vGftSBbav6NWO3dAV+ruIfPnO/GludPk3I=;
 b=jpsmQLsFMn47iJXenLufNJCOzkNUvnIqk9U7k8xMpCufB/H0tdtBAVvjTdzS4NwTN3
 9FZU8Xtz8V8CqiuV982j55pDmH0lxQdxdac9rd/N6pJg0F33Ndr88adCgoi63XcrbXVt
 10i+HNIRCSAEAXXkaHt5Ab4TmzF2EFjSHiBdglm8B5NUCKywL1unyEEO52Wehc5P68uw
 YK5v74I3j4+4MSMnRgmI/wTdC39zvVdssnjZgnBgs/JLdG5ZCPnvlc7nCby5ZME3NSza
 dKGhrce5CwNi6I45wZDSluICDkGphWYMEGYH6nh+kyR6B1w45y8IDBdj01BKBf3xHWjF
 rghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753364286; x=1753969086;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5KVM6yg+2vGftSBbav6NWO3dAV+ruIfPnO/GludPk3I=;
 b=Bp96wju+cVh7itDKLB3qajyjttWRMg/BiJuPOUWrQ6EVQ+Z2NYEx/sozTDHpAzoo0U
 /wd4RShyjYd6RldSLVt78X3CTEJOe13yqV15HZCV7HxvED0nG7fo07f2+LRvER7YpNTB
 VpVxIz1KP3EczJ+0vhrFBCRUHwbGZmTYpSLck55E43n69J9gF3EwtAPoYAnmLY3GhO/o
 NXiuU6HDGxKayEQ0Bhw/oKGXPl08kwTjAqIAu0ieJJq9qUhZWdcY1AuRE8qnonZtapbo
 pm7y9znNm0T7oiReLkK2cZGeVI6eM0vR0g3SgtxlfwZQMe5nyN3cxYw3ENq566+aZlCM
 BNZw==
X-Gm-Message-State: AOJu0Yw0MaM55eGgsU2CL8bEL01D9jrL01My8Mogz1aLeZFOc+za9QIK
 GEmSMaUSyjXp0N9xjVbyqa3cW+Zs9MuANi/Csz10EYi8WtsHuG1ruR4w1UG82XQvhHA=
X-Gm-Gg: ASbGncuMzB8hBAf4NZmXRdQzKYXTBF1JjiPaKWKQ92nmJ1l9BQFOFczwM/P+QoVWYfp
 7D5FrqWR934SCdm2T6zsiuj6oYTZhqqjVOCDd9RMhW8sk+s0Y1F3Hoa/XQFy7Aku/F4VBukMW82
 0fm3MV/av882xVVaHTl0U4feIy4QZWFcpavB3uJ/gUKnabjemgGqr5dVUHiAczrrCeziF2v2LSL
 E76Wfv4zQqvNj/cVxiu8BmKvh2CjVsU0TBeoCYe9VE/renQ7GvUqWopekPlumPt4Oq90I3aDUyh
 xqteh4K9sBwNwh8RZuqzZRZ135/1ZLHQ0qJQpA6uPdbPrksAUs5n+Od2Re6SrA5siRH49JgvCjW
 90X7hCIPeZhRXBb69Y2ZIZu9wjldRtbb/Sn5ojdUpuy7Ku+9+20zFO9zgXEfXKaXxaTA81G5PTP
 2H
X-Google-Smtp-Source: AGHT+IGWqWPgk1w5lpZoZoEPw3SVxO6R8twbMSy47HTVy2lcqcCvx9kzG+dw949NIx1uH0d6g9hqNg==
X-Received: by 2002:a05:600c:1e29:b0:456:1752:2b43 with SMTP id
 5b1f17b1804b1-45868cfb59bmr55392385e9.21.1753364285755; 
 Thu, 24 Jul 2025 06:38:05 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054c599sm19859705e9.11.2025.07.24.06.38.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 06:38:05 -0700 (PDT)
Message-ID: <51653111-43c4-4438-b72d-5d9fde2aaea7@linaro.org>
Date: Thu, 24 Jul 2025 15:38:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: add hypervisor test for aarch64
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Burton <mburton@qti.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250724094214.93330-1-philmd@linaro.org>
 <87h5z1voky.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87h5z1voky.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 24/7/25 13:02, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> From: Alex Bennée <alex.bennee@linaro.org>
>>
>> This is a simple test case that runs an image with kvmtool and
>> kvm-unit-tests which can validate virtualisation works. This is useful
>> for exercising TCG but can also be applied to any nested virt setup
>> which is why it doesn't specify an accelerator.
> 
> You might want to update this text give now...
> 
> <snip>
>> +
>> +    def do_test(self, kvm_mode='nvhe', accel='tcg'):
>> +        self.require_accelerator(accel)
> 
> You are now forcing tcg. Or are you planning on adding additional tests
> bellow to exercise split and KVM (when we have nested support for
> HVF/KVM)?

I don't know about KVM. For HVF/split I'm using:

-- >8 --
commit a4c49f63b31da7fb16d29656479d1942efebba2a
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Wed Jul 23 17:41:36 2025 +0200

     tests/functional/test_aarch64_kvm: Test split accelerator

     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

diff --git a/tests/functional/test_aarch64_kvm.py 
b/tests/functional/test_aarch64_kvm.py
index add89c58c5e..f1e0a4382bd 100755
--- a/tests/functional/test_aarch64_kvm.py
+++ b/tests/functional/test_aarch64_kvm.py
@@ -36 +36 @@ class Aarch64VirtKVMTests(LinuxKernelTest):
-    def _launch_guest(self, kvm_mode):
+    def _launch_guest(self, kvm_mode, accel='tcg'):
@@ -45,2 +45,2 @@ def _launch_guest(self, kvm_mode):
-        self.vm.add_args('-accel', 'tcg')
-        self.vm.add_args('-cpu', 'cortex-a72')
+        self.vm.add_args('-accel', accel)
+        self.vm.add_args('-cpu', 'cortex-a72' if accel == 'tcg' else 
'host')
@@ -66 +66,2 @@ def _run_kut(self, kvm_mode):
-        ec_and_wait(self, f'{self.KUT_BASE}/selftest-smp', self.OK_CMD)
+        if kvm_mode == 'nvhe':
+            ec_and_wait(self, f'{self.KUT_BASE}/selftest-smp', self.OK_CMD)
@@ -70 +71 @@ def do_test(self, kvm_mode='nvhe', accel='tcg'):
-        self._launch_guest(kvm_mode)
+        self._launch_guest(kvm_mode, accel)
@@ -74 +75 @@ def test_aarch64_vhe_selftest_tcg(self):
-        self.do_test('vhe')
+        self.do_test('vhe', 'tcg')
@@ -77 +78,7 @@ def test_aarch64_nvhe_selftest_tcg(self):
-        self.do_test('nvhe')
+        self.do_test('nvhe', 'tcg')
+
+    def test_aarch64_vhe_selftest_split(self):
+        self.do_test('vhe', 'split')
+
+    def test_aarch64_nvhe_selftest_split(self):
+        self.do_test('nvhe', 'split')
---

