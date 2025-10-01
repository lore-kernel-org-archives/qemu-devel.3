Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5314FCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 17:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v40qs-0005Jt-Ii; Wed, 01 Oct 2025 13:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v40qo-0005JH-H1
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:42:50 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v40qe-0007x9-DC
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:42:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so64911f8f.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759340550; x=1759945350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GsFCg+F3N7BwMm6MJVCB4pefGJu92zYSW8q43aVYA+c=;
 b=QU7bAErdhgO5Er6KxMa6yr1sadHB5LLupTDFJ7MMAgxAj4ijBky1ZzYrjMlkXIH6YX
 HJhJaOcOvHL/Q3LhLM6g9CEII7CsXK+3YSV2f44vxvS8KpDGlnq2EA5+k3HM3dSzgGrZ
 KCyIV0vFGp1nIb4dwsVV6nv6XkwPg1EGTzZocMQGtnJuCNKNRDHwJA2a7CYb8yl8xt87
 htCLeGINXKuAcHToskr93Hyyz/6EmnCspw4RbVQaspq2z45ztVeUjTP/BvGjOgarPUaB
 4HtxBWYHCNbDESLlwTf3z0lCCNVnTEcJS2K3XbULvXlT4zbl6F3SceofkD6cXseWGV0J
 PjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759340550; x=1759945350;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GsFCg+F3N7BwMm6MJVCB4pefGJu92zYSW8q43aVYA+c=;
 b=qWCdDLsBIZc0vDip/IMwk4n+XaIXNxDAqGkbYedRzQlWqpoO06APwiJg4CF3omyESQ
 Rn7+KA5pff9c5Qv9xYLvCvqvi5UwiWwjF5Gkodi0crYNvxbaQ5xR7/W0jbb448AJ0P/a
 D5mNH8SeGWg5hTlfXK9IYpFsskt2gvT8yPk714n445RFE1BeZOl9UtxktBrE8zYjCi1q
 vyfSOvLivyYa5yFgfr6UagJ3YFdJuFlzYSmK32Ce/dblUxREIWXgZrercH8fh1npUwEo
 7psAAyAWCdR/hnlqce895L64ZWL4v6GZJBdKAi4lLa/szhblkuCBjELhSBJs9Aqw2cCU
 mINQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrycr2uKC9TvVvogZ8nKzd3jE6UPVQYLaZcLUX/A2Rtb9hhWNsaLYaaxiG06lTXw979iPtzlkht7ug@nongnu.org
X-Gm-Message-State: AOJu0YzE6wtON+Oliik4AamOtO+uqSBL7EwAnr8+/8rrjGNrz7PR6h9q
 sqf2RZhgzUDj3iD62/UyCXaorDicEq+VTMl3IFe8jbLqCSJBytBsn34aZcGLE5N8WWKc7m6jdX3
 idIg5
X-Gm-Gg: ASbGncst4Sk/FyFo63byMhRkSczeRmrgHs0dFGYpGvxvVAcx5COFpLOD/k9qnPUk9br
 WKPSr/+Vl2VE0sYxHGMJh0RWdCdGWrhEn+uSxt+J8eK7Bw9CJ7K82HwL5MLoy/ddXyNvUsIZ1KH
 H5356bBEWvK89mago6ecUYuz198Z5CAMMS8UWrEgWK56Zi5NoV/2+br4O3fRiNFqwqAKVX/RDbp
 rNnoKsSDK4A70J6gNbXC47BP49auNbtOwsGsO+e+hW7qr0TD+7AcysCotA1Q8VklbX8mMEA4yx6
 XBYRg3alie0/n8zrQGK6v/3SjFO6NHBHA1N4esAQ4ePj+yxbvbPufskLyPBYM0jMfFQpN7jtmli
 z2BuKX5xX+Uugk8AU0c+q9F9rpPaN5Y+85EB/DjHnLF08KjURiMuP91u9qA==
X-Google-Smtp-Source: AGHT+IHSTsdE3mv4Pz1vzKD736lJH6320ENYWbwGawRYqoyz8gjCczKtCKzfPqXRYz99+KwDHsYo0g==
X-Received: by 2002:a05:6000:3105:b0:40d:86c9:5c9e with SMTP id
 ffacd0b85a97d-42557805113mr3957683f8f.40.1759340550153; 
 Wed, 01 Oct 2025 10:42:30 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f02a8sm54621f8f.39.2025.10.01.10.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 10:42:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8E1255F7A7;
 Wed, 01 Oct 2025 18:42:28 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Andrew Keesler <ankeesler@google.com>
Cc: berrange@redhat.com,  marcandre.lureau@gmail.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/1] Support per-head resolutions with virtio-gpu
In-Reply-To: <20250902141312.750525-1-ankeesler@google.com> (Andrew Keesler's
 message of "Tue, 2 Sep 2025 14:13:11 +0000")
References: <20250902141312.750525-1-ankeesler@google.com>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Wed, 01 Oct 2025 18:42:28 +0100
Message-ID: <87ecrmikmz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Andrew Keesler <ankeesler@google.com> writes:

> In 454f4b0f, we started down the path of supporting separate
> configurations per display head (e.g., you have 2 heads - one with
> EDID name "AAA" and the other with EDID name "BBB").
>
> In this change, we add resolution to this configuration surface (e.g.,
> you have 2 heads - one with resolution 111x222 and the other with
> resolution 333x444).

Queued to virtio-gpu/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

