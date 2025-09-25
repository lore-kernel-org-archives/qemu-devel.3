Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DA8CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1isv-0002LN-Nv; Thu, 25 Sep 2025 06:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1ist-0002L7-RX
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:07:31 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1iso-0006LR-Q7
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:07:29 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-ea5b96d2488so701309276.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758794835; x=1759399635; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bBW0W4jDecwbVj0eUTGQG8EAOWaAGuY6Z4bEYTphbjE=;
 b=sgQoFF76Ig6/iJmi6Y42mqYfwBTQb7T7EtROT77y50zp4OlMgfpP/OxxPq9iw7L6aV
 hv5zZ2Jq+hR3jefJOs4LjoHTxzkaTWt/2mnWk4EVVCOu72daoraI+j/YfijVnUmXL07Z
 89b+V6Je1vG85TQLRS5nVdU1rbyM0hHjQWGOYvKaJ78Vu4jrUHnq4hh3gIbqfbj5Lhhr
 pVKmGf7on3XGt/3Yhj410vPr7wydYJZShHfGfLSFXrW0A7H39s6QWPBfMKfwpRkurLh2
 ojPooLkVxJdzFMtuAdYe0CfoOs29Dfb5af5Mu78wPjh7nGFqBKSIzFTA5XaddJ6gZTyX
 7gNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758794835; x=1759399635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bBW0W4jDecwbVj0eUTGQG8EAOWaAGuY6Z4bEYTphbjE=;
 b=pDeUoda2kjcC6ICyhyZ8IavJKprC29WBw8qSzNfUJTect/1VqyPPeGvtjdWQrmONbY
 8N7ysPObCjlvpC8jzzKd4DxJbPiVCNE4/rL+9DVaKeWJsUORJs1DgASiB5vlPNx2RtVy
 IeB6Dgv+HH//M2SuoXe84mFH19KDiR2sZPhCy3rndNEtJV5pNQVhHg/UL/DAAY3fkdsV
 2PsyAAscXGBzuj/opyiHKBgDCUGxgU0IOg5NeLgx0EKiOjvYdS/9sV8gFhTIHZxmdMDP
 bEwiaiTomh3MJNJUNlkGLKEjH98x0eqaX10UZChvknxCHZZ+Zy2wA4t6ZVKJHSIxYFWk
 QRLQ==
X-Gm-Message-State: AOJu0YzVZ9XN+1c1FNPqAp5TOK1hfajbO0kOqL8eJQOv6cJLnzjZT7s7
 /5WOH0uwagGsBfnr7Hd19LdoBrCWxjFtLNQhsfK9/v1Mb3I9nekVsA1VC+sVOLZ98VNMxeMn6Ug
 mYdykZEwJEtOiFHPgX2CXW2DorDfCbWYh0I3vs6bo9w==
X-Gm-Gg: ASbGncu8MThG3khQmn+uYXAguzsPG01eEYUgBZr8e521f0HakT1ZdXZCORX4FYKw/+k
 daSyPmu/xlyworhbLQEg6+ZdG28fzzC4ZvYSwNMwOWSoYifPvNcowKUVxBZsEz+6uJ1UGY27iUT
 DecqTESlzLue7eX6qDxXwR4BFeZ1Li5h1mlxunPaDCNMKDN9cG90Lu0Z1IjaXeFzuPZ7bRELrtm
 HayLTAh
X-Google-Smtp-Source: AGHT+IFmEIHVndkqUmlqxyEo77AFGuF3dE6QM0voeO9Gx+fVKdemN4QXWtZs/5oHGK6lURXw4Huj9EWh/WZB8ZxojTI=
X-Received: by 2002:a05:6902:2b0f:b0:eae:e225:72cb with SMTP id
 3f1490d57ef6-eb37fc872aamr2662638276.25.1758794835053; Thu, 25 Sep 2025
 03:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250915132910.1252212-1-peter.maydell@linaro.org>
 <db0c9db3-372f-429d-842d-341493204d7a@tls.msk.ru>
In-Reply-To: <db0c9db3-372f-429d-842d-341493204d7a@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 11:07:03 +0100
X-Gm-Features: AS18NWCxWhSm4WGJjUDPBJhNB4R5lVSru6YKJvFsFlwsAd2-Twv3JvrgYCnb_zE
Message-ID: <CAFEAcA9f+7=pA7ZZQkUsgNSjk-JopT20rMTrWmZy_Jp5=f6bZQ@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-uhci: don't assert for SETUP to non-0 endpoint
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Wed, 17 Sept 2025 at 15:03, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 15.09.2025 16:29, Peter Maydell wrote:
> > If the guest feeds invalid data to the UHCI controller, we
> > can assert:
> > qemu-system-x86_64: ../../hw/usb/core.c:744: usb_ep_get: Assertion `pid == USB_TOKEN_IN || pid == USB_TOKEN_OUT' failed.
> >
> > (see issue 2548 for the repro case).  This happens because the guest
> > attempts USB_TOKEN_SETUP to an endpoint other than 0, which is not
> > valid.  The controller code doesn't catch this guest error, so
> > instead we hit the assertion in the USB core code.
> >
> > Catch the case of SETUP to non-zero endpoint, and treat it as a fatal
> > error in the TD, in the same way we do for an invalid PID value in
> > the TD.
> >
> > This is the UHCI equivalent of the same bug in OHCI that we fixed in
> > commit 3c3c233677 ("hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or
> > OUT").
> >
> > This bug has been tracked as CVE-2024-8354.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2548
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

Thanks; I'll queue this via target-arm.next unless anybody
objects to that.

-- PMM

