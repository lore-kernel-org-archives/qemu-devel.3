Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B856910ED656
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w64Oy-0007aV-Ir; Fri, 27 Mar 2026 06:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w64Ov-0007Zx-3I
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 06:26:49 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w64Ot-0003l5-Ho
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 06:26:48 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64acd19e1dfso1842682d50.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 03:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774607205; cv=none;
 d=google.com; s=arc-20240605;
 b=luqdZvc5QEj7Si8K7kqZbFBWliHgYdsReon66v0CBMCz0JUfrOnYwHhcNuw4b9/cHJ
 yirW+GWRZ8b6TEGvnmijcHLV8e/wYxd67TxpZ3iWMp/M1AGKdEz1L8Yc20zXgWPcG+h2
 AkaFXndqkkDZxBjKOQadPlkcwZO6iK7plhP/p/UiUoOVF6qGrEwN6ZPLKYjJMMJzDqJg
 hvS6BfxHzGwXyzPC4/QVrbLl2qcuRAIesA2hhRPqSPR/Ianqx0jxntDXKw6pwfBIjJk6
 6/9SLubznjMGVIztXGx5mnERHvKTMyCn3GE9eiMiTqDeGISh4+RUbmxypL04niTQOwaC
 azOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+flSvJOn3RvL77ZMIK5nbQ81WmgCb4SQVDXi0GpJdHs=;
 fh=0uJc4Y5tQSYDCS1tif99eQUSn/tnshq7qHMDjAMtiDw=;
 b=QQSBD5ySFyBm2AcLvaar3fFOnpGzlQKCCV+1w9bf11WTTLY7Yyb3vuLYpFV0c2Rcj2
 VKBTG8YuYJz8I0c8ZPZxWvhU52AmYn0Bog5AmmMuauy4jU5d3Yn4F/mPbxLDd+E7RaK/
 yHxePQ6cvqlH+hTVnrPA14Qgo8kDKtjK4EgpLsvv2U1K5nve3jhbxRSHsXDZdIB6NZJn
 17McAMR1+ts/mvQ++QeTCjRspzE4ZmUdi9SVAl620KbzFbK2BXD89RTtXNRdClTQMcYZ
 AIgx4I2dlAjBYsZ6lM/TYDy0KPXUEYkVrFHwVJaO4k4aRsRDcCNkYLPhxF1lEHrHOXZ3
 mrLw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774607205; x=1775212005; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+flSvJOn3RvL77ZMIK5nbQ81WmgCb4SQVDXi0GpJdHs=;
 b=oXrIrH9hmcGJLG+6plzsVAgjbC2ejslUsAU+KyTY03WbnWyAfxi8j/FrMLqJEasFCq
 +gjdJmaTSQ/21sFtObELoAOj+yCT21EmQ97dYzlzdrfOh0UY2ZGn7xXqqQegz1KYz1wR
 2d/zv5JjeWo3H1NaGJRtBclhUOwZ+qJrN6lpdGee5nDPwuGbSyW38PYdksDsdh7y//AB
 FmLybYDkZEc8DjlPsJWchvA/vH/bpyErQGVas4UoXXJPFUu/e2yxrLROTDx77aqMWiEO
 GGbSjWHMCMdQuff4WDNyxNNtrjBC15fazHevmQL8KgUE3QLQNL1cxwCgmJEqaw3vP1uE
 4ySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774607205; x=1775212005;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+flSvJOn3RvL77ZMIK5nbQ81WmgCb4SQVDXi0GpJdHs=;
 b=BQwLu8BY4JICC7mKoZTT3M+CU/ZnI70XKdoAVxGq68ftEVf6PeBzKHUy+DkKPNV9xs
 E21QglBlBrT1Zg0Et1wTZzv6GQcCrygE+P83PsRzJNXkFzvEy3QTzDfc5je5LTvr/Lw/
 PGhbM69ucvepy9MZtomfeAR7QVjpMT0yaUQi7GVG653vs9cX/ItQ9LyzuCl6yMEJgeB6
 AdwfYTdODflpoclHFqQRXpgV4aW87U5cVL8Irh/ztCSRJA9s9Khi+5JfyNVYNw5qUEOf
 gxrSod/7OKI90k83Glz/iKUZwhEDYMzW5rseqfMJtQDe2ONfuancQbWx5LB5BMLcDQ6b
 VrJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbA4JVGvkIvlUakFukPwjZfIichIoYClHSciqbFAj1EBoOm2PltiY891RpatkUfaL0bf8qRWs61cfG@nongnu.org
