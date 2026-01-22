Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B4CC44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 09:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1virPX-0004Dw-R3; Thu, 22 Jan 2026 04:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1virPU-0004BL-KE
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:55:28 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1virPS-0002HK-WD
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:55:28 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b884d5c787bso7369766b.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 01:55:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769075725; cv=none;
 d=google.com; s=arc-20240605;
 b=Pk2hdcXNlXp2pRHud//OkuQk1rUoKFpJLwV9SIcq96HM46LgONRZ1iAlLcIatxv5xS
 If4sJ0pK4gcu2DZmzvHMLM/NgM7lM44bYCLG5ASGJ3Yz9YHtk7hmMQ0DxIHeuIscCPXx
 YoBG21MK+kKLDwBJJzB3INO9Kj6gysTPMP6sbyIAYrQYC32pqEeeMH/nBbET7rsb9YNT
 xEzXKT+SX8vVIUQHeHVnXiCpqD1iUl92JxpITwPSIbBpaCBl5BrBn7o/0P5B+h8ZbF1R
 toa4gje7EUzPIJ3OoMAxa9D0AbF2GgGnQ8WaKeCan7QXhCjfSiLXR2zKnW9Xsm4GLgeM
 w9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fqMiuFxFDrLsB2MyxctX3Vcy58t6wRGH486n+ABBGas=;
 fh=PsHUvoRLEZVs1fHqUS8bkGMiUYk7SAywQazIyFCl0Ok=;
 b=SCEvuToxdg0Bg51styJ0kUMXh3pa/PfZArCGNgbgpht6ut3Q/V1y54r3Y9iT/LZfnC
 of8CQXB7yMOysmOHdFg4pA/lcVYjINhgyfi1Dt1dgY1Szyr979sJ+G93fxPGsFyVHWRU
 srY2ptooqghaWKVGFymCvIVNz7a06HID6COMchi/3Au55Vyu56BQybzdHW1+seMWDXtt
 4zmI/VrubJ8mYOY3Lcx5OyVlGl6M2ampCmEKyiqGfbGBDE2lPfrdHyR/i7bg7tGHG06T
 tJNkoXc/3swwPjuxjLOdGwImWrNk5R2NxUTG8nXDifajvmsT84GTDfkMKPNRKOyqEiLo
 a/vg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769075725; x=1769680525; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fqMiuFxFDrLsB2MyxctX3Vcy58t6wRGH486n+ABBGas=;
 b=jf6mdP3eCwieSnEFRLoH6VxQFi1VrJHyyKICdCoGEmg/nb+e6x+QBATfpV/1PYB3w5
 mUZIKEH5BmFCpDpSA99hsVr/N+XzAHi6pBOIXfwScQrfCZwm8oNulPC1TTd0KRVl0jly
 JfNfMcrZ3KdBRj/nnkkJ6jTy1yYot0uuAeabQ9TD0S0ZA0nourlNLs4/hh+D0VnSZaso
 NQ8qT3LhS9rns1thRZu8/E6sfTCRjqjSeeiJDInbbgpOxy69iPt6BCKL209vVycSPufV
 /JFJ/8aTMS8vfWCMupxJTa4Mi9V2sJ/WZmac4L9msZj+cp5LBk4HfsvJGMVasexkkqM5
 DRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769075725; x=1769680525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fqMiuFxFDrLsB2MyxctX3Vcy58t6wRGH486n+ABBGas=;
 b=Z4iSg4mZYIAlzheJGgFr0Sjsiw94S91kLoueqMWOytcuCLaxBnK9wJkR8jJeRrnGIx
 IaSHXJZi6hznVfZqsw56YWef7hhoV7BnP0RId/hlykWn9feqoRac4/oApBtNyLSJXdNP
 jfKAuID6QsyMTobmK4mXjTig7rTzj+4p7r3yyPcKrKDAnTxusQ0aAW//4JX07h2RmD2w
 HzII0+c9sRRK5Y51MFbHCZ5/01cONqrG4vH/HgB1DSbDZf2nWmOnMqo1b2C2is5Hofhl
 U85fjBS0JvvUYx97R+7NYMJfU5MdbsEwO8rJgUJ+baroFCx4BRTui1nLucojzhietEEu
 8aJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY2ZlxdyMP+ZXYcsfhe1ImNek26KM2vUn2aRVz5n9vSevVbdcWAYRPXGNb9/fiYU1lTop1QFCcqej3@nongnu.org
X-Gm-Message-State: AOJu0Yz3HVbPdDx55neTtKo2js2YrT8Hao2JMemuUHY5cfoOh4essLJq
 jO2IkqVd2rBHaE4KuzI/AskLFayio0GFSkO79wtqGl2oZbPSd6mBmnYhxcdQRO8cJSeN7w8flMB
 muNIageYWdBDLQUNJusbbjbR6oFEEpPg=
X-Gm-Gg: AZuq6aI4Q2A6C1F5q4lfwmHi0QBL+cj4dbAGUOqOpCUwh1TwaFFCA+DCM5uC6GvFS6a
 Bc+HT5lat1O+yFH8m0mOIFbgCLoEA4i1ZerUmq5P2MpB3Lg5n012EVTQrg/5PPhS/GcKEje4mnG
 doHwhoxzAUbB+rsjb7r7K2kE99aHhR5tOHTjFK223eBhLY/TE+QbNv5iLO/vmyGJm1bA/Vcbbvh
 +lDT7e8ImG9ba7/pV73IVGdBqsvp5htMVV895b+Fc7dbRwqOkpvVLSHNg3kGW9Rw+NHWB4=
X-Received: by 2002:a17:907:1c96:b0:b87:e58:e37d with SMTP id
 a640c23a62f3a-b8796b7dfb7mr1826221266b.48.1769075724602; Thu, 22 Jan 2026
 01:55:24 -0800 (PST)
MIME-Version: 1.0
References: <20260117-colo_unit_test_multifd-v2-0-ab521777fa51@web.de>
 <20260117-colo_unit_test_multifd-v2-2-ab521777fa51@web.de>
 <aW-8QNQJ3PvBD35r@x1.local>
In-Reply-To: <aW-8QNQJ3PvBD35r@x1.local>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 22 Jan 2026 17:54:48 +0800
X-Gm-Features: AZwV_Qgsfqo9Hs8wX2IE3HKECNtulveOPancMWHMc3lu8msKIfKtAVDoDsC0_tI
Message-ID: <CAK3tnvL3=0HtFb+0Yx0B+sf4-2LMtBN2dfkmHa8e6TaOc3egmw@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] MAINTAINERS: Remove Hailiang Zhang from COLO
 migration framework
To: Peter Xu <peterx@redhat.com>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Jan 21, 2026 at 1:33=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Sat, Jan 17, 2026 at 03:09:09PM +0100, Lukas Straub wrote:
> > His last email to the mailing list is from December 2021:
> > https://lore.kernel.org/qemu-devel/20211214075424.6920-1-zhanghailiang@=
xfusion.com/
> >
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>

Reviewed-by: Zhang Chen <zhangckid@gmail.com>

> --
> Peter Xu
>

