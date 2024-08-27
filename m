Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCA0C54735
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 11:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siu1u-0004xR-S3; Tue, 27 Aug 2024 07:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1siu1s-0004wi-BU
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1siu1q-0007bm-Le
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724756785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iR3lFjN51CE1jLoLe/I5fnr1MRtAlp7Mnt1MPeEhfBM=;
 b=GPjjB7OPOYAjy/QgS29sMf/ri+Pi0jObMj0B6ztw0YNkcSNkgIMrhOtpmnqFDACVr48u65
 QYLS7R/b3WHZLicSz6FvuzO08AJiV+52QQparVLThncJCx/FPJ9ftpqrDFhIS2T5hR6mqL
 /Q4c/dW2PWQ34RVIQ1s5tIa3GEp7EKQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-KdgFAhCgPQ69pJ2Rf42R-Q-1; Tue, 27 Aug 2024 07:06:24 -0400
X-MC-Unique: KdgFAhCgPQ69pJ2Rf42R-Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4280a434147so47247835e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 04:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724756782; x=1725361582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iR3lFjN51CE1jLoLe/I5fnr1MRtAlp7Mnt1MPeEhfBM=;
 b=CdwUNUqU7b0AiAljQmKFv07c6it+mj3ByaCFTnR+5Df0SuH9SsA6kqGafu1PNfM0/Y
 r7DDQReYen4UkVw6AOUlva/gSlMrY06lZrCln78mPNLitxKPCHY/Twt7MjXoxUXgyPhV
 f8bB5pyBtGCoiJDH3w2ksj68XXagkl5bP7gobrUm2b8MnfoH7DGXGCgT0D+XzitQ24fG
 +DMGpK83aG6UrLs4SpecKz51qxajX4It1B2LifNL1iNaI3t6l59+yecT12I+LPIlKFWZ
 eAFMMmbZ7TQY/I6ZYiDIf6dUT7TDMgeSNdVjc+Ce/VdYQ6GvSrCZAvpMinlz6TgqutS4
 rcqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9nx+Wl5AuVzXQ7JGM1rjnhiOE7XtT69GtoPK+cJjzwztrQHPXF17KjJ56tPawx0wvu+StFYrGSIwj@nongnu.org
X-Gm-Message-State: AOJu0YzSYaZmr5wsE3ml2s08R0loHaCfe9w3yq3ufsWi5CAkfuBX3Msu
 yPLRjrvAjYl177vO0jOVuTPWtHv4QOzZdzt2OPKjBTGYDJPvZG5ECjUZFgTolTfxu6UCKcG2ZKa
 KkYfQUo2X+lnTidewISCak/DsfOsuPV/5k47NWSNAlPSQ8wSqWRXfV3Fast0WobQSzqm/hJwpsA
 MmMZsGj9IuhADcCCeFW1DlqjvrZXMnrfPAvZX/GjDsMFw=
X-Received: by 2002:a05:600c:4691:b0:428:1090:cfd4 with SMTP id
 5b1f17b1804b1-42acca01fd3mr78386225e9.33.1724756781904; 
 Tue, 27 Aug 2024 04:06:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAEw3etzpkUQ9ft3YphNNZqtIOWHOBxd2MZrAt5IsYHbOazDDLm08MbVuK1owqGxt1YimjpZ4xeGtJy5hwYdk=
X-Received: by 2002:a05:600c:4691:b0:428:1090:cfd4 with SMTP id
 5b1f17b1804b1-42acca01fd3mr78386085e9.33.1724756781429; Tue, 27 Aug 2024
 04:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240801124540.38774-1-xiangwencheng@dayudpu.com>
 <20240801101210-mutt-send-email-mst@kernel.org>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.d4485eba.82f2.4fda.af98.6cd4ae867655@feishu.cn>
In-Reply-To: <fba0cfc406f202976ef5ac5d129e08524ce06bbf.d4485eba.82f2.4fda.af98.6cd4ae867655@feishu.cn>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 27 Aug 2024 16:36:05 +0530
Message-ID: <CAE8KmOxPS2QsWOesKg7h_euSV7r-z4NPZ9vMvTLY6tOudqJjuA@mail.gmail.com>
Subject: Re: [PATCH v3] vhost-user: Do not wait for reply for not sent
 VHOST_USER_SET_LOG_BASE
To: BillXiang <xiangwencheng@dayudpu.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 1 Aug 2024 at 20:32, BillXiang <xiangwencheng@dayudpu.com> wrote:
> > From: "Michael S. Tsirkin"<mst@redhat.com>
> > How do things work now after 7c211eb078c4 then?
>
> It does not really work after 7c211eb078c4 and it's my mistake.
> I forgot to submit the code to check vq_index in 7c211eb078c4.
>

* vhost_user_set_log_base() sends set log message only when (vq_index == 0),
    -> https://github.com/qemu/qemu/commit/c98ac64cfb53ccb862a80e818c3a19bdd386e61e
===
    +    /* Send only once with first queue pair */
    +    if (dev->vq_index != 0) {
    +        return 0;
    +    }
===

This should help to keep things working, no?
---
  - Prasad


