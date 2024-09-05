Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D9BCD5BC9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 15:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smEOD-0004Rs-Rk; Thu, 05 Sep 2024 11:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1smEOC-0004KI-5I
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:27:16 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1smEOA-0006Bz-Jf
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 11:27:15 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f51b67e16dso11214511fa.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 08:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725550033; x=1726154833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXahTLAYlsj1yDnt7fXtBg+nwUlBAm4L5aEnBZ7qjqs=;
 b=pzsZCnJmsOb70577jbX8Xkm4tC04t3SqW6xOVQl5pZ3537tsOMJIbsgFaf6NMFSSRE
 ps/eFR0akQa8ywa7cdl6Z+b0+7C1IM5MgYDH/m5fNGQmgu2zQzph89TL8X6BWwSUthu3
 XXUVRRarVuVcQkipoMjozd08UdF9r6CGBElEaMOWanJDvhq7/Mi1/w3xEc+Tn4O9j0I8
 IZUb8jrcrm+Xtwrf/sY3MDVLDriOY3VTvFxCZES9KD8mw31w+BZmj72y7Cn+1MKBo66d
 w74pvg21pHliSO1ebSImJi82qgEseVHEuh0nxBYPuak2WtRdwiWz5rHwb+d0++IgP059
 AeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725550033; x=1726154833;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tXahTLAYlsj1yDnt7fXtBg+nwUlBAm4L5aEnBZ7qjqs=;
 b=VYAOVXuFIIjVvNZ+f80Kry+fdRVu7ZQsZKr0MXr0YB/NVacm4jqgBFMFdXjrlDYivj
 ZjvCefni6+7JrhFCL3B3Xg01p1vGzZEF32U4oUPhoGrXzm+qoXWiWK/Gthe3Ck/sCIWd
 oTIhh3f7ohmMWpYEJnNWu+VxVvaSDnrrj/2y77CDgVdCi6CHlMoHdHjXDbahb7KE7tJg
 uJeA6ARLqcDo+qWZ/jM3dX6p+ySV+J5FgRFKXN/ryT/3IFO/k5Wbj4tSv7dI7g8TN02H
 8lCy5zIHfd78pbdSQ96gmmX58FBbt4BSLoPP9dwyASYExSzjcCZa+W8qEq3z4sD0ZBg7
 NHdw==
X-Gm-Message-State: AOJu0YzqtsOLuUmTD3dsE4U8F8b1noKZ8We2VBRILv43dKGoWaz0SQUq
 QdqrZOY1/WRejbJbqy33BBo4Gh2zj+gYz9sqUizDMTcfLhhWyg/o3Ef/BbbzfFg=
X-Google-Smtp-Source: AGHT+IEM0T5uvpcYpf6SGZUwlOtyGRMRe57XF5xU31d2kZYEy5Vqp0Dh8WwlrDhpk1Nm2Usnrx0dbw==
X-Received: by 2002:a05:651c:221a:b0:2f0:1f06:2b43 with SMTP id
 38308e7fff4ca-2f64d570aeemr60148671fa.41.1725550032042; 
 Thu, 05 Sep 2024 08:27:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3cc6a5a40sm1346091a12.87.2024.09.05.08.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 08:27:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B9DB55F8BA;
 Thu,  5 Sep 2024 16:27:10 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Rowan Hart <rowanbhart@gmail.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>
Subject: Re: [PATCH v3 0/2] plugins: add plugin API to read guest memory
In-Reply-To: <20240827215329.248434-1-rowanbhart@gmail.com> (Rowan Hart's
 message of "Tue, 27 Aug 2024 14:53:27 -0700")
References: <20240827215329.248434-1-rowanbhart@gmail.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Thu, 05 Sep 2024 16:27:10 +0100
Message-ID: <87tteurui9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x233.google.com
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

Rowan Hart <rowanbhart@gmail.com> writes:

> This patch adds one API function to the QEMU plugin API
>
> bool qemu_plugin_read_memory_vaddr(vaddr, GByteArray *, size_t);
>
> The API allows reading memory from an arbitrary guest virtual
> address, which is useful for many things but the motivating examples
> are:

Queued to plugins/next with a minor tweak to the cpu_memory_rw_debug
call.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

