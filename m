Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FDB109C057
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 19:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5U7L-0002Fw-Ls; Wed, 25 Mar 2026 15:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5U7F-0002FU-3q
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 15:42:09 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5U7D-0005AX-NJ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 15:42:08 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64acd19e1dfso273651d50.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 12:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774467726; cv=none;
 d=google.com; s=arc-20240605;
 b=F9Kz4aijII420wIR0X0kTkJOyhe05c/WnNPXpnV3hwhyDKbwicrn5SrJj5yxZ6dUbz
 VO/kw0S8v8p9TuBrevkPIDScYqNGQFMzaBFA7m8IKPZf9tOG4yGRxzLnaSJ/A3sSoKoW
 YRAaYRemoapZh5jp+4ZgIrpxC3Gul/Nv90CVEi+nadjQx8E45wXtcR3dAxXvFnQtuFUo
 zYffQ8TfU5xTCd5SyYyWaeH+VEXRaTIj1p6AwlrZvPKl/DhORCArX3fqNDajuPjiky0C
 rK/AyIL/4zrgzU+QkFX7MgJzXJaQMDKI/v7QlrgGxOqds33UE3UF2KtxGwGfx8VrPiy0
 ugUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MTqGlKJBBRfDtCDpDOR24HEUyBOyRDO78nlNihYSrIc=;
 fh=XoT/3m2n+5Tb9qQIQk6AFhYpeFMXMsOisqFc1vSJFkE=;
 b=jFuGiDMxbtvAvNV7uzvsVctFS/2MnX8GgPG1H4r/HPlwe/gezHP20CqtRR1Sk97RiZ
 BQzdcfuUHEtGoBYVqArwa9GfvHeejHK5FXBhNg/HCTojbp3rI14fnGlItA/M/VW0VyNS
 V1qUt9AymasKGlansZwLPWehWzgm6FdL7OIf6e5ub/z50asEwkjicRChNvvtIPt1SXe5
 m98CxKqHBZA1BWuC4AdiS1O5Tf5hG4dIOMMhVOaA1gEHv/MNA+y1C2e4KwQxtljVT5/Z
 HACalKKoCM7lBF0h9Wr3YwYyasqGz8yWqI0fwymAHfexkbUWPizPGyxdKBJPvIvHNy7D
 w+tA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774467726; x=1775072526; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MTqGlKJBBRfDtCDpDOR24HEUyBOyRDO78nlNihYSrIc=;
 b=W47c6xk4KyYsWNcX7fWRXJUDcVBqE5phxI2S2HFMne+/1Ksv7Vt6XVRCejK8t1Tvta
 kHBOHffZhqJyfUbqR5mKUplsehPOMFBsMgnH8EhX8ZqO2LikkMBPdPJuFXsxSCvU6cyS
 rreoKBmmQteICMblo+wxiZPmPwWJM3PkLyFxPOD83F3qMo1ZXjhgXYQhUOSIPfCyCJBi
 ADZxdOBYgPltMMETzMKKMTtBm5iC+RS46znimqeNwXZ2MMj9MJZRKE7MnilMcW60XP0g
 KelhmeRJzOrPQ9aUKYAY/ffKwLB+vblEOgXDt1fzovToRNi0pSmx6W+qSngK27jemVrC
 g9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774467726; x=1775072526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTqGlKJBBRfDtCDpDOR24HEUyBOyRDO78nlNihYSrIc=;
 b=OA0M3rehFLrsv7PwpbBK0VwN5RhBSnpcuJjcPXwF+tJiMQvM2YFy4Yqgdru9EeugVn
 DQa2aCkJNVwAWfBENOHV6+BhNJZqehSZKLGKb7gKEfvvMB/5jRq5Y9596HejmsUBL+2e
 +ChRBiMYqpcyrxqBuyB6yOSmKKHA1k89z12xqQEkVE98H6lRbA8rGmwTTda4xuhO9rR4
 iHNRte6QZD1I2t6XuvZD8y8w4/GJw/Fs2/UONocbVRfHRjtohbjoPnsVUHaI8up8XmQH
 oP4Or0RWPkhBRjtdDsDorbqHQtEQuA2PczIKZplC4N42BBrLnSjd9tt1U8ueDR3eaSro
 tIfQ==
X-Gm-Message-State: AOJu0YxkC8XXnomihlaZFiEhlhXev1J2XGMs34pfzcelWZonKpMAKdkF
 wfmfRbDzjN+UKTqb7s/XR0Jx8DU8bNi77N1CXOoKNuyFEqb0Z7roFjT7cMbobHNwoO7xvMEFWta
 ABwWyYK809GtvWHQdcuUX2aykJ44AaVvw3Y3Ggri5Rg==
X-Gm-Gg: ATEYQzw1Y7eV0tFCIoV1bKqQmJD0OF1hIBAlHeLw8W268XCT8OQgQeLzvg+PL8BXTv7
 cQg8IL9QlnoOEbCN5GXH5l2Vxoya3TnYthGtlXzLdgeqIv5Hl/z++Eik9iD8HODKgK5A8obrl1c
 eVeAbNuGF+OHA8mbQRikw+zBMJ+o6uyQk7Tu0vOPgXTtLxhniGbj8iVueere4jItjv9bhrASyaA
 j+dTLb2IyaA7SXgGB3okqcO4Eu7TDwqM/fj8msVONFf2gRhZmUYX8gFRG+ppcqu+DdThVE1somR
 MpMGYH0H+5HvfykdRDH9mxX8zaI3rp0XUXplFAwbe/l4eSTPWLg6pjv8fCT5lR4CX233fHDoegk
 EMQ==
X-Received: by 2002:a05:690e:434b:b0:64e:8b35:e26 with SMTP id
 956f58d0204a3-64ee616acc1mr3535665d50.63.1774467725982; Wed, 25 Mar 2026
 12:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
 <87tsu4m8w4.fsf@pond.sub.org>
 <CAFEAcA_DEPSoAnEzobryPbqU77QHwqYyxybmdi7KX2wjJqzRhw@mail.gmail.com>
In-Reply-To: <CAFEAcA_DEPSoAnEzobryPbqU77QHwqYyxybmdi7KX2wjJqzRhw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Mar 2026 19:41:53 +0000
X-Gm-Features: AQROBzDGmH87nrsoGOmrw1aEs9uqnt__549yIXteVn4O296jIV2KKTu0RMFdGgU
Message-ID: <CAFEAcA9fxumwc25utUqU23_Gj2SdpZDWSUYhhivejQjnQksEOA@mail.gmail.com>
Subject: Re: Cleaning up contrib/ and tools/
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Wed, 25 Mar 2026 at 16:49, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 25 Mar 2026 at 11:44, Markus Armbruster <armbru@redhat.com> wrote:
> > Perhaps contrib/ is not a good home for example code.  It seems to
> > bother people whose judgement I respect.  Can we find a better home?
>
> I'm not sure to what extent we should be in the business of
> providing example code. If we are doing that we should label
> it all a bit better...

One thought that came to mind: for example code, perhaps we
should think of it in terms of it being part of our
documentation, so for instance:
 * shipping it (under /usr/share/qemu/code-examples/ ??
   as a subdir of the docs ???)
 * making sure the docs can hyperlink to the example code
 * making sure we have docs explaining the example code and
   what we intend to demonstrate by it (the plugins docs
   are very good here)

-- PMM

