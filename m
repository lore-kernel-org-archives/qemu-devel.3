Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0F6EE2084
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 11:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voJqu-0005iM-RM; Fri, 06 Feb 2026 06:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1voJqm-0005hi-6A
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:18:13 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1voJqk-0006uX-Mx
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:18:11 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4362507f0bcso1063278f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 03:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770376689; x=1770981489; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7symSCIaYKRHUbfI2KAHHL+E9YGUeRoXljItLbDPTOA=;
 b=lgzEVTL06ZxdI/v+NrMxqB5BDRK8pYb9WVtrCxTNTESzCMjarcjfhgrC6acvKQoyGZ
 oljhtelTQKLUJatTP1hsUXxo9e/BCaofUDd3LwoVoIdwBcOZf7iwc8P4gI60g63JC3dX
 tPV4BoFj+MMuHejh/I154lnkH00PvA+kDTX/IhkYctX7ftDPdb44UHFTZ7UYSQhLe82b
 uWqKow0T5qFfOooAu+sXVdfMITjkifoi0eL+kvSFY29zu8D1e6hA8juF/KRqQtEDgTWn
 XuRlmN0jDjb8KMqOzDnJoQPRgKXyegiOjoGyh9kfaMvk1+gs6abGhzqEIvgHaDH20+IZ
 UzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770376689; x=1770981489;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7symSCIaYKRHUbfI2KAHHL+E9YGUeRoXljItLbDPTOA=;
 b=t4dBoJcWpihRHDsvyEr/WvIrqhdrlvtyxVEa0NZZ2dJt10CGntfXOMyPfNiCAZn6m6
 6VrP9CAUDqZsL436MzNm1Z5J25k7b0qkNiXF0uD3/4TJsqdd0GnUuoJgfII+A7tfpQJD
 fJnoX+GWxRX5UmEVMFfzVDyBJJXw1D6dmS3nMSO2VVVGFWnYeSa177u5sW8tRIB9pG5Q
 /KbWsn4igUcKogCEkm5tt8WtjYCBqh03H29C6rAF1q9IlNpy6ZYsVBQF1Q6ZE9NY+Tl0
 GL+MT6LFNRVjA6Gp7k9kXuUHsHIUzwlGS08EdVhd++W93i/eBgL7kjZ+epDHjaDEojt4
 IX0A==
X-Gm-Message-State: AOJu0YzH56AjiKb2jyDKxBK5BG5fCZeSg9I6I25Xs8wAFm2ZyJujmbCc
 biHxNpTz08x++qrQ/RAl7qgcyRmA27B3iaQTiuMBPBQ/99ZDbMWwpfTX
X-Gm-Gg: AZuq6aLdpVu6CFNSIY8i3MsXphMFoDPzpCBcCD4foIVTJ9SJp7U1qpvjh85/saIAyvo
 Mry3L0plx75oBR+sm5GiUh0DNb8bniT5QBSF09m1BkB++KFHZPzMSSl8Ai/TbLwBmBYIEm+Vk5T
 l3INRTnE4u6yCPFtpS97ZFC1obBFc5zBsr23S2abBFeJK2ZP4//EyLfcxSgG/VlA0NuGLngv4Jb
 vyIfywIc3DFBLZgFoPWLhPcxiZqvVsmcznN94LsZYU5lPT9dOrKjcxLEDG09JpkJrsL5CxAPbS4
 c0KNoinwvXsnhBSRqOPWV6k/aWFaxt4RNjtQJgSkQ9VuOg0JO9sGdMT/WKYJaml3+l4sMJ3YTwj
 O/+V/wpPqCCNkjLve7FYJ256m/eeJ5t2SShM28hcgQie1OgZS519GUmD88hDEkprQXVacujDQuA
 heE/87bbymG4G5RR4lpu4bLgaVprjALFScgMREqKWwzAp6k24NPpVOGUUzdJORByYu
X-Received: by 2002:a5d:5f55:0:b0:435:bcbd:cb29 with SMTP id
 ffacd0b85a97d-43620987844mr10045190f8f.2.1770376688743; 
 Fri, 06 Feb 2026 03:18:08 -0800 (PST)
Received: from localhost
 (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296b25casm5264844f8f.4.2026.02.06.03.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 03:18:07 -0800 (PST)
Date: Fri, 6 Feb 2026 11:18:07 +0000
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org
Subject: Re: [PATCH 5/6] docs/system/or1k: Rename from openrisc
Message-ID: <aYXN7wAz6nXol7RC@antec>
References: <20260205030244.266447-1-richard.henderson@linaro.org>
 <20260205030244.266447-6-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205030244.266447-6-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=shorne@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hello,

On Thu, Feb 05, 2026 at 01:02:43PM +1000, Richard Henderson wrote:
> Also rename docs/system/target-or1k.rst from target-openrisc.rst,
> and update all toctree entries to match.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

This looks OK to me.

Acked-by: Stafford Horne <shorne@gmail.com>

