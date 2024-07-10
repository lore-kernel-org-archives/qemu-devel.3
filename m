Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B81BC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 10:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRUFB-0005TB-1H; Wed, 10 Jul 2024 06:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1sRUF9-0005Sc-9g
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:08:11 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1sRUF6-00008c-1i
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:08:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-367ab76d5e1so1664248f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 03:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720606085; x=1721210885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+1JRgQ4XYuMQWdbzd3Ma3YwUhRokMQHze4y+TXChMoA=;
 b=XDzixUPH+MxITyuBuFEQCJACMwgtWT5WhUgjVhY3vgbgt7MOoRYx7bchAvd+Lt0j0j
 PWyioIKvA5MFX2EL5HkL+C8Z5yTTT+noQ1F4aXL5yRZ7XYDPXXcCEXGI2eqtKLe0bN8a
 1R4jvEWEpIY3pF9CQHks4lK+o6P9G2w9q/c+M5nR7UaAQyJ9Y/MPZxbjYZgU4UGlJ3ak
 /5H7yVbFQvGp8IwzPL1LYRF2phZB6xx+CZrVUJhFs4dxIeGxFLIUPxDEz1R4/sJZh+IP
 nykGbkvaFrIgX5fuZkp6Z70v7G+VcS1T1NtHBXpr89PYJmwhG+2Z1MVZDy8K3q7yyh9P
 SBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720606085; x=1721210885;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+1JRgQ4XYuMQWdbzd3Ma3YwUhRokMQHze4y+TXChMoA=;
 b=N9T9KJTskORYM4YIgUcUNo3SNQ6kQKlNxGFTReLkOSvgBWjwfBoEc7CAf22Zs2QnoD
 QCCuul0DttJ364wMKiltfh6Wp8GbK79LoQnseZ/B8KfT3IUN8sCrJXeJ+tFHHZMTZMLU
 AeIa9Wm/Z1bqIneysWXNztAvA3fDiM4uB3Z8wcGjXWYOdW9tIA2mbUNatcQWqv5bXVql
 nEj51YXvQmxehJ3hgiGIFj5aX0As2tngZO+KZsMet61fvhkTO+LcNTwwwTVc/xZn5viY
 WajgWVpC+fO1arCWtQqR4Sq9Dta023JsTQpojWXgXMIRRKk7xleazqsfT+heR7xCD4J3
 mq3Q==
X-Gm-Message-State: AOJu0YxUqX3TGcXCE9mBLg/hvH8U2XiD0R10Qs5Rrj3LkNWACmrj7rxo
 pNp5g/zEM3jtfhd31Pk/R+/f8uXk/zd8tAo+12pr/SPSm/CVNio9cueLKK3M5yE=
X-Google-Smtp-Source: AGHT+IHqRHsbBZc4GeUbzTCYLoHXU7NHzt9sgG/ux6FuQNYXuT+gqvyQZ0Qw8KsE1LxPEPOI8LBrGA==
X-Received: by 2002:a5d:6910:0:b0:367:89a7:da5e with SMTP id
 ffacd0b85a97d-367cea67dedmr3019297f8f.19.1720606085054; 
 Wed, 10 Jul 2024 03:08:05 -0700 (PDT)
Received: from TRC26085-X11.huawei.com ([77.137.64.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde7e039sm4959161f8f.2.2024.07.10.03.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 03:08:04 -0700 (PDT)
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	stefanha@redhat.com
Subject: [RFC] Per-request private data in virtio-block
Date: Wed, 10 Jul 2024 13:08:03 +0300
Message-Id: <20240710100803.6644-1-dmitry.fleytman@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=dmitry.fleytman@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hello QEMU-DEVEL! It's been a while…

I work on a solution for "smart" IO caching on the host side.
The configuration is virtio-block device backed by SPDK with OCF/OpenCAS
on top of remote storage.

To improve decision making for caching, I would like to have an additional
per-request contextual information from the guest side. It might include
information about process issuing an IO request, a file this request it tied
to and so on. In general, I'd like the set of collected information to be
flexible and configurable.

I searched mailing lists and other related sources and surprisingly found no
mentions of the topic of having custom per-request data in virtio rings.
This makes me think that either I'm missing an obvious way of doing this
or the concept itself is severely broken up to the point it's not even
getting discussed. There is also a possibility that I'm just missing a proper
search keywords...

I understand there might be be security implications to be considered.
Also having custom kernel patches to have a flexibility of choosing which
data to collect is probably not a viable solution.

Please share your thoughts.

I would like understand what is the right way of doing what I'm looking for.
If there are new mechanisms to be implemented in virtio or other parts of
the codebase, I'll gladly work on this for the sake of community.

Thank you,
Dmitry

