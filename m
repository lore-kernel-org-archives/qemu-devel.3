Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BACCA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNiD-0002kV-ET; Sat, 30 Aug 2025 11:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6r5-000598-68
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:41:55 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us6r3-0000yU-Ox
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 17:41:54 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-24457f581aeso22726075ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756503712; x=1757108512; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iRWmr1O4B2f9bSnHePOREzILiJcdrkemwQ+b4kVuZX4=;
 b=i7vb3wAIn5xr/sLsRZVsH1ndUYpxokkCXKxDjChSOfNpvuS+Mx7nMDpa4avSmapZvr
 VSPhQSZ/7491uctRF8IAgmVvZSs3aE0jXIODEv6Ek8ASluHVuK8TJL1+ClZrMLkDlcKt
 78rGe8uEJezGmVWdNkUQtVRZRGQNvXcU3lx9iAcqu3MM3W0aoHQkOPYm6+WT7D+vMgUT
 MNOKkdfInkT04pZtcibHUGpEb6kFO+BFkLHh2eyb88Zrx5GU+sDpPldKldnBUshRVTgN
 5c8Q8VAVDgyDE61I7hFjNEmEFSG3JDSyZhFpxAvCKcwkpUXXpujg7oQ2m8sagxIaD56M
 AZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756503712; x=1757108512;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iRWmr1O4B2f9bSnHePOREzILiJcdrkemwQ+b4kVuZX4=;
 b=S2HOIRvIthbgjIwXN5Yw0QjGXTavwX5fWQk2NpQYtV9VaN8Guw7fG/Im/Q7Pzd/yvh
 ja65b6v9NLNQuz6qm7zeI+NF0xS99y6CEh8mAopmr2iz6qpPrfX2YWlyooj440gYqFbu
 cExGiJkVt4DML2BLkvUu1bHhNEw1KlC4O/pszudUPlAVOO2whvR+t8T2RfVRcgeaDO0l
 IYT0EG6hX3CFIh6BNME+c191oy44mSc2fU2wFpr4y7FssAuz/wbpA2ynniyeoL4N/5h/
 pFxKSbRjbWjaBYhceFQ1stD1Wdh7819V01MegSl1SiXEX/mVlNSmxCUWSR19/ObNv1NJ
 LOrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVveJDpXderZWXyLN+/ELg8a+536MTg6hdSaNn5V5pQnDxhVB04sRNkDMrxPhdBQD4WWCArjhddEK30@nongnu.org
X-Gm-Message-State: AOJu0Yy6m4YqfXfHLWvPdv1heOe0l8vOkKC9aaxsQ6G5WmDcg8gXXvRR
 mflnlQEMWZuaKz3uCe8Yw/vzI/eK/yKU0CMnfP3/WHZ+Td/LmKeOoclgVggOTtD2+FQ=
X-Gm-Gg: ASbGncu2je842y/X+M4vg9KVCq9afzsFbsaqGtl1DN4Qb0Okx1Zk/wjBZKWEv3MBVP0
 qGui0IYxIZ0f6l8jQtV9Q26GqImsndmyteWm74ymU8n+NS1f3vjHmdFVG6osRmdfPhx9FMG9dGD
 FNv/ZbtFpl2jWUuT7d0lmor8DjN69RZBkw6d868gYI1YIV/JdKGbuKR8VIwtnGnNafuVKgWwlkb
 AP8JdF4pr4YJbto1nFl2mdV2kw566145v7VrX/Dy4n4HKE6Yhvd5HaMdfrgjPn+LtnGzgsGFRmG
 p0HB045DGGjDgWi7w3p7gwCkHYpJO3k5CxsEUxrZpAWU7t+x9IEb1uF6n7Og4FMhofdicVDymXL
 odxsXcggVEPqXgNO7Y3Tb50Ye3pm3/zxOPyyB7uWHFEbb1yOh4O+HFpbZsAMuiX3PU/5MJA==
X-Google-Smtp-Source: AGHT+IHXAOWg8AH03SzYUwqrV/u3iomI6/7DwzxRxYSvv4ngAbAjYVZgxIgWcS3Jdj8XK/iy8Yy25g==
X-Received: by 2002:a17:902:f68c:b0:246:cfa2:81df with SMTP id
 d9443c01a7336-24944b3fdd1mr1051285ad.43.1756503712245; 
 Fri, 29 Aug 2025 14:41:52 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-64.dyn.ip.vocus.au.
 [122.150.204.64]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903727e23sm34709725ad.45.2025.08.29.14.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 14:41:51 -0700 (PDT)
Message-ID: <5bf9f7de-c798-4808-acca-8bacce96abee@linaro.org>
Date: Sat, 30 Aug 2025 07:41:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] accel/tcg: inline cpu_exit()
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, imammedo@redhat.com
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-8-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829153115.1590048-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 8/30/25 01:31, Paolo Bonzini wrote:
> Right now, cpu_exit() is not usable from all accelerators because it
> includes a TCG-specific thread kick.  In fact, cpu_exit() doubles as
> the TCG thread-kick via tcg_kick_vcpu_thread().
> 
> In preparation for changing that, inline cpu_exit() into
> tcg_kick_vcpu_thread().  The direction of the calls can then be
> reversed, with an accelerator-independent cpu_exit() calling into
> qemu_vcpu_kick() rather than the opposite.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   accel/tcg/cpu-exec.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

