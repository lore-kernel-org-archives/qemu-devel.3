Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B56C25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 17:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7evZ-0005Yx-EM; Thu, 16 May 2024 13:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s7evW-0005Yk-0Q
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:29:59 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s7evU-0001ny-CS
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:29:57 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5210684cee6so1496577e87.0
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715880594; x=1716485394; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eturuhnXXopcjfJ4vRMfHyLVpREedj7ePMj3+8z02x0=;
 b=h+UmGsAe6smkDlPcdnHzWpk8u8m1y8HfRv66M5I7Uc6omLABNYrdYmrkqx+cCFVD5O
 gjtPJ6WMgSSCgZzDyi7c85q2XOsLw59B0L+MgRbX6QgSn+zcmqOdy8OqjZvqMCi9WBec
 EElmlQ3xEDtxElmaYdBlKIT7uQdw07GRAwWLgmh+pjSSmTrr4t0iGF4rodIbDeWTZFS9
 5c0CKfJRLr/TPPDOZrZUdOUonrbn0oOV02p6reSZa1q6KEz2DH/8sCJLCkwyaAXuOoHi
 fVngstNWpIFCvyuMrKJaPSNoJauKPf4yZmKA/FonkGuSeFtsl+q61a2pa4bKVgX6HS6s
 VRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715880594; x=1716485394;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eturuhnXXopcjfJ4vRMfHyLVpREedj7ePMj3+8z02x0=;
 b=SQ+ImGDkaFivKfF2w5ix8cWo1v8GA+AKYzxjd3WOGSo+1nOLYV1eN0lDdkJIQqVbDo
 LY4gBxrSgvjI/bfZXWw7o/UW3RftK9njey3Qfa/7nQBbjq7+HKlVxRfKW1HavhtyApl0
 +xUogCOEyCPoPlhrQxc7SU+lmq+t0vLcaM4dJNUHJdQRWSpI60lOikrRPFJNYdqIGNeh
 kXe0Ne39m+9kZecR22nPImEriqN3SxQYU+rFv9rnLtHWebsgxtCVyNE1LdAen1WB23/9
 5c+krPM1byuz/IOa/EOkrVjeV9+di+cRi3QiDS9ceLrTM9L8pYYXFeyLO9wD1cyuFb+W
 PdmQ==
X-Gm-Message-State: AOJu0YwwBtldLM7zbD5bgyqdFjiWW7aq9JuyjKtJdxav4iahB59lor/g
 Z3CfOLJLwXlIHi3XjAZZkyNOWVLhSFuTfY+h1Qd/z2Usdup3Ior4/XsO4AqAB+lYD9c3Taw8cUM
 nPoKmvaO5ze9NtnbS6znkrxxCeXhbjXt+M6s/DA==
X-Google-Smtp-Source: AGHT+IEZiTYwi6MPVMJPMy8YzP0DsVjdbcl2r7F+Hs4LPdElre3l0CbxcD1RHZe7bw5xKdph7jSpMnZsEHYheOJ1D5o=
X-Received: by 2002:a05:6512:39d3:b0:51c:5087:909f with SMTP id
 2adb3069b0e04-5220fa71af9mr16776527e87.10.1715880594164; Thu, 16 May 2024
 10:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240516162230.937047-1-berrange@redhat.com>
 <20240516162230.937047-2-berrange@redhat.com>
In-Reply-To: <20240516162230.937047-2-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 May 2024 18:29:39 +0100
Message-ID: <CAFEAcA9ocOiZ5E0WSCKoR3nL+qf4LF-AQ6_4HpF9xfipAJhbog@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] docs: introduce dedicated page about code
 provenance / sign-off
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

On Thu, 16 May 2024 at 17:22, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Currently we have a short paragraph saying that patches must include
> a Signed-off-by line, and merely link to the kernel documentation.
> The linked kernel docs have a lot of content beyond the part about
> sign-off an thus are misleading/distracting to QEMU contributors.

Thanks for this -- I've felt for ages that it was a bit awkward
that we didn't have a good place to link people to for the fuller
explanation of this.

> This introduces a dedicated 'code-provenance' page in QEMU talking
> about why we require sign-off, explaining the other tags we commonly
> use, and what to do in some edge cases.

The version of the kernel SubmittingPatches we used to link to
includes the text "sorry, no pseudonyms or anonymous contributions".
This new documentation doesn't say anything either way about
our approach to pseudonyms. I think we should probably say
something, but I don't know if we have an in-practice consensus
there, so maybe we should approach that as a separate change on
top of this patch.

So for this patch:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

