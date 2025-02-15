Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2127C021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 19:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjOGE-0007Xy-0I; Sat, 15 Feb 2025 14:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjOG5-0007XD-N5
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 14:55:27 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjOG3-00040l-SF
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 14:55:25 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21f78b1fb7dso53376285ad.3
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 11:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739649322; x=1740254122; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TYvOPNy3AHVGI6v9Pk1o7GCHynUoxThyleQTiXT1d94=;
 b=D7rDxYyJ9GyxbLFJnjX35i3gVbTvlU/BL4RE8MgnjEZ3gxU9EkrY2tz7u7Toe3yDQc
 3MsGyh5Tlwn9T3sf/x/rIQ34txEoaAY9wbpUkvqw+W/DRyH8gZnnpuzL+Zy++aP20LQS
 TIh370R/aDluTzq9CiZBLyM/cK58N4HRZ9fZtzG36rK7KF3J5L+B3m3VdoJz8xut37qM
 VELn6NAnrUZyGIraUl3Wmxp/rzApCUderh4M4S98u77XUEk2R+5CA0GPFM6kOj4YE1U9
 oLm4K/8v63laqTqEjUQeaB2g4GTVsf5SH8PRmFMMVt7HXc7/S38SPcRkU/jiG8PvpKYL
 T1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739649322; x=1740254122;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TYvOPNy3AHVGI6v9Pk1o7GCHynUoxThyleQTiXT1d94=;
 b=KAxEARNyCuqgZjVkPsWnQMKkl7Qo//9ZbJ3y7oKWHRS1QqSQrC7fqKCqzUKTJJclHz
 mEW698MCqY4NIz3Zxk/d3hJCpOA9fv552K65EE4EFoi71GXUTqOTGAf5h4XtawKe7+vL
 rbVf224QmJpbZ4bGSD2InL4IxDAjFUWfqObGi0DapBLKDrcpWBKLo9UYIYQgUm0DQ6yC
 rP27UWJibhY3B8IqM2MCvvZeVAlD1OknwHZdm+rg1z0oVJZaj9NiCPMLipIx+sU402BD
 2zk/OLgVpGX1XSqZM9GnEn1nswcGuQQoSBJzHpew/XfLOET2YAycoEthat1sOd+khjZB
 kviA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsn0YWKft+4ctusT/5PD+6sQvysHR4AchI0t9L5bR3QXdSH7NMxg9kxjygvBWkHMvaeqD63gxbVJx0@nongnu.org
X-Gm-Message-State: AOJu0Yx+E9iR+0Og5UaD79Hj5/JOXv+YD8dpIQ86jBGPyU8zFFBr6Dtn
 NM8lE+2Jp/KDCNZMVPBbJY8oHb4YrY1CLbyvXx84mPX7RPZ1Nt0FITTvirLsIrU=
X-Gm-Gg: ASbGncuGU4GW5oXhLgnJ+We+KIlQbWVHlWT+TGcK8tLfxw8YEwY/tPqU4D4ydI3oC6D
 v5BkA2w7iWt/6b0s5eWFc0tAq6JOTfpEB7me3+xfJdkeOYUPEoO3K+6e2xqWN86n2JIBWJgjvKl
 RNyqm96IvyhoGWW8sXi77gSWi5qZCWM6KhiX2ngOhG+PeWMiZA5m0z/DedwXr33VclwwPy1gUxq
 XsME8s7+jd/rPalig3fQ4p3v4npOe7DEDSB/LIOQ3wy9Ts6Z+bw7lIn8Kckj3YHRsrowcAza1UK
 F154IO4VJE+Hm06itDYBVgiq2MN+gU9+FybnixBN4oYOcSn4rghNu+s=
X-Google-Smtp-Source: AGHT+IFzwzSpWaf6m9K24r5Npn6uF289oZJn18U+wD95h9cuRXhPmJp/zXERAK2ekv5yMOkvQGTQJg==
X-Received: by 2002:a17:902:e80e:b0:220:e362:9b1a with SMTP id
 d9443c01a7336-221040623acmr62338805ad.25.1739649321911; 
 Sat, 15 Feb 2025 11:55:21 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d638sm47217485ad.147.2025.02.15.11.55.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2025 11:55:21 -0800 (PST)
Message-ID: <1139f48f-301b-4d85-b099-6209326973b7@linaro.org>
Date: Sat, 15 Feb 2025 11:55:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] target/sparc: Fix register selection for all F*TOx
 and FxTO* instructions
To: Mikael Szreder <git@miszr.win>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20250205090333.19626-1-git@miszr.win>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250205090333.19626-1-git@miszr.win>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 2/5/25 01:03, Mikael Szreder wrote:
> Changelog:
> v2:
> - Corrected a mistake I made in the FqTOx instruction
> - Fixed issues in the FsTOx, FxTOs, FxTOd, FxTOq instructions as well

Queued, squashing the two patches together.


r~

