Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE63CEE3698
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZRw-0006CO-UB; Thu, 12 Feb 2026 11:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqZRr-00068U-So
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:21:47 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqZRp-0006Tz-Fa
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:21:46 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-794719afcd4so608107b3.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 08:21:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770913303; cv=none;
 d=google.com; s=arc-20240605;
 b=LnghXHLFfkcqzFp1xEqMd8cUDYrwvsAfdQNaBojspr9UNkpuTZkdj5CrT9/C7hDGuZ
 L7aBH9+3KTlsd3hBRVDbavdXzpjmcfaGt8r/CZa5UgESq7axjY+Bm30GWNrOt9lxwtUr
 IgpoS8qtTM92J0PrXDnrVPjW1FxCQFVacRN5JIxpf0eEZMwVtOMbohwBu6CPeb+P832X
 f7KrRwkR6t7O1HgEGh4ZItmakp9UHMHpiV3cYEHAv4TnsH3g+EnOWbRD3JIh/kppVPkK
 cpdM5m9+zfXql2IyYDCvdRHjfTbpKBYssKWMN8StjT11+5rhJngiHoytboMkLxNr7sN3
 M1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mgarlAJOBzurn+yDKDZLhTu0ROIu9bFNkW/pSU+kR+A=;
 fh=fMHLqPn6sHt1evO6ktPVA/Z1oe8ouQosjaUfpEeU4SM=;
 b=PYw1etx464GfSar/q32Ud+4W7CP+sqN6RdlwgalLnhynnejxtJZHJ7uIjIW2V+XhPt
 bkcYfTszUWaI/UdS+W4phPmtwyEx474DEJAZJjH+FUxttfeEReDZH2n3oD4Wphs7hbGW
 z7J55Qes428SA6Bz/5FVXcwCo0hStn6OnwZb2ioRGUvGrNPE+vS5Y1GgnJM2sBN8Vf8U
 r1YuxLlIhlNgBlr1wxlyMA/2t7/DjbjGMVZTgfFga+GhwJ6mvDe4qtNaWthJjPcX+lF3
 MCcBFtbuomeTiEDv9tj6KGyj51zpsdoyDx0lfWWIkQGGJ3Xv/i5/cQZUqYE9Rqxzw/K9
 X8Iw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770913303; x=1771518103; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mgarlAJOBzurn+yDKDZLhTu0ROIu9bFNkW/pSU+kR+A=;
 b=auLH4hTIn4KOunzEiSbEQ/XzuOKWi+w06OHNiluWmmjZY6UqqKAyyUiJfKNMM15cpC
 JsZia2Es9rqIn/ceqlolLV+DWrnNTADAuJIxa2xVP6HXKe/puTnv593aopocKJNT1Uk5
 3ccB88LpKndZOca6s9NZncMBJgCl+ilsuUOWGEiAeLB8rhBi9+FiDcWJhamhhkPLPgr6
 gUynvW1k38UkFgOFkOCv8VKPblq9kjsI6BAnlLN7UeOChnjAzVSPSITD8p2FCJZTR1nv
 St2s82wiag8PZfIRbZ3wyMXO5DgCmxoBFn5Jy00WpovV2TIBepslxr6t78F17yt81Zpv
 GIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770913303; x=1771518103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mgarlAJOBzurn+yDKDZLhTu0ROIu9bFNkW/pSU+kR+A=;
 b=TpsZ41VFstXVpvYrRyBGUKnwZDInQvTzSeTCid5AAZxM2BDs0MgMwTbgbp3QsocwoH
 05mU+5UH2BTaEd1Jw4ZBeeca+vsMkEnshDeGubYW/UE5dnDPwPJacO5U42k0zsKVWifA
 RrK50rCaiZZzyMk5nCqf8sQpJ5KAqeJO2CKNl880kOZ5URpbqwUKKCDHPU9Cia0zLJzo
 KWNIUHmswYt3ZiOgvwq3SA9geH6rWjCBEJAWh3TMF9UqAQU7eBy3INYylJFzIjTAZwmf
 sMNMdud5XknC017OQrd55R+sE7KJcBIA4QUciel1jtK9QzzO9ZNKOQJvTxFqGal27VJ4
 KYKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOPGvCDBmcMijdZP/94LH63FOuUuLwntb7JMAzIC3pCkPMOph24p7SSQgCpgbkXActCMAZeNjuSJ3Y@nongnu.org
