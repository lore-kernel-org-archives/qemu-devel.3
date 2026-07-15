Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FFEC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk1k8-0006PQ-Em; Wed, 15 Jul 2026 11:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wk1k7-0006OW-5k
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wk1k5-0003T7-JY
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784130108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ns4ByQU6neYcP96eAzyJBgeNcc0A7yd2UrsYhbk1IWg=;
 b=CRINW6o5o6PmACXpyRbJJ9UswDNCNrIAEIzg0QSU4DwOR5H/3Ef4+PK0lamhjBJNeNDPZ8
 rrnNMB74W67qjzUdB4FMoALLi8LxdmHQgwbMWBaAEDnJB3eMca1v8cSr8EgBrdVNxsGPco
 6ngsPPS04dcg/76ScEsRMP9dZd5yJns=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-HRfLgS0nPq-3pEvyz4oqsA-1; Wed, 15 Jul 2026 11:40:39 -0400
X-MC-Unique: HRfLgS0nPq-3pEvyz4oqsA-1
X-Mimecast-MFC-AGG-ID: HRfLgS0nPq-3pEvyz4oqsA_1784130038
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4926596eebcso16351775e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784130038; x=1784734838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ns4ByQU6neYcP96eAzyJBgeNcc0A7yd2UrsYhbk1IWg=;
 b=lIpJrNPnZHsMBeAwWtZSO+CX89AIvejgGIIZSdT1K/ZIS1lxHv0hoVs3hsXW/KQ3qA
 q330TF7q4RZ2Bq6gyDpQOSD0ueoFPPFHrCQX+f2wc+zyJ6yx0afA5ec6X2ipAT+DQTdg
 mnHqt8ObXeCQ2Rr+CtLuAlrTBkszpHGeIEi9tMA/+7IQx/lhnBsEf975d7g8JnwRBXXM
 Y0aE+mE2s+7ZZdFkkwsnSO1uV89+sBDHunJyVDX1AL48SFb0ypYFz8TK/cPvI92z3dIp
 eDLmK8vC5yrk6G+gNMiL9ex38ZmXUA303grlZeKzpxaPvIaKyok2kQA8GwABrct13YUX
 Fxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784130038; x=1784734838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ns4ByQU6neYcP96eAzyJBgeNcc0A7yd2UrsYhbk1IWg=;
 b=Nr/e9Hn+PQvJf/7Rs1MjgZ1Vn5PFjzDNDKzP3UBf7J/1ZFd2+mW8/mWbalHXcMaOZk
 Y7aNGV+PB2BHQ5jJZJC8F3Fy/5ZS9mAWiFM779INpgVwL8SIDCsZKnh+DZAA9VV4R0Re
 jbibJA42Rt/w4rVjv9DkmkC4WMAarTvp0JtWD1/RA3tAfZGoFizGyRuEPC/PjZMzV3EW
 mS8LzlO8naFXsxNHMoRpWz4eFXwWkQss3phLG6DYd3BObJ2R0P9BbErOVJ8AWtY5baO5
 vu93LeUjqbwd3admtqL/fD+BFg1f9sHW85tgGs0Fo/tCPCceWw3JZ8DFDDHZ37crwpNc
 MJKA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2QITjjKupfSn+AQUMACfrBUw1JC2SEvBDW1CsvmFcSBgsvP4FrNMGZ7Eq9Fvo7cTaHmH+O1thu4wU@nongnu.org
X-Gm-Message-State: AOJu0Yy3NesH9tcGFrqunUTa1WJQQ5o50H3bCA4yN2hWAPGz3J4uvkH4
 7WqieReB2PHt13skroa5/bW6Mn4otddDolLQ2utupF/TWlkIIoi/k42UWhFwA0w+HupsTp/LzM/
 DTYkZHwI7WSLUiEIhG9QO1N28Gez1qflpuCHTbr0aLCPgoWDkq1wtCmlD
X-Gm-Gg: AfdE7cl77C5H4TyP8QZngU1QXhktggO1wSvmNj1j7AVzOhXmYbOmb9DX1oGDjnyFIRb
 U0fYmX9BflqpD4kX18YhDedT0baLBhT4tkXMKJkJSpETTsXjAfhFIrafaA5OckD5KIrpot76Y2P
 3RGeIdYs2TkKiCOTmE1W27JmLI2oWmuhH/wbZzlHcUT2OODt9hr02rdDjBz9a/vsvE0Gq8FfVfb
 7kHFv9jz1Jiec/hs8rwLfdbQ6cDkWaOEDzX2qulwOoXs2Q1PKvTIlfFUUvPHZKYonijQoF7YBtU
 /J9RLswBvUr8OXWMVdyQMZpLMt4rxQNFoH18Ch31tj6sPKph8iofLbcyD/tLwvbF8gPcu6vf9D7
 htnpzwpUDspBCi5qBbfAVdMUJ
X-Received: by 2002:a05:600c:190f:b0:495:4056:2c6d with SMTP id
 5b1f17b1804b1-49540562c8fmr8306485e9.23.1784130037962; 
 Wed, 15 Jul 2026 08:40:37 -0700 (PDT)
X-Received: by 2002:a05:600c:190f:b0:495:4056:2c6d with SMTP id
 5b1f17b1804b1-49540562c8fmr8305885e9.23.1784130037180; 
 Wed, 15 Jul 2026 08:40:37 -0700 (PDT)
Received: from fedora (82-132-245-114.dab.02.net. [82.132.245.114])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e0e4sm18496740f8f.4.2026.07.15.08.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:40:36 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: aesteve@redhat.com
Cc: cohuck@redhat.com, manos.pitsidianakis@linaro.org,
 marcandre.lureau@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, sgarzare@redhat.com,
 Dorinda Bassey <dbassey@redhat.com>
Subject: Re: [PATCH 0/3] hw/display: add vhost-user-media device
Date: Wed, 15 Jul 2026 17:40:03 +0200
Message-ID: <20260715154003.128073-1-dbassey@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260630112310.552606-1-aesteve@redhat.com>
References: <20260630112310.552606-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=dbassey@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Tested with vhost-device-media (v4l2-proxy backend) on Fedora 43 guest
(kernel 6.17.1), proxying a host integrated camera. Device detected and
frame capture works via v4l2-ctl --stream-mmap.

Tested-by: Dorinda Bassey <dbassey@redhat.com>


