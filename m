Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018B2C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5Dl-0003Vj-Sk; Tue, 07 Jul 2026 08:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh5De-0003V0-Bh
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:48:12 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh5DZ-0007Fd-O0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:48:08 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6651bc57458so2662023d50.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 05:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783428484; cv=none;
 d=google.com; s=arc-20260327;
 b=grm5G+zgnj4mM1qq94qTRUfK2/Mxwse71N4Y8vNJwSfMQhVN7psMydIkunFqeUEoOy
 WbKZcDpfZZ+mnmfDNuKT2jVesOKIa0MvvJ0C5C5IQ1tzmogrAzsqfuoApRIjB6/50Zat
 n/D6NMm3kzJluCvlAMMOY2jxfqMKNUyqDcVovdLnvYLOaqU4s1itmfemR4+K8xTL7Osu
 frKQ73vowGQLU6HLu0PmGDwe/Nl8SGqLMTVPHRGwi3Byr59S82vIPAPAj9joUXXcnnZH
 9W58V6k96rKUy8kqkrBu6qp+n54AgirrZaa51qqibkax9sba7/oaHoGPc4qSWEXNGEZ+
 LI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mWp5UiVLF3Ur22AHpCLZlJWgyOJm9G33BVXoGd9V7Do=;
 fh=ieb0I+gD6WJKhNa9jCaeKhrdOcbjzkuz+zcXpH1ODCw=;
 b=mw9e36dHKJIUBu0pcmr0+zVyYRD2i83NkePdLrf60dAFBe8v5ZDozDtNTNfqlSLRIx
 DjKxydWL0gk2bpEVHAmosKGU1oflsCU/YAecr6D74NAkDTMsH8YD6Uxi3gmEDweSCUQp
 xTQRc864Jv8h9hRIUe46+6tccnjaTWSKkGfwqgmI7B0bVTPUmaa02WuipB0eYNgOAHjg
 F8V77IAjrf7Wuc+mY514J6y3UNrV584e4Cw0OucSDfntp0XWQX025GzBMevOHy7Icazg
 21Y+Tz8NrTYltTs0dE+2mL/AP1JhL5kgpH/9Ka35M3WB3MpvaQAvtr2J0M+Md9By1MLn
 oCHg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783428484; x=1784033284; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mWp5UiVLF3Ur22AHpCLZlJWgyOJm9G33BVXoGd9V7Do=;
 b=AZSgsEx2SQDbL1FUDnIZwmQZNOayyZrIXt3yd4D6bvokFtUEQI8Qxt8Q/vR+vmgXC5
 gKjTL5bxLgn56GX2RV5Ru/QMMqdrjG3XPdf1b8X/IgV9jg1/uki5o8IuQ5o2wMxFdNls
 Zh5Ui8RwJaWRvz1rfD4v5UAEpSvIV9YWs1evL6taQRMKnYb0W8Yg1ntcxsYcdJG0QsDk
 hXkYSH+HPiql9xMnPkqoAWLsEFsxPaL72vMcTZzYbm/F70Ys3wdPfmGM+PaR99aTlGyy
 bpHoBLnhmK8jaPJsAGTjwrfRRIqtjQ3YMCzGGnHrSTv3lIqde5Sty10C7edAflBFZSFw
 eIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783428484; x=1784033284;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mWp5UiVLF3Ur22AHpCLZlJWgyOJm9G33BVXoGd9V7Do=;
 b=bCjfTpnhl5G1c19h2VjEBwB7hRx3R0a0M30PZHld7DOgWH28b1yQSrjp3xSPAVlqXW
 yoqjn3+H8zkrWlQpyztXNoFPuQVn4phEvLY14X3MNcvaJfOqRUOrVMugmfYeQtq9IdPZ
 UDeKxmUXbOLLm06oEbAZEWclrRzx7SfhVmpQ5WWgaSr7Iw0vCPB/ztr5tJMwD90RdUwp
 1LOMNAQDoy4h2wpbcvm3gDbLLkjabVB2v//4frHg+/nm79Wz1Z0kN8o0g9DUhkCEMYh0
 5Qt8UXPVm9V7n4YEaAvv+/H2mwDLv6E2eNlefI0ySjjyHR3AnTBzZV00FcnmBk2bUc0k
 nHkQ==
X-Gm-Message-State: AOJu0YyAIpXy7JBdjK2yNjIKA9pXCPwyRKF7Ac7fui6c6s+ehhldHwuo
 B+7fmGA/QmiVfl0FWbQoFHwlY9yrNxMIeQZGw2+qBjrsG/SXgjUX7TWv68I44R3mobYrSl1wkfS
 BF//oodvUqS9AnY8ffJBNSa0wvP5cBauQV/S4kkC6/A==
X-Gm-Gg: AfdE7cn04qq/6OrG4sHTOfEpwUgdD3AMbZiw77BR+A0LCUIkYrLE5KhXLSjMhCBDT3e
 Cx1aPLNjsoxWSzGa0Bg3ukjLOW2nPlZZi/qkLZdj37cdPehJXz5JREdbNoBDMYKAjST7j2VVkVZ
 lYJZE1JwCO8qtHhKWY5vnGQqaUXbN+rv/fKeBnsjPAaNfU/6UfnztDZhHP21Tg4ICKFphi1bKDb
 w9ZDNkugejsZE+/dljX/Jl6WjlJw5SMd7ancg5aLbeWxKbb//8BKg7dXlZyvjTHqOX6sB3qLl6g
 iZSZWF5o03WAqbYhP6ZuIyaeiO0gvclVXGzBKymgHVxdRyiZizFhLElM
X-Received: by 2002:a05:690e:c4e:b0:667:6db1:8219 with SMTP id
 956f58d0204a3-6677fbd9eacmr3826027d50.34.1783428484429; Tue, 07 Jul 2026
 05:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260529114723.42040-1-peter.maydell@linaro.org>
 <20260529114723.42040-9-peter.maydell@linaro.org>
 <CAFEAcA-880g8FVk1SZ8eH7-cAkzh2oyH7OFV2LBG68=CcFE=JQ@mail.gmail.com>
 <CAFEAcA_Lg3ebEiefKmf1K_RHY4NozezGese2rFf2w6af3oPccQ@mail.gmail.com>
 <e6a5de30cd451e820007513b869a87bf5fe4890d.camel@beckhoff.com>
In-Reply-To: <e6a5de30cd451e820007513b869a87bf5fe4890d.camel@beckhoff.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jul 2026 13:47:51 +0100
X-Gm-Features: AVVi8Cd5d0HFwyxcOPzIvgEJPc3nQVAv7_ihveaMkb9S15kE_GlSmQzd2EINYZY
Message-ID: <CAFEAcA-eU0z1k9oHdKJ1rwVfq3U0QkP9w4j7zdb88V52=YO2Tw@mail.gmail.com>
Subject: Re: [PULL 08/21] hw/misc/zynq_slcr: Add logic for DCI configuration
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <C.Koehne@beckhoff.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <Y.Vossen@beckhoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Tue, 7 Jul 2026 at 13:42, Corvin K=C3=B6hne <C.Koehne@beckhoff.com> wrot=
e:
>
> Hi Peter,
>
> sry, for the late response. I've checked the manual [1]. 0xb70 is the rig=
ht
> offset for R_DDRIOB_DCI_CTRL. Additionally, the correct reset value is 0x=
20 not
> 0x21. The commit also requires 0x20 as reset value because it tries to de=
tect a
> toggle of the reset bit (bit 0). Do you fix the commit or should we do it=
?
> Thanks for catching!

If you could send a patch with the fix that would be best, I think.

-- PMM

