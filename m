Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBA5C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 15:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Lyt-0008SS-6t; Mon, 14 Apr 2025 11:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1u4Lyr-0008S6-FS
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:44:17 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1u4Lyp-00014O-VD
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:44:17 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-af589091049so3092248a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744645454; x=1745250254; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MetnSWs0nq1ZKwVMm1SZwshOSb7iM6OHgwlS7spNFUA=;
 b=l+2jT7SZSZoR39i85EFGD0DCj4SS4UsgvZtoZco5vzI3Me/gy2tgSdNo1GnQD0AiCU
 UKNDvDO7Yq5QXAl2KpKkk0bEtWA0/4cLSkCWaXWpkOptNiRu69VvgtWc8+VlBDQxWiaj
 P78TIIL5hg0c3VWYEpqH8hvnf4imWb3rSuzqOS4lRIYdm3eeP2FaI+2oUTS6W+tnv0GS
 9wVrATFC/u8umqYeLWO73AS1tWd7Cnf81oO/NxDlojQFlHCH7BDvoR7Ojvyw9OLxUsoe
 rZpumCPc68BCKADwiPtR+CP0mGmOQqmunR8IJcSe0fTtfBbWIvtlG6qDbVqDB+/nQ+r+
 9JEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744645454; x=1745250254;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MetnSWs0nq1ZKwVMm1SZwshOSb7iM6OHgwlS7spNFUA=;
 b=fdDYzgEHgnhh2cmz+UKG3cSyduXz7zvF9vWMjRE7nX00vEsDmXyLcgT6JilhPaVpDx
 fcDp3xyUgXN6MlYFEW4uDisSPrragULcBMWYB8HmxHku6AAh2LatOgkmHQWx7KT8jnbv
 Gt6H5GfGSHnT7ZYoAhEDZ/T3u4gI+wJLQFoUt4lwmxayeX3uelNqlicheqOfSUKB7ZLT
 au32coL29Sp1nRzcMuhWDHHMdqILF2ABAAAEKFB8ULQuwnUThxxyRRnf9ZOZ5GbiiSw6
 xVe6EAiy+MbWKmV9Bm9RSDX0jdUftkBp78kgQH8CDcC3WIS4VZeZLp3Klq3LQgAdJDV3
 FFgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN3elHTnREmcRUbVeLrHFQTHhLVoHsL2g/2GQc8H6S2sUfCqQ/I+8POGZkkGWK2DErjJrez/QzhsZ+@nongnu.org
X-Gm-Message-State: AOJu0YzqsY/mA1feye1Tzaezfv+ifxyZYKHI0V6QgTkTvQHM9d9Vf6mM
 cJ1wcLRYQk//p7WzkJBAvKp3Y3ppLpDG7pc1mJHuv3Nbf7EpGCUs
X-Gm-Gg: ASbGncuf8yl8ixKX1lKfjFZ11zC3q81WJVbD4eTg8O8IpQ2hzrg9waFmb1zSP4J/E7i
 YtupO4ykkBAPuO56+6K7kJGozwVgGuYLA+SDetRfzI+9/UidBZWYIlPu0iFlNRkeESksKb9hfle
 J9CGSxN1ja52kSf5QprVJPnfSZIq49Sy4DlAWtaYAE5fLzCxFXvrOl3RiDsu7PZc6rfoyFJnFrB
 iTDtguRDWVbyPOi2xOOVm4xWFGNOal8861sa4SIuXXdw8PfCIPlujTSOoko5ayDBJT63hBrfLgF
 iX/QNdVIeQWxqzU/5NIszm1tpaqBWuPfMZWR
X-Google-Smtp-Source: AGHT+IEqcjxulOQzOxdwWrWqATGggSA8ehreXXU0YQ0R98Atb2/pn7p2pg1A4rxYW0oNMDj59tlPTg==
X-Received: by 2002:a17:90b:5242:b0:2fe:e9c6:689e with SMTP id
 98e67ed59e1d1-30823670094mr18264782a91.8.1744645453550; 
 Mon, 14 Apr 2025 08:44:13 -0700 (PDT)
Received: from debian ([2607:fb90:8e61:8954:1427:df6e:93c8:2b14])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df08f71dsm11219783a91.23.2025.04.14.08.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 08:44:12 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 14 Apr 2025 08:44:07 -0700
To: Gregory Price <gourry@gourry.net>
Cc: nifan.cxl@gmail.com, jonathan.cameron@huawei.com, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com, anisa.su887@gmail.com
Subject: Re: [RFC 0/3] Qemu FM emulation
Message-ID: <Z_0tRwHNXD8idZl-@debian>
References: <20250408043051.430340-1-nifan.cxl@gmail.com>
 <Z_U69HlC_aKLghwL@gourry-fedora-PF4VCD3F>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_U69HlC_aKLghwL@gourry-fedora-PF4VCD3F>
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pg1-x533.google.com
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

On Tue, Apr 08, 2025 at 11:04:20AM -0400, Gregory Price wrote:
> On Mon, Apr 07, 2025 at 09:20:27PM -0700, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > The RFC provides a way for FM emulation in Qemu. The goal is to provide
> > a context where we can have more FM emulation discussions and share solutions
> > for a reasonable FM implementation in Qemu.
> >
> ... snip ...
> 
> Took a browse of the series, and I like this method.  It seems simple
> and straight-forward, avoids any complex networking between the vms and
> gives us what we want.
> 
> I'll wait for Jonathan's commentary, but solid prototype (bn_n)b
> 
> ~Gregory

Hi Jonathan,

Any feedback for this RFC?

Fan

