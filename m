Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972C6C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 05:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxKRQ-0005nb-1j; Thu, 18 Apr 2024 01:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sloosemore@baylibre.com>)
 id 1rxIQs-0007sa-NA
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 23:27:30 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sloosemore@baylibre.com>)
 id 1rxIQq-0003Xj-DG
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 23:27:30 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-36aff02f998so1145655ab.3
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 20:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713410845; x=1714015645;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5gA8QUGQOdrLso3TDqnwOuHMmqkm0XVXDlJnV949G7o=;
 b=v3q1YwUyV9tpX1jawaW6QabqMIJ0PK/0rdMssXmndjGHn9irCiz/NwrqlJv6hoUeFt
 fw/mSL/O70VbKv8SdqGj5GspD22DqJKlQjnDfhDNEkBbzaYKXxGmihgtQtY2syA/Ch81
 QpLBshUXk5AZMp1z8qRkCSrRYmMe0Rw0q3a8zhWkhrytHUWimso2p5RdeB7wMSSbgjG4
 OloGFzsjb4NvnJctWiSbFma6JSBQm8n+AvkDizdl9PtcHb3/oQXTk2bZUrR1zz3OEA0D
 kA2c6BjorZXyJDlP4dFUaftIQ6JQWqzwHvWq278uh5IcujXVwEPsTsxO9odYZE4QSUAC
 fP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713410845; x=1714015645;
 h=content-transfer-encoding:cc:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5gA8QUGQOdrLso3TDqnwOuHMmqkm0XVXDlJnV949G7o=;
 b=QX5CQlUC9N6xcFVQjH/glhIwZQFEe3ORJR8UOIUBq5i6Jdv54BAMgz7CvZ7L9F7Rlt
 A7r9hr/bnY9H56vu5B7AzrNFbIbISznFc9+G0DjzmeHA9e2ov9Hn+9Tgfdc0Neq2uW1w
 lRkjxOV3M430voHlZgChi4yNXEP0RYWrfHFEvD/sT5MOZhyGQNQodiOLfOHCFXAdo6NJ
 JCdxusjyRgpxPwkMapgnG7ESXmaHTvWjHMm3FW3lMnl9EAiLulVNwnnTijrmsKilMx8l
 rh467VkHV+zprTZz6AjTe6wSjWbtXTTCqvXsRzjp73AfmrSa0UE2zKNqWhQRU9a92BXq
 muRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUfX/+5oNF7cwYSgIk2Zso6a0Gx7EqQRzF1B4m4p0dNOuOPogkwXBI3DkIgJRr1y96jHzUz9QXSw+aGpODzCdfHe4debc=
X-Gm-Message-State: AOJu0YzDVaYI5Y7kiXEjCcYr8kTKhfHG6ZlvstAKx9RhA6DfXP0UpDv7
 BC9tDTRYK7oDO7/1R14MkTIPr6AOaxC3DBcCqxwUMnT9Mn2Ht+YX6TgpPQ1jGpc=
X-Google-Smtp-Source: AGHT+IFrhLQQ6SkzsTzhCTAnWXrX4IwidvUebTMZszp5I7p08/L82L+EGlf+0MnzJgH4gJU6jIlUmQ==
X-Received: by 2002:a05:6e02:13a3:b0:36a:1725:e123 with SMTP id
 h3-20020a056e0213a300b0036a1725e123mr1810227ilo.14.1713410844838; 
 Wed, 17 Apr 2024 20:27:24 -0700 (PDT)
Received: from ?IPV6:2601:281:d901:5620:837d:e339:1ac5:3222?
 ([2601:281:d901:5620:837d:e339:1ac5:3222])
 by smtp.gmail.com with ESMTPSA id
 kw23-20020a056638931700b00482f40d1024sm173661jab.139.2024.04.17.20.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 20:27:24 -0700 (PDT)
Message-ID: <55a1bc52-b435-463e-8be1-4b23e44393a0@baylibre.com>
Date: Wed, 17 Apr 2024 21:27:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: gcc@gcc.gnu.org, binutils@sourceware.org, gdb-patches@sourceware.org,
 libc-alpha@sourceware.org, Chung-Lin Tang <cltang@baylibre.com>,
 andrew@reenigne.org, Yao Qi <qiyaoltc@gmail.com>
From: Sandra Loosemore <sloosemore@baylibre.com>
Subject: Deprecation/removal of nios2 target support
Cc: Dinh Nguyen <dinguyen@kernel.org>, qemu-devel@nongnu.org,
 newlib@sourceware.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=sloosemore@baylibre.com; helo=mail-il1-x129.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Apr 2024 01:36:08 -0400
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

Tomorrow I plan to push patches to mark the nios2 target as obsolete in 
GCC 14.

Background: Intel has EOL'ed the Nios II processor IP and is now 
directing their FPGA customers to a RISC-V platform instead.

https://www.intel.com/content/www/us/en/content-details/781327/intel-is-discontinuing-ip-ordering-codes-listed-in-pdn2312-for-nios-ii-ip.html

The Nios II hardware on loan from Intel that we were using for testing 
at Mentor Graphics/Siemens was returned around the first of the year. 
For some time we had been using QEMU to test the nios2-elf target, but 
we never had a QEMU test harness set up that would boot the Linux 
kernel, and user-mode QEMU on this target is too buggy/unmaintained to 
use for primary testing.  So the current situation is that none of the 
listed maintainers for any of the GNU toolchain components have access 
to a fully working test configuration any more, we have all moved on to 
new jobs and different projects, Intel has also moved on to a different 
platform, and our former contacts on Intel's Nios II team have moved on 
as well.  It seems like it's time to pull the plug.

Therefore I'd like to mark Nios II as obsolete in GCC 14 now, and remove 
support from all toolchain components after the release is made.  I'm 
not sure there is an established process for obsoleting/removing support 
in other components; besides binutils, GDB, and GLIBC, there's QEMU, 
newlib/libgloss, and the Linux kernel.  But, we need to get the ball 
rolling somewhere.

I did do some GCC testing on both ELF and Linux Nios II targets around 
the end of December and another round about a month ago, so I believe 
GCC 14 will pretty much be in working order.  Beyond that, though, I 
think it would be better to remove support promptly, rather than having 
it hang around in an unmaintained/untestable zombie state, getting ever 
more bit-rotten.

-Sandra

