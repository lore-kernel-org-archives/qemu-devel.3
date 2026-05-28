Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5006CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 07:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVPQ-00045x-6V; Thu, 28 May 2026 03:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSVPO-00045e-7w
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wSVPL-0004gY-VT
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779954238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3UcPDLLQ99zXvr4ktWmu0D9rhvK4CL1wQTsu8XUwKnc=;
 b=eBKoseFTTEDy/EMSxCiKtGX/KguCH6hxKgYu0RmSuOiznoCDcwiAM18JGdUkNglbLtcuWI
 yOQZSuMgssJGDArDP0JgOiK3JReTT3fQ581YGa2SSNkPNQHHOJBFItBk9IvIJVwGv77lVs
 bc64WBXX6CGvCWgOUaL0Drmmh3tF12Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-9gs9TddpM0GuCUb24Szw3A-1; Thu, 28 May 2026 03:43:56 -0400
X-MC-Unique: 9gs9TddpM0GuCUb24Szw3A-1
X-Mimecast-MFC-AGG-ID: 9gs9TddpM0GuCUb24Szw3A_1779954235
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45ea38c03a1so6199530f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 00:43:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779954235; cv=none;
 d=google.com; s=arc-20240605;
 b=Tb3gMwzyoez3CxAL9PHvB3WRqfOslTBYOXBSUTVq3elZiUzmGi8Im0uuzShbbqF4dq
 xSWjF8LJyO7hiDyW1MoeIRlba7BUmK1zI38AjF3QMkmRaSyL5tZG8bmo7sv2hN2maPH9
 YtwSOviQ0pl2G8TmI+FPQjYulia1yq/GsKUIiOtHBsYs6B+//ss1rmHEtwh5wmxALx2u
 5dzE2quJPVrYVXgstkT31iRvkbMFFJ63jKVlJF3CLczBveu73kNRe7HdNMhIDC4nvDYN
 8XZmaOsX3H5tv1mqUHgp8uvOlPypf4xzG8Zh9yrb2YShmBDXE1UWrqyWzsU29+4p+iNo
 aVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3UcPDLLQ99zXvr4ktWmu0D9rhvK4CL1wQTsu8XUwKnc=;
 fh=6K2sY+SlxSE6OKh1MHadelO6kgdiwfYuR84eDMNoMng=;
 b=g0NSrMq4MWa80WtSUQAmxUNJZkuqfTHlwwrZNEvfmCYM/SAdskFzbU16RYMV64QcDY
 oRDH3Lb/vn3NdT6o7jbeNk1kU188HYrYecDH7RQdEA5RzYoIygJnK4CqT2e6Bzg7ShBF
 2LosLQLKHXFbbF5632O13RBMtGNh6BYFnm3SDCyneDcNF9amcv/75GDORuuCehuC0vEX
 1FmIReS42tNDFEaf1/nDa3pTB/an4g7qI1nzOoM9p1PiMnXIE++Ia848Vg9CK31+iQPn
 A7pVqw3sXTAuHFte/KWO9DMNsT4AFZINRNJJ6INoktA61gFZVq8zPhsLloBwK0dbRY0M
 DW8g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779954235; x=1780559035; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UcPDLLQ99zXvr4ktWmu0D9rhvK4CL1wQTsu8XUwKnc=;
 b=XKuGSJGOW7Q6+Z/jzria5FE2UHMYZNntsEMS6MBsREwxQE2Q95jxAxbhKa1C2NOZE3
 5spXaozOcWOMI+93Emen9+tFc0BNeJUnTeYemOc5kWD0DxmrajxzLPeTV3Jq+nYPCkTC
 jX7zC2u4FR3t7k4B18ftIZzElRMABb6Zmseyzy+TPUf3uT41aaSY7/PHdUIa3iZ00SyZ
 7jB6pvH++lM+elG+LfI/2d9bg0UhQEEbZou9O71GS9EUf6Qs5v7wnGk919F8ESj8e3bK
 1EeKnyWYbGQzG9NZkwig4WiyIQec7hOvwYdL0c0lci67/eS3+hdNHA3GGzsPefo7Onge
 qy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779954235; x=1780559035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3UcPDLLQ99zXvr4ktWmu0D9rhvK4CL1wQTsu8XUwKnc=;
 b=hVPez5Q2S4cTRCDK6agJmO+K5ffIM9MqfoBKvfNwEMXLFO9J0gtZ3O/FHROqwaCa+d
 D8BPNX4lTow4Al3jUdMeU+o1btlM1Wdg153hZhLWXtgrSjddbDCFLbxsoc6ETCFVviX2
 BwcYAlBO81PXDJT3zaYq9CxoCGiG9IXa4Gh1LiSnVqdV+yR66PYyyB8lDkxg1DIcEfs/
 GVpOu1JWEXmKJJo+fuEaAqzRy4KZYSVpTEy7LQ/cdFPpxud0ySKyPFB6qqrCuCTmBG59
 4qnMV9ghq+R3A2UMcZuffKJWGV/HQWabl31ad0lMKsaWHsRH84Yj2T6az5RxcurAVEN4
 wVMw==
