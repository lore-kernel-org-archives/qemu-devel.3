Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B770CFA44E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 16:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3eHD-0001uu-Vp; Wed, 23 Oct 2024 12:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3eGz-0001ts-J4
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:32:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3eGx-0007Yk-Hj
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729701105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nuvNCQcNrF3eTs0ls4fjtXiQkkF3W3daXvRmW7kt4O8=;
 b=cch7YXmWuR35cQbtD4XdyzOVotc4AgUng0JCXk67OzJd3clo+tUkzIYda+/1HZqJ6eThAE
 SPGCyi+EWKyUfM2G9/C1rooSOWbWK9PakJ0ip1En6qxcbcSEDCVT1XB7wnKchGYzKIj/s2
 xnCJxn8l5IEjoDLWo5s1IVODEKJZ2WU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-GRuU1e5OMc2MkKmzJ5q51Q-1; Wed, 23 Oct 2024 12:31:42 -0400
X-MC-Unique: GRuU1e5OMc2MkKmzJ5q51Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d504759d0so4499884f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 09:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729701101; x=1730305901;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nuvNCQcNrF3eTs0ls4fjtXiQkkF3W3daXvRmW7kt4O8=;
 b=h1bbevkkoxcrswhJzBYxUEIXtSlXbaxZ6tzn1fbXFhR+gwTnOLGTJuEqzFpKoFn0uD
 ISOE8whQOm0eKeerZAtN3qpkl14TMysCjJi3cRsY714d8kXbom3fl5fPgx/6tf9fTWER
 9hvgfPNMQqc4BjCoCDYs9j7SKWHq77BCuzrKmthsUkbcsmBFwq2baRBVS3Q6LD9OAmFw
 AL06UZU7wRO3xmOm55aBUdfub/bEjACDOze76psj0/mtlraLqOW++op4eBOCZFY7Q7Zi
 ZbqJW4mZG7lU7YwGYinZd3xdm+jgM4xsJ898OlsMEaGjGjXzzwuAWiZzxnsASVminCng
 EzVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/G/qDYE9Xlcll5cmHdXEMX09/OsjOc/8yBFiqVeO+yi/HO4+HKFGYDeNqyi6nYVDs7DhUti5FM1cc@nongnu.org
X-Gm-Message-State: AOJu0YyeMrCNb32/xvF3ukEwUMNpdLNY5OWEiO3lXzfUhh7yei0FCPj2
 1zcgWJuDf0WmhIKdWBRut4XUyKUes7JOWuA27i0ntrp5JeLrciw22n4qIAN2PQs+G7NTy4LJ213
 VpTO4buQ7oLDygzf0BAiMrT8rpDOQ6LrOqdCub5+UneArzftzzf2p
X-Received: by 2002:adf:8bdd:0:b0:37c:cdbf:2cc0 with SMTP id
 ffacd0b85a97d-37efcf8d06cmr2455242f8f.53.1729701101451; 
 Wed, 23 Oct 2024 09:31:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC7s8h0w4j8Rl7taz28pzD1AZaChilFK8QeTaEPQwLzyuXVKCxHfFTCfVI19N9JVpZo1tzww==
X-Received: by 2002:adf:8bdd:0:b0:37c:cdbf:2cc0 with SMTP id
 ffacd0b85a97d-37efcf8d06cmr2455213f8f.53.1729701100951; 
 Wed, 23 Oct 2024 09:31:40 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.144.54])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9bac3sm9226050f8f.94.2024.10.23.09.31.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 09:31:40 -0700 (PDT)
Message-ID: <b36283ff-2e14-4ee0-a64e-a5c4f9e86534@redhat.com>
Date: Wed, 23 Oct 2024 18:31:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 00/14] precreate phase
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On 10/17/24 17:14, Steve Sistare wrote:
> Define a new qemu initialization phase called 'precreate' which occurs
> before most backends or devices have been created.  The only exception
> is monitor and qtest devices and their associated chardevs.
> 
> QEMU runs in the main loop during this phase.  Monitor connections are
> active and can receive migration configuration commands.  QEMU starts
> listening on the normal migration URI during this phase, which can come
> from either the QEMU command line or from a migrate_incoming command.
> Thus the user can issue query-migrate to get the socket-address for
> dynamically allocated port numbers during precreate.
> 
> In this series QEMU passes through and does not linger in the precreate
> phase, and the user sees no change in behavior.  The cpr-transfer series
> will linger in the phase for an incoming CPR operation, and exit the phase
> when the migrate command is send to source QEMU and causes destination QEMU
> to read CPR state.
> 
> A future series may wish to add a command-line argument and monitor
> command that enters and exits the precreate phase for general purpose use.
> That would enable the user to issue monitor commands that specify backend
> creation parameters.

I have a problem with the concept, which is that the split between 
command line and monitor is much harder to understand.

Ideally, one would come entirely before the other; preconfig is already 
ugly in how -device is processed later than everything else[1].  This 
series makes this much more complex.

If I understand correctly, what you want is effectively to execute 
monitor commands from the migration stream.  If you want to do that, we 
need to take more qemu_init code and turn it into QMP commands, so that 
precreate can exit qemu_init very early and the "after precreate" 
command line options can be replaced by interactions on the monitor.

This is the idea that drove the creation of -M smp.xxx, -M boot.xxx, -M 
memory.xxx, etc. (see for example commit 8c4da4b5218, "machine: add boot 
compound property", 2022-05-12).  For example -semihosting-config, 
-acpitable, -smbios, -fw_cfg, -option-rom, -rtc could all become -M 
properties and handled by a single monitor command machine-set.

Of all the other options, -accel, -cpu and -display are the main missing 
ones (-cpu is the very hard one); a full list is at 
https://wiki.qemu.org/User:Paolo_Bonzini/Machine_init_sequence#QMP_configuration_flow.

Anyhow, at this point all that's needed is a -chardev/-mon pair (and I 
guess -incoming defer) in order to bootstrap the monitor in precreate mode.

It's okay to prototype without full support for the options I've listed, 
but if we want to go with precreate we should make most command line 
options entirely incompatible with it, and also make it imply -nodefaults.

Paolo

[1] -loadvm and -incoming too; but for those two we could make their 
monitor commands exit preconfig mode automatically, and invoke them from 
the monitor instead of specifying them on the command line.


