Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6901BC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 06:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trt4D-0007zD-SJ; Tue, 11 Mar 2025 02:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trt3u-0007xY-0K; Tue, 11 Mar 2025 02:25:58 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trt3r-0005qG-Ch; Tue, 11 Mar 2025 02:25:56 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fea47bcb51so10700249a91.2; 
 Mon, 10 Mar 2025 23:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741674352; x=1742279152; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87hG8nmi3KRaoBsjCWOa9fw6YTo7Zjpt/uJbgwf8Evc=;
 b=Da5BRJZdc0wulmT8s9DJge4l3rgB/fsJUZchV5h06gU8UA/o3Zl/OXERhmuXQAAN6M
 Ik49VTQ0KcYPqpmjLk4Axt84CDaA6iGhp9U/QAU9ATpnr06oSHxDqPkoySuVzx7RH0mb
 LHk7iZ2Hkjxkvmw59Ppbi4lrDtSjiOFSFDLPYUd3M9DZMqmxuNjeTfHMp8XZ1jPeKPCO
 njUCkvAfvTq/JNIqgmlSUrKCThGjFcVnKWhBJwVW4qNxin4bLaq0YRcom9dlW7Aq0epK
 Sk4PhacTbjmK6zbFzV9BT0EU9JV0PSvstKkUwJEy5m390MPWbmdUVHDs+y0XKzQojNl8
 IygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741674352; x=1742279152;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=87hG8nmi3KRaoBsjCWOa9fw6YTo7Zjpt/uJbgwf8Evc=;
 b=ajrIxJcLM573LLejVKgTUrK6za+gR++e5IEvCnnWsnoMGF7QAMI7PLetraCffPS0aS
 vBTE4hlEt120Oap1Rai2+wXrnsbyic/qHhNqVVhFpfmM5rst2VylH6an/DrkEvBbhz5U
 ITK9COz2nH6lNfRd2Yq9Oo0gLcyV0y22Jycfj87vYtV7RZ1qW9o7DtaNpKZL5iHBYD8v
 n0TxIDTsXdl8ysxugkd7kFdJql7/so5s4VVj/UnP1NXHhRKS5AngzREjPEKspZX31B9O
 SgBsp1ROIbLSEhv5Q09hiGrLGWe8sy0RwFrq44NuSMmp3MdB2s5WYzW06mh9Q6R3Oo5P
 cVKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDJdUO/nWZfV0bWer2Mj2PHjmeYVVRPpI2G8NFDrhLz0jYcrWFXKm4j1ad/XN0Dg5MOhbZhltS+a5F@nongnu.org
X-Gm-Message-State: AOJu0Yy0fjOj79uDHYqJfb+o24UFQHqRjKv2HoNuW8hKhGhrQqUllxZ5
 wDaHjuKspRZl2Y/bhjvCdLQH/etqJQ4TsatDhOodfa36lvujKpxzmQP4BA==
X-Gm-Gg: ASbGncsmxhSCZ/Y+ugrn+Zpc7N0T+32XfSta1MQmMHQ+ffxvYqJFa1SkLJOJZt6jgS0
 9SXZSBXupfWl9u/nZHY/turL+1tmXwuuimpZkwsV8vVnzOr7eGbB6af6R7+UqyVHtLOdGXPqN8Q
 1pnGzQ8Xg7LBXSXYZtok3MaLVnAcp2llO8i2LKbF/kex2WklrInRKIKFDtPRYAKRaqNyHLPyPk/
 QjhNZy3nnYU2ilxbbO+/MZKj4sQC+nuC/OdbkL/AS93CFUCdsMm34flsSGbXgkRgBar2Vb5X1ae
 Fj9jpS/i/TO+K79IGiBZVKsGriVftGriXhuD1aR1
X-Google-Smtp-Source: AGHT+IGuaygBAE16gjBvdFx9nvOm4Uzj54YnDYuGeHD/zi2xYWMTLe5LaXlO+GKpdP1EzTET6sJHTA==
X-Received: by 2002:a17:90b:2d83:b0:2ff:64a0:4a58 with SMTP id
 98e67ed59e1d1-2ff7cf14552mr21554466a91.22.1741674352072; 
 Mon, 10 Mar 2025 23:25:52 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773c87sm11037301a91.16.2025.03.10.23.25.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 23:25:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Mar 2025 16:25:47 +1000
Message-Id: <D8D811O0ND04.384NMIGZQ6BUH@gmail.com>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 0/3] ppc: Remove ref405ep
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250204080649.836155-1-clg@redhat.com>
In-Reply-To: <20250204080649.836155-1-clg@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
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

On Tue Feb 4, 2025 at 6:06 PM AEST, C=C3=A9dric Le Goater wrote:
> Hello,
>
> The PPC 405 CPU and ref405ep machine was deprecated in QEMU 9.1
> because there are no known users, firmware images are not available,
> OpenWRT dropped support in 2019, U-Boot in 2017, and Linux in 2024.
>
> Continue the phase-out process and remove tests, plus boards. The 405
> CPU implementation is kept for a while because it is possible to model
> the power management (OCC) co-processor found on the IBM POWER [8-11]
> processors.

For the series,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

