Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33BDFB44B4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 06:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGA6g-0000gQ-SB; Fri, 24 Apr 2026 02:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGA6e-0000fw-3O
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 02:33:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGA6c-0007zO-9W
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 02:33:39 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so91551015e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 23:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777012416; x=1777617216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JvyrK4KXDGk4B5zYslJLs/0EUMmF8duaMvkGfm9A94c=;
 b=XJCjDa9JqofMP2onI1DMWeEt0qPms1dOGvB1skGj4Mrf0L94dN0GguDVhkJ0tV31qV
 pusbMNKzUwLW53J5Imc1WV42lD4JFGje51K8T/EhOJlyFG/bClJwPV22nE1I6onkd2LA
 XS5NMpQRlkJtDVG2zhhmxzzTweI27bkuwq9MYFRk7kngnpPYERGars6eefRIZ0s+S+O6
 x1No/bwtHsGumiLi02G9gTXZIvgdmZQwQt2B6trVHfB7vRJIsZKnDSQzY85Y0BhP0YTz
 Rq7+CxkxRPjJFcTH2/vPne3JI5hTIQcXk6/O3ZSoocewok0CtKRGf/W2YS+reSDoPRpz
 4pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777012416; x=1777617216;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JvyrK4KXDGk4B5zYslJLs/0EUMmF8duaMvkGfm9A94c=;
 b=DtvMygFFhtqJSlPBhoE1CEsJphFjM+BvecgY9Ac5NN64xdSNpBw5uDBayaPn1DUOqe
 1wB7FQNfOV6va5Ob7aK2JIyPUhPI4nfWd8A4drZrEJZuxnhbh45lfAlDoIL5Tm9ZaPTd
 dwEBMdhGpS1ZbuIyTjVYrJ12Yc4KMab3GVk36BCuLYahL67j5fkzHJS7LEocYUeqxoYm
 HLvglfILNF7asODBNs8JB6lfRJaUCm+6y5fz5+pOxx8Akb0v6vIRvExBtIHuA7Dh7/ke
 uRhSDs3MpyNMANoF2g64vJ1yilcpE6Ecnq/54NjGrjjojs8OxwMbB4s+pykvT1siOfgp
 u/Ug==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TR7JPtTVFoXVNEq8tG7c8lphQ3OiStPXB/n7nVIFB1b0AQX3DL3RnsHGQZXrvWyZ5KGXTzwW21kXK@nongnu.org
X-Gm-Message-State: AOJu0Yx4J8PUtbDO57znhDl2srHKOQcLAqi8nupY2vLY0pAkolrytgJj
 tKTwmUseGk/iPVGG4MtoZrn/TMjbJwsBk8cph+ALDxZcNkqXZY4whK/S51YHQ1fJN5Q=
X-Gm-Gg: AeBDiesk6iQGosu8Eks+vdJOiMNtoerPC9mVltrR5m4SvYLtt9tA6lQwACmP7UBVKTz
 FewhUj+PbB3vISjXHQ/UEcylBxmx95C+zbrM7JZyp7Ti3HHds35O8rL6hPYhXPmlgj5Rnrb+Ilq
 cSTEddVnXsLtbLrChOlUp3tv6MRFbv1N3fnpilUUQzrvYbncWju7fQ1it99bNozumyQhzJ5f5ZC
 fcnhrvRRPn0fv5CIVFbqCgTi893yt9h0dGXPjvWxcIbvmtm0+RoyA/FOKkqhRU+sRUn9JBkhtvX
 CevKlYUDIp1BYpR/mglUA8mLobouF9UIlgXObN8NlIkSQEfAHmrZsI6Zzn4MHMVO43VlAR2WwG/
 4vUnXsj/eFuleix+Eq3g1qgIP7RRSAXu+y0TUx5sKecRrzmHJ1tiGvV2kabOURa7kXu6xrJnlxO
 mn6cWBK/oovcD2Ze7SEpi3CMP3JZ88a64BvJdGz79aDo0LmzTtQCLEY8xlQX8MzT8yvN2yHm3j1
 Df0
X-Received: by 2002:a05:600c:1e09:b0:48a:592c:e655 with SMTP id
 5b1f17b1804b1-48a592ce7c2mr172892065e9.17.1777012415932; 
 Thu, 23 Apr 2026 23:33:35 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a55dc9f58sm538866295e9.6.2026.04.23.23.33.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 23:33:34 -0700 (PDT)
Message-ID: <db91f531-dbc6-44dc-a751-3ab4e96da718@linaro.org>
Date: Fri, 24 Apr 2026 08:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] intel_iommu: Replace assert(size == 4) with guest
 error in MMIO handlers
To: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@bull.com, zhenzhong.duan@intel.com
References: <20260420170523.17908-1-junjie.cao@intel.com>
 <1c4b67db-447f-408e-a6b4-c477894f1a59@linaro.org>
 <20260424030935.2664678-1-junjie.cao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260424030935.2664678-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 24/4/26 05:09, Junjie Cao wrote:
> Hi all,
> 
> Thanks to Philippe for the suggestion - this direction makes the
> overall logic much cleaner.
> 
> I have drafted v2 locally: raising .impl.min_access_size from 4 to 8
> so that the handler always sees size == 8, which eliminates all 25
> assert(size == 4) call sites and every size-based branch.  The low
> half of each 64-bit register pair now uses vtd_set_quad(), while the
> _HI cases stay with vtd_set_long(); for 32-bit registers, the wmask
> ensures that zero-extended 8-byte writes cannot clobber adjacent
> registers.  The default branch falls back to vtd_set_long() where an
> 8-byte access would exceed the register file.

Great, this is exactly what I had in mind :)

> Currently replaying all 24 fuzzer-found crash inputs, will also run an
> 8-hour generic-fuzz, and testing with a qtest that sweeps every
> 4-byte-aligned offset with 8-byte reads and writes.  Will send v2
> once everything checks out.
> 
> Feedback is very welcome, whether on this thread or on v2.

Sure, keep me Cc'ed.

Regards,

Phil.

> 
> Many thanks,
> Junjie


