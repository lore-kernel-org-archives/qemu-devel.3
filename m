Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18357C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 04:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trUrL-0000xr-Jv; Mon, 10 Mar 2025 00:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trUrG-0000xO-Ml; Mon, 10 Mar 2025 00:35:19 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trUrF-0003Lu-5U; Mon, 10 Mar 2025 00:35:18 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22337bc9ac3so70270235ad.1; 
 Sun, 09 Mar 2025 21:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741581315; x=1742186115; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d81OVahzLMWMn+aS3cH7fkV/5C4vWVO3Jq0ayHjk3Zk=;
 b=azL6IL0KieMird0dOnnMa/ikXSXX2YWfoFYGlZC2o6LBr3i6P2YRhXIvWnffk8YSeX
 DhXBEAjSpB2liDIVmBi5Z7pKysalYUigvzr54lvsQGC4GGYNpQmef3fHvXd1Fz77kNVW
 LPKS+5POcn1hGqJxFDzhdBgRU94PHQ6WIg4bnrnHdyVcBAR4aMYb6zizHVhfub53rpFV
 ug1E+h6p2D98qe9Wp9r8y1AiZLvN2QVAi+CwK10Wv2CICSTf3WbtwCDXIyDNB3STeCVE
 zXiJChsccDpOiBh5a0w9rWLP0m/gyX56qFFFGjV5Iw0YAh7QSUG/q5rDET1UWSugXCwE
 tHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741581315; x=1742186115;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d81OVahzLMWMn+aS3cH7fkV/5C4vWVO3Jq0ayHjk3Zk=;
 b=wP3+JXVJoDUPu0CSeXFT2shVhYWIBUvII4T6F077PmZpWW3OixR54csDt/o2t2Ho1O
 OuX1G24YuDIVBfJyYT6Ns59yRZ89yMWDNKLR+XIcwssmQex/Xjx4XW4Gj+SKWkvcxZxC
 lurviL9+rSqptQqYHmhaujVkq1TWlvWgSafLLj5X5i3GQUU3NXZV3QUNk57f2ynIfTtY
 DLaHwv6qmvwyZUOJFl+YFbI/rSV9xgzdfQMoSWZwjDKbzt/QOCwLXs8Fpl/OXvnXBy8b
 +EmH2+SY0Eurm4bPYhHdjh2pjRL3voNcHzP75KK3HeMymB6Eoq8RteWKZFGmfPfy9sTU
 XC0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHbdNfTmCvWejjqnijoZr9IcpkHDgY86kyilaWzNDXPGgQ4jrRiSxLdoPrMnsdwHi9PkbXa0GeMh/h@nongnu.org
X-Gm-Message-State: AOJu0YxJhv8yLNWV4w4yI3t85rehcgTod/qUde1VrCB2ZB/GFICzorBV
 ebRv2oC5yq/Ta7Z0TyRdqeeTRUNIWpVKd0HtN7C4pwk62ghHEbQ7
X-Gm-Gg: ASbGncvEmQ64HkTWlCojmzJ/c7ZSZ00uEn2e2Kj8TgNMTnIePNesBOmLxbumoXOAWNO
 jCj960UAQgro3dNqX5Y3XqvDE1trhigVz7joWX7lg99dGJIppgO3srgLUw2nyMgAIiGvsHD/v58
 PGW7BSvfwADU1OsP04Xkuf+XoeN9Yda9K1REAVQmvSqWeR+Gnktun/JZbey3z48xYEfXzEbXoNC
 pzVGI6GibJWCkx/7ttGzhl6WtVyS89bhzsQno+iPF+aQPaylnAtkI51n9EkIEJuzOllq1yZkuVT
 wdN93AlnylY9GvzCbAbLOBvzyJ0fxtxWb568qbLJ
X-Google-Smtp-Source: AGHT+IFSJRix5RlTic91/lJowZHc/v2a556kw/Tyd28i8j3kpH3Oqi3XqPs7d6JX0qE4E/0oN7SiSQ==
X-Received: by 2002:a17:902:da90:b0:220:e156:63e0 with SMTP id
 d9443c01a7336-22428869a45mr181159495ad.8.1741581314844; 
 Sun, 09 Mar 2025 21:35:14 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a92765sm67487605ad.205.2025.03.09.21.35.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 21:35:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 14:35:08 +1000
Message-Id: <D8CB1RW7LECG.1XN6CFV2NOQ50@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <milesg@linux.ibm.com>,
 <danielhb413@gmail.com>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 07/14] ppc/xive2: Process group backlog when updating
 the CPPR
X-Mailer: aerc 0.19.0
References: <20241210000527.9541-1-kowal@linux.ibm.com>
 <20241210000527.9541-13-kowal@linux.ibm.com>
In-Reply-To: <20241210000527.9541-13-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

On Tue Dec 10, 2024 at 10:05 AM AEST, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
>
> When the hypervisor or OS pushes a new value to the CPPR, if the LSMFB
> value is lower than the new CPPR value, there could be a pending group
> interrupt in the backlog, so it needs to be scanned.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