X-Gm-Message-State: AOJu0YxERtPeWBUqR3Mnkwek89AtKzf5rJnzhtw4rPOWuUn28g6qStNx
 rQtiR1u1c+baaSM3WwKoCXrElU4naUvkrnWqp1+JJ3PgznTWlp4M72AhIEO44LD0GL0o62ah7SN
 CYjZGLvAlKX7uHvftSDAWPsfu0NQrXw+irqTd6Df0KA==
X-Gm-Gg: AZuq6aLOcBYb0Edc5U4GOdkcIobgNk5KQac4oKC0stgsg6xapBYjR9CDWRYw+g9rNvz
 kDiOarsZlI2hAEngV3E5FMS3cfkcTlKKCrf6pNx3/LxXD/udVaszqTabuHe5FhdaHqpL4HDZgJf
 SQL9KZSMdpAtz4bxq0ObuRgIZhe/bdv5BgwuEt3CqI1xl6AYtA3smyKJ3jxDg5ER9De9D0t09p9
 Xo+xhNYQ3PnS5/2D+VeHrzC434ueYT8o+mD7XCgDFf7VcWu6xj/jLIYSl+bh12grVHIQE6dhr1C
 NyBMthckzBiMIk6WtKQ0Dq1UDn2duDgR85q6NTJ5QyFtRWwXiJAB0ldVFQybAukzkzU=
X-Received: by 2002:a05:690c:dd6:b0:796:2ee6:3f8a with SMTP id
 00721157ae682-797376fc365mr32285907b3.69.1770913303210; Thu, 12 Feb 2026
 08:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20260212090801.999731-1-vsementsov@yandex-team.ru>
In-Reply-To: <20260212090801.999731-1-vsementsov@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Feb 2026 16:21:31 +0000
X-Gm-Features: AZwV_Qjp4DWp6uhJwDNBCGVbK_GzRfRFLSilf0jRGi89bkcsuAAjEdk9mznjOII
Message-ID: <CAFEAcA9oX5EGB5yQvrqVXvnDKcOtT4caXzvMa8OC5PudLKfvag@mail.gmail.com>
Subject: Re: [PULL 0/2] Block jobs patches
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, 
 jsnow@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Thu, 12 Feb 2026 at 09:08, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> The following changes since commit 44dba5a0c86fff68fdd013c29bba81d5a1e32825:
>
>   Merge tag 'pull-tpm-2026-02-10-1' of https://github.com/stefanberger/qemu-tpm into staging (2026-02-11 15:12:50 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/vsementsov/qemu.git tags/pull-block-jobs-2026-02-12
>
> for you to fetch changes up to 267d7ae99a1d3b5be9d3421db3bdf651cc18c7ab:
>
>   iotests: test active mirror with unaligned, small write zeroes op (2026-02-12 11:38:18 +0300)
>
> ----------------------------------------------------------------
> block: mirror: fix zero bitmap handling
>
> ----------------------------------------------------------------
> Fiona Ebner (2):
>       block/mirror: check range when setting zero bitmap for sync write
>       iotests: test active mirror with unaligned, small write zeroes op
>
>  block/mirror.c             |  9 ++++++---
>  tests/qemu-iotests/151     | 20 ++++++++++++++++++++
>  tests/qemu-iotests/151.out |  4 ++--
>  3 files changed, 28 insertions(+), 5 deletions(-)



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

