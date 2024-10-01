Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14218CEACCB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdhO-00026N-ED; Tue, 01 Oct 2024 10:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1svdgr-0001sn-2g
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:17:28 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1svdgo-0004Pg-5Q
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:17:24 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2facf48157dso25922691fa.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727792239; x=1728397039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2WQlDxLbePhp13jG9hD2NprrdP1cs4Jy0dZFWVY2lxc=;
 b=LtKzSq0NnBH9wKJ0ZLrlFKCbGppYRaKIdHzzJpdMvCdqwyjOBv8lt0rCYcftG7F0uL
 vFnqPbTL6LOjUki33SZftx9iA19PZWOXzRzcOYYlXM0I2pik06bJzpMKjV/NcFEI66XX
 2vk6fVE3ZaKo/nSxKoDiY6L6zE1Ts0LiGsjQzZznhSs3oq0VyBwz4kUezBFhA7H+CKtS
 OJiDsBlI4UxIzanWJZsz5c63KgqTIQnWmUheBdWDP1IUXWvqc0cdvOIdZk6RJSCfoYyP
 jO4OfnbW0JCaptdu+lMgbjsfT2YrsRZKLwiprrs96tOmyCkT3d22FbttHLNuR6hP/Nef
 SZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727792239; x=1728397039;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2WQlDxLbePhp13jG9hD2NprrdP1cs4Jy0dZFWVY2lxc=;
 b=RW0mqqR8g091xADSKBjNKdCl3GXvRAAv+12lldOFfvCOcl6HO4yER9NUr0HbZJ1WfC
 FciSFp8Xl/9UjssmhsujNfAxvTC2Az3FZJcL2ctlyWMc87djLXqSjTC3QWTHor55cDEu
 N5yKUyyAjYNX9CGv0dJnynZZwgbo/phcpMZy7XRQsphNkBdugM9BXpqvL7dYn8DdzovO
 RkvVIxDZMbOM8u2Z50rxBkQxQRjmCAdy1MtTndFBdjgO5Nn2/OwouZ2dBdGkhVGrLpCZ
 3kYdSASsBZpxVnvVllPV0MXAUdStk6REcd6E+9eezVJjz3ptEKegM+w1Ur+oZubbkPZh
 dzsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY1AUW+Yqft+NfSUr4tAOU88K5lOidheyT3mt9xh1RJuuQ6HeGVg4lKB3kMHioLsW8UzzhImiWoraP@nongnu.org
X-Gm-Message-State: AOJu0YyyDApfrU7kySyF7sGl9HFwwUP6QWzw87yevQujDgRin6mfnfYh
 u95/JfaP7wXmP0WK5Vw8Jv6wWd+QXnUYNS9XzKsGHz4RHVv31sN+5hpI5HZsaMIKAay+0VwQMoB
 /ero=
X-Google-Smtp-Source: AGHT+IF5s/4w073shuhDAc3yvc/KUV3YPjRZy6r6eHsXo9nVn7rZcxcP3kE4ZQZDdAc/q4J8EBc4GQ==
X-Received: by 2002:a17:907:7fa7:b0:a8d:286f:7b5c with SMTP id
 a640c23a62f3a-a93c492f7admr1491638866b.27.1727772720663; 
 Tue, 01 Oct 2024 01:52:00 -0700 (PDT)
Received: from meli-email.org (adsl-74.109.242.227.tellas.gr. [109.242.227.74])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c297bdeasm671491466b.167.2024.10.01.01.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 01:52:00 -0700 (PDT)
Date: Tue, 01 Oct 2024 11:50:07 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH] tests/functional: Switch back to the gitlab URLs for the
 advent calendar tests
User-Agent: meli 0.8.7
References: <20240930171834.51701-1-thuth@redhat.com>
In-Reply-To: <20240930171834.51701-1-thuth@redhat.com>
Message-ID: <ko5yn.bgayz532vi6@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22e.google.com
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

Hello Thomas,

On Mon, 30 Sep 2024 20:18, Thomas Huth <thuth@redhat.com> wrote:
>Shortly after we switched to the original URLs on qemu-advent-calendar.org,
>the server went offline - looks like we are better off using the gitlab
>URLs again instead.
>
>Signed-off-by: Thomas Huth <thuth@redhat.com>
>---
[snip]
>diff --git a/tests/functional/test_microblazeel_s3adsp1800.py 
>b/tests/functional/test_microblazeel_s3adsp1800.py
>index faa3927f2e..47c941d487 100755
>--- a/tests/functional/test_microblazeel_s3adsp1800.py
>+++ b/tests/functional/test_microblazeel_s3adsp1800.py
>@@ -18,8 +18,8 @@ class MicroblazeelMachine(QemuSystemTest):
>     timeout = 90
> 
>     ASSET_IMAGE = Asset(
>-        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
>-        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
>+        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day13.tar.xz'),
>+        '67e4c502651f8801e724ecc26403f1d0cdbc00549b033166e2e8cd14e9d49fef')
> 
>     def test_microblazeel_s3adsp1800(self):
>         self.require_netdev('user')

I downloaded both day13.tar.gz and day13.tar.xz and these archives have 
different file contents, is that on purpose?

