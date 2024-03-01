Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79D6C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6P4-0005Ju-V3; Fri, 01 Mar 2024 12:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rg6P2-0005JJ-LP
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:10:32 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rg6P1-00038P-5s
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:10:32 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412ce4f62d9so1735085e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 09:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709313029; x=1709917829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UsexgoUjmTm8RmShfv7UgmGWfFkoww8/n1B6LT69b4=;
 b=E8unwZVszMKXQlNorgq5YLwUUXpVRBdhJ3ydclHlRPytbv7XhmNRl10UWRLhHY+u4s
 mE8prZjNSS2J2H+SnxNwgjd9iYISbaRrLcHKIYr4IYM69PEF76YIOPSKPo9tufbLgY01
 zVQxsD61f3QxkBNqgTDxh2ffah1084irPdAfo6UQbNXIbO+hTrbfXEaLYndzDxLfHnQH
 n+mhPxnOk+z6UJdIPbuVl9FM+sM5xRFvSnua76uxC0XwoyIMJTsi83D1ETbN2tAS53H+
 p14n+CeO3teXbVWMiDHeXhyKdGzLPccCNQXzHa35/SuJG8Hd5Kkz2hHTNo7YSEHc77KO
 3BBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709313029; x=1709917829;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0UsexgoUjmTm8RmShfv7UgmGWfFkoww8/n1B6LT69b4=;
 b=D9IWfMNqSqECHsu0War3lXYqRoluPBmyMikS3aJawRBUBqAGCp2l1IwE+335VmyRC5
 1w036l69mIUBIr9ikf0FCFb/Fakr8WbphuleSDJ96Vk2uvIGO0M/LWqTNQtGCJoEBkeM
 Ag5j4sfib2d/l+zfBuIVf8OASOP2F9DwX7B958r4tcJfimUnOsbnVf4zThul/G62bK0J
 CzPxwxN8UtGojIWU/L3wns/BscFir5iLtOvX62B6lmK1wbhPcL9MMjliuuKlZCVyuP1O
 SQ8Veglu8uBcOxq/3bKMxXiRcNqDeO7I1wMSqa0+csrwWNTViCpjRYxKXp3TJBOSMv8K
 4Z1w==
X-Gm-Message-State: AOJu0Yz6bnmFj+xYhHvq2WmnoG2QQtwihP1dAoaHmizlWtwSbO1Muhil
 7wZqoL7MoqCu4T9bfA+QZ4MfiOyR9+QHP+Wn6psxhjFUYIHQECFt3vPuzHz+s28=
X-Google-Smtp-Source: AGHT+IGMbVuPwnQ861L11RuiYo9pdV+nQMy4AKTsrJyzOAfP/AlLk78sAtYyFS25mJmCl16LzXvrzA==
X-Received: by 2002:a05:600c:19d4:b0:412:c536:16e5 with SMTP id
 u20-20020a05600c19d400b00412c53616e5mr2106253wmq.0.1709313029456; 
 Fri, 01 Mar 2024 09:10:29 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 iv20-20020a05600c549400b00412a2831806sm9315115wmb.5.2024.03.01.09.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 09:10:29 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CC78B5F7B4;
 Fri,  1 Mar 2024 17:10:28 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Vikram Garhwal <vikram.garhwal@amd.com>
Cc: <qemu-devel@nongnu.org>,  <sstabellini@kernel.org>,  <jgross@suse.com>,
 Peter Maydell <peter.maydell@linaro.org>,  "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
Subject: Re: [QEMU][PATCH v3 7/7] hw: arm: Add grant mapping.
In-Reply-To: <20240227223501.28475-8-vikram.garhwal@amd.com> (Vikram Garhwal's
 message of "Tue, 27 Feb 2024 14:35:01 -0800")
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-8-vikram.garhwal@amd.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Fri, 01 Mar 2024 17:10:28 +0000
Message-ID: <87il25514r.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Vikram Garhwal <vikram.garhwal@amd.com> writes:

> Enable grant ram mapping support for Xenpvh machine on ARM.
>
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> ---
>  hw/arm/xen_arm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
> index 32776d94df..b5993ef2a6 100644
> --- a/hw/arm/xen_arm.c
> +++ b/hw/arm/xen_arm.c
> @@ -125,6 +125,9 @@ static void xen_init_ram(MachineState *machine)
>                                   GUEST_RAM1_BASE, ram_size[1]);
>          memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
>      }
> +
> +    DPRINTF("init grant ram mapping for XEN\n");

I don't think we need the DPRINTF here (there others where recently
converted to trace-points although I suspect a memory_region tracepoint
would be a better place to capture this).

> +    ram_grants =3D *xen_init_grant_ram();
>  }
>=20=20
>  void arch_handle_ioreq(XenIOState *state, ioreq_t *req)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

