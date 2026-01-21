Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11376C4450D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 12:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viXBL-0006nc-7O; Wed, 21 Jan 2026 07:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viXBD-0006bL-C5
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:19:23 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viXBB-00083l-Pj
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:19:23 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-79028cb7f92so54405787b3.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 04:19:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768997958; cv=none;
 d=google.com; s=arc-20240605;
 b=cq54HxQuCYXyCP2Kh2jMmc+guLMGj6BtOCTlMXPxnGpTV32aIufRciHIdCQhKY3mUr
 NPjgBGDTlI8vEKN9UIOpDxRRXu9hhQzwIgD611IZIvXABNWCzyb0dj+fPeQ+Aur2/2sX
 rPi5qkd5c6cu0bKTskSBv8VRj4yF+FkbIn2bRVzsB3povbSiGPa9FhcQHi/iW+QVNLtt
 104/wZaoC0GwBVKJSSK6AafZ8jGIvKealuwJm7XxaeTxJIl/dEzioO9stUiqg72fIaSU
 6jZaXEoIXP2UPgIf68A3o8p7a8HTueaZKtIXS7jNXw57i1szTBZFP4KtXVrZ3pi27xXd
 5peQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rwKudhattcDNX64qLHnU3YBSiYoKLw0335vDY7IZh8U=;
 fh=h5XwtwbFZRZ1FUOtZRgdKZteGKilXmRo+GqhpTRH7tM=;
 b=jaTHj6wru+6VR1lQGBNmazWpaYynVDIkdFTQ0fcKmpDk02XJB0DLJEfIo2oOW3qu0M
 6eCIJ9MN2DnnQDTeNLOUAfQYa4sl4XOenWdZCMlMuCOsmhNVEj8c9MSepNsiIDnT4a+V
 0ZO0DQu5NvzdngahHaGaZ4hiWa0lcyg0E5EhsMrV8u3e22wisiEV9URwuzRvYYqwEqDZ
 1ZAa7+JBetv+HK1irgOOvuhe76QAp0D3R2WFnXOulvDa1PoFhl3qfFr7MniQe8shBnav
 S7NUKL/t4lS5zRgl1wlfR3opHQk5zupoGRDH/VEryMwRuV46hRlWKGS4vGg1YesS5zOh
 bxXQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768997958; x=1769602758; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rwKudhattcDNX64qLHnU3YBSiYoKLw0335vDY7IZh8U=;
 b=eL0N3lZQtaDxXtyYvmCcL9ycqHD6rBVhAwmQT29ArNtEBPZkWeAb5S1IDNAvDicelN
 qKj75Hp/hnhxKJWysQldR6mHkYJlWkDANpSC8S6GXNCPwRQXRX794y4MmVX3bdzcFUXq
 p4H7Nxuc36CKxyBe+hf0c1FtNtVOic9rj/xMxKxGcAmAd4T8anI9AQ3ZhNfJHrtN4/t9
 CQha2VBTwKBdIUYdQiocG1CdSl+1ZpK5YOI7jApIoHmbhBUl5wgZ/Ax1rQSBxZ+WFE+0
 KP7yFCtQdVScmHSIu4dYZB/ACT89SkqWxyq5oD1D9H7D1Ex90sOZAUDQTWZuHOvR1qTG
 a8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768997958; x=1769602758;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwKudhattcDNX64qLHnU3YBSiYoKLw0335vDY7IZh8U=;
 b=Vh/y3yJI9XSrc7Iyf9UY5AdWzadCNI8KNTw9/srsrAVHLkYtoHCD5qcZAWfr2vtygk
 /5iO+xBZJi5QhK4geTVnTmA1tMIEEiKvcRM4qIiQSgh69ycBciICGQre9b3hDC3BvaKK
 2AtKygWeYs07iy7/oeeNd7Lpe7/afClXcn8VGN1+YuFCp2+SBIorC9a64dYxZImsPQK9
 sGjEvxooGfOTr7AUwErI5U9+V1PJ+bWIjcMOniG9ETyknL4/BggaWXgi6I0JscH/cBrG
 je7DRaU1cx33k+qVAwQsuQFkexBU6qP+2e0n2qjpXjVZ9XtNQXOSzMWE09/lA3liY5WT
 QIJQ==
