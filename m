Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D1CD41149
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 09:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgJZ3-0005HO-KA; Thu, 15 Jan 2026 04:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vgJYr-00051H-UQ
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 04:22:40 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vgJYn-0007Jm-7m
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 04:22:35 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81f4e136481so327815b3a.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 01:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1768468950; x=1769073750; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JsH5PHR+ifaG4u5ZGgSD8jUdqMq1VxI8NZxgIqsnoc0=;
 b=mDYHnsVDV/9Ezy6TVNnBREZoRgxDjszfzsCpcMZ2gh8UVRGc1yrbxICrb1jzF9TilL
 dPUbT5R0ZxjROlC9p1MsjeGctqIRnGMGd3Ca4rIZSKhuE5oFQt3hbmv7rI9VoRG5DxHk
 Q6wGVPWdVLKWbcbHAk3gVnCiXqRB7T2kJ/+1QU7RtN5KUg+nhxJBlzoHxh6QzVdNRjWu
 RLhUmrJ/YMc0XdbYrTTvXI+gMvZtDy/1gW974pNGPQAO24+BzdBR0G5iDkAfHBIHNvHR
 bmkQ5r0sm8Q/FaWN8BaD2Q9IKblI/x+uuSg7JpM1t7ZYhCAsxxNPO+PcZ/GVGUfVPZVz
 Ys+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768468950; x=1769073750;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JsH5PHR+ifaG4u5ZGgSD8jUdqMq1VxI8NZxgIqsnoc0=;
 b=HsSnTwhcghHllxeqEaZC94LT0gIrm3TFheCmQ4Pq4GEPWLoaGEXQ++oR3aA00tJYvu
 aj7AIckwmoYBw52u1hkeg5BU+bspRTbFem5bBJRSzbcrz1j7qYiwI7QW4m0wq8Hb3hHs
 S3aY6UAfQiVun7dV5sdWSyTHV5st1Q5pYhIBmNbuGxx6IMaDOeTuuWeeJ+OzNgc/KOUL
 opz345FCHUCFeH0NXY447nxL0Lbnu4N2z7uBqa58Jwb4r0GUXUtYO7yUqHBkaY0fnWFr
 azAIRx/oiertzCwOaWaTWlJBCaSAcE1PzA/uMxoicEUh2Dj/kaHQQhW+wmcpzN10R0Og
 Cf2A==
X-Gm-Message-State: AOJu0YwgaG1CDbOfKinCU29cfbdTuEdVhk73eqqBacM+fIto8VR9SZPc
 fd4qWOaMkTwt90puUj4KF3tNxU44Re88LxmnAkXVjtrb5Z9DEBcn6CpgnE0HHNg2wJ4=
X-Gm-Gg: AY/fxX5DuOpY75++yDMJGFtnrDeNQCYOactOgqzs9G2ugtd/9HdrKwgILPgwuLsH3Va
 u5WjQAAfzvI7FYpohsgRZxXxPWGuO5NZy/CNLy41BeJ6MRsj4ezDdygr8FK7IcSq9DYtVIzfMT5
 67lZ57Q9uf4dDCNt3KbB74t08j/ya8F+9I/JPoSBdfuIY5mYxoUOFFuaJUcvQuzCYqrHHy34f0W
 TP+Y6uCzmFAhR8n1yHa2Uu9P2YNUizz/sIrPNxfXtvm5us/2oIf7+R0J2DNyPlAEpBNtdbgq7wn
 lCHV9ZVCfkuyKYEfU2/OikiJvob4g4wb1IzGVz3KhkPrOKG3Fr37Z2UO6vdeZMXAgkoSsh8qi6z
 7kp+CsjBVCN7nKBvgXG/6NPqyIU7NWsgyErG+mqSeUzKWp+lrI49cK87y6hO2zQviDnPjiOlDpn
 cUc77/4gebsX8/GxJZzLDOVe7CA+tm46d7wKc+0gh7tx6le4Q=
X-Received: by 2002:a05:6a00:2da3:b0:81f:9b97:5e4f with SMTP id
 d2e1a72fcca58-81f9b975e6cmr199499b3a.47.1768468950129; 
 Thu, 15 Jan 2026 01:22:30 -0800 (PST)
Received: from sifive.com ([136.226.240.171]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f8e6751edsm1904252b3a.49.2026.01.15.01.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 01:22:29 -0800 (PST)
Date: Thu, 15 Jan 2026 17:22:26 +0800
From: Max Chou <max.chou@sifive.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 14/18] target/riscv: Add cfg properity for Zvfofp4min
 extension
Message-ID: <aWiw6MWqJWH1yMSx@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
 <20260108151650.16329-15-max.chou@sifive.com>
 <d235db23-1c03-4adc-bcb9-e190205f2c74@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d235db23-1c03-4adc-bcb9-e190205f2c74@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026-01-09 14:59, Chao Liu wrote:
> Re-verified Zvfofp4min -> Zve32f.
> 

Ooops. I missed it when rebasing.
Thanks. Will fix it at v2.

rnax

> Thanks,
> Chao

