Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4895ACA5FF0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDOWg-0003yC-GS; Sun, 04 Oct 2026 11:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOWe-0003xY-2m
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:53:20 -0400
Received: from mail-yx2-x2b.google.com ([2607:f8b0:4864:41::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOWc-0007uL-9n
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:53:19 -0400
Received: by mail-yx2-x2b.google.com with SMTP id
 956f58d0204a3-6755aad8a98so390364d50.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 08:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791129197; cv=none;
 d=google.com; s=arc-20260327;
 b=V9dTRj2WhDNY+ltyASzH/XPE4yd57SWoy7LSY5XP5eGV9ctF34sbc2FoZoProSP5BC
 d6xluy+MY2frLUayqJC2GNYt75UY8I0fPnV1+T71KhCuQYWE0CKsviwa3GEqINiZ4QQ/
 Ux2EIaB5GN2qcj598UDvt/X0GuLg2GTZGdJYErwe77oyKjlnkBjrYZ0u8OgC5RKJ+1ub
 SE3nPTKZj/ZG6W1PxRZvAsFbdFxI3rJ+fQshGJngRIByBXcNCYVAhEsVYI/baW5o1vfG
 o4G0rwxS8EPIaQOppLqb6qKP9EMo4xSCDyAUmSyfs8+P+W2otlEUwB+1ieL5mo/75cV4
 e/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PTbsI1qKOCs+tvm4+n4Z61evdmFzD0GBdyy20o/81ms=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=GDwgqqEif0Ky+T0qSFP9Yn+vsD1Hr6BvrpZMqgppH2JLl6GB3GJqyQxENaFc6PigYl
 nabZgyInVhR2XnUq6OAn/OOYM2x4xhFBY5/dagrYl6NfeofW5xTik5/ukIeFlLcqqFaq
 AZ6IK/IO+7+KMUAciQh7g0UmP+lWGMXojkM88ef+Uc7/ue3dHN3l75XVJobmbxKiKyzq
 XVkjvX1VI6xNQzLxhqI+5XmHzs9iJhwA8DtePcyDWgRJIBJM5gxkd9v6zgfxN5OLvulu
 tU6jrG9AzleEv/x5W3UwVbmQHi6CseDDh27Ip+nDzJ5qCBsOnn/DDrmnOerRy528JjED
 b5Hg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791129197; x=1791733997; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PTbsI1qKOCs+tvm4+n4Z61evdmFzD0GBdyy20o/81ms=;
 b=pdaeJSiFtqzMWn8UBOWN1sHTzzm7q7QwSZMqetsDPhS7N1Q8IVpUg15rpmRRcXNCiN
 de/6E63LihEGnlk62dFruYZiId6Wp7AQbxuvBL6eSnK400ocvUU9KbtUPuk0YevlpQEg
 H4Z/BbKW2O+ZHKK35zBAcCsyGrr9RaviX4GAEkDwY8eej9gIsdmCUdHBapjLGvMwgq1X
 1/qaEmrTH0+JLFdQYrh2WlM6bPyyFpUS9L4f1/v4dOybD/LFpEgYzNxpNztmbE6tn9qG
 gxf8rSXQp/QsX4JJQQr5CTbSkbQS/fgVIgNqjnGzR1o1S89cZioT3oLFMegm38TvByXW
 q8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791129197; x=1791733997;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PTbsI1qKOCs+tvm4+n4Z61evdmFzD0GBdyy20o/81ms=;
 b=bFqEt2Gz2j0BBJGLmcw/SEJ+AtKwHtEMxtQ1rvBTLakXcqObYj4zdRbQV3jDD8Pv3n
 A95vw9qFsb97S98WE5umn46Ca5pdXni3hazIE9GfoCoKmGHoEt1bDfOAEd8BbslSLM9v
 74ilghO+PrTJCUvO5wbsaDQj9FbpJALs6hLyGVYmt8Uf4bFj7p2XXoMKNu9oGD4t+v1C
 nx9UUg2crIEtK5FKzvpC75+ojp7eOq8LKKmlPzCQ7XLUvkkFhNjbwjYZ7oFSFvND9DRg
 UpitUpw+URX7QRr5DxHtUT543WBbhV5szCbgbDwg1p2ct4pSGnoGKbx6eJsI+7QF5Mri
 aCEw==
X-Gm-Message-State: AFq9FYJ02TR29bVI3RfPv3PFYJS1ZHR5+MWSDFzptTfH3a2lCcwuMMS/
 aT5BdStFl50bGK6f5eD1qLI0rghetVVIo+00jXct8jBkk2/I/I1hjrYj+xwudZXMduim9mEyFno
 TysW83/2J8Tw7E6Tj1DvWSXYrNYuGhfQ=
X-Gm-Gg: AYBFou0J5nY2xgembsEVBTlz3oqHLM18aYUlEc/1l5spa9zClc/2RhWu4HxoxpwjA1D
 OqLiZD6IA+92yQZK5124XJkRI3XECprhojhwU8uJyQ1TYtg7N3dDcfJpCyYpajqcT8GGp0pF1pa
 EE0j1wj6EeiYcwkyOGZhtxYVPfZxebrsD3fAZby9mm21xZ3qDqOJvX5ahkc7eDXa8JOYpL+x5p7
 Bd7i0nkVnZAFS8CXJ7bnWNB7//gag9x56O5t06tjdP1f4esUZ0fdoBXwyhXJu+D8hM0SHfNs/FK
 vUUXvGyUW2FhnqMO6zihiwx1ONOQNpX9d7WxOKqAnetllnBCiLJhNrrz0BFexfJROBHWFwIoJ8D
 VVLWvib5ZCrT/D2M=
X-Received: by 2002:a05:690e:e89:b0:677:c18f:7257 with SMTP id
 956f58d0204a3-677c18f81f3mr1662467d50.23.1791129197013; Sun, 04 Oct 2026
 08:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-9-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-9-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 4 Oct 2026 23:53:05 +0800
X-Gm-Features: AclHuK9eGoJpGs441HvzALMbxy6ASo44jiUDRsSijICZZEnNwYUkk5jU8DNWW38
Message-ID: <CAEUhbmVOa01Y9m17oUSntnKF5PnAudhP3Zh7YE0OxCLE5QQDSw@mail.gmail.com>
Subject: Re: [PATCH v2 08/30] hw/arm/mcimx6ul-evk: Have 512 MiB of RAM by
 default
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
Received-SPF: pass client-ip=2607:f8b0:4864:41::2b;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x2b.google.com
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

On Sun, Oct 4, 2026 at 8:29=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Having 512 MiB of RAM matches real hardware. Fix the machine
> default to make its use more ergonomic and less error-prone.
>
> To reproduce the old default behavior for e.g. migration purposes,
> `-m 128M` needs to be added to the command line.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/mcimx6ul-evk.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

