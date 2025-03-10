Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED68C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 05:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVYi-000245-GN; Mon, 10 Mar 2025 01:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trVYC-0001Q4-Eg; Mon, 10 Mar 2025 01:19:40 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trVY6-00041e-I7; Mon, 10 Mar 2025 01:19:38 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22548a28d0cso36300575ad.3; 
 Sun, 09 Mar 2025 22:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741583971; x=1742188771; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAprJb8UP2za43jr3RvXjtgVjRlegJVoUpaptfFY28E=;
 b=eY2EfdoXh+41c+bRlUo5dyIfp+elRiIrazjRJLqWosKDKQqK4TdVWbB46kBAMMmy/h
 Scwge5XEp9GKGwxVOePDIK//kSMY6gHBnbOXhXQkHFUimL0NFByBrmERF7BuEzcwYCfx
 Zd3jYb2QK0vPjoRV0vTBLghNQgeI3Lt+jLvWIVlcRZyXJyDOnwpPuDJ4BuoOi/Mw7sG2
 kU49VSCsswjo6P/C/YbjWHS10QSCcYgm9z6TDA2anPaBEfYOqGN2J3lKjTATzrlav6Cy
 JLkPTHZtXToNWkJ1xsCzBMUvjRiWoenoLIBAuy+aI5tm151YRrG4rjdR8UkY5St/p7Mc
 DBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741583971; x=1742188771;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CAprJb8UP2za43jr3RvXjtgVjRlegJVoUpaptfFY28E=;
 b=MkG39rZ7msVa1ZDsJUBqaIwjNXV4NiXsg69WDMAC/V1x5+IYM3UjT27g7K/gx0LTtO
 kNA6tyVFSGbQrOhgzxeDZRQnUPXRUj8MCnD3HIWIJmA5LRHeBgAIWPi8gRPr5U7K+OrZ
 UPEUp6cAVZH6KJqkftD31E0QtSseYgHqIe7B05opaAyThxERxJf5w5azxBWUYXHawyp0
 HXaO7bMtBAJVgEC09pGYbXdF+X0b8bP1LfYm78zmQxl66+GhiPdKvhJhV7u8PL+c7We3
 feKmer6V67mJuT7pRJXHkv1NAB2dOnfQ8xwUcaQtrQeQv5LpXlatXuX3VbjPgtjW+iSH
 dUsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcUSMJNhj7MXEGlpLr0Sqa9b8FVAhbSROU9Ag2LqvFFlm9mXfrxY4RxpJveg+EBUITr/4jktsatDi5@nongnu.org
X-Gm-Message-State: AOJu0Yzd7K67smw1/KlAhjDyF83BIc1QR1JVF22nOI20I0AuWABGV8Te
 Zw2ta+ImrRPiq9CIRomiaxrr+PodUAIKp6Y8Ird6q9WBwIthvprV
X-Gm-Gg: ASbGncv63xN5ZftLyelFsW1Lpjct05oRyHJAFjKA5j+8kXBIaDh7562gJ2FU7XaP550
 yw583w9F45rIwBLf3+pQqDhmO1laQ6q2+9I8OMKsbpJ6R317P/8aAvfXbI59Uc5bZ3g45C7r96d
 S+SBtQejnJOhmGuZ2UwYXykM4rb6np6+Ef7blK359Szzp4XzvNQDMWASpr8g6eJfEKbPdlegdw/
 36lLPGPO3jdYT26CvTcIXtyLCuRA7fz8Yv22kO6wcAZuykYOQQyzl7Z25/P6BmvleCwQXn4iXHs
 Zi9ecU29JI6Dt3EMUqExgdIzZw0V4rn+29lcyO/S
X-Google-Smtp-Source: AGHT+IHC8CZfIAnyv1kwBS3GKxa3KvTke5y9sEpttqbBpGWa3dodLZpb3WCfNXKDXDtqkmwhC6JOkA==
X-Received: by 2002:a05:6a00:139a:b0:736:520a:58f9 with SMTP id
 d2e1a72fcca58-736aaadf082mr16398722b3a.17.1741583970696; 
 Sun, 09 Mar 2025 22:19:30 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bdd78cbfsm3809489b3a.33.2025.03.09.22.19.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 22:19:30 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 15:19:24 +1000
Message-Id: <D8CBZO42SQ6J.1JDDSFNBPRZO7@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <milesg@linux.ibm.com>,
 <danielhb413@gmail.com>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 13/14] pnv/xive: Fix problem with treating NVGC as a NVP
X-Mailer: aerc 0.19.0
References: <20241210000527.9541-1-kowal@linux.ibm.com>
 <20241210000527.9541-24-kowal@linux.ibm.com>
In-Reply-To: <20241210000527.9541-24-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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
> From: Glenn Miles <milesg@linux.ibm.com>
>
> When booting with PHYP, the blk/index for a NVGC was being
> mistakenly treated as the blk/index for a NVP.  Renamed
> nvp_blk/nvp_idx throughout the code to nvx_blk/nvx_idx to prevent
> confusion in the future and now we delay loading the NVP until
> the point where we know that the block and index actually point to
> a NVP.
>
> Suggested-by: Michael Kowal <kowal@us.ibm.com>
> Fixes: ("ppc/xive2: Support crowd-matching when looking for target")
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---

I think this one should be folded into previous patches.

Thanks,
Nick

