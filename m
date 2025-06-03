Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBF9C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPRO-0000n5-NU; Tue, 03 Jun 2025 07:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPO-00083B-PC
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:18 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPK-0002CR-Om
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:18 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-606b58241c9so949509a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748948533; x=1749553333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxDMdaIg8arEcAZqrWcxA6HfH8o9FpNz/62pOCW6kuE=;
 b=uAfU+QNwVYabdGwPLXYx6HEuLLyVl2xpzz2dPr+9tMmKBLzczk5hi0Kt1e+9f3IwWl
 AKrSLlBAXVM7gH5u182yxRcsBL0u1PPwMQWbrwXIA8hQYuttV7h/qw8lKW0HLcj4PyKH
 84CgpdNHQDy4splOsF43sJtzKZ/ChHRI+EYkAXFuXsWkumv+VngLfWgivg0zSptXQM6y
 G0B+ORlpNkD3B9NJswCR1U5O1gBKA52mlV6KnFno0KPfCGd53nkew2GfbGvMSDijKCX6
 JRvOYSOZGsxUBoKOexmP+wRB5aFHt2SzovZmMwmvB1KudhkcV4fNfBd+mQOv0osNxc1v
 araA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948533; x=1749553333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xxDMdaIg8arEcAZqrWcxA6HfH8o9FpNz/62pOCW6kuE=;
 b=sy0lGKAl9uFLq3ou4p9YtwLvW7fFSsD8gtZ6iSKV1yp7xz35xWyDwT3BaQNvB6kj5P
 HpVbrlBtaCZhTHeHFf08YYuJ/jRxdmDR0eeoVXa9bdN/x1nqNpayDXWOsOCsNvNS1T4C
 oWCgyBq2EnxY0+Th8t/qfVjq+Hjsixg5BsAQqC1EB65AMKLjWG6R0WB2z0J70CgxiRNp
 tZ1LfhetAlza7N32bHUJUvMJxJQoXO0q3SexR7jHxs2NT+T8h6zCOrv2meJAte6iAOT3
 HAnza2/VymsutFkRsdUG6ll4vaoWUqhUg0vUYHWqeVPB9TDNZcnyLTIJtD3589s/8kgZ
 C2Dg==
X-Gm-Message-State: AOJu0YxbgtzPpuui7PtsbfiqUjSQISe7Azeb/2dGmL/fVqKxYO581rzu
 mhHqTDHo2lTQY5TAvdV6/rjEF6S1D2zHlmAvF3+ortqhVvv3HStWAF+8e8Upob8vzYU=
X-Gm-Gg: ASbGncsaxRn5d189wgNi5Ccj75jRxr51APVguzGuYCrOG/y8VbrhBgSTVcXRxG5NFPL
 BjNB3+Qw6Ef+OCb2XuHQlHyHZ04VXFSvnt7td8U/ynmaZhEypgVFIpA7gqskBclkZhmEQgJ19D3
 ydMTUND+CVc9oq70x6Sbqao9hR/5igmCUNAj+CzVYT1LG/s2p69aAqbSCYHSMklLgjSOZURjz7l
 whfw6vnFPQ6he/uZHxvCELXLkCPk+G9X1bCweC6hIuQ+gW0Fkfl/bSpDzcPTW5zux5zAZX614js
 PAS9lGcEAvZtIWOIb8EhpRXK+FnibN1QqEBUmQOLU9tmpvPtLcrf
X-Google-Smtp-Source: AGHT+IHfIW2Pdwvv7tPD/bQM4YVttqLyO1J4izr2UJGWTKej3lF10cPs8bcQtT/XHxP+j2ngTDKBfw==
X-Received: by 2002:a17:907:6092:b0:ad9:982f:9206 with SMTP id
 a640c23a62f3a-adb49606242mr1105080666b.61.1748948532999; 
 Tue, 03 Jun 2025 04:02:12 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5dd043a9sm930549066b.89.2025.06.03.04.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 04:02:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A27CD5F9E1;
 Tue, 03 Jun 2025 12:02:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 08/17] MAINTAINERS: add Akihiko and Dmitry as reviewers
Date: Tue,  3 Jun 2025 12:01:55 +0100
Message-ID: <20250603110204.838117-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603110204.838117-1-alex.bennee@linaro.org>
References: <20250603110204.838117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Thanks for volunteering to help.

Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7718199979..79b1d5c0b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2669,6 +2669,8 @@ F: include/hw/display/ramfb.h
 
 virtio-gpu
 M: Alex Bennée <alex.bennee@linaro.org>
+R: Akihiko Odaki <akihiko.odaki@daynix.com>
+R: Dmitry Osipenko <dmitry.osipenko@collabora.com>
 S: Odd Fixes
 F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
-- 
2.47.2


