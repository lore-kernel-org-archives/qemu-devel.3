Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58738CCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 08:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIj8Y-0005zH-Ni; Mon, 19 Oct 2026 04:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xIj8X-0005xw-26
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 04:54:29 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xIj8T-0008RA-Dq
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 04:54:27 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so1381455f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 01:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792400064; x=1793004864; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8/dHi80RO8nWesmfOqifptWpnAkwSptTtRbtE44JYkA=;
 b=R2SvNIpsUFaRotShXelDKwhxMIi/TYGxg6NXTxuZbQz8OmgT1tQTvHf/0Dnzjkt29r
 SuhJI9mVKOz4kqWekntS41H8bX0AsH3jhyFRyjwVeeJz2Wmxe6qOTmBrFAnhIRTumCzW
 IJQjVzDUR2vib7nXmd6iMzl/Kaxweg3nfe4vgTsfNhwkEm2YFLWFUP5pC0zYSKf7mGYj
 zGzjGrf6SFmrXaptzlh6PNlFEmf/xhD/VmRYMEQwLG65Ix/yqswepFiVWnk9+Onh5pX0
 23Y2y8WiiiYl92DHXuUIcbZ2ZoORrUMc7tD2/6IFQK+vFNE70+wu8Bb9JAjp4xT9+IM8
 PdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400064; x=1793004864;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8/dHi80RO8nWesmfOqifptWpnAkwSptTtRbtE44JYkA=;
 b=LZ1JkLa5+FMVEsvvloMwrSqxd9uBljGnGGJd1XdfOJVDAiT1oyp6bIoezBagMWDT3G
 CN5eq2Mvaxm0u5EGq5X2y/BHdA0uVlJr9AkWdcIRUd9GEJP4KDFn9sbi6eZSAX4KjMA4
 O85Z2tMyl1ni19OPjVpcc5ZpI5plObLUMzUuNk6CznBGkHWzpPEnIVdZ7jrjcF6UPsjm
 QqeHV4Kt4uaPPZ+H1iwmOD4Y8jqzBT2gpqP1apywJg/X22dDqWYupi+zRi0CZwv2Bm4y
 qkhV4mgNawzAR3QdG2oeLfZlX8lea2aT0KquY1pz+t0mtR8z8So0s5Sv4WqHxVUOjfec
 qc1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4EmNK0xxx12xb0BRfg6IIwCUe3f9mC4bDhS9o+16MG4E31B4xNGT0drxPa2DkBABpCMQxuYd0bt0f@nongnu.org
X-Gm-Message-State: AFq9FYLP8doMVwm+DiLlPhyWdKyIUnJar8SJOfpNG7P0A6GXOgRFh65V
 /YfvICUuN3AzH92BibzaKu+8dJEIkvFVcctJkJHEc+BRHmiFvatjeocHfR2lbppsjRM=
X-Gm-Gg: AYBFou3Gwt51JboezL4e5t70N5ARDGAgwe7OepgYlrtUD1vbEAnpyts6yFXVINGeXd9
 kTWUkJQZ+2nMjlBut2tUqdrhHc//UrmbEf3wrwrkZVOqcPuTxVUB4/ZqkJm/1w9hfoeajCGNBXt
 tbTKxgIYxZRXRGJz3ZSPdLAzuf2MMTxyinWUdHyIbRoTS6CF4/qjlxEvKsR5Azs/BetDqKsHws5
 HOW3erkxEuhJTD2bC3NuCMo7ZvBoZsoyYnJESE62jxcDFhpDAG3wU2LeDf2VvbusFOMOpb2DIa9
 Yr+dMONE7aHPZa8s7N6jZK597Hbx3dUD8vjFuqD+291SG3bQ290agtFo0WkewDH3uK0PTFvp+Zs
 VwWP28lvUOaak/MLDRP6ar4oMZPGzEIikuIJ16iozpKHRbhpSqyNAVl2jiP4wgTp4buToks+OfV
 jNeCOVyqsTBIL3uuctOwgQjxArAn4Mr3scbUTPS87zYZu+i9kjgxCpd+AdE7IUQDcD7qNqPtofj
 qXcBydVmEt74PezB1abRLTwGRWagHXUcSVamrby+6tCt/bYmlfRfmiPITEyRQ==
X-Received: by 2002:a05:6000:2905:b0:48e:f8d:8cab with SMTP id
 ffacd0b85a97d-48e1afe357amr92415f8f.4.1792400063776; 
 Mon, 19 Oct 2026 01:54:23 -0700 (PDT)
Received: from [10.89.180.227] (cust-east-par-46-193-64-64.cust.wifirst.net.
 [46.193.64.64]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471a35sm18708554f8f.7.2026.10.19.01.54.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 01:54:23 -0700 (PDT)
Message-ID: <e4e79dc9-18e1-4f5e-baef-fdc29b1884ef@linaro.org>
Date: Mon, 19 Oct 2026 10:54:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] tcg tests 20261017
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20261017174105.25814-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261017174105.25814-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

On 10/17/26 19:41, Pierrick Bouvier wrote:
> The following changes since commit a19f59a72d96056d9a8f48cf6c77f5787491e414:
> 
>    Merge tag 'pull-hex-20261015' ofhttps://github.com/qualcomm/qemu into staging (2026-10-16 07:50:02 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg_tests-20261017
> 
> for you to fetch changes up to e77a38d8944cafd7285b9f7caa4771e89027dd1c:
> 
>    tcg/tests: add an alias for all TCG tests of a target (2026-10-17 17:40:25 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH] tests/tcg: match custom target name to executable name (Paolo Bonzini<pbonzini@redhat.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261017074226.1347492-1- 
> pbonzini@redhat.com
> - [PATCH] tcg/tests: add an alias for all TCG tests of a target (Paolo Bonzini<pbonzini@redhat.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261017073952.1346449-1- 
> pbonzini@redhat.com

Applied, thanks.

r~

