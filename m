Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FF3C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 13:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUoGI-0000AF-3a; Tue, 30 Jan 2024 08:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUoGF-00009C-Su
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:34:47 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUoGB-0006Mf-Ba
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:34:47 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33af6129f3cso662034f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 05:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706621680; x=1707226480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=keBOBYDfIORqYI/to2+VEwlZixxCQOvFMGfg3z6PyDE=;
 b=TLEoTf7igCOSfE0Np2wmz0vE3dOVFwREOM8d8Ma/PXtVbgZYm21KfXUohHT00StVWJ
 1aB7KcTbgKhT4GfX5mc/TossKXHhOsLsPX3WUsDKxUxXfO9kfEMbc60U59P6f1+eNgnE
 JyEcxaQ9qxz4qsypmAZywoVR2tFkXTQATnD6tfWnR2P9UzlThjtXGht9pUn7j8F/9xBB
 JSqHw5qUmuGGhzxxjxFc/YDxLZZRDjFcNrn8ojb5JMagwB47RfroPCNr6C/7e46BNWq5
 Da/tG/pxUnOhFOFJOhcMGPiVCFnEyG0YUwL/Sl8in2zpfCIPRQwYOD6GTcb43mJucYF6
 heBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706621680; x=1707226480;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=keBOBYDfIORqYI/to2+VEwlZixxCQOvFMGfg3z6PyDE=;
 b=vm7UXXrrh75MnxBAl0DQimiXXxIG5ca1AEsd2OpfTb90HkACUgBX0DN5w4iJGB6Squ
 nPr1Eb/xYZjOtlInbsHXOiixmZm3PUhXM8MhFy9zfatKg2wKbF3b8lnmxr0tOQHImIVM
 G6NyoPIIVr0WgLN0+Naw/GllswzfiCsOBS8TVbxhllvNK8xtV4V40Y8uWnRsGH+h6PYD
 bI9DcOG0UrL1Bs5a0Z8vsO/Ni50qKN1TfQl7qHNwchAh9Nep7bBSGG1lmhdPl2MI6Icz
 Q1c/xoiWJmqZM3ark4mrHYLJAZ+H7haPFZX6Egwp0tWWZ6JATCe4EwZ1af8WrJpiLM35
 JmGg==
X-Gm-Message-State: AOJu0Ywd+8nHOa24/37YbGENqRks69OPTutU179tWb4e52ZN9NLmxw5H
 0H/PUWoslwrSSUuvj7okBizQwzgPZkPeNKqDz6yAr8pQKfgHcM4no1dmohFz6RYWtxhlEYvVQd4
 x
X-Google-Smtp-Source: AGHT+IEBh7rl8Br2QTkCQewytogxR2SPZRt7U9fUf71Aby7ZCaSMdMg6k3YVnUMCFxc0W68m87qzmg==
X-Received: by 2002:a5d:4a0b:0:b0:33a:fa1b:f195 with SMTP id
 m11-20020a5d4a0b000000b0033afa1bf195mr1308021wrq.71.1706621679792; 
 Tue, 30 Jan 2024 05:34:39 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ce2-20020a5d5e02000000b0033af4848124sm3918077wrb.109.2024.01.30.05.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 05:34:38 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 18A175F9D3;
 Tue, 30 Jan 2024 13:34:38 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  David Hildenbrand <david@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: [PATCH v4 3/3] tests/tcg: Add the PROT_NONE gdbstub test
In-Reply-To: <20240129093410.3151-4-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Mon, 29 Jan 2024 10:32:16 +0100")
References: <20240129093410.3151-1-iii@linux.ibm.com>
 <20240129093410.3151-4-iii@linux.ibm.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Tue, 30 Jan 2024 13:34:38 +0000
Message-ID: <87cytjosgh.fsf@draig.linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> Make sure that qemu gdbstub, like gdbserver, allows reading from and
> writing to PROT_NONE pages.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

