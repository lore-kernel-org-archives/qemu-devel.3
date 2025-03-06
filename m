Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985F0C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 21:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqIwq-0001PT-SL; Thu, 06 Mar 2025 16:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqIwo-0001LS-B7
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 16:40:06 -0500
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqIwm-0007Eq-8C
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 16:40:06 -0500
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6dcd4f1aaccso18738816d6.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 13:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741297203; x=1741902003; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=C+tD+mcOIVJLkrCMKJ229X8vz3JWtFsoIz0j2VFKC/0=;
 b=KpvPFUkTjBOmYnSpzdy5hOY4vz6FjXyWSm1SUndy9fvJNJN5yUcY96DxCvQF3JGUAI
 OSwte5oVgsD2j/H1lqpppTrhODW9689/KXch0Jw9I9vkLhUQ0VBz3TyesBeqHBw3PClb
 9rLkZKM3Ky2W2AydoM8dx9Zw0lzRffZX3dkNxGD9L4lfZPSz46lbu1lFXiwc0a1knU0T
 wa9LAs10KNbuED8RG0CMeagnd8+bKgEIN0KrmXRo7V70SGqpj9Hj71OXAh4vlw7vPukx
 u2gnLSUU03rFhF3mOLluPoKE5SbVGVxOsjlkSoMhRuqE13N2ybJAO52NYUH959MsHRGM
 rfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741297203; x=1741902003;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C+tD+mcOIVJLkrCMKJ229X8vz3JWtFsoIz0j2VFKC/0=;
 b=Ybex+RDxto8TRquxv96fEP755/5Ph/Oi2cAzRJs9eEP+N7Gpkl9BDed/fhsrzrbyPw
 o+i+UqfiynEgA1uV/yS4KaHq0PaZ17hNpWFIJaD8TGWVEBgKsVbsfeUqI4xmoEoANhrn
 zIk+Lk0+cxWIwHCWXqZCGWMuchI/VzErEG1uD8PDUjzwgHSg8N9Gonf8BJDB3inchnGZ
 5qqLrjc+5bPfCeLuXEXIpdmk+KrpAeWixHnXe/EZA1v580HIFXXXpAZjspQqxdKE5OIB
 WMzkNHS7lJQ+wJqJC+KGOSdOCkHNNXCmvDotw+01+xI7ocJUoD+Svh/YR8JktyQw5Qdq
 RcWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX946SboD9STIVQiHbcSqvxuWIHXgXbBJON74v5WZ0ZdJHLWvrat98k4HVR5Ho4QpCAhEF2miKE0z86@nongnu.org
X-Gm-Message-State: AOJu0Yx531oZTkLRvCFEAemsbZeyYZkBGO9UW3mva2mV7kclDIF9fXbn
 WxpQf3A+ole5GIIvVsPMs0Xavt250yiGyVaDFbghyfMMbYAn0Vj3
X-Gm-Gg: ASbGncsK80QkH1FsA/V/xZ16EJTV1iA//MThEXGJZAFJrcGrHPODqdw7OT972bz2q1s
 9f47YTXIQ9N0zJqfLwA+70iW95F6oeUcbrBK3NM176ITOD/ckbUqqhbw8H3O2x/LDLgnQfbV6GX
 Yc7NYD9KpBgWEC6M/I9L7MMQFa2WtoGlF4HBHzSMytlLafrrzKoZDmE+3sDEHWSYVJb8Ds8zZtR
 z05IwdIaz6qiAu+soIWB2pX8bVRXN2KHzj2NZGFQsvJdqJeHyXHpz/CnTl6951mhQiPNgT8Fhb/
 fz8Kf+ifO0hXMxVe3lwFoU5fLcj6QBaS4gYOec1hckAegEwFNcOy9JQORPkQz/8=
X-Google-Smtp-Source: AGHT+IFA5PvfrYQen5NlHg79Ab95MevwW6hQKyePurhg2+Y6ddhvk6ONFfaP3ykkury0L08uLEVJZw==
X-Received: by 2002:a05:6214:1c4e:b0:6e8:ddf6:d137 with SMTP id
 6a1803df08f44-6e90063fed7mr9975816d6.18.1741297201848; 
 Thu, 06 Mar 2025 13:40:01 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:f449:4838:1970:9d05])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f7182eb6sm11276426d6.122.2025.03.06.13.40.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Mar 2025 13:40:01 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-12-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-12-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 11/38] target/hexagon: Add guest/sys reg writes to
 DisasContext
Date: Thu, 6 Mar 2025 15:40:00 -0600
Message-ID: <023f01db8ee0$50c15e70$f2441b50$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgHJqp6VtOyy+sA=
X-Antivirus: Norton (VPS 250306-6, 3/6/2025), Outbound message
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
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 11/38] target/hexagon: Add guest/sys reg writes to
> DisasContext
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



