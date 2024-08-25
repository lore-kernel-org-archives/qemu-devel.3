Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59020C5321E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2024 11:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siBWC-0001Ab-Qq; Sun, 25 Aug 2024 07:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1siBVu-00019H-HN
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 07:34:36 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1siBVs-0006w2-U6
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 07:34:30 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f3e9fb6ee9so40311431fa.3
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 04:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724585666; x=1725190466; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EBOPOD0hJ91yJ/PWd+Kka1k6IWK/LJzUbuBA4uXwCkI=;
 b=EBi3wiSBXj85LlQVx7y+LJzYQvxb5ZxuyyZExboVzHt/P3iUtVDNqTatfDencx4q4r
 usKaUdyzxGiEAHv03XNV7Lc3PsWZhytG7M7ZP16JEZEeGmB0J2UB2/YZNNtRLT28LRVp
 h8KcjLUM9jx3hs68qx/sxY03y3hwK2S3lUqYv8obVjSXpyzxEvZS6OCPGgX5sY3m1O0B
 ue8u8i3PTHyz7dGEuMlAEU9fPnAQKGFvT51+6IUOiYgXA8XGlQnfpgOJF4yfa1lWwiOL
 MNfZ6jWGlvYvt6UMvc/q1PqDq9KLbEcpl02NeKHxtj38EcOn2Kq1q04Q2bv5eBSLybDD
 E1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724585666; x=1725190466;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EBOPOD0hJ91yJ/PWd+Kka1k6IWK/LJzUbuBA4uXwCkI=;
 b=JmVXpNjbpj0AxHrA+LKLbFtOF8Z1rkxNcMoaAFfukBq7JalhS8sf0YP2PH6k7pw+0Y
 MDuhMsZGWDRa/JojV+bwJG6jFbJZztXGP4Ur6qZt3V/s/03aA16lhgMD8ImPMqJ7kuOr
 NySuqO6FHhxRMSCIdfC2AUq2KMyC8um3OUpJscoP8Y5Txf2JLn5u2cNCJrSi0UJvcfpb
 Gz+rQ35/wqd+kvGn/yjY9lFWNyaz4rwXTeiumUiZ0lnCJEsIDr3NyWOLWfupGgIC8d/e
 wH5jqPzYYk4jKPUWqW1fivtjHadDRmhTOHVC1fbCj5V5f3Zb1UOFuQSs5M/FnN4LaAJg
 8BKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqTmeLkdXSz2kuoD22VaQpyv0jlsGNIpXRp8ydiOTTj+OJr1gCbaT8AJ5BaBYbVP1W/WmEzEt7MsKQ@nongnu.org
X-Gm-Message-State: AOJu0Yz1sRymFLHEbdWQme94HTg8h6yoHIF32Jz5Fb423zF5ULyEDgyU
 19nVuIuJYZ3kmc5wIHWHcQYHxFwYZpiCl4HEA9/nwgKIqMy0Fs1+MPPCUe9kEJ/EsaQhuiEWsCb
 D+i8/+/7ri2m8JdOtj7mEcNWJNigNqwutXeKkFQ==
X-Google-Smtp-Source: AGHT+IGh43+fS1pL7s9nPmGaxB81uehVsI0yZ2f5VZmyNKeiE6JODc6GVOTET7H4uBqm4TFrXi+dc7aY33wcsu976eg=
X-Received: by 2002:a05:651c:19a1:b0:2f0:25dc:1886 with SMTP id
 38308e7fff4ca-2f4f48ec576mr44375681fa.10.1724585665438; Sun, 25 Aug 2024
 04:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
 <b88fe895e6f71711387ca153f4f1b3fbb0aa2176.1724556967.git.mchehab+huawei@kernel.org>
In-Reply-To: <b88fe895e6f71711387ca153f4f1b3fbb0aa2176.1724556967.git.mchehab+huawei@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Aug 2024 12:34:14 +0100
Message-ID: <CAFEAcA-OaQ1ypa7LXz5nOs+6+fjmYNHzNL0VVgapoXEHU=rHnQ@mail.gmail.com>
Subject: Re: [PATCH v9 11/12] target/arm: add an experimental mpidr arm cpu
 property object
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

On Sun, 25 Aug 2024 at 04:46, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Accurately injecting an ARM Processor error ACPI/APEI GHES
> error record requires the value of the ARM Multiprocessor
> Affinity Register (mpidr).
>
> While ARM implements it, this is currently not visible.
>
> Add a field at CPU storing it, and place it at arm_cpu_properties
> as experimental, thus allowing it to be queried via QMP using
> qom-get function.

>  static Property arm_cpu_properties[] = {
>      DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
> +    DEFINE_PROP_UINT64("x-mpidr", ARMCPU, mpidr, 0),
>      DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
>                          mp_affinity, ARM64_AFFINITY_INVALID),
>      DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),

Why do we need this? Why is it experimental? The later patch
seems to use it via QMP, which I'm not super enthusiastic
about -- the preexisting mpidr and mp-affinity properties are
there for code that is creating CPU objects to configure
the CPU object, not as a query interface for QOM.

thanks
-- PMM