X-Gm-Message-State: AOJu0YzSnYphoHM1rlOT/hSueOtucI9RAXHnTgrQWnE3ns86ZXbDgLw9
 Gf3YQYQ0V4smkOwsbZTAelRj5cgP61Jxp//5YRcO2eJZSiZ1o3QPkf4hTqzpJXI6rtzqKbg+yQL
 BRw4+mOg5qbU5JUncoeTTZ+KEWKyJ/ZXeIod4N2lENJmfGAJD2imOyopW+ClODhoib85sepgb2F
 5RrqUomzLug5t1COiFqSJ9I/VyD74UAqA=
X-Gm-Gg: Acq92OFzFL3drWMmWD7drJbVy89/AYiVVk3zvTQm1CwjJYVrx5KQTBm/8uPFLmZXYqW
 oiFPNn+jP/J7bUJZkEUMKDH6snFmMqhgJpdwnuKAuZWTzb0pXriU1Mey8o3G8QCcXloaacDphUr
 Kv6mwlKZQ2EH/XDjDkrDTU9lMy7mRk6gA5mHADEXjArl/jFo1zbWJQjKw1tw3KLTqzlFFpGjqH2
 lA0Q6Uk+9deO4hYMkaqHoHYwx7q/22ZkMjxWAXApalCj90=
X-Received: by 2002:a5d:5f54:0:b0:45e:73a5:e1ed with SMTP id
 ffacd0b85a97d-45eb36adb4dmr46346821f8f.27.1779954228061; 
 Thu, 28 May 2026 00:43:48 -0700 (PDT)
X-Received: by 2002:a5d:5f54:0:b0:45e:73a5:e1ed with SMTP id
 ffacd0b85a97d-45eb36adb4dmr46346764f8f.27.1779954227326; Thu, 28 May 2026
 00:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260528073412.551117-1-pbonzini@redhat.com>
 <6574cb8f-250b-403a-be99-c116a6814075@linaro.org>
In-Reply-To: <6574cb8f-250b-403a-be99-c116a6814075@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 May 2026 09:43:24 +0200
X-Gm-Features: AVHnY4IW-CbP3d4kVp7It8Q4k3h23azKDWKUlS-gD7LBkM26sgCCF_iUcGYiCkc
Message-ID: <CABgObfZWHx9qK-mEQ=2xeJWcyKzKE34VHDsAu-q0TSn=RbATtw@mail.gmail.com>
Subject: Re: [PATCH] docs/devel: relax policy on AI-generated contributions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 Paolo Bonzini <bonzini@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 28, 2026 at 9:40=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
> > Revise the policy to permit AI assistance where the ramifications of
> > copyright violations are at least easy to revert and unlikely to spread=
:
> > tests, documentation,
>
> Here you mention documentation, ...
>
> > +**Mechanical changes**
> > +**Small bug fixes**
> > +**Tests**
>
> ... however it is not listed in the "limited set of scenarios"

Good point! Any suggestions for the wording are welcome.

Paolo


