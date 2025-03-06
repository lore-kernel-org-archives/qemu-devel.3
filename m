Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB59C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 21:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqIpd-00074L-74; Thu, 06 Mar 2025 16:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqIpc-000747-Ii
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 16:32:40 -0500
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqIpb-0005SX-4g
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 16:32:40 -0500
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6e89a2501a0so10292506d6.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 13:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741296758; x=1741901558; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6aYQdtyWQMbB5Ng3iHHRn4xuqgYsbYxigZPKqGANCSc=;
 b=H5NiAFnZoRHXd+jd0yoTFmDZ4XeD+nT5cOMCgfym04HYYGnLWhGssrsjhHBWyNm5Tp
 ynupYyL/yiLb1BZOj3SVhycognuFik7ibdmFgA1Nf1EH5Nt4ZTzC/cEsoOP8UkG/KOPS
 9Ugd4oI00HUyD1uLH37Sg4MPrYTOdkZMTi+9P5aswwGTGrJ/73828/T30NQv9X4R/8Mw
 d7nJpctQn2N+0DL7VEF9XKf7oNi5kjRPJW2oQWQvDR8SymSJkcMw6yHhFfONcV5Rrkl0
 XW7wb6U6GgzJoNTcaW4jMY5FhviDti6CtX6X7toDDfaBarMrx8U5HeN4mHxdKOgaZs+/
 Ve8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741296758; x=1741901558;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6aYQdtyWQMbB5Ng3iHHRn4xuqgYsbYxigZPKqGANCSc=;
 b=S3AAsfj52+PJVjcYMO0NMF6YPRMit2xu0Iqpd04K7u8m4yql/9p8WEaTPHcDiuIQlD
 wABRLsnsHDwaK4JZkrFvwpWS1TznBGWcEffiuWKZ5xQ/AGj54Puw8V6VwWSpWqD50dG+
 3iYq3XDcMqyyHUzkd9O0sO6XoEJQznoENlMfGdO/6udCxscScUG0ikNdWbl78dg2F5B9
 vLMcI/fvt6kCyFtMoe9zNIVJi/rHUraobq4LnMtvYzzVJUAdQHJaZ/mO9RMDPLe4Ktrf
 Sfnoh8A+i41zH3mo1XhPSNUYp2n6xgkkT7Gi279j2vEw3UIz+v2c3olJg9ZSaKRMH9N2
 jGSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6+UrM/qDqhPg2cQMkmD86CfOcqHbZZWaGUbcZ67yFLmsF2GrxChDirwnjS0ZGaEbglXkwpHOGANce@nongnu.org
X-Gm-Message-State: AOJu0YzQ3ciV7zP1rHvQ7uZoVWDFSMDIJKGn4OTGZ55Tby+cxK5TZsHF
 kMHPV0GbLG/MTVib0T8CoRxM0H5EZsoG0H2+8aQGLLnIgdv8NcT9
X-Gm-Gg: ASbGncuLPylBJv2RPOPrABSm7m7H5xW1x8fIAh7qm3RGakE/9LKJ3UEzy5DTIAt/JHA
 C1lWVAA4qHWduw0UAD8zxR1JrocRmI2NKcYvNu67VcoWf1Kxuha/uFsqkqI/REuexVbubIMtawP
 NtV53Kk5ViPhKkGbE9F2/i/Uf/p2gIyxe97+jlZRdpo1BNjmo91L8P8jExf28xeIbKGYYKcUBfx
 jG0TFnkzF74d5mxn+6pAbNBcIbU1oK2+ji3L5hYmcGDoPsZOyhD+DhGtbpVduCDFYo2kKyTQc2m
 v9k/ODikjs9T0fLX232WTI8Sw1ZcCfqI2g2tW9D6izwuPisGOHeu52Hq4e4EsDY=
X-Google-Smtp-Source: AGHT+IEHEI+u/gvrrNETZvhOt/wTHTYgFyUNTI0pX4BQnOGs6rxADOw/cwqWaXdru7UccVB8qLeA3Q==
X-Received: by 2002:a05:6214:d6d:b0:6e6:6a6e:7596 with SMTP id
 6a1803df08f44-6e900694192mr8752456d6.39.1741296758058; 
 Thu, 06 Mar 2025 13:32:38 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:f449:4838:1970:9d05])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f7090c27sm11455726d6.44.2025.03.06.13.32.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Mar 2025 13:32:37 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-10-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-10-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 09/38] target/hexagon: Add guest, system reg number state
Date: Thu, 6 Mar 2025 15:32:36 -0600
Message-ID: <023a01db8edf$4844c800$d8ce5800$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgHJR+d4tOy0MsA=
X-Antivirus: Norton (VPS 250306-6, 3/6/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf2b.google.com
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
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 09/38] target/hexagon: Add guest, system reg number state
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



