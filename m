Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A741BCA5FEF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDO7J-0006GK-88; Sun, 04 Oct 2026 11:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDO73-000614-C9
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:26:58 -0400
Received: from mail-yx2-x0c.google.com ([2607:f8b0:4864:41::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDO71-00060d-L7
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:26:52 -0400
Received: by mail-yx2-x0c.google.com with SMTP id
 00721157ae682-8ab46253999so7767907b3.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 08:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791127610; cv=none;
 d=google.com; s=arc-20260327;
 b=p2+h4YsEo+MAhPSwtyxaFRMsE1P1l9FUKPX/GFAjXD37iBSCegcxhyhHtLZm0Ip7Rb
 5Avup1reM8s9V4RQ/BbLqH0qqCOWNox0dcyA7n4M9qP73JJA4BGJ5t1/sX68q8WhekRP
 LIJNx8nkko34DX5rOW80FUfdtxQa9HEo+5lJJr7JnIrB3EWWh8Wf5FnkGebz9Arn5His
 7HFGJx2jcDZLNQEQaEQd2d7Pkj0NRLnPo0ilMNm8WWUnZwnaK4j9mlZbc3N7zPJCXUMr
 0pdGmLSlKFzfUP+D0d5l2cztTFiPqhN+/MjmWBfvflsCaQxpxzPSNr9+3kgZ50GZC1ou
 qe2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pFwd6/3wkZ1BbDFLuud1O66rhIuYH7s2vLGJwpTjYyM=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=I/tEEEGPAz+k3hEoWRZ9AFwbxsYcFkposvnR99h3Y3zpGRtUV0bgTZ2DUqyktUJ4Q9
 KtLyJXtJKZFAfJGPG+y+04WJFfdU5BGKWlp+jP7YEnPZ5kOQH+eg04l5eY7SHWZetjq/
 PcBHH0flosJhdqu20+pWg+ciL176Hh/9/43KVMUZKzqYfZBJSqpYIYoWLo42BVXbi0NL
 sPVxGtFnCiMO4Dp9iRVq+vjX1y9X/eH5aSOu7aEqD+lbjbIG/BN5tMI/IjfWD1SyccPw
 9UH6jqCahw4YzivFV2DhjxmiUnXLyvWgeqUcpat7d1X5PzOxS7qIAg9pScpaF5d7iNsO
 DpnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791127610; x=1791732410; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pFwd6/3wkZ1BbDFLuud1O66rhIuYH7s2vLGJwpTjYyM=;
 b=myeGxWt+3cckGT8gVJQ1ITczbJGPM/koNK8T9H8UF23joFkuwftKFDsNJb7dmrhkkW
 /xPw9YPK49sEeVlMtbqG7ZAyYxZxIHVlzchMY92FfzSbBVtjruAjk6KXQvmF/d/JTVRr
 h4mTOwpBu0HLMogrV0zhG+tpMhSWectSCTwPpzMuWQco41kydkmSohg2LRjX3irtp04k
 Rgxg26Yv8hLQxg+1vDhLpk9nI9KDSnkQGjT1YEOHZ8DnUfYqEX6VuDpmz4P6KDJzdS+e
 5YU/n5gyXT1fyrqnKfuPSdSblTTwUCg7WYkGcymhebJaGjY9of6wONdfoXvmKav/0cbh
 PWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791127610; x=1791732410;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pFwd6/3wkZ1BbDFLuud1O66rhIuYH7s2vLGJwpTjYyM=;
 b=wpw2zltce02Zop1IuCDqa1hgjrWoCWWNYSMwNKW34Q6yqIN171Hjd11bXhAVt5Gsuo
 jgy7qwSLZ+gTBGBjy2IjMa0WrwBJEB2iH4nOGEdnlQaugROFbREG5A6KFjddpsVHWQ/2
 j61Kj2KlRZY8QHKZKT8kqhcdD9GhAcWGyhpgS6HBLi79TM7kbcB2FTO9hfjesHFSiP/l
 52iL0QHmw1GVaje7iHczqXaX+YtCBdW29ErNaEDQtzGvqBWmU1Xnadcrvmg/dYpj6/FH
 2onXusLOFltXInoWD8jSa6nvmYigulKt6uMabjNhwGOHF9nMrA1Cgj2nSINm4gXKzvtI
 brRA==
X-Gm-Message-State: AFq9FYKfuq+EngOGQDwrdXq7c/GFWWOd8rgch9uiBbxTYSep+3oLJecJ
 VB0XcrWaFpBBBNZwCj/6gwXO7WABn+xMOfqIshqZa2dX/8Iz3aPMpKlzNNnwvYj9kC94fBYGNAw
 3NErIOBvvCjx+gfya8zQBXhhQ/Awx4ktNDhbx
X-Gm-Gg: AYBFou1OQJKTVNatBTQ26SuuP0Mkf9YiRW/FwMzL4wBU6USMhZRKDeD37BOa4FDL+U6
 wXuA+biWFvtpbC0wmdi7x6QKDt8vUC1ct10RYI9NAQr/qzT0asGE/j2zvwX2VoKnYjUmKJaU4Kg
 wTVehADvXSvuX4C/VLqUye/iw9ZmgbnO/iCpQS0lT8mh+C/ur/zR1Dcwfnox+rXbOvFiC8seMLz
 5vty2K78n44HhGXqO7yqvZs+UDxqgljh5v7UYux50rKdMXuAxzSNOpUmz7gxz8Abr2jwfmh34ca
 KiWnhLqcL5Q/x1eX3q+IPq5WAR48rHlllKCD42/6Oz5p2jE9TP/sY9A9s4fPp5HzWb3aKzakEGA
 RA1uv1ZPIkm6VMSwd
X-Received: by 2002:a05:690c:348a:b0:8a8:889d:2db with SMTP id
 00721157ae682-8ae39bc50f7mr32695957b3.34.1791127610516; Sun, 04 Oct 2026
 08:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-6-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-6-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 4 Oct 2026 23:26:38 +0800
X-Gm-Features: AclHuK-GIluIy7PXKC77O1q0cy8hQUecFfpIKLVNLkywXTFoWEmM1kyXfczi_Y0
Message-ID: <CAEUhbmX8X9z_kHL2QaH9SLvauTYKOmmrDs5wLjjjRvCEeANkeA@mail.gmail.com>
Subject: Re: [PATCH v2 05/30] docs, tests/functional: Drop redundant CLI
 arguments in imx8m*-evk invocations
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::c;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun, Oct 4, 2026 at 8:36=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Both boards provide defaults matching real hardware. No need to ask
> users to repeat these. Also, remove these redundant arguments from the
> functional tests such that the defaults get tested.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  docs/system/arm/imx8m.rst                   | 2 +-
>  tests/functional/aarch64/test_imx8mm_evk.py | 4 +---
>  tests/functional/aarch64/test_imx8mp_evk.py | 4 +---
>  3 files changed, 3 insertions(+), 7 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

