Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5844FCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 09:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAm6z-0006Fa-1u; Mon, 20 Oct 2025 05:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAm6m-0006EJ-Hh
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:23:17 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAm6j-0006o9-Uj
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:23:16 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so2293711f8f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760952192; x=1761556992; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BE0R9EVQJAztMsG2wgbqSHdCis6S2l/YOu3o+hecgZo=;
 b=qJbV8e70VEQ35Pg2+4XTJCXkEzYtBze7yEl8KEHzUCyyF6ErMzMXyp96EFOFl4PE/y
 WnNZJWh2/yFRGS/2L0yXTtWFQwtofQnCwgQHTIFCjqr7aS6vrl6wb9FBjtid0bODUxG0
 Iwgq2p6jyfkvjF9jcW+6vWiXl8Tv2oj/5SA1XvRCWGmUxzSgtUntyIOhPcTt6P9H6h3H
 H2H/V4W7tWwuOgnXsVN2ccNyTXMcISBM21nqNpnEtRn5Sk5q0tzyK1sUfn1dRFlBNfP+
 IZkB4qLUmJh+ilvtwkSEQRc8bnEOQ4lVjJGyCoa4sU14C3Hqt4F+0OMIw/KkhY/kag9D
 AF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760952192; x=1761556992;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BE0R9EVQJAztMsG2wgbqSHdCis6S2l/YOu3o+hecgZo=;
 b=Ujqs/2carWndwxp1l7pN2/gd1rWgxbol3WUd2wxF1hf/3xe6a+3zrVlt2vVkMdGE1n
 mKx/DGh2KrArWfwLXOyYV7oT0xxT075oh1UWdl2tYE750PqiL2XYs2UuPATf3cHi7pWw
 IqkZfqrtvqbxFxic7Pq29+c2DvS/PoviiaqfAhiwqGWdun3atNnr2U6/XSlqJe3fnlN4
 0vqkqfUqC7U3TdChD+C3tJuHCL+a+ckA4XyWDu2g53RP4/zijPXPmzmL5ez4OFh531vB
 gzCVzheA3w5jIXmUDfeqLN8cxyjCIazhxlMu0v7bAghQyoR5RI6xlGXnfgiQ3kL6uaRT
 IO3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ/md6Klws7WkyEXpjXWRnNCzbL3yetxjP6auCBrowD6C6TbQwX9xRT1/kAd/LFX0xkpAVI1sNt1vg@nongnu.org
X-Gm-Message-State: AOJu0YyYotcZbOu0VxHOK85BeJKZgRJF9ZsesbBuh5vrNbGlPTXeb6C9
 /fPgwM5fOhzlL6wLZqnf9sBukvtmp9hmP2YpafJ82iWob+hKdbV/LgI2YkprdgdWdLw=
X-Gm-Gg: ASbGncvOkZtLGUR7nkcOlol/hY+lQjGF8cPwK2f2vGsBfcoCt72jxXJscH0aOvHGjVN
 UQOUweoVwgU6hmZsFSVH+If9DiecOz2Fl+2S3inkC1/G6AXCS3vauVGrp9VrUt2YUw+c8zoZF/H
 GiZZ6Eb/byjDz1j714DYD4gPhHGJk2E9ygfWtoztXrP5H6XcJnIyQLXN1/uFneIdo52dWhW+bfE
 TMzmD4gcYyHaQ7h25HbbTKRYiaMrB1eaKl3hDa9JAfFwqUXiKFxxtlMfvOpnaGCejY9ot78HFug
 HSWVT/2XvbTzY/fQePvxXtnGBdDObgxCq0YnQQsGdc1fuFQt5Csg7aH7nvdJgZO8GwdEA0D6jlQ
 v6bNXxmkwRcioOEV93sIpvCiEI4aoMGhMhKGTSOCW/uhqepSFPop+piGc1HGUgugWs4l1GEO/ul
 jiukFKHF6BmdqUl3axsomYZP6EPqJNXYKAmWAM2BkdjtTLReqY5w+mle+m4ttsNPTn
X-Google-Smtp-Source: AGHT+IHPBLeO67RYp3ZD+dhreblaQlQFoC4SoKeDnBlXZVpPCc78K6+Wq86JdbHoZocX7echMLhLwg==
X-Received: by 2002:a05:6000:22c6:b0:427:15:ff3b with SMTP id
 ffacd0b85a97d-42704d145d4mr8301718f8f.13.1760952192186; 
 Mon, 20 Oct 2025 02:23:12 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a9a9sm14729916f8f.29.2025.10.20.02.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 02:23:11 -0700 (PDT)
Message-ID: <07d282b9-e8f5-4886-83a2-47cb2ca7ce87@linaro.org>
Date: Mon, 20 Oct 2025 11:23:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitlab-ci: Decrease the size of the compiler cache
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251020085431.23968-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251020085431.23968-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 20/10/25 10:54, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Uploading the cache from the runner takes a long time in the MSYS2
> job, mostly due to the size of the compiler cache.
> However, looking at runs with a non-initialized cache, and by doing
> a "du -sh ." in the build directory, it seems like a build only
> takes about 236 MiB of data, so the compiler cache with 500 MiB
> certainly contains a lot of stale files. Thus decrease the size of
> the ccache to a more reasonable value to speed up the MSYS2 job in
> our CI (and add a "du -sh" at the end to have a reference for the
> required cache size in the future).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   Looking at the latest runs in the CI, our recent attempt to decrease
>   the cache size by cleaning the pacman cache did not help much:
>   https://gitlab.com/qemu-project/qemu/-/jobs/11747329283
>   ... that run contains the "pacman -Sc" command, but the "Saving cache
>   for successful job" step at the end still takes close to 20 minutes.
>   So we likely have to shrink the compiler cache, too. In this run here:
>   https://gitlab.com/thuth/qemu/-/jobs/11770708859#L1769
>   I added a "du -sh" and you can see that the build directory only
>   takes 236 MB there. So a ccache with the size of 250M should be
>   sufficient for the MSYS2 job.
> 
>   .gitlab-ci.d/windows.yml | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


