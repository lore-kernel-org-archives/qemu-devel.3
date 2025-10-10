Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304B7CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 19:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7IOv-0000ua-Br; Fri, 10 Oct 2025 15:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7IOt-0000ol-87
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 15:03:35 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7IOo-0007aa-TZ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 15:03:33 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-77f5d497692so3140015b3a.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 12:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760123007; x=1760727807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MvLe+dWmjO7+Ndnkl8LBzgvfrEZUBRWZy4frBR2hjWw=;
 b=jjt8T5P+lEQq4q7CLhztwnxrDbzjHyhflGFRqtXFiRTPbmYhwN87+Cs0V4DpybStWv
 +DajIsP6ckzRuR5dInqzSyhrukay6n2pknTxQUp2QorMga3n47LBqBQNwaEmxxCTGKv9
 l1JrHByhYYMrR6fKIz0ORpG7W7NeK7TWjx0xrET/2F3yEU0w8xldNd2H1VWo7cRRoeVT
 +RdYcvsHCKkTFygwzCOVz4xe4NSLUt/1IluBPClUF7H1RX1bPCri1/boO4x7kzQ2Wajp
 lBrhKvT213pmtVefgkS96ksGoPS9BqLTEVRF+E9LjG+HXepTx6oExMY+4BaKIAlKPSfd
 ETkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760123007; x=1760727807;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MvLe+dWmjO7+Ndnkl8LBzgvfrEZUBRWZy4frBR2hjWw=;
 b=YQU8j1uU7zydxXWPh3XnuuwIkJqq1Ph17Dz8a4Hteh23q94+AyKPfmrqEAo6mG4J5O
 BmcHnvISw0609lMj648wS4rBPuLNqCcV9XfK1ofEZZPIXOXtlMu5HRVtDzmr/+OFAcyY
 nUrmn9fG10ADWXCMZWjEEgjTZcBIb6AxMMEBg6LJMf0PhD1qmPnJ6SE3LPJJbIG5Qzkr
 GBRQjjHC99qu40HO7PgGJf7gZcxx2geAwwoHGZFD1ZE3y6TlOnaB6GDBMJQrmrd9un7u
 c7aMKjtMLu1iNsH3qyOmzIgSb1PKWFec+LJkWJGAumvBJooP7iUmnVWMmusrbVUizt5F
 XHIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0G9WPD4Fe0cOoXsCrkya3JcC5DeGiQEjTjVvBeSet/vvP488H1OlWK4FJEqnmUAxl3s13L3hu4Zai@nongnu.org
X-Gm-Message-State: AOJu0YzIRZReyHuhQIOthDniM7zVYlLiOdS2l/Lf7woJu77P4xNcqWgG
 auji1MVBWh4SXr3omYnyWLIjFbNxHGL8qOJsj1DoMFRIfIcNApOsLE9kfZeL7DwI6JZEKtrJAHa
 yvqVVm+o=
X-Gm-Gg: ASbGncsT65R7NatUllAbduEZjajhHLXBNxhXG0vtIOocWE4+c0638tY5SLf7hBRFOyu
 2psvnMLWB4vr6pM9R4CvHf/pHF09aPd3GxG5GhgezYxI8+T0epQBkSZ3usTpQpZU+zeE9K49v5Q
 cctoiFwwiBJSad+eZO2bSPvlKoR23jsXUjT+yC7FQ3wnXgq7y5cTLA6U/PHuKv43csQnj66dKkr
 rwaivOkU2ju3KS3+GsKV+l2tjYKCOZAIoSAk+vwvmysU0slk+8xe3uyX18tFXfpjH7v+BVQAnvp
 /AY8kXu+IbvVOEGpDMPczlWCvkJNCXZvEdcFObtG0f0YTgRTvW3K0yzMgan/eci8amEYsPz7I78
 yyU9CYhdD+wUxjgf6RDKwtCEuM59eggB1gfRlQEraknnaubo7M4usW8ROKbc=
X-Google-Smtp-Source: AGHT+IE9oI+JPNVfdy5VXLsmOKyyM6BZkRFi91W+hH1HN/DKd4aS9ov2q6MwYLaXtidAZR3ut9nNEg==
X-Received: by 2002:a05:6a20:271f:b0:32d:b97f:14c6 with SMTP id
 adf61e73a8af0-32db97f1cabmr8756953637.19.1760123006960; 
 Fri, 10 Oct 2025 12:03:26 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d9932edsm3692287b3a.73.2025.10.10.12.03.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 12:03:26 -0700 (PDT)
Message-ID: <0c116e6f-da84-4f94-ac7b-4b6add65f3a8@linaro.org>
Date: Fri, 10 Oct 2025 12:03:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] s390x patches (+ 1 functional test patch)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20251010082145.576222-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010082145.576222-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 10/10/25 01:21, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit 94474a7733a57365d5a27efc28c05462e90e8944:
> 
>    Merge tag 'pull-loongarch-20251009' ofhttps://github.com/gaosong715/qemu into staging (2025-10-09 07:59:29 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2025-10-10
> 
> for you to fetch changes up to 47ea7263701e85ea03270d34c9a90f3971597e06:
> 
>    s390x/pci: set kvm_msi_via_irqfd_allowed (2025-10-10 10:02:51 +0200)
> 
> ----------------------------------------------------------------
> * Improves s390x virtio-pci performance when using kvm
> * Fix a problem with losing interrupts on s390x in certain cases
> * Replace legacy cpu_physical_memory_[un]map() calls in s390x code


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

