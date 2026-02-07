Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844D4EE0ADC
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 13:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voic9-0001uM-LJ; Sat, 07 Feb 2026 08:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1voic7-0001u5-UT
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:44:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1voic5-0002re-Uo
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770471879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vjrEcJDFpzCCyKjfoqKxPFoUaUMGNJgCr8Mblqh3jPI=;
 b=ac8gv+AP7MLmNx1r3Yjo/wfWTbuPQ6rVhIXY7x9sk1g2sbwxX1ifKPYCLp0lhx5mejEkKd
 26sIZdZspP/EJmfrkVMel/ygqzyQcDL3va52vAtMR/rSTXY1aiVcUNfEC6607l5OlEQHe6
 pFSz+S5rGeuWWjAvqbdFHwxXKG99Bko=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-wLccLLEQNsm7XnL-eWKvnA-1; Sat, 07 Feb 2026 08:44:38 -0500
X-MC-Unique: wLccLLEQNsm7XnL-eWKvnA-1
X-Mimecast-MFC-AGG-ID: wLccLLEQNsm7XnL-eWKvnA_1770471877
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4806fa4a180so15022395e9.2
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 05:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770471877; x=1771076677; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vjrEcJDFpzCCyKjfoqKxPFoUaUMGNJgCr8Mblqh3jPI=;
 b=oQLZLcFTEiqXtIxyfJGO2io/JwRQXv+PqV0rNfFl7QynFimmKYV1k22DdDYfcVkIjS
 842/SJ7mSHhSSFRBghCy5BnFP/JPQHmg6bz3TFGb8j5b7G851V1D/6Clniq0CiMUDFAb
 W27M/hgv+KDwPE0OMORhH/CxIayknx6PQbg51lGI+wkEAvL827iJwpzpysLR1NjqOGS6
 IB1LCe5LOzGW5WjPNM6m4EVyKeTvP+4Ag5AB6f/RgmUzXx1HjltonLqRZyupIY520Bk5
 51D+X2AnrrhZtJgiv46jwX9gZKQcooKsDD5yOPsUe0GJmS4lvqceAeedb+H3+JIT/wqQ
 8R6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770471877; x=1771076677;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vjrEcJDFpzCCyKjfoqKxPFoUaUMGNJgCr8Mblqh3jPI=;
 b=o77Q+GrRcA4Wr8kT0q2/DQqoipXAfnvKcJEFNZ6ZtsPyKgXhEGnY/PqXtzvLAu8U9J
 wYXxE7ZKajWtqdfeIjF6LUSNh2y7j0zgsGSFiXs9MaQcfR8gCzwTby9FdroY5SGMOhL3
 wkq1E6NMr7PrheDNlM/UiiTe3FEY3KEZXdPZAmseLpci0BjOANgg4vpDL7X6BWzkuILn
 wBaj9TXzc7clvdYhZLmbjVwcb1IvvUlGYL6bgWMgotLNNvksvzxpFLMHXHJ9Az+KGKpp
 SG81rA4vVzkonwygEdlrMso8Qk98B8MvHyvcy1jxu4ox+t16dU/jFQDgmkEWfFxrt5Bn
 m69Q==
X-Gm-Message-State: AOJu0YwPmohdGpOhbnpT4DH+9uJNZJ0zKdr3IJglr918kQ20tGEMxXy8
 EH+AYQL0Y76D7TRsSu4af03gCIrOjkX+NR/UC85/pv1SvPlfh7Q0NEnknsPI4KKOglYoedtaizI
 pNiQHI3jXHTvR1Q3nA6BzLLacAaOPagVFAcoSO6wO7BmKeXfH1Kpu7rS8pv2VT0Gr
