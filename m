Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B755EC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 21:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhFfq-0001Ix-QL; Mon, 04 Mar 2024 16:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhFfl-0001IE-CI
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 16:16:37 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhFfh-0007lw-S8
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 16:16:31 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412e586b631so9593365e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 13:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709586988; x=1710191788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8kee9wEy956r008yNvlAkS38P5YGtHd0kE6+O1JBO4=;
 b=BJAr6aU0fp+mPRbox97b+ew+1apb3edDy6WC7zauozPAy1TotaplDzrksKZmqPuCaD
 fgH/N6O14eYGytI6Sy3pxhs5y7Kdm84gMDldO0VTMAyCSyQI4uhy6wd7axYX0yKu051d
 Ikv4JSAv0QC3ufuiic6wLOT1od+9lDNxTA7KgkFKvQrizMRFuU0xnCnbjdOndS5qKsx2
 hKA03fusktn0mjSOP7IB5sVpDsIKaSpcsRiGaXLT1GGYXQWkP9TiUdSnRvnUp+Wsf/w1
 avOSFA6iq8dYHvCH3x3urXnXsGe2VpHoMPH+WroCoT3XuJl/kkvMZIwUctmQxa1TLTk0
 vgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709586988; x=1710191788;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W8kee9wEy956r008yNvlAkS38P5YGtHd0kE6+O1JBO4=;
 b=cVYNDlwEraIRQ5BIwiBg5uK2lnjHk2z+km3zmkKTfCX0T8uSWRFEWQGsF6G8xqoth7
 WdfhTfIqoUrit40To4PY3MELm4BzSYEViSE/VX53VpIeQXXEE+dQ7kqndhMPxn0npP+G
 R60iTBlD1kuS5egiUkJ2QC/MDkWwfcbqXPMIDu7MLa/ZexduswJBP0LIKCOE0CJCFykS
 nN3ohBi8upEC5LYdj8bYV2HnwRKJkHSiBVcNx0bZluITlaPo1JqldSKAXSmkjk2w+5eU
 t/4sch5yTxZOCXRPiXjHCGUsqPtlrkNak0R5EMHnuhyX9HMsJg2jphosYQtjQ1FVgJVs
 uioA==
X-Gm-Message-State: AOJu0YynTMDHzHO+A5GBf/ijpkflGPfaTDxXt0A5uVRqalPgBeSdPhL0
 76PfPBQ/NX7W3cj0Tc3iiyxopfJc7AVl0SMq/s6jY4FroZiyjIfqm6o+OaBUs74=
X-Google-Smtp-Source: AGHT+IFFAUuazGW97B+pcXFOylb0po9KbhCr0WoK63zREm8Zwpan9V+pkaDgUta077JLlnOa4sY4Pg==
X-Received: by 2002:a05:600c:3107:b0:412:b8cf:150b with SMTP id
 g7-20020a05600c310700b00412b8cf150bmr8167829wmo.10.1709586987929; 
 Mon, 04 Mar 2024 13:16:27 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v8-20020a05600c444800b00412eaa85e74sm545648wmn.5.2024.03.04.13.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 13:16:27 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 586F65F881;
 Mon,  4 Mar 2024 21:16:27 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Wainer dos Santos Moschetta
 <wainersm@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/2] Fix CI build on Free BSD 13
In-Reply-To: <20240304144456.3825935-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 4 Mar 2024 14:44:54 +0000")
References: <20240304144456.3825935-1-berrange@redhat.com>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Mon, 04 Mar 2024 21:16:27 +0000
Message-ID: <87jzmhwvdg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> FreeBSD seems to have prematurely purged the 13.2 images from gcloud,
> despite 13.3 not being announced until tomorrow. Historically the old
> images were left available for quite some time, until we noticed ports
> failing due to missing symbols. Either way we need to update to 13.3
>
> This exposed a clang bug so needs a workaround adding too.

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

