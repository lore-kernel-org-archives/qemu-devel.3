Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D025C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURTR-0002CF-Kd; Wed, 25 Jun 2025 10:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uURTP-0002BZ-M2
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:51:39 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uURTM-0005hr-Lq
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:51:38 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ae0a0cd709bso212625266b.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750863093; x=1751467893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rf4c904YRpgQhEWMSdQwo6B5fLvCesC5T7RoQ9TZoFY=;
 b=wuLs/ewTWRAEo7KtQRqAXidRsJoPNk2/cMbP59AsFo6bMCm6j7lfL5cRpf5ZDlpxQH
 HwWdlqSlMS52T3cmXErMWBcwkM40bd/665Jd7/nuopZMiQcYF4h2iuV4PDt7rWJVrXEN
 N0McTi976CM8gau4v23PQbnQkPJfYDNFKWYUfkovTx3WWsPZEqZlPOiUMA1I5wCI4pDK
 HRc9NxRNXI9e7rpTzTMadgjNDmrSJZqwz5/pxUDZH1RPr2ryCLfpkZkqVR3BET7z2pbs
 dIyO3XWGYXJonc1K07ZmrqLfhUiJWTf8/KhveqKs9cP4+D2tm+UeQZSAWFnkBsadmsqZ
 UOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750863093; x=1751467893;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rf4c904YRpgQhEWMSdQwo6B5fLvCesC5T7RoQ9TZoFY=;
 b=r9CuRrFvUn6yQUoBntKvK1p6PefGKXOYvW4uNVV5c1zS8/TuhczPt6gX1lNCEAMBfc
 dgWoI3CNuU9hOiq0nYuQJu2+FwcdpUnO+wzHFH8K28ubc1zIU/90U96TWg/aMXBuPFNe
 IRb+WvzfPn/3JilLA/jSjfieBArf13sJfeazBQe5m/roAqRmp2V2fFIpce6jGr9XYum/
 Zi2i+/bQxfyz16f5SlMqy5gAyxXJsDC5HdRVylzRnQYQtjS2wsSr0ffWkbQHU9S1R/BN
 2qND9JJxwZh8UNceXOmTxtlPyQxHBspCewt3YaYvughIFZDSfl2hHeQTMDT89+4lNmqR
 c4BA==
X-Gm-Message-State: AOJu0Yz0DNRRMCL20HINW3rnewEXwwbXuogQk1b4NO4P41+g7M5uQm6U
 sYkk3TbJUf8/2X/svbEUiHirUx9zYTmUU5/3dTE8Kc99pNP4RFt6eycE8XkE/2ICpQo=
X-Gm-Gg: ASbGncusk+OGmbqZofDijeR1SlYUXGBNIxwrpjD9HtuPfZxnzzAj3IBL951PxXttRzl
 AvpychhzXXYpdjSBc7bZHx1FK9OHAaCzIrNXicfljnHiAMq6glj5FFkC/y/O6t2AY6i0kHEVQ5C
 kaLCNNMbzyeUqw2qxkuqVqBk5rj3yqvWjNPm9LhsSeazmmp/bGbbWIz5NiQQ0VKoDwVtHhTSWAN
 ej4R92/PNAjZ/pd0q03WllU6eA1ez3s+t0y2gbt8aIBoJlHcWi2Mk370oHEkSlyBvSf33eJj3mo
 hVqFpd6LvrX+RaCJdiG0FNsx8yC41HddeHZpqS+biTguS9WOynK0aUmNJLPkWqSFuFlm9Z+BjQ=
 =
X-Google-Smtp-Source: AGHT+IG5BXCvYNp40lsZBgYOw9xpXVB61rwvpEJ9CztIZkrQlK9MY+w/NnSixkYEerSyTz+s/WdQvQ==
X-Received: by 2002:a17:907:9303:b0:ad8:9394:272a with SMTP id
 a640c23a62f3a-ae0a721ec3amr723236066b.12.1750863092747; 
 Wed, 25 Jun 2025 07:51:32 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae0c9c3f6dfsm70677766b.103.2025.06.25.07.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 07:51:32 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5FE315F891;
 Wed, 25 Jun 2025 15:51:31 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Rowan Hart <rowanbhart@gmail.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Alexandre Iooss <erdnaxe@crans.org>,  Eduardo
 Habkost <eduardo@habkost.net>,  Zhao Liu <zhao1.liu@intel.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v14 0/8] Add additional plugin API functions to read and
 write memory and registers
In-Reply-To: <20250624175351.440780-1-rowanbhart@gmail.com> (Rowan Hart's
 message of "Tue, 24 Jun 2025 10:53:43 -0700")
References: <20250624175351.440780-1-rowanbhart@gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 25 Jun 2025 15:51:31 +0100
Message-ID: <87o6ubzxfw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Rowan Hart <rowanbhart@gmail.com> writes:

> This patch series adds several new API functions focused on enabling use
> cases around reading and writing guest memory from QEMU plugins. To suppo=
rt
> these new APIs, some utility functionality around retrieving information =
about
> address spaces is added as well.

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

