Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387B1C678DC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPLiy-0006gQ-0j; Wed, 11 Jun 2025 09:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uPLin-0006dB-Bl
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:42:32 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uPLil-0001JM-Il
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:42:29 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ad8a8da2376so1088478066b.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 06:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749649344; x=1750254144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWV0y1jqfrm+V4ifvzzbEC2y6LGcH1PfIgAegq8b/dM=;
 b=c81LJj4M20LEuqAae80QoOwv9HSDUYtgwDiz3SK8Ix5ZheDJbgqdMY7kXOGxhTkmdj
 PsHYCUdQDwsT8JP7Lhk/qbd7k6U7cT1dHugIW9SKWL6kDJnYlfHUpKfnEsT2q7JC1Grx
 Kka0ovy/l0YsW/0B30rJBs2F+8roxS6xQ3/QTV+XsZplad2AwBp8Enriwh41ylQH7ORy
 Wc3BLD6AH8LWzXh7+L85omiEQokxyRxggs5Xwk6bmWHbmZ6XJXiqkaDQtH163l+2ZuEr
 6MNvqIIE7kb9O/prI2+9uw0DUyg0FoPlmq8euyU6itEn1ccbQe3xXM/cz8Gkbsar/pBL
 QNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749649344; x=1750254144;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QWV0y1jqfrm+V4ifvzzbEC2y6LGcH1PfIgAegq8b/dM=;
 b=vnyLdZOb3XDXFQD/JvnGbu3y5A5415F0jYjTOa30Ru0sNwLHUNd8nuQw1YPl89E9el
 54mPDj9fyfH0VMfd7z/qlX5CuODgKn3N26AGNeBfIRerf7johpyZ44b1P009CHVC50FV
 NNIrVAdMqqlFDBnrk0xQttOOOPaJfeU39FhbT2foj9IZc7KewL/l5cB2i+GvXR5e3na8
 s6E1VSzLIOJEKAmNuy3b631XHQGlzWkzlKd9VH/fKVWrRl6QHi62k7j710OoS3tSH2HM
 keadRy+dxUClBF6+0vrF0pi4lBj6Kc0XcCBd9Lu7OxuJg5gbWUslFpMJz18L3XF89IvS
 aEOg==
X-Gm-Message-State: AOJu0Yydsm/6rPt8nZJi+2hdriiA9L1IHvdQXHVgocBkEFoRk457I83N
 CBtfQIofxuXCh5aujT+nfLgyKREdp4IP0BXrfdo3PScuOaxAKtmhfXCLCTPKCgtjRufPeJBQx5s
 bSUG0
X-Gm-Gg: ASbGncsQQw0J7odPDfa4jIDrjSRf4/U0eBDV23HsckVFEpnAiOoC9xVDNHdvyvVWcq/
 dN8N73g9IFfLxN4WYmbQtPsj2QlJZIsJ3TUhJzNqo83g+0w3gSxPdp1uRUO9HODmVgvPBeeC+zl
 2SBkUPIrBqsnqbGAAt00O3Df+19lXl4Cp118oEcQTV4MovFnnm58HXLkgybccJH6msrmA831eZh
 Mbs9DrbsROBgIpU3SX3hJVhkZhJnsCrytebo5/aoKe2jUOhp1GDf/8z4tB+WYjflAURlRfI5Dms
 451Gv6Zbcy3uA6GTnkvzoj4w9WQbQWg4tSqQqFbF1IFR+vWnSuJG7YDj+FmlClA=
X-Google-Smtp-Source: AGHT+IHn/Xu8DvmAaya6XAsgy9V6hqz1g+B8d1TD61hM5RBSVNg/mq30wLNCBugKdoR4C2n8f6B+Jw==
X-Received: by 2002:a17:906:ef0a:b0:adb:4775:93c7 with SMTP id
 a640c23a62f3a-ade897f33d4mr330394066b.56.1749649343654; 
 Wed, 11 Jun 2025 06:42:23 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc1c725sm881171566b.84.2025.06.11.06.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 06:42:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 90EC75F7CB;
 Wed, 11 Jun 2025 14:42:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH 04/19] accel: Propagate AccelState to
 AccelClass::init_machine()
In-Reply-To: <20250606164418.98655-5-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 6 Jun 2025 18:44:03
 +0200")
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-5-philmd@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 11 Jun 2025 14:42:22 +0100
Message-ID: <87v7p2jsxt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> In order to avoid init_machine() to call current_accel(),
> pass AccelState along.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

