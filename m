Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68888CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGZ9-00074e-N3; Wed, 27 May 2026 11:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSGZ8-00074G-OC
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:53:06 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSGZ7-0001k7-2x
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:53:06 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-365d8e43759so5995716a91.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779897183; x=1780501983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SGN8LW4Y5CWli30Wtq0+NAK7G5hcREsMOObiGtMIFT0=;
 b=xPig+E7X6DsxL45OR+1f8C/vk8UX4WIGzDLiL3k3D+zhmknJkOu4yNMWl/Fe3R9hDZ
 Af+aG0H9QoNbO3WgcOfg+JET9p0jtUnaL4hyL6ka59F35hXZdlQaaQRsbhjc6cwTe3ud
 DAPWUUyJS/NCpT9I68kINkunBQtpNE5TUc+P9b3oJB7ueCR4qzry9mORw9uvxFZ8GHXZ
 gSxPsg8GD3Hnj7Zu/FbZ81kt8GClTI6VDy+FbqIOvoyS+DnexERXBxOFwT1p2MqUpl6t
 cbU9s0OG0AHRc3N3zAfHKbNFLDJZXQxNCRtr6bfSu/XK5PFquNLfUJNV0sM3nGBKRy8I
 LGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779897183; x=1780501983;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SGN8LW4Y5CWli30Wtq0+NAK7G5hcREsMOObiGtMIFT0=;
 b=OyzyOPoohHKSGVWfy1lGyLq57pekQglnb2K8LElx0HNAO0bELy+SCk0MMar5kkNcQO
 qqBvSIGeQS+7kIncOoHBIFUIddSu5jbKO1rapNu3XK9/ttiVtu4km2eKLhkJGyIWsrBA
 Wv4++dCwOyO1eFp0e6yBXi1kRBkqOXMVQeee+PmzhP07BrNzOc8s2UFK9ftSv7zvxnSe
 u8SfobxkCRJZt/0tUbZKTW+w188qzJrSjJWCkiNBP2p2P7sWeraENsUwAItMdTPOjq/M
 lCtM9pQSWTTPznKWWRMnqWsko1Z5NNBgYaeu2ixb9xKccoJR4MWYy5cChXCG1S7D54UV
 nc0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+a3OBr5L42+YDn/4RYVUfyfhc7BHJnvxj9/V/Iq3x8QPzB9sIKUdBX/RUqZk7nutyE1xO5cstVXZEQ@nongnu.org
X-Gm-Message-State: AOJu0YzvqmVLuDR4Qol0A/OdMJhzIf6KCvAPMrb3OwzH+9wLBnMdLlST
 afVTe61JL7HuIs3kRhktBo3vYhSW8Ak0DmBs1skf1JQyZJ7Ht3GArE8jc2QrjrEukdw=
X-Gm-Gg: Acq92OEdK7FaJid4TzbHeiMf7VvxngWtdIDQAXRdXWP4t+e218zpd+9cG4SciTfYSiP
 NRxZG7GXb6rg7mLnrq0f3RczeQ48QL/NsHRsOddMLlm2ASV/WHuPo3uEkStZK6Q2WNa1BHCmrHy
 ajfyCcn5yddc46AZl+djdtRziuru6WBLZT7hjSW6fag87j8t7YThHWFz1HgugRq7O2Y/08ZTWYW
 blHgsHJKA/JJU8gWZc0VQbntuzSoFEbJ2AV8K0r8qbKIfhw0hiofRgsgVsiEjhrK1ZDC830/b41
 27oYIPRo8SDk+G7VGjX7hPjpkFCAzQcr6izPXe1IuXd/Gmh9tTWq7ajkIMYrmlm31JKfOSV+OsR
 7Cx+J7/yYvQP4WlTdrXEBrE1C0n5vX3b7i53FnHTqmyjjidczpB4UvGh2Snzg25ejVTL0OBF6K8
 EQcYUDaJmko/o9UnL+Km1STvWQIjotQrngjy8H5rVpMZLfQxg=
X-Received: by 2002:a17:903:3c4e:b0:2bd:5ed7:1729 with SMTP id
 d9443c01a7336-2bea20a2f4amr269874775ad.4.1779897183298; 
 Wed, 27 May 2026 08:53:03 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56ce4easm147189325ad.30.2026.05.27.08.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 08:53:02 -0700 (PDT)
Message-ID: <27b8facc-9b5d-48c0-ab84-6a8cedaa1672@linaro.org>
Date: Wed, 27 May 2026 08:53:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] linux-user/alpha: add coredump support
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Aurelien Jarno <aurelien@aurel32.net>, Helge Deller <deller@gmx.de>,
 Eric Farman <farman@linux.ibm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@kernel.org>
References: <20260526190535.10833-1-deller@kernel.org>
 <20260526190535.10833-4-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260526190535.10833-4-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 5/26/26 12:05, Helge Deller wrote:
> +/*
> + * Matches the kernel's elf_gregset_t (ELF_NGREG = 33):
> + *   r0-r30 at indices 0-30, pc at 31, ps at 32.
> + * r31 (hardwired zero) is not stored; pc occupies index 31.
> + */
> +typedef struct target_elf_gregset_t {
> +    abi_ulong regs[31];  /* integer registers r0-r30  [0..30] */
> +    abi_ulong pc;        /* program counter           [31]    */
> +    abi_ulong ps;        /* processor status          [32]    */
> +} target_elf_gregset_t;
> +

But see dump_elf_thread():

         /* Once upon a time this was the PS value.  Which is stupid
            since that is always 8 for usermode.  Usurped for the more
            useful value of the thread's UNIQUE field.  */
         dest[32] = ti->pcb.unique;


r~

