Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31795C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzdo3-00016R-2D; Thu, 27 Aug 2026 13:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzdo2-00016C-BU
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:22:26 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzdo0-0006rA-RK
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:22:26 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so196817a91.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787851343; x=1788456143; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jDSES5tPeH3zWwhZK6eD8MzTQpywQGzzJ4q9onvN98o=;
 b=HamMBlc8iOFWTmnUTFMA57Y72Vs0Pvx0KUa6oYJY2+fWUwmv+xsoAkUEocEtAV0ej+
 OsPPQdgmUWyjOAgAUHoHogV3Im9NWxSgvulsbQRqZW0N4hwtQOfrybiosOhXmxrCuJTk
 IVBWFQZG2YUPwidKdSTihN+Ip+jQoyPdszTmUoQRhxmvNwhA9DH95IgExrABcrBoPKdg
 bJdq0WajG6HpZiOZH4oJcjMz/fDQwsZaJWnFGbnv1dMdIg6/WKwtJb7LfGbP5axgi2fT
 /ZxeeqIhep18NKjCwK6F+x2MjXdQOAWvMm48ztwiVBpC/5uGWRoX/H4Cd+IjmNd+UA22
 2O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787851343; x=1788456143;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jDSES5tPeH3zWwhZK6eD8MzTQpywQGzzJ4q9onvN98o=;
 b=iBxfSx5YTIoJYnaPsTjUX6VFVER7M7JqLA2bxVwzH6+3ch6kFVkgUgSkYJZPfUxFvz
 UIO3Bpgc1QskYcBlq259BCkyIMA4onmffdcD96Hm3bRw53DxoGSAbyJmLOcw4tofRQ1E
 ojFcm9S5RtOiuUmRLpjiOAMr1JHjROOce8oSktHHe/UfLGNPk/TjH+becqu3DIDV6kts
 heFvueVTBAXju6j9DffOd59C1jsyqQC3FnwwYKvw2CGvc6db7/zzRyo55bNDBvx2h8/P
 00uXZjswv2ZJQncsn/nUI8U9BJSQ6Re2CWDCyLjVzTwxKTnYpvMRLrsDBLBiAPxbB4/F
 aFAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrnGdFVAePDwXyreo5jSjjVPyAwCYV17TqbroCUrfNLvnOaKZyYM6RCse+YmRFlSWz8zUVMxTnCqIA5@nongnu.org
X-Gm-Message-State: AFuF++lR6uPXjdPHDe8fXVsODARHnMh1GPgHe77rYSulCNuis+CtQV81
 UWhRM2Z3PBmRVXWvsy/fl90i398Jo3DKJfFBGqorhqdIciURHgqLxf0ziq97wfIdW6zchlYVoa2
 qQTjsv0A=
X-Gm-Gg: AR+sD10fwUIn/uu21LdruowcNnm+3ttuUbU828R2xZLyKz5qnnCJiKnWeOju+WfJjv6
 +rrEsbik4Zg4K63XmDaJ9FcrCD3XKdQWhy2siV+S1JQtLgua3oXTAL1TPecI6tB6u7ryATQZAcM
 UwE2MxPkqnPd9WBNFghYkpvCW/pDtAqDDMouOAPi8e5BdtzlnQZiI1h7ac3daw99zqbfP8J1fZN
 sEZ8yoCSGTSGCrcwRQCwPQ2hrOunCfpsYcTPvzFr7JidKsrgbXmAm2phemkDLmasqVYJvUHYb4G
 5TP/xpq0FFNWTWaJq0tD8mwi2XXEnmC2jEUFec0fxQXh9udmmLVIhmcHcDegCiNoN0s1xAOdSji
 oNnW72rRnEiBO++oyEeJumpn1wrsSQntO3ouhOTlh60n1cGRGubor26mjT383zc4Vwp6vLsyq9N
 RdiqWtWmZ948pYXh3NvQsL8grZYnSL7jf1eRhnjXLhQmNeRqtTWxZq/y95q1OqjjU826tmv6/Zx
 CmbzubqfBs7S/HTaj9YYYoLpwGLaaxJokNhkGg=
X-Received: by 2002:a17:90b:39a7:b0:381:28e0:6259 with SMTP id
 98e67ed59e1d1-396d0fd46d9mr1046321a91.9.1787851342511; 
 Thu, 27 Aug 2026 10:22:22 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39675867f73sm3061190a91.4.2026.08.27.10.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 10:22:21 -0700 (PDT)
Message-ID: <300577f2-4724-45fe-bab5-d0a9df58a657@linaro.org>
Date: Thu, 27 Aug 2026 10:22:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] loongarch queue
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20260827012811.1008381-1-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260827012811.1008381-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 8/26/26 18:28, Song Gao wrote:
> The following changes since commit fe11f459f640cd08f35c21f9d403517951bfd671:
> 
>    Merge tag 'fixes-pr-v1' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2026-08-25 06:48:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/gaosong715/qemu.git tags/pull-loongarch-20260826
> 
> for you to fetch changes up to dd9641cb140d6e2c297f8d87c7875409e42319b2:
> 
>    target/loongarch: Fix SWI interrupt delivery via CSR_ESTAT (2026-08-26 21:40:19 -0400)
> 
> ----------------------------------------------------------------
> pull-loongarch-20260826
Applied, thanks.

r~