X-Gm-Message-State: AOJu0YxZRT1Xr3jXc04cWqxr4qDGJojDWDSyAEvaICie39BJR+LJ7UGH
 EmoyPohY62HX1n7nzJlnfFMWuwFDfq/q5E5VcdyRkGbYaE83fdCBG27z6j81V135vMSOx+/ccVc
 /WYCqAMDKR3dVBIoFboshEmYejMJX4NB+yx6YJSsdjw==
X-Gm-Gg: AZuq6aKMaBfP0UzqtOXIhG2d/O2ZarVBnjAOGTgi9xY8Ul2oha17DhCvT+YW+axKjwH
 jOKFOftev7unaR9HCuoAWVTAfqOxCk4Fo4EAoWZnI9gUUv5jh6YOs8Th8ZWi/W+VB/Ony6rOb+k
 FDRQGekmO4XhYjLCIAERak5bRbjwPGi5x5BIUuOoVms+kAeRbtfDLM9eJ3bjNBI7hfIF63ZTEaX
 CiNZ73O7N/RqhWeey22jEC0FCsMH3zt+9wmh5R/s511mFfHpNQhytFVDmhkD35jzW2Zud4w6Fyd
 Fs36
X-Received: by 2002:a05:690c:c511:b0:794:216b:d0d9 with SMTP id
 00721157ae682-794216bd7b2mr6730557b3.67.1768997958170; Wed, 21 Jan 2026
 04:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-5-mohamed@unpredictable.fr>
 <CAFEAcA-3P6i_w3b7SaFTn4Zmwnot5vpDs89y+zpjcJ=-mEnP5w@mail.gmail.com>
 <8158CEFE-8EA2-40A4-970E-01B30BACC019@unpredictable.fr>
 <CAFEAcA9JC1HRboZ=722dsT7a4nDQNF_ECjLK+z84T5MJisfppg@mail.gmail.com>
 <2FD2C3C6-8FBA-4833-B890-5E81637BE7EE@unpredictable.fr>
 <CAFEAcA-MAsQpaaUx0dJHRHjUJ6bEWwnf58VZN965Npmi7_kHXQ@mail.gmail.com>
 <FF6F91A9-9A09-48B1-8857-FF213C9A4644@unpredictable.fr>
In-Reply-To: <FF6F91A9-9A09-48B1-8857-FF213C9A4644@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Jan 2026 12:19:06 +0000
X-Gm-Features: AZwV_QgTuDx4byO6bnZnRe-P6azQ6W87MYvn-4-JiCvrmH45roX39mHRSwLQR5c
Message-ID: <CAFEAcA9FMiNZXgRP8OZgvAyPJXfBphXXs4eB1kBZtDgqYDTYUQ@mail.gmail.com>
Subject: Re: [PATCH v16 04/26] hw/arm: virt: add GICv2m for the case when ITS
 is not available
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Wed, 21 Jan 2026 at 12:00, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
>
>
> > On 21. Jan 2026, at 12:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > which I think means we do need
> > the its option to be an on/off/auto one
>
> Hello,
>
> Would this be ok instead?
>
> typedef enum VirtMSIControllerType {
> VIRT_MSI_CTRL_NONE,
> /* This value is overriden at runtime.*/
> VIRT_MSI_CTRL_AUTO,
> /* Legacy option: its=off provides a GICv2m when using GICv2.*/
> VIRT_MSI_LEGACY_OPT_ITS_OFF,
> VIRT_MSI_CTRL_GICV2M,
> VIRT_MSI_CTRL_ITS,
> } VirtMSIControllerType;
>
> Combined with:
>
> static void finalize_msi_controller(VirtMachineState *vms)
> {
> if (vms->msi_controller == VIRT_MSI_LEGACY_OPT_ITS_OFF) {
> if (vms->gic_version == 2) {
> vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
> }
> else {
> vms->msi_controller = VIRT_MSI_CTRL_NONE;
> }
> }

Is this with the idea that the its option get/set
functions would set msi_controller (to ITS_OFF or ITS) ?

thanks
-- PMM

