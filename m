Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2328C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QKm-0001BX-37; Mon, 13 May 2024 03:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QKj-0001BI-UO
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:42:54 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QKe-0000el-FN
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:42:53 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-522297f91bcso3072366e87.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586165; x=1716190965; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3vwz08eZRWKhDf36czrg/rZ73WAdFVg/QScuz6m5e4=;
 b=KgY1Uo0vENajjsMuBjcK5pu4Nyatdur214NR5gwsttOcpEkT71QpUcZEZo7hAnEEX0
 iAOcvs5c+C0E1WttYIn7qrAqV5oy1SUro6eRJdTLJT/OChWSTKnbaunZOT/AazHoRNqK
 xYBdRhMFCPC+mMZAK444R4tpx0NLh8rJR0Oa0hNbJesq4gx5/CbsABNMnk3CE7Q285ZD
 V8GEOgXCBR649pd0o00cnEjHkaMYWpTP1PEul7FbZiQ/KvtLWvi3rMEvS8XX8zY1Avxt
 jofk83X0HFSUAN3j3e9nm8x0TUtY0DLNkGZdyMs98V1bqKqtAJnts6l5yQ8pBkTBwTGf
 18SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586165; x=1716190965;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T3vwz08eZRWKhDf36czrg/rZ73WAdFVg/QScuz6m5e4=;
 b=OvXvgm+VK5lJG0iL6thZ6LIXeFQf2gMOaTcPz6PjxyOLE6W1an/qDHuWhaaqoKiRFY
 TmqKJjB9Pc4o/GD58Kt1H2+4nVH1NhYq+cj6864F6cEXWxgKG57oY5PAOdP/1139UmOo
 OL48o7jvgm9MznU8dmNtxJikumU441FULtYGwzmZoXZhGwo0LGrAbV7zbZknI5sfBaeS
 Er8Mfgg5wfrNQ/uuEPzhy+ZWi8vqQIhOXN2T8VEuffi8SWV2mccwwLgZ9keLzTLLnM9n
 f3j1lBMXZoKQyMBFmRktB01AO8BBx1g5DViAy7Hp4/OnhV2CRojf0e2n4eKjL7GgsaVD
 kq9g==
X-Gm-Message-State: AOJu0Yww6ec8c7h6BGssAaqq1cGVhpJDtpTjtujc8Q70/ZVVme/fHwpq
 He8HRHHJfc0pV/ROBQ1ZKBv2HeNkEYM7eLelWJsDIMctiAVA4QCaXTpHNTCN0O6tKZueZhfgbFz
 K2Ms=
X-Google-Smtp-Source: AGHT+IENVmniVOXFtTzw/vJHxSdOPA9haWOD3IxBQw3bAOHfkcAfnHNaC8cxOIxbokbY2ddlnPZMbg==
X-Received: by 2002:ac2:597a:0:b0:521:134f:dede with SMTP id
 2adb3069b0e04-5221027bd05mr4837002e87.68.1715586165343; 
 Mon, 13 May 2024 00:42:45 -0700 (PDT)
Received: from [192.168.51.227] (12.red-213-97-13.staticip.rima-tde.net.
 [213.97.13.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbec5sm10357628f8f.95.2024.05.13.00.42.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 00:42:45 -0700 (PDT)
Message-ID: <ce3105c8-e60e-4451-8626-fc190d9f0d91@linaro.org>
Date: Mon, 13 May 2024 09:42:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Subject: Kubernetes runners down?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Our gitlab ci has fallen over this weekend, not connecting to k8s.

https://gitlab.com/qemu-project/qemu/-/pipelines/1287356573


r~

