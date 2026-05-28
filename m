Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F0DCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 16:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSdj2-0004qx-8p; Thu, 28 May 2026 12:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSdj1-0004qU-1G
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSdiz-0003az-32
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779986207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Ip2bjAxRJdfvSTi20Veh/QnIAIPxTvQvBFus6YZVrN7ayCiqQqE3M5Lqp+QJTvTGzqYQlb
 OgYNTresxWr8bz42V4VQNDQnMZFvUI3fUIIXV1jH5zzKg9W9Sf1/torpCdz6i3IcSA9/1t
 6gvKtqegJm+92ATJQ/NFWtbIsmW/ZTo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-bm32JVuSN1enpvR8FH619w-1; Thu, 28 May 2026 12:36:46 -0400
X-MC-Unique: bm32JVuSN1enpvR8FH619w-1
X-Mimecast-MFC-AGG-ID: bm32JVuSN1enpvR8FH619w_1779986205
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44dad1b938fso7583105f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 09:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779986205; x=1780591005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=VnWpL5Vik3y3W8+89MjXWlYcjcuZJy909i7SSSDIs804OsGHcrk3yuGL5NUBjb/qXo
 DOq9fom7K13c5a2Soi7FFnKpyZBE2WqCIK8OZmE/iTEcQA7q2Ggq634K5H4z/ntR02Eb
 lPGNLwRm8XANtfFglBpaoGb6yIc2hsm2Rsr3sAAEl/y4YiHo0HqVW1gxytbXlm2+D3FY
 NHSZUGwon74B9IvnQ+c4FMJH4NYXE1qdaVfEN5Va4RiK8JOjvzK6Tb4pdDfxDv0prhF5
 +7eZJTty8l+7PV4+VzCMYkkTofJyI4HZEJfmHZ6ja989hf/HghV9H/+yc2mPNskPh6On
 QDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779986205; x=1780591005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=T4Q3gEy8UnKh7ZRr7wMmxNHx2POfs89z4gEXxMiOliJlbGzVKF128NBP50rjNtsJUp
 PQoWoze3/CIBQ4o7hkpJpsu42yadr3aCszKLzbFTBBAMIIXUlNvvbDgCXHGn3XTOGVC2
 GgCBg2dY6SXTkF0D4vnUcr/FMXfNZIkoBvie1NkBUzKowpno3KllDvmh8wt/oEOCuEes
 1Lk6lRvmROqqy++iZbG5OjZQRgNJ+m4v+ZQSbEZzZDnqVdkgSsBv8dfnjf2kREUPledc
 mQV53S/HkU3AhTrmxTnScKT1oiiWJxyBBywtgPnhoZ5l9WhPXuPoal8la7X92UlEme4z
 3nzQ==
X-Gm-Message-State: AOJu0YzWI6GeSX9Xo604d/nFICBnw+v3+9Skn3RcRfmscETjNz7/dZBZ
 +7tv3sHyuTHQTAtbbKt5Wo4ztho5upib8Uz36/OtrqdXOfXo6WOLhQPUrAboErHbOViQtleCrtN
 3x0Yx4KgUZW5H2tWnuTgb7d0xCrraRMNkUdjhQ34QKOegsnNU00JjVuty
X-Gm-Gg: Acq92OF8UDe2S9oho8+lNAkQHsILMJa98osw9K7rZEkC4JNKj28wzXw5UWmOwjR0V0D
 Q15Sec1sZeKno/uiqSq55FSiL9lB0FIa3F0NycqROegE0rWr/jgNi1gRXNAE9hfE6s5K3bQYgo8
 Y29mR5wFK9NwpsMHikXi4RK4bUM67yJMWzplEcl9LX96sd8iI8kBbGvTchjoceW/dE0sWuzZO/Z
 7sbxKmhok4W/Zv7ABGehmpgosKUlkHUFs/+UgMla2PgGsJi2jOOxY26VYt8t6ljaIfNIdumKIYO
 5nph9dqpRnImsjmpfXi+nn8KlveTOnOTUyHZC244TCElCzkfN+RFQP9eJA9f+kgJnFMQhsMLIq2
 BgMCK+oLCOTjWq4osDzOs6CPg2Y1MXahAEYTFpjPHul/OsZPagL2yWn7gkXNLCaEJt0ifryzH5l
 5ZK+1e0nZSb9zmBFYSeE2hLtcwsWltewQ5eVviXQ==
X-Received: by 2002:a05:600c:3550:b0:490:97ba:bc61 with SMTP id
 5b1f17b1804b1-49097babd23mr7951345e9.9.1779986205573; 
 Thu, 28 May 2026 09:36:45 -0700 (PDT)
X-Received: by 2002:a05:600c:3550:b0:490:97ba:bc61 with SMTP id
 5b1f17b1804b1-49097babd23mr7950945e9.9.1779986205196; 
 Thu, 28 May 2026 09:36:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909a23dac8sm81345e9.2.2026.05.28.09.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 09:36:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Feifan Qian <bea1e@proton.me>
Subject: Re: [PATCH] virtio-blk: add missing VIRTIO_BLK_T_SCSI_CMD size check
 (CVE-2026-48914)
Date: Thu, 28 May 2026 18:36:42 +0200
Message-ID: <20260528163642.866534-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526154957.1741622-1-stefanha@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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

Queued, thanks.

Paolo


