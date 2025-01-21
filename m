Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776CAC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 12:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taDbA-0004n3-UJ; Tue, 21 Jan 2025 07:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taDb7-0004mh-SG
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:43:14 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taDb6-0004f7-AM
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:43:13 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso39864325e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 04:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737463390; x=1738068190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39hGV73xlQVFRhO3Q0E9iziRakUgoWMVhB44UoCpW5U=;
 b=NkjsgIN4fJF4AvneMHgSTYybTEwIopRE5hxry7L7gAQCBQMxxDc+OerKrxRcW03sKR
 qbSii1go+4X1Sda5EbxcMO9YcJgMv5C2FzbnmDhl45AWwJwpr1T7tCLZQ0tKWKDWQFi6
 eZ+Rp5Hugx7RT9bk8sGv5NNELTIOo5Fimv/etFERUvsB1wxOZw5rED3KL4Hsda4Ojv5Z
 KAszRqTBr57ba6sfr2vbXOmo53sevAmTqke3S/PPS691I2O/L+ySqSSbpMWooo0xcnsM
 ptXz/155Yvuqa9WAv41jOUPqC1yXj0hNkrd+QD/z+OUVIVimzIxDuRmbkGrH8TyhAarn
 +fDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737463390; x=1738068190;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=39hGV73xlQVFRhO3Q0E9iziRakUgoWMVhB44UoCpW5U=;
 b=uCslvKlMh79wSF4U4Ppa5CTZuo5Jf13TQU2ciHH/WZFuZxCsMz0zu43WpSHQsYplQ8
 EXlfpf3EggnGrWJwTpCjWjhXL3c2VqrHGhn+U+LtyrRo+JdUYjDHdnf1BVR0DMsgKvLs
 RzO3oa+heoiCFkfOOI3urDRW934g9/xTgn1dilKCnpGMfvMzZjGp1UR1ZegoINKPJsMq
 xCUJI5iu5s5QiGlONZKOzEYNcPG0XwF37SNGFd7bsMJLGliHBEGtUJ1kOYBKmSH8NtHs
 FFl2sBVOStVBa8qs+GE6ZksCxrC202WGmLSCHw+Ya9be6z2CdXDcwhwUZXCQvTs+Mhre
 BJZA==
X-Gm-Message-State: AOJu0Yz/8QrJSCpK0jrTVSIHBH/uQClrQaXMqMXwzNTqj0uTTrmAwZBG
 W8tdYPmeHIYeC6bBn+aoNYW4P2oBe9/qpT2dwTH1W5mbkWw1OPbILRzX89oZt9w=
X-Gm-Gg: ASbGncuaTuPOK7gHeVRH7NxU4Op7RYiOdbRe0NPUoXr/fcu5IU0XgclWrC1ZEbrbyld
 Dl/P/47pDEof/lyiYdpBuqGevMCrYpqF/wJb/Chty2IkcGame8QC/zNAiFdykxzsjpcV6jAfYoi
 iIH3gAlgMsj9B3YsJyFa9uMjtL86/Vllsf/zWpgSB4DhL1d+wFZW50jgvb/BMPTjJjXux7UiPbU
 LNCjRntSw5KYNZnl4+8rtFTmc8mo9X3LWKTylp1/zXUTS7vUidPy2yYXOrgRZpgLEw+
X-Google-Smtp-Source: AGHT+IH5KK/0jUudyLqAOpoErAIZf2vY37MRlEN55SN/xNA6cbGQMzhImnGyN8wg0WDw0pKi4v4uKg==
X-Received: by 2002:a05:600c:4c24:b0:434:f3a1:b214 with SMTP id
 5b1f17b1804b1-4389da1e6c7mr139120275e9.28.1737463389661; 
 Tue, 21 Jan 2025 04:43:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322ab36sm13084330f8f.49.2025.01.21.04.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 04:43:09 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6545D5F756;
 Tue, 21 Jan 2025 12:43:08 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-arm@nongnu.org
Subject: Re: [PATCH 06/11] gdbstub: Prefer cached CpuClass over
 CPU_GET_CLASS() macro
In-Reply-To: <20250121114056.53949-7-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 21 Jan 2025 12:40:51
 +0100")
References: <20250121114056.53949-1-philmd@linaro.org>
 <20250121114056.53949-7-philmd@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 21 Jan 2025 12:43:08 +0000
Message-ID: <878qr4pcbn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> CpuState caches its CPUClass since commit 6fbdff87062
> ("cpu: cache CPUClass in CPUState for hot code paths"),
> use it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

