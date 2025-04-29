Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF486C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 21:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9sTv-0004k0-Vo; Tue, 29 Apr 2025 17:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1u9sTl-0004if-23; Tue, 29 Apr 2025 17:27:01 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1u9sTi-0007Vd-Rv; Tue, 29 Apr 2025 17:27:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1745961996; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eB4VYw7y972t0cvMk/NfEmef4dGf7lGFGv1dFwfR0goulyQFgC9TzhFXvzXS/4WIDVR2MXvGFdjy4j3Dupkxu/gcJEYTTeNkngusoDB9Lii+86VVIkpYX9L3i5Bse4NoAp9N3WBK3D2vuV6BepDdhBhwM93pKMQDZh/m6okHRs8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1745961996;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=n5glU0FlvTlvVa30Iq18L5A5JJTQ2PT2eof4gDYLDqU=; 
 b=AqZn+px0cWs/6H0aH6bHnVyr4xzqWfibHVYKsiWO4A9ZfKbCQ7XW8fxraJ5KQSQWIvrqkP3hUp9zy3PqDL+U+Zi5rHyz+BIMrsTG+lxJB0kx+bP7toOa3FsAJ4TulyCKzr/kdz45d9ap9clE/hF3uyFjyN2quSRskS/WTZyWVFA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745961996; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=n5glU0FlvTlvVa30Iq18L5A5JJTQ2PT2eof4gDYLDqU=;
 b=dv5MyZhEbExyxpNjqCIvy0Q1WUDoleraMk99RcWtNBSWTI6bJGkJJiyTCpcb1+Q2
 ost9kdmFhk58cw1tmBXm4X5J6DfBCZ73tbJIp2HnkSKdbf+hmJ/AAngwpwo4V5RmxPU
 GyAD8ZFzyWBKGjXoWF4GHuNFmvkb/0QOKjqcO2uE=
Received: by mx.zohomail.com with SMTPS id 1745961995758660.1143623261877;
 Tue, 29 Apr 2025 14:26:35 -0700 (PDT)
Message-ID: <33ae8cd5-cc5c-4bfd-9c0b-dd71b80dfc0b@collabora.com>
Date: Wed, 30 Apr 2025 00:26:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] virtio-gpu: fix hang under TCG when unmapping blob
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-stable@nongnu.org
References: <20250428125918.449346-1-alex.bennee@linaro.org>
 <20250428125918.449346-9-alex.bennee@linaro.org>
 <8b123991-21f2-47b5-851d-6b53fbfaa691@collabora.com>
 <87o6we3bto.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87o6we3bto.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/30/25 00:19, Alex Bennée wrote:
>> This change makes QEMU to crash.
> What is your command line to cause the crash?

I applied this patch on top of native context v11, ran AMD nctx and got a crash on SDDM startup.

(gdb) bt
#0  0x00007ffff5411b54 in __pthread_kill_implementation () at /lib64/libc.so.6
#1  0x00007ffff53b8f9e in raise () at /lib64/libc.so.6
#2  0x00007ffff53a0942 in abort () at /lib64/libc.so.6
#3  0x00007ffff6cbf18c in g_assertion_message[cold] () at /lib64/libglib-2.0.so.0
#4  0x00007ffff6d2ea07 in g_assertion_message_expr () at /lib64/libglib-2.0.so.0
#5  0x0000555555a42820 in object_finalize (data=0x555557c9d290) at ../qom/object.c:732
#6  object_unref (objptr=0x555557c9d290) at ../qom/object.c:1231
#7  0x00005555559f3df3 in memory_region_unref (mr=<optimized out>) at ../system/memory.c:1854
#8  0x0000555555a003a7 in phys_section_destroy (mr=0x555559ef5b60) at ../system/physmem.c:1035
#9  phys_sections_free (map=0x555559c2dd80) at ../system/physmem.c:1048
#10 address_space_dispatch_free (d=0x555559c2dd70) at ../system/physmem.c:2692
#11 0x00005555559f1d33 in flatview_destroy (view=0x55555a54a720) at ../system/memory.c:295
#12 0x0000555555c278cf in call_rcu_thread (opaque=opaque@entry=0x0) at ../util/rcu.c:301
#13 0x0000555555c1cc68 in qemu_thread_start (args=0x555557993d30) at ../util/qemu-thread-posix.c:541
#14 0x00007ffff540fba8 in start_thread () at /lib64/libc.so.6
#15 0x00007ffff5493b8c in __clone3 () at /lib64/libc.so.6

-- 
Best regards,
Dmitry

