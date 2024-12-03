Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8923DE69EA6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIV08-0006C2-Aa; Tue, 03 Dec 2024 10:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIV06-0006Bn-Bd
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:39:46 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIV04-0000yB-RY
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:39:46 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434a1fe2b43so51221225e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 07:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733240383; x=1733845183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wD5Ww32SqsbLurZC3NteIq86Z3QBn4l0SlXxCzvawy8=;
 b=trQsbMDLsjOvu4jUWLhNu4J7e2g1cz+CSPSGqoDlg7XXOhiFoMHL7wtrvkxe13RTSW
 F/ByZWgDRVIOGewLWLDvYDDRhzI+U/9mXk+q7zTzZvNoIC6+sS8ngKS72n7MEAI/TKAH
 IaAFfClDfYCC3vMsr5JvzWFtJ1JF+iY6loFuhevAXUTYJQR1/Nr3jcMzPJYcW7eupDb9
 Xe08KaEUCg1KdFjjmFqVK4hesAV2gUoLwI11tFkL1R0F46ga246dvwdckx6xFLX5Tt27
 PFb4XCEvpsFaGGvgsFK4rpgLMcipgAYCXX9UL85SWwCjoynINZPkihRa5SfblbzditL7
 ktwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733240383; x=1733845183;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wD5Ww32SqsbLurZC3NteIq86Z3QBn4l0SlXxCzvawy8=;
 b=dGjxnFRXjkZgFk6DUwz7mg6+MJSDbRpXiiE2bQI6H8TRA1uY04XnmfQb06cpcnhWHn
 GGwR/wXU+uIBKI7OgKppkuE736F6BWklmE7qiyGYo2H95eSLE143baaVhIwsb0TyUAhf
 FgIxKELa3S/UjeLWlMRnbRkVNrkczNyVMZj5BZro0Tqdx9YfAOyTap/w05NB9g017QYq
 NEbaEY+u6cdHuCGMxA6sXOiDeAWyGk7OUmER4DjbpYQGtyy8CgC1biynBwTZE+xTxO7r
 ko8yRy5/ym0exS14oz5ZfPJuYD3ZdCY0xQ97zQRiTbyl8I3Y+owdOE47kPWV41Mk2WsK
 fO9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj3t0I97jlnU3GAxEInbPYMaThQXuCada6xMPV/jFmPbubf6EN68SlwC9ECIRZXW0hRNt4D+0bZnTD@nongnu.org
X-Gm-Message-State: AOJu0YzdIesyf3FbSb/0WCieEzoBi4odlyXZh7ky0/5dc4wax7sJj89B
 c1gLB8SPynRUveT8SYizBWE66M+ycBqcye7NCWWzrEcK290kQxIH/tWZprZgloA=
X-Gm-Gg: ASbGncsCj5FsXiQEYVcctYMPh6xnvwlk3j7ZZoyMZkeDz8oQZp44SNMtn6XhDvhvik2
 3tmVDD5PZnPJED7rYocr2cKK6sziz3TP9hbpzUtUkwOgNHElbOo67VmM0gTkMJFexTiVEHrhLFl
 pP+vx6eTs3nk69OznDLFFeWw6N+zDY6x0JvVOl4ZStlNKb6wWwAHjSskgMgm74XX+NGRZdkPE4k
 XzxGHCqrmC8zO9b6hG9T/raLnNtQ3IXPRwoX3T57So1RNVk3K7mnIemmQ1fzENELw==
X-Google-Smtp-Source: AGHT+IG5lTiZpLGWsDAfbvU/2a+K/4jrPX1DXjGGbL3KCUZszSzHPNUwbRBYK5UMebEmCmSneI0nUg==
X-Received: by 2002:a05:600c:3509:b0:434:9c60:95a3 with SMTP id
 5b1f17b1804b1-434d09b50b1mr26758815e9.11.1733240383108; 
 Tue, 03 Dec 2024 07:39:43 -0800 (PST)
Received: from [192.168.69.223] ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0d9bc91sm199500635e9.9.2024.12.03.07.39.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 07:39:42 -0800 (PST)
Message-ID: <d310853a-2d74-4fdc-bbbb-85d2a2c43fc4@linaro.org>
Date: Tue, 3 Dec 2024 16:39:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/core/machine: diagnose wrapping of maxmem
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost
 <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20241127114057.255995-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241127114057.255995-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 27/11/24 12:40, Daniel P. Berrangé wrote:
> The 'maxmem' parameter parsed on the command line is held in uint64_t
> and then assigned to the MachineState field that is 'ram_addr_t'. This
> assignment will wrap on 32-bit hosts, silently changing the user's
> config request if it were over-sized.
> 
> Improve the existing diagnositics for validating 'size', and add the
> same diagnostics for 'maxmem'
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/core/machine.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

Patch queued, thanks.

