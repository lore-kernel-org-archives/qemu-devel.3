Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F5BC369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 06:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u22l9-0003bV-VP; Tue, 08 Apr 2025 02:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u22l3-0003ZO-9I
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 02:48:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1u22l1-000616-Mw
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 02:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744094906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nXyLAkJt/2CJ23sKHK6RR7FTbNBcAxW/u2xnmibaOTQ=;
 b=OB1XAn95cAXdiS5IfkFJaz73F5fdRQuJnUyg/PDjSy3xgtMZNmdSHJMHtvjAdYEAZEPKvN
 PHV8S6gqu/ukg/6CkJf1yaDTfoJvF4PBTfWqpjodWBSkifbUzwiCKng+Gb9r2NTYWVVhJ3
 aV5Bx8l2IRjZjvJg70pU8vptysivXps=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-YYTi4LimOhGqkOGgNb_YgA-1; Tue, 08 Apr 2025 02:48:22 -0400
X-MC-Unique: YYTi4LimOhGqkOGgNb_YgA-1
X-Mimecast-MFC-AGG-ID: YYTi4LimOhGqkOGgNb_YgA_1744094902
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-86c428a6bd1so1868824241.2
 for <qemu-devel@nongnu.org>; Mon, 07 Apr 2025 23:48:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744094902; x=1744699702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nXyLAkJt/2CJ23sKHK6RR7FTbNBcAxW/u2xnmibaOTQ=;
 b=AkRsKw3rqOsgoCBn4gO3yNgVDB/F5pY3QkiLhfHHeuWjMyvbC14P88TYk18xBihVX5
 sL+O6cS0oJwJ1w8GtG0zRKhTMm4L6DQb35e+YhdqhqhgzzosPVIzrgzK3Ixn3l2LoBY3
 6Ugwu25EtQRvAO2CinrTIVz2cNwlHucQFy1Nd7c4go72rzxxxcLp0iTYUEN+4OxDuaIl
 5/X4FZk1y7X3YCsPOLmbV9skCkqzH8I1K7pIPLPuz+OHsFJEKu5jpl/zptP1BNPvUl04
 jSaghFydx+pt+4t7SznbYP8ZdYoS9UJM7irYhGw5yeBOVqw3L86lN5kJgsaUsZT9BPsw
 vXCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQzKa1UPbEG8cmR0MKK2pFwADJHyFoO0ZHLJzhMfTU0IhGc6ok8wv08HHysGEvucS6m7Um5kMgHhCR@nongnu.org
X-Gm-Message-State: AOJu0YxNU2GmvaUwtWTsQDDuhhLvi3b1BiHLnMbQNHK+O5TnT195Wy8K
 fQzW8zOJUIdvRrRQwHzCIfaXS5b7KORMKHoNcTD8RsDs2IF3zcdHC8RKITNyDhWS6ojEoVqKn+o
 nOXTEu5S5K9/Ih1b2iIV6i8awNmQkQlDDlibbAWaL7pj/r/qBWVA+/2ZibVAgklNT26CuWTeG6T
 Q7h0nXIcc/9T3WLqYbjNI/YT58fro=
X-Gm-Gg: ASbGncvlYjc8XaurJRNgHyIZ/fQzszpFBRHud3/YsI04If6tPjKNuXku1gcBfnpu4EQ
 doRoHQxGhr0LkdO5/A14m4SYkATO/GkfFoUzYG+thSUjWuB2PAmXp83fMQVhALrgQZNfwAlQd
X-Received: by 2002:a05:6102:dd0:b0:4bb:b809:36c0 with SMTP id
 ada2fe7eead31-4c85546b0b9mr12061610137.20.1744094902253; 
 Mon, 07 Apr 2025 23:48:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBU+53TTV2rA2jq32yfxvX/dSh0Pqe35kcsvP1eE6airicsq0Miec9eSjzgzcHtpVO2ZxfRh4oIUa8qGQ54uU=
X-Received: by 2002:a05:6102:dd0:b0:4bb:b809:36c0 with SMTP id
 ada2fe7eead31-4c85546b0b9mr12061604137.20.1744094901943; Mon, 07 Apr 2025
 23:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250408061327.2590372-1-lulu@redhat.com>
 <20250408061327.2590372-5-lulu@redhat.com>
In-Reply-To: <20250408061327.2590372-5-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Apr 2025 14:48:09 +0800
X-Gm-Features: ATxdqUElayrprzPu5b7ZoN7M98PI7Xg2SSrr_7RrFTzo3a-GkTxiCtL2r2YUlzI
Message-ID: <CACGkMEuFrODdop0TCFPLT9oDrAuNMtZ2S3Dpu=mQ+afJpO6a5A@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] virtio_net: Add third acceptable configuration for
 MAC setup.
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Apr 8, 2025 at 2:14=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> For VDPA devices, Allow configurations where both the hardware MAC addres=
s
> and QEMU command line MAC address are zero.
>

Let's explain why this can work.

Thanks


