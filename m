Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C6ECD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNXT-0000jg-SC; Tue, 19 May 2026 12:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wPNXG-0000iA-0A
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:43:18 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wPNXB-0006Ly-S1
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:43:11 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso2334124f8f.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779208987; x=1779813787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J5Ir364kNJg3p2BqrOnWJzIx6akY8iN2ohGX2P957j0=;
 b=tTlCM+8uDLDdh63pNRPGMDLa6fX294G74+JlbjPaDY8YATlPWpsg4ElJZ0QLKcXabP
 Tp/L1foVCAPvAOCJ/fylUxnymvnuDykvAA/M7zcd6PxHJXL4pwI+/jyFtlfDhhIw77C2
 zkVcQJJq+3SnT5+Wqhp1Fp1JqIylh4hzHiHhtlyYbH88iAhMo/VryKM6/WxB4i+FESJC
 egpAphKNuuthfWeulcrV4ac9q4eKlMxcdcieWhqXGQK7RzwBhZ7pENYYSE1Qj2lnyvNa
 qeHMKTcZGiBC9jQaxTk1de1wl1VvAE0dghx0TZ+k7kRHH0FW7uRpuaeuTMrPzRe/H2rO
 fYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779208987; x=1779813787;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J5Ir364kNJg3p2BqrOnWJzIx6akY8iN2ohGX2P957j0=;
 b=o6EMQKey1qQTq8VBfOsPJEDWtEsUB5SC3P7WiPTPYIIxRqxQ0LXqHIEWkNECzeVFpP
 g8Kvw2mfiyU/2R9IjS5lfUSTQKJWt4ZU241d+EpDPZskWp9dSpVuj6bVngxhYnGnreHf
 5H4XiuUILlsnrCFusfCRbxFnqrla780h08LE7JNe35gWHWcANZBlss4GT500rL/2HvZ9
 Z6vsQgFKcESJDYTxxd74YFbJ6znIpnPOh76skOk6EbEdI9HcAM0IyQ0+zH/8cHalebMd
 WpuuBe15NRr83ZsjXYXF4pySDvO1ya60tumiuEej3DAwB3sZJFDH6B6M+j04A4DeoM7A
 X4Yw==
X-Gm-Message-State: AOJu0YyA17MctXERKsQ1URTRXYxBeZHxenXfz3bi/HTcrIteJMtXjXcU
 9YxvzW0H/tw0A8AS8csq2v0jX8QTfEVnIdwD0m+EGD7Ja8Wrf0gOy+lPNSTDoOY8sFr/950u/Zm
 XHTCfHAo=
X-Gm-Gg: Acq92OGCTzTgrNM/kw+cCuUF9N+DPTceM0FY7Px5DcoWTNRcNNTD5GNwPFaMLv/iC/v
 VKIItEsiZfAG0VUiBq/NYFJMbdC3Q/Khsixx/sOnClSaxUJ+DpzwBmEvRwENODexTTtNt7KcVx6
 0Sov/Bd3aZXf1X7f2h3xq9Iq5XsIFN1M3jtz8MNdOeZNZIzvSHB7wbh4VPP0klv7+WvvSgzhePM
 +bbaVnIbA9H7mY4dHWAkzREQGBEuELnlwNU8xRiUMHueDRO6gRkki2pxesvdp3GnZEQ19aauP76
 d3xHn0hC1I6JySWRJOHmt3sfrHy55Kn4PRjrw60xCVxcWiPN3gi8I4mh+OBvJN10tzQ3X6/uMF8
 QB3mq89UT53xbWYOo22Df8DIdn4g5auZF4cGvmXKv5eNaxtlbXbLN+odsThZmpc4z1lM84SYoyo
 LDfsmxVyZUW/J4v9LWSeMw7mqmhTPkT2/G6A==
X-Received: by 2002:a05:6000:26c3:b0:45d:7fdc:2e99 with SMTP id
 ffacd0b85a97d-45e5b87880amr33133631f8f.12.1779208987136; 
 Tue, 19 May 2026 09:43:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm46556591f8f.36.2026.05.19.09.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:43:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EF4EA5F81D;
 Tue, 19 May 2026 17:43:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Max Filippov <jcmvbkbc@gmail.com>,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Song Gao <gaosong@loongson.cn>,  Cleber Rosa <crosa@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 0/7] docker: Remove LegacyKeyValueFormat warnings
In-Reply-To: <20260518102222.80735-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 18 May 2026 12:22:15
 +0200")
References: <20260518102222.80735-1-philmd@linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 19 May 2026 17:43:04 +0100
Message-ID: <8733znbbaf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Update MAINTAINERS entries for manually maintained Dockerfiles.
>
> Remove warnings such:
>
>  - LegacyKeyValueFormat: "ENV key=3Dvalue" should be used instead of lega=
cy "ENV key value" format (line 98)
>  - LegacyKeyValueFormat: "ENV key=3Dvalue" should be used instead of lega=
cy "ENV key value" format (line 64)
>  - LegacyKeyValueFormat: "ENV key=3Dvalue" should be used instead of lega=
cy "ENV key value" format (line 97)
>
> See
> https://docs.docker.com/reference/build-checks/legacy-key-value-format/

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

