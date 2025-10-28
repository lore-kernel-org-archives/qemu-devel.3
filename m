Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFC7CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhPe-0006IG-B1; Tue, 28 Oct 2025 06:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDhPU-0006HS-PL
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDhPQ-0007CU-QW
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761649113;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=prRvxur3E09D3IkNRG6V84C1UldRa36MdV8O+6OSW04=;
 b=fbtzMkicmb69JgiPbmedCziUvUNkPI3S5Aku8T/JpSMnEjYTlJ2g2gbd0KYUrnHdq+B70F
 udE2zMmpKYx1DV9WWlU2ibQS+sDtJcZnp2nvG1YmVsr/MqJBndJre6de1XGM5Y89r5TdUU
 EbOEOjnn1OMaE0TFfQ04ap9vMXrJ9zk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-KmKlvXJaMPGr7Fy-OR8phA-1; Tue, 28 Oct 2025 06:58:32 -0400
X-MC-Unique: KmKlvXJaMPGr7Fy-OR8phA-1
X-Mimecast-MFC-AGG-ID: KmKlvXJaMPGr7Fy-OR8phA_1761649111
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-40fd1b17d2bso3638473f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 03:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761649110; x=1762253910;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=prRvxur3E09D3IkNRG6V84C1UldRa36MdV8O+6OSW04=;
 b=qRFvNLzsL2YcawTSAHe29JIB+d3WRUsE3a13EeC4uFjWyfvrRpDEwsRGTMguSEgo0j
 s0YBJaQ7sZyt6hd5xj8Y/CHO+1ge4p+oQhNw1U+OrFfGAmvVendXfe3WfTADPhsCuasc
 a11p62dCHyCyUYl42oi6HxR4pyt8oeOqHCLSyvDny2xc1/4YdaG79Oxg9CsRsJv8cp6j
 9UzA9soZgyETxYUpBUM7rV/KMAJVHUEZvaLyAnX6r/woeCpYn9wVEnht185cK6oUa0iS
 G2kYBQtomSSSZHe8RjjO676BNjYJl3xbU+sIboXw8XhvUJZWZs4SAJkHLZC9YkzlRq2Y
 jiPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIam6lCiHtPNmQ6+KtYrCFmAL8vyTGn2YBIx1adLDlcsD3YdXGmSbJU+PeM9zSAsTwHrj30Bg4p4ih@nongnu.org
X-Gm-Message-State: AOJu0YyJNHl1qj5cJBoVUZEjpmOP6Sexj3Veg4nL93BzQJLBErhYM5dI
 lueP6beKIIrKKJVraV4DP82K36S4Oz3vIwXkSKJOvKovpWpxaE/Z7rHyAZEkZ4XGMXu4zTu1htZ
 6hPRYYagkkSnLPOMtBdyPgVrhMF4989nCl2qy1WUptAx+vSX9h8dQ7oAvljmj4TAd
X-Gm-Gg: ASbGncs9Qf1uLxERqCCGNauvzApVSASB38q4AEI8wdqH6TMmU2dlwr64RD21M7fjJoD
 fe0r7Z1E3QHJUfXZlr1YUPH1/51AoHdS7AvdFbyRxyAhTKO8l9AJOZSNZs8GdU3gMot1XxGqSOM
 H2VHUG7Vq6b3XQTTLjcCIVwaNXJdcingEXuqNqM18b3zwDAhgWMuwXPVOHlpSkA5PbzacuFBQCK
 QjTHjpskPFca04hAZ+C7KmI/WZ7SiBFSLXSM2l7+3nWN+9MwjgqDDc4f3ViKkYsx+MaU9ECn4DX
 NIOblHs3rhhbv350KT9hYiuT46jaSfbPOYbtll5iB+9Ra2Dzf/Wou9q4PisLv3XytllGz0WOIoe
 ulwhQtFU4008+aroKSC4BziQO4JxE2AbCuTum9dTtpgRgfA==
