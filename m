Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A101FC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUy9-0004pG-1s; Mon, 27 May 2024 03:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sBUy2-0004nK-UL
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sBUxy-0001AE-8V
 for qemu-devel@nongnu.org; Mon, 27 May 2024 03:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716795621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tzry4NJ2iAn6riKSPOqv17p7ZjLtkVvPyJjd2pYQ+8U=;
 b=jPWiFTQoGkUO+pz7o7tnCwA4XZPBAfKXVngCaMKzk6y9l0e5hG23nS1K34zYD9rz52pWMm
 5s08G5GO5Y4DeFT+vNjy4oH1Q5x0elMr2IkJYEmtomhPEfssAvmNG9X9qCMbZDHVBlUQ8S
 GaL66n0wz+YhLofRgC3TsvdX2tMePc8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-eN-kRp8WMWaEcG1maO5agg-1; Mon, 27 May 2024 03:40:19 -0400
X-MC-Unique: eN-kRp8WMWaEcG1maO5agg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3550360cc03so1449803f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 00:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716795618; x=1717400418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tzry4NJ2iAn6riKSPOqv17p7ZjLtkVvPyJjd2pYQ+8U=;
 b=uR8RjxqsaEL1H2z/uGX/WH/4nNAM9PyNmRtkGmDCQ9tFGta2vCIniSn8n3cdXZIlsG
 xk7q1NsBweYX7c3+g0fNi8WHPwPU4j0b8xTuF7nUC6rKpywGUEnFWYeN1hKH2gfJbT15
 oE1kRwOuSZYVWGi8BtsbLkqj2OZ4sztNRYzIpM0TaWyad4nBOxhxTstrilQEFIeZF9jX
 /TVM0LSkOXZi3/pOQYLsShxPS8n5yAV1Sv1Ff28WTpao4NWsLCk5mv4zeG+iSaIbciKB
 LewAlMdNekO/vheOxTdnB35Y1zaJ9Kfo48R+35/ivpbQf4hoo8xc4fykbmCk+JTewX1T
 VFfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdHd/jpcyI1XBU7xkliA+Luum8f+FhV1uaXB17d3U3F/fi8vSuKzijBIUIiYaApB+RLQTpSEArky36d+5x62fmFHhDjt0=
X-Gm-Message-State: AOJu0YxLxl8vYnPikWzTor+s4zThAL6+sooEAUwZU0EXVzDce2OT60M4
 +1syTRr61wDHNxdeCFGDILZfZG8zxQQz5Zg/+bPWH58R38bf+aw0pb1k5P2SU1sXwYaoGLsQ0QZ
 bDw0pcloz2Jlhzbf0LnFd46reG2wiBkr5lV1IYsQbnhqU/PSLoYysFrHkJ5lkTshHrvqeDy7J7I
 5pvyQ1rAJihjRzgCgWc+aEU9jjkuo=
X-Received: by 2002:a05:6000:104:b0:355:42e:bfa0 with SMTP id
 ffacd0b85a97d-3552f4fc4efmr5901198f8f.57.1716795618451; 
 Mon, 27 May 2024 00:40:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELYIZtrEEj11f+vjUiJOYURZDitgnPqVcbhHjYiPzeFcq+VhQD173MX2vRA2iF1htQ3Klx0V8suuHAxCnczKo=
X-Received: by 2002:a05:6000:104:b0:355:42e:bfa0 with SMTP id
 ffacd0b85a97d-3552f4fc4efmr5901176f8f.57.1716795618058; Mon, 27 May 2024
 00:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240525131241.378473-1-npiggin@gmail.com>
 <20240525131241.378473-3-npiggin@gmail.com>
 <CAE8KmOwYPf_1rX_An0K5gncDAC7V5jvR735tEAomVJiVxOeyTg@mail.gmail.com>
 <D1K8HPYOSEZN.9TWVXUFHPPO3@gmail.com>
In-Reply-To: <D1K8HPYOSEZN.9TWVXUFHPPO3@gmail.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 27 May 2024 13:10:01 +0530
Message-ID: <CAE8KmOyGNSsokPK=GaRQUHHYVHdXBx33c1qBPbuvJcRX7o=6uw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] tests/qtest/migration-test: enable on s390x
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 27 May 2024 at 12:34, Nicholas Piggin <npiggin@gmail.com> wrote:
> > * Above patch (not reviewed yet) adds comment about sporadic problems
> > on s390x, and this patch says s390x is stable now? It'll help to
> > mention in the commit log - what changed to make it stable in 1 day.
>
> Patch 1 of this series.

* Ah, that one got filtered to another folder. It'll help to add
something about the 'flic pending' case being specific to migration of
TCG device and so it's reasonable to remove 'has_kvm' check and enable
migration-test to run with TCG.

> Yes they should be called "enable for TCG" indeed.
>

Ack with commit message changes:
  Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


