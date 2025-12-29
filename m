Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F55E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaHxn-00052k-El; Mon, 29 Dec 2025 13:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vaHxi-0004xT-RY
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:27:23 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vaHxh-0002ej-8t
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:27:22 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4ed66b5abf7so111645701cf.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1767032838; x=1767637638; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QQFjMkq4/K1jAttxNxSE37cpaRl5SQggj70CxVEdDgc=;
 b=F9rkHW92jTiFMcjHBD7dYLac8lxoEX5p7D1vnvqHWq6B20A4vuZfq6OSklVvPciH9J
 tUKU7F9hdSXH+e+H1b/7u49STux55GaJXbNCe3PKDGtn+yXHh0/pNUOEPpbl6Jqn7moX
 8lYLwOK9IPZkzTBytF/GOatIYJ9kNk+P3/eNVwp5oPJZsdVMRz9WGtHL7Jte1g0xkPUC
 7ObsbK9KqJ5V4rMSkc71HdHwDrVhM+zrXT5k1OP9aSCrCAyK0GRcz0kQW5DCwoRFHAir
 /YkKPIJS3H803lqu2YRoCwhmUGneyk03VEXBWHjPG25K4vZKWpDPLplt1/dqrMUy4xES
 hcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767032838; x=1767637638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QQFjMkq4/K1jAttxNxSE37cpaRl5SQggj70CxVEdDgc=;
 b=bwwQjqOFFvkJ9JgbRJzzpX7ejy7TlrNpWIpw4ZDLiNnMfL5GkCMcBUaq6HXdfdLQJL
 W34khZmAtpRXFaB2uJ1FZg33iHC2AfjIFKN3JzluXQR/wJkl9sCrOPH6GwpC4n8i0sTv
 Zh5+29PA/uGthQvSkJIiw4LqnzsxiRrzNImj0xDgdhw/B7kyQQkKFz+w4oTZ/kwAp43v
 tEKSWclRtRZTW/tV3k1kcZZ2nfHpcZGg9nfixFy15rqsNuSOhlFx4jCCHjuxO0RwiAgV
 V8qhKF349lO2bQsWrJW4AoRH+t3BQelExhbF1UAuJD8IE3LOhOwzbpyQIh5e5YL2At0X
 INIg==
X-Gm-Message-State: AOJu0YwvNX5EhJc1OV5ja4MncGV0QsJW2i+9/gc2jVVN8OsyseTlqHMn
 yUIsdUM+ua8MQzqFHY7cbeWODxN5eE8mU9KW2VQ4mGU8c46vsZS+agPb15PCX0TYIr4=
X-Gm-Gg: AY/fxX4gJLbOBIMhmrdfYtchR4itfovISdR/Scgyx1dTO6D7/vcAMU12mYSl6FRn0Tc
 PVlSbLGDtkOT7Yilsdhj3+FpLbprm65KejOLI4ofxP+XZshd1KQtADLnhdGaN/os7m2f0aDDU6M
 EQOxravc2bN0o4xn7w6o4fraKCfpX+qFDFkaGwNozhsHfGDqW6q2beoTGFleuv4Wp8znS3NMRG7
 c/YBhkXPpohJqDnbAgQdDfpitN6+RWWBZ36IldZljIhEuStROaV8g4uSoCBeVENsAFOALM4Ly2K
 t0nl1IHg57YNxkQYoMQ3bV6HLr82TIfouLmRvKA2KQT6klhVIyf2OIb129QcXwreqpk0GThzEfZ
 H0SxHUK7C2i0zF8NrAuVewy+FaT/2Vj0G5h+/MOZotwyUABV8MNs369g620vTEl9Fxi21BKFY/l
 Nlw0Nrz2KYgOrKu7NcBYkh8sLagdXhMJTKFsX7G3u035yeVPjchzmoX8Mvk9npV6cF0IKOhA==
X-Google-Smtp-Source: AGHT+IFIdphjHy4rhhZeLG3qqrm9JIGXnFQQwKBASSmgoZsEFHviu7TCZMK2hbeRNDXPcMU5b8syag==
X-Received: by 2002:ac8:5e53:0:b0:4f1:b362:eed7 with SMTP id
 d75a77b69052e-4f35f4849eamr476146361cf.42.1767032838306; 
 Mon, 29 Dec 2025 10:27:18 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d997ade8bsm229075706d6.26.2025.12.29.10.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:27:17 -0800 (PST)
Date: Mon, 29 Dec 2025 13:26:42 -0500
From: Gregory Price <gourry@gourry.net>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: qemu-devel@nongnu.org, david@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
Subject: Re: [PATCH v4 0/1] numa: add 'spm' option for Specific Purpose Memory
Message-ID: <aVLH4mmbDSp7ZdVu@gourry-fedora-PF4VCD3F>
References: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209093841.2250527-1-FangSheng.Huang@amd.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=gourry@gourry.net; helo=mail-qt1-x82b.google.com
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

On Tue, Dec 09, 2025 at 05:38:40PM +0800, fanhuang wrote:
> Example usage:
>   -object memory-backend-ram,size=8G,id=m0
>   -object memory-backend-file,size=8G,id=m1,mem-path=/dev/dax0.0
>   -numa node,nodeid=0,memdev=m0
>   -numa node,nodeid=1,memdev=m1,spm=on
> 

Interesting that you added spm= to NUMA rather than the memory backend,
but then in the patch you consume it to apply to the EFI/E820 memory
maps.

Sorry i've missed prior versions, is numa the right place to put this,
considering that the node is not necessarily 100% SPM on a real system?

(in practice it should be, but not technically required to be)

~Gregory

