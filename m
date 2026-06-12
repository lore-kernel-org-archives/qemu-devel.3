Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B19BCD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXwBe-0005LR-V1; Fri, 12 Jun 2026 03:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wXwBV-0005H5-0F
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 03:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wXwBS-0006Il-SK
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 03:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781248805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HMwwgD3Y2QW5ihjJpxtmbt/g9FkYngqzy+ZuQY8Cug8=;
 b=Gs0bgZrZwvUqu69f2nCS3G+Z4LsfI0ps7bv6/VdxxkaDLgGszA10/Bdq0B+KKoRwRVZBmB
 yzwdTOnpJpmG1PgpELV6ZWnjmwpIMCUUJt3LZVv1ANAtEnV6Efe1JR6kL6HjvZkDZ5LwHG
 Orzge80Y0kLYZvPBNUOjXAhhM+12saw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-GHwkiBLBNkWtNboOjYou_g-1; Fri, 12 Jun 2026 03:20:03 -0400
X-MC-Unique: GHwkiBLBNkWtNboOjYou_g-1
X-Mimecast-MFC-AGG-ID: GHwkiBLBNkWtNboOjYou_g_1781248803
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490bae3a39bso6026135e9.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 00:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781248802; x=1781853602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HMwwgD3Y2QW5ihjJpxtmbt/g9FkYngqzy+ZuQY8Cug8=;
 b=A/DqhMIKI2meatcKB2F6on7ES471atZ121Ls7YEwBWKU+fATQEGwyc/Zxz1Ab4xXpM
 PulBY5fRlvl6SnPPDBEUATWPOWqgXVDKA9jFIPwGhKANtrRaI03G5vyKaA9NqwYiRxmT
 6Bi4tofqtWQY9XdAKZunPMqqoReJaaZbrLOVLPeHvktNqIn/R159V3jVTOx53aosY76i
 L+QF5ieUIrWxmWZ6D3XpzfFCNGlyRAmjpxhUcI88qmHK5u/LdibE4hvpg8LVQ8ojXUaH
 H8Ifklp6ZX4xazth7V4heHAbPOkGtvVmuSv8DQiBAKzcXtbcTrUFWFkMsqnbQVQvxWKC
 QPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781248802; x=1781853602;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMwwgD3Y2QW5ihjJpxtmbt/g9FkYngqzy+ZuQY8Cug8=;
 b=YuVbBxtr5ywaetkrHFSwUacTXGMDd804Gb0yrOu2C2OFCnMZ1AGWFx1gQ9xHgNx6Ir
 1SOObXtLLc5CUYmayDxGBb0boktLvFqA568lEyz1MK4ZxjECijViuzhajhjI3Xl13rwc
 XJUasOJ9UZVeouRkU/LNlQ+z/nzbEIraZV95tcGXC1gymnEduOH5pOhJswIz7jVr9JOC
 XCFkKk89JRrgGcszi7km12jG2gZvTKP9zaGJrt+XwSIO7Yv1tx1VY7pZzMOcLgZOq/A+
 z9G8uI69FbU4IlPuyCvVEm7mQnxpx+gF4wI1LnLfhF/Ra0cwm6iQJ1HOgGF3bCLtng/y
 loHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3ouPDkq/VaqAjAnDvrjtbamb/nRwmTdbPt2ntkXK6OINlbBZRQlgm9RKtmx10O/7IKA4ETKl85zt6@nongnu.org
X-Gm-Message-State: AOJu0YzWXg+6uWxuiKpG/bEBlV5X5eLgcpswOzxcZb3eDnmBGVbcOUki
 jYSBa9+wUuXI20KCkmeXKEVRmbc68ns/2pxE0emvyLnibblR05V/V1zE7nP4qKL7tby8LMYBeeP
 aErnC8Pv86hVJK1zyZPJYA0rPfm042JRioYDcDgGpApjmivPTmuA+rH3r
X-Gm-Gg: Acq92OHutuXdiomdchp2IyCVUX5e+g9Q7DfyGI69EG1S1dUPKD3+9l66xmY0Z9Fdkx4
 ykfldHiPyvrwW477jC4T1SNeapA0qL3RryZiX84dOfMUr9aSiJjFAAhkKv6Pq2LmHlBBipg2uZ0
 POj79izkZfVdeCPcXzZZX023RBhr3/gKSxK3y/hW6XhHpFZncLllcasn1fDHdZaO8u515SmKpcZ
 c1z9mE3EFDkpE2ENFi+867PQ87kiGDNjQKbKx0pgTUFgMApmXU2FFsOo8ku6xSA53IWNfbR4Ua3
 1ucxlV00Ng1bs/l1Zyy9OchgWU6DcDdHt5N81ESHWLGIwyaCX1JQe5bhCMZTY3FbPMKUW8W1NUc
 LS2V0xaleLlEUVj8Ap/+7jxbAqzGuPFSNRX4tNrAxMnIAe1+TvsGHuoMNObUU
X-Received: by 2002:a05:600c:314a:b0:490:b8c0:d470 with SMTP id
 5b1f17b1804b1-490ec504d5dmr17290605e9.19.1781248802462; 
 Fri, 12 Jun 2026 00:20:02 -0700 (PDT)
X-Received: by 2002:a05:600c:314a:b0:490:b8c0:d470 with SMTP id
 5b1f17b1804b1-490ec504d5dmr17290015e9.19.1781248801990; 
 Fri, 12 Jun 2026 00:20:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4b2e8esm33863255e9.0.2026.06.12.00.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 00:20:01 -0700 (PDT)
Message-ID: <04f37dbe-20e5-4be5-82d2-703cd4a9fee5@redhat.com>
Date: Fri, 12 Jun 2026 09:19:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ppc/pnv: Replace Power8E with Power11 for 'none'
 machine test
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Miles Glenn <milesg@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
 <20260610090800.3672832-2-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260610090800.3672832-2-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/10/26 11:07, Aditya Gupta via Devel wrote:
> Power8E and Power8NVL were deprecated since QEMU 10.1, with
> commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
> 
> As Power8E chip is removed in future commits, remove the use of Power8E
> chip for use with the none machine test, and replace with Power11 for
> ppc64 test coverage for the test

yes It's better to be in sync with the default pnv and spapr cpus. power8e
was hardly never used even in 2016.

C.

> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   tests/qtest/machine-none-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
> index bafd7d660ec7..3205df190f35 100644
> --- a/tests/qtest/machine-none-test.c
> +++ b/tests/qtest/machine-none-test.c
> @@ -38,7 +38,7 @@ static struct arch2cpu cpus_map[] = {
>       { "mips64el", "I6500" },
>       { "or1k", "or1200" },
>       { "ppc", "604" },
> -    { "ppc64", "power8e_v2.1" },
> +    { "ppc64", "power11_v2.0" },
>       { "s390x", "qemu" },
>       { "sh4", "sh7750r" },
>       { "sh4eb", "sh7751r" },


