Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A762CA0ED1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 09:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umUa1-0000ve-84; Thu, 14 Aug 2025 05:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umUZx-0000vU-Fg
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 05:49:01 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umUZv-0008Hd-7D
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 05:49:01 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76e2ea94c7cso725881b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 02:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755164936; x=1755769736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UhXQ8ClAZyC6ZwPBAtm9gjqUVvPh4kKwbXv0Fn9fBm8=;
 b=cxvhg5D8WpPVGxWkJ5zU2aNkTY7yb7kTPLxCxI5Xly1JgRuqfpQ2hY4YyeSikqGdoj
 lJwGkba701zV6fc5aAelePKe7JcbGfRQiWcEafZXZKamZYrynnsHnkNIsq96G1kypxEV
 1NWsUbIpgMuIgoIKm6o0hE9/YzJFeZNN6aeOy/yyNrlI2t1mgyfhF5e9UA2F3fpScMEn
 AGuPE0mTVL+dmaQasNgq+bs5ad8diZC9gNyduC9/B/CCJaxtaX76gginQdvAGpgFTSMQ
 OSvP6EEa4YSZ/obqphTvVzseY6N/xanyqvJhX5m+mKE6F8SeyH2G10D7zJXhxbeuAzkO
 1zwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755164936; x=1755769736;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UhXQ8ClAZyC6ZwPBAtm9gjqUVvPh4kKwbXv0Fn9fBm8=;
 b=ITbPldNcmYRdzpmhbqH5lEcNlZXhknEYPLPMsxWkti1uQEB+1BDZqyYDlmgrBP7w7l
 Q9VgynTrFCSHWPL+B3EHd6yY1AA5VFaJUPclbSfZYfOUbw2QxxIVvUhIMazHzsfoc3R5
 Fni6jwhVlSQ5QcSr76FB/kYXhWfW31wWczEPBFWZez0YTGdgg+JaTUIGM8H8Ezl5kviW
 qQAfKqCkoYlrFmUd0+LUppwyJ7tU+LG0z7hS1Rqv/GfXomdLJK0rZo4fpi+0eOx2JtZZ
 IVfLRFSnFS3ANYRuSgzX9999YU1IFpB4iVOXEHOYNWLTl4XX7TCaWbkfAqlEOLZaFHrj
 7/6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeA/WRdSR5MABTWGnGgA7LLAw+4yhZ5Ja7ddDntkt67ygYw3PkZ9KBpniwtbQ7D7EbjfOIO8lOAME5@nongnu.org
X-Gm-Message-State: AOJu0YxzoMzK+HJidHFIYdYs9g0AXtcSN21+o09UfN6Z/X+QGdPis+64
 wTIcN2DStDWy7TLU/IUDKz3N9+nC1uGx4RCOlgltTEAkKtwdFulUBk1Gv3kSH2lGrak=
X-Gm-Gg: ASbGncvn5Y26WyzHIsI8kPoumh6ew0oudvEUD6UWC6T6zFcdW0crWczxUEHBnGr89zF
 2C/e/HVmltnNyYkMfW1LRJHWyV8l2MgE/6LwKHem7CMvQU069/wqXKW4iOCrB1+Cjl1tpOUvfym
 k3E6gmocI+TpQ7HPaEpX2m8uZmnJNF4XQ6X7WJ4+Fq1Ch4QInhqL2/vpy6l7BeAhnzaqEUPS9oa
 19z6rTyVj/lWgDlAhfjExfqwLnquTwnn100/JWXjVjD0o5ChLZ8nhyTIm8ZHwVXbXQ7QV765TF1
 7JQfUiqGFFLNKZlWZbk/a8BuzII9SWyTdHvb2oX6aRInCGmECSE4ovjW7oMK/1HsM+bijOvg4V7
 ZKVDMshMmt0rx/A4CQ7J1P+s2gQ1HFZl387ByewGRV3B/P0inWMWaBZIh+PCYPerxWpDVcHSlDi
 FEAA4AwNXoHKGygsRg8Fiv4sKW/aCvEJHY7fzaJ2VGZaAfwLUsQNUVTwNvH9iGLBwe
