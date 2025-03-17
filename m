Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C519EC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBwY-0000TF-TI; Mon, 17 Mar 2025 10:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuBwK-0000Kj-UD
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:59:41 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuBwE-00070o-5f
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:59:37 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39104c1cbbdso2582110f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742223571; x=1742828371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4qBARzpAWDv8g08VW2AvJNqOSH12ex4O/mGfLyxCjE=;
 b=vr/4BM26xwNQaSXy+LGMfFOz6dkdSt+M91leUfVjnAAqo3iGP6uOuYXzDnGPv2dQOP
 Fby/UV9VIGw8Jpzpe88Hf6V9FubtJWQvfm+zXvb7UBmasU42p9C2B/P2Zl/LGyz3C0ku
 zsSKChCFmZI4VDrb1wPdQ62aGxf+orCBT0xv8yEWb+CKq9JpEnwkZ/mEXczVI/9xSnS7
 8vMhqqib3F3xt6N+GCFf3zSDCIQz4b6SA+P4ffSkC1i2xXp39+8Me78piUBpHYRp3v3u
 Wh93LfC3YbE7gJlnJ4tXH1f84OqP51i4ujykaGbvVYO4tS4wjuQdqwXqi9I8dyKmPUWF
 4bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742223571; x=1742828371;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+4qBARzpAWDv8g08VW2AvJNqOSH12ex4O/mGfLyxCjE=;
 b=F30aWcGp2jRfHqU6/XPIqhHg0xiuwVak5EIpIXgJ5GBK8wVkV8wzZWojHkrMzlYd5h
 FIV4oRyNgqIhexqxHtBUelsalRy8/PDJ848aMxYXllLsbWwXa3Uwqi+bw1k0YtX3m0nW
 tTeeML72kXiN24A33Ax4Gan2hb3Ifj1fY2r0BZuRx+APUh6wy02/CcXyZj0Rwf0Ln1UY
 xJ78ku4sXFuhbLAToWKReffb9I97p6A6j/IxBrryp3SK70JrE2xWwv9nz6K9FDSr11kK
 0aTgQIjk/B7cYE6jWhcTJe4DWd43Ww4OYJkUEhBKPB+6PeUgQlSLez1oaBaX7+Gc/lhm
 9kQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqjCj08MCl6cjQPk2H0hi7M9hRIHkDA7fVK07mYfK5tCHBEYiz8XXlaUD49c44wzGptFNe3b16Cpv9@nongnu.org
X-Gm-Message-State: AOJu0YzYhOnHh15cdreNa/l+R+HNCAbLgat4bP+kQm7qyzIsRL8MKNy1
 mPmEAuVYEf/E6w9yl2RhLu/iP4u4INPEGsF6ZRMgXDU02ZJC1A4ArDKGZ17J0KU=
X-Gm-Gg: ASbGncttp1300t5A8kkwTU25B5nMxZJJGww/AX3KxeQ7tzId+phGJKQ6XT83ev/6IjF
 j6jpplky/yYWCvsnIKDBJ+zm/Gr0AOeR/zZ3QWao6D9erB78C8X5NJdx1nOP776hgJNWRq7kUpF
 cRYlYcFAIGhnlUtvlFx9koUQwivOLvMBWx3nAL4t7vRfXMmCSXvNW3aqvt6RS308hrIQMb/Do1i
 6o+nVWhqSBePpOV8GOh3FkTPCM9mRWZnPPc90T9ZRYh8kq1vhDcVUkKyXxhwAAoCWMibKv9O4qa
 703rRzd7sYCebB44UwVcTK5ysMVfMvrbyerphuj+jEzhdOjt/7LUi2GIPA==
X-Google-Smtp-Source: AGHT+IFN02epWZ/ei3F6J8pgLPjkHukuyIuBAa5FmGw6+o9KbPshzz7zZt8SoCMeZ6hZXenMFujq9Q==
X-Received: by 2002:a05:6000:1866:b0:391:2a9f:2fcb with SMTP id
 ffacd0b85a97d-3971ee44653mr12643421f8f.36.1742223570797; 
 Mon, 17 Mar 2025 07:59:30 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df320csm15085845f8f.7.2025.03.17.07.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 07:59:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A066C5F892;
 Mon, 17 Mar 2025 14:59:29 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH for-10.1 2/9] gdbstub: Allow gdb_core_xml_file to be set
 at runtime
In-Reply-To: <20250317142819.900029-3-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 17 Mar 2025 14:28:12 +0000")
References: <20250317142819.900029-1-peter.maydell@linaro.org>
 <20250317142819.900029-3-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 17 Mar 2025 14:59:29 +0000
Message-ID: <87iko7og8e.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> Currently the CPUClass:gdb_core_xml_file setting is a simple 'const
> char *' which the CPU class must set to a fixed string.  Allow the
> CPU class to instead set a new method gdb_get_core_xml_file() which
> returns this string.
>
> This will allow Arm CPUs to use different XML files for AArch32 vs
> AArch64 without having to have an extra AArch64-specific class type
> purely to give somewhere to set cc->gdb_core_xml_file differently.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

