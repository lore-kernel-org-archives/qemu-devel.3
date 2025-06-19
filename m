Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8CCC7115D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 20:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSMAr-0005LC-CD; Thu, 19 Jun 2025 16:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSMAp-0005H8-8u
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:47:51 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSMAn-00065e-Pk
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:47:51 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so857553f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750366067; x=1750970867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bzix+8zAJLfeHlWgigexZd3xxg6pu2+lMkmq/TNDM8k=;
 b=UwpA0flJ8aOL5RQp3xElZ0m3OnE+qEBUMEiy0A7EgJQbhDZKpDB7vDqO9/e9t/CyQo
 iaVHyDmzH7djqtYDt1jbGESq9KLyJ3MIcQAoc+hRVb9fotSQUkPzG6GIgYzfmDJH+WiK
 LPAMAOipn6DMFWUZETW+6392jvqcFOnh5T3zIYtQNVRNO01G7F42GuWBoGXzyt1m1nlb
 L2lfI6htt9ctT05CtDPV2VxmZ0DAt6KxMNC4wLLscO2qvPh/nv1Q+TmHNg2DQ4lahe7g
 8PbmOpe8fYoRD/K/3e4ha+bbaLK//whJ3HB8qrSRhVQSLzZbk01aUSEQMBgSV045qloR
 a3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750366067; x=1750970867;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bzix+8zAJLfeHlWgigexZd3xxg6pu2+lMkmq/TNDM8k=;
 b=TuYTivbUrkweDE0aAG6CcmexZnNTyCBQ83U+iuh2lqXuq5zmIAaD/05wvLJXN3i9KC
 FwzkkBXLfCNT0Qk/ebsePa6xnar1Rz0LRyXRubE3Wf3EXYcQF/4hF5F+GrOsmZpIlA5v
 kuEPtK/WWSO1Ca9DvSAyBrHxJYbw00pclwQmNcQQIt8L9slUQghWlLuZEzWoAnjMFDrM
 O37P2c+A/2EtSauXxU6uUYtKENx4X+fqnHG+PHuS1QmLyDbkYidXr960DWRtebuVbNyu
 scfMSmLnDdPx/F9Tp3A1HnzrrSjCClZtxjCZu/KQHnNVvkLhu7uOUshEDbva108HuGsJ
 GA1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVVpoh5+l7+Xkp/WdQMnBrEVp0wzuYl5QiADdjFDbBvwWXfCH9qFR2ZsUvR/5psLcWMtkJY7ZrTIT9@nongnu.org
X-Gm-Message-State: AOJu0YwchB+ZhxWnM8tpZCIMoVMO4HvkTEx5hCLtpSt25WRCviGX5Lzt
 rixSgiwyuVZHEa8EEVpiHBi/kVP5Fhylvi84RzDpzSHdW7Lr/Y3gWrmdWUbCmPqBAVQ=
X-Gm-Gg: ASbGncslu6S7xN6NkDcaJgNFxjFhTW4jNWCNgGANHNRXkdtIDgyX6Nn91N3j3ZbJQUx
 3fiktMRCwuirugYdD6lPil3gF0LnCIH1xIg6z5T56P1lp64HE0aXPOmw/6k3+i2sS2jnRbABjEQ
 wY+4usxam4ij62TVW+VJ9KTUhfVq74ImZIZT6SrUSuAAVCMOAL9YMjmCzPlF3XgtM4DJjBUAPG0
 16/REGiPbDEFvIjCqlPbqtTtjMKXSF2ugWZuarwBlQ47vzxnHu/Sp8YlM6W7srHXexlSw66B3d9
 vZMcvKrl67/7MdANZ7CeAgZKHJGbr++f+t/yEtes3nLd/rppGg2nafM2QksRkY7u5UU175qVn82
 dqggMum5/snWFK/qL6w4fVSVSOlusmg==
X-Google-Smtp-Source: AGHT+IHKzGNP/YgFXLQjwbAe39QrDnHbLtS3zaKWkULHPmmbOVyt/S64uYB/6VP+XULvIv2mbBthtg==
X-Received: by 2002:a05:6000:2182:b0:3a5:8a68:b81b with SMTP id
 ffacd0b85a97d-3a6d130e818mr222910f8f.44.1750366067310; 
 Thu, 19 Jun 2025 13:47:47 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453647082a2sm4618405e9.37.2025.06.19.13.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 13:47:46 -0700 (PDT)
Message-ID: <ee460d4c-035c-4229-9a0c-d36390782f98@linaro.org>
Date: Thu, 19 Jun 2025 22:47:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] hw/i386/pc_piix.c: duplicate pc_init1() into
 pc_isa_init()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
 <20250618112828.235087-2-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250618112828.235087-2-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 18/6/25 13:27, Mark Cave-Ayland wrote:
> This is to prepare for splitting the isapc machine into its own separate file.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 260 +++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 259 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


