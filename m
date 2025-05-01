Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87691C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWhn-0007uW-W9; Thu, 01 May 2025 12:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uAPVJ-0001sy-AT
 for qemu-devel@nongnu.org; Thu, 01 May 2025 04:42:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uAPVH-0000LJ-CZ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 04:42:49 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso2515205e9.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 01:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1746088965; x=1746693765; darn=nongnu.org;
 h=content-transfer-encoding:subject:content-language:to:user-agent
 :mime-version:date:message-id:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBg7ezcuprXykc/K02UIVpCehV40oQ6pHaLdEutMdP8=;
 b=WEBDGX46HUgpZQMQRzky+tMvx3ob3sNkROGmY7MtaaDIpVih5tNKVkSwL3p1aNSX/l
 DNW6gHEU2REHoOO6PjeSzNU9N4CVi7+3gGtbgToD3EPLCVrIHivkmk6YXk1iS5ukRd4a
 +7hGx4n8thgpmYs4pUS8OxffgMkvo5m53y6zEuz/UtgjHBuECe8WIikyTbngacesmWXF
 YKLDgywImMW8RSkC2SjRcbg5xOxXGvumXz+1yecbEUWsgLRwr/Ewd6BSvBpwqOtEprtX
 1gakjxbCuRjtl4xQ9S2y+CItJP4ZDUmhg74coqjw4hVwuICj+q1DfMroRLM4LPOZTGpX
 WqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746088965; x=1746693765;
 h=content-transfer-encoding:subject:content-language:to:user-agent
 :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BBg7ezcuprXykc/K02UIVpCehV40oQ6pHaLdEutMdP8=;
 b=n10kFT5UMEb2hEJLGtehZ+k2iMWvuWe/Aw4VG14d4PjiZwSoNRz1ooOFOGuN/CEvRW
 ihftE9EvR2lovYnTBD2aofJJAg0wfFuhXfCX/QPuLs4jEJADa6/FG4H1OENHymJdqUEK
 U5lIPL7/84yx+QLxnhpp/G2NwCouiAApkvrQK3rHVNEOhzpEKx8C46P2bw7ak+56CV0q
 1ZPPhhljQMvwguLRLWQw7NFmMywA1XCAXxoakwwHIaRhQIUpZZa2IX/Uy5iERjZ+BXfh
 17NZZUoXh0el/wGxWs0NYTT9aXfdFoJGLDztD7lrB+/NWS/H1ZMxv1u6sg3mpkSJh6tK
 KbUg==
X-Gm-Message-State: AOJu0YyCA5PLtwW1M9CQAxxdvpKafDZGE1QJlFKixUKA4vFeYRr9X3s5
 g0ZKgMOLr4Bmh8T/bGt2UMNDGXoh5d246EdqxKreojUMI4ebgvqQhmlHvQ==
X-Gm-Gg: ASbGncuaPZt43rJXWReUzDktcTH8GHdS5A+t2wdxdThYWvQFGza+71GmEr5Xyc7M8q1
 6EERJKT5m2/8c4RcA7o5waid1pJht9YBsZniujcnoWotmAGfgyNkJj0asl8Q54VBpCxP0xFctby
 U3cXVUdfsYFRtzKXJyJMSVp6CPzPU4qLFT6xA3+hDdz+E1kyHC9W73Q+wiCj+Nps4W94pUS9YAm
 UfJBrRQg+n9GAxL6xIeTDVdfOvamkozV+H1ZLNCN+qZNzB61zL4G5mAeHZ3rDMOayFoHmhFT1Zk
 zESDjT3H+gKmOEysvPYUqZ1P9GZtUtzRGRT1dWCaEdSQ6ja/A5r/vc5RsbZ4keEgxWaRB2U8MVv
 uQKBAYbpjOAnwhhjO
X-Google-Smtp-Source: AGHT+IFz2Sh8OUvTbacp/JZ8jVs53Vf0aQOrD3anH3HluljsoH4O4cRXmL9SbIL0jCHdNLSzr20bfg==
X-Received: by 2002:a05:600c:1e87:b0:43c:fa3f:8e5d with SMTP id
 5b1f17b1804b1-441b6ff201emr17847865e9.2.1746088964452; 
 Thu, 01 May 2025 01:42:44 -0700 (PDT)
Received: from [192.168.86.32] (97e5422b.skybroadband.com. [151.229.66.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2aecc89sm50766755e9.9.2025.05.01.01.42.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 01:42:44 -0700 (PDT)
From: Jon Wilson <jonwilson030981@googlemail.com>
X-Google-Original-From: Jon Wilson <jonwilson030981@gmail.com>
Message-ID: <e703e0e8-8207-41b6-b2a5-6d6544816fd3@gmail.com>
Date: Thu, 1 May 2025 09:42:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: qemu-devel@nongnu.org
Content-Language: en-US
Subject: madvise(MADV_DONTDUMP)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=jonwilson030981@googlemail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 01 May 2025 12:24:09 -0400
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

Hi, I'm a first time contributor to QEMU. I am using qemu-user for 
fuzzing using LibAFL and as part of that including support for address 
sanitizer 
(https://github.com/google/sanitizers/wiki/addresssanitizeralgorithm). 
In essence, this requires that my process running in QEMU requires very 
large (albeit sparsely populated) memory ranges (terrabytes in size) for 
the shadow maps. When ASAN detects  an error, it causes the target to 
crash. As a result a coredump is generated (which would usually provide 
a very welcome opportunity to perform a post mortem), but QEMU includes 
these shadow maps in the core dump which it generates quickly exhausting 
disk space.

The function vma_dump_size performs only basic filtering of the ranges 
included in the core dump and the implementation of target_madvise 
disregards MADV_DONTDUMP (which per the spec it is at liberty to do). 
However, it would be very helpful if QEMU were able to exclude ranges 
marked with MADV_DONTDUMP. I believe it should be a simple case of 
adding a flag to page-protection.h and using pageflags_find to update 
the flags in target_madvise. Then the logic in vma_dump_size could be 
updated accordingly. A more colourful and easier to read description of 
this is in the following markdown gist (with references to the code in 
question):

https://gist.github.com/WorksButNotTested/becd7a1f89690fad89b3e8b44ed7192d

Would you be receptive to such a modification? Is my strategy for the 
fix correct?

Many thanks for your advice.

Kind Regards.

Jon


