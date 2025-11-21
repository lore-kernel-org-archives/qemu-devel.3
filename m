Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72FECFA76D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNz0-0004XZ-UT; Fri, 21 Nov 2025 05:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vMNyv-0004Wo-0E
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vMNyl-0007qf-5d
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763719362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWbf9BxMySjmKWS0gWktivL2wpZp7NPQlvDq4R6tsZ4=;
 b=IQir1f3ix/adCFKdnfhF4tQsA7m1OHHIU8/TAsh+wPQqHTz5hU58uB3ci1aZxcfVnpU9rQ
 T6dlZXUK+zuJ1maHmP83ipiT8ucxnbNSebkurgfe1L5ofaSJ6ICJ64+SGBFPeCweKuMOwF
 /JUXmPw0hB/8KBlzwRPE2SXRABwZLMs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-RVuKQasUNumBdE-45hfqfA-1; Fri, 21 Nov 2025 05:02:40 -0500
X-MC-Unique: RVuKQasUNumBdE-45hfqfA-1
X-Mimecast-MFC-AGG-ID: RVuKQasUNumBdE-45hfqfA_1763719359
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477a0ddd1d4so21879975e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 02:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763719359; x=1764324159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWbf9BxMySjmKWS0gWktivL2wpZp7NPQlvDq4R6tsZ4=;
 b=EIqNdC/vJFCtPu7ibtNtIplqdATQ6kPL6xtgd1UkG1aP78dGX+ysNGWXYcDZUUUe25
 iXhlbJQsI5ZrtIS4YLSoA8ieThs5sqlvlwzgWh8uA8eI139/fMEYz1Vsf9G9QuePfH+t
 s02JSrOBfGLqbuwk9bcUbUxRXKL+3DJOs6QqWimEQPRnC1y/UpEvxXYYZ5GcuC6MLFZ5
 1DbLbuDI5KGrD/1f5RW2MYRSoHoSZeOnc5neFwE2f1frwHjEYElkQ2A4SFQPdgEUeSer
 rHTDkrYlMQVWln0jPNIUjWrIldJRteY68nLpSSA5G0caEKOrDss79sD//AYLxbulfej9
 p+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763719359; x=1764324159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AWbf9BxMySjmKWS0gWktivL2wpZp7NPQlvDq4R6tsZ4=;
 b=OoF61MT1tRErH5idRRD6Fs9UQJoiTXTnPJcpvcbpA74btheH0c9rvBYJJVGK7SpiDN
 kaOu8dhWgJTIvhlTDcR0J4zdchACXfk+bRCOhSE3ULXa3Ip7rApsRuJA4uxMVJejrv3b
 hrd8eqYLAjgY7hqMormntTVraFQbGprBrdDWX8eT7/qrOHBBk7ICvyQx6hfRdMSFwbtP
 MhGxRAgNjX8JYCeUAoU/5PSH7kKNFZy90S2SL/0z53OchDQQIdeGbA/03rwkyypccqWG
 UTYt4OA1JB1ZBHsgRVVqep6LhmUFgcZmd2MXB2NWmWmK2cKD+bvR/uZtamjelzFzed4I
 dkpg==
X-Gm-Message-State: AOJu0Yy66ixUZ53AgDPYaQuqYxcoUp8vXvIUk4Mkh+yTSzUNpHG2ar7C
 mifMQjE4j+BdvOJVaHoNYVShIS6VpXOQRT3tLaEzm2eiJtKSOWppRWQt+7HUa5f/i/GSDx3KN21
 nFzy/i4yiTjd/tJK2TmhpBrODHwYgO10lmGPABRLDF4YKi9ngBCiK44YE
X-Gm-Gg: ASbGncs3sya2olPpy2xsyk7Ovt0OcAHjI5Hr9fFNIdEnCHD3Lmq5ySkN5An7/d0o6Zk
 G4+yrXfq9SXiQXlXatoNQLk/L5uRHxHGUkZHa7Hx0qjlX5wChXj1JmU6eBipO4Xr/Dzbo0tfDUy
 hUMcg7I2ioRAHlW1yeD1cx58veKRy/1qmi5UnJ1Uaz0rD7CEEqxusUii/CtgJsMjHsPrxOosvFP
 ioQeYpdP16keSK+/N2sXS3WjcXegPhbiclAnijYrY/IdgVwvJYfAVj+GgEg/hjJXGH26N9iNOWp
 x9ga69kqE2OXJ/m8NKlQ0B16uzGBZXEyJ00c9JiQpDo448r2X+mcdwNsgrfA7s8+RE+/AKMWhYv
 P5sgM+hYQeUqB+u7MEpyTrBo5EhJL7f0bR+8oFDdVk1FVJu0BXamVj4afkhAEeh6D5ET0MRO60E
 BrWq5s8Ysn9eKfgIY=
X-Received: by 2002:a05:600c:6296:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-477c10d7013mr16283445e9.11.1763719359393; 
 Fri, 21 Nov 2025 02:02:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXk43274RwMsJ/7Oqom2j5zOONjQYKaP058GIvdAhktRkxM2A42YCKBZVO9LPhuGvBDt/X8A==
X-Received: by 2002:a05:600c:6296:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-477c10d7013mr16283075e9.11.1763719358975; 
 Fri, 21 Nov 2025 02:02:38 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf355933sm36925915e9.2.2025.11.21.02.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 02:02:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-rust@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Josh Stone <jistone@redhat.com>
Subject: Re: [PATCH v2 0/4] trace: add Rust DTrace/SystemTap SDT support
Date: Fri, 21 Nov 2025 11:02:20 +0100
Message-ID: <20251121100219.654238-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119205200.173170-1-stefanha@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> v2:
> - Re-export probe::probe!() from the trace crate to avoid the explicit probe
>   crate dependency from hpet, pl011, etc. [Paolo]

Queued to rust-next, thanks.

Paolo


