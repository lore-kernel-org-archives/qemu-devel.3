Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9E6CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIOu3-0001eA-BS; Thu, 30 Apr 2026 06:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIOu1-0001VY-Vd
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:45:54 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIOu0-0005ki-Co
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:45:53 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-656d749109cso413265d50.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:45:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777545951; cv=none;
 d=google.com; s=arc-20240605;
 b=NdLWayQIV1sF5MwC1NoXdBjGdHKyjaTGBdk9Fgb9tEqxiSXpc4NNHhA+XybdZ+jGd/
 8ytN2scVRalzohIbOLcdDQLtKWd6KfGEWDElAdbdpaZt3p2yhWt3vSu4m/bNrWjDcGM4
 Nzv/WHZ9QzPctmUGrKXoL4gOiHXvkkpDLytwFUjE2tXR1KLVn+/2YIlgjGyaNvXyvSUu
 enOUe7qYZ35PJhiZ3Nw2GioBtI+oudlDZOS83BZ6EAz5L8+uAjq4qI04KemOiGfP6C0v
 piriMoBDhgFwUBcU4uawZXZWGi81C0uYv7kcGO3CEDO0f5UTsFrvTg2WujBYJxmIWas4
 Fy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BHNxHJBuaO20juKE/pLga5H1LtRXixgb5UTlH1CgSfA=;
 fh=5hpO1k+4pWDxQ9oa5Nh4x0RcpkpENqy649CApJlWSfY=;
 b=bCMLRlKQEdHkCFlDm073DXsOtN938TYj7rglvsV9KUiC2/WcJQ39D5C9PrpO5rJvot
 9+I+5cFZ17wFqw7rr+7TMhFVZx4X07xIeRnZfGzzugsCeONqpnU9VVuw4CRdDc4ifOGo
 a60xmQ0RFCMWm1hGmro6kFp+ENTNTBLozo8PjUlb3MUlpS2YFepEhmHWdfMi125CxU5N
 HS2NY6AzHpx641Xepu1+cPTedwHRKd7atQN1I5CqnWF+drj5NuBvIRwjhHPacZ94Yb6v
 v3EbEI+xfEe+WXiqKVdqPyJD7ruk5r5GQdp2W80aE8fOSrNMgCf6imfVQ6RZTdl6w7aS
 vlgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777545951; x=1778150751; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BHNxHJBuaO20juKE/pLga5H1LtRXixgb5UTlH1CgSfA=;
 b=ZGrEWOvcWxevGpL8LuBKhYBuFpoedPXj+U5YibHsiv6U3ZiVOiTnreIPKodovoZJZ7
 thbxRqIKhpO8vHtTlJ0dAKKQUh6Gx+I5mUIC9pGokOxxheWRZZwBO/Sx/awmyYdiUJJ+
 EYe03IOm8QoHkaDhQ23Y3l6jhlrswDTgfsC4KNjkq4N3JfbAXV1EFbXSgywGMAMsmew4
 Yrmy68qqNR+4p9FBYdLJghA4LFfeCxQgGJGwxUSiJhEo4I7wX9ak2++DWvWN03Ov6zeV
 Y4aQW4iuF826AOFYm4zFgcAzf9KKd7fkDsu2H91iOgHg19S3OQIrIDWQfSeyah81Z8XU
 1k9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777545951; x=1778150751;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BHNxHJBuaO20juKE/pLga5H1LtRXixgb5UTlH1CgSfA=;
 b=ihfYOTKxgsnt58CCohNxcSVFC0OpQHNUnMhDz7wkuMmhkJJES8W6qx7Or2oRX3dqhz
 D38nQRsJO5H2k1Csmq48fbJyGUh39SLeqqCLF3vCwa1igwS0pMe/6grXDai1EAZZx0f0
 37odSJs4mvcQPkzOksiGdOdGE8yERoET+7IPXUVQV2ctD70+xmGFhxnhBCbouJFJhF2H
 48Por6odBSKJUFZOckxfOl+ZpqALnXqxr4P4HpzLH6DK3iTOcw2CYM/AefgIPsMNdP+i
 wUvdPtVIIHOYG4zexvrU66cYzfQYr4D5Qdg/3js1a/GA/Lxf9F9Yk/DlEQ2EBrqRmbsF
 NE+Q==
X-Gm-Message-State: AOJu0YyLUMQZCyAIgv4I1kTolJ8spHVOau1QeTst70+VxUgcU/vDvpWd
 F3cjS4OnN0zMKdfuw2lj+I5/kTZy7X7iPjPbmlGjK01hhDkt5YKbyRcWoH4kcaG3yJW/V3shdVa
 Km1/KpYNs9N+r68UfJrUNTGfo+wKYii2aXI6UXVHUKA==
X-Gm-Gg: AeBDievzVTaaT/1vBZaHaBfNEv14uDfsEAiISOUVwjvSgSc69GyeRkXIchuJMs+xDNm
 k2p0DzdvtrLHFRxwhx1/VQx1nUTU3TBcwAtsUr/rn/Z0+bwZoFOTBWNvyXq/q3A+RVQXjk2uz4y
 zY2TLQoXFSchezkzcElOcMvAemNj8fuBl9b4SFkTSPOwxQLNyqqnt5y/ulMK/ywmYORfjU0laJF
 d5Xz2kT8AQMOwNvrSeayK6nFafvO5iTtLkq71Qyz7NHn5l15/ryJ4ZupO/x+JiT0V/36J9uATAd
 U/Q7NPS6vIgkx+N4J6Jf9BDc3LQGeGRHCL0a+ij4Ii5C+rPAdba4kVfz/TkZhm3E764uQHQdspO
 6EQ==
X-Received: by 2002:a05:690c:dc8:b0:79f:b903:88be with SMTP id
 00721157ae682-7bd5286ec35mr24805137b3.16.1777545951020; Thu, 30 Apr 2026
 03:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260409035015.132370-1-richard.henderson@linaro.org>
In-Reply-To: <20260409035015.132370-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 11:45:39 +0100
X-Gm-Features: AVHnY4IYbt_Y4eG0oHQudzG_zLHAvsPw9rSRj-bEwJ6YRJpT3_MD5jjAzA_UR1U
Message-ID: <CAFEAcA-mEC7feX5r=W_bvawe-sFdO=8neP8V4-hvYHFYkugeZg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] target/arm: Remove bswap_code
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, pierrick.bouvier@linaro.org, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Thu, 9 Apr 2026 at 04:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: 20260407222208.271838-1-pierrick.bouvier@linaro.org
> ("[PATCH v11 00/21] target/arm: single-binary")
>
> Version 2 here should probably be RFC.  This time around, all
> instruction loading, and more decode, is done by translate.
> A new CPUARMState field is added for passing data to EXCP_SWI
> and EXCP_NWFPE.
>
>
> r~
>
>
> Richard Henderson (7):
>   linux-user/arm: Restrict regpairs_aligned
>   target/arm: Only define aarch64_untagged_addr for aarch64
>   target/arm: Segregate target-specific user-only fields

I've applied these first 3 patches to target-arm.next, as
they're good cleanups independent of the bswap_code parts.

thanks
-- PMM

