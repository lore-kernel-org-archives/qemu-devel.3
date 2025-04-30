Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70851C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8pW-0000FC-2z; Wed, 30 Apr 2025 10:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uA8pB-0000Ci-Ff
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:54:22 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uA8p8-0002F0-Fy
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:54:12 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-acb5ec407b1so1183706266b.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746024847; x=1746629647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+92xMN9Y45fxRWHmYk42+bc5VvQ4fHNq1jKXEpkmFY=;
 b=W+gP8bhQ7L4fp+Sw80KU9MBrZD1PtXwPdfV8WXSeTWIKGt2sbRfssJQ66/bjO+/ryF
 fHXu4sPnxiaao1inQIBiuzbSNJqQabJiHFHJlvpA+xME4oBVQfOpwh4Gi4zi5iX28fTs
 QSyaxK5XTvQadP03hiZ6sbdMdPLLLBcmbVQcJVhaap4vUY3Ahxq2ucDjzug3d4aZFDNE
 XLJnXn4/xHYAHR0cxikXnfCj1/v8iFLpolUfJcsH9/lNfiTLkqWVlDdZrWjlIxwENzql
 Q0x/KI74j0mplUXioBhmVgys7Bc6UMVqird5iqItoj1Aa2uXjgtk9Yb5014KHISCTKQ/
 mlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746024847; x=1746629647;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B+92xMN9Y45fxRWHmYk42+bc5VvQ4fHNq1jKXEpkmFY=;
 b=MeawY7k7x8/6hxpFYNkjCua6Ryo/oGJxk3L1GifwKFWws8RIn++Asp1dvfbfaDBoeg
 aO4EXa6p79RwAflB4MeUrbg3fXZKtScy++fl6UbL+F4S8bwnO40l1/LxHAITnBJ39lDY
 Kb2ouMM47975BU+sOT/JFUaPTlMvSRZbtonL63iJKOdtPjSaOjlA4h0Vdo6I39HXVBnp
 JgpqlfMeT4A6qFpUF81jSTrgMS+R3Ii8XaNLSrTWt8z4aY4/M3Lk94X1fiiNhJbrQobs
 UiRcsmLiyr54o8dhZ5OCO+IEQPs0b2v4tbU4RjjvivJ1sIRGia5oeE5B3VBm6exv8krd
 9U3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbUCzxGoSs8KT/o2uXR2hRguXaQNtXVsWsBUuszT7dmP8ovcy4xPY2tzCQZRUJB1+yhApXAH0h/YUf@nongnu.org
X-Gm-Message-State: AOJu0YxeglDSA1sZvfJmfH6vFnJfEZ4FN0lem2OgEHUfg7KZLEDZVNFx
 0WGzc7UdTZHLIhPeRLnwgmEl72dtGDNLqbm9JR8H/lVOjsyBL2tmr6u1Fnmj9KCQnR2lXxGj6vv
 RBbc=
X-Gm-Gg: ASbGncsXLKYgiAsxPjTlL4PyJ/LO28alKEZzyS8PeQO+MWGigbwVN+vUm8yEWMeTjL4
 YNtaMqBwL5ecKU974JSxd9/HYgKTnPl1fdNzjgPj+kuEspiYorAxjgY/w657XG7hgYOWE/5gvf4
 WLewkswBrGXrYDd+zKcAUbw8GDEp1s3sIPF3jsprAqKU3iWhWSmMWZP6RyhKqUnx/ySPvOBbORI
 i2ZbE0Ft3VDN4upIsKpkc2gwFLoxZDF5nv50pKals/lc0D+ji7ZiVGJZIYhkN5A7bP9nOLLPp8A
 iWsiGYmjyMMfcqOdQ2CkeoQXvgJ9WkQjj4qLP8fV/R7cySRQmam9ig==
X-Google-Smtp-Source: AGHT+IHw1n8hOOC+FIuRt7dZgS/vS/2EWlnk5LSfzsvrCEWOcZMVkGZFLshnFM/iYczssXZtToAskA==
X-Received: by 2002:a17:907:2d9f:b0:ace:3a35:43f2 with SMTP id
 a640c23a62f3a-acee215d9d2mr280135566b.6.1746024847425; 
 Wed, 30 Apr 2025 07:54:07 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acebe215210sm358788266b.68.2025.04.30.07.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:54:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C8CF5F8BB;
 Wed, 30 Apr 2025 15:54:06 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Laurent Vivier
 <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v2] tests/qtest/libqos: Avoid double swapping when using
 modern virtio
In-Reply-To: <20250430132817.610903-1-thuth@redhat.com> (Thomas Huth's message
 of "Wed, 30 Apr 2025 15:28:17 +0200")
References: <20250430132817.610903-1-thuth@redhat.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 30 Apr 2025 15:54:05 +0100
Message-ID: <87v7ql1z02.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> The logic in the qvirtio_read/write function is rather a headache,
> involving byte-swapping when the target is big endian, just to
> maybe involve another byte-swapping  in the qtest_read/write
> function immediately afterwards (on the QEMU side). Let's do it in
> a more obvious way here: For virtio 1.0, we know that the values have
> to be little endian, so let's read/write the bytes in that well known
> order here.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

