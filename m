Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8C2108B900
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 11:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Y5K-0004ML-V7; Fri, 20 Mar 2026 07:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3Y5I-0004J9-0A
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 07:32:09 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3Y5G-0004ia-Bk
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 07:32:07 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64ca1ba0089so1806146d50.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 04:32:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774006325; cv=none;
 d=google.com; s=arc-20240605;
 b=SKzY5s12DeylV2WfsN1qhbnx42cBuBEf4CiiEDu0vNT23J1yszCIcDUG4fwuEPMkCI
 bQWh8z3w6qnlXKkl/DJBExPAwtymZXyJQ3YhOB3L4nirm9XY2sR/RgIwixJNRvRgpc8S
 FhLsrxT6FQbg7uGbdVnMf4vI2mrnunO+IP8Ba5nP9/An1h17mCjt4ap47h1pSK5F4chX
 BK/Q3bizVDCy/YWajIm3BYmFhll5Y9hAXs7rr6qGB5anfUDrGwQw1UfpSip/7q+EkRIh
 ZAnw1shVcdQghO8cX+/lOBzRdub5VgvwXEP8obidUUMSEOWoApsIj1DrWAWbd0Ha3+1Y
 gfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7PmEIpn6qWS2999e9Kq+Dsi4jLGGUjpI253Hsg5y18k=;
 fh=BNPn5plGW4iapFgomzvvXDa0mZylAFxlcZuJupMSfiQ=;
 b=Td1XpJzsgf1KRPir5jyLT8zmroYRktBBl9yKkYDVQoHxUSZbCpHAi7FeSbv/ovSGNB
 AD1WGkbfNFA2fDRj3DxuDA8Rt4SZX9rUUmjBpkb3JhHHUp9rQkUwLPhmRiYuSVgy+kxo
 LbOLe7Eq4Ph9Ydu0FW9muNj3psP+vElASUYSyPWCY1RGcCt8qvOj5Y5MZ7M57cpSLvcY
 OECCmPS5nuDrl1gpsiImGNE2lFefYkcj2dHXizsRZDxTDWmydYHvNbBoufZHg2wV4aQ9
 3CUIyuQBhfkgo3W6AeJt5bIpNvcbKfuq/iZ1i/mJFi+7qcFwzanS/ff3WASt8+ism5JH
 RfgA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774006325; x=1774611125; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7PmEIpn6qWS2999e9Kq+Dsi4jLGGUjpI253Hsg5y18k=;
 b=UI2IJnMY0JAMgPLI2EFWAh83WEZcDsoj4MCqO/4H/NX9gqfHU2P6AxvNjZY9pbfW7x
 VdiD7GExuaf87mrqeeuI9mPg1utrmSlFwcFevhIiXzaeloKkJP5FDbJ/W14GKsxCDtwv
 49vsiWPhkN7Xr6MxO3GJITLILKZwjYw1BTXW/8CT3cJk05pait0jtIT76peBOfoug3y7
 c5BBYq1lmpSgdrbCeUk62YDW4fvOOv1LXS4oyI9qhLnwKoeNS2OL7K7jPoNK3llvYurI
 4MzGmpDJ+JggZRtEa7gwCJLZTa4sXn/qU6ey1cgBP2B7aZdu0FGJNqkm4W84CXj6xpbv
 uF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774006325; x=1774611125;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7PmEIpn6qWS2999e9Kq+Dsi4jLGGUjpI253Hsg5y18k=;
 b=lS/zWoK0giq+uvjYTBUqibz7hn2M+cBhaErTdhNSm+4U94XF71fS6rn734Vp2N6eoX
 zjjKie1jwtSsBTO1DJu/ZhBlTo0fkyuW0xK43C9el1E+u4HBSX3+O/5qV/wwMLMjB8d9
 rhNr7P0dYFVPcr7/60OPK5WphGn/lSyObv92q/v7HrSGGTe4GLfsp+6qYxZM+VJrcG/F
 F6yiLYEZnGIu+mLD/fYfhkr2t3L/MdGj2rVe/5J+P2bp6Pi918A8EOukiColJ51Gvwm5
 +D8QnA5S+dJAMB0+YmaKVhEu2syv+eSeqejaeIfxfKyVPFpkoM1SHf7hoKyoMC5OErBM
 bUmA==
X-Gm-Message-State: AOJu0Yy4h4oxvJs3YZ6w6a7XCStcoLablTeWxx/lYjgoSpczhxYAI+cX
 hz4a60ZjYioNYmcTZNP8tr7gurzJxVqZQy6CBGIpAyu/mAGGdxOTGuDAXZsuSgl1grrTHsrnye1
 NSJlZnWlxEmqX5PG95J7aqteXl5Z1SjO3nCyNqFOQ7A==
X-Gm-Gg: ATEYQzymiTOqBhefaYXFn0id6UJTwHd0Rjq+EoZkF5iNNyQx96SrbZSd0kHDJptVPA8
 jrl/WHIHW85gygJ+ul2BwFNF67r9fzmAr9SxeMhEqdKXxPY+XGGozT9hwe3p1HTzI8PQsl77joL
 RIzgNFOhxb3mZQsKIcq1QobDH7mMezFcFj86YNwCJPejJj1SB02F1jKEZgogPHXHMK1Fi6OLSmj
 C+7nQgVEXRqXcY7zl/Fj5lvhseXXiSt6ifjC3cVlHXRbta2mdjSX4VKqwAqVoDq5/0bzw612v3h
 9+D7I3GeVUwQ7QvrKFLYVqeISg0/R1luXpcxdDseCldj4J2JZCUUCm+7HCiV7h3MFGLdn+nsV2j
 Udg==
X-Received: by 2002:a05:690e:1206:b0:64e:ac68:548d with SMTP id
 956f58d0204a3-64eac68598cmr1550254d50.73.1774006324884; Fri, 20 Mar 2026
 04:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260320111647.138984-1-shyliuli@aosc.io>
In-Reply-To: <20260320111647.138984-1-shyliuli@aosc.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2026 11:31:52 +0000
X-Gm-Features: AaiRm50a_0hIUBOEMDSRwASWBnqz_HF9Z6yiRyUr9L53IUv__7dw8kdLl-GafLw
Message-ID: <CAFEAcA8EgLD48QASJCvLUGjmHDdVSFX8=cdiyHpuxaqmWCnNig@mail.gmail.com>
Subject: Re: [PATCH v3] linux-user: update select timeout writeback
To: Sun Haoyu <shyliuli@aosc.io>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, pierrick.bouvier@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 20 Mar 2026 at 11:17, Sun Haoyu <shyliuli@aosc.io> wrote:
>
> The Linux kernel writes back the remaining timeout for select-family
> syscalls in poll_select_finish(). If that writeback fails, it keeps
> the original return value.
>
> However, QEMU only writes back the timeout on success. If the writeback
> fails, QEMU returns -TARGET_EFAULT. This can lose the remaining
> timeout and change the return value.
>
> Update do_select(), do_pselect6(), and do_ppoll() to always write back
> the timeout to match the Linux kernel's behavior. If the timeout
> writeback fails, keep the original return value.
>
> Tested with the issue reproducer.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3343
>
> Signed-off-by: Sun Haoyu <shyliuli@aosc.io>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

