Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEF3CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXgeZ-0007eJ-KK; Thu, 11 Jun 2026 10:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.kanavin@gmail.com>)
 id 1wXgeV-0007dv-2y
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:45:04 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.kanavin@gmail.com>)
 id 1wXgeT-0006z6-Lj
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:45:02 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-8ccd1f57b32so86378006d6.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 07:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781189100; cv=none;
 d=google.com; s=arc-20240605;
 b=T+iGWrfQEhX+4kLMSfmKR9fq5MxGdxP2M8FuCsts1VKCTNO9FUpFtBS3+FdW/P/IsR
 Rd5lOtn+yudNXujbt8hf7nFGOVWRkIB+53ZSrdFjn87Wx5Iq2UfqPAn1w+4ZOXWNxiRk
 R9h4P4nyNbJLomBMtrvY2lzCM2iyDmiUfI0y0wZyNn/4wc2CL6APOYz91XRWvT8tQtee
 AL7V5z81mv2rgkooh2TAohyMut8S52Q6/Fym9ewFItMyfU1wDSEx1uc1vFojkdbfhCIt
 JMvyB+7A/91wYzkZS0vos5kBGvxGOQWRFJP2Lz+ZfE/m6j+oPshhjPATchszifzohx6q
 C5Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vaFnOHMrhfpbN5F7uWMNmfp/QzRhcwZoalWl4szkMx8=;
 fh=jjLbwR6Ie9ezVMM2sJN0+2jpxoQWZvctPdqcKVN/6SI=;
 b=F3muFYsCc0Fw9qX+925mqo+C5keXTLai9QVWCrqDm4wOcmhXPK1dauXQZCgbqrRpET
 5kPi6O0zAGFmaojtYDaebTFCS+4/Ed/zeBwa2fR2qTarHxW9z5rPbBRw8cvOtpAGIIjt
 qDX8Jzo5/pJx+j+cMhGsqR/Sh9i3sBPT0eAGVJmFvNAR2K7qFI2ge3ug9sUnJ8nnKeWE
 dsSFlZsD9hM5W3k+A6I1Im5YfQ4ZzcZzCh2B1xDGeCOsDJdOkho4jMetbKIyGdyFP+Wf
 KU/g/Bc/pSvlI2Kn27ZUfXcVNRXyHOa8kCszkK4kZU9pw6wNyzJx7ijJ5UItuxw4V7i8
 G5tg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781189100; x=1781793900; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vaFnOHMrhfpbN5F7uWMNmfp/QzRhcwZoalWl4szkMx8=;
 b=NigjTWtvUv7VQXkdPyZp+9xNFijuvAxNNrs5u4kvs4wFmgHPG46VhE3BU9H6xMnvAy
 cme9pj+eankTiOCkpTe0edY5tfcs+kBWOaiwiz1JMBmHQ0pHVkksnHJH0u+hwbtPEfoR
 xschUIM6dY6GdD2VJLmnowtTp6fLZtKDHWsZw+0JI9r4cGiOUdcaom+PTVkn/AP+y+4l
 p9sB//rbqXiGhQF8f9OEsbdoB6saKNAfF2EItMvaQYQ66qpmWZLLlHnlEqdVsasxey48
 1OTUP2JuqkWNKTmHNvA7Pw9FjQYSK+gQN/SOOCpNaEcrihOdADrxGnWMMCjX+1k29sqL
 yHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781189100; x=1781793900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vaFnOHMrhfpbN5F7uWMNmfp/QzRhcwZoalWl4szkMx8=;
 b=OY3mlH6E8IXfEqMaGT6XTxBfLj7/rqE94kTIxbVwxixiArFU7+LEWjU6X5KYdb0wvO
 zJ3+STroHFjF+46Kc3ydwCzAOwb62+5Ru8nDtVWRjuWd8nWMehHmmvTOgBunrZ4X3Ti5
 ak2uKVk3pHjz+H5mJJnnUIOitPcSAFDwwXJqK6B8j4GUV7CVzLJ9RzK2h0YN11i/SHZF
 dR9JUHpNCNQ6/K2JqauITRfXXs2WVTYk7fhLIWQAm1K9I4VzLOpMoD8IjjY0uThVBbzk
 nB014e1HGCVLqQkca7vkOItf7qjEdbCuEWFKBfDPhHeo0t04EHp/0dSk9DBDGGfY3r4C
 j6pQ==
X-Gm-Message-State: AOJu0YyU5HIV/1P+FZ+14Ag6HpIDWNBiY+CeK5/cnOIerQRZvNfrwwbF
 97Xt/6LOEcq0eHQ7l5+6SEIKj3yZ5lwpizvBjuQlpT9t4wcHkEM+A/J8AeCXrLVwZmZWBJdP2cX
 cH8CxpQQ2x+LYNt17hK9LkR733poSJF/obA==
X-Gm-Gg: Acq92OHDdq/VTxMcSnIhj/nZjOPv95LuccbfsQ2o1Ua5a/ke9yLhzD7ZKRijBjQuiyo
 z254KckY/UoQLecQJ+UtxzjYCSE3MzC2BKRUmoEIi6d+wj99p0IRTX8S7xiPvbjh1usIRotLBm/
 G2qC8bnOVNGZk53ZNk+o8EGZ+nche+qpS9TvCydDO2l6ISWkMatmAIODIw2GhCiFdimQIC+iL2I
 9/tXkWYI/f0IRaOsTZoKQsoUP6BahorBMW9rGtLqFI8VbMIY9WpQvkNmIZrUB+c8b+BNTd2n+Gz
 feJlSdCRZtn+B+NjV0ddrNcq0B/C8RxHMaSI7wfrb/uSR7xAlsKk1wLMqvwhSA==
X-Received: by 2002:a05:6214:f24:b0:8ce:d302:f069 with SMTP id
 6a1803df08f44-8d1d7a78ad9mr48807876d6.3.1781189099996; Thu, 11 Jun 2026
 07:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260611-sdl-v1-1-93d4a51684bb@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260611-sdl-v1-1-93d4a51684bb@rsg.ci.i.u-tokyo.ac.jp>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 11 Jun 2026 16:44:48 +0200
X-Gm-Features: AVVi8CcWa2YkSwfnUuxblsN3mVrm8ciRI9QycibNWau89urBanhBUimj_n9I5Hc
Message-ID: <CANNYZj_tg=DTXW3mdUGyifCDpeLAE5YWHLCNuuwQV_Y4fUsTpQ@mail.gmail.com>
Subject: Re: [PATCH] ui/sdl2: Explicitly specify EGL platform
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Richard Purdie <richard.purdie@linuxfoundation.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 openembedded-core@lists.openembedded.org, Quan.Sun@windriver.com, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=alex.kanavin@gmail.com; helo=mail-qv1-xf2f.google.com
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

On Thu, 11 Jun 2026 at 13:58, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> Resolving the issue described in the GitLab work item also requires:
> https://github.com/libsdl-org/SDL/pull/15806

Thanks! The pull request is only towards SDL2. I believe SDL3 (via
sdl2 compat layer) isn't affected (it sets the platform correctly in
my testing). Is that right?

Alex

