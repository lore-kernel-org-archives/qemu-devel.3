Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFDBC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 23:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts978-0004yC-Pz; Tue, 11 Mar 2025 19:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ts970-0004si-5X
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 19:34:16 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ts96q-0007CQ-AF
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 19:34:09 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-476ae781d21so1068551cf.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 16:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741736042; x=1742340842; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=RDJ8kZQDaiNBK9XSTZM9Vq3++kgKx6BCE07KjKmJab8=;
 b=gcvwMSiHgvt6/02yzU0j4dGJwhfwZTxN758VvskMJV4635oCJzZErV3f8JmyvTbNxg
 dJZzUFkpdrryIN4P5fTaCQDoEqCMTEj1iWq9mO3sFwT6dub+ObUKjKCKRILDoUCFLSeL
 bDWtqoM+XnOJoaqDqf0sFRDLhMvQddOjy7ewHoZadyMc+Xgryn2HQkLvQ2c8ZuChsOOq
 IrfY3kdz6VXdDQdrCif1C+nGphgJrr6Y0daoFttyp+r4Qde5ynLP1Z/092zY+O1glt4c
 0gEJdlWMQvL0+bdj20Ci9QY47kdj2t6FOfdxZ6KKfvWDI9qr96D4ryfd/dzImsXDP9XX
 xUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741736042; x=1742340842;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RDJ8kZQDaiNBK9XSTZM9Vq3++kgKx6BCE07KjKmJab8=;
 b=ei/M+9q4zel12I/PfHPQUZ7ykrXBCL3MRP5KIakOF2/KJdKDxVMdnQotUSY1GWLYsM
 WS9GIqu2DGfamPLb4uQ9x85Uc6cE8k+IqENh8oHuRJjBFZWuJV2gUFmxogBRaEBBVT/F
 pobA6pyqqBhklHfMpLP9v3uKgjyZI/PMqog47/kmzuJu/CzDIymt3ifv9yZjLCSettUf
 f6QofEANUU6dBHGeU7E1wxZpyvdmWHaEIQMEDEudmJY3iGOnDj6x7gOYAoot+E4DHI/c
 M38RxAy5WYQTN8axV4oRnfEDqo7HBSgJuXjmN8+8T6QaJWygLGk01VSGZjFA1ZITzMCk
 4CPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHJuRQr0G4B7ca4oSvxUHwyqd5WdmZxSCMqORVBUgHYkkwOALQ77yHLJe3TarXCwDh8wQhVDtMmQSM@nongnu.org
X-Gm-Message-State: AOJu0YwXdBPpjMNlkMN0QaqJ4KD7fxaQAeNpSZhdVyZzZc40iVchWRUN
 5i1vv9xJewVHCqXtkGgOnPrPRwsuGuDPuxCG7THYuGvp5o4kDRk3
X-Gm-Gg: ASbGncvpKr2I0N1jgP6oE63dXRvHNLWlaDyDOoZpu/JoNF5uboKxVqbWNSuYPXD0+Bv
 PhCHpY8FUlENptS3gDMacA3DXAOtBQ9L73/VhKrd4rg2S6cL4BL2dIKYTxBLDlzMPDoQDEgFVai
 DGTGTelAU5DEeDGn/VNPZrxY6e3aDIicz+GbQOBuRJprb6R0RBgWYhsqVah26z5qCLsmDqYuoZl
 7Dbsm5NCNlqBEDnFLnalfg2Ih8Bo5yJLnd1eTmIhZoy7OGn2XPbZB7QVL+h06RFbkVbezQ47jZA
 Fy3qtCsjO33IlTMOtZJ/uw0fe/yD03OqXmsc/ZaVMxtNYRtcHcARA8xghgZYyI0=
X-Google-Smtp-Source: AGHT+IEt6X8jCBX565DMtMOQzUREeci+vUdhq3TPAwFT00XPt9v/LQllT6vAEm//3V7p9/PIRfD+Nw==
X-Received: by 2002:ac8:7c4e:0:b0:476:9e28:ce49 with SMTP id
 d75a77b69052e-4769e28cf44mr66167591cf.43.1741736042474; 
 Tue, 11 Mar 2025 16:34:02 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:a832:3b35:d71f:4119])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476769014adsm44552861cf.8.2025.03.11.16.34.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Mar 2025 16:34:01 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-30-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-30-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 29/38] target/hexagon: Add locks, id, next_PC to state
Date: Tue, 11 Mar 2025 18:33:59 -0500
Message-ID: <00ab01db92de$119edae0$34dc90a0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgJNF0F4tPCTRIA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250311-4, 3/11/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> Subject: [PATCH 29/38] target/hexagon: Add locks, id, next_PC to state
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>