X-Gm-Message-State: AOJu0YztgWSEV3lSBkfspbR65Nk4JMeJTbgd9AHI9W479R+gI7EHN2Aj
 +FQ4IwkzHb8VXySH7lGO0NPZ2ymm2mKskPpn6zOwzlPPI8jxlLXQg0KhVs8PWxljSOr058lXj42
 1QLoeeyMn5jmI0GyG4LzjCnuNhV6JuVzrKBeqZz8VTA==
X-Gm-Gg: ATEYQzxRnXRXXt/OsIbtt8tUqBxdRNi9i6rF3WZ7UcadN5EX3L7yri++11tP/90w/09
 cp6hPMV2T/n68y1g9vc06OUnUNj9uIBj3YfzJIkuGgrsHvDwc495is9yijij+eGrN6e++u894dD
 nGMfB0fP/CvBJiKdaeKcNq3r2q4+LRpm2q7wFtot0cHExE60v7HmNjVWQNjFNmSAqpjG/LHt6gr
 7mKWdjDv6pfaRZHhKPfU+NCBxhNhBJZa+hR1JqKvcJ/WOpR7t8kbDvqD8Lbo15lSAsXDcynqU93
 7PyF5MBD2vos44jnpPRqRGFuUN+mauHDl8LA7Osw/p1qXSw+yXGjq7NZvJ/eSANDG44=
X-Received: by 2002:a05:690e:4394:b0:64e:dfea:ab65 with SMTP id
 956f58d0204a3-64ff73cba44mr1339988d50.43.1774607205014; Fri, 27 Mar 2026
 03:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260324-tpm-tis-sysbus-ppi-v1-0-e59175210954@redhat.com>
 <20260324-tpm-tis-sysbus-ppi-v1-1-e59175210954@redhat.com>
 <c6830a19-c275-4a83-bb17-4430680b3d54@linux.ibm.com>
 <A2BD2FA0-6D5F-47DC-BF2B-017ABE5F31AB@unpredictable.fr>
 <07ff064e-bea4-4beb-811a-f5f3485836d6@linux.ibm.com>
 <CAJg9Kky1q=5DFDPkh-i1hyxCKmpuEnR02hrHN-ncewY2VO0LQA@mail.gmail.com>
 <EAD6E043-B77B-478E-91D6-863B0E185CFC@unpredictable.fr>
 <CAJg9KkwznOFSzcme_6A44Er7dd6Ae+szWF+Fwh4dw=Hyv3BWVg@mail.gmail.com>
In-Reply-To: <CAJg9KkwznOFSzcme_6A44Er7dd6Ae+szWF+Fwh4dw=Hyv3BWVg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 10:26:33 +0000
X-Gm-Features: AQROBzBrm8UyIFcBtygqCAzUaq0wLUTyciJQKko7Vl_Qa7HkhgvLl4tFVFwA_Vg
Message-ID: <CAFEAcA85B5g0xRExvicBZwW=bADBj+dQFFeA3ihg+=bTYJNZCA@mail.gmail.com>
Subject: Re: [PATCH 1/3] docs/specs/tpm: document PPI support on ARM64 virt
To: Mohammadfaiz Bawa <mbawa@redhat.com>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Stefan Berger <stefanb@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Fri, 27 Mar 2026 at 10:08, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
> For v2, I see a few options for the docs and wanted to get your take:
>
> -Add a note in the PPI section mentioning the FEAT_S2FWB requirement
> for TPM TIS on ARM64
> -Add it as a separate general "TPM TIS on ARM64" note since the
> requirement predates PPI and applies to the TIS MMIO region as a whole
> -Hold off until the ISV=0 syndrome support patches land, since they'd
> remove the FEAT_S2FWB dependency and make any note we add now outdated

We could in theory have QEMU check for whether the host has
FEAT_S2FWB and actively warn/error about enabling the TPM
in that setup. But if we're going to land ISV=0 emulation soon
that might not be worth the effort.

-- PMM

