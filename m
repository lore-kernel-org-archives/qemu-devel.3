Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE9F104C00E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 10:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0HAS-0003uo-Ok; Wed, 11 Mar 2026 06:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0HAQ-0003tN-Ls
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:51:55 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0HAO-0001ua-Lr
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:51:54 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ca1ba0089so12981871d50.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773226311; cv=none;
 d=google.com; s=arc-20240605;
 b=hscZE5taElGcPapPW3AdTVQZeid8zGoiWnFwPw/V3oIF+Tzefd8W8ExrrzRn4jDOSK
 0gregXRisVpwmmAsrscfwyxpo7eGraM6bLUSyjsaX3VgwC+1YneINJt+F8UQeZk8flbP
 0e4STlQBNCJzRk1EuzEKSqMUp8jKYM5CU3PjNlwRzwv6xRhKPGsJpIEdpO7q7gVnxgnK
 xQ3wjgazms13bo97J1bLvLPgO2OrATbXHDoUt6pNLEHzLNEC2UNiwz7X0pE1n4gOAEof
 9RxzSJhp17b5IAtgal0rffRMk4GEq9NL6Ngz+jesvqBazT/kTAIuPdgIP2wzcNDZgmbc
 1OdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=r2BmujFvbpBnkCWDoORslb/gLaWOUVnxTOF7Widx+5A=;
 fh=/bQ3TuCiUP7qLeMcUwB/B1HJxhsRMOQvoysixe1WVh4=;
 b=VGwD4QLAX3DYtqV0DRavrCdZwOKCqSJepKPWeJyOsFN/40pVw9oPM8+DX6x1n7Bf+j
 Kygl6/29Ln0FkWpfjU+gIMm+byp/OmNofgYanhgQlhYEOMCxBQGsFuQn03Pe+5tiw9Of
 kjdLcvGideasEgJBakhrNVDutrdxz5DVbWOE/SotKmVGNwFzQjcBKCMWa9hxo3IE9Uhb
 W8VPbNlzLqydV04rmWEPrB9/AewkFAcoLrqn6onKqh7aCQ/GBtmKHYeNoBmsSPVDzfuM
 y7EZAuWfH7UvLGloDpsR91Kdo2m86ySogSpXQIb1DZjpmsa6uB6uqrBU3ZNgt27/NNDG
 mxww==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773226311; x=1773831111; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r2BmujFvbpBnkCWDoORslb/gLaWOUVnxTOF7Widx+5A=;
 b=kr34RkdwGj6tlDFZ1JR+VfVovO/cxQg32Gx7fa9ZjFSx837njevrUVKvrQcpsM8Fyp
 W8Lv6HoY8j5vXVHunkRjUrwGtyZGEYGeW4bapmrZ+bZVM6x18BJRnTjgwSgGg/fXcPGM
 svG+KdZKLDZhnJKsBvl8BjITovY94LeDwI65RXyXn32sEWNHoEm/j6a2PBR+ZWcvo7+B
 iq80KmfGERUcxTPl2617pkQ0fClBJ3OIE5ThESZujtCeaLMJKWv8kRD/s2MNLK5Bbaze
 wuXTKynGKHQL2HKs9WbcrmrytvqQ9ZIsJoqbb7myP4dX+aQ0M7cmMoLPzVKmqZeqLtrz
 yf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773226311; x=1773831111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2BmujFvbpBnkCWDoORslb/gLaWOUVnxTOF7Widx+5A=;
 b=HQVh+BJZFn32+LJ9NxJY3crFX608JGAybs8lo7qtOR2NpZywZiDHpyRckaC++E9+oL
 fx+M0Zn5+2/fnBjrrqD/DCG3zXGCkGI/5jdvlyQX406ST3j9zYMi2rlMOQM+j3uVFXHw
 HDkm8eSltQGlC5m0XrMnt3Yf4ym4Rw5lYb3DMG8Y4WwepJyYtWPYOXZ27wJFRcldaBDy
 WPxqFRrvVoHm3QW+ypXg+vgTRNvYD8c9xVfXRFAflpMIRJcVuhTf+gyqc65SG9tSHsPW
 R0whMyXlL2NeNPU2T7AUssYeWigemUHpVeYh6FZQ//YkaAyrVTBIToYiHlqp4/7B1zmO
 aSeg==
X-Gm-Message-State: AOJu0Yy9kiebLwv9EpvjCsd9acENhCx/7QYJ7BS797yDsaIoYGnvJ0Zz
 cMAdyadQT2E6U4DlwQfx9it9gAEHHPyijXFuJ7wrZVyOwIkVxW+Ek2vBc5NYQjldrOf6X/oQoms
 xucrCWPEyv4JH/Q2SXrGh0g+589KSV0mce72MU8/4y4zewdjb0Ump
X-Gm-Gg: ATEYQzw3ADeIiH+iQwtik/1p+/mRH3sQEnnIF3ju2skZ+M/ip3mo+rUmNDNtCWCiOxa
 H1p9zRLgkyM4NRc+GLd/07x01+HWqF8B+s6wJU4QUlDX4o/0fk7jqyYb8LJXX8jo8H3BpN0pYWH
 vy9wyz5EpqFfarnFv/roY+YzskA+hgC7RWsJbL+GhmpHdFI68x9SIOv5Jmq32MUjMqZh896XcH4
 hp7NdkUykH1zFgoBUthASL/vwcRNqfTgBSkYrmNwfex006y0LA510ZnxtOQDreNSLwJcF8Ar0mM
 8ye5dnGbzn1QHxC13oU0LRg9npKnWp+QFGevTKSjfGrINfCLyX+U9gLDz+elvfsig90=
X-Received: by 2002:a53:ee59:0:b0:64c:2128:c34c with SMTP id
 956f58d0204a3-64d657e7fd3mr1321008d50.59.1773226311377; Wed, 11 Mar 2026
 03:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260208103958.121455-1-heifetz@yandex-team.com>
 <20260208103958.121455-4-heifetz@yandex-team.com>
In-Reply-To: <20260208103958.121455-4-heifetz@yandex-team.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Mar 2026 10:51:40 +0000
X-Gm-Features: AaiRm53_cDqTDSMBq8d5_d5JelSmhzhDcLK4dmH3PkSHqTIBtlmwnf5N1-SEBlw
Message-ID: <CAFEAcA92MKa1Q1xwamjsFja=-V5ag-JH4kM8xTFiu07RDCBbTQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] system/physmem.c: remove useless assertion of block
To: Sergei Heifetz <heifetz@yandex-team.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 8 Feb 2026 at 10:41, Sergei Heifetz <heifetz@yandex-team.com> wrote:
>
> It is useless to assert that block is not NULL because
> it is already dereferenced in the first line of the function.
>
> We could split the declaration and initialization of oldsize,
> but then we would need to remove the const qualifier.
> This seems worse, as the assertion would be almost useless anyway.
>
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>

The commit message fails to note the information found during
review of the previous version:
 * this function is called from only two places
 * those places already either assert or assume that the
   block argument is not NULL
So the assertion is not getting us anything.

With the commit message updated:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

