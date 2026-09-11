Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06261C79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 06:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4vDe-0004rt-NT; Fri, 11 Sep 2026 02:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4vDZ-0004rZ-Jq
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 02:58:38 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4vDV-0003aD-O6
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 02:58:37 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-853f8c34ba4so722625b3a.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 23:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789109901; x=1789714701; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QeLTQVQeTEdSXgCqiJKGDVVrRiQG2d1wUOpne7KW/VI=;
 b=qqo+8ffJZThDRpxxfjNkeYitlH1GXBG1FlaFLyUAwnUX9N4kzCz8WYCXynJHBBSV4E
 SjyXFoVvKM1ml1ENGAKfIyUXN8SgFdrLQt18V1xBiP9veQXD+K9wHaAI9s02sIaXIjKv
 gEu325AfppO26WN8i86DWPKuW05Ot5rqLjaLSZNckbUuJt3PG1bhw/1mMPXrvYaz+0YH
 vUcSEem4pmElcfbTM2HvTpEoylPe2bF82vEQ5wB06BS5xW+NguZQvVGz/+CX+bH3kwvt
 hATXulWtpm1zUKvScFOF7R2DiDSM+4CMD76/I/hCG1BrNh9bgLqGkc+cmSZuGgql9qzG
 oXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789109901; x=1789714701;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QeLTQVQeTEdSXgCqiJKGDVVrRiQG2d1wUOpne7KW/VI=;
 b=gN5VZxRAgluryGh5zMWtLMsovfgb/tWR81JPloLCUvHMijpkcuxiWO7MvYyjbNzU6Q
 KVEwl87WxxlmELQDtbgTns/wBlvRKyAKFoCINbpCCy+CxNj1NBe0vh+h87F5mP7aILTQ
 yTRn1qtpKmYbuQkehSugQsSfze7YazBBoOEL8lmJ49FZFEvZduIgcD+1Hkl/64uCyUMx
 9R+/HlWwXwaZzrQhdC8vssAysm7T5tcWOfg48rMScdkViRpjIcr0CAMi/WVGzMLHUYsY
 Y2i4clWfEVjKgXy1im74a7FbH6Eu7eDRlEwd8quf89Nj8ySp4MAzrq3T5xbFuGEbAMR0
 g0lw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXUH8gVjavS1XhRD6EvfxXdP00PDoDg4EqGNYIz9/d9yLT0oamIjY00fMkZwN56PwVnPogRrToPcP6@nongnu.org
X-Gm-Message-State: AFuF++mU4C6KOxNwOF6smvS9zcMSejgC+JT8u0M94sNgzgPgukXHxY/P
 AND4wDCmXJzk3T+KAq4teupDrq4iKBnlu8mTfFzM4yGDsiAbagLuJ3gF/hZ9mFOSsvQ=
X-Gm-Gg: AYBFou19Z1aBUyGvkQcT1By3Mf7yozVnHodTnJyu1IeGW6+AN4eLpztjZf+AKXQECtm
 l/U87zhd/cKs2r88S9CmDlZfOaPkx3jwX2dtWwYf4SF1K3OUHx5HoG4haVQfX+DdD8XzdnhkXlh
 LXH6k9mvbuyHmqrTPsYCklBdpklRxDJnLXypo/i54J63g8hZaFFvjCjytLZYE1463AoDmdMPCu1
 YjvM9mthUXYHiKQTtwBwPlvtUdULCfcIoqCfFoW4CbZCZaLCisBoj4aWGKomH0wyXi/EIMISmBi
 qc5FpE51K/KIAxIDiIDHSwAmppSa8Agas2p5XEC1sGXiCFKc5Kh3OaGpSJZYcxFflbaIZXSB9St
 VKnDfr7nlqHREWp+5mEpyIjQOqEKe+czYTXaxz6IhF8R1s9/lh98PAdzeW73LpidNP5ZDcIKwTl
 0nYzyWofBQgBGEqfvjImdWsrDNoMRv7rNYOaj8QPPrblSE0+utHRkxrXpLzMhFi5tsL6rxS2EvL
 x1Yho1VmkEF9ahQMNp9D5whVvg729+CZd06suKdx90S36XGOc9XPHR5GH0=
X-Received: by 2002:a05:6a20:9f95:b0:3c4:1916:9d40 with SMTP id
 adf61e73a8af0-3daed5cffe2mr5260256637.12.1789109900491; 
 Thu, 10 Sep 2026 23:58:20 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:20b:7d3e:6a30:1f63?
 ([2603:800c:7900:ed00:20b:7d3e:6a30:1f63])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365ba729dsm5671449c88.14.2026.09.10.23.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 23:58:19 -0700 (PDT)
Message-ID: <c71d8539-92e1-4a30-b705-468e653ccc0d@linaro.org>
Date: Thu, 10 Sep 2026 20:58:16 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL v2 00/24] Various virtio-gpu/dmabuf related fixes
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
 <20260910-virtio-gpu-cleanup-v2-0-82555d04f70c@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910-virtio-gpu-cleanup-v2-0-82555d04f70c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 9/10/26 06:02, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau<marcandre.lureau@redhat.com>
> 
> The following changes since commit 257bf4f160c50ca8c4ebd603f519f5c786013fb7:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2026-09-10 11:08:04 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git tags/virtio-gpu-pr-v2
> 
> for you to fetch changes up to d6e516555805b95a7a935c3fd74568dabf7796f2:
> 
>    contrib/vhost-user-gpu: disable scanouts on resource unref (2026-09-10 19:59:43 +0400)
> 
> ----------------------------------------------------------------
> Various virtio-gpu/dmabuf related fixes
> 
> While working on CVE-2026-66020 (which had a few revision on list), I
> kept finding several places where virtio-gpu scanout and dmabuf
> ownership was unclear.
> 
> The CVE comes from using a blob after RESOURCE_DETACH_BACKING has
> unmapped its memory. Following that path also found stale dmabuf
> references, duplicated scanout bookkeeping, and inconsistent cleanup
> between display backends.
> 
> Those changes touch a lot of area and I have done basic testing with the
> various backends. I would not recommend backporting them all to stable.
> The first 2 patches address CVE-2026-66020 in the general case and
> should be safe to backport.

Applied, thanks.

r~

