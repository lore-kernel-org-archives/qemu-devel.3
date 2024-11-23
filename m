Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1314FD75E5C
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 17:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEtWV-0001OX-JY; Sat, 23 Nov 2024 12:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>)
 id 1tEtWH-0001Gh-EH; Sat, 23 Nov 2024 12:02:05 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>)
 id 1tEtWF-0002RR-MX; Sat, 23 Nov 2024 12:02:04 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa4cb5fcc06so541798366b.0; 
 Sat, 23 Nov 2024 09:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732381320; x=1732986120; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oLUxKFQtxNNYQPfV6cTLZKIXxitdR+Itz92sWRA5Y14=;
 b=OzbKbRxuIhCKXTkDlJyQ2EqWCwGuhpJ2cUgs49WHp0noGEP7ld5PVPde2//qUUp/Gz
 Z4JAbNRc+/VrRQWOQSqVNj/0k5G/8TB7oshTizBG6gWAk4lelDm+PhL+KYVVxbwt8yex
 sx2/LtqFjB9Gl/3PCCoRkc0QN08Blak1YQs2vxZmVyae6vdU0dlRgD3cDj6KElb/hs48
 eKe3ewAgetd42xW+8Owgbj+HGndDCKfWCCuyQuOwMuLUJWZ9KLhp5DIds1oq7sgGIIDv
 +YcFwTwqVfibMET+hEInVdiRUc6Ksn3AR+THvyXc0u1UpcEfGnEx2DyRdtZ9KSbWJNNc
 H02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732381320; x=1732986120;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oLUxKFQtxNNYQPfV6cTLZKIXxitdR+Itz92sWRA5Y14=;
 b=NTtfRlchsmw2MwIFaobSt7V6n6qodOVE48/p/7iN9VZ77D69+fx3DUWS+7grg9XG2F
 Mwwb6zbstf1sx5WxK1iNx+Md7XQY2UnTALv1yUad+Pw+6KwedbT2Z2Su+o1Rd+YHiW0s
 907Jti2o9E9nt2UdoZmsTSLlLNn0lSB7t4qiFfV4XudIUtETbLhGCniBzZqBmOXypnAo
 odES1bPuIGUDGFga8C3xYwmFccMDsLsgHlIpXPz6pJ2/gjuyNuMBIQw82BtvUXHtAniO
 GFjEiDrOsTESHm4yNO83nFbZswZZXBIqWfqNDRW5MKavmKYaIxiZQYEKUAR7qPsitVar
 cFew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrQyMIv+fgLeOb7A0BacoHTcNHc0abaeZo9nDKIg93UEk3gLNGjFQxNX+VCjFCPLarFLOfvs0ckKrcsg==@nongnu.org
X-Gm-Message-State: AOJu0YyQdAlSSB7mVgR4GD59wB0fY20jFNF0dblSH63Ao+Piaz3FfQOF
 we3APfdm7ReMiNrUxNNYUhQOh8LTTA61wR6a0N4q8xy01lS4dBWMtKCckQ==
X-Gm-Gg: ASbGncuCJAv12zNedaynmqs4c3Tkwp9iGwmOugQRrFksQO/EWvFJ9hZmXdsL8Xu7wys
 Znoh/0K3PFrH1pNpc0oRDusYjUz3PIlkKTrXW5IR+242yQ+xdmdKBn4nO4bQLC1sxDn/ZKpV7lb
 Dkv7q7picBPyD5FBf4zRu0n15ACSTtGxFIewbvN80J/augzVeLAPLSYuRkGPATCtD6DfLeC2hC3
 jEEOQKFrzb46MUJo73dRSMztAsg74K6BXuOtmAnBIBLyisVe7y3pD0IJvoUM9Zpo6dRdVtszpZ1
 xPh/Khae/tA0Kw==
X-Google-Smtp-Source: AGHT+IFSiHAFlXgwOZV2UxsXB9B6Y0+dm/OuA8uI6kcIaz441BI5WZAZD9+Bf6igIndPwQ0dqkv/LQ==
X-Received: by 2002:a17:906:1baa:b0:aa5:308c:3489 with SMTP id
 a640c23a62f3a-aa5308c351cmr273474666b.58.1732381319957; 
 Sat, 23 Nov 2024 09:01:59 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedfb2sm5661709f8f.105.2024.11.23.09.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Nov 2024 09:01:59 -0800 (PST)
Date: Sat, 23 Nov 2024 17:01:58 +0000
From: Stafford Horne <shorne@gmail.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Development <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH 0/2] Misc OpenRISC fixes for 9.2.0
Message-ID: <Z0IKhkyU8YdI5vyP@antec>
References: <20241123103828.3157128-1-shorne@gmail.com>
 <618427e1-ef6d-439f-be0a-6d573b28f1c4@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <618427e1-ef6d-439f-be0a-6d573b28f1c4@tls.msk.ru>
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shorne@gmail.com; helo=mail-ej1-x630.google.com
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

On Sat, Nov 23, 2024 at 03:12:12PM +0300, Michael Tokarev wrote:
> On 23.11.2024 13:38, Stafford Horne wrote:
> > This series has 2 fixes for OpenRISC that came in over that past few months.
> > 
> > Ahmad Fatoum (1):
> >    hw/openrisc/openrisc_sim: keep serial@90000000 as default
> > 
> > Joel Holdsworth (1):
> >    hw/openrisc: Fixed undercounting of TTCR in continuous mode
> 
> Is there anything in there which is worth picking up for stable?
> The first one above seems to be a good candidate.

Yes, I think so, would you like me to tag it with anything?  It does have a
Fixes.

-Stafford

