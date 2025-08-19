Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40002CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 21:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoU2R-0005LN-40; Tue, 19 Aug 2025 17:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uoU2P-0005Ip-AD
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 17:38:37 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uoU2M-00083P-M7
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 17:38:36 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76e39ec6f52so5741258b3a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 14:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755639513; x=1756244313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YqhFFupFe/EhiIkC4raXIRJoKGDUCq95ZaPZ6Db8jow=;
 b=IUSi5mye7g1w4PrpcxRAdS9UK0cfk1xJvYyVynERVFPQBT10XmvNHr1cV0Lig89y30
 KIJkxJgGg4eF4ocvonTq8OSSCehyQKqY3TXNEYAAHoDUnEmkoIDGha6UjvDpyQmOHBMA
 vBz/+y9oIQJnp7W1e2PJ4mN21dKoTlB1l/pWGUNAhUZ7C8EpjymP0TUCHBQGMgwXsdHQ
 23yDnfDmgDVNcl0bdVkz0YnSp1l6ITNrqE3BWOUT3M75bEt6p0mqnYVaixHQfLLWgDZ/
 e2+Zk0qArP/FE45DxeY5BMUYtR5AyCnMZkRRpC/AV7IpWCUaOG5Imj0gUJCQEYoStyCE
 aHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755639513; x=1756244313;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YqhFFupFe/EhiIkC4raXIRJoKGDUCq95ZaPZ6Db8jow=;
 b=Xb3+B4RPCDDw96CQ1DfUrg/1q6Z1nAq85bJs6qzqT0RxDxoFQI5T4pEBrA54GU/zS+
 NbtvVApJuOShmg32A7Wp44XzwtARYwiYwxD/liP5lYD2CDDnta9x6kdso2T1Qp1cknuD
 3QfwyWDT9H9LyyvrZxI8VvF3bErVSqSz2HXtKBsvaNgNadvp8MqDCXi6ROl0bVsJQGdx
 GRkdDYEAVbT515yBD7Y450XkhssgyMOGUH60XFld9SoTZmYmJa5rXYgUVETN49ufUdQp
 gl/p2Gz912uCsPXz6660VNY509mtk7oGsYSd6pYrS+nZg34fbfEc040/UmdtUgwdyaZo
 7FBg==
X-Gm-Message-State: AOJu0YygN3fNo9FrLrSVr20qQONtmdlD/KkFwIjsLIXDmTZ3A92hA5l/
 idd+VC5ZggaI7xlfpDTgwJA7HEVguI8UFpZRLFSWX0fQBMntKLhTIuRefxjsdWUdwJzWrF1lsB9
 bvDb6gbM=
X-Gm-Gg: ASbGncul8KjxsgquxblfNznTflFSMtyJa8G8DE5zXEt/Y+flFRLX4p92YnS81Jr9O82
 kl5UCm8EqqVDURR5zBBZsVBlgnJM51TrdDZHVn7VdpujwPDjThUNX9OkALOwTHKm1CE0LqxDymE
 KrYDcd+cCxLNlWS1JYOWhrLJKMZjF4Wk2bulz9XgmEOSAdztwb72oD/MFv6z4Ks7P6ihGQFTx8+
 hBEubp5siP8QNkYUYxfEWzI54UviXQoiZHforQo4ccPowrj0siI8nZcW0UnxOE4yTM/+eM7/+9P
 PWXzKGj/RuyI6LGCVgub3P7244y2WApwUv5sYTMCYC6oSkU0QgC4MDVvIA/jJwOT6rlEMK+3WoB
 pYNLsHiT6ZlzB7XH0FPF1T/DNcSWZ+ikCrWKQ1lXe
X-Google-Smtp-Source: AGHT+IHy9GxMWt/UnV2dT/6ZVy3I5nUk/Yn8cR6VLRdKgsG9eTQis7A3mYW4wGuTPOUnRZvQxSVIVw==
X-Received: by 2002:a05:6a20:7fa4:b0:232:6630:bca4 with SMTP id
 adf61e73a8af0-2431b89b4d6mr1129247637.15.1755639512986; 
 Tue, 19 Aug 2025 14:38:32 -0700 (PDT)
Received: from [10.225.235.227] ([120.159.20.238])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e7d4f7cdfsm3371014b3a.63.2025.08.19.14.38.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 14:38:32 -0700 (PDT)
Message-ID: <ee9886db-8d07-456e-bec2-f4bccdea3449@linaro.org>
Date: Wed, 20 Aug 2025 07:38:27 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] util: add API to fetch the current thread id
To: qemu-devel@nongnu.org
References: <20250819202708.1185594-1-berrange@redhat.com>
 <20250819202708.1185594-6-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250819202708.1185594-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 8/20/25 06:27, Daniel P. Berrangé wrote:
> +uint64_t qemu_thread_get_id(void)
> +{
> +#ifdef CONFIG_GETTID
> +    return (uint64_t)gettid();
> +#elif defined(SYS_gettid)
> +    return (uint64_t)syscall(SYS_gettid);

No cast required here; extension to uint64_t will happen automatically.

> +#else
> +    return (uint64_t)pthread_self();

Incorrect cast here: you want uintptr_t.


r~

