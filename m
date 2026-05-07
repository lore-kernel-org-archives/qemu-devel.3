Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C11CCD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1vw-0004xO-72; Thu, 07 May 2026 12:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wL1v9-0004b5-D8
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:50:02 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wL1v0-0001gy-IQ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:49:48 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso22124355e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778172581; x=1778777381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZtP9nnXpyHsTr6q8nhruspaH75p7XSNAmy7nQTwSps=;
 b=sOPipinkt1kkxVVTVBS0tKMSX455q1/M+FCga/6ttI6O1hGyZJy4NycYf14rHx9l1x
 OnZtScg9OBHR0k9wXbCAH2oENWUPWqJmWWPCVn4kh3NC9JDCWn3ykfGtFjvbnZB3G8Uv
 Rl9mRCF2a0mVxxoCiBez/k2yTIWIAwCbVPs/u94qLlew552dsr3zDImsUqw8SzL6DtHW
 fgsjqohp4xqzKUHbMaUbxQKNoeDeAv9xHfTZGLCkfiMgDaNjzEXZDh2pOFA00ZnYyIMb
 6pYLU+bcTyhk//2ebC1zhDCd2rWDf0DJzp+961kAmLGJQvXEHcfurngSpHnE8eBa3t5I
 +cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778172581; x=1778777381;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WZtP9nnXpyHsTr6q8nhruspaH75p7XSNAmy7nQTwSps=;
 b=GpubMBgcoAHOPh1Q357f1xKvi5d62P/imv22sNv5O+Ii19UKhS4CXkru7yxrxe3X2i
 yQeIkZbyXaYfWqGCqD9CB6xq62t/PP22xRGv1JsaxhEOjPlMFvao8QxXVvDv0o5RdRNp
 QuUPWsDuphF7dqv6UF71YnZinoCKrShtpdrlQqYwAi2eeChWTBejzLdeJJqpBhm6KrlG
 ZaEnL8XysFVkOoVb5pZ8h78kstR8G5a+dgreIUbbTN4ToQg47GOo52PNiIBu9IlkleiQ
 G5d/U0DSTJHSe6UOFnW2Rr7+jnKh5uaw63T8Jy4FHEpomy9kR7EJPvkWaS552my0BqwP
 1lmg==
X-Gm-Message-State: AOJu0YxAHVsQzq3oPH+kMtoxvUxBRZgi3h9wV2p6a7oWBHqMOG1RfHIH
 uugsHNRfFvXCyA+Upq4Q9FIAouggUm91APVryo0nhBe0CkVI+SBjlmmkrnJZ6x0abfM=
X-Gm-Gg: AeBDietehMIBU5PWRRlOQ3xVSI632GF49xOxu9fFdDqJQuZ9pym7IR49rTt9HJPIWg6
 UHgtkMk8k5akLoBAFLUT6zK7F1Y4hypqI6htHcsnVH61J9NbLXYKJf9FDaGd80sPyb75ca+ky+0
 J4lPFR/uBWXRQPSJghQ07G8feJumVQaZ2a5PZaGkgpLsTByq29RxNgMjY2JWtWuB7vswTM7opJy
 vzUhsKAOCAy+hBcdmPTKwqGkaDcGheAaTsVTL75blBsuSlsyqiTe1mm7mYy+rZqS10NoWIJ2n/P
 7Wa7oTkUzJGXiGHfntQbkHmjfOO50HgranX8vbCxE7LAKmzW/rkMkTVVVePzjlNidIONK0358r7
 p9zeFOy6N3VYRCKpxRmznQV2a1XaBuIwiOe3Vqua69bQdw00tNvfBpTPaboxcnPsd/Ny8wpQWzx
 mCqoOJRYXNBcPvIX0uqrgg520=
X-Received: by 2002:a05:600c:45c7:b0:48a:761:5816 with SMTP id
 5b1f17b1804b1-48e5dfdb8famr55502165e9.8.1778172580532; 
 Thu, 07 May 2026 09:49:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53158dd9sm42395715e9.36.2026.05.07.09.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:49:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E01705F7C1;
 Thu, 07 May 2026 17:49:36 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,  qemu-s390x@nongnu.org,  Philippe =?utf-8?Q?Mathi?=
 =?utf-8?Q?eu-Daud=C3=A9?=
 <philmd@linaro.org>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Peter Xu <peterx@redhat.com>,  "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Nicholas Piggin <npiggin@gmail.com>,  Chinmay
 Rath <rathc@linux.ibm.com>,  Glenn Miles <milesg@linux.ibm.com>,  Palmer
 Dabbelt <palmer@dabbelt.com>,  Alistair Francis
 <alistair.francis@wdc.com>,  Weiwei Li <liwei1518@gmail.com>,  Daniel
 Henrique Barboza <daniel.barboza@oss.qualcomm.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Chao Liu <chao.liu.zevorn@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,  David Hildenbrand
 <david@kernel.org>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,  Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 04/25] target/microblaze: Make
 get_phys_page_attrs_debug handle non-page-aligned addrs
In-Reply-To: <20260430093810.2762539-5-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 30 Apr 2026 10:37:49 +0100")
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-5-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 07 May 2026 17:49:36 +0100
Message-ID: <874ikjkvvj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> Currently our implementations of SysemuCPUOps::get_phys_page_debug
> and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
> non-page-aligned virtual address and returns the corresponding
> non-page-aligned physical address" and "only returns a page-aligned
> physical address".  This is awkward for callsites, which in practice
> all want the physical address for an arbitrary virtual address and
> have to work around the possibility of getting a page-aligned
> address, and it doesn't account for protection being possibly on a
> sub-page-sized granularity.  We want to standardize on the
> implementation having to handle non-page-aligned addresses.
>
> For microblaze, we just need to remove the explicit rounding down to
> the page boundary that we were doing in
> mb_cpu_get_phys_page_attrs_debug() when calculating the output
> physaddr from the results of the MMU lookup.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20260417173105.1648172-4-peter.maydell@linaro.org

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

