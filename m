Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82661C197BF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 22:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnmIT-0005fW-CC; Thu, 27 Feb 2025 17:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnmIR-0005c7-4v
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:23:59 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnmIP-0002Sw-GX
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:23:58 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4399a1eada3so13781115e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 14:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740695035; x=1741299835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTVruDrzlsxWEGIPkh5xhJ0OM14c/uiOTga3WBMPRI4=;
 b=dTFKzAIrEg6EQnA7IKnS8px40rYw2iFt8uQtzCVNa/PIz9o5Y8EpBfnQgrXfU9MuRI
 eTzm11Gd4lVawEVmWwlTa7khTOZiJLhlS/S5PjeonRv79HoSgONc0Zb2SrF+wLpkzAOr
 e6jYmlXE2HgF4tQfVFlToaFQqR3ZXbO6oWCFCOPnM2ZvvOgkd/lLqH0SjzUhzmAw6NQR
 vef65N7PdZgEL7+ol5JS/r4nwwvliE7RpwroT+8tk6555x3T1iLKVL2n08o5AbMnbzql
 gOme7PG5RNAFiWunyRWP7Kg9FZoikF4uIgOaAzGyiKhVTP24yvYP4EpJ/HAxXcY9Kr7W
 DXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740695035; x=1741299835;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DTVruDrzlsxWEGIPkh5xhJ0OM14c/uiOTga3WBMPRI4=;
 b=mfOeQ7OHTWWZ2dRexSuC/hOwrDSkSZ0gtSmvtUP303vecWEMquktYQAqr7AjYq9/L/
 i1oTPAw9QHJEmAb0Mcz9j8TezA3cxf1TJvxPh/vJhXHH0HkyD/0v4MsXRArFypN3k2ez
 Svx2GWKDE6GoFsVnCRAUW32R4105fPGsEsgk18woZ2w7SM4ysz2HaMfWLmPAJSBRCU1q
 46GqYJtP5Bf9guiBhEWJ/wxKghDF1DiVBsDnXDp5PCJ5McYWw6WKSG8R1qR3dYTVo6hy
 vvo0paKm1LqNFGIST9yIt9HPJDijbIFZenxa7Z9aqBqZx3B2E1uX6fa+DJPwGY1NVY+3
 KQdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYsbg4KYEK91H4VAY6ZHJOkbYFvXjR0cd/bhWgxp1VSBJPFl2XsX5yvec/RBevaNX2wBS+dbOs959T@nongnu.org
X-Gm-Message-State: AOJu0Yzdp3ngznDhnKVXvpP60uFeZq34W2ILGrUoycgwg6RZmu9OVw4V
 T/AxLCev3WH4TIvTaap9K/HbOKO4ZUHQce193qR1Dut5n/nRg82y+/XmZ4pSdzE=
X-Gm-Gg: ASbGncsm8QN4kgHyZuM80pLunTcDefPfqMV10mz96WyLO3nERbIHgDBbOvuyIHdu7to
 ZT/Hfok7ZUQQnzdC/b+MdD6Gye1ew2i5zQY+9Q2EsUrvxL5HjngpEkZuOOGa0UjF4o/Ue7YoHb9
 ufNQCjXBONVSMOQxEkwzz60j3b4OJ/GTszSeNO7lc4Z/m53/Ku3qCKff7AmGF3dwfk49XD8nxTg
 p8rZaKlIqBlLLxVzwm0EiDWdEo2jI/K9Sfj3zWZ5DOpfg66i0Ym1fAAHnKvj0CNBVVhmIIdSw1J
 w2Tsuut6CCmdSKN08/lYOVif6yt0
X-Google-Smtp-Source: AGHT+IEVpZdQaANVpM5k5ALKX+pvIi7tsaSnpoAKQuKKGGW1xqHyshMv7cso9OAiZFtyaORpd2Hh2w==
X-Received: by 2002:a05:600c:5494:b0:439:30bd:7df9 with SMTP id
 5b1f17b1804b1-43ba6703bd2mr6871815e9.9.1740695035087; 
 Thu, 27 Feb 2025 14:23:55 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b7a28bf64sm35397115e9.39.2025.02.27.14.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 14:23:54 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C1E8B5F929;
 Thu, 27 Feb 2025 22:23:53 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/tcg: Suppress compiler false-positive warning on
 sha1.c
In-Reply-To: <20250227141343.1675415-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 27 Feb 2025 14:13:43 +0000")
References: <20250227141343.1675415-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.9; emacs 29.4
Date: Thu, 27 Feb 2025 22:23:53 +0000
Message-ID: <87a5a7vxfq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> GCC versions at least 12 through 15 incorrectly report a warning
> about code in sha1.c:
>
> tests/tcg/multiarch/sha1.c:161:13: warning: =E2=80=98SHA1Transform=E2=80=
=99 reading 64 bytes from a region of size 0 [-Wstringop-overread]
>   161 |             SHA1Transform(context->state, &data[i]);
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> This is a piece of stock library code for doing SHA1 which we've
> simply copied, rather than writing ourselves. The bug has been
> reported to upstream GCC (about a different library's use of this
> code):
>  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D106709
>
> For our test case, since this isn't our original code and there isn't
> actually a bug in it, suppress the incorrect warning rather than
> trying to modify the code to work around the compiler issue.

Queued to maintainer/for-10.0-softfreeze, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

