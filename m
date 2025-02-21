Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C2FC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 16:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlW1H-0001VZ-R6; Fri, 21 Feb 2025 11:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlW1B-0001Uo-KR
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 11:36:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlW19-00051B-Up
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 11:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740155806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qL0B3uZT0g/2N7uPh7SdWbdwD2IKSkpoX3fBDs8pKFo=;
 b=h9FC2RS0UoOTnDYF72rRxO16irghuw7yyazHkmKWFB9X9dC8n+7wpHYwNLqO3Qc8XNsQt5
 NiXUVsJY9GM5/fbvCKQUuq32O4ZPEW13KQUA/FmfIa/gDR5tk5Scii2e4h+VEE3xMG4YQo
 cV9h4yMTYZ+5FJEd0gnHeTWnZCRIBho=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-2WhdhfpoPROxXQm62T1xVA-1; Fri, 21 Feb 2025 11:36:44 -0500
X-MC-Unique: 2WhdhfpoPROxXQm62T1xVA-1
X-Mimecast-MFC-AGG-ID: 2WhdhfpoPROxXQm62T1xVA_1740155803
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f44be93a8so1203581f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 08:36:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740155802; x=1740760602;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qL0B3uZT0g/2N7uPh7SdWbdwD2IKSkpoX3fBDs8pKFo=;
 b=N9D2GWOnWC5SHew1U2r3XbO7AImg3KIke7xIvVjqluXy0lqTHYwOgN0bqbFOu0abPx
 VIS1Q7Xgk4j95RuK+m26gPqpbYQ/NWkq2DrjEWnb4TJQ+Dndo9hLxslyv9q9ynjUUPF9
 LnQvMJEjUXbrH70mxsF8DAC2RKMaqG5QkPevZX/ILNPoxC4N6+ro8OeROz0SpYi1zu1R
 5r4RiX0p0n5njI2PQkChuWAbLvdsfZ9Znbzibv8JlQowKSndVYx9kS7LuWBN8LrEvZZe
 MKMVriUlCLB8ZfR7o8gOcSHqGABHzEpUCj+GyjROputGF9sqfXEECtMRnQ6DANJKzMwi
 xXjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEVT/amJ8xpFYIJdahMinnxjcfi0EV4yBO2LnEYoq9oqcG88sV0+LC6BbKccmitBYt8RnGxT/CznAJ@nongnu.org
X-Gm-Message-State: AOJu0Yx0vg52o5ccxNzcWYyZm/cKch0HoqdNahEKRiyInV9xvBL8Unlr
 8XLTbk+PFsMB6v58WPcf797e26ysQzmaLXC9i/w0RM1nKjAVulrtYbnzqcsDpwYgarw3uO2Te3t
 CNOMrLrT9td2kdrK0LRw722Mgx3aWBXMoLmDqlo5gWeKjU56oTGy8HgTFnnknZ7w=
X-Gm-Gg: ASbGnctk+K2+jIm/8lWUHwmal+j6o92RJzvTfVFdZO4y+S9lp1+VaIrawj5GXTnsx4s
 7FbZbz5YJ8Gk21y1VzkXUaN/63KO51VJp7No/mk+bE5kcC1BSRQQ3d+eAfaz6v5mWw+LrpaWDwf
 EeAGUhCEqDS+qqv9MTvGS2s0exU0PlBmM3YK1gqrq8+WI03+S6dQdeWCxUnsE2pVI26BbqKB9ps
 3Zt317RBR5RpyUe3FcBWKwlFCwtrOePHTouyNkDnwL04a+mIJs/CeVy/yDmSDRTE06E1JpPyTnA
 P7dVRvFAt51l4bmAyXA=
X-Received: by 2002:a05:6000:18a9:b0:38f:63e3:de35 with SMTP id
 ffacd0b85a97d-38f6e975cb3mr4345372f8f.25.1740155802487; 
 Fri, 21 Feb 2025 08:36:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLnl7zNC2dTHcFgcC1wtSRJt5Z7A4Q5onmHPaxgqwQVve2GwZfEKS+JZHvG4cnsuDG0lwEMg==
X-Received: by 2002:a05:6000:18a9:b0:38f:63e3:de35 with SMTP id
 ffacd0b85a97d-38f6e975cb3mr4345340f8f.25.1740155802049; 
 Fri, 21 Feb 2025 08:36:42 -0800 (PST)
Received: from [192.168.10.81] ([151.95.61.185])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38f258b44a7sm24191688f8f.12.2025.02.21.08.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 08:36:41 -0800 (PST)
Message-ID: <1cf2edfd-5cce-4b15-bc28-4dcde96767b5@redhat.com>
Date: Fri, 21 Feb 2025 17:36:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/19] Factor out HVF's instruction emulator
To: Wei Liu <liuwe@linux.microsoft.com>, qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com, mukeshrathor@microsoft.com,
 magnuskulke@microsoft.com, prapal@microsoft.com, jpiotrowski@microsoft.com,
 deviv@microsoft.com
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/21/25 09:36, Wei Liu wrote:
> This patch series attempts to make the instruction emulator in HVF a common
> component for the i386 target. It removes HVF specific code by either using a
> set of hooks or moving it to better locations. The new incoming MSHV
> accelerator will implement the hooks, and where necessary, enhance the emulator
> and / or add new hooks.

Good!

> This patch series is in RFC state. The patches have been lightly tested by
> running a Linux VM on an Intel-based Mac.  We hope to get some feedback on the
> overall approach, and let the community bikeshed a bit about names and
> location.

For the bikeshedding my only suggestion is to replace mmio_buf with 
emu_mmio_buf, and replace x86-insn-emul, with just "emulate" or 
something like that.  That is, no need to repeat x86 inside the 
target/i386 directory, especially since the filenames also start with x86.

> First two patches fix issues in the existing code. They can be applied
> regardless of the discussion around the overall approach.

These four can also be applied:

  target/i386/hvf: use x86_segment in x86_decode.c
  target/i386/hvf: move and rename {load, store}_regs
  target/i386/hvf: move and rename simulate_{rdmsr, wrmsr}
  target/i386/hvf: drop some dead code

> The checkpatch script complains about a few things. Some are from the original
> code I didn't touch. For the code I changed or moved, it complains that some
> lines are long (>80). Seeing that the rule was not followed strictly in the old
> code base, I held off fixing that class of issues. The other thing it complains
> is there is no entry for the new directory in MAINTAINERS. We can fix these
> issues if they are deemed important.

Yes, no problem.  The new directory thing is just a warning but I think 
you could add a new entry with both MSHV and HVF people on it.

> Please let us know what you think. The alternative is to duplicate the
> instruction emulator code in the mshv accelerator. That looks to be a worse
> option.
Yes, definitely.

Paolo


