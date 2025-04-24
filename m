Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3017C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 04:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7oXo-0005fg-Vr; Thu, 24 Apr 2025 00:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u7oXm-0005fU-V1
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 00:50:39 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u7oXk-0003VQ-C1
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 00:50:38 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3054ef26da3so490569a91.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 21:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745470234; x=1746075034;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=twUNGvdtJjb9xO4JUOcGQb7KHcxtZp2SkLP/1HuKz/0=;
 b=U9CAeDptHt/5BKcp1pnBTqpxX+K2isTmZnWE17FEdCx5wysf9R5F4IXM3jH+D7gTJZ
 Qezb0LrEZU0Q0YWmvIn8myvcVscqkLsbl2oaiIq42GYnzCbRMvnwjLU1zxk5yh0c1fSt
 +WLCxaZLh/7InvfI9ng92XRYt7fHIJaAAo9EpL+2bi7CosXFONV6hdVSK8Uxrty3swvC
 xDNjgEOXJK4wAA5g+ZA01j+OrAvyD3zz86DerFSmV7OjK9phhlSaKCW2AQS3VN4/Vu+i
 gNlaJ5FoNVPWFhZAa8h3bwPWzwoXt8s6eXVDS+6vW9Mjyj4J0MWtil2ZUeOtBqrxOz+4
 oPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745470234; x=1746075034;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=twUNGvdtJjb9xO4JUOcGQb7KHcxtZp2SkLP/1HuKz/0=;
 b=O/wXFwCNXNEkX5P+0/a/+nr7kTo7xnl+ONjvL+2Wv24x4LNIBc+oeheITXQQ7tBbfT
 hCbL2h3HMX1PN40UM63vrVJbUJ1gTdhZCeSAHeDKEVvBRHdVCQtYBKRiPi0bl4DNR3hT
 laIHIHT+h3kfscP2FADhrc+YFUD+qbT2Jm7X1QllNNhHQD9sPxZGVVhUoyJKuyRPy5Uj
 MZsgEi5Ey8t6UdOpi44WEmX01jLFJa236GEJFRyean460e3ixJRTF89a3qI/cheGFNK2
 3jb/a2PmvwLvu+9dLn48lzbLSV95uEVPs6/qfEwIFCUpZ4BIW0kFnlaAYsDmM7JaCnvN
 GVmw==
X-Gm-Message-State: AOJu0YwOPoaAX0OIFkFxCjMPEBkpCZ9bE9/HIc3icV+wmFtZc3/MwuXf
 DXFqkEiQ1ZowQNQLyKbeA5Ped071dlZyiI9Y+0fvDRKL3al7JaAX/TlP/tlvx2o=
X-Gm-Gg: ASbGncss3kjePFxLlgVbXZkt5Ou9RVm2KT+UJcv6DZ15B0hjpRMFguvi5/stgUWOozC
 j7WT8be9mxQCU78ZmssEHpfSPGGilMrT+tJX7JvmCGeeueRgbS3/WPIO1JphcxPJRLvDn/OOnkt
 1edbGlq+u2tLxnp5Qym7opmBbH3faTO80N0U8aEt0M3h3ZpAnTFCqA3ZpNq6u+IvGDZWj8h6Z4z
 DJlv9wOP4og87/j9Y2N4f+aAON2AeXTHDdegzcfApaT57duvrmahZVThRp5rHMlFfj93CRd5M/U
 5DAG0a2z+cP+2rFF1TbrKZrfvJVqmBaHsrOaVkFi87M3
X-Google-Smtp-Source: AGHT+IH41llK0NhWvKWHPmVztXkdCRE7vikouhTGa34ovZSJzfm32s9TyocbivhsLA+Pclbhajweqg==
X-Received: by 2002:a17:90b:498d:b0:305:2d68:8d91 with SMTP id
 98e67ed59e1d1-309ed34bafcmr1781245a91.28.1745470234448; 
 Wed, 23 Apr 2025 21:50:34 -0700 (PDT)
Received: from localhost ([157.82.205.213])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-309ef03ca86sm289629a91.3.2025.04.23.21.50.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 21:50:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/4] meson: Use osdep_prefix for strchrnul()
Date: Thu, 24 Apr 2025 13:50:10 +0900
Message-Id: <20250424-buildsys-v1-0-97655e3b25d7@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAALDCWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEyNj3aTSzJyU4spiXQuTFKO01NS05ESzJCWg8oKi1LTMCrBR0bG1tQD
 PCkw+WgAAAA==
X-Change-ID: 20250423-buildsys-84d2feefca6b
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

macOS SDK may have the symbol of strchrnul(), but it is actually
available only on macOS 15.4 or later and that fact is codified in
string.h. Include the header file using osdep_prefix to check if the
function is available on the deployment target.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (4):
      meson: Use has_header_symbol() to check getcpu()
      meson: Remove CONFIG_STATX and CONFIG_STATX_MNT_ID
      meson: Share common C source prefixes
      meson: Use osdep_prefix for strchrnul()

 meson.build | 80 ++++++++++++++++++++++++++-----------------------------------
 1 file changed, 34 insertions(+), 46 deletions(-)
---
base-commit: 1da8f3a3c53b604edfe0d55e475102640490549e
change-id: 20250423-buildsys-84d2feefca6b

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