X-Received: by 2002:a05:6000:1862:b0:426:fec1:a58e with SMTP id
 ffacd0b85a97d-429a7e7e29cmr2915648f8f.53.1761649110295; 
 Tue, 28 Oct 2025 03:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp9rVNkQq6idh2RrGzpwdv2s8cE6DDoLxXmMMG8w+B4E/MdwFmM2cx1whPMyJ+wD1m7USDNg==
X-Received: by 2002:a05:6000:1862:b0:426:fec1:a58e with SMTP id
 ffacd0b85a97d-429a7e7e29cmr2915615f8f.53.1761649109848; 
 Tue, 28 Oct 2025 03:58:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cbc16sm19084918f8f.15.2025.10.28.03.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 03:58:29 -0700 (PDT)
Message-ID: <628c0b08-dd53-475b-be43-fa5085a32cda@redhat.com>
Date: Tue, 28 Oct 2025 11:58:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 3/7] target/arm/kvm: Introduce the concept of
 enforced/fake registers
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 cohuck@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com,
 philmd@linaro.org, pbonzini@redhat.com
References: <20251016140039.250111-1-eric.auger@redhat.com>
 <20251016140039.250111-4-eric.auger@redhat.com>
 <CAFEAcA8=01a34UyL6NFiiYxFP-hd5Bdi7Y0ZQqKFnO8bUX+XqQ@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA8=01a34UyL6NFiiYxFP-hd5Bdi7Y0ZQqKFnO8bUX+XqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,
On 10/28/25 11:35 AM, Peter Maydell wrote:
> On Thu, 16 Oct 2025 at 15:01, Eric Auger <eric.auger@redhat.com> wrote:
>> Newer kernels may revoke exposure of KVM regs to userspace. This can
>> happen when one notices that some registers were unconditionnally
>> exposed whether they shall be conditionnally exposed for example.
>>
>> An example of such situation is: TCR2_EL1, PIRE0_EL1,  PIR_EL1.
>> Associated kernel commits were:
>> 0fcb4eea5345  KVM: arm64: Hide TCR2_EL1 from userspace when disabled for guests
>> a68cddbe47ef  KVM: arm64: Hide S1PIE registers from userspace when disabled for guests
>>
>> Those commits were actual fixes but the cons is that is breaks forward
>> migration on some HW. Indeed when migrating from an old kernel that
>> does not feature those commits to a more recent one, destination
>> qemu detects there are more KVM regs in the input migration stream than
>> exposed by the destination host and the migration fails with:
>> "failed to load cpu:cpreg_vmstate_array_len"
>>
>> This patchs adds the capability to defined an array of enforced
>> register indexes that teaches QEMU that some registers must exist.
>> If they are not exposed by KVM qemu fakes their presence in the
>> preload phase by adjusting the size of the cpreg_vmstate arrays.
>> On postload we make sure to ignore them when analyzing potential
>> mismatch between registers. The actual cpreg array is never altered
>> meaning those registers are never accessed nor saved.
> It's not really clear to me what we mean by "faking" these
> registers. It's definitely not the case that we want QEMU
> to think these registers must exist -- they really don't,
> and for migration from a new kernel to a new kernel we
> shouldn't include these registers. We just would like to be
> able to ignore them in the input migration stream so we can
> handle the inbound migration from an older kernel.

yes maybe I should use a different terminology. Those registers are
"faked" from a migration pov only.

among the provided enforced regs, we first identify those which are not
actually exposed by KVM. For those only, which I named "fake regs", we
tag them as "they will be missing in the input mig stream but that's
expected and OK". We make sure we provision extra space for them in
cpu->cpreg_vmstate_indexes/values on preload. And in post load when we
compare the input stream indices with available inidices, if they are
identified as missing, we just ignore the error. That's it.

Hope this helps

Eric
>
> thanks
> -- PMM
>


