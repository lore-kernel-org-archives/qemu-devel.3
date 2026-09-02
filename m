Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460C8C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ktZ-0006Z6-BE; Wed, 02 Sep 2026 09:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1ktW-0006Xy-3G
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:20:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1ktT-00076m-5i
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 09:20:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso10826115e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788355244; x=1788960044; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C+WdB3sH0pKz8efta5NVNWLlShVKyzTvfELYT2zM3J4=;
 b=FCKKqnHZpnCjsxQZUnWZVWeVcGPsJvIihUld/x4tw70UtsGNTJvtoz5+RVcWO0SmGp
 srW0xdywebuvn7mbJHi/ToUcn1WCrRa58mKavyPLnd4lrSXNcI4BMEkyFMed4PxTU/gZ
 IZ/zLBJgRKGQBU3tmnJYjrUYYcmJLvvYGhxQ6OAe0SCJ+snAPvH26SVLPrVduAD60T+P
 7XxHQ4QvRtqe0hymOIWQ/ddp2cnFw6xUgj9+eh6rhqtPCk/ZS3Rt57AGHmpe6ag/kwh/
 KaytBuJPQQaB5841eOq7aVL8aFh5o8vmfRArWdr2Xu6zFfNmQI2QuEHuVNMhU+CiQoiK
 tzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788355244; x=1788960044;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C+WdB3sH0pKz8efta5NVNWLlShVKyzTvfELYT2zM3J4=;
 b=gAOSxUGFIN3FKJ+NUp1H/s5cTyrOOivDgcDXFidjWbDpFZpKd+aT14R8xr8Qo9hEWy
 p9DfNvZgbW/2YVeYbKr961qmvR4TY9ufalXNCz9FVsO0mruHFGlbEdok7PnzVXCfIhDj
 kv0uKBenbUOon907h5CbiGE/hU0UE13LcDaBKY+TWG+cKsBp95EnZgjyOBGSXcIjFpEG
 ClCXeriQx70sOk7Qm0s5WBRkrTc8uoapwgKDxy8g0XljTJiKrGfWtvzm7FBhc21oIo81
 cxKzp7/WyDPz4m7fhGqEk8dzxdAQyu4/9St6fLVyQ/73mk+MWjYXvg63mHB0DPYfrPVK
 kkOQ==
X-Gm-Message-State: AFuF++lAFJ5X7StNsrGQrzCv58ri92nPadc5zbEks7qasTqDoW9c5he/
 Pa1BQWchHmV3Haf6rJxnpvVhy6ZUTSlwCZyvHNpxflyF6TGWIrdGJt9OUvwYZckCaO8=
X-Gm-Gg: AR+sD1175X3DlPKIzubUUcgRNtb0BQx5laP3HE18hlSpk3w2Taj9MK5VAhQ2VqKqMBu
 v4789Rc3C5I7K3Q3Du8GJ0pkQpS0Hcj2CI4w6XdShHXV3O+2N5etagPwuZwLvhoq7fO6yLpzKmW
 EYVGbMlkoDRofPUPi5E7V16Orbu6fFGE4JaSM5j6gVy2de6hCEXsgr28bPcsq79KygEkQKS2pgr
 S65VRqe60RAJu0XBb8B+Cpq73fRBZPpOXLdM3NiuoZRO7Azq8Yo8+CtsEG/xbo2mG6O1n4v2Ws6
 1XKpotKNxl+G6q1TQCy0HxHcuW/b/jWSniujNw7wAPV1fBYNEZYLpk5LGubqExqlHmfGr+z7yjr
 0LitiLw57vuflPz0kcZewdZcQOJyyVGJEodm0R9UoyZFhucCRg3HDDpzquaIqfJWViiLbeA8SPO
 Ff50jjHw1Ob/kUDnoMVprLT36RJqqVYUIlyn+DwkWpkaW8nAhLd/uOnqEhyBWC
X-Received: by 2002:a05:600c:8b4c:b0:49c:edd2:855 with SMTP id
 5b1f17b1804b1-49cedd20930mr10135665e9.6.1788355244336; 
 Wed, 02 Sep 2026 06:20:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce4642382sm75057215e9.3.2026.09.02.06.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 06:20:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 391DE5F85F;
 Wed, 02 Sep 2026 14:20:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH RFC v2 00/30] arm: add Raspberry Pi Pico/RP2040 machine
In-Reply-To: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr> (Gilles
 Grimaud's message of "Sun, 30 Aug 2026 01:42:34 +0200")
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Wed, 02 Sep 2026 14:20:42 +0100
Message-ID: <87ik4nrdqt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Gilles Grimaud <gilles.grimaud@univ-lille.fr> writes:

> From: gilles grimaud <gilles.grimaud@univ-lille.fr>
>
> This RFC adds a Raspberry Pi Pico / RP2040 machine to QEMU.
>
> The work continues the RP2040/Pico RFC posted by Alex Bennee in 2022:
>
>   https://patchew.org/QEMU/20220110175104.2908956-1-alex.bennee%40linaro.=
org/
>
> The target is intended primarily for debugging bare-metal Pico firmware a=
nd
> for running firmware tests in CI without physical hardware.  It provides a
> functional, test-oriented model rather than a cycle-accurate RP2040 model.
>
> The machine supports two boot paths.  The default synthetic ROM implements
> the RP2040 boot protocol and selected ROM service tables, with optional
> QEMU-accelerated helpers for firmware testing.  Alternatively, users may
> supply an RP2040 mask ROM image with -bios to exercise the modeled hardwa=
re
> path.  QEMU does not ship that image, and USB BOOTSEL mass storage is not
> currently supported.

I've finished my first pass through, I'll re-review once you post v3.
However some general points:

  - checkpatch everything
  - format commit messages
  - reduce duplication
  - ensure only one architectural features being modified per patch=20

I've also included our experimental AI reviewer so takes it's
suggestions with a pinch of salt:

  https://patchpilot.linaro.org/run/b132da76b734#stage=3Dreview

but it might be worth a read through none the less.

>
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

