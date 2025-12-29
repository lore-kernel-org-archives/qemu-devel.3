Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A65FD3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 03:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va3pZ-0007ZK-GI; Sun, 28 Dec 2025 22:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3pY-0007Wm-Fr
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:22:00 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3pV-0005gl-Ny
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:21:58 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7b8eff36e3bso13870785b3a.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 19:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766978516; x=1767583316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bwmHLfIO2O84Q1ccPOmOeFc/0ewicl65G2fakN3+NJI=;
 b=jJpKlz65swz6l+2i8wpE/9REbBDO50LKrKe36aCPr/aUUockpqfk8W6WMbYkTU59gk
 aO0xdFTviG9ucxR7Yw5jj6oF0dgt+p0zefK5XWtoyLp9rYiMqfk9Drpk7zVS/g0GtuUH
 NTOaOX//s7bwyiczNSC98LEhptgg/7Pq+IxZ+LKjr0I0lP7AfHcj4nYj9iiFVFYX+HqG
 a57wOkLsqEzmt8JP8cOWlboGOrgxsrBheorG8W3SgaEQ/1fqJRfCWv6POx8hlVJs5x9s
 iLiLDXJH0n0PODNIAPJxB946vVUV7OQqOZ+AMdwBAvVF91Eej3Mnd7L9FoXomg4NnYtH
 qOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766978516; x=1767583316;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bwmHLfIO2O84Q1ccPOmOeFc/0ewicl65G2fakN3+NJI=;
 b=L3cRHn7DlKe7hXpmBC7ZabfkzC7hqUa3EHjOnepRMCKMyOoyoN860/RTjFykeuvhud
 0uzEpkZ5m42k+inIHk9phuvKXDFSenxZGRmOQJE79HI2FPKhbUkNK60DOYBzcczB1Md5
 Ee/7EkpU+mGe8W0j3P7KbljEOSbcHaK9cORCLfhYj+pKK+N50xMGZSgVEBiRjfjmQUam
 ixvMDS+b2DctzMZYDaFQR0lpwplaYqZCnURc4+doA+UFS9mzJZzqodPxr6IwS0dBRWyH
 F1ZfAAjtw07d65zlEbIoz6olznjqhp+HssukQUwbV0jnIr5s6vVmqfluwZEWiIswk5Cs
 Yhng==
X-Gm-Message-State: AOJu0YxbhjuUMoEwyfKCgC/bKwD0TNW8OVCcGeKomlzH+FQ1bddNx8lj
 VKhPrwP4gc3JiK52LXrL05r5kjGbDAE7XskUw7S21Ek8XtCtc96t03oPy/KhHGFxaBZCnJP+m73
 4WS/V3d8=
X-Gm-Gg: AY/fxX7NhjQX4zdkCGkb12ZLBgAc8KMnNx+qOot9uqh+Jgl9/yCAXyBPvAcyoVXTI0X
 S5b4x8+keQorlNPNZcpWUdDGeRGvj3ln6inpw0orxCFSXt2IWO7ilS5d5IZ7z6IA41YGN15eK0m
 GNLMfaIBiLAr5HWu/j9cM/3G41S3EPlBA1/ArCsDYIu6RFHRDXYaDaDQPX0tRE1MHgx79MMYfmH
 MRLJ/HrF9LC/7B9oLQqjFpuZMTaJU/GUrKFVB+8+cMBHgNbXPijRt4dw5682m7F2reWHiW///Vl
 COZIvEYYdO7f2RBr/pucTO10xyc0MCrF1Y7vf3sswvGSqWwLKQJJrWw5Ax+xfllZJ9odJSwsnNv
 q1Wtuzo7dpfwbFJ2/nyzxr2PCxiYwSnJUl9YpVlS5lVjFS/cyXKHgiH9mlkM7d9VRyqZQZh9y0J
 yIv82ECH5865JB6DO39EsdHV+WEewSFzfbZN/6euT8JBsE70+RPl0NQ6soWanjk4AAYRib3Q==
X-Google-Smtp-Source: AGHT+IFRxdTNgkZ31tlJ207QzwSrysJ1qw7eVSYucGDA4zP5DXI6zW2aTUtgWVbE0sjsB0/hb/encQ==
X-Received: by 2002:a05:6a00:8017:b0:7ac:edc4:fb92 with SMTP id
 d2e1a72fcca58-7ff646f9458mr25266930b3a.11.1766978516052; 
 Sun, 28 Dec 2025 19:21:56 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e797aadsm27964958b3a.61.2025.12.28.19.21.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 19:21:55 -0800 (PST)
Message-ID: <5b110389-6afb-4376-8596-9fb3ac561b4a@linaro.org>
Date: Mon, 29 Dec 2025 14:21:51 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] system/memory: Allow restricting legacy ldst_phys()
 API usage
To: qemu-devel@nongnu.org
References: <20251224151351.86733-1-philmd@linaro.org>
 <20251224151351.86733-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224151351.86733-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 12/25/25 02:13, Philippe Mathieu-Daudé wrote:
> Commit 500131154d6 ("exec.c: Add new address_space_ld*/st*
> functions") added a new API to fix a shortcoming of the
> ld/st*_phys() API, which does blind bus access, not reporting
> failure (and it also allow to provide transaction attributes).
> 
> Later commit 42874d3a8c6 ("Switch non-CPU callers from ld/st*_phys
> to address_space_ld/st*") automatically converted the legacy uses
> to the new API, not precising transaction attributes
> (MEMTXATTRS_UNSPECIFIED) and ignoring the transation result (passing
> NULL pointer as MemTxResult).
> 
> While this is a faithful replacement, without any logical change,
> we later realized better is to not use MEMTXATTRS_UNSPECIFIED or
> NULL MemTxResult, and adapt each call site on a pair basis, looking
> at the device model datasheet to do the correct behavior (which is
> unlikely to ignore transaction failures).
> 
> Since this is quite some work, we defer that to device model
> maintainers. Meanwhile we introduce a definition, to allow a
> target which removed all legacy API call to prohibit further
> legacy API uses, named "TARGET_NOT_USING_LEGACY_LDST_PHYS_API".
> 
> Since all targets should be able to check this definition, we
> take care to not poison it.
> 
> Suggested-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/memory.h       | 2 ++
>   scripts/make-config-poison.sh | 1 +
>   2 files changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

