Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B425CCFA15
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 04:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stg6T-0006aN-9l; Thu, 26 Sep 2024 00:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1stg6Q-0006Ym-So; Thu, 26 Sep 2024 00:27:42 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1stg6O-0007vw-C3; Thu, 26 Sep 2024 00:27:41 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2d8741c85bdso124748a91.1; 
 Wed, 25 Sep 2024 21:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727324858; x=1727929658; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AFsjpfx57dRmZvVVnRLF7Kdkl7gbFcGJt0PS9Fbbz0s=;
 b=hpMsG85BUZLMcNb3KHzBr5GoOgHAwI1429qhmu8zh7uWlrCSB5nMDU4REGH/ROgvUw
 L8/wf+LFbf0+9tX3r+e8jHZNA9EeBvHfWGJsBJ6A6SeGuyka3gO7FWPgp4a/ypTpViTn
 wKzWnBRM/dXubeiLJihb+Hs7oxLwiUa2JxdyYR6RrifL/YuGZlny7Ie6dmMTR4oidDSa
 26VbWww4jyzCwMbfM2KnHBcfLKWd/eSFPbk7ATj5S++ggHQKTnpWAWa9uL4IKlIQvyGG
 f9qTOmOMjQ7pcFbZx5Pm05FOMsLWW0sWESd2wD2rW4qh5znwX44W0Cs9DoIs6J06FLvW
 JlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727324858; x=1727929658;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AFsjpfx57dRmZvVVnRLF7Kdkl7gbFcGJt0PS9Fbbz0s=;
 b=RfYgSglwovgT78zsSobXiIXBD2nzGkjerHYOWlGvZ8tpX6/nd7ZCnC8rYb5H4R3YiK
 xLBlzauyP2Wc1rqP6tIXKv9wcL+t/JnUWNacoPPikMPh+e6w6ST9n2yCMPhDo+iDTmT0
 +VGWfPca3TndfWk9faoCEGvwQxTMkXCwSJAyGjZlR6Y3aTAkEDHJtlEUpDBYVfFeEF9W
 NjwXXN4EmRVEqfF0SPn/PSBLJLO4YCSrDqtBgGJMr2nEjUnewKdBYrlKzMezRbE2yFOG
 71TafQKC7pkVadzAvBr266Fn8zuRh5u+wWms7iz4WXTd2LGyqwPjfNqjrFaoO32+9tGR
 s06g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeX5hN1kvVOndM1/s4RQtbjuZYoABt+5fKEk3kkO6zL8kZ2U+Tik8Gq8Omj86EdoaBXkLfjRfcfxWCRw==@nongnu.org,
 AJvYcCWoS8oSNS7ChDytsfOsddFTyT/CCuHTOevuzJ1cP50mzRnJ1uIkQcPQu4J4JBNkji4M1QpGP7xOoHRz@nongnu.org
X-Gm-Message-State: AOJu0YxONRObOeuZE7Tg/BBqpfjgokXOXhAZGLAbGFql3bVitUVVBBZC
 ruyPosOwapBNUUoCoOnOjd8A/OE5/vC9/xiV5FTnogX3YZIi3Jq0
X-Google-Smtp-Source: AGHT+IHz+MgWu5OktDW5pydZci5TaN5h0V9iUCBo19aI4QZjMOXo18wjBvvW/xpu1Wn0rF5s+X0mDw==
X-Received: by 2002:a17:903:18f:b0:206:aa07:b54 with SMTP id
 d9443c01a7336-20afc2d0472mr31421565ad.0.1727324857821; 
 Wed, 25 Sep 2024 21:27:37 -0700 (PDT)
Received: from minwoo-desktop ([116.121.76.56])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20afe071995sm16621495ad.118.2024.09.25.21.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 21:27:37 -0700 (PDT)
Date: Thu, 26 Sep 2024 13:27:31 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 Arun Kumar <arun.kka@samsung.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 minwoo.im@samsung.com
Subject: Re: [PATCH] hw/nvme: add knob for CTRATT.MEM
Message-ID: <ZvTis+cte1aak0Yr@minwoo-desktop>
References: <20240924-add-ctratt-mem-knob-v1-1-0674de9b88b4@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924-add-ctratt-mem-knob-v1-1-0674de9b88b4@samsung.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 24-09-24 08:35:40, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add a boolean prop (ctratt.mem) for setting CTRATT.MEM and default it to
> unset (false) to keep existing behavior of the device intact.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Reviewed-by: Minwoo Im <minwoo.im@samsung.com>

