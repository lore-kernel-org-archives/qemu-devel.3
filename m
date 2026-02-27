Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD20FEFB47
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvxg4-0000Pt-RB; Fri, 27 Feb 2026 08:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvxg3-0000Pj-Bx
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:14:43 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvxg1-0006F3-SM
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:14:43 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64aea64bf15so1705719d50.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 05:14:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772198079; cv=none;
 d=google.com; s=arc-20240605;
 b=SyaTXqr+/fpUZKB8J7mckHCPT2ndkfqlq5u6TL3WZiANzNQ3dvdgK8GSu34+3L6HYX
 2fmCBr7sm60gssGkQ+66NJ993ECEV9q8MAkNp19wdHDC1+BtN8wHBbHyu8Mb9v3IOA8k
 JnyGI1+6gg8Q/jeW8HeZzl8R5nKZwGwLHliRumvdsBcZ1yQiGt8ckoZeOvm9MYeQOlQL
 W6Pb5B3an77Bmp6PFeJTOvuS7kbOblvwb7naQDfLAoCNjII41Osn8BYQoD4A6U2qFUz/
 kUyXRsPeec7h4lCTt4XndkTsaqlEZipmQc6wylP1EWuKTQlcft6bJes1mxCdPm3+eqWP
 NEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K3fLwXB1he2rPSs4SFGDoWtWsvIn6bbN1tetlGpNGiM=;
 fh=1oW3mullCo6C+FsMss+A6yUoqCfV978yZ8v1/qRK2qI=;
 b=fe4t7G9x2cnO9Mqufcs2XwNdbLkHbO4Bj1cDDaM1GVzPUGrpeVUBzRenTTYTPK9024
 3mOfSQSLrIXIRojJT3yqsftxDpF90I9JTwy5Ilqegu4S5W4hX2Tv7xckJ4E448YPzwv3
 8Exsz6mcsD896ZkslH96T6/SuIleF7n25VFe+Qf0DL+oer0Qgh6AfWuvx0d0kKD72OzM
 GsboWo49laueOtHA9l11Esc+aYP4uwsuZTVaQKy4rO2ccumYSbbi4lexVC+YxfNnTvkS
 ns8LE/SZtzIGhdx2g/kTwslg/z/bmGkxzE7wtTnRiMnUFb9kjwXdYOc+AZxGmB67PGaI
 +ung==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772198079; x=1772802879; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K3fLwXB1he2rPSs4SFGDoWtWsvIn6bbN1tetlGpNGiM=;
 b=aCfS03hIjyBvpgjBeVfuqfrzwB8RXs3MNB4VJf55AQ36wgSelPN+eodQQj/+tbuYeU
 redqED4lC44CDZTj9Wzy4yrNMI9JRrwu6hScqhh03zER1hsedaV2FRV1QGyEqHiaJ0uX
 ZrlsgKznLZCDvHMYB/Dq1XlCTnHs2TzRYKzLXYuzhXaxzghdjG8NMRYFxrdGV8wQU2AK
 v28U83CgPY+X/J64Eoqw96BqZxN7I+ydBjToAwK9yqWsXDKgf1C+luGDEfiWS73zlnlI
 VeFqxF4gslniIDJSQ5Qt7NuwcmIhSwGXHOJXYHkPLc/MP1jXJ/efaIWF33fbo331F+sH
 lxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772198079; x=1772802879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3fLwXB1he2rPSs4SFGDoWtWsvIn6bbN1tetlGpNGiM=;
 b=sPWPQ6R5NuLkf5G0xL7byIFxFS6oiPJJrELcoQapBZhesKs5nLulUkLBSKazH8ErRx
 LwnHdpd8Z7vegJ4jGWJlvsmdqDdWVPZVaTBi1eCgx4UVUpXc/hp13dSoS0S3NZEk9/4B
 O5Z4oF7dsfOTe1mFEoWarqAXVoLqfEJxTnsDf2QZC+qm30cbZQvjinRlqJPjPa8utEdC
 E91wW8SLjphErge7Qf3gXk/xmi2sxmMemyxiZIwRGA7GzursgGCcUXkihX67fVcxP/V7
 3dFhC4xbSUUQ4E/smStKHJaA1UtBqP2uuHCoSeqUoOLYtD+8GJuejafza9OkocueoGpi
 LiQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLj4QySop/ZZQdeJNQPHjZlublK8tUm7WoTo1MNEJGfCel4CF5WivgQwyHYrjuoqQfyVwD+Uo1V2UW@nongnu.org
