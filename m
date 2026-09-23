Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282CCC98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9StB-0005a9-Dr; Wed, 23 Sep 2026 15:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9St7-0005WO-Sf
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:44:18 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9St6-0008J6-DX
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:44:17 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99cso1110883a91.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790192655; x=1790797455; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/EdWwjerQTWn/va5gGfhLwinLmOBNVz0Nr8MquIiOlo=;
 b=DJvYQg2xaZg2BP1daxKDFBCOhrkHF9+2tX3RBN2KRU0UyIrz5df7anxvSIOqKQ7geE
 4qlZZoTv/c96YfJhiXF2QgFoOaWWufpqiOi07iCrpmqsYz9oqLg94Ithfm5jE6rEcG57
 GnW06oY/zShYeiFDmch54cthnlleEvjd/vFYV5aO1JadHQPTYHIMIo5f3d3VUSQQ+txr
 EJKJsaox6cmfzF4XnP3U5fEIme3Uu3GX09soMt0oUhiqHQiqY0T+Lgcf+s2LVE+MKoH9
 8ANajYF1M2J4JjjJlmNvZCfN8eKhle65UkXtSZ8mQ+rkjgvOGi2TDai5PiS68lX08RtG
 xAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790192655; x=1790797455;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/EdWwjerQTWn/va5gGfhLwinLmOBNVz0Nr8MquIiOlo=;
 b=T1LYlJrXHZiAU4Pk5tM5/pVGc78eP0nBgYN0f9YqjI+SSJ4EE3b6YR7rjstH69dHBx
 qeaoFXrpzCfnYA5yeINQRBSS6Cc5ep9Ticc2LRwBkDM7L/6fWsVCRpOgKqHAANetfqr5
 cXWfg6CYjdRBs+tg39S7+VYUI6SbVdQHgo+nsEu7H7E9RU5nAiGwARWUQTzr9dC2hR2p
 vURZ3WH9wMtDXC61+bblGyGB1Lqe/OELfEA+p5NVy3kfBtn55RwGdMfdj4WgER3g4frS
 4LKtmg7dF8Jhj5UJRgDVtzPB2PKZWl3yJU0uyMPR/WiFqDwJ5lelmChqq++wKsM6evTm
 izLw==
X-Forwarded-Encrypted: i=1;
 AKwUvByYcChfoEBL4DC1JaZ8DFua6/rh1LzXpMMSnckAe2jr6PfAkmqcdvqBA5YxyEE7icqytJBR7TAGmpSN@nongnu.org
X-Gm-Message-State: AFuF++kslLDa9xyFWZmhPgfYv3ZcYOAwrV1E8cJCZalXepqMx+HW8YmH
 rGhgEcrhPTrHBWo6y15XNpQfHG4xzu+L+glCBW+gAAerQCfpEQ8SIMP6grehCC68LPQ=
X-Gm-Gg: AYBFou0jM7h3WRyDz+5oQldgoqKcn0obrsWfzXQTgz6FWUtTT4QTLIvkVXPaKq3cWOL
 jYBkKZTkv4SLDc9+tKzfbMCsbgyOIZ9bSCAKZNCGGXS0eoPPOcF4hCZrDkgEsJs7HI+FHM2e/5/
 9GQzWtjheF3blDKPdWtwzthy5Qm0f+KrCEUyip/lDgJgT7QfvsRKbseunIgqeS9yCPmVCsivQNr
 xqk9/0qQIjX2p8GpEDCxaX4tAtx/I3TsgZXQd0rgAxjxbQZ4ePt9vBoCIhtfGA+pvqvkrjZFKi9
 JApmQwkkHX4iRmqE5jp1LZhzJPjN/pWs0bnh45SlkTJqjhFHZDLMvgXg0isGvfCJh9a8dyBXQax
 wZKnqIMB5yWrrZvHbye6+1HVh08rqSQrTaaBVdYWsUcez/ArVVCUISe3hweWerORX3SNZU2YCba
 qYINeHN0mxCN2qgpecOntDBpE69Kcvl4LgjvFySPLgmLsY2CClDXVE5CjjO7XmqC4PNMKqdV3p3
 IRL6/PdWWBXKW0HqEel2vb4rzmLsXOIM3bPlSHJ
X-Received: by 2002:a17:90b:390c:b0:39e:1329:7816 with SMTP id
 98e67ed59e1d1-3a098d95369mr142548a91.15.1790192654725; 
 Wed, 23 Sep 2026 12:44:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a09773e7c3sm527900a91.17.2026.09.23.12.44.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 12:44:14 -0700 (PDT)
Message-ID: <e32c7a30-e49e-47c2-9653-bffdd6e6d960@linaro.org>
Date: Wed, 23 Sep 2026 12:44:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] 9p queue 2026-09-23
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <cover.1790149757.git.qemu_oss@crudebyte.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <cover.1790149757.git.qemu_oss@crudebyte.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/23/26 00:49, Christian Schoenebeck wrote:
> The following changes since commit 7074591d7954876951f84c15b994a43251d5a3c1:
> 
>    Merge tag 'qom-qdev-20260922' ofhttps://gitlab.com/mcayland-ntx/qemu into staging (2026-09-22 07:56:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/cschoenebeck/qemu.git tags/pull-9p-20260923
> 
> for you to fetch changes up to fe9e30899ffceef25cf345ec83f76546afca19dd:
> 
>    hw/9pfs: mutate FID path from main thread only (CVE-2026-93834) (2026-09-23 09:32:15 +0200)
> 
> ----------------------------------------------------------------
> 9pfs changes:
> 
> - Fix CVE-2026-93834.

Applied, thanks.

r~

