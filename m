Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE27E1099B4C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 23:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3jjH-0007rQ-3o; Fri, 20 Mar 2026 19:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <landonclipp@gmail.com>)
 id 1w3jjG-0007r6-4C
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 19:58:10 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <landonclipp@gmail.com>)
 id 1w3jjE-00008I-M9
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 19:58:09 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-899a9f445cbso28841856d6.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 16:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774051087; x=1774655887; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ks57RW+en4ONWkRvCJOQSuqmXz/QxxnWhHRzvSJIgHA=;
 b=SRfv5CKPh+ftCShAcPzcQ/06iEKhs1fBl/NXlHkhQkuHpGrNeqDNAvKuGWUi1wSpJQ
 qxw1XOPV8ckZ+zcnVCq1XLwyMwRsXrOm/hEX25VIMUm9kJ/e1rGah6tg5woGJ85pFO10
 45zawzeDmeBHnHtc5YcLgYdjZwgLjrOE3ZUgZ9MkKMcNu/x49Og1H9w1NAgV0nbaIroU
 DuSoXLb+icZTCv8wgYNhvxVGYg8PlhDOG5NDhuIK4K6ZMx/UC+ncvjefdAMIgIRY7SXR
 fHwMIrPYz7mx9gmA4AMdOKlWeeo3DcdUwZe68Wh4lZQHojJeUZ6Ft6Unk2kxWaPSC1LJ
 XlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774051087; x=1774655887;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ks57RW+en4ONWkRvCJOQSuqmXz/QxxnWhHRzvSJIgHA=;
 b=KQPEZ2l6ctJhfXxR6HaqDfOy03xcXB1hLy0re7PXtb42rM7HJT/T3KeDcCgLY8GQgu
 NYVn6F0RmNBtsxx2Hf9LZCDY00fEwKNUx5BeBKvF0Vso3pR/2AdA5EZxmwexXFhsguHs
 DQv7x7MjImciwdlFfPMYolImnqfIH/KUMttJBs6whlx0RkUlX4eTF2SwL18/Q2mit+sS
 mgZGf5SZm6Gq5Acr6/YcC1kSQHvaLqHwWdDk9AWDDuuGg931BwV3E98xahpeu/9PotRv
 JHKjc2QXtDHL/gOFXyMROeKV4SKTNf3BmmwiivKvkIRxi9xDvjWj1+2HUD/astBjsRnu
 PKbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPzhXZR+825nqXeXk4bIgP30GYHapDk4t62iuY8KQdyDF+lKvAInEgJrh9A+Bl6ZjgFdEKPhslOZnP@nongnu.org
X-Gm-Message-State: AOJu0Yyzpay0TtlVGJlgzurjMKJeUJNq99vxoU8m3pSfgnM2tA10KkuC
 qHU4pIS/e7zYUAVueDDUh2D1f4THuYJuliwzZIb6pP736m62tbCVIBXX
X-Gm-Gg: ATEYQzyPxIwXDSd58SUi4RjwQcETu4goexBnXNwIC3zogy8YhDT4/dFPSms4+Zsphzk
 0/1HnTLPICR1thYGaPpY5y2aMQvh7wXlz9vbsQ1yypmNOK03CI9eXYFaU1+RFouhxYi9xWI/UMD
 acCIMjflMwCPw6L+RsPCQYwcnogBxRenbZBYcKvLYF6AwP5854jeZkJoxcJGb+6Yvk68oAP4Nfd
 0AeeOR94GMsldVkD7I63qI76m/rTM/YocVWaY5r5ykIZhdF41LH2ApKNnYGuSeVT2rsi1/AXaga
 eDdwfsNC/MEX5CY6DRPmAIbPQj/8/AKpdjdNf3gB+A3+YbaoioiRG2y+W26HlI9qe9oXp7uo3Pq
 UYbGFCL43u7Xi7+xYDO/GNq5DZ6xokRMSm7Qwza+IQy2S4AmdLOchjlh9XyGvV3joEzReJ8eXfR
 kRPUXZ2ID5GuCeXyVkgO/iKblIERNu1DqZKD0WrBoE53PN80B1ZhXUb2FOsDCWmCFaOcdn+ASfl
 OOa4E+Z8G3rnA==
X-Received: by 2002:a05:6214:21c7:b0:89c:518b:9dbd with SMTP id
 6a1803df08f44-89c85a7e205mr83165526d6.46.1774051087345; 
 Fri, 20 Mar 2026 16:58:07 -0700 (PDT)
Received: from localhost (c-71-194-28-115.hsd1.il.comcast.net. [71.194.28.115])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c85215210sm31650716d6.2.2026.03.20.16.58.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 16:58:06 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 18:58:04 -0500
Message-Id: <DH80MH0YC5X4.2PMVY8O5WQJ8U@gmail.com>
Subject: Re: [Qemu-arm] [PATCH/RFC 4/5] vfio: No-IOMMU mode support
From: "Landon Clipp" <landonclipp@gmail.com>
To: "Landon Clipp" <landonclipp@gmail.com>, "Alex Williamson"
 <alex.williamson@redhat.com>, "Geert Uytterhoeven"
 <geert+renesas@glider.be>
Cc: "Peter Maydell" <peter.maydell@linaro.org>, "Auger Eric"
 <eric.auger@redhat.com>, "Xiao Feng Ren" <renxiaof@linux.vnet.ibm.com>,
 "Arnd Bergmann" <arnd@arndb.de>, "Alexander Graf" <agraf@suse.de>, "Magnus
 Damm" <magnus.damm@gmail.com>, "Laurent Pinchart"
 <laurent.pinchart@ideasonboard.com>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <linux-renesas-soc@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <1518189456-2873-1-git-send-email-geert+renesas@glider.be>
 <1518189456-2873-5-git-send-email-geert+renesas@glider.be>
 <20180209085024.004b6f9e@w520.home> <DH807PW5SQCW.3AA422QQRGVAH@gmail.com>
In-Reply-To: <DH807PW5SQCW.3AA422QQRGVAH@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=landonclipp@gmail.com; helo=mail-qv1-xf35.google.com
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

I don't know whether the threading will work 8 years in the past, this is t=
he
link to the original conversation:
https://lists.gnu.org/archive/html/qemu-arm/2018-02/msg00226.html.

Landon

