Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2994C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 12:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tevcL-0000lP-Ml; Mon, 03 Feb 2025 07:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tevcJ-0000l0-F4
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:31:55 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tevcH-0004ap-Ji
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 07:31:55 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ab6ed8a3f6aso642043066b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 04:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738585911; x=1739190711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVfmXSGUEpW7lnI04Q/GoWBLwAa/8jZUce6bIXYHh2o=;
 b=EwKNuNYle+MYcS2HVRz9IYjQZ7suv5JqwvUolXSbUpEFeqOA79aLyF9OvQaep/LnIK
 D42HSuGsLwjmn8YM7yyWAOztZcKwgdfLoBTCuZIYrdGJ6bc5YMUe2somLo6MB/mfp0GO
 olP2imNH+6bdDUTI0QyHQ0CT+tZThmR1NmPocI8V6moXOSHhHb6zC/5pg3LkILW/dhlU
 DTM8CqBFuHhql501FcHkvstkUStRkoJ/PQUEqXdLC/jHEaDAjWH0HydYQ/AHLXFefh2X
 duSzrheNMwl9CHHET15NFiu+LCwwwPjz8Gd/4Bm44mxS6Mx1ZOX/tFP1jUDeyrtzo+aW
 fA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738585911; x=1739190711;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wVfmXSGUEpW7lnI04Q/GoWBLwAa/8jZUce6bIXYHh2o=;
 b=QrEtGiUrxKDI1pRjFSG2XEyuDDGJCZ76ZlU+mGZTRoJGdiyP43+o1CbBDJfkR4ah/d
 0Dlcn1YfWDGNBZ5oB7RFUYZGrvTIHMx95FvxTF7qK6Ovd2cy/cmgAk1DV2KRCsQhuiDf
 pA6uW4jhT+i24qZmA07qsBoiy06eV2zAf6elgyjKgZbBEvK48Al+vaHIuSIfPwyF+DbR
 sKXYvdPl7JXpvvKXWO3TiZmbkBfMY9F8G7uDWMJtEh9Z4MtrS7FPjWgXOwoO61ehqF+B
 ZuVNg7+ZLdOBB7oiS5iMkFpvimvYzYofrYyuH7UJQ2zsTLu9w7Co4mWeUtbiiTwmsC4S
 hbhg==
X-Gm-Message-State: AOJu0Yzu5vZ88cjUtsY4djxJLdGgdDgZuQK03k3PFexccGEVBSEvEsle
 JRKHsFI/P6qeF4IB/QaF2BI8SXpFxfbAJig8LCm+Dxzw/Gb4SWE7LI8t4l02unc=
X-Gm-Gg: ASbGncsJzCLNF8G+HEHEqlfA70TnUFjrWAZ51/LUcKqm1cPEPImrrRJzPXL1aTm3CV8
 DTZ86W8dTtoWkuHLCXi8gulAhmYe/m2t0UVd3v9vkRRj9ovlIPgx9t9lUb8ew2xJeQGRMiDWFmx
 l0PUj3pBvQL8aUb4J/UIbSCY0r7V80JrFld/Rv5ipaxeeguc66LsrdgKCh75sP6CycWgdB+/nKM
 C9uNppuQ9HZkSAjALUIRpxLVabQKwFGWurkXPp+HIUQcHB9nFbVDkaWZ0+tyZHhXxTSSBy8Seua
 EedTa4KEbrjstLnz7g==
X-Google-Smtp-Source: AGHT+IEC48JD6hCawlVyzK1XH+1/BIvInCoXSCDdhvRza5h3DwttccAPU6R+tA8Ilp4E3uoCkpZIRw==
X-Received: by 2002:a17:907:94d1:b0:ab6:eec9:5c08 with SMTP id
 a640c23a62f3a-ab6eec95d8emr1790843966b.10.1738585911398; 
 Mon, 03 Feb 2025 04:31:51 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e49ff30bsm739244166b.88.2025.02.03.04.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 04:31:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D43E95F8BF;
 Mon,  3 Feb 2025 12:31:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk,  berrange@redhat.com,  philmd@linaro.org,
 thuth@redhat.com
Subject: Re: [PATCH v2 09/14] gitlab: Replace aarch64 with arm in
 cross-i686-tci build
In-Reply-To: <20250203031821.741477-10-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 2 Feb 2025 19:18:16 -0800")
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-10-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 12:31:49 +0000
Message-ID: <878qqndxai.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Configuration of 64-bit host on 32-bit guest will shortly
> be denied.  Use a 32-bit guest instead.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

