Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5479C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMVh-0001fh-EZ; Thu, 20 Jun 2024 14:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sKMVf-0001fU-W6
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:27:48 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sKMVe-0002Ya-DW
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:27:47 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52ca342d6f4so4200e87.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718908064; x=1719512864; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qpez/aXXeYJejr+hwOw7Hi/zgO4r4cavi+BlIfGF4LQ=;
 b=fmGUXEbRzWEzXY7YAiScqWB8IimDu1luSBcgcbpTAxt23IiyGSJcFWIuBA43nNNdqe
 GwKnHmq29uY4AEQ8zMTMgctAt/uYxCX/aONbyNFLuObto3X1wPiIv5Jeb7W7+dXLqlLN
 s7PJGIH3C8Axd5ckdm2ziORkcxwm7vIWivAOu8dwkPjNsvFgE3WQKNoXXLF8pdi7f/p8
 pKDgfQDKqbTsVe67OXpBLNLGlTsoyinyrP1jOLiIIOF+S8ewiUcy2ZRXCmZ2EOcMMvDC
 qYO+gti+oDab3jzUe6feUJTDWp+FBnswhHE9ogjGaVikOuTsx4f4oNU+Xoi3YOJhOw7R
 Ncsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718908064; x=1719512864;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qpez/aXXeYJejr+hwOw7Hi/zgO4r4cavi+BlIfGF4LQ=;
 b=iAlh06NKGWb1xSlo1Nk0o0Be1Wl8r409Om8wJ5QQTOPfHBYv85PvqYbGGOopUjcs8B
 m+jMWGU1VwuUI/XbkLzmFKkTh4pnURWFY8mbpByizevHgPfHE4fHpVVaMgca3XZDJlZe
 R0yl/PWMHLURGng76bPLyz+4YWBspvCjcABtSUHNPTW9R3p+6cXef0Z8rdfaud4xpXDI
 fbMLIALRvJbRoFI2aZZEKPaRAfGB6eyFRlfyUBVo2pH5vSDyDMqmk2p2cj1XaKqEIVQx
 jNQKFBWrAV6Aq4mj2P/nKrovz3UQk0wPh3slrB2cg4XJ1IuKKZkhqLm70CFurGpSsipH
 OzTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKvnK5oMmhzJBl2G4YCtchhJFhfXcJNSQlwL/4vtRSWdIOyWiX2e7VNwfF15lT1AKE/3NYOZQiotvfEJGuxIcfDpXgPRA=
X-Gm-Message-State: AOJu0Yz40k+PGu9Bs1c+HMZVe+Eajc5N/pj6KYRw2ec4fD45G7dsK7J4
 Re6Bj4sPA5nplT8K/dwiKJaPKDF2jh8+LYPXmvD3X30elrWtNt89xLNTfCPVdTys7lCEnmSI+4w
 VOVZO995UbnVEV3X+D0hJIry/r94fI8YSDguK
X-Google-Smtp-Source: AGHT+IH9L7ZUu+HHmeWBDoqsm3mpPyh2p3i/pFti0my58tKUD5CM0fFKSfaVZBObNm27kZQ/IkN8LNHgipn8clIU0vc=
X-Received: by 2002:a05:6512:3b0f:b0:52c:cc9b:be20 with SMTP id
 2adb3069b0e04-52cd4a7e5e3mr48825e87.1.1718908064247; Thu, 20 Jun 2024
 11:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240618224604.879275-1-rkir@google.com>
 <4b3d0472-8b06-403a-9ab8-553aa858fb7f@redhat.com>
 <92be5dcf-c793-4c29-9a55-910b59c4c2c0@linaro.org>
 <CABgObfbo=aLW7RhjymNDJpMbUXWNRQ2_LccdXqKKVrCq5o75bg@mail.gmail.com>
In-Reply-To: <CABgObfbo=aLW7RhjymNDJpMbUXWNRQ2_LccdXqKKVrCq5o75bg@mail.gmail.com>
From: Roman Kiryanov <rkir@google.com>
Date: Thu, 20 Jun 2024 11:27:29 -0700
Message-ID: <CAOGAQepqfC7QePJf8mZ1768XSNGJBYqBpWRT9pvqiDjwdfEQfA@mail.gmail.com>
Subject: Re: [PATCH 3/3] exec: use char* for pointer arithmetic
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 jansene@google.com, mett@google.com, jpcottin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=rkir@google.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Thu, Jun 20, 2024 at 11:16=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
> > > Would it work instead to declare MemoryRegionCache's ptr field as cha=
r*?
> >
> > I prefer to use char* only where there are strings.  For unstructured d=
ata such as
> > MemoryRegionCache, void* is more appropriate.
>
> Or uint8_t*... I agree about char*, but unless casts are needed, I
> find uint8_t and void pointers to be more or less interchangeable.
>
> The problem is that casts are a bit uglier and (while unlikely in this
> particular case) more subject to bit rot.

Will `typedef char *MemoryRegionCachePtr;` or making the ptr field
pointing to `struct MemoryRegionCacheData { char unused; }` work
better?

