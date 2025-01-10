Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A935CE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHpp-0006Nv-EL; Fri, 10 Jan 2025 11:26:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tWHpn-0006NK-NF
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:26:07 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tWHpk-0007Ko-47
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:26:07 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so3248039a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736526363; x=1737131163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MRBBn7ua6AiQncp4edi4fCUImhcyyFRONkXQR3rJUMk=;
 b=UH8isYE5+iXlCBjUEzgeYQUyuIV1+la2H6f4CpL4nhsCDsN2TMizPu6hmWkxRhHA4b
 kPDGtVBqwM1MHGVKlnLTnuh9n2SoXkZND92sgr+qWHV4ODB7SYhpCI5vp5J89YdfVWMV
 KWVCgNe+SwjJrhabMYoj2NCBhq2S1L0zGjK878tOQwxSPIfbwi8VhL7PBhLKcCL5ih3g
 IkPoz2BguFkUl0nThzkiESevKtcCP7RtVqmWn4WpIKXROpjAKwxLJ601iDTG2tr4WCZV
 Qbv9aCpdtFsgdddrwxP43wWPy7tSZJ8Mn9DUwSVog5aeyEFsL9ZFKudDAYdULfVrb9hX
 q2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736526363; x=1737131163;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MRBBn7ua6AiQncp4edi4fCUImhcyyFRONkXQR3rJUMk=;
 b=Ore+7pa4GyMIb84LLKOKmhfros2HYlPhanoyyQoPe9/bVarD7f4DWn0tQG6vWE+Vfq
 tAmMLjwNBRON0kAnIrZcFqn30jgxkjV8arMarciAhn7mFzK3hWuB+mB/Ct+KMgdMjf2E
 X8oyV6n62R3iesolp6HbPGE8iopX+0TlqZS622SPHDPOHu/8MH0bJNg7pQYIFpjRvKhi
 bTtU45DhShqTQW+X90uraV9ozJ26HJjnhhtWurQ2CmPAUG0NAvw2KEMrVWAFwP2xaBg7
 9wtbhrFQi824WhNUIPjJzkJFVDDLwqt1TXQk/+RrKyjPracrwyis1fqwAJ7s8RnjFTAv
 5Iqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeEt/7B87vBmzaYKkyUNnMA2iVMI2bRmFhYZucdPa5/9oIPGqSkewGBZ91HKzyfmB/pmaAE+ov6Afx@nongnu.org
X-Gm-Message-State: AOJu0YyLJCgrA9ZNNs7HolTpyd/KWCIs2LgsBmV6fVSfLUoXil18+0vD
 q9TRXQB9qAXtPR73weG0iBx3LOTNGWOKq20pxFDPCXU0dW+VigCwu6wAdILKOn0=
X-Gm-Gg: ASbGncuYZ+cmsNn6LDvd3/zVLqiN9GDlHc4uFDJjgUtYmecm5jLZW+/xSjj78NBAKiL
 Nt7TieePIo/zvkQxOi8BU1dPfeo1cNysW8RtJvUjUFxauEvtFyy/2nIh2UweKGEBs6FOFmrQBHK
 XhtQxmXs1MEwVQzl+LB4mQfRrXa0Z38WcFHwKR7S4vcMS5ZocMZZMsT6a6cLpIZ4Pi/4x+qdWYW
 nwWTybcthbmy6w2PLqL8sySJNthLDyIavz7p9FXS1timACNnhcQVNMnvNC8ALAk0xi9xkY5wS+M
 T16pYijrOKEB/3tlootvkU8UYek12v4=
X-Google-Smtp-Source: AGHT+IH6rmG5yMbM3CofLppy0VLZ6x3H0b0pNR5G+EotVu7h3Ss+P4EhdWnTg/iY4eZBgI00HGm0Rw==
X-Received: by 2002:a17:90b:280a:b0:2ee:d186:fe48 with SMTP id
 98e67ed59e1d1-2f548f1b5cfmr15961821a91.28.1736526362722; 
 Fri, 10 Jan 2025 08:26:02 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f54a35b125sm5683048a91.33.2025.01.10.08.26.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 08:26:02 -0800 (PST)
Message-ID: <08932dd4-f4d2-4eae-b237-2975c820cec1@linaro.org>
Date: Fri, 10 Jan 2025 08:25:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] ppc/ppc405: Remove CPU
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250110141800.1587589-1-clg@redhat.com>
 <20250110141800.1587589-4-clg@redhat.com>
 <1c294e9e-8774-4e3c-874c-d64bcc0f7ce7@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1c294e9e-8774-4e3c-874c-d64bcc0f7ce7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 1/10/25 08:15, Philippe Mathieu-Daudé wrote:
> Hi Cédric,
> 
> Cc'ing Laurent & Richard for user emulation.
> 
...
> The deprecation message (see previous patch) was about the
> "ppc ``ref405ep`` machine". Is that OK we remove these CPUs
> for user emulation?
> 
> $ qemu-ppc -cpu help|fgrep 405
> PowerPC 405d2            PVR 20010000
> PowerPC 405gpa           PVR 40110000
> PowerPC 405gpb           PVR 40110040
> PowerPC 405cra           PVR 40110041
> PowerPC 405gpc           PVR 40110082
> PowerPC 405gpd           PVR 401100c4
> PowerPC 405gp            (alias for 405gpd)
> PowerPC 405crb           PVR 401100c5
> PowerPC 405crc           PVR 40110145
> PowerPC 405cr            (alias for 405crc)
> PowerPC 405gpe           (alias for 405crc)
> PowerPC npe405h          PVR 414100c0
> PowerPC npe405h2         PVR 41410140
> PowerPC 405ez            PVR 41511460
> PowerPC npe405l          PVR 416100c0
> PowerPC 405d4            PVR 41810000
> PowerPC 405              (alias for 405d4)
> PowerPC 405lp            PVR 41f10000
> PowerPC 405gpr           PVR 50910951
> PowerPC 405ep            PVR 51210950

Up to the ppc maintainers.  I don't know of anything interesting at the user-only level 
wrt these cpus.


r~

