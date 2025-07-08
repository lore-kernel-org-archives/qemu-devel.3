Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DC9C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFHA-000201-1m; Tue, 08 Jul 2025 16:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZE19-0001qF-Qg
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:30:31 -0400
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uZE14-0002xH-SL
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:30:12 -0400
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6facc3b9559so75760646d6.0
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752003008; x=1752607808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gJfeKqNJvliyVsof1tnXNWGe5oI1E6MCoJRkgy/dOSs=;
 b=OiOp0LVwRQtcVgAZImPiAK5XQeNI/xhyQzQaQtNGYatNZeYNycvTPvmAzXootjlp23
 mNVaPWa+JpSQGPH2hT/DdfPScnNQikLRvYOS43R7QJg6IhWqGeeGOY9XlW5FswfMLfqR
 GOxQB72R8YdPeJMN4cvUz0B1AeLUTfNRG472Yu48PPrsH4JSgl6+hjkYDb6yI/GIbojN
 6cYStrF2Gk1IfuDMaecP/mrXt4jrkh7mSGIucAUNbZktdnooeaFWlvolaupnfV7c6b+w
 4LH2ZgZl6+ZKabetWVX/7R163GnCenPTtEiid/CLHsKboulY1OGSeXdtBU3+6yCsibVD
 IlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752003008; x=1752607808;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gJfeKqNJvliyVsof1tnXNWGe5oI1E6MCoJRkgy/dOSs=;
 b=wihb9dJASU8ZlMOWjkeKFY/KkLigfgGzlZIHmEC1n8pIcIJZkQMBkd/62tNDesjnPA
 0mtlH5p3IThpoBR1zfWvTDPR1iiJ0tU42zqKb2G8vljSipwokBJh5E0l/HH7M4eKSOVw
 9JdAkiR37h85BAzaVrXCgiSaTRAc2Xha1NdpNCTS8sgvwUrZBJs5DXJ2Z+3Unx+iiR2Y
 cul8HtX3RXACwTnRG/lMJYU6/d+qpdvEZHo5bWKxuk/nYryM2akPpZz3kbwctWx0Kkrl
 PbA9MxBEBs0H4XsrcmXFxgmC9hfE0MHnvzq2Jvd4X7Lrb57Rs4jO/2YmFcsagWVl9yKW
 gxSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE+3eqT+sA+GWqxWsV+GqpmMrnlSNbkggtdDQCkr3YgeWBo4nCp2aunlyX5FjcXd69MDf2Gyby7mK0@nongnu.org
X-Gm-Message-State: AOJu0YzMHNDnebyofye8vw9sIbxg+Ee2v0a5fTJz0vveOAEN7+w5ZA0x
 YDagBlEiS9Perms5t8LpmMyqqX2i0z8Wfe+PsWrSouGvSTD5AIRpFK1hi/Nv93s7u/nXRBP3Jiw
 nNrv5
X-Gm-Gg: ASbGncuM65A/Oj3qn7RYFYnkBIvPxhY8FHJSdxLi4FBcsDpv1iFx7CcYEpW22fqQG83
 7nlqZ2hl26YrPae63eyny+mLNBBb7c1JS7/OalAY9koKbYMalLEhPXAjLx8va5Anzu8zImu7Pts
 dxMzFZ9nOSDP9JP9Cqkxhpv4uWIIfAIylLX/Zk4eCdR131cxQ8VdqgTFMs6/emlB6aP/y5wajB6
 cQ7LchxKuiG6Jt7PKbiLf7UFVw+ZX/FIXBteQ9jQUEs9yeD54/l2f4jhvHeenWYZ/gOIQ2v57vZ
 P5d1XOLS+vkWRF7Qc4PJSP7RsGaCZ3aLFa4aSPnow9lCfFR+bKsD1rAzoYCoRtgLUxptjXLqDlM
 =
X-Google-Smtp-Source: AGHT+IEpzc8plQC4rcAJGrcS24kwQb5Eh/ouKne5TQChs8nh1tzAlwlioMkMRwTv9sLvZ7Swcd1aYQ==
X-Received: by 2002:a17:903:1b47:b0:234:eb6:a35d with SMTP id
 d9443c01a7336-23c85e77329mr246108985ad.27.1751995953966; 
 Tue, 08 Jul 2025 10:32:33 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8459701bsm123651925ad.205.2025.07.08.10.32.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 10:32:33 -0700 (PDT)
Message-ID: <1b58205a-1794-40db-8e52-d2a4c4a52956@linaro.org>
Date: Tue, 8 Jul 2025 10:32:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v7 3/8] qemu/target-info: Add %target_arch field
 to TargetInfo
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250708171949.62500-1-philmd@linaro.org>
 <20250708171949.62500-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250708171949.62500-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qv1-xf2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/8/25 10:19 AM, Philippe Mathieu-Daudé wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/target-info-impl.h | 4 +++-
>   target-info-stub.c              | 1 +
>   target-info.c                   | 9 +++++++--
>   3 files changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


