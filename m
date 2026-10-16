Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75294CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHjTz-00032G-6i; Fri, 16 Oct 2026 11:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHjTw-00031q-U7
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:04:28 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHjTv-0002eR-AF
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:04:28 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-888cbacf70eso71841457b3.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 08:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792163066; cv=none;
 d=google.com; s=arc-20260327;
 b=JccmN8SJwKAyBIvFAs4Lkv1M/NwebVsQLyt2jct4CnjdqTMSk4kjVv6xLVSxQwtTDc
 t/WW42V3VNMn+R7qMpeypGJonLeceJeS6w47/DLnGTFVBmYyGOIEv1XNWbzO24X+aavH
 YHeDUcFFxN+oYyzeA14BcaKp8JRCkM/dPLWX6W2cTsj51rEZ3zM63ME6I4IPbv7ItP0p
 Y5H0V3BIFO1Vqb5zL9zxV13KzI9uaK74Juf/Ha2TRp0sMWAEcgJLH/7fg494potMd5E5
 W319fnTp+7SgYVHqmvJjOHkzTvJTcptLmoCBxX4u6E376g6Kl1hpCexzjz/hc7RVt4rN
 KNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=us2H0RfAYX0Sq/XufmuHMW3vO4usHejrCTKmhwDtjqw=;
 fh=Lo6rZgc3RKiqxSP/Q7XwHPdPl4aEFi3KMChg+BxIXfc=;
 b=W8A+pSBnXT70EBNbjjeZTESbcMWK6wteji9hM1Nj+m0J6jRxYw1S9ft3rhDU5Ye/58
 3DDcGnsNxioWg6AiM5Pd5L+OVUjs7fztQB0dSntbr1uTHiPZneriVzSpYVkDJLE7F3T2
 wCrPy4ch4bp2FFXeWDq8AGVopVwMvTmstldn0hL+0xMBy4CpbZwDgndy863TBWwr789J
 2+1p9zp9s9W1q7rt1hZPtiUq0I66S5NOIQ+/WfOVOp4e3ulvzSQ3G6+ekpIWxGdlhbDM
 DBBENOoBMazLL1vcehEvNQZffWEgIev00hu34ggCjrbTK18u5/afVhWbV1RHpG4sVA1D
 BDgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792163066; x=1792767866; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=us2H0RfAYX0Sq/XufmuHMW3vO4usHejrCTKmhwDtjqw=;
 b=ViVQxHPllA5qJ0TSSyrjw3dsMggNUp/xBUzLGft5o8UNXpwp6p9XRzjhuBBtD6KbF8
 ZOMbm28BN9O4WYSflBZSJqcE6YxmIbtZCksTJWkxMPxFXqLYk+/V6NSuzSrTXjcFGaxm
 RtS512brfJRj+OTLx2GVZZHzeWNZForwdb742VAgbUEOe11+5Zvcco5MBXpZuSZcyKd2
 XpJ4UVncj4BdAvS/YKqnJcTm8SFGGqT+4TuSRoVyFpUrZyLJVjAWZgUwQcMtO0mEm6On
 CpQQ8LWN/MXEnO0fPXqUApSacLnFySvaLqTSHlXgAjoLo/MmxSiBaROhLcGZ2egvBeQY
 9CyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792163066; x=1792767866;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=us2H0RfAYX0Sq/XufmuHMW3vO4usHejrCTKmhwDtjqw=;
 b=JSVBPOLuLtKQfiOGeVtNoaMnDlmvBu3w+JcmHIiE//ODz0eVaXhS2LUh48xW5gfoGP
 1CE4SZrwUASm80lEjN6UeR6nV60EVoSvUwkv43k5iJYluADPMN71UPW7lftUmPYQ4BsW
 UVS87uUuiXju4VErZtHmnNdHzmdwSSM5avZSXFPsuvHN2XIdCoGQ04wvVZJ0JZxYO7kI
 ULH3jdjD5MjTv6eWLPu6JU0kXLreSnrRD9NQTbkMZxWAQ6FZRaHltQggVU1HP1OL17zv
 6HtKzs5UEAxEpsxQThngBi9qAqjWlxVDngnNdKacTZqoYSCHgvZPLs3+O+z+deGabwqi
 QNQw==
X-Gm-Message-State: AFq9FYLdnfH0RY7wvnpnDoDU6RgTXr22J7O5gmU8SOD9cDwnDIweRdse
 cUCpHTL19JTEesXYFtBbv+LO+5/VBjXtxuDg+/8gN6oLR8QdZUJnSdP4OJJ0MJqES4gDv2QfEtr
 VL/Cd/NGhquNP2+wbx4zvp+n7Pi1BJQ8VQ+kVVR/0kA==
X-Gm-Gg: AYBFou3h9ke0W//GZqg7cS8+Gd6RTwERP3Zg+/2g/+xaUFmG9yQ5TtrdzpD6XUPp8J+
 ImqJ3+/PYfJn6mpAfyhhErNJY0BG7bNndjKeR4ptN1RLzyU0c8eEYue6eG4mzFMs4oc7jMnrXrO
 XVCQhCZUFWg1/aUu/XJtpm3zVff0oPAqHCV0884du6AckZvoGj0QP+ddK+rW0MIKlVmdBc7o7fs
 ulOBJXucWPecJDUk0Zqf6BLjkCzuKysUSJizUPDwMN9sQ8G/ZrveoJA3MOK78bwvTKiSR34bw0i
 NA/5L8B0VXI9bJmU82jFV6izHlHJyU674nHPSa+tBlErJ0ogwV480asCGkHHfHSXARY+sS4vyi1
 dmYfchRP5l1JrC5QPf9XLTAmMDAoqpSZBa57aWJ/ncVIU8mNLLA==
X-Received: by 2002:a05:690c:d91:b0:8a8:8945:c423 with SMTP id
 00721157ae682-8b0f21ed5c3mr820167b3.56.1792163065526; Fri, 16 Oct 2026
 08:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20261016143007.3474704-1-brian.cain@oss.qualcomm.com>
 <20261016143007.3474704-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261016143007.3474704-2-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 16:04:12 +0100
X-Gm-Features: AclHuK83Sa3ZyhNRQde2_80tmsTfo0oJeZcdOsq5YIo9dkDcGaDtgAyeZ1IIFy8
Message-ID: <CAFEAcA-faTUOChuACJyaysNU3Kap6W8v6zWkwR8BYzb_-W-jPg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] target/hexagon: use get_user*() for semihosting
 arguments
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Fri, 16 Oct 2026 at 15:30, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> Link: https://lore.kernel.org/qemu-devel/CAFEAcA9EL10xpPx_0YD-q6YcWWP9-iwcyG8x0s1yQhKB-XQGXQ@mail.gmail.com/
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_helper.h |  2 -
>  target/hexagon/cpu_helper.c | 48 ++------------------
>  target/hexagon/hexswi.c     | 90 ++++++++++++++++++++++++-------------
>  3 files changed, 64 insertions(+), 76 deletions(-)



> @@ -513,6 +524,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
>                  ret = guestfd;
>              }
>          }
> +        unlock_user(filename, physical_filename_addr, 0);
>          semi_cb(cs, ret, err);
>      }
>      break;

This piece should be in patch 2, I think?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

