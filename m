Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1044AEF371F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzWQl-0003cE-8W; Mon, 09 Mar 2026 04:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vzWQj-0003TG-AI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vzWQi-0001Vb-1F
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773046655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=plzCXztyD2DphVpDKQO/AacB0e3jwelNz+PqdEAvSgM=;
 b=XjBshz57gLYi9qtn3NlMD/Hbr4ivOhG+NxbVGJQ0+TUwtwnoOjB3EXkITTFuwWCIC3wTE/
 jgckgxHrX8agpFIUAPV3fWAlknFiQyaG1exIevnK1hK/h4ZoheSn9jpWe1WrbBF1t7AU3r
 WS6GmROvSOJsGboU4oB7V9dpG/b0Uok=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-u82e3pXFO7KY5ux2HsEtaQ-1; Mon, 09 Mar 2026 04:57:33 -0400
X-MC-Unique: u82e3pXFO7KY5ux2HsEtaQ-1
X-Mimecast-MFC-AGG-ID: u82e3pXFO7KY5ux2HsEtaQ_1773046653
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-829ad972df6so872887b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 01:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773046653; cv=none;
 d=google.com; s=arc-20240605;
 b=WS/kXxl2xozP+eH5eJqYaQzQfepmgjulaMHNSDx+I3YMZUnRBmF1O0sdCSPYLrC9me
 EyG4B3UNoYm8+bP4SKKqAQIZHipOIaAsUaEWUJnTeHCLQRCIEV9iyDgmWqm9ouAoHj3x
 NSSAlsbtk/KQ2hNt3QRrOMLfOfdt1B5bMeL+G3tjuCmJlwfgur/VnY9dVZ31BPC3sr6/
 lcMKKAA+fZA2l2/spo7hkArkX9KOh3hU06snQBNqPGfyi530Ds1AqpGWdWidE2Z9laDy
 TmgogusDzLqRE/jnrD6ScNuhDhtofpfFkL4eWguNXO2lMGkYluJIwZ2dkiPdyV+DXDAL
 dmUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=plzCXztyD2DphVpDKQO/AacB0e3jwelNz+PqdEAvSgM=;
 fh=9rCAgRZzFqNjR/wNTxyQXAt8YRB1AGR74dADh0tp4w0=;
 b=gGWxW4wnZdmtLfUlAv+1psffSR0mDZnccXzFBXwNhdjo/+Su9D6iTMK/1MJ8PIY4JM
 FpDnNeMW6rqEG5SFBIBalPZ9nsT7P1YiasD+9VNZXLSMCnDYAp+03Nk+Kbu+/OJg53T3
 qwpo0SouVTcw1BgVw5dcskM71noSe9vkGg30R6Yi76X0JJZpj1WMDT0UmCH42ZEk9FaG
 fw4A8TYth7rli0ZuPpUQTUL25uiSOJFhWCemT45T6z7K4dpE22UUEofbZfYVlmVrHbaF
 uuLQryjd28WITV9sgknNobSMAanmZxZ2mSKuLRqDvP94PYyTs9cp3pJU6fIVDcFCyMBl
 t+CA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773046653; x=1773651453; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plzCXztyD2DphVpDKQO/AacB0e3jwelNz+PqdEAvSgM=;
 b=f6h/KqA55c3L3jfAgTVHv+Ii8D8NCyHik3u3ohnCJvZDNlmmKesyWN14JFf+oUgb3W
 4n+di2hDEmzPh+eb0YJIAXlqcAIMk9W1/415/Z+BKyUNkhsO8HMOmbY3sg+hqujhqnYg
 3KpT+W3YTLObAbtfrctvkSw/AbJpAN+rWMRpYjfeR0HZZ4JaX1zwrYEpTNyxZeDIrWJi
 4pjlN9FYQIU/eNeBpBdgCub2u/MEODAkYcE5khWJ/8lD1J4PSrT7JQh2PaDK97RIKmA8
 PXjjlLw/+digYcgymyEd5fWHZZLQYq0LSQy6ZBxZb5RLQnrbltRtA36WzWVerBBEnn4g
 +Qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773046653; x=1773651453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=plzCXztyD2DphVpDKQO/AacB0e3jwelNz+PqdEAvSgM=;
 b=IeybPGhSEuPmcwFyuKARFpVYwf7YPGwJMZorEy0Q6reSksc/bfYWrl7If2DmPMKF5o
 hXbDuLKI4Et9e1rOcUO054lVzjUCyaKA6hbVeAbfzSOlfNQFAnNZMy/v9irwkOcIu8m1
 0yT0zzZ6frTtkXpTEaTtUXUHIFXgtI3olM6B2uTHfw8+YUWT19JMvGBLU8K2SO6P/sAa
 848jb3PsZXIgbCOeRsaAI/phTCnk+3sQDLnm6sh4rkTRZGtJYJ7DmXCgaMC6PcFNnSNY
 so7rD5quG44Aci8EZ8kXUkb5ZMf3moKKVbQVYPnn4D1AQWSEbk8diVHMCxD2tR7E1IOa
 dAIg==
X-Gm-Message-State: AOJu0YzVFSINqr8HEAxmZ7AQB0FWAVsPo9ljUkNnG6kecC0cH31ci+r8
 zL+jf+lIZUqAjKOAH8+iti5H++70zEg+UEDAX/ZZNemLK4ZMedR9BcwZJsK4dbbesXHFzKOw7bs
 5gk0j1yDHJz9zT1rAkTPthALXisIYKuo17BQa36xc7uTIGLmZXCM9woGu67LkldRubmyjFusIZT
 eRjFzcfQkY1aUVeKruvoS9Rhe15VY6Z3Y=
X-Gm-Gg: ATEYQzwZHHUK+S3csAV9JzQ21VWM0f5Bl7ggYxDmIR8Bp3C9O4dtonk1KT8tD45qzuM
 5JVKyacGJftpcvLZHnmUxL2LboS3Wj9qoNQT6YpzUIC3j7RKGVnTxnL5wU9yIj6jX41NIxwphFR
 ckwAGwIbfvVx8hiuBQ0WB75mFGIpaLBnfrefh+DbqK5Zhu8SPD9XSVvuU4JMcXPhePF9g5dQ9dJ
 zLvdXqR
X-Received: by 2002:a05:6a00:3e14:b0:829:862d:6b4b with SMTP id
 d2e1a72fcca58-829a2dfbe5dmr8840897b3a.26.1773046652847; 
 Mon, 09 Mar 2026 01:57:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e14:b0:829:862d:6b4b with SMTP id
 d2e1a72fcca58-829a2dfbe5dmr8840878b3a.26.1773046652470; Mon, 09 Mar 2026
 01:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260304173535.2702587-1-eperezma@redhat.com>
 <20260304173535.2702587-8-eperezma@redhat.com>
In-Reply-To: <20260304173535.2702587-8-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Mar 2026 16:57:18 +0800
X-Gm-Features: AaiRm53or6Z_v8aotOZvUUAMICNKDBTnChmwycp0zruXyuSBEx-ROsZnWa4sP_s
Message-ID: <CACGkMEsXQVabrdNGAiSUR6E1mQpXGfoH+kcZPDxVrjcFrdXDsA@mail.gmail.com>
Subject: Re: [PATCH 7/7] vhost: accept in order feature flag
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Dragos Tatulea DE <dtatulea@nvidia.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 5, 2026 at 1:36=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> Let's accept the feature flag with all the infrastructure to process it
> in place.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


