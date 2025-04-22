Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F62FC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 15:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7FY3-0001dW-5c; Tue, 22 Apr 2025 11:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7FXl-0001Xs-QG
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:28:19 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7FXj-00011U-GN
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 11:28:17 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22928d629faso51032195ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745335693; x=1745940493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LdttK49l/6ZiMsoZwTHhYmnlIzPyU7tOPY27PVyCtdc=;
 b=MH3QH1kzk4RcFQiCfvAz0vb8e+LQSCWM3/TXmugUgshw9rikgU5ag1M7hxUXptPni4
 4umEHeByvcH7whfvc1Xawzb90MQzBL0UX2GOh9mBQBCArDK0AIZx28rLS0ifxzxAMDNu
 KuzY6qBOrst4O0afBi/l/yHg6PORv8sZPvRftVC9qX+k9tqUWZ/40VNl2ZTZ7iCVV9tz
 CiW+/4s+f/RJkZ440rkrR5+Iv3sNHwKJIg/QQrumj08QrPk38Mp20X6bhxE54R62otiY
 IPwbxkXiYY+vjRLaiuZvtNh5T9cSQ90CaOH37Jc5AcGXm0Ey3jhaZBx1zkMZK+F8C4Lj
 LT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745335693; x=1745940493;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LdttK49l/6ZiMsoZwTHhYmnlIzPyU7tOPY27PVyCtdc=;
 b=u73VZ5xr9rGawE5KuKsL28gJwNSg/KmxDDN86CeNsxNsHG9DYfbKaNJKHNIgpfdy1j
 Fe5WakuXbf+mQvISEoXqb3gFUWrZEy2/R6wwd1wSlSMs68ZlFPqdRBGP+xZvCzgemIQl
 AT3unM6/oEpVKYZsTkePEcKghu7a/UiBdodVq730XPD8C29PRsAl3JY28LqAi1t2meVb
 Ft0LeFr+fmh2ldagvOlhaJm2fOs6IuBXAXsikGK3bUOto59o2xEwYUkun2PBdPzC8Daj
 Ti1WabMKOkdPDEXH1Tmk4g38JgnJUx0iO9hUEjFKYhikIXxAwQZTkBQTL6rZ5obkTDuG
 7xHA==
X-Gm-Message-State: AOJu0Yy4vO13uCxJfZHLu+K/VbYdtHKPL8ZnfAlE3umx3yuedWZ8OYfS
 AtiTsNYNxPs8Ghz1JegURSmsDzx7r6Zpl5iN/ldbzErrF3F2U+3MPpyIcAka3D2g20WV/UxOP3N
 7
X-Gm-Gg: ASbGncuh5eE2ImDISyjIpNCr3cRuEuCmZ50OxWKTWTym100TGHdZeoFVbGYCfg+lstF
 v4YahDooZ0k+mCOBvAg4ImisoTVwooiouKUov8IQriVgRLRFHtpMGs1G6Kc4Xw/2NdfyqccyEDZ
 SVGp9AbtHker/8R3+NqlQhGrSJYMSMHO+DTUHB7aQl4JYX5Ozlsn80BU+E8gJ5cofFfI34SXdd5
 +qm7kjpjQW+0w3y8Fial3n8kGQ6+th6HRdNbz8Qml6Yi539vzdjKKQqjtxBKUWpQHyzgIIHBdtH
 G6SuBOGlxkbd/QnmKOSv/g/eP1avjRbocVbhfs0AdESsvyuSPrD2Xn1pNPl1FybK2QLhYGcDuFJ
 OihcjLyA=
X-Google-Smtp-Source: AGHT+IH+RjcNYS+UguA4XMuyKwjvhl9yYDHDOOWvUZ6xWSzSon4KuE7FWJghdO02OK1tBSufJ942ng==
X-Received: by 2002:a17:902:e808:b0:220:c34c:5760 with SMTP id
 d9443c01a7336-22c5361b398mr207865235ad.51.1745335693644; 
 Tue, 22 Apr 2025 08:28:13 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bda9cdsm86628185ad.22.2025.04.22.08.28.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 08:28:13 -0700 (PDT)
Message-ID: <2c2706df-a59c-4ad0-8c47-3f58a07328af@linaro.org>
Date: Tue, 22 Apr 2025 08:28:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] target/i386: tcg: remove tmp0 and tmp4 from SHLD/SHRD
To: qemu-devel@nongnu.org
References: <20250403092251.54441-1-pbonzini@redhat.com>
 <20250403092251.54441-3-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250403092251.54441-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 4/3/25 02:22, Paolo Bonzini wrote:
> Apply some of the simplifications used for RCL and RCR.  tmp4 is not
> used anywhere else, so remove it.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 51 +++++++++++++++++++++----------------
>   target/i386/tcg/emit.c.inc  |  6 ++---
>   2 files changed, 31 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

