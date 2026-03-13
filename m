Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09D7105F7AE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13Rq-0003Rz-Ur; Fri, 13 Mar 2026 10:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13Rp-0003RH-6M
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:25:05 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1w13Rn-00024G-Ef
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:25:04 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5a0fc5e2c59so2785158e87.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 07:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773411901; cv=none;
 d=google.com; s=arc-20240605;
 b=FAs6gRSgREq8oJ7syArHMkkfctyiTQzwzFDLPvqkBJBIbm1pAn3vyEu5xGlHzy4Euc
 3XxOQO6pOqXWJLMdDTRMaye59Ohgv/K9JDd306j24srHc/xkKvqylDEXjaCpdkgYQQa0
 IA7xhp9Y+wD5DG4JJRcECdYpMcbSBl1TrnvYoPyvK0Lqgo+CdlX7iLWv/6DJaIqhr4x2
 3ZsIU6s30t1kd/Eo0igcyezfEj8dDP53pRdyoGPUFMym9SxSeuzlK3mNsiXKD+mJ6xmT
 es3+T2Nu+3EhvQY0dHVQSLZ9dO9oNAgl0AvLlWNS/0DojZga5o0v9OMQGcYv3F5NTaqM
 8ZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uVf8pKsHgLoK2iVGqY2letFSYQCwHgLq09/nNXP39EI=;
 fh=uRm23xB8dFt25UDWnVE6oSdt0+caQPDqosy/fhASXyg=;
 b=lhfKnH5Wh3QqWqa77Jc3R2b3p+njyL7YE25eF2SdwSA6hNBl95+6WmDDPfFyLXPGwC
 r2lTNqSraylbkb7RZ0pAu1DvwHf2V5DSBTfe5oyMSi3ERTZ5pAT8GbnUmc1nwR4heL8A
 TEpcP4dlc2VC0b1YBvw31j39vczSqRFny5QEwJv0xOiwvgPSgvUJGZRSOYG3+RGmHOi4
 54e+d/OwHvsTMSl3TNrjBvabFez6m4xqKqRbhiJHxyjKmm+RmbWqmOtwHWkrdkFzR9Kq
 K0YRP8IW9hWHNNXwmzDMPeoA+nFM3LkK7ouSstU8/OgeKSw9frmcl9U50Sw3nAzztjkE
 Q+Rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1773411901; x=1774016701; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uVf8pKsHgLoK2iVGqY2letFSYQCwHgLq09/nNXP39EI=;
 b=YJovrFfej27+IvKcI8PqB7F+Zl27QXdRVjahn7yjBy9VYgaZ+dg+KwCrAqD0kGrCJT
 QgrkD6yrO9RICn+Anqx0cWMrtUKVBtKwtHWiGyUANLpmZb1XKGyT7dMm5Zo3SzSfY2/9
 3+Qkkr3M/eVTn7QucCXSiq2sgq+NSXCZchqjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773411901; x=1774016701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVf8pKsHgLoK2iVGqY2letFSYQCwHgLq09/nNXP39EI=;
 b=RfAEg8zeFEhGaR7nep0TLusRwwdwCgehBW2bcKLYtpDXTu0oEFVFG07DOuvYorNn9y
 crqDBB+XFdN0QwbkoYDYonB2PGb99807ODTnHYKJW+/Oj4n9yc5DN2KM7oWJrrTny2cP
 VnSJABLSmgpiBDDTFq13K8DGJFXRGskSDZUvJpL81iLmE9lR0g2JoBv9u9xeoWPR+Otb
 aXE7Z/1hiv+EXfSzTnYV35XiVgCv/LlZp+lWKRR/CM6SjzbEhy24QA19F93jlBReY7SR
 g4fVfAAof8ZXFeExsDW2095xwvJS2Or0d/Y521Qfj7pVcq8rATwdeRC3+uc0yQYREeTQ
 KC+A==
X-Gm-Message-State: AOJu0Yx5W4ILg5RwQ9cAso0P+/VpyX2amfopGZdoTHTB3Ub4qNpFjpdF
 6hWgjOnGxP0sgR7D9M6xoSEQ2jkCzKVlB6fZc5cqahsOijEhUBpVyQxNolx+kweU7qgovOpDEOc
 D6XtFvus/7sak1+3JiVLuZND7djug4DbRgioKxSRDxw==
