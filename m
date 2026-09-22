Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677B4C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93Dg-0000BR-H0; Tue, 22 Sep 2026 12:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x93De-0000B0-Li
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:19:46 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x93Dc-0007zz-Jv
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:19:46 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cebcb8d7so58003a12.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790093983; x=1790698783; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9hKeRvaXYB519yNT6zYdYj24h8ViUgwzQHoyneH+1us=;
 b=UbNzETDL0lK9mbApibhk52/KYmzwV7GM5+ikbEvUjVsqqvdPAXgvumKWpl1bvwXZpP
 ikPwWfRceObozszS8akU6/A1TlInq14wAHQFYSyAJODTA+xSu3d/ZgQ1z4oVxM8F9HJE
 hpXBg0+yEs6/Y2u/nC+Yd4piAiqOsH9Yba/1cJBoG1AtEnwLFabhwXG1hl2tRO+P7D83
 2qLs8B7LbiHYLBW/UX3rZikgcKC1YW3cseJZe9qK9liBLtjcgOrR1RFBhqYEP/oaAMYr
 D+yzrOG0F5XWQ3EzKXXZpPofVIr/XCmSaeIweWkiPRUXFCXtgj8GCTg9ezau0BOoZH9y
 RIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790093983; x=1790698783;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9hKeRvaXYB519yNT6zYdYj24h8ViUgwzQHoyneH+1us=;
 b=XNEY53VP5UQR1CerV3ECRc9g+nYu4LjB/259Q50k4oObCAf4MBO4PDr82IlOSzp0fe
 eWcm1y9+g1BZvtRcRF2EUiOhoisKlcL66LZdkmkL54U8qJt6KUKqitSCCIu3Zszdgtar
 B/+jnEtqfXpBmvYUNt2eo63wKZLrGYVMBX65v0mtmFNtmKY6tsxxjTVe1egIzdv+yRJZ
 byQU8SUW/KVRT7fz1GtNXe+SoRzCEboFtG/xLisPvgU0DzAG5k8A8da38ozf7QVjuPVp
 6dVXTAm3xAFdYDuv/mgG/36XpXn5LshrvasqXpyRwCHLD6h+aWc/mMCrnhPsQd/AIjEh
 bNlg==
X-Gm-Message-State: AFuF++m9RIDPVbYiC0es/dJZvK7/b7nOAeHhyzSn0R0qZXPooSvCnqTe
 I0cU/8/4oF7Wo8WtsDWmvwkJG2oN7KiWJxjOZ5Iu3TQkbxY1QGupVVR4rxAVqvOIPe1qn2gBXjN
 TgHmm
X-Gm-Gg: AYBFou2NZSs0/2slOXR1dBu/+WZ+M/PFU+lDBNWGYSE+7awi61ubiWjL1gGZ5Zboc6L
 1Q+sON8/A+vOqxM3aEw7f6BxYSIKAtjBueS1N2nb2uIcKoyxITLC6q8zODUZswfWdk41lHDmVkU
 6H1gANzqUO0ccISIybJIdYoKcOxmmBQzqZ7HC45u50z0tkoTIpb7C6U9liEB2sLOXYzkF2HVTHF
 RL1Wajanu/cjwpZg44O1chf/7JkdhVao3NJntLiQiqRskXg+RgpT3icWFkB1boMWVTEd1IVJ/1w
 dwY2hMB4VLkbT2uZNAGkVvCt3Tr64xpAAWBowROUK5NxfbIrNjVz57MlMe2qIcpSWykrqsZKOa1
 5cafO1UZIsU23GCa3iTBpWtpOyYg2ei9E2Bg02xC+jJztjgLuiLAuJcSnqKKZZSpUKG+77aVRvH
 T37HKYU+FVF+aAD/NUKu1634isS1laiBFSFAgQCWtPeSTkg1xVi5MPm+2NRxqCBkuL9S+u7ipOh
 EAvvcODsI+VIDcvdlGH1WhZvLiNFf1fi+3B4RxY
X-Received: by 2002:a17:90b:2243:b0:39e:6c68:fd96 with SMTP id
 98e67ed59e1d1-3a07372714cmr1274792a91.43.1790093982943; 
 Tue, 22 Sep 2026 09:19:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a07dc5f3d7sm140670a91.16.2026.09.22.09.19.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 09:19:42 -0700 (PDT)
Message-ID: <7f6d6414-3c9e-4add-a397-73b2d9be9579@linaro.org>
Date: Tue, 22 Sep 2026 09:19:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/10] qom-qdev queue 20260922
To: qemu-devel@nongnu.org
References: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

On 9/22/26 03:51, Mark Cave-Ayland wrote:
> The following changes since commit 67166d97a3269285aa68c489f85c9ccdf78495e1:
> 
>    Merge tag 's390x-20260921' ofhttps://gitlab.com/efarman/qemu into staging (2026-09-21 20:53:03 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/mcayland-ntx/qemu.git tags/qom-qdev-20260922
> 
> for you to fetch changes up to 3e4027a5c0ffc6afb3c1d298a2d88d433cac5f7c:
> 
>    hw/i386/sgx-epc.c: convert SGX_EPC_SIZE_PROP object prop to class prop (2026-09-22 10:52:29 +0100)
> 
> ----------------------------------------------------------------
> qom-qdev queue
> - The next set of conversions from object props to class props

Applied, thanks.

r~

