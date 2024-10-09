Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E975CED62A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 08:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syS8B-0007TK-6S; Wed, 09 Oct 2024 04:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syS88-0007P9-9A
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1syS86-0000eG-CE
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 04:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728462789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vKWBpydi6OZCHyGeTeMfrvombmHdOWqRZkheNIWbPxM=;
 b=cRn/t5gQk66B7NEvjZYExUs5cfN4qCFHIG2456i2qiv2d4aKRToCaciRh/xnMbScpMAKcv
 Nye4TwVZsNjxG+Pu430ry4Vo5bB28J044uxLhxQuHejIJPRYx++4LURBO35egcRwt2p2Q1
 dvHdLDNCeLgkJLIGhLvE41b6Hve0FCI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-Z11z44LQNtGkOnRHFIGuyQ-1; Wed, 09 Oct 2024 04:33:05 -0400
X-MC-Unique: Z11z44LQNtGkOnRHFIGuyQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2e29df9d3abso636755a91.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 01:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728462784; x=1729067584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vKWBpydi6OZCHyGeTeMfrvombmHdOWqRZkheNIWbPxM=;
 b=tJN7ELjPFPLfflbkrfGwuY1LOeYiGpjAIKEQTH93rKnFOIg3dsv4cMeB9KmzLc5Ccf
 Z73ENB9kRNLE3ndCeC5elxFthTI5UqfZqc2L+K3rVBq5trmoM1/Rzr+hGXxXv/0CcDan
 YspNiEVBdqGtRmuBBjq6Ia8bStOILFm9Kfq2uxQJdyvDJHLcxDjIQ+x4hP8vvbAg4Sk4
 yRfS71XCMZDZwb/uyBM1JHwzSxXH3gWn4qd17WRQbncq/JUVQ4G3dkKaZnXs0tZ4A6ZS
 Y4mFN4N/49Ss+OPaWMB8Mhbqgvx8gNS7QZ2R3UEAtfPhD4ahZD+Pt67Q+izrNRVcuxsw
 bchQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX//SrnmA9XCX0dm+kRR8aXpjpKtGWguWr0PMXtuWnz0mowgT9mVt3OWDHzAlkQU33aM0C9SstY20PZ@nongnu.org
X-Gm-Message-State: AOJu0YwtQ4gzcL9CR+v9drxBzlAR0iEUXdr3zqYmUwixPLSyKBKkqab3
 zR/dYABsB6zlfuhrLVDJqOL0iohIlTs3C70OG6WbFxOvr63F7Fz0Ws17cc57LhvvrB5Fl+6zVnZ
 l0gFXyZTozuYtCKrSHgKXhELkBs3WUw2SoXbupA1ZLGi5Tnt0oKQSuQCJUU3HkGcw7agMSX6a2o
 xXKBrgXoOSVNqzQ4tGozGU3FiUUO4=
X-Received: by 2002:a17:90a:d816:b0:2e1:f0ee:7d with SMTP id
 98e67ed59e1d1-2e2a246d38dmr2185983a91.18.1728462784653; 
 Wed, 09 Oct 2024 01:33:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJsI1vZDgT4/bhSYNVx+++MTgp2K0VE1zQLHyoFXxIanEqlalaG6gNWD7KwCquE7QTrt5a8tJzvHeg0IVAE7Y=
X-Received: by 2002:a17:90a:d816:b0:2e1:f0ee:7d with SMTP id
 98e67ed59e1d1-2e2a246d38dmr2185966a91.18.1728462784229; Wed, 09 Oct 2024
 01:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240918225128.455043-1-dave@treblig.org>
In-Reply-To: <20240918225128.455043-1-dave@treblig.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 16:32:53 +0800
Message-ID: <CACGkMEsbxrXaOH1U6HPAd-PXmmUHCM79DDEdqO0Tm13pCfP2Pg@mail.gmail.com>
Subject: Re: [PATCH] hw/net/net_rx_pkt: Remove deadcode
To: dave@treblig.org
Cc: dmitry.fleytman@gmail.com, akihiko.odaki@daynix.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 19, 2024 at 6:51=E2=80=AFAM <dave@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
>
> net_rx_pkt_get_l3_hdr_offset and net_rx_pkt_get_iovec_len haven't
> been used since they were added.
>
> Remove them.
>
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---

Queued.

Thanks