X-Google-Smtp-Source: AGHT+IHj3MwSb3JWcBhyoOovn8dGlEB/uRNYUIfQ0xd1gbq/JeWWUz0xFadXXnz/eyXHwR6A1K6geg==
X-Received: by 2002:a05:6a21:6da6:b0:240:20d:47ca with SMTP id
 adf61e73a8af0-240bd019e6cmr3470292637.10.1755164936214; 
 Thu, 14 Aug 2025 02:48:56 -0700 (PDT)
Received: from ?IPV6:2401:d006:5c08:e100:bc49:5c3a:83c2:8ce7?
 (19r3hzjy9klp0jf5b7z5.ipv6.originbroadband.com.au.
 [2401:d006:5c08:e100:bc49:5c3a:83c2:8ce7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b470fd547d0sm2562644a12.4.2025.08.14.02.48.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 02:48:55 -0700 (PDT)
Message-ID: <80d7478a-bed3-4e6f-9241-2c4b54c62929@linaro.org>
Date: Thu, 14 Aug 2025 19:48:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM sysreg ids for FEAT_SYSREG128
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Oliver Upton <oliver.upton@linux.dev>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <1c6b4f19-6cb2-4da0-9acc-d63307880de1@linaro.org>
 <86cy8y8grv.wl-maz@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <86cy8y8grv.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 8/14/25 18:11, Marc Zyngier wrote:
> Hi Richard,
> 
> Thanks for bringing this up. FEAT_D128 is not on anyone's radar on the
> KVM side (I really don't fancy having to write another set of page
> table walkers), but it doesn't hurt to be prepared.
> 
> On Thu, 14 Aug 2025 00:27:25 +0100,
> Richard Henderson <richard.henderson@linaro.org> wrote:
>>
>> Hiya,
>>
>> QEMU (ab)uses the kvm encoding of system register ids in the migration
>> stream.  As we implement support for FEAT_D128, it would be good to
>> agree on an encoding for the 128-bit registers so that we can avoid
>> complications with migration later.
>>
>> I don't think this is terribly complicated.  Simply adjust the value
>> in the KVM_REG_SIZE_MASK field from U64 to U128.  E.g.
>>
>> PAR_EL1 (64-bit)	(__ARM64_SYS_REG(3, 0, 7, 4, 0) | KVM_REG_SIZE_U64)
>> PAR_EL1 (128-bit)	(__ARM64_SYS_REG(3, 0, 7, 4, 0) | KVM_REG_SIZE_U128)
>>
>> This will currently be cleanly rejected by index_to_params, resulting
>> in ENOENT for the ioctl.  When KVM grows support for D128 guests,
>> kvm_sys_reg_{get,set}_user can select the read/write code path based
>> on reg->id & KVM_REG_SIZE_MASK.
>>
>> Comments?
> 
> The encoding of the register, as described above, is absolutely fine.
> 
> But since you brought the subject, I'd like to align on a bit more
> than the encoding.
> 
> The way I see imagine it after two cups of coffee (which clearly isn't
> enough) is to have a feature bit provided at VM creation time,
> enabling D128 support, HW support allowing.
> 
> At that point, querying the list of supported sysregs would report the
> 128bit versions of TTBR{0,1}_EL{1,2}, VTTBR_EL2, and PAR_EL1 (ignoring
> things we are unlikely to ever support, such as FEAT_THE). The 64bit
> versions of these registers would not be reported.
> 
> Does that align with what QEMU would do internally?

Yes.

After selecting the feature set for the cpu, we register the system registers that 
correspond to each feature.  During registration, we select the size of each register 
(more specifically, the canonical definition is maximal, and 128-bit registers are 
squashed back down to a 64-bit registers when FEAT_SYSREG128 is not enabled).

We always require the same cpu model during migration, and the choice of register size is 
tied to the cpu model, so there shouldn't be any migration issues.  With -cpu max, we 
explicitly don't support migration between qemu versions.


r~

