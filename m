Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55473C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 23:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts9Gy-00023F-Jj; Tue, 11 Mar 2025 19:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ts9Gu-0001yw-I7
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 19:44:29 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ts9Go-00007T-Dg
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 19:44:27 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6e8fd49b85eso73304426d6.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 16:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741736660; x=1742341460; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=05As+0Mth3HNDR6zyqKF0J/0w9mSNtpEfvIDxuvwqL8=;
 b=eeQs4DtcFNwG9bxonvmDnc2/NUMz6RWFNPYfGyopmTsVW2sEVlNTitmbQAHRMcLwoQ
 ys0SrMI+hgxfTV0z2PiJjDlEcQeMUvs/dYfzeVxQ7SO9k21DSUHnkLl0DmjGj2+grP34
 7xlgr+HP8SI0VWjX7MdsbS9SitAwjlyrbcpRYorvFFj3h0CmXgUIQSglZr1SaT7oicUU
 vrIiSrzcagqp6NMB+mh4crC4RcUYpjjwNaYjV9pf40TCtlFa6Jznx3TxQRMTNxW4gKQ8
 LXLXPGk5x6xPF9iyIXqMTuMOzE7T20AkFiEOz9iXdMMIrXzCU+mxSYSQ2DvgSlnli3OP
 mYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741736660; x=1742341460;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=05As+0Mth3HNDR6zyqKF0J/0w9mSNtpEfvIDxuvwqL8=;
 b=kXAv0VJPWSza9m06zw3SeSHyxSigQjS0UU7tJnkfbMJn5dwSI52hH/A/81PEJXZHfX
 bRpOd21SoaNXD/ST9tZh/LYXfp3VDl3pZAGknpjB06XgKGGGtpzFdcwBZYOh/nphnQLj
 SGHQHUbo1hxrsStju4szVgD7wTtEk9UmDYU8xZRuvO+t2WMmJ7X3YCI42jHcliO2QYUT
 irQCZn+8I9mRJhPsOvg6Av6D/hZHasb2bknmdAuSLwO9RFPlAFUYRhKf9YLhVT3PJqX8
 BH35qJ+SmfhaQBGrAHY1QYCtbr9cJR+fiDZjca1k0WyyHYFvXeubPPay17Ly3m53BscB
 /ZAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUkd+z4F0xaXELJksunqRssptMXQZSefplhnEq3TIQSS5J9P5CgTiqkJs38tpE/iVcjcSCF76LAqsj@nongnu.org
X-Gm-Message-State: AOJu0YySPWBi48bQxnQhICy25cR9aEOCxiFiFtMgTzJS/hHxIQiwWGF2
 NVmrFMB6l6AK46i0gUZ52itZxWs4IVb80j2JRh+9ju3/ZmOgE+v+
X-Gm-Gg: ASbGncswWrMHFwtwUXxYkB859DBGdrSSIw2ZDYuy6TxZrW5tYgZOJdDm9lzvXz/ekKi
 ye2hIycYJkTxN8k9tvRuUI48jTAFixgI3JdQmpPechsJKOJgGHGZSoOvyMZK1a8F4EM27OT17C/
 d7osMTp645rzS4M6mb21zpCFu1X+Mj5sF2bhk0ThHPz6+ZFYMxbOWOJNSld751QEZBFbIiDPgrI
 YB/XMeWrGBkZpOvTHZVJ8LhA89T+YDXpiCSRUN49H5WV0igljjSg0HjMtSicT3c2BNIfhDOovvN
 oTuJNeIyGuyDX2cy4RnMEJiCAtgZeESswzk0WouW+Q2/Fo/h7WzFFTCrbkq2Kgs=
X-Google-Smtp-Source: AGHT+IHilSajJPZfEkli5t4H/7fpEI4cmlYPbwILcz/ztAoH/DUXrUbGENLW9xoyiwVWh6LV3KC01g==
X-Received: by 2002:a05:6214:da9:b0:6d8:9062:6616 with SMTP id
 6a1803df08f44-6e90060420fmr330275436d6.7.1741736660550; 
 Tue, 11 Mar 2025 16:44:20 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:a832:3b35:d71f:4119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715bac0sm77807006d6.70.2025.03.11.16.44.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Mar 2025 16:44:19 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-32-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-32-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 31/38] target/hexagon: Add {TLB, k0}lock, cause code,
 wait_next_pc
Date: Tue, 11 Mar 2025 18:44:17 -0500
Message-ID: <00ae01db92df$82046510$860d2f30$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgLZ4uZptOwv0aA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250311-4, 3/11/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf30.google.com
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
> Subject: [PATCH 31/38] target/hexagon: Add {TLB,k0}lock, cause code,
> wait_next_pc
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> {TLB,k0}lock counts are used to represent the TLB, k0 locks among hardware
> threads.
> 
> wait_next_pc represents the program counter to set when resuming from a
> wait-for-interrupts state.
> 
> cause_code contains the precise exception cause.This will be used by
> subsequent commits.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


