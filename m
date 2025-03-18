Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40A8C28B28
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 07:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuRVR-0001qw-Oc; Tue, 18 Mar 2025 03:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tuRVM-0001pX-0r
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 03:36:52 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tuRVG-0005nk-PI
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 03:36:51 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22548a28d0cso143892425ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 00:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742283405; x=1742888205;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/fRMP3gMl52AoP58CbToWvuE5l8CGfrdy2D4G5KqF0Y=;
 b=zHaM88OcqHtjWtRIlETL66jp9L3mxogKdVeymNQkCuha6tbrTqU1/J8UbZwCisHUHT
 iA4pmWnRTjfFDkse4YKNGHlvmQUT8A33dvcUM7GsPqYviCzC3KQELi6LeqGBeF7gjsia
 g0Un8dMtY64vJ8At3hNwE2XGEab3YvTp8N6exzXznaLZrbLCJYO3DV8u7M/tH474z9Ae
 0PwHlLQV/yL1aPwFTAdiOCBA03hKB50EKcX/cUpt+92O5RRcBuI58pr/GSK/9pw/2Uhe
 C2TKOVutvoCqQLc0kkSlcYNDnNpsLb0lr8cao48NrZ82e8pBF+k+DfwXPs/TBH0j4hLq
 qrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742283405; x=1742888205;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/fRMP3gMl52AoP58CbToWvuE5l8CGfrdy2D4G5KqF0Y=;
 b=MQ0OstNVdfs74oMamCz/1tBP5v8aXmk1FsOIHWoDIAvK4tQqIyOgvFFY4i1UJF9R+F
 +syCI58X90Xw32s2y5F0h/4DEeeZIEpdHAmzGAKp3xEGhA7Xq1K5zv8IkKLTZVEuy+iY
 dTTLTeAcsq3yTneeuYHCOLuEPvRVGWAaFb9nNCkt96L9AuzoqAQnzlZdlRnhfqnm1HLl
 NlJVvwCaTsSRb7rAAcxZJaDvtKcKRH6qZeHuNZJpR0MweQNrn77J+6pgg81HsyZolaPy
 0FYPyhpDLpUP6k9th32hudhmNODPMZFpvxYYVMvX4cr4rg1tVzumZy4rkomdr0qeDToH
 Sl0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTw0hPkBNdmeoy6eHUbM6n7e5T/VH6kUooUfzV2xRbcsLS/s8u2nM46Tku+KniCUuSYEuaH7vn59yF@nongnu.org
X-Gm-Message-State: AOJu0YycUo2gIPlvZqD8En+f/EA7ckImT5esz0YLyj9hk+8s6AmtRtbn
 ak3gL7M3PCT+V4jgtMJ855DY1lrzTa24QWzUgapPiW3xss+cAasXGlYdHLPAhEw=
X-Gm-Gg: ASbGncuY7wI+Eks7AzYk/qPBY4LE4PSvxt4w9Z3ahcm7ryK274cOvisH1IK95kJPlMg
 CAxyOvKikSfYZYxtTyyLiC5hEzFhKj6+8xexHsuGqdfkjSOQPB7ZElnvrbSWRKw2sAchC8tJWoA
 cVRhM8WJuoEBKZyZwbLuNasQxWy3DQrhS6ERkO4mnb7pdMWe2581Z0y7YDcJHyZSA/bucGwrRuO
 S8aKm+q6INBaBqAikK9LA8V3MQS8OVgQ0MZoGkWzgTH4Z/QrgqSlctwYv6uBZl9+AwOBcY394i6
 OADhNlSYu404+H8UzqlpI1IlfCIe0fEqylbmfG5wFryMIJh71Dd9E1LmySYHbpEGCdA7
X-Google-Smtp-Source: AGHT+IH77ITq5RcOpTEYady99CB18PzmZqqDXfn/uR02Vq0Aibs357ERlOzXz05AZm1Qt2lZEmkRrA==
X-Received: by 2002:a17:903:8cd:b0:223:faf3:b9c2 with SMTP id
 d9443c01a7336-225e0a7a10bmr203109845ad.27.1742283404863; 
 Tue, 18 Mar 2025 00:36:44 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd40f3sm87669895ad.219.2025.03.18.00.36.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 00:36:44 -0700 (PDT)
Message-ID: <f53a6183-c57b-45ed-8b97-49366fb30037@daynix.com>
Date: Tue, 18 Mar 2025 16:36:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system: Use the meson binary from the pyvenv
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Cc: qemu-arm@nongnu.org, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
References: <20250318055415.16501-1-thuth@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250318055415.16501-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 2025/03/18 14:54, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> To avoid problems with the meson installation from the host
> system, we should always use the meson from our venv instead.
> Thus use this in the documentation, too.
> 
> While we're at it, also mention that it has to be run from
> the build folder (in the igb.rst file; the other two files
> were already fine).
> 
> Suggested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

