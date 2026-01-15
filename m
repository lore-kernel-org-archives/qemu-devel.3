Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F13D46602
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 17:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgQt0-0005aV-O4; Thu, 15 Jan 2026 12:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgQsu-0005Un-PI
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:11:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgQsr-0000gT-Sm
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 12:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768497103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WpKAFbrbhw8Y3zbVA1Hx2kXD3Fm3q+LMlFbWFQ8qHzo=;
 b=glpHgoOI4xF73vigwFit7bNB1uzBw1ltdcKAq1C/fJglkhcg7vdcDdYxmShXJjRJ19fzzB
 lB8+N3wBTM80QlJAXD3cuSDoULdLlyfL/CAqRlV8UjXkKYJuslpgEFn5p0pIp11HpPwQ4Q
 QjgQyG5HIwlUKV4+xJ8jZArz/0d+GQo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-HqOaKE78OpGce0er6Ufuaw-1; Thu, 15 Jan 2026 12:11:41 -0500
X-MC-Unique: HqOaKE78OpGce0er6Ufuaw-1
X-Mimecast-MFC-AGG-ID: HqOaKE78OpGce0er6Ufuaw_1768497100
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b831e10ba03so171975766b.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 09:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768497100; x=1769101900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WpKAFbrbhw8Y3zbVA1Hx2kXD3Fm3q+LMlFbWFQ8qHzo=;
 b=nDMHDwAroXnONfZcFRrxLBvRCC9ntvDBTBiCU539hMJuPr1/mR8VM8cLxh4/Q0C7UZ
 Tmicu5kVe7AKRg4yHsu+LNrQZrhhh/mhZQDAAz/7MYorIaIhnoG4v5ozMDP3MgpGKbm5
 lOXkHUvUdd6nN4+XNRa5lFea3zVHFdR4mYYiBesbY6+pFwZklF61oJuqnixGJXgsaG9+
 F4Kyat5HH21j5dRuGC+eM84vTsSEtb8E69UqJWXSLczSBmdhDDGAU8E/6U6CCmK+ixS1
 r7y8JMvEOBbbTvscirCH3AsOELaQjNBKSgz8WuycNmd0Qy8dyPUOQaY6y/lKRfP8Q8qA
 Ygfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768497100; x=1769101900;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpKAFbrbhw8Y3zbVA1Hx2kXD3Fm3q+LMlFbWFQ8qHzo=;
 b=vw3ffCOyctHKtOXHKDR8CZTH6Q73HUi/ltWlbto7XsjqdV8SNVpEdz8mxpbnrgMbX0
 Gw156vgXsU1KzFwjubgxJubw5CWFBOIUa70SlXazeoD0AzP5cXzSOSzQnYSnW/6Q8S8p
 mt9/9R0nT9FfOs+pe4SX9lD+h8RQWidmMxs+4vL2RB5UAxCpxwYu0Vkpk/Gbk91hG/ay
 xFAqAchzFcMxivHhCBlCz5iKTehOKFne2kFueGYNOcHSNZs/fnjYZ4wZZ8WokooZAnh7
 2Qh6bCI53qlh8XaMethALNJVM0XNDmU2Z1Ykl5sfh27P26ijpEsgqEgZKvY5zqRWh2a5
 zKBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUasmZDoV+eUpcWedo3XalYjZqUeBTYHJFyUlxZWCrQeLI3yEWvIOnB9X7HRr4uBHE8TdayHHyCqER@nongnu.org
X-Gm-Message-State: AOJu0YyoBiZfo7BAKW0q/1kGtuZoimFwQJrsSvCxwJzav2DwE0Q6quEe
 AcqZpZ3YhAJGlniJUdpT80W7dvXNK0/WmDeyF3miDS5I0AOSfTtOao0XDZS7KVVESxBrsxxEThi
 lfNMjTd47oN+73l+IqpS4BmbV3yWgKC+QJg+Z2IqSU/zTYkQacpMbwaK2
X-Gm-Gg: AY/fxX4VoCb9jQMvUGGrhyLQAyFlLNG6A7rs4FWimKR4R0ytI+QiAQ6WOiXOMBOY30a
 RarqVuSVwOSkuzlGObrFJpo100G1tRTb0s8/3HFIRWcx7Qxnxik/qXesDo9tAWXYMlowjaz2vqg
 qcrx54YzDTZnamsTYcMPdhCdsUNaLwszapoSlG73UVadTS3EESL/JozceItzULkpFvnym2QFc2B
 fHDCCVvYOzSQ6Zomz9MJd20m/I2V6LgZkeil4wZlklz9HfCMef08viQDzpwccTMjPOEJYtMEEUI
 u6LG8fA9WfSwb6yG5DUwlikcW+YM5aY2RRRKF4sS2q93GJwMRpt235+9hbW8G3UfnOXj0dFf1kK
 56ZzEtbZhpKphGl5ygv0G9c+J8xRrez6fbotJt2wJk+ll0GTKuzF20dd5dFQ7lznzK6T+gEYaua
 CPMiIjscz75Ew=
X-Received: by 2002:a17:907:7255:b0:b87:c61:7d4a with SMTP id
 a640c23a62f3a-b8792df0114mr34972966b.29.1768497100248; 
 Thu, 15 Jan 2026 09:11:40 -0800 (PST)
X-Received: by 2002:a17:907:7255:b0:b87:c61:7d4a with SMTP id
 a640c23a62f3a-b8792df0114mr34970466b.29.1768497099834; 
 Thu, 15 Jan 2026 09:11:39 -0800 (PST)
Received: from [192.168.1.84] ([93.56.161.93])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b8793f5b20asm8007166b.20.2026.01.15.09.11.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 09:11:39 -0800 (PST)
Message-ID: <c8436397-fe56-4281-b9a4-5ed6175be055@redhat.com>
Date: Thu, 15 Jan 2026 18:11:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] scsi: persistent reservation live migration
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, pkrempa@redhat.com, Hannes Reinecke <hare@suse.de>,
 Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alberto Faria <afaria@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260113215320.566595-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260113215320.566595-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/13/26 22:53, Stefan Hajnoczi wrote:
> Live migration does not work for SCSI Persistent Reservations acquired on
> scsi-block devices. This patch series migrates the reservation key and
> reservation type so that the destination QEMU can take over the persistent
> reservation with the PREEMPT service action upon live migration.
> 
> The approach involves snooping PERSISTENT RESERVE OUT replies and tracking the
> scsi-block device's current reservation key and reservation type. In most cases
> this involves no additional SCSI commands. This approach isn't perfect: if
> another machine modifies the reservation on the physical LUN, then QEMU's state
> becomes stale. Persistent reservations are inherently cooperative, so this is
> acceptable as long as real applications don't run into problems.

One issue is that this would not transfer reservations done from a 
previous invocation of the VM.  Are you assuming that the restarted VM 
won't assume to still have the reservation?  I think this is fine, but 
it has to be documented, or maybe QEMU could issue a PR IN command at 
startup?

> I am also working on a test suite called pr-tests that runs sg_persist(8)
> commands across multiple machines in order to exercise various scenarios:
> https://gitlab.com/stefanha/pr-tests

Thank you so much for that!

Paolo


