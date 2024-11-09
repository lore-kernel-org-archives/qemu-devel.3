Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E33D5E369
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kh4-0002D1-ML; Sat, 09 Nov 2024 07:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9kgy-00029V-6u
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 07:35:55 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9kgw-0007g5-B8
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 07:35:51 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c9693dc739so4275786a12.3
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 04:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731155748; x=1731760548; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wQj7c48AbPYKWDjcAFIQD2C/0zwufoXtdrabuHjcR0k=;
 b=ammS0RDPHCA/j0mS6yk4mVli3GtnTBrzvBKuDmZxzc1QFC02Atv4YatciEVUjau1P6
 zcLJBE+K4bTrfrUkiXplvs+wxdH7Yy9t0GMEPP/2M3AwNx6IIOuYl2kyu47E/X41trRa
 RXIUlJUtWexkdyXLqrioon6C8nYIDAX/PL3J4xZSHn/chwp4fOmjOQnweiJnAFkhstdJ
 3nW0MoSGzlwDWDqwPpyS4+blAh+SRw48OWOFty72Ah9w8F6ZLf8opnHysEvqWh8FqmVH
 KId1NrUtalt/I37PXEWGrB/wIPL+dXjrm1F8LyOOLB+px5ndtbObtk/JhLTZS70jjY5h
 QJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731155748; x=1731760548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wQj7c48AbPYKWDjcAFIQD2C/0zwufoXtdrabuHjcR0k=;
 b=whj6A9mYo18o/pGeHTBEFvsoxvyPLn9Wn6/KYKwgxErO2NOIjrtZTjNc0XERBgkhOc
 nXZaPvwD5rCSEnUjke8Pqliru89CHRY0AfiuL53KIp6KqtFL8QA+P4dy5KvqWD+E9/bo
 TYZuP6RVC/vgG5z8QKoQVMSdnN7sWd2trcovnErW3vu5QI1cW+T5rBZpdORNoIazpVry
 SxYWnQwzncCCKE3oZodPzaYebOrRsY+FRCTA8Qt3o0cha3cBLl/EPm/8vGBIEQBSoLcK
 f+xL7mXO5h/S2C2MOAzbdvj+PN5ta6obY95Uo7wbZRaD6qXn/Sr/5J3zkd/XTQOvYKsZ
 Veag==
X-Gm-Message-State: AOJu0Ywlhmrd4MOBcVs/Oblqb13atHFx1Np4dmGM0zgGe4IMNrPK/KQh
 arU5VRcrg4qPlV+GgSTlLxRN27lbc9BL3ZL7tPJ+xTtyZsIzu9O02nqXzRB+plytz5G/vcxqOzb
 JddN+AqEXfhRfnrjsXL7V0A3bFMMEgFZsWMxn/A==
X-Google-Smtp-Source: AGHT+IHuDnMLL2ype4HXiTByUGhEEtkbcUrRTQ6OjH2LAkcFCjw7xk5mSfBIBlS1MsjVjAFnl9o1Y4/agkrE+NxojQI=
X-Received: by 2002:a05:6402:13d1:b0:5ce:d6a0:be32 with SMTP id
 4fb4d7f45d1cf-5cf0a30878fmr4600127a12.1.1731155747856; Sat, 09 Nov 2024
 04:35:47 -0800 (PST)
MIME-Version: 1.0
References: <20241109073555.162151-1-pbonzini@redhat.com>
In-Reply-To: <20241109073555.162151-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Nov 2024 12:35:37 +0000
Message-ID: <CAFEAcA9+7h6naG2zCGPu16Yxk+Xti95WwnR6N1HBcfv80Fv8xA@mail.gmail.com>
Subject: Re: [PULL v2 00/13] (Almost entirely) bugfix changes for QEMU 9.2
 hard freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Sat, 9 Nov 2024 at 07:36, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit a1dacb66915eb7d08a0596cc97068a37c39930d3:
>
>   Merge tag 'for-upstream-rust' of https://gitlab.com/bonzini/qemu into staging (2024-11-06 21:27:47 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to bd0e501e1a4813fa36a4cf9842aaf430323a03c3:
>
>   hw/i386/pc: Don't try to init PCI NICs if there is no PCI bus (2024-11-09 08:34:07 +0100)
>
> ----------------------------------------------------------------
> * i386: fix -M isapc with ubsan
> * i386: add sha512, sm3, sm4 feature bits
> * eif: fix Coverity issues
> * i386/hvf: x2APIC support
> * i386/hvf: fixes
> * i386/tcg: fix 2-stage page walk
> * eif: fix coverity issues
> * rust: fix subproject warnings with new rust, avoid useless cmake fallback
>
> ----------------------------------------------------------------

Hi -- just a note to say that although I've just kicked off the
CI process for this pullreq I'm off work for a couple of days
at the start of next week so I won't be able to actually merge
it to master til Wednesday. I plan to do that before tagging rc0
(which I will also be doing Wednesday).

thanks
-- PMM

