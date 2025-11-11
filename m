Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAA0CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImUT-0007CE-0X; Tue, 11 Nov 2025 06:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vImU4-0006nJ-Ay
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:24:27 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vImU2-00013f-SP
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:24:24 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7866bca6765so33379877b3.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762860261; x=1763465061; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WcY7qXm1KIBGyF4OCvuAoUyRqQhFOzSEarmV+Skm5kI=;
 b=N9stHXkkVqJcbGM2Rmt/j5Dl2FbK9S2fqDfWLFYWMCO9ZqFBkEHOmloXV/q1qcFb/Z
 2pI7d08LefcJzPKD/zjfmEgbXvm516X/mta+CA8OKWFnx/3oqLCfupsCkVnwagOaK8Lc
 FCJA5/hWkNThgfiawFLqrTeD65ItlJXmnay8T7d65wy0+9qq7AEaAQaTw4iihuSOV8hL
 SUPfkJUbA7rT42hs+hAGrjGO5qUXlD2AbG+4LI5KTmVbyED6mXbtG2uzHQy7MFHwl5fk
 4WPAulvPHZX2ZpjljrB7CgwD/I5M9OXDy6ydU2llkI0QViw0h/jOvLIkyDsZhIuSJ7ge
 2a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762860261; x=1763465061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WcY7qXm1KIBGyF4OCvuAoUyRqQhFOzSEarmV+Skm5kI=;
 b=cpJAQmKKnFvfiZHWi5Rq+rN3Ygv06+AoERTyvtNfDR21PkRiV3qNQgb31NGmvO1mmz
 jX0p6dHsKYSBVWJhmZkObHqKfi1NZftYfm1eEaOs/W6jEg/+ldo7p1joIJ2cDCyY49CQ
 J5C+AgC3d9u91lzGFzZJgkwzqY4IcKDAQ3GvCSzb9FFEzefIv1d+Org1IZiYeBjP9zMy
 SLJoNmR3houwhWCDnkaisa1FDmidDd6OvbwHQ+4Hm87n7W13EqX46HYdxQOX6goNCrla
 UvjIFTz6DzVm36Oj6tdRUhy2eIL5Sq75yUb7vnwH7D1PNZmXc2xyU3/zzsIykJESQvjN
 f7gg==
X-Gm-Message-State: AOJu0Yygljmt74/jm9UYGS7jRaFUunAzwd8NNHyOSp4Vk22PRAEoN+Yv
 l07EOsxxd93BWPi/UvA8cJb2XaVDqFmLLvplwZMk+ddd3fgLYpWMoCddyDe6yWeXixf8QwhL2v4
 ytqxMTXjS+WFgFSqDqOrCWGs7V8TNrrOHxe3R3dHGdw==
X-Gm-Gg: ASbGncv9h2NU13kVe0zaYx/2qkS1xFJPcqmQGf+XTJbP7eGQvSAUN0bM5zdtckxoQ3K
 6FT39IdhmO7Y9YZLmbBfh1ko8/URJkkRPh67J+yUOpfkyYmgyqC9ThVB9RILto4/BO9I1nTpfCp
 2ekO+J3HEr3yL+bH4pN9Aukmqf5ZipYdHVH+pBP6UiuUrVp8+VqXAAgOjbFiyLjaxNZVnXvzyHz
 y3WbCdk41Pxjc/h2dVFtInCy/syIfW/xgCb/ENzRniPdSkXn9rBnKFh8jnisA==
X-Google-Smtp-Source: AGHT+IGpPyj0pTulSPWP8p9SkptX98IO3pHR3PUxhluogXt4Pd56wFpXTYvaC/yZcKf+m3CSY+bdGROHTR4eaSfXpzU=
X-Received: by 2002:a05:690c:c014:b0:786:8ce9:3b55 with SMTP id
 00721157ae682-787d53625ecmr80492517b3.5.1762860261251; Tue, 11 Nov 2025
 03:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20251111105429.3993300-1-alex.bennee@linaro.org>
In-Reply-To: <20251111105429.3993300-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Nov 2025 11:24:09 +0000
X-Gm-Features: AWmQ_bkCn7uxJ27SoxbLjgrFeOgm2PxXoLp0jMgLNcy8eusSVGzrWNASYMkzF-8
Message-ID: <CAFEAcA_AUxECwpnfuoz28fUrwrMtbHxgesBwGscS_v3ocw4KPw@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/dma: don't allow weird transfer lengths for bcm2835
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:Raspberry Pi" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 11 Nov 2025 at 10:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The datasheet doesn't explicitly say that TXFR_LEN has to be word
> aligned but the fact there is a DMA_D_WIDTH flag to select between 32
> bit and 128 bit strongly implies that is how it works. The downstream
> rpi kernel also goes to efforts to not write sub-4 byte lengths so
> lets:
>
>   - fail when mis-programmed and report GUEST_ERROR
>   - catch setting D_WIDTH for 128 bit and report UNIMP
>   - add comments that the DEBUG register isn't a straight write
>
> This includes the test case from the reported bug which is of unknown
> provenience but isn't particularly novel.

The emoji in the comment seems like a bit of a flag that
it might be AI-generated :-)

I would at least clean up the comments to be more in
line with our usual style and degree of detail.

thanks
-- PMM

