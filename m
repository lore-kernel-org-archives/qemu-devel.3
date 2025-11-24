Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8670CCFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 13:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNWyE-0001ys-QI; Mon, 24 Nov 2025 08:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNWy1-0001tw-Aq
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 08:50:57 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNWxz-0003Ow-OW
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 08:50:57 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso28599125e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 05:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763992254; x=1764597054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/F0+Ax1zYQEzhQ6Gr26gkcQR7UbRcGCmo9VNENRVu1s=;
 b=OcYZYXrnATiG3j7TpZ2CF6/320yfyQfG/04P6dhv4bRWogvB5PG9Jz0rI3uNDOny/a
 9R66sXL9pMVu5Xp5w3p3+BXPceTeei1PZ7UzSlWNObB3ibKuYngIjfsGD1uC2EwkoQ1P
 41Ci75oF2dCbgBOZ693lA6wQueArqIBCwCzI4P8B2NEhvSlD8zrQD+BfZ/hvi7fA3CGR
 PvKsSxp+UcZRoKpdonQpJYw8XoLmBKqe5FUdguStYatM4+jQxf2KgPBwrz2IYIy6K/zP
 xFoGDAauqrzz60Liv89kknO/wqN3tzt0GSDpIz/+AzhgVi6+wjpu4yTSppbL2mTjLreB
 0vSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763992254; x=1764597054;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/F0+Ax1zYQEzhQ6Gr26gkcQR7UbRcGCmo9VNENRVu1s=;
 b=nkBCc0Wr0x0CZ3B42Nbn2fmy3TinN7F1cdjrrIgpXXb5b+4KcWBVKLiMdJmnxFkgAk
 fs5I97c0plX6EbCwfBH1kxSG1quZmz7nszwQ7PH0fD4M7THYqKelbETw+Q3m4p7jYXK/
 Z+jgJwTMU6lFNCI3yVmPIBsgAmyCEr+JmufFwpqzeTuT23AMMEzeTNe+S3xkeBdr9EQq
 9Zvv1m+PsMVRUjcDUXEg5jPwtK5/VJs2IdeGz5oRNvCSwsQMW6cmK8cF1d/KrE0x3GSl
 Z3kyRlwi2WFwBq5ky50Hx77Q1WVsTNs7gTzo7SbSnWBIX35bJOxKSAC2+r/gnkVvx1Ni
 47LQ==
X-Gm-Message-State: AOJu0YzleYAKlss4Y7kAhUkYchtdpu1vv4Yfxzb7yZDP1W5KR23owFjX
 SJqGFbWFcUfpe5R8FB9TgfGk8/2tjJAa2xOH2dLnNs09AHJ7ZMW61XQzARLWDegnco4=
X-Gm-Gg: ASbGncv73rdHG9Y2otdOF7y/cKxtlBJJYGdt5MBOwz7zoXV9PlZ8jp9B67iv5N1a1Co
 EEF8mS5zs4TdmgBQF4JGlelncb+OFwRAPnnjsuBsKcFG5MZ+eG0+bGDQgscf3dHH6Jg04Za1Tl+
 Hq5VBDPtWJgxAWU/nWggdfc/DXmxhUizKNlZv1RAzdYlVJklvEoH0WN8ylxO6wjdomOLJ84yVd/
 Eyxv3JBmIhSuwhuVMM0HN3gP18CHXdTxjefnYMmbtrl9dSnbo+nC2YwZHpy7Xb2U/NBdwg5sh8T
 hKEnNj6T+qRKaNVcc0LNPhEi6PfLrk6ifDJ+ewPECrZCiyP+R/vPjVueurJSKSe0chWYNulLluD
 WnSry6+Gs8DUBHshCh8NfX5AUkdcv7LdkbjB29u2rICbHACONoS5Idg06sD5CauxHp9D1lIoFtY
 Xic/MbciKQy3Q=
X-Google-Smtp-Source: AGHT+IGUN6QIzSfxx1Evn4tvByIWRLn8nPqsDhHgRnicWXXHJMsUzK38juSDXeSzbkxqB1RmhVflAw==
X-Received: by 2002:a05:6000:22c9:b0:42b:2eb3:c910 with SMTP id
 ffacd0b85a97d-42cc1cd9466mr11299556f8f.3.1763992253977; 
 Mon, 24 Nov 2025 05:50:53 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8baesm28994269f8f.39.2025.11.24.05.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 05:50:53 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D2F45F83A;
 Mon, 24 Nov 2025 13:50:52 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/3] target/arm: Enable ID_AA64MMFR4_EL1 register.
In-Reply-To: <20251120125833.123813-2-jim.macarthur@linaro.org> (Jim
 MacArthur's message of "Thu, 20 Nov 2025 12:54:14 +0000")
References: <20251120125833.123813-1-jim.macarthur@linaro.org>
 <20251120125833.123813-2-jim.macarthur@linaro.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 24 Nov 2025 13:50:52 +0000
Message-ID: <87qztn8rpf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Jim MacArthur <jim.macarthur@linaro.org> writes:

> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

