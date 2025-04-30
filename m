Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E165BC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACIr-0004Jh-4g; Wed, 30 Apr 2025 14:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACIp-0004J8-Rc
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:37:03 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACIn-0007Hi-Sk
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:37:03 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso2260075ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746038220; x=1746643020; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qI0Qr3sJ8BWLNtDXHSs21GX1niptxc6s+/cv7MszLEM=;
 b=zqXzvnTq7FOsY2eDLssXh09NTL+//x5OunFr/uXITUe9N7tRY0Sw5YY6A/Pc8Br3nb
 5AMY+wirujmqVAWBhEv8ic+LNU8oMINKP7TcGDx0qpXxg7KTZpYGbiwyB2W4umeLMpKt
 AU6ZzSvxKTMaLL1W88/fVDhLK86FzZQHh9WMOPC77x8A3D1kwWGfPyqy0MNpARSYV0FT
 MQ624k6y4JOTKUHAYppbTWhy+uWEg0mgWPkq6YxyRsaFgYl7N5KLKlIopy+NVEzlizjn
 o0yr3ws9hB7asvHBEtpzbV3RLmlsMLd2vMXJ9/2FU+UzU0zlHdl0A1f9kdN3B0X+2AUX
 JeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746038220; x=1746643020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qI0Qr3sJ8BWLNtDXHSs21GX1niptxc6s+/cv7MszLEM=;
 b=E4BRp7tEyCciV2jUwIGcKGgBewJVrE1Rp13Plu0NyjfinOS6D37zdPrnkXv/tuTR/k
 1XKxLO2O5NUvNWcPCxMJsyzb60MErj0innLu3mCh50CcxNaM3Dw3WBkxiCGJygWbj3Ke
 ekEsGk7e6RvXEVvJkJcNOPP+xdtfTtcjBo63rlvNqxZfoO+Y/C4GZH0ZjizQZ0P5xHMc
 +mHgYMx0CC3VVc1KRSUjCPLo6UaMs3u4JYlctUHqIKSLov2/+jJlA10kYZYz3RIqMTVN
 FWDMJNcQD7JFt8lhBh0RRCGf36qjrxsRG6I9heLWxuqBnbT5o2OzDYRKBy1fPUpBT5np
 DptQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhupCvsu+cjxazWQrgjEoEsvqxkOwWbimba6kBf9dEwdOPe3wtFKh9JWIAuC7jyzu7GZx4Qi+QyUFj@nongnu.org
X-Gm-Message-State: AOJu0YyeOU+YDNpyNBIisCeqLVUXDvd5QSbd3uQ2EtHLl40BT85s6vQ1
 nBM+is2pUSMizHrKnZJS8HC0okQjKQA0mQ1055CT1d1XC0/SCIrgbfw1H5OdZV0=
X-Gm-Gg: ASbGncvnPbhnjD25p0xghS+arz1spBZYNAOAgpq+pmIfQ8/oK+y34FA1fadIeaEzRxA
 rV39NW4h0eKdDg9Z8lmSPdQyyqDKNMINHfSbDTH/rgc842/tsI/BI8PQlGMDtUVNCxYYoGpsq1j
 ssiFmdKglL29FU7JIgnFVBtr0aodmTZ+fgrjOOkeuTFqPB7uwTgzclUkh7Us5xQq33jWAgx0ufa
 VFh4SE7QE7whTxz4MDxE0IYvC/EQWpprrb8neNDTGY/NrOnQ3jFG91ge7CdgEu8EFpGc2coL7nw
 EdK8u1CSq2Ue7NAAPY2EsSHik9/FIHcJmR3Sv4pGRMJovpysCIVwPzihtcqY1hQofFSmTc99S77
 /ziYWMTA=
X-Google-Smtp-Source: AGHT+IGYbEHufWt5jICpxhqSqovtwuspnzbcMjk29p/zyq7TxbJGOo+t2blgF/vfmRVoKNrbNlUnDQ==
X-Received: by 2002:a17:902:cec5:b0:215:acb3:3786 with SMTP id
 d9443c01a7336-22df34d5d89mr65461035ad.19.1746038219834; 
 Wed, 30 Apr 2025 11:36:59 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db510272csm125428715ad.177.2025.04.30.11.36.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 11:36:59 -0700 (PDT)
Message-ID: <01400e4b-dbe3-4ea0-ab7c-3acc726d52ab@linaro.org>
Date: Wed, 30 Apr 2025 11:36:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] meson: add common libs for target and
 target_system
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, anjo@rev.ng
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
 <20250430145838.1790471-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250430145838.1790471-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 4/30/25 07:58, Pierrick Bouvier wrote:
> Following what we did for hw/, we need target specific common libraries
> for target. We need 2 different libraries:
> - code common to a base architecture
> - system code common to a base architecture
> 
> For user code, it can stay compiled per target for now.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   meson.build | 78 +++++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 61 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