X-Gm-Message-State: AOJu0YxbsWQ+82Y3L7WGnR+CKJuRaIgZ6mIH2yV7md0bLWsMv3vFOkMU
 //qRFGb10mYZ3B/NlYWUJ84WhQY9rV0jDCZ7cpy6vtlu1Nyw2YkkCpZfY4fAiCiZ9W0kYK1bR0S
 f+Qsp1Pf8LcZEvILxmTFwnbtrmHquAuahUQwu5/HUNQ==
X-Gm-Gg: ATEYQzwZZTQt6+A/qLskt3WHTjFa2hGjuuctASw5SQjXckV2V1+3PoUhcxkyLnLTicM
 /duTbkfQQ0HFIBR3tu45mXJF0vT4mLG8XnauL3DBbzlUpTEjR/0Mg7EtnJPSTDKxm9ixRRg3Su9
 3SXtFNLu0GQ7MtIIi7/fM3KFSu0ur+WGLJSK5uYR7WzAs+GtoCbh/juXGDXSYsCa9mI6dk/b41K
 Q8g5rhgC8absiJln/z9S8bP8d54jFgHg2BJ8HA//WI4pE/Y7Z883egPHddp4R1yA4AuAMf/wbU9
 Os4ML/8LMW930xHbGrpaaSQiNfN09EOW2X7yJ8Tt9D+dGyirHaJSLqFM3pY8BZRKnC4=
X-Received: by 2002:a53:ee51:0:b0:64a:d294:e502 with SMTP id
 956f58d0204a3-64cc2378a3fmr1714512d50.66.1772198078551; Fri, 27 Feb 2026
 05:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
 <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
 <20260219131751.4e4e4e0e@imammedo> <aZ8THMubft44Q3E-@redhat.com>
 <20260226135648.4c1a4009@imammedo> <878qced4xx.fsf@pond.sub.org>
 <20260227104227.3d84f0d7@imammedo> <87ikbi9yky.fsf@pond.sub.org>
In-Reply-To: <87ikbi9yky.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Feb 2026 13:14:26 +0000
X-Gm-Features: AaiRm52c2lwviW0Xz1vv6BxHbmGiGBhHvWpffiNEu8fceG_jWmjnf9P2iXIdMas
Message-ID: <CAFEAcA_dXNiXCeYdBimBMR-hWvt6+DB1FdJ9iZ5q8zoejyRWeA@mail.gmail.com>
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
To: Markus Armbruster <armbru@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com, 
 pbonzini@redhat.com, shannon.zhaosl@gmail.com, philmd@linaro.org, 
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 27 Feb 2026 at 12:10, Markus Armbruster <armbru@redhat.com> wrote:
> The larger problem is that we generally fail at documenting device and
> machine properties.  I'm not asking you to boil that ocean :)
>
> The narrow problem is providing guidance on watchdog configuration.
> What and where?
>
> Regarding where: you proposed to add a machine property of QAPI enum
> type.
>
> The property can have a description, and you give it one.  Sadly, it's
> basically invisible.  As far as I know, the only way you can get at it
> is qom-list-properties and such.  I doubt anybody is going to read the
> description there.

I think it also will appear if you run e.g.
 qemu-system-arm -M virt,help

(which produces a list of all properties with their short descriptions)

For board-specific properties, we should be documenting these in
the manual page for the board. For instance "virt" does that here:
 https://www.qemu.org/docs/master/system/arm/virt.html#machine-specific-options

For the global machine options, I don't think we have a place where we
document those. If we did, we should perhaps have each board's page
also link to the global-options page.

-- PMM

