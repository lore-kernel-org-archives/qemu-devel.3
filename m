Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688C3D10C0E
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 11:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7Ysk-0001qm-Kb; Sun, 03 Nov 2024 06:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7Ysj-0001qU-7X; Sun, 03 Nov 2024 06:34:57 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7Ysh-0007ww-LX; Sun, 03 Nov 2024 06:34:56 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e3fce4a60so2651700b3a.0; 
 Sun, 03 Nov 2024 03:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730633693; x=1731238493; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CtVJ6dyxoV/K/5YxWQMnGiMslLZ1jUynbInC7qgXZzk=;
 b=JOHCtxWmU4ifJ+imfo77wVASNQ9FpvAooVpdjiAny+Reg3mWuzwKp/oL2M1ip7e+ha
 +r7YyPyXna2Y/Lmlg76tFOEHUTzfhR6RoT2J9A6v3MQ5L6KBg5OQB83bf/FeDYSrS5qp
 iPPrpFBQoQ8gGMNmGdKXkLcPRZ4TA/BcsYmF8YACCG1ANNBug4hDIjI4UmXvl+FQshks
 iVIFR/b3Svy0b4evRuR7ZWXywD1I0cn3txEp4BBHkafPLBiSZk2Q3v3/CEGRL6T46DNW
 TbVrBLqqy5AlgyM8rcH+F+MiE1qM+p5xjHezv+1tnEv32ns2IE5JIhVTx8TtlN9zWXWU
 u10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730633693; x=1731238493;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CtVJ6dyxoV/K/5YxWQMnGiMslLZ1jUynbInC7qgXZzk=;
 b=kkqcu0uwx8+FpwdD6j0AaKSrTkx0cbODhwRO1kt76alainvS6bY0ERBtW8Hd0WjT3+
 MomE71m/rEK8Uj1IOSaxs54SyyQWzRgDY0fAsMRrV4TV/9KfZsVx0ILihPqyRQQRN8gy
 kFTSS9x0k3FqTGqOtBWnRPOuCoDznLqDGE0JsQDIzttd9rG/u20Vj/FaEMc7pedHvDWr
 aPyi8vZZPM4H1oNlCZElex912Wwwsd0LJHZwApjMz3KycNbAWc+eSRPYruOX08zEXHjf
 ZOkIQY68hNVRIJ1zUXQsTo2JeGCG+QNLV/Lv71jTNS0fa9IhMB1ky7ICthQWhOFpawxL
 rNbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVriK0AGcJaeI1JFeCCpU4PEJtD5PVJexkUQtMHLDXMSmf3qhuLrNP1/rX8TakwpkRsueP+12TOexM=@nongnu.org,
 AJvYcCWPpsn1MoXaGmt7PNGQk/Ufc9XVI57otJ4/X6kjyDK+LpDNaVlujO4CfT6P8IOxGOn/5LlqiUd1efjs@nongnu.org
X-Gm-Message-State: AOJu0YzFH6ybGz+Cp8WON8qhH880wosK8LK6hSxa++HHjqkLO201VPzw
 AqcPSmXt2wdEkZEi1g65g/LY0vHE89QR1GHhS0VQPwj/JQSrjp9F
X-Google-Smtp-Source: AGHT+IE152AiJm28fPeuQxES9dS93cYWY0jkHPlTHHseLIvaYy8NzD8JgmBXU27SJbJVitvsrpf7jg==
X-Received: by 2002:a05:6a00:b55:b0:71e:52cd:9cd4 with SMTP id
 d2e1a72fcca58-72063028d8emr38907634b3a.20.1730633692937; 
 Sun, 03 Nov 2024 03:34:52 -0800 (PST)
Received: from localhost (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72119bca1ccsm1293448b3a.128.2024.11.03.03.34.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Nov 2024 03:34:52 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 Nov 2024 21:34:45 +1000
Message-Id: <D5CIFVGK5UCZ.3S0N3TFQM5CCP@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, "Madhavan Srinivasan"
 <maddy@linux.ibm.com>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>,
 =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v4] hw/ppc: Implement -dtb support for PowerNV
X-Mailer: aerc 0.18.2
References: <20240820103003.550735-1-adityag@linux.ibm.com>
In-Reply-To: <20240820103003.550735-1-adityag@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

On Tue Aug 20, 2024 at 8:30 PM AEST, Aditya Gupta wrote:
> Currently any device tree passed with -dtb option in QEMU, was ignored
> by the PowerNV code.
>
> Read and pass the passed -dtb to the kernel, thus enabling easier
> debugging with custom DTBs.
>
> The existing behaviour when -dtb is 'not' passed, is preserved as-is.
>
> But when a '-dtb' is passed, it completely overrides any dtb nodes or
> changes QEMU might have done, such as '-append' arguments to the kernel
> (which are mentioned in /chosen/bootargs in the dtb), hence add warning
> when -dtb is being used
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

Sorry for getting to it late,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>


