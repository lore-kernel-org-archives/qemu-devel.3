Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A35C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 08:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWt6J-0006IK-9J; Wed, 02 Jul 2025 04:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWt6C-0006HF-No
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 04:45:49 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWt68-0001o3-Sj
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 04:45:48 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-adfb562266cso1055420366b.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 01:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751445940; x=1752050740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EkPC+xflEyh58hMWVG+t45AJTZEdXM5JQ6CwJJJFexs=;
 b=j+aKBDK3bnCMm7K7A0QRZmS1GyuI51/QhS5v6fjgihQlkCShJe7PODTRLf7IvyK9Pf
 R6QyJSIv3WpxhUe6rbnigMsSIfByTKdHPK/IBWFKVpqUA+K5R26zc5mZYrrUT4VcYy28
 cGB5y9DCfMDnLmKl+Mba0qrqMnZ3+vPcO6kqYky+NaKvcVFu8FTGtREMe7XxNU/vbUhd
 qDEp3SVNh8xd+7u0ygvjZ6RHsRDHX8CaMJVGDCtIFwX0GMC9MS+ZG1PBSN5uiY/PnD5R
 gqZ32VSzoiL2EYD2rTi9D8NwfmaY+G8N+yegwnoDf1bunyiRSJqx3eHkZ01GC7oN1FVB
 mnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751445940; x=1752050740;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EkPC+xflEyh58hMWVG+t45AJTZEdXM5JQ6CwJJJFexs=;
 b=wz23xuxVslq1a1p52wHukUrEQnta+upjftZsKfnwY1w0vLAH1XTmNHFa9xNAbYpg/2
 5/qvqndoKo5Ts4hWHc9+703XAjFsqtkmWLZhNjnbSYNaRbNrfDLJCRniWltALkZgDIt/
 R4ygFYus9Qs/Xip9LHVOUnzIwRlTsCYb9R8iAsa428AklWn7IXoqqz1FSEWmoQWeShCQ
 O2s/kPiKz1tu+YO9FOR2H2zIpR9Sjm8iu/Ge/Y8ou8CIfwghuH3eF68wrXcM9wucvnwr
 MsDNO895Vp/mEljqg+a1F46Cy9RevJWHmtBD8awBydaAeb7FVIFaKXcLd2fDceej7PJU
 AuRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJDPM+WKbG1jOlILmZ++A77a9qCoIT5GPTfENwr7yW9RWjX/GCt+ZwQZTDpOn87ZOaascZlJNOPdJn@nongnu.org
X-Gm-Message-State: AOJu0YxcvjNCf9aA6c3AJJ2l9AHsD8I+oJDMeiYvtHP0TKpXHpdZ13dV
 qWcQbZrmuzjAVWPW4de4SOh8eupEd/OrInKEHSmGOmn4DrqT9kuDOoNeGk3Ex48CRZQ=
X-Gm-Gg: ASbGncve4p2U0xcFya2U8NvS8y2J+WNiT4RKJWQn4MPaY+9UyRv+QhVkjvxcwTzsnBr
 M8Of2KJMgaVT/JJSFHIAIqmC/iGyJWaZyMloa3qGROBeVabtW9BPz3WHgbd6ku1fpnwuH3jOODs
 7viuMJWm1g045szX4t9Azp5HxUO1dfoECvdZ1G7yjuV3/+3XBGSOJGXlqXGjAT+lhMopoqqL2pB
 Ng2SNqP4ImNIHIFLFzhb2ww2VpfwN7eNShtU3sc05QvZKIWhK8dxzMH5zvmiCq5XgY6XOG9EHTz
 4NA1yOSwv2F+kQ8GuPKl257t4AC/3VMR/YFVd94+Z6CgGX0wLUhMc/F/WbNSy64=
X-Google-Smtp-Source: AGHT+IEVxUH7oMwDwObWpMbe8WbFxVuANAWzJhGt2tlc56v71xNu1CVww1/cqC4iApoRpvp9aDXKVQ==
X-Received: by 2002:a17:907:7fa8:b0:ae3:5e27:8e66 with SMTP id
 a640c23a62f3a-ae3c2bdcc36mr207648166b.27.1751445940571; 
 Wed, 02 Jul 2025 01:45:40 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60c828e1a96sm8672319a12.19.2025.07.02.01.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 01:45:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F0A225F8BE;
 Wed, 02 Jul 2025 09:45:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  Zhao Liu
 <zhao1.liu@intel.com>,  qemu-trivial@nongnu.org
Subject: Re: [PATCH] docs/system/target-i386: Remove the sentence about RHEL
 7 being supported
In-Reply-To: <20250702082138.23109-1-thuth@redhat.com> (Thomas Huth's message
 of "Wed, 2 Jul 2025 10:21:38 +0200")
References: <20250702082138.23109-1-thuth@redhat.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 02 Jul 2025 09:45:38 +0100
Message-ID: <877c0rf0b1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> According to our "Supported build platforms" policy, RHEL 7 is not
> supported anymore, so let's remove the related sentence from the x86
> documentation.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