X-Gm-Gg: ATEYQzy6os/RgKc7MGTyYOLvlficsVu1TUulxNCwf0Tw1cohgb0R6WEGgR2K2qwi3cm
 Dz227bI7rPI8M0rtsfkp9NQFDVpWyaIFj3yl112+OiazSv+aBYNRXeIVSN1O7q50YfwVP8u7yad
 MLxcu9w5xGYURyLHbF0/3f/f6LkQjnPRwKmG6kM8NDMQg4vnnbBLPpP8mJnK1Wy3P8SvH4ulaXb
 Xt4YmtU2ORM66y8rvNl3Gu/qQ0LcVc69oV9Kg10TatbmBVHpJ2/jNfhMu3qiMlfJK5s3Weofl5v
 Nvm2oAPgy861X8kOUsEBshSlwYEPSjVaByZg7kAZqtVuQ0O69g==
X-Received: by 2002:ac2:418c:0:b0:5a1:3fff:5e91 with SMTP id
 2adb3069b0e04-5a162707846mr1006130e87.20.1773411901272; Fri, 13 Mar 2026
 07:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260217152517.271422-1-alexander@mihalicyn.com>
 <aaFrB7fMMUPfMP_5@AALNPWKJENSEN.aal.scsc.local>
In-Reply-To: <aaFrB7fMMUPfMP_5@AALNPWKJENSEN.aal.scsc.local>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 13 Mar 2026 15:24:49 +0100
X-Gm-Features: AaiRm507_W810COXiI5Zek7JyORHtRTTG6kkNuerwUQaZM2Dyr2iLmU9HHsfkcE
Message-ID: <CAJqdLrox2KtWVCdTeQeR=W98AkekmypMVN6sENUwimWPFDBOmw@mail.gmail.com>
Subject: Re: [PATCH 0/4] [RFC] hw/nvme: add basic live migration support
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alexander@mihalicyn.com; helo=mail-lf1-x12e.google.com
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

Am Fr., 27. Feb. 2026 um 10:59 Uhr schrieb Klaus Jensen <its@irrelevant.dk>:
>
> On Feb 17 16:25, Alexander Mikhalitsyn wrote:
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >
> > Dear friends,
> >
> > This patchset adds basic live migration support for
> > QEMU emulated NVMe device.
> >
> > Implementation has some limitations:
> > - only one NVMe namespace is supported
> > - SMART counters are not preserved
> > - CMB is not supported
> > - PMR is not supported
> > - SPDM is not supported
> > - SR-IOV is not supported
> > - AERs are not fully supported
> >
> > I believe this is something I can support in next patchset versions or
> > separately on-demand (when usecase appears). But I wanted to share this
> > first version as RFC to get some feedback on this in case if I'm approaching
> > it wrong.
> >
>
> Hi Alex,
>
> Nice work!
>
> As you have already identified, there are a lot of features that are
> non-trivial to implement migration for. I am completely in favor of only
> supporting migration on a very limited feature set (i.e., don't worry
> about CMB, PMR, SPDM, SR-IOV, ZNS/FDP and so on). Focus on the bare
> mandatory requirements. It would be preferable if the "is migration
> possible?" test is an allowlist instead of a denylist. That makes sure
> we don't add a feature down the road and forget to add it to the
> denylist. I'm not 100% sure how to go about that at this point.
>
> AERs are something we need to deal with. We should not drop events. I
> don't think I have a problem with aborting enqueued AERs, but not the
> events.
>
> Finally, this at a minimum needs somekind of simple smoke test to catch
> regressions. Preferably as part of the QEMU test suite itself, but if
> that is hard to achieve, then I may be ok with an out-of-tree test that
> maintainers can use.

Hi Klaus,

JFYI: I've just sent a version 4 of this patchset, it has all the requested
changes:
- AERs handling
- new autotest
- better feature filtering

Kind regards,
Alex

>
>
> Cheers,
> Klaus

