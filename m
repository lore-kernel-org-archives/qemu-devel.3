Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC0DCAC582
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 21:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvjHw-00016i-U2; Mon, 08 Sep 2025 17:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvjHu-0000tx-Ke
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 17:20:34 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvjHo-0004ER-RE
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 17:20:34 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45decc9e83eso2600805e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 14:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757366427; x=1757971227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtFbu9uGNYR3g94cfZWQ73yJZ/4jh2oSFZ8Q3Zfvu4k=;
 b=eBL2Ky1GiTh07sBTy43t50G8aqOBdBqdI4J/5dbM4bXzcOZrRrF4fkg5aOOR3uZIp1
 CuqSQWWu2YmyI3mUUflF6YAl5ylyYZ0/zyWHLub3+lM/+HoP9AoKjBxYS7uVMXnjPB40
 ZyLitC9neL2LeUfZ9+fZr86wWsaQ/QWPbY+/+2ncn4GxCsdeGQBrT8NsZ2wk8xphZKGc
 l1thg/ehNZJBybkkfA1Jaws08ZdiKFWMUqWIbCPI0SJQiiJluyudke4QsMFI7sXRfVe4
 BaPh8xJNqAp56rtPmNKeODnd1XMSXPypCKZLcia6nD4RtbzyBGz9zxk2zzAQDlVPRls/
 s36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757366427; x=1757971227;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AtFbu9uGNYR3g94cfZWQ73yJZ/4jh2oSFZ8Q3Zfvu4k=;
 b=fJanoK4AqMutL0/+HAl6VTO2KufkCLZ0kThB43kcB1N/VYe+yG/p0xtfWVuJTgKEkm
 IqMF0ipihDvzuTDaIKDdHZ9Lx8CnNYD6joEZeFdFzS8lZYaluTFUM6mThzlXB2Jhpjt2
 KmuqN5PZJMZ2+WXEHIMkjWbpSoGVwjQ3Br2Bs4QvlwC4FQcqCfdVMFrOD+Il3jIl8hTi
 sgviEH0VCpTCyI95xRM6hHyWxlYPNL8AncaT3KtRt0RQ1mfFyW7pSS1fsTLVG9S5hDlq
 oFYDmwGJU8bjlJrR76aJfhIjxwunNdFLAzo6WwUr6v2pGSSvRv6sVleveVJbiVANH+ff
 mHQw==
X-Gm-Message-State: AOJu0YxW98IBOhSmZ4M5GebR3sCilqerSSs0i6gwBPDeO3niUStpFg/l
 jpvmYa5M0P7+uJoTjwHyFKrISMq84aVRqm9FQzIFZjRmKTcRB5HeirsNGg9GRn4jKZM=
X-Gm-Gg: ASbGncvwLRPaXiNn2rNnay4eqXlqXSq8Yd8oU2X2jN1lXmGQ6NjJdMg8I4m5nJwdCA3
 DB8tuRoclPF7EBEmlVERrvP0fxcSkPXdRbW1++dIneBveqRhY/SqLXMrWNa3oUQiBeDTqdqFFdF
 f1JMi/GYWjUzIY0gQ2BSK/Nleqlqaa4+wNv1G2FdYYWBVvpFxXwcHuGigCHwp4qKM64l4bWB5d6
 diachRChZszYsW42Ntphah+GTyraS58hCwnMlRY8a1/WEjo1Uo7RqU3iCwW1WAGMgAKClwg5g7/
 M0pmreLQuHiGeyYLuNncuh2OA8ERiP812HbeEhlX3O7UkJTOEe59s/0feFQ41G0JgLU9BfpuO9X
 14bTVChSP2+7jp6lIXmrlLmU=
X-Google-Smtp-Source: AGHT+IGXDFFWjQAi7MOVjhZpElHu/EzNehjcfiFsMHH0HVUuHahwnqaUyMSufa2vS0eWrGQo+8Uq7g==
X-Received: by 2002:a05:600c:4514:b0:45d:d9d1:80a3 with SMTP id
 5b1f17b1804b1-45dddeed052mr79188705e9.37.1757366426658; 
 Mon, 08 Sep 2025 14:20:26 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dd4affb6bsm176143445e9.1.2025.09.08.14.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 14:20:25 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 236EF5F7C1;
 Mon, 08 Sep 2025 22:20:25 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yonggang Luo
 <luoyonggang@gmail.com>
Subject: Re: [PATCH 2/4] gitlab: always include entire of meson-logs directory
In-Reply-To: <20250908190901.3571859-3-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 8 Sep 2025 20:08:59 +0100")
References: <20250908190901.3571859-1-berrange@redhat.com>
 <20250908190901.3571859-3-berrange@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 08 Sep 2025 22:20:25 +0100
Message-ID: <877by88wva.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> There are files besides testlog.txt that may be useful as published
> CI artifacts.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

