Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD66D5E364
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 10:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9iwz-0005Qr-Ud; Sat, 09 Nov 2024 05:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t9iwy-0005Qj-Ra
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 05:44:16 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t9iwx-0002oW-Dl
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 05:44:16 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539d9fffea1so3024372e87.2
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 02:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731149053; x=1731753853; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JIpnBJHmzIVVhIAV3Ko11hk7TTFaNJl5v6XXwacvIis=;
 b=I1395ShpWxfHkZ408u8SM2pyG2l9Fr7VbOVg4g3RaxRuCXkBmWXYkxppEY03V8bWr+
 YqdEvsJ9+CLzHFFCoDsTJJFc1aUsGPGL5nPNUIAVV67b8e10d/1+EkgtDJI6MNWBH95A
 LDr1cvVfLxgJ65xFYeLTmapSN05tJ+Rmn5h8unko2bA8Jiwc/EPspX6obKdnVbBh8hXv
 UgKyJ8XN2k7pJVQzr7okAO6xNJ/KAHi1pEQKt0Zmt33h7fXw/SVT3Noml4GyEJ+Mobj4
 3uSxLQtBVoKYQWlSvhUBRcip5MpsPultkFKWziwB0kaMzUcI5EpBIMyi0vhuaoAdAbAy
 S+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731149053; x=1731753853;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JIpnBJHmzIVVhIAV3Ko11hk7TTFaNJl5v6XXwacvIis=;
 b=j2b8LrdBqXiJKTnrXlzp/NVHI4+ZsB+/OVgJVj8cws7PDjX4HULFFXmcsAEG2DQvw7
 A+jl/HMGi0cyxzndmGFqsSlW6XLEV0KJiNBTuzZDfxMJJXdDip+1PmvPI2Sd8NiJZFrE
 BTx90gGlg6jPGRXcF4QEQHI6bNX+XiFTxizusaJ5PQce0TgP1VueoHF4pZVo8m9r7nTh
 YEQm9v6RUzzWnBP9NWhTSv1W2S6iEpdFqqi05xCSiIQNB32eeLtP8H/x3vCOUURfb/Ye
 NJ/angYuUFWWzGEbhpcxr9eA1FCd8EmRLy75coFs06n3dJ+dcYpIry2pqh/NLnAi6rbn
 RYyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwNBWFrJ5wEDXUtuAy0jkoX/oDCDIB6WPEL7kftFywLjcnW2KTXwn0UE5knkaI3O2RP4Yx0LU+xiO9@nongnu.org
X-Gm-Message-State: AOJu0YyKxK5TaczpDiYimY1rOazGc4DzG/goce9A9qUgg4i4+WRpVgZm
 9YSMf68adpT/YeDaMXQOO+uSzPO4KjlpVCcfC3SeJWtPFR/Pcpnx5dmRPIMX
X-Google-Smtp-Source: AGHT+IFGv48havwvIzHSLQUn1z+fnpKjWhHslbfxuSlwYETDUtdXbOIILYRWGCS+USzKe4nrEKPLrg==
X-Received: by 2002:a05:6512:3084:b0:539:e110:4d72 with SMTP id
 2adb3069b0e04-53d862f381dmr2919926e87.56.1731149052832; 
 Sat, 09 Nov 2024 02:44:12 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53d82687db7sm902091e87.105.2024.11.09.02.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 02:44:11 -0800 (PST)
Date: Sat, 9 Nov 2024 11:44:10 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: "Ho, Nelson" <Nelson.Ho@windriver.com>
Cc: "edgar.iglesias@amd.com" <edgar.iglesias@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: xlnx-versal-virt smmu
Message-ID: <Zy88-tnGVGj6elQV@zapote>
References: <SJ0PR11MB66930672DEE042F6AE1E7421E75D2@SJ0PR11MB6693.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB66930672DEE042F6AE1E7421E75D2@SJ0PR11MB6693.namprd11.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Nov 08, 2024 at 04:26:20PM +0000, Ho, Nelson via wrote:
> Hi Edgar,
> 
> I am working on bringing up the Wind River Helix hypervisor on the xlnx-versal-virt machine, which expects to find MMU-500 SMMU where it lives on the Versal SoC. I understand the -virt machine is not intended to fully emulate Versal SoC.
> 
> I found an implementation of the MMU-500 on the Xilinx QEMU fork, and am curious why this was not upstreamed, and if you know what issues I might encounter if I try to integrate this MMU-500 implementation into the versal-virt machine?
>

Hi Nelson,

There's no particular reason other than lack of time.

The tricky parts will likely be to hook it up without the device-tree
bindings that Xilinx uses to create machines. Perhaps also how
we use Memory Regions to describe the DMA ports towards DMA masters
and towards SMMU TBUs in a non-PCI specific manner.

Cheers,
Edgar

