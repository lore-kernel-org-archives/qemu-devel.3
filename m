Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA43CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 11:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0f0r-0008GE-0G; Mon, 22 Sep 2025 07:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v0f0d-0008D7-GA
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:47:08 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v0f0b-0005ik-Gs
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 07:47:07 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-71d71bcac45so28283367b3.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 04:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758541623; x=1759146423; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XQk3SrtoKuHYk/5T+T+vr3isHFWeopw9cLJlsffUbDA=;
 b=RiMJpR755y4Lns1YK/2M2cnEBmWlejiHZF8CKej+Z4tFrHLYsgZ50FoMR6GsiUHReH
 xPiTjC0Par24yRDTMEHZiHDkO3vFNVYKQ57D9d8YczWcFbg2g/qTD2gYPxDeBKfLu/Nq
 Mf8TI8nIrwp19gvakrD9gjKQ79XHesUP2WhHZApi71FfpBrWIRvT1zC4JfhXjgYRxKyT
 KDeCUeekWuvLN8NhdRl4nwokH20WRYlro7QKihJctqM8zdMh+2/UFJV39/m8QtEjRMAD
 8QmYnmRd1PINKtq54zwY+gZB2/i/fHf8DdWXFzXSRZB7iblaUufQfjq3u0GOl1X7dUu2
 UYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758541623; x=1759146423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XQk3SrtoKuHYk/5T+T+vr3isHFWeopw9cLJlsffUbDA=;
 b=uFvlyrcoFcUr9dUgUhL3jHEto2CELREaSlmLtCfCS+NLlATf0jl4UyF4mI+R8SohWd
 OdoQlQApBXyn6zVqrXwFMIPEx6Usy35LpL4hYA7nLjRIqeHmSFK7Q6s8bDb9jH6ZOQ0+
 u/L9r81BjGLS5BJhuo8oxfMjDpyT4COX+DnZbIl/6kF2HX0k0ecuA33BjMJeGyscP6pY
 bB4xF59ulJl3AkJYbderaMSM2WZZo2VnfTJXAYtLl/f7C7OXZ4LedUDg11Jb7SUzKaYk
 xrj4Dw6YvYfZ5zopIxRu5PaTuoY8K/BB1/aX5HfbQqT32rYwQoDI6yNiWr9FMXNx8u34
 NHrA==
X-Gm-Message-State: AOJu0Yy+rXO9j5eYfRzOELBj8cBAd8AcPI/c+3vZTiz0qCu2nThExL8B
 +oIvfx0IfYV+PcsqH5Uje2uKRXiKtXOM80UgW1HsDl7GADHikQqZkHojo19NGrd6mvDdj95p/pN
 Qqu5zw4ot8HLGIFiiEpUihpASuAOFlSkVzPu2qg+kYQ==
X-Gm-Gg: ASbGncvx/AaV/IU5yc+QUrmmF2K/7VNuIqXmf6m/g5om6HUBFNzUFAEip3ZS2r+/RQB
 nKC2Ly2AV5OnAzD/hD+hfxbkjw4uCX6ma78ICOm/3DEPj/miY7Kv/MYOoo/5tYizho+DS3caeVk
 OQq0PTM2W+207syPITmoXfOY5e4EG88IAQcyykHvlQD+nIWTMVfDM2SIDYesNs9qGZoz1dANWPB
 UWxcyZa
X-Google-Smtp-Source: AGHT+IEMBISG2IQnLEjNpCK4rrai6s3rPnaYirAfoDwMHhBTtmHmx7IKlZ2Vtnl2/wIBCSlc1Bl7zuoWLQRIG8GyXec=
X-Received: by 2002:a05:690c:f95:b0:735:7cbc:a935 with SMTP id
 00721157ae682-73d1f5a83aemr113896537b3.11.1758541622676; Mon, 22 Sep 2025
 04:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250922113219.32122-1-pbonzini@redhat.com>
 <20250922113219.32122-5-pbonzini@redhat.com>
In-Reply-To: <20250922113219.32122-5-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Sep 2025 12:46:51 +0100
X-Gm-Features: AS18NWDWBcak1EVzUQvv18Ab1PLVbavejInQa6n2WDFrOWK1j3FU5Y54TyAnKrM
Message-ID: <CAFEAcA9Vr2rxeJ0P7Yohqt2+NWQ8CmmpKsB016CoKv8RchkDDQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] docs/code-provenance: make the exception process
 feasible
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Mon, 22 Sept 2025 at 12:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> I do not think that anyone knows how to demonstrate "clarity of the
> copyright status in relation to training".

Yes; to me this is the whole driving force behind the policy.

> On the other hand, AI tools can be used as a natural language refactoring
> engine for simple tasks such as modifying all callers of a given function
> or even less simple ones such as adding Python type annotations.
> These tasks have a very low risk of introducing training material in
> the code base, and can provide noticeable time savings because they are
> easily tested and reviewed; for the lack of a better term, I will call
> these "tasks with limited or non-existing creative content".

Does anybody know how to demonstrate "limited or non-existing
creative content", which I assume is a standin here for
"not copyrightable" ?

-- PMM

