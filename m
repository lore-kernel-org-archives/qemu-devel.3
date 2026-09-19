Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CFEC982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 00:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ivE-0002jy-9R; Fri, 18 Sep 2026 20:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7ivC-0002jK-7j
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 20:27:14 -0400
Received: from mail-pj2-x16.google.com ([2607:f8b0:4864:39::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7ivA-0004QJ-Mj
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 20:27:13 -0400
Received: by mail-pj2-x16.google.com with SMTP id
 d9443c01a7336-2db22383fe8so8773565ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 17:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789777631; x=1790382431; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=em3jlffynbXq0tsb4sLCR1/3Cw84BBwzo+pOmPqzxyk=;
 b=NaD6bqPwAynYVXa6rBFq3Nf6P+XS3vXWuqnEtne/yLDXybCT9C2JyUzgf94AzxSR8R
 IVQLvx5FRpkEantyR3gNMjD3zxysC9DrAMcLy7neraEpoh6vB8EFVEnK+6c4CgwMCI4Q
 b/xIXlEGbrI0negKIMnxS3sLerZMMufuoDt4zpGNZ5tLPc0G2FVIz1EhLchju6YB1q7x
 r5AQQLU/fZFNE6d1q162LU4okhl8I4dLnFMpuJKnn66etLmx5EWdo7bvfrfP/2MXy1xF
 T8C0VcLuPgUkuGh48IeExVh03iKnXO9+nJUqjR37N6JUmsbgGLHn5HBEdFhBHjknJbPs
 7vXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789777631; x=1790382431;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=em3jlffynbXq0tsb4sLCR1/3Cw84BBwzo+pOmPqzxyk=;
 b=Tg3Luc4iE28Q8mbA3w97TJvEIVy84QfosSE7KFNav+YNx/clD/m9pPN0LfsTqtrGYl
 ot9LidyThVZhAZ3KEk3IpWgCebag3Yp7R3q7VM2k9Db3Zhc5Y/lSiwXXg4f5+B2fuCD4
 6bK+eHBpYFnYXFnZgjqMt7CJjdo/y3NCi+Ad0AW8VDCH59H5G63DeHTRDzSdEXXDkl3R
 BihhO2Ph3USfbK2vh+KGGArZ+5dx+kiTxXWD5GnoQYwguFD2xRVBcp3ikwGxHUNcXrd+
 BKTuixOe+qvqO55yRmPEMGfUi5z3U5BO8n4qE1LqZi9dTE7JJDenDqHNjL0kFNTAMRHE
 YScQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByxzKvvpYweD3sZxsX4a8Uh/8kbvFYG3kcyEKtWlQXoxmlzccNJUcsAPL/JQKOUotb+GvomjL92geVX@nongnu.org
X-Gm-Message-State: AFuF++lAHazG3hcCjV+ODVtRe21Zdn8A9Zj3ymsUf2Dg/wpT5eCM6Bvk
 RKMTwc15oRNvpvgUel16Zjttm5M4oqzanVTPys54Gg/I0nepMNrtsH/nhcoYu928TyQ=
X-Gm-Gg: AYBFou1gtQHC6sWMuDxCo5G4pBTCfadfg7RwB4XRrCnzmRRreda0d7PDhPgljGCrGs8
 FHcBGdg7+ntq4Qv1axACYHcE8Nt4TkZasYUrGaD96O9PZ/BsahlRaLmNvmyhVdZ26RxOWh6CxHr
 J9MjLLw3Swn03Y1Hjb77vk4jum80oyDVGsK6oHbDUKSUjJeu2AQhnIYOURPlu1t6RLZgblVPXpf
 eWhXUHq44dP1qqrcnRG8b+GbBZNuTKYeDgJAeoIyRVQXi3ML+CK2VbLd/wWBCY4DCO7v5+aFsx9
 8LL2q15lY59TwUR9p0Fsdl0uRp2SeQhyGWR/IgIuSZyZN2m/xJKdH+Q6H65V+C8+Hw1k2+RJMtA
 PPVOTqUuM+zxDI3Ki01jvYbhdiNl+mzzMbxVDzXTJvtlRw2iCD6fl5XT2py/NZJGKWH+VpTYpNw
 1E3f1jjUYMJuwSR1gAliYh/yJtE3K4xjW1Ywn+7sZKz/wrXvOXyxX2NSd1rZmbP85MNwzX9WIOK
 nsm4fLRWa0K8YQryZMKaf8jRBlxaiCdlbtOQlH06eoRfczcao04fBgvNV33nQ==
X-Received: by 2002:a17:90b:4a03:b0:36d:9e0b:3801 with SMTP id
 98e67ed59e1d1-39e54d38c48mr13143859a91.8.1789777631094; 
 Fri, 18 Sep 2026 17:27:11 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:fc68:7352:7265:5984?
 ([2603:800c:7900:ed00:fc68:7352:7265:5984])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d55cef9bsm1787810c88.10.2026.09.18.17.27.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 17:27:10 -0700 (PDT)
Message-ID: <49ddacee-21ab-4ebd-ae87-991dc0732270@linaro.org>
Date: Fri, 18 Sep 2026 14:27:07 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/11] Next patches
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260918113926.831204-1-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260918113926.831204-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::16;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x16.google.com
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

On 9/18/26 01:39, Peter Xu wrote:
> The following changes since commit f8296b816fabd370307cd22b0270b610fc0fa279:
> 
>    Merge tag 'pull-loongarch-20260917' ofhttps://github.com/bibo-mao/qemu into staging (2026-09-16 18:24:08 -1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/peterx/qemu.git tags/next-pull-request
> 
> for you to fetch changes up to 666dd3c9b10a70eea4aae3c09b0f945175a7cb8e:
> 
>    system/ram-discard-manager: fix offset_within_address_space in replay_by_populated_state() (2026-09-18 07:36:52 -0400)
> 
> ----------------------------------------------------------------
> Mem api pull
> 
> - Peter's patchset to drop some dead code for 32bit hosts
> - Phil/Bin's patch to enhance error message for mem allocations
> - Cam's fix to virtio-mem crash in multi-source work

Applied, thanks.

r~

