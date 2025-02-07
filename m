Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FE2C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQaw-0003lO-Mo; Fri, 07 Feb 2025 10:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQav-0003lC-Sx
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:48:41 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQau-0001pS-Aw
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:48:41 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso13560625e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738943318; x=1739548118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2QHRfL/YIx9O75iw1w41+zjShq/a4ncHEkq2sWr7n8Y=;
 b=qnCV8anQ+hV9AjAJvbAmJQDUiLgRT+FR9S7MySTNSVHF85gok3LKuyBOPTf/kINGip
 aIONqlGHclLw0re550myrQ8BoojnLk7RDqB7TrOfypvQaLxkntvt7PsyjPI4KFHDn4Vb
 otVkXw7Nd+l1bQQmqNGx2DXvT/o5F9bNUFQQCqc2CCVrxTn9/l/+ixEoQ8GIlRIB3w+M
 X1f7pEVGXTPmvz32dNcMhQI9JR4g7VkwMxssfeWeoI22d1fj9OqeNec1G0k0DJelxoGw
 WfKjMG/PGr26CmWOfEo0QC6GTFr5wlzQBuAbmYG7k4RCWxPPpTgZnEyfp8+Th9Z70n+V
 u8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738943318; x=1739548118;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2QHRfL/YIx9O75iw1w41+zjShq/a4ncHEkq2sWr7n8Y=;
 b=PJarrY8PTOTHqnnlHlpjCGY4brgFOdutFBgmfr1/wo+rS9oidKTBFydR1gsjuO2iDb
 s8oJhW9fd/+GMZQ/q7xnctW3HkWcNrUgsN4y0D/yiirCzGdJgDAgrahG8QNR8X309TMG
 dm/JPWneUIOLBSIe039as60O7yTzXJ/K7eIeIa8PKXFHJLMasvLOp26icCGqEz5BHRIF
 rFNOISjfzXZxkvWPaNSfg0Kd/SHV/sDQKtDZDS6AkWNJ5fxuVfoKDnE+LOi3UCOlD6uv
 qqqzfsR+BjVJruA0jvxgmYWkNQ73ObusyGlp/Ehxl630XjdEksw8P3JDSzIXnV1XwSbn
 b5hg==
X-Gm-Message-State: AOJu0YxO0cKJFJH9fRQuTf5J5dmOhHGVUnLwnE2BDTpIshV5StQJtUHm
 pKe8Q5dVsqCRbzPTbllI9Ykt0GHKEiDTzZLJxmIM2m6WZfdOFRprYgkkDTbv71zX5CgO/k7rh8q
 m9Wg=
X-Gm-Gg: ASbGncvPgRkXFt4hVIPIp0/4MlYYEC+8OCr5o3e8l88G+1irBPdJi72WOg+szWhccCb
 rmKQh+oWFPs45eVl2xGhNZQyKjDXMf5Z3ltZoYva2Cp0wyxJqUXR7eKGekQ/kvs1tmufWrdGUMl
 5XqWfPwDHPB2eXuAl5XJ6R9UZoYF40mELFP07fioxXFmF07cjJd0zzkdFQHe797WWKQJd2xc014
 cSl1dxD5KTyz1D99RuvRixmqykBA9gmDvynqMG5cL9wIsxt5hbt6HrOpS24zwGKrr9aJ/fE3OI6
 LYGBzf5Z1Ur6RnaPtg==
X-Google-Smtp-Source: AGHT+IHVosK/MrF4M37ekClYkkYMNu/Qv+zfbcdGM2oUDiowzdZpGpfdBdOrX1f/7IkAe/MrXWQyyQ==
X-Received: by 2002:a05:600c:4e0c:b0:42c:b8c9:16c8 with SMTP id
 5b1f17b1804b1-439255b7dd6mr25559095e9.10.1738943318121; 
 Fri, 07 Feb 2025 07:48:38 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391da9652bsm60277095e9.2.2025.02.07.07.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:48:37 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ACBE45F76B;
 Fri,  7 Feb 2025 15:48:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] tests/functional: Convert the aarch64 xen test to the
 functional framework
In-Reply-To: <20250207144409.220006-1-thuth@redhat.com> (Thomas Huth's message
 of "Fri, 7 Feb 2025 15:44:08 +0100")
References: <20250207144409.220006-1-thuth@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 07 Feb 2025 15:48:36 +0000
Message-ID: <87ikplrc17.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> This test just needs the adaption for the asset handling, then
> we can move it to the functional framework.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

