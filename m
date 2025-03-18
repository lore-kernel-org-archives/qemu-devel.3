Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11407C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 19:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tucSH-0004Qg-QN; Tue, 18 Mar 2025 15:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tucSE-0004QN-Ex
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 15:18:22 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tucSC-0002Vf-SL
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 15:18:22 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7c3bf231660so710307985a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742325499; x=1742930299; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xu9pD2O+h8JlKZ//cAun6+fOFShL014YY0T1KqFh64c=;
 b=NYMPf2Qbj5ALpPcMjfrdCtl+VpByhR0YMWuEFu9GBtpJDt9FVov6xLHB1k85EY2DhR
 giitT7N9Wo+AmuhYyp06CliH8/rB5w4NznI0PfA5KUplVegW+6kot0EafZjxWLEXfajU
 GS1x8o9ooDb6SuIY7FGn+gaN+hXkweRsWLEYuJalqRUwDnF3+4Dci5TrzvChthrKPx2z
 qddjcEMVbRTJJM/ojdZQXZ9A8Q1kelv7yJCq+8ZMKSjlPPn9swjq2VJ/QzsDpwpY4KzR
 2BtqWO50qxMSqYBDNqhj16HY5Zis1sFmHiVQ4zfc5BH6arMAR881QZu6t4cPtOA/bNZh
 Q9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742325499; x=1742930299;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xu9pD2O+h8JlKZ//cAun6+fOFShL014YY0T1KqFh64c=;
 b=J8QOt4fXYwpjLVtG0ivhOd1jOCvbK4fxtBmiTKJVkk1/Naxj+ZJBgofglXPBVvK5oU
 mj0H5uldbKmLwep7YoJCEw+a34W1JUHhZ4/fxff+/QdyeDSGkn6Ww7ZvEa3cgyl6xq7C
 9/CLppcYrbcWll826lR23mwrSG84nOl+UMMpRrEv5AzQ6HzAU7FPMWSyNW3mYKC8C5XE
 1gga9CsX9A+QAkotlRERuG83SCfeG9CGcz4XvsjeIPMZcVZBu9FsfGg+HvtlxVV1On5C
 8kKVUpr/k6QLtJ3KJMPqVqlOtGKHwN80ddaBRKa6KRG6SVlOXOvsdwFAScE7zwI13UZw
 XYrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfgg0+Sp55+wpOEMQGzpXwAA4juHCkGN6lcP1VNmJUap6TeBkZqyomzXEl5bIYkgeN6xOt312WbZ1v@nongnu.org
X-Gm-Message-State: AOJu0YylJPqclNrgkkxajyqHTr+LCk1jommy4dNqqfDbpQW7orztYL1P
 5H358E/KgZ+h8oOKWl4fe7QqhFviedjHCelBZl2RYEc6+7X8SDFF
X-Gm-Gg: ASbGncuMI8dmKZZdtBI15Rbu1vDn3tXPNYUw4JTPODgdLk6w2A9BoT2+j0EbHIbWWLZ
 KpZrxE8+0B5yJkF8fRNZ1aJD1yQwSFhjMfJY9aN4Cj3F7yAT5DFkJElq7d5toMZVVWU6Y5jAEN3
 CzKDx5p0BKyrmjgA9N95mrFssXZ0gb5BE6GncJE9upccxcFkCLKKMDZdtMVsQrCC7a/4BUZ8pa4
 Qr7DJ4jnsII0/WLcP3fkdpEJXHxmQvZODytVncXscDHQwToVc79B6SGAOlLDHG6WsJ1U2SGjBU/
 wW8p8LGqG58bTJM9PHgeBYzBl/QZnjEk5UCuAF8UwdchdxtXWY1mqfQmj07ZWeZTAcJB00TmsA=
 =
X-Google-Smtp-Source: AGHT+IGJG+nYyavhYIVYG/CJdmVW3fEE1/IUjkYALRm+vdnGSel+S6B4WR4rC/pfEr+aawAbZDBC2A==
X-Received: by 2002:a05:620a:172a:b0:7c5:6396:f161 with SMTP id
 af79cd13be357-7c5a69b5f44mr66887685a.49.1742325499677; 
 Tue, 18 Mar 2025 12:18:19 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:6d71:de10:2e5e:506a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c714c0sm755677285a.40.2025.03.18.12.18.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Mar 2025 12:18:19 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-32-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-32-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 31/39] target/hexagon: Add implicit sysreg writes
Date: Tue, 18 Mar 2025 14:18:18 -0500
Message-ID: <026a01db983a$82531650$86f942f0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQHuTzxtsvRcQ+A=
Content-Language: en-us
X-Antivirus: Norton (VPS 250318-4, 3/18/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x730.google.com
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
> Sent: Friday, February 28, 2025 11:29 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 31/39] target/hexagon: Add implicit sysreg writes
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


