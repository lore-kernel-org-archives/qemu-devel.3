Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984C4EC01A3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4aVF-0007Gv-55; Mon, 23 Mar 2026 04:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w4aVE-0007GN-BM
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:19:12 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w4aVB-000779-LW
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:19:12 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b07069e2efso23446195ad.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 01:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1774253948; x=1774858748; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=13roTXJkDSTjjW4LuFpIWDEt/qYgybbs0i5LejU27Mo=;
 b=QnqnkRtgo9rExDAkBc1cXAly/bpJLsTCtyic1qG1gzBPonEUvkELvErIfjB6AT2+2K
 xNJeETTPLnvTZr78MUVrfI0tsq9kCSQwcJESbYkOhfOH5fCWQZ00o7g9A58z0FPO8Dxz
 0rJppecvT+9NCyUg/+ts0UFmCQNW80rH67z7H8MlYbYI7xK9KkwpJsIcxMCvBJ7E4GhO
 cIdabNkMSlyQrDHWg/15kvkYqm67U4Z189hrLrHrLDuXodVkcadblBEOETE36OiBjGrh
 6mTgCZMSVyClyidAsCcENRDmUeBq0clGUmQB2r19g1MCSEkGf2zC4X9ltrJ19vh+vnr+
 SPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774253948; x=1774858748;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=13roTXJkDSTjjW4LuFpIWDEt/qYgybbs0i5LejU27Mo=;
 b=U9l/b3X1HnnnUgjsdQTxiOkgRzUcjSv8jX56MKFIbP5emeDfIhAE6mxklR06xsVv2T
 ETR9bS/YExKoIOHcY7mR14dI2/hEIJZxVrX/lWx2p/VN8ShucvumZGqJZO4C13VAy+Nn
 F7wXDb4PZp5HDfcm1l7koFllNl5F5TWPcYxJ9ApZqzxd+PE5RhNOUdYRnc5uo4ZaJaWW
 W+KNCtVqzRqTFRCqzwLJMi8fIspmWKO3kEK12w4Q0iSW9gp8sSijxBxDCUeYczF5rIp7
 q4ncotvxgdGbExGgaSezDn+z4auaerJldaCdxpnnufmlbsJnothbjXO0Jb/7HygwfaeT
 T0jw==
X-Gm-Message-State: AOJu0YxCIGGm+5IyTPtut0fkyeEJoxi3oNWbyPeUTzDYTBQ2qWM8Ottv
 yYWN2C5dsB5YCU9qPrWkPTve6ZcPj+P4ilqeFg5y+v/ramUZCH10DFmNqctVti+mQRc=
X-Gm-Gg: ATEYQzzpQPa5oj071/LuZMJ08OZr2ZCSQ8Ju7Kcs3nZ1sADrGg5m4/rnXg/qhIsltsv
 fJBRxY6UVazteHa6gPAWrdEI+wxtDA7c1C7ljDUKhN9C2O88Tm+afaNx3jNcMBC2a1UD2BFhxqe
 yIbEJL2EFZHSaDuTq4w1ZJ6llufNqJc9Tf0UqKBz5TVUiMfR8JDtr9IObZaW5BeqjVXunoaPJV2
 vay5Omr4MPMetRl2L/LO0BHPmRpXgIKSXG9QeHQ91Hm7Cd5/peNNu2c6C0N0gK/RDLP8HpnxEWg
 l4oCQa4293Xu26Sh5mtSW4GACglxCzGg6LoSWap1a14x1I8YHUo5+SEzL1gn1qeTiNp4RnCYfwj
 B0iuQJ6+07KWU1jBpXle0bNOFBlVaEeHOBTkxP8Zk4557NgHd463sccw8vlZYBwzZMt2RDpeAMG
 wccbEkZL9xsiw1cVjCFc2/wkTwzQ6DMU2rXFEXSVkZGHovy9LjEU4ostghymkEc3iC
X-Received: by 2002:a17:903:32c6:b0:2ae:ac0c:5a29 with SMTP id
 d9443c01a7336-2b0826d7421mr114445735ad.10.1774253947895; 
 Mon, 23 Mar 2026 01:19:07 -0700 (PDT)
Received: from sifive.com ([165.225.234.181]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0836a31ecsm101581125ad.77.2026.03.23.01.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 01:19:07 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:19:03 +0800
From: Max Chou <max.chou@sifive.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-stable <qemu-stable@nongnu.org>, Paolo Savini <paolo.savini@embecosm.com>
Subject: Re: [PATCH 0/2] Fix probe_pages and vext_ldff issues
Message-ID: <acD2qZvU-TQTa_e9@sifive.com>
References: <20260318013805.1920377-1-max.chou@sifive.com>
 <9843f984-b58b-422c-a823-11a497510709@tls.msk.ru>
 <acDljtkBJTxOMqfk@sifive.com>
 <20a922d2-cfdf-4ce2-b230-675e33266d42@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20a922d2-cfdf-4ce2-b230-675e33266d42@tls.msk.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2026-03-23 10:26, Michael Tokarev wrote:
> This makes sense.
> 
> However, 10.0 lacks d887736225 "Expand the probe_pages helper function
> to handle probe flags", which makes the first change in this series
> (5568177738 "target/riscv: rvv: Fix missing flags merge in probe_pages
> for cross-page accesses") non-applicable.
> 
> Is it okay to pick d887736225 for 10.0.x too?  (Adding Paolo Savini to
> the Cc list).
> 
> The result works and passes tests but since it's not my area it'd be
> nice if someone can confirm/deny.  Or maybe some other fixes should be
> picked up for 10.0.x too.  The current result is at
> https://gitlab.com/mjt0k/qemu/-/commits/staging-10.0
> 
> Thanks!
> 
> /mjt

Hi Michael,

Regarding commit d887736225, I agree with you that it should be picked
up for the 10.0.x series. It includes the necessary modifications for
probe_pages that enable the first patch of this patchset to apply
correctly, so I think that is okay to include.

I've checked the cherry-picks (3b3e6682/2f4335d7/ba624f3f) in the
stable-10.0, and they LGTM. It appears to include the related commits of
this patchset.

Thanks,

rnax

