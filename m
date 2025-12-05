Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AB9D2CE01
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 01:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRKd3-0000IG-6k; Thu, 04 Dec 2025 20:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrtc27@jrtc27.com>) id 1vRKd1-0000HV-Bs
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 20:28:59 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jrtc27@jrtc27.com>) id 1vRKcz-00016z-E1
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 20:28:59 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so14187095e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 17:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jrtc27.com; s=gmail.jrtc27.user; t=1764898135; x=1765502935; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k20l+9m53TjOU/a2lmglfT7bVTDyvj1RlRxi2gNcqLw=;
 b=dQ1an7Jlour73lqcDlNWiEngBO9NyxBeHopMnCj01LUrmy1VyffZRQbfnzDg5LB9ns
 pZm0RCMYjJxsIfxm6uJZBCrQT0HXviZ24w6zFw3rf2JOpyCgbO1HR54NJPtdAhLrGkfs
 ZRkrKLvMhTcinO8evXCNixDD9GN//JYZe06+/loIRZpukB0OHy0E8loovprO/pP5nx0E
 JRgivQ4HgJAPSeXDuEpQGw3ZLIlr/HkjEjIe+t17y/2hGS8CFnf+plFwdj1jlxjSgbaw
 c1bfvUZvctcaBR0fQkGLLzf8e874P8vwSnvn0HxE3jspcZ8EgUEL9Fnz7ecsgxFYE8FZ
 2SZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764898135; x=1765502935;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k20l+9m53TjOU/a2lmglfT7bVTDyvj1RlRxi2gNcqLw=;
 b=dkiMIeaLY6ItCRDtiD8RGfNKwH2FKomv2fTsHTqZmjVwat+Vs2oy0PZ9GKmfLiHtbm
 bo7DvJOylnEbx3OhWp4ZIUxJsAF3xumH0dwXfQ5ZkPgMXk38Zijrb7jZpCkGBLqAOnfW
 eWsWOStmLD4ytmvbJQRIHBJU1RyJRmG0J6LL4U/MIJG+cs7S2ef5xebA6tglBcCEucm6
 PgvZ8vYoDAG9BSakP4ElnOFUkZHrcEvh1ZlIpw//WtAVsnRmJCNS7KanjbDKYXRhX7ce
 2GQcDXlhFCR7Sr1WvqRDQEHBtaF+0X0dmnmdw0JJ9C1Uk/cE3PsvQOOG5y7y6rHXCLt8
 EzKg==
X-Gm-Message-State: AOJu0YwuiwkqsyxmClVuGmgDDYdXN9P8rtc5dDO3C+fS4ZXH2P4kKkQX
 7gFPvUDS+ywVQ/5Gp4OcX4ZNF+BKwqCEYnMf2Ti5u+Qd3tUXVr1w+bzEjoXU3WATDac=
X-Gm-Gg: ASbGncv1jvNUYWi2dCOoUI73vzTmOzrvCK5tGOab0D/hay0ffKImltdj7lYNeV2W+eP
 baJdvmSADne5ocO4y+mQVRn27IgmXJ3Vk8XepJLV3JGaR4ylm8D+7MxKeYOERr4IR2LRQxYoKou
 uPZKDCNbb2M15iEL3inhPF1moX5xn2aIho/h6+NdnWs8NJtYWEjanwjKjtp7thxY+OEYVoyD4P2
 3TrwDYJBSo6G+nPRz39yKTiklhDRJxp+ash/ApR27CIPOCCBifqrk1F3SZCBDX0tJvq4VCf0KPN
 lX6Y7KTjLtj9CVzWSicJ+YNmYFYk/waFHhKXv1HInl3mDQGjfXvmVlritdNg3CA2+FPmXZR6EQk
 z0nPsLJXnWkUwAJWl8V2yReyWrY/mV7o7hADdlSDeouZLIhvl/e6h0yTnY0MZqiKCU1ZtkHK8MQ
 Wn5LXEo7kN3LwkWULS/tk/DgU4iI1ZZi/f2BdBZ7mOpz+sRAIhm4yqtdy+MJUa/HuCWV2dwphX
X-Google-Smtp-Source: AGHT+IHu/eRWalgYgjrBSDTdZejwyT9F2+yelvszQfoq+rSQxmUx8ZxI657mL8BZuS25dM8tporT3Q==
X-Received: by 2002:a05:600c:c84:b0:477:8a29:582c with SMTP id
 5b1f17b1804b1-4792f39d92cmr49791185e9.34.1764898135044; 
 Thu, 04 Dec 2025 17:28:55 -0800 (PST)
Received: from Jessicas-MacBook-Pro.localdomain (nat-184-7.net.cam.ac.uk.
 [131.111.184.7]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479311ed466sm52640075e9.13.2025.12.04.17.28.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Dec 2025 17:28:54 -0800 (PST)
Received: by Jessicas-MacBook-Pro.localdomain (Postfix, from userid 501)
 id 97C1E1075B23F; Fri,  5 Dec 2025 01:28:53 +0000 (GMT)
Date: Fri, 5 Dec 2025 01:28:53 +0000
From: Jessica Clarke <jrtc27@jrtc27.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [PATCH v3] target/arm: handle unaligned PC during tlb probe
Message-ID: <aTI1VZHxicpycoLj@Jessicas-MacBook-Pro>
References: <20251204203540.1381896-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251204203540.1381896-1-alex.bennee@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=jrtc27@jrtc27.com; helo=mail-wm1-x32c.google.com
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

On Thu, Dec 04, 2025 at 08:35:40PM +0000, Alex Bennée wrote:
> PC alignment faults have priority over instruction aborts and we have
> code to deal with this in the translation front-ends. However during
> tb_lookup we can see a potentially faulting probe which doesn't get a
> MemOp set. If the page isn't available this results in
> EC_INSNABORT (0x20) instead of EC_PCALIGNMENT (0x22).
> 
> As there is no easy way to set the appropriate MemOp in the
> instruction fetch probe path lets just detect it in
> arm_cpu_tlb_fill_align() ahead of the main alignment check. We also
> teach arm_deliver_fault to deliver the right syndrome for
> MMU_INST_FETCH alignment issues.
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3233
> Tested-by: Jessica Clarke <jrtc27@jrtc27.com>

v3 is different enough from the tested RFC that maybe this shouldn't
have been carried forwards, but I've now tested this v3 and it does
indeed still fix the issue in my testing.

Thanks,
Jessica

