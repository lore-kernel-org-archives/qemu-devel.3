Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40A3C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGad-0007IQ-81; Mon, 17 Mar 2025 15:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGaa-0007IB-TC
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 15:57:32 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuGaZ-0005rt-4Y
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 15:57:32 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6e8f94c2698so23506936d6.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 12:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742241450; x=1742846250; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ku1WWaBghJdB7R8aFc2pAPIx+PZhUi6+nK9EF2tbWeg=;
 b=nL2kOfvVuwsaQjQM2GMWNcKEmicxzs8jOepUHoLNqWE/zWPOgXaeaEHfiRygenja6L
 kyZbS10PwQVfpc2jzSfgcIeYoTNzEhZ/KF6eny07fz6rm575XR3qfmRXUgGAzI6pJFN4
 PmajNECeaeGMgPfG+ix0rx8x9P6P46cL26K+mEEpD0QbxxxdNEKWw7ny7Gzt0FNbvjfg
 VQD6H5FinMfqMpitNfpBKBAMfxLl/dLFUC4ZvSRdXtffPqoRGKdpI2UYIXz6WS/xIGnO
 gs7Kfh9JgGkQNUYoS76nSaNEEX4dCENxFDcqp1dExEr2FSONQFvIJ8ejN8qOuzyC14zd
 y3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742241450; x=1742846250;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ku1WWaBghJdB7R8aFc2pAPIx+PZhUi6+nK9EF2tbWeg=;
 b=B737pnfNtPfzYPvvVTCto2V1dXeHFzXlySxR2wWFdThxv41ypsGM9CBfGF1soyyD46
 N6A07pyhzjUe1l3Xn8uMDFhczclHQsdJQt1py9mhgx8E2628iUzxWFmNCaplBrOIOMT7
 U/aExT8eEdo2XubIKUO0pk3QXgEYOWIeOO4DWe4luZB5JnH+Ylwutox8wyCqt8TLjuXI
 TXP2Wfpv5Gvis1Wlb4T6SZfCGgR0n8kCjPJttjGZt6vLk2wZN4cPHwOknhqtQQxF+d1T
 d4i5ESAqnXMEjV0vuvg+NdDaE96YzsmXw7ET/tT7Yue9jS8tFwnJXeFX6iv+oQl4E5HD
 8HUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7b4EX+94jZKDQqX3b+7+Mun8TJELw/CSZEzSp+/C+M6LjW7rUUMZqrOcmhxiAkqThEuI5V0U47Rj4@nongnu.org
X-Gm-Message-State: AOJu0YwJitOU6lZzU1a41s8QnaCPXdyZWhaipack/igcOWkCuOAhj+Xv
 Vrb42upDeIqrHD2clczS01bI24CviCJLEQUMHcBNznFFe3tZIqPn
X-Gm-Gg: ASbGnctszJ7qfeJONymVbeGFZW4VaETe6BbAXn27EMeoc+SdGoLVRb2wH6hdsDnJzec
 JXnsWnp7NceGkK1u6QJVmRBRaXmi4r85pP2dYrAwxYea+mv6lsYrfeVVr+UtkRkqUkD6BImFL8r
 Jg2KCAmQ3d0ZLwJT+Rn9Omx8uyge0+43x4uTzVDo52OMZTwWpZvJBNbrsxOygccyJ0+cxPAlgiw
 dLwQ5+8j6LZCwCsSx3uAz5PGmJmTpTNTo/pBZGFAaBVzlH8Oi/zofVmhgmABAPvrlPKps2e1K65
 2gBJhT9NFiwIAk3Wh02qH8MRsbvY8suur6Lw0E9heWF0h9oyitp0IrjHgsKBTv0=
X-Google-Smtp-Source: AGHT+IHmgmkVNC5oic6+VIdRRUeYDWLf5wfQImscMmzn78aAwcpJtFB6r7+F7hRSko3W3xn2I/95aw==
X-Received: by 2002:ad4:5946:0:b0:6e8:fe60:fdeb with SMTP id
 6a1803df08f44-6eaeaa08163mr195127096d6.17.1742241449774; 
 Mon, 17 Mar 2025 12:57:29 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade35ca18sm58379116d6.125.2025.03.17.12.57.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 12:57:29 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-21-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-21-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 20/39] target/hexagon: Implement siad inst
Date: Mon, 17 Mar 2025 14:57:28 -0500
Message-ID: <018501db9776$d0236fc0$706a4f40$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQKZUTmwsu19C5A=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-4, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf2a.google.com
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:28 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 20/39] target/hexagon: Implement siad inst
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> siad is the 'Set interrupt auto disable' instruction.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


