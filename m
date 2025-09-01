Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5623CCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 17:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut8H7-0007Ob-84; Mon, 01 Sep 2025 13:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut8H0-0007NW-Uj
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:24:55 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut8Gy-00022P-MH
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:24:54 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45b7ebe667cso28232175e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756747491; x=1757352291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adgozc4Gx7F1L7PDzWGiy5jz0FxVfa1krglHYIA1LJo=;
 b=yXrP+mdYvOoKA8G150dOhvV/YKLxcM1kYLiBuRZTC+f2VmCUE+6lQZIDUyIG14Z4i+
 8OrIKmkLGHnfRiw0G90pYyl4XjkJhL8gNo/17cXK7/eObLG+O8wVs9yjM/YawhoiaaLl
 mjtJE5hwqMe/JReccJJKrVdhAFM8Co0AUMcwIPTEC365FB2Elhzz60oqAoRLmgfYswzx
 b990N3/Bg/6At/MsX6Zr2jhfVCsixaL/XqUpAU7GiNSZseT6EL9xUV0YukWH+SMBaTWJ
 mDbtTu/aj4XH43jvgYeTulyGdBsgdwvSxx92U5TWK3yielJ6EyeEbAOJiyVuDGEBuFfH
 /twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756747491; x=1757352291;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=adgozc4Gx7F1L7PDzWGiy5jz0FxVfa1krglHYIA1LJo=;
 b=YNfr9SnZk2j/YqqhVdIAr1IreZHO3hZB8kE6vQAANiL5nANhV1YsWEhV16sl62MDRh
 LZBl0RS9MlYXFfu6/Sx3mdYvjlqA9fWajgjQgjrKixwWPyTgUjf80uSYcEovWsSZjlDX
 fIeTMtjAiVeP0SEDlgzINRDKYNMnGbRyozmrYlamC7vgUj6WIBrOfjIfJdI7QjNQCOyI
 QBCMloIwb/xSma3Km3qXzIJQf7F6k31URF/8Gd+QC+CDg1p3qM1nGlxOQaQtXX2LSoYM
 D5ACiOLfNUq7GrDdJF28/DrrFv3E+t/igPIKawe70dFZqwR/rd3QfQ5MpQQa6O0MF1wT
 2CGw==
X-Gm-Message-State: AOJu0YyfxnNT2n7f+2SS6L5A9IM+HlYK7PeER6tlzrOxvfcsvXXBZ40e
 bA1c2e1niVpNGGvewEED+uHEBQiLBfCO+md+dahFeYN6MrdFcQ79izZxaZs++1h3u/A=
X-Gm-Gg: ASbGnct9opWWJKBz77VHhJ98lAUJY0xWYkT7fyrJ6caK9FXajzWpMaqdAHuCnYULDO1
 YitVdo1bWfqsmIel/v9oa1xiIm2mISbtx0gahvu8IgknFNp08FpzLsApKmV99KQnyQWFL6gpzv3
 vFgBDD763L8LRXiPPzYgsfUufQT9RIrBO59nuD48gdSv0pbO0Oiox4ndr0+BpjJZ19Ebvs1YPP4
 ezZ5KAzn+rXQlRNku2F/Zc8qoFsJpgcYB32KjfE5C33DQvxkj58/4+J0e/6mdDTFPhwCMLVqoma
 wREaxmW+yzsqf5ENe+fBD6tXdY7RLSuFu1tm51qRGdqBkywk0SmGJKeqclfW8GlOaCuPd3p+xQg
 kX+T84+3Kg33kieh9KGPtlmwH2v+68Gj/rF47w0+BOWij
X-Google-Smtp-Source: AGHT+IG0bZ6gUPa6zRPXWd4lyk5rEvGbIoQOK+qcsjW/gk26DQ+rhBCf9Gvs2kdiu6qjVCLmo5/97g==
X-Received: by 2002:a05:600c:1d07:b0:453:2066:4a26 with SMTP id
 5b1f17b1804b1-45b8553417fmr88875855e9.16.1756747490862; 
 Mon, 01 Sep 2025 10:24:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6db6sm261203165e9.2.2025.09.01.10.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 10:24:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2628C5F81C;
 Mon, 01 Sep 2025 18:24:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org,  Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 8/8] scripts: Add helper script to generate eMMC
 block device images
In-Reply-To: <c8ea640893668e7f03be36c56c0ff1ee5b91c945.1756706188.git.jan.kiszka@siemens.com>
 (Jan Kiszka's message of "Mon, 1 Sep 2025 07:56:28 +0200")
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <c8ea640893668e7f03be36c56c0ff1ee5b91c945.1756706188.git.jan.kiszka@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 01 Sep 2025 18:24:48 +0100
Message-ID: <87ecsq13xb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> As an eMMC block device image may consist of more than just the user
> data partition, provide a helper script that can compose the image from
> boot partitions, an RPMB partition and the user data image. The script
> also does the required size validation and/or rounding.
>
<snip>
> +
> +echo ""
> +echo "Instantiate via '-device emmc,boot-partition-size=3D$bootsz,rpmb-p=
artition-size=3D$rpmbsz,drive=3D$outimg'"

Given there is no explicit option for emmc which we can document in
qemu-options I think we could do with a basic documentation of the now
user-creatable emmc device in the "Emulated Devices" section. You could
then give an example of the scripts usage as well.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

