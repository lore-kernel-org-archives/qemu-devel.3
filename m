Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA90C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 12:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ8rd-0002Im-W0; Wed, 31 Jul 2024 08:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8ra-0002FU-Aw
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:55:31 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8rX-0008Cd-RC
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:55:29 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-368313809a4so535530f8f.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722430526; x=1723035326; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BdizTaiIOj3XiATRIOx9O5r92l1ZYjEmqKDDizk8Syc=;
 b=PWpTxPed+JnLtuROTF9GVhmyFsFcYUvqiTOzcfuNwiwBgMB7N60rR9ijTCtpkxdwus
 jtsx2ebnRaKuE/O9BRwLD0qeh99o3pWv5ziny8oEa0LIh5r8lBFV5u9dZQpbxRYwFrTK
 IsniWGxhAgBBRxlvjUrXC0tK5qkcew5qSamsJy3d6GgeccLtZDe1FWm0VUcGdF8Csi4A
 l75LMlkFVTvB7np5ed39OvJdfU9IbGZ9A4UznaVsKan1IErVKmxxa/biBE2XmCb8PntL
 MEkA+3zCJNhEuzG6z+AFuBtMdV93y3NUpq4y/jEamZbAwgMraxZmG6m7s8TtM0xMoegV
 Zf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722430526; x=1723035326;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BdizTaiIOj3XiATRIOx9O5r92l1ZYjEmqKDDizk8Syc=;
 b=WciUZK9yZWF+aVgLAs0rjqkzhFq5QeGqYgwFNkjYVvqlLJC0SpxDH65B+LLerub7qm
 Psk+wvto5pXp1R39onz/4V/50ZD50rkLmjUXoIg+tDn213Tcbap6MK3OXg+TUoOnKSWZ
 RhJwFrE3SMyddnltjATl0B3GvUL2pcOuP38cI37lccSg/masdhUAYJ3O0h1eHYmrrJen
 Q2l+69zYz5khg4eltEtDX/tfg4XMrshBHLV1La4PM1Jop8+p2n0Dbx9H/caeRC6FzfK6
 zrUEbTdjFW3X99GG5nla30eVrdh4HswM3SjgzVe1btOSJNxhk1eKMzcqCf7oJUZhOWdy
 B3sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtkAWQcONEx6qFCNS58pV2mEPF3A5SIimh3e5SzyNBrZpoJJCL8jr0OHlan6TwRR2wnVirJWeR6G90aTKqdGG3PJD88lU=
X-Gm-Message-State: AOJu0Yyx7FMi3Oiqkj/8EV2yqYbRZALCm8AANBogAv95DOQsM5tF4okq
 gOdVbnfa77pdR/MIGyNniz9fxnW0qLMgVDzkTMU0IbM3MV8xTs/znQbx/eEiSQg=
X-Google-Smtp-Source: AGHT+IGb2oYPLhxJWvcin5X+G+r7AnGkBuexU8fbhTQQec3Oyeb0URvlsAi41Hx3m1PmV796BNsfAg==
X-Received: by 2002:a5d:5685:0:b0:36b:5d86:d885 with SMTP id
 ffacd0b85a97d-36b8c8fdbcfmr3700335f8f.24.1722430526008; 
 Wed, 31 Jul 2024 05:55:26 -0700 (PDT)
Received: from [192.168.214.175] (29.170.88.92.rev.sfr.net. [92.88.170.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282f382abcsm3137025e9.1.2024.07.31.05.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 05:55:25 -0700 (PDT)
Message-ID: <66e83689-3b38-43b1-855b-3f4b167f07d5@linaro.org>
Date: Wed, 31 Jul 2024 14:55:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/24] tests/functional: Convert avocado tests that
 just need a small adjustment
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-8-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> These simple tests can be converted to stand-alone tests quite easily,
> e.g. by just setting the machine to 'none' now manually or by adding
> "-cpu" command line parameters, since we don't support the corresponding
> avocado tags in the new python test framework.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/meson.build                  |  6 ++
>   .../test_info_usernet.py}                     | 11 ++-
>   .../test_ppc_74xx.py}                         | 74 ++++++++-----------
>   .../version.py => functional/test_version.py} | 13 ++--
>   4 files changed, 53 insertions(+), 51 deletions(-)
>   rename tests/{avocado/info_usernet.py => functional/test_info_usernet.py} (87%)
>   mode change 100644 => 100755
>   rename tests/{avocado/ppc_74xx.py => functional/test_ppc_74xx.py} (74%)
>   mode change 100644 => 100755
>   rename tests/{avocado/version.py => functional/test_version.py} (78%)
>   mode change 100644 => 100755

Please squash:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index 98eddf7ae1..a906218f9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -317,6 +317,7 @@ F: configs/devices/ppc*
  F: docs/system/ppc/embedded.rst
  F: docs/system/target-ppc.rst
  F: tests/tcg/ppc*/*
+F: tests/functional/test_ppc_74xx.py

  RISC-V TCG CPUs
  M: Palmer Dabbelt <palmer@dabbelt.com>
@@ -2101,6 +2108,7 @@ S: Odd Fixes
  F: hw/net/
  F: include/hw/net/
  F: tests/qtest/virtio-net-test.c
+F: tests/avocado/info_usernet.py
  F: docs/virtio-net-failover.rst
  T: git https://github.com/jasowang/qemu.git net

@@ -2969,6 +2978,7 @@ S: Supported
  F: include/qemu/option.h
  F: tests/unit/test-keyval.c
  F: tests/unit/test-qemu-opts.c
+F: tests/functional/test_version.py
  F: util/keyval.c
  F: util/qemu-option.c

diff --git a/tests/functional/test_info_usernet.py 
b/tests/functional/test_info_usernet.py
index ded973253a..cd37524d94 100755
--- a/tests/functional/test_info_usernet.py
+++ b/tests/functional/test_info_usernet.py
@@ -19,7 +19,7 @@ class InfoUsernet(QemuSystemTest):

      def test_hostfwd(self):
          self.require_netdev('user')
-        self.machine = 'none'
+        self.set_machine('none')
          self.vm.add_args('-netdev', 
'user,id=vnet,hostfwd=:127.0.0.1:0-:22')
          self.vm.launch()
          res = self.vm.cmd('human-monitor-command',
diff --git a/tests/functional/test_version.py 
b/tests/functional/test_version.py
index 5e566d76b1..3ab3b67f7e 100755
--- a/tests/functional/test_version.py
+++ b/tests/functional/test_version.py
@@ -17,7 +17,7 @@
  class Version(QemuSystemTest):

      def test_qmp_human_info_version(self):
-        self.machine = 'none'
+        self.set_machine('none')
          self.vm.add_args('-nodefaults')
          self.vm.launch()
          res = self.vm.cmd('human-monitor-command',
---

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


