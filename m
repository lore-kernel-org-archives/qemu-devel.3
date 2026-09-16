Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55920C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nBJ-0003BN-TR; Wed, 16 Sep 2026 06:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6nAw-0002NZ-Rw
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:47:39 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6nAu-0003AP-Pz
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:47:38 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cebad4aeso630598a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 03:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789555655; x=1790160455; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=G/L9zReA+0YntS5TcwmLrFmdPmyT0SCmkD8sjeItoIo=;
 b=XewJh912QLeaw4TM8M/FaPBiToehppGdb0Vuu/7wJ+HI+3nIGLvG5ANwz3M9D53LAi
 iCXNdR/Ur0M7SUeefnE6Dqx1/Ss8wJs0JFJMlLPhO+tkOWL0DKdeeRUVFRuzQOLHEoyQ
 Fed/idupLxHsw6MoSiKi+ihOBS0HcVS+GMqtD+j6S2tTdmuAs1WP72z8DQYDem4XC9jp
 aqJImIxP6qXf3TJArxmu5eadyX8asH6JC7r5L1ssogZY5E8KBUXWaUX1vvh9t8KgSnkA
 0yxpZCNCmzUGl9BIQ2kwj8FDMZYEQge6l8SKQkRTVMcs5/HFjFrxbL4l3OI5K/4rpGov
 lUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789555655; x=1790160455;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G/L9zReA+0YntS5TcwmLrFmdPmyT0SCmkD8sjeItoIo=;
 b=O01fw65R4hldAM8GBJEv5CsdhAEDCs8pctAftBfjH+DHW8RbPHk8D4dXcRJA8/A5pB
 C7QLbGplEyo4cd0sOgkirWx+bao2oySyzfk3eEX9pFj4fM28eRymbthLgLd3WnCVw7pW
 bDXcQqO+UQKeZ7FQOAvfcfcKfj7omI9MoNdQDw8JcFk7v2gwW6N9hOzJY9iT7llYma6i
 fXXwlxy/KdVgmj+lyAXUnghNkTIGNrsgQ4g25Pgr4oJaZPxkEYTdXgfVAmQWDQYoBj/b
 88CEd+FZ/1WAILEqAswV6nuUxUYE6ehyF38ggA7LTSr5TsgbcZeoZX+uAvmeEz+wFVOK
 T8uA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfF+75FglO5NEKI94V4Ualr9eUhPKIrHW7dstsHeMBJTpkO5t51wCXMy4UK20ldTOfhq0kkAnqy3lL@nongnu.org
X-Gm-Message-State: AFuF++k8D6qhjdJvLRUYYwklRyWyfiuDceOrCvAmgi9rVrBf1ZN1xgZF
 ZyA1Xgtbtl9iwYF3BPahW9XUoA1Oesxbn1QKitvGNNSSmiXHgiUdLD35IUJLlYjsAEU=
X-Gm-Gg: AYBFou0ghaJjqoLogNJC6BHrf0+GfEC77wEinPA+yGmJknatRjfD70HDQA3g7eCIKJZ
 MqRK6uDqbNFfp0+yWpCrxTded3212IAxAL2oaQTiTUiJquHHa1vT4urmHaCEGB5ju8AgS+sWkTB
 hTjAgVqpfV7J/BEgIja135Xlc7LvoWBpacvnMx4m3MzeYGJgG6V1GAGkuzcEgIgXZfOfu074OVU
 3PChz1gC/yrafy//7JvMlP9lIHQYLTc1pH2Z3cJvO4k8TXpREQuuG1CnkjC3SbZCP8LmnJBr9Fo
 LPiXC3aQoJzf8XKTfkh1Jzlu2xOna9W4MCQpodPVwpqS/Xygb6/7aRbQiprjgmndDIEHRRcQs3u
 LyAkowRmVhUzKn4BNzoiZmTl+WlxRpnlFWDXJ/0sUYoYzEfxq0X5vu/eyKLJdtIQedXDHptixaX
 eiI1U7F71DFUW0SJ1lVNfoi4ft4nm3uzuJUqr2472OEBMYiCL6fbvk5n6vwDJplVY5KZcGqnRrs
 A+f8PmxLGZzPvea2e+2EXRyvPK7dA5sBu0h2ENQmwXYt92GjM6U+WSjBasr2A==
X-Received: by 2002:a17:90b:3bc8:b0:398:dcfe:968e with SMTP id
 98e67ed59e1d1-39e1e504f3fmr5984255a91.20.1789555654660; 
 Wed, 16 Sep 2026 03:47:34 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:845c:f507:397b:9b72?
 ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5a6a0c5sm7354046eec.7.2026.09.16.03.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 03:47:34 -0700 (PDT)
Message-ID: <63ab8536-5e31-4101-94f4-005bbc6eda27@linaro.org>
Date: Wed, 16 Sep 2026 00:47:31 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/17] testing: various docker clean-ups post meson tcg
 conversion
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260916085341.1692742-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260916085341.1692742-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/15/26 22:53, Alex Bennée wrote:
> This cleans up a few bits and pieces although doesn't totally solve
> the issue of an apparent stall while meson builds the docker image.
> However with these changes there should be no difference between the
> meson build and the equivalent "make docker-image-foo" invocation.
> 
> We also finally get rid of the ill-advised magic caching support in
> docker.py.
> 
> v3
> 
>   - Update make2test to trigger docker build from Makefile.include.
>   - add Daniels's suggested console: true patch
>   - fixed up some unref vars from the reverts
> 
> v2
> 
> I've restored the configure based compiler checks for so we can build
> roms and the vdso blobs again. It looks like we could never build roms
> with container based images so I've left it for now. Unlike the vdso
> build we can't trigger a container build through Makefile.prereqs.
> 
> TODO
> ----
> 
> I've still got Ilya's s390 test image patches to look at but I'm
> sending v2 because enough people are hitting issues.
> 
> I also need to look at the timestamp stuff that Pierrick has suggested
> to see if that improves the caching from the registry.
> 
> The following still need review:
> 
>    tests/tcg: add console property to docker image custom target
>    scripts/make2mtest: add docker dependencies for check-tcg-% targets
>    tests/docker: fix brown bag typo for docker-ccache
>    tests/docker: swap --quiet for --verbose
>    tests/docker: add container registry to configure and use
>    tests/tcg: use --add-current-user when building containers
>    configure: re-purpose the tcg test compiler configs for vdso building
>    Revert "tests/tcg/meson.build: implement ./configure -cross-cc-* options"

Still missing 20260915110855.491985-1-iii@linux.ibm.com
("[PATCH] tests/tcg: Fix building outside of the source tree")

which is second behind --disable-containers in my current pain points.


r~

