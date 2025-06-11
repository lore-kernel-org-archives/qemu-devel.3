Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A4AC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 10:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPIa5-0002E0-Jx; Wed, 11 Jun 2025 06:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uPIZq-0002CU-Ob; Wed, 11 Jun 2025 06:21:04 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uPIZp-0007ka-3g; Wed, 11 Jun 2025 06:21:02 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450cfb6a794so42201305e9.1; 
 Wed, 11 Jun 2025 03:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749637257; x=1750242057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6PguoYRi/zm6aQwoeuHPDJ7Go6qcy1ydlAPoya6GXcc=;
 b=dAbdCxm06jkFMt58gZU/YUv5KvBpWRSpYGmvmq6T7cM8Vxr9srH1sggcBEwldN9g0B
 3WKx+rpfBaF36puoVIOgU38JGElOhtEjYgXknFq0jvvI0cfUHIBg1yu3+AgphYI0Mb8O
 cV6Fg4XEL+r20keRCyYzDtBA5JXrr3cukGndcXWBHZ/H5luSn+F0DcJ+oDonQyHotqDf
 N89MPDRT8CSBftK2z8uEjNnP/wXG4h2FspwbacYXTsgFaO0NACe2HzgGqZU7zTfrh+r2
 lcYjnyfJDPe94BNR8eDDhTX5+KWMiiComYCF6mMIzpO6jejiKgqVVMCT4WutuTwoJDqC
 7XqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749637257; x=1750242057;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6PguoYRi/zm6aQwoeuHPDJ7Go6qcy1ydlAPoya6GXcc=;
 b=rXOsqQLrHvYaZH9Js1QigJDU79aW/8xhC+0RUIDOcRcHqPgYPdAlAMj/Y2HDiEoLTR
 6URPDJIyPAbdl3xviSQDCYQKo/fS7FleNZ4v17LxddgcmKoRZbgrSq6cAdkNXxwOFz+m
 076Zv0vnPnJ4541WViKFcsTRCTogxw37atju/Glc0KvVFevZTyFvNKT9PVch7PfvXFDq
 BEcG2iLIVgMe1dFRHbWXRtEsQdEBf8rt1g0J7zQbhLxIV3moqnZ8tyAjHbVukPWZyiiG
 ZdtDmBkIZzvEdnoKmaaVfct5GaBvnbJlu5KLX3cBNIQ1S8JspmpGpET/ZtC0OOfKQ05P
 pCHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTp5b9Z/C53JCBJnK3uLTulZDWZfEH/tYcgXC5eW2L7BVq1Egp+bdaMsgxL9cwhIDPVB5SztI83Ar/@nongnu.org,
 AJvYcCWwfR1olOUO/mFXxQVcw7RxLNH74eCNZZHtyGj/Phdw/GD6W33DNh/Ac08M1oIOI9MMtrMrE6/c0ZOp@nongnu.org
X-Gm-Message-State: AOJu0Yzy8TVm/MZEwFZsfC1t1d1z9twERAMBpgJULE0dM7KGHWY8Q28F
 EPHXB/UW3laxhOngPzGq7MW2eQi1dk8OX63wecnmX2gkDyhQLITIT4jQ
X-Gm-Gg: ASbGncsg9lP2+M+lDQGfXJE+iA610Djw00jBop6O/SvQWk+GGJKhy8VJgSAsL51+AAR
 72yw+m5U88L4dIZ9ha69vz2PAqn0e+ixh7CmEp6ADz2QVr/3YcQ94wzmc6BZUE2NoFca97NlKcM
 YJ3E4J+ejkHDcloTWuxjMDyTDDtpzguGYE4vcDsiO7sSu6KdUS2CAxBqGOqPvw4L4YxN9CDvd49
 XcnQX9y9AUZbCd/Ulqqt6FUDbgiauGBs0d3ISsHZ+HcyU9Jz/ZAqLSmEuRjA4UJT7Eas9mJf1SZ
 6S5JkDbMp+LG2KYUTD3K4z3Y8T+qH2ieJoP4a/04PDvXVK4NYrPDnVMV
X-Google-Smtp-Source: AGHT+IE51emv01IyrLJQu101dgfyeDKe+yRICJoRi31tP7yiWZcxDrc/Jc8iT30GB55AMjQEB9tK8A==
X-Received: by 2002:a05:600c:a377:b0:442:ffa6:d07e with SMTP id
 5b1f17b1804b1-4532486b9b0mr20759385e9.1.1749637257164; 
 Wed, 11 Jun 2025 03:20:57 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532518d714sm16566755e9.28.2025.06.11.03.20.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 03:20:56 -0700 (PDT)
Date: Wed, 11 Jun 2025 10:19:35 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
CC: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/2=5D_rust/qemu-api=3A_Add_?=
 =?US-ASCII?Q?initial_logging_support_based_on_C_API?=
In-Reply-To: <e14ce991-7cd5-4875-bd99-5dc27a22be78@redhat.com>
References: <20250610202110.2243-1-shentey@gmail.com>
 <20250610202110.2243-2-shentey@gmail.com>
 <e14ce991-7cd5-4875-bd99-5dc27a22be78@redhat.com>
Message-ID: <03F26AC2-B53A-458E-9343-0254516F26DF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 11=2E Juni 2025 07:56:23 UTC schrieb Paolo Bonzini <pbonzini@redhat=2Ec=
om>:
>On 6/10/25 22:21, Bernhard Beschow wrote:
>> +/// A macro to log messages conditionally based on a provided mask=2E
>> +///
>> +/// The `log_mask` macro checks whether the given mask matches the cur=
rent log
>> +/// level and, if so, formats and logs the message=2E It is the Rust c=
ounterpart
>> +/// of the qemu_log_mask() macro in the C implementation=2E
>
>Clippy complains that it wants `` around the function name=2E

Will fix in v3=2E

>
>Paolo
>

