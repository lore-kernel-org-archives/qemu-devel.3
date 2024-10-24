Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E934D0BB46
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 00:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3lUc-0004Sm-NO; Wed, 23 Oct 2024 20:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1t3lUb-0004SY-Lg
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 20:14:21 -0400
Received: from fly.ash.relay.mailchannels.net ([23.83.222.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1t3lUa-0003TW-2m
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 20:14:21 -0400
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id C93E28A2BAB;
 Thu, 24 Oct 2024 00:14:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a206.dreamhost.com
 (trex-6.trex.outbound.svc.cluster.local [100.103.23.198])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 410B08A17AC;
 Thu, 24 Oct 2024 00:14:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729728857; a=rsa-sha256;
 cv=none;
 b=a117MtdDBM4c+Wy9+jDZYazKyvJNICJ7hQVRIFpB/EZyxSkLj9COJT3lG0TfBWshbnAdfq
 dMBad/HIlIEioSTL7gwijtKbro0KO0wjJsl9CZpGGShBERN7PmBmr0OhHK02OgF7EKtW4m
 dwhEyNtWDt4tUdJaBqBctTMzCTjkDBydEt8HAX6zjJpYhrma5YbpAo4tVMY3X52r/i4AiR
 IK3MlCek5ytZ0Q75PgiK3CzIexkBY7B6frzCERxvIvAtVVFdNMjcidsnOJyinNaNa+h418
 PwsQYQQ0fVShI+AAptO2kO9YQd5M6vedGir58DoYpQ8d2+F76u71J5oiW3jiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1729728857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=lSsJvYgO+gwEFxP4+OSxaH6HaagzNPQXB5fDQYXmkRY=;
 b=0KmowBnlp7zXCI2tIIyAVnEIGYMJDwiUUe2oMamfGy3QFch1o1NviT1LeNcRD2kSmb3t+j
 LOLkN+x8YZvRzkHsuFQvvAVCbr6UhvKeY9OeZxujYtbGLs7LbfZ+JAOGqvndQL3LHy/dn9
 NFiIMBE29NA0A8SFlBRVE/tbVcXU5bNjArKfugr5U9Jw9fxlZ0kyzf3TCybokflmEffDKn
 oaBk0mBiXXgVgmWNM5jiLLzztfz70nuhKnaK0l2Lh+K6rM17aAPv1WxGkRM5pLX6fLf5RR
 rV88iulN5A3I5uIeg7Z07FB/GmcR3jkRINkLK3kXqeKuWkrBklXx6/ugvIsUlg==
ARC-Authentication-Results: i=1; rspamd-9bc7b7997-6gbcn;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Dime-Chemical: 38617e924eed8f1d_1729728857574_1811641741
X-MC-Loop-Signature: 1729728857574:3466480258
X-MC-Ingress-Time: 1729728857573
Received: from pdx1-sub0-mail-a206.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.103.23.198 (trex/7.0.2); Thu, 24 Oct 2024 00:14:17 +0000
Received: from [172.22.7.54] (unknown [198.232.126.195])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a206.dreamhost.com (Postfix) with ESMTPSA id 4XYmcS4kSBzDh; 
 Wed, 23 Oct 2024 17:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1729728857;
 bh=lSsJvYgO+gwEFxP4+OSxaH6HaagzNPQXB5fDQYXmkRY=;
 h=Date:Subject:From:To:Content-Type:Content-Transfer-Encoding;
 b=VgioahnYSjPpZbpr2+Wr2Vq6gpXM1ugAGgcMHQ9w1yYH1HCDM6qx71HpDXXkfNuq/
 xsUgoneU/tejS6PCRs8ZhkosLZzlXnz+D0ChBtMPjAj/F408VpJK9T3mYe9zgzBbLy
 OTxZrwGerzKgdcfernOIEp4gNmXXql1rKhId/Z7KtJzw3WHZmlA3ge3rw3uwRNf405
 +WwcY4vMC05g8ik9vjBgxpmTOvbYfhjKsVZGj2JA1MhFmYvq78i3D8YKJsbuV9Tlgo
 LHRLC7ObXRJUdSSvlefHPyHQXA84yx5Akk76qZ35Bhc7AmetFaxcaj6YIcC4PFzqz8
 TEp+kUS8iaFQQ==
Message-ID: <d8763fb6-04e3-463d-944b-5608e8250649@landley.net>
Date: Wed, 23 Oct 2024 19:14:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please put qemu-system-sh4eb back.
From: Rob Landley <rob@landley.net>
To: qemu-devel@nongnu.org, thuth@redhat.com, jeff@coresemi.io,
 peter.maydell@linaro.org, glaubitz@physik.fu-berlin.de
References: <d6755445-1060-48a8-82b6-2f392c21f9b9@landley.net>
Content-Language: en-US
In-Reply-To: <d6755445-1060-48a8-82b6-2f392c21f9b9@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=23.83.222.61; envelope-from=rob@landley.net;
 helo=fly.ash.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/23/24 19:11, Rob Landley wrote:
> There was a big-endian issue breaking r2d last year, but it also broke 
> big endian mips and some other targets too, and it got fixed. The binary 
> I built a few months ago was working fine for me with vanilla qemu git 
> source? (I don't _think_ I had local changes?) I can try to build the 
> version removed to check that...

I did

$ git checkout 73ceb12960e6^1
$ ./configure --target-list-sh4eb-softmmu
$ make

And the resulting qemu-system-sh4eb booted my system image to a shell 
prompt:

# cat /proc/version
Linux version 6.11.0 (rob@j180) (sh4eb-linux-musl-cc (GCC) 11.4.0, GNU 
ld (GNU Binutils) 2.33.1) #1 Wed Oct 23 23:44:11 UTC 2024
# cat /proc/cpuinfo
machine         : RTS7751R2D
processor       : 0
cpu family      : sh4eb
cpu type        : SH7751R
cut             : unknown
cpu flags       : fpu ptea
cache type      : split (harvard)
icache size     :  4KiB (2-way)
dcache size     :  4KiB (2-way)
address sizes   : 29 bits physical
bogomips        : 120.00