X-Gm-Gg: AZuq6aJ93VJyQJUWRxEAsDcSSaD8wGFuVZUHClZ/vd/yPbick4yLxTyEOv1A++DE2U6
 0PBEQcCEujwxLqLpHnsfuDZThGAzkMh5zVugYnYtR9eCV2FXCNs9mfkWx1WItVTbLsCeRTSi/JV
 pzZrYljjlFuqjdSnYIypv2iyHAMtIbayxFs/dFmdk/JAjvK4TdFGx7f2K94G1AGx8eU67/2vO9O
 u8Z5PES7y3/MRACKKgsiye7w0wJbZ7cC3wNhe/5nU7snnSIa/qHqkFV1bn6kTITXFQfGPj32003
 GebyTdvpc7iitHZq1EVdk+uTlgeLNN/pKS1TANL+h7c3gsOArmL0VIhDmbfP9JIYA5Cn+OHtEkK
 y4k6XjT58FlbF9VFQjOn+ZKvolD6j793eQMHMPRot4Yf7b6v60/qhl7AdRgc/EKwIWs+OtyaFr0
 y6lRNCCnQ3usNtHtoagG/FZ+w7WBOHZIVv9iF2wHvNBA==
X-Received: by 2002:a05:600c:458c:b0:477:b734:8c41 with SMTP id
 5b1f17b1804b1-483201da2e1mr82294985e9.1.1770471876700; 
 Sat, 07 Feb 2026 05:44:36 -0800 (PST)
X-Received: by 2002:a05:600c:458c:b0:477:b734:8c41 with SMTP id
 5b1f17b1804b1-483201da2e1mr82294825e9.1.1770471876251; 
 Sat, 07 Feb 2026 05:44:36 -0800 (PST)
Received: from [10.58.49.123] (93-44-32-35.ip95.fastwebnet.it. [93.44.32.35])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-48320728774sm110076595e9.14.2026.02.07.05.44.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Feb 2026 05:44:35 -0800 (PST)
Message-ID: <b3632083-f8ff-4127-a488-05a2c7acf1ad@redhat.com>
Date: Sat, 7 Feb 2026 14:44:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] target/i386: Fix FEAT_C000_0001_EDX comment in
 Yongfeng model
To: Ewan Hai <ewanhai-oc@zhaoxin.com>, zhao1.liu@intel.com
Cc: qemu-devel@nongnu.org, ewanhai@zhaoxin.com, cobechen@zhaoxin.com
References: <20260109021028.83985-1-ewanhai-oc@zhaoxin.com>
 <20260109021028.83985-4-ewanhai-oc@zhaoxin.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260109021028.83985-4-ewanhai-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/9/26 03:10, Ewan Hai wrote:
> Update the comment for FEAT_C000_0001_EDX in YongFeng CPU model to
> accurately list the missing features instead of the generic TODO message.
> 
> As background, current Zhaoxin CPUs implement several CPUID.(EAX=0xC0000001,
> ECX=0):EDX feature bits that are not yet defined in the Linux kernel, for
> example SM2/SM2_EN, SM3/SM4 and their enable bits, PARALLAX/PARALLAX_EN,
> TM3/TM3_EN, RNG2/RNG2_EN, PHE2/PHE2_EN, and RSA/RSA_EN.
> 
> We previously tried to upstream all these extra feature bits in one patch
> (https://lore.kernel.org/all/20230414095334.8743-1-TonyWWang-oc@zhaoxin.com/),
> but the maintainer rejected it because there was no in-tree code using these
> features yet. So our current plan is to add the CPUID bits together with real
> kernel users step by step, Once full or partial in-tree implementations of
> these features are merged, we will update these definitions accordingly and
> potentially introduce corresponding support in QEMU.

KVM now has a mechanism for introducing feature bits separately from the 
kernel.  Feel free to resumit using that mechanism, then we can include 
them from the beginning in Shinjidadao.

Thanks,

Paolo
> 
> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> ---
>   target/i386/cpu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 34e3e66344..10603eeb31 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6958,8 +6958,8 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>               CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM,
>           .features[FEAT_8000_0007_EDX] = CPUID_APM_INVTSC,
>           /*
> -         * TODO: When the Linux kernel introduces other existing definitions
> -         * for this leaf, remember to update the definitions here.
> +         * missing: SM2/SM2_EN, CCS/CCS_EN, PARALLAX/PARALLAX_EN,
> +         * TM3/TM3_EN, RNG2/RNG2_EN, PHE2/PHE2_EN, RSA/RSA_EN
>            */
>           .features[FEAT_C000_0001_EDX] =
>               CPUID_C000_0001_EDX_PMM_EN | CPUID_C000_0001_EDX_PMM |


