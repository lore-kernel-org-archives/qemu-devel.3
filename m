Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D272D11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOc3n-0000f9-Ol; Thu, 27 Nov 2025 08:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vOc3j-0000Vy-NM
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:29:20 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vOc3i-00045I-4z
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:29:19 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-642f3bab0c8so707728d50.0
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764250156; x=1764854956; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OIt1afmuwhp+NOaObry7lFFA7Ar4gIhl4+AucIW5uKc=;
 b=tiMpV4saNBZ3Pi1rJNOdF/mLx+p9zvfH6Gf1cCka2b9ruThupmdlroTI2332WOCVhI
 2kj0MUXXGsWe/m+i12SvweA0vkqbZrURIKU3w+Ku4B40kKokkJxjbmy4prTdDMbjelIv
 AHyL8PwmP1GJN2R74eKLb2SlzQVNvdYGssDrJpXhPUUqiHWoXbY3Nks2XxInB+DwyDdF
 t4foi31AiPkXH6uV82DK7yfMSs/NJV15jRsATsg2F7SuY6MGyYRStvjW2FtjBRZNpNCc
 4epS/A4J9RmqRs3D1A/hp7SROu84nlJHVkmjoBJ2gPJ4SBAdA6PHgreO906WnYMW9wGn
 J/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764250156; x=1764854956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OIt1afmuwhp+NOaObry7lFFA7Ar4gIhl4+AucIW5uKc=;
 b=JaNxJ0gEcPkLWAHnAOfzC2F0tA/3KilIuLnkACy06P+yPcjNkOCdoWmU4pfMl+grQ0
 HS3SiCM/Q2MxtL90yQYgOHtSykclMsyeWTqL49cwBMRgvpUsEhx9Mw2DuTXtw41PI1V4
 3aTxk2sHVqnplJ7mql+FzbiGHRVEokCgf6s4ZiCp8AqgcAAIOKb41wNxAqLTAhAQa8pD
 9oDVXctfA8MIr0dkWqt0eL+hfa19OUtyoEE235e7iXG4FAVKAWVDfX6d1MwaDHGRJyQo
 RFyTbxt/MU2f6A/srf0TovpN5np/E1FtQAyRfaifVNJy1hBr3Rvph4r7tCc/FiB2cPc1
 QEKg==
X-Gm-Message-State: AOJu0Ywm2LmMYMCc1AxoMrNK9swe8afqJNWN4z5u2X+aSWKKEocdO68t
 X00H8VgsBBZsraU0IYhCSUbrNxcIk5Z3RW0GBoIpE4MBVLUTFZB2ZTfNYmvN2SsiqFffkBvq3pR
 NpeuoiifL6l0RJhHI2vycwTEXgfIE2FLO8hCFzf9COw==
X-Gm-Gg: ASbGncuBdOljtiB71PemmnoJhFUTaJqRtBESqdu2l6khSZw+j/DTrt4vi2jFHaop3cd
 MTQoXSPXzXNI5FAJ4Os5SZ8orLuTz1DRC0SBkh7vLa1BykKWO3K3u1St/bOAs0LO2wBtkBXhUSH
 nb+vtg/4yrgwYe6Qd8bJ3+f9JMd1n11mAEy3p97IP2plMmtcmlZZZL0IcQrWy/AZO0+9Gmmk6So
 BIB2jK3kOmRIjh82u/oR1En8g+uln+U02VveVTB585y1iHVoSw9uDZzuQlZlDQ9fbtg3U6K
X-Google-Smtp-Source: AGHT+IGqS0rWanYau09Ksu2yIGYIbE3cvTdKknafC1ihB5UGwgf3juZbyzsXpZ+FXC5DsXBYTmFnuCyJrKajGbjYP2w=
X-Received: by 2002:a05:690c:7306:b0:781:1ac5:c29 with SMTP id
 00721157ae682-78a8b558f3dmr175832267b3.51.1764250156230; Thu, 27 Nov 2025
 05:29:16 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-hyn0B-yWE1=g4+NN9=NBjWvk-P8qrAk9L4vpAZpUYvQ@mail.gmail.com>
 <20251127001247.1672873-1-navidem@google.com>
 <20251127001247.1672873-5-navidem@google.com>
In-Reply-To: <20251127001247.1672873-5-navidem@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Nov 2025 13:29:03 +0000
X-Gm-Features: AWmQ_bmSSAJ1FnDiUdDWTu9BFu2PShhqqN7-m4SEE4cjH8gQezEPxr_UQCh0QsY
Message-ID: <CAFEAcA8t4RVOJY8jLLAY7z7D6UBYVRCnbj-NW4U6a_K3+a1LnA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] tests/qtest: Rework nvmetest_oob_cmb_test for BAR
 check
To: Navid Emamdoost <navidem@google.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lvivier@redhat.com, 
 pbonzini@redhat.com, zsm@google.com, alxndr@bu.edu, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, "open list:nvme" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Thu, 27 Nov 2025 at 00:13, Navid Emamdoost <navidem@google.com> wrote:
>
> The nvmetest_oob_cmb_test was designed to deliberately perform an
> out-of-bounds write on a PCI BAR. This was intended as a regression
> test for CVE-2018-16847.
> The recent change to libqos introduced strict bounds checking on all
> BAR accessors, which correctly caused this test to fail with a fatal
> assertion, as it was performing an illegal memory access.
> This change reworks the test to honor its original intent=E2=80=94verifyi=
ng
> safe accesses at the BAR boundary=E2=80=94without violating the new API c=
ontract.
> Instead of attempting an illegal write, the test now performs several
> valid read/write operations at the very end of the BAR (at offsets
> size - 1, size - 2, and size - 4) to confirm the entire region
> is accessible.
> This makes the test compatible with the safer libqos API while still
> serving as a regression test for the original issue.

This one I'll have to leave for the nvme folks to review.
(You'll want to recast the commit message because this
change has to go before we add the assertions, not after.)

thanks
-- PMM

