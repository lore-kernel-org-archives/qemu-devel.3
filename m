Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCABC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x59vn-000147-0S; Fri, 11 Sep 2026 18:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x59vl-00013z-8U
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:41:13 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x59vj-00063g-KV
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 18:41:13 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39b350c69b4so56697a91.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 15:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789166470; x=1789771270; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6+qRxgg9E8CgchbD97qM4tTX7Ks8f5CeiQrZx8frWrY=;
 b=MNIcS1KstuIjK9agvUbqkpxkow7/0B+Y7PwdAqZX51tpKJTe3+9NVzqwnKmgTemjKA
 e85tfScfyxRdQU8kATy8viqTOraprX6VF06gJ8o16K4zJR/SQfMpofmJ/2lDBPZ/uE5z
 hnQ7d396UD7nM8vFw6ItsM1SInq0xuFLzlXGtmmrifb88g95/RtKvmNHyzNY38AdJET5
 DRiDkkkeBGZd+5gW0N8nQ5xHNwYCPkSyUARGMH8iaj7IhPeAzjKkeM4p11WhdU++yKcQ
 sX8Eya6PDiGdtPm/4Ej9bD/nOUnpJ+UFeYrlAiNRY3UaEz9U/w73LTiawzq/GRuwx4d0
 W8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789166470; x=1789771270;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6+qRxgg9E8CgchbD97qM4tTX7Ks8f5CeiQrZx8frWrY=;
 b=EycnhchPvmXzxv0ueou8dgGuyrC27TyBuqfmrdQewx6aQFO+m05M91KiGpdiMmRgxR
 jigC+ZsoYqNpNdkJeMqi4ehx6fJti9IRLstdNjn9tw+sqn+HEgmXcKhlQAsQBwlZkxBD
 fc3+uVRVlae1K325RjChxJQVXf4QELs5is/2mfGquBqzQsbYhediwFR2VurCxLX9Mrys
 fM8pBAnSEsJnkFXAXruIWbZQgiTAUEVzYujFGmqIaeWuXi5y4o2VtBB18HCE/eU+l5f0
 Ygb40ChHU7BgBgrPNvyZkU9gZQvaTCInvgD2ilYKij1DeWXoVr82J7q6v0ymL8tkCiQb
 BLBA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxh7DIqGKVAGT814awyYnelxmX3YS0mvr69ECFmazer1RNt8tB4aHEqi0DvhArdcjUIU8spiWPd/MPt@nongnu.org
X-Gm-Message-State: AFuF++kAYHn4xyZbNRFkMCAXk5nYgcdbBGalX9BWNJa20GEb0uF6YrGk
 KgzkndNZdTU2SdY+e0HtXlWw1P+vUenPyYNj4ye/RONFS2HHog4t1LXWD5jcja/ClnA=
X-Gm-Gg: AYBFou3vUR4NXEtNvWtix4WzlcC2iWflRdY2o2DSmUXR9zqiHWJySaZp9yH0GGj5rRR
 2k6VBR+BvTrLOwa0hheYpfjmbWlzqf4NKfS1qpe8rqObiLy7ebYtGz+4vN62qQETKryBvpnSt4q
 bWyrQ8oJyGagU9xEC+YTDyq9LvBhdLYhzmzQiUcYt3aUn821ZBrPZlpNCgTEnH8bFYATRsrMg3C
 SWWAtB5eUV9NjIEuD+t1kLnww0DsTPLNsuYvF3DeZc2bk08PphCo84acgxyz9V/ZxDMASuTZq31
 AOidxScWvx9SHTYLQTNUTeLGO/SBaDHHt/ny0EvU6Qv928zQVMDnvupHXWSx8NDtoJTq3ZIDZxe
 t0ZFBoyUOB6b7/EZ1z6Uys/WjnlH6ZHAkk8SFLKLF0k+z1eVTBELwfANTH1ZAbzaf1q2NhDni8l
 i5Dvxrvg1eQhxB7smp4LZbqXjET7qGXzAnhXJuRoEvbMwKmsnLzMdxs9DyhPhPx+or6xWQ/R4vW
 WLv4OZgsPQFDaf+YXl9lplQLoMytZpDjhvix9Xr2P87we5o7vCVMQL0rAf/KM/Oqw+OqA==
X-Received: by 2002:a17:90b:3ec3:b0:398:9c00:29ee with SMTP id
 98e67ed59e1d1-39dbc6f44d5mr521846a91.22.1789166469672; 
 Fri, 11 Sep 2026 15:41:09 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:20b:7d3e:6a30:1f63?
 ([2603:800c:7900:ed00:20b:7d3e:6a30:1f63])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4ed79absm10237204eec.17.2026.09.11.15.41.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 15:41:09 -0700 (PDT)
Message-ID: <ab34b7a0-9e55-4635-9d48-c2479e0b14a9@linaro.org>
Date: Fri, 11 Sep 2026 12:41:06 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20260911160307.865892-1-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260911160307.865892-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/11/26 06:02, Brian Cain wrote:
> The following changes since commit 209b2afaface001c7d4d981e38f186afe7b24a50:
> 
>    Merge tag 'pull-parallels-2026-09-11' ofhttps://gitlab.com/dlunev/qemu into staging (2026-09-10 22:02:18 -1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/qualcomm/qemu tags/pull-hex-20260911
> 
> for you to fetch changes up to 8acc03787bd602dec74c0169cf8cf232356eedbd:
> 
>    docs: Correct semihost spec URL (2026-09-11 07:29:10 -0700)
> 
> ----------------------------------------------------------------
> Hexagon: v81 support
> 
> Initial support for v81, scalar only for now.  HVX support
> to follow.
> 
> Adds new machine definitions, v81 system architecture changes,
> new scalar opcodes.

Applied, thanks.

r~

