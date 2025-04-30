Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113E6C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 20:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAEGk-00074A-Uz; Wed, 30 Apr 2025 16:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uAEGj-00073q-Md; Wed, 30 Apr 2025 16:43:01 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uAEGh-00068k-VB; Wed, 30 Apr 2025 16:43:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1746045752; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Lo+qTLoLk+XAuF5oADrlutxOjTftIx6TFBT3AHutnbIiizPle8x89Mwt0tpzhUo8AxJ1XZF097YST9qcTI4o/s6Dc00FM7aB0Y4Dsm/O+vhheZAufVE7o11Cgzy4uz39MxKOZdI5Ztd2jKhVqkZHoTWYFTPr0eqdm2fkMCHG9Wk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1746045752;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=+HMxDXM5EmWDfyjI7iKIounzo7KJUdVYfrDEQXDLqp4=; 
 b=QkkfH1VyGfxXgerLU9CI8YWow7DKoyEX2Ye0oCEZq0Io0zu+yF18qgoSTrenYoAYk1nQfkPb856Yi9tnLGP64QlymZ/9N62DTnjoASeGSlDgQvoL/chgcJE95TwGM2AHukwTbkaG/tSlINgrKYjKPIql6Pn+qdi0Ee5RqMXrTYc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746045752; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=+HMxDXM5EmWDfyjI7iKIounzo7KJUdVYfrDEQXDLqp4=;
 b=AlbR55JKTuzhr6PhK8Xbe3U/sB847b1ly/eIVv170l1KYfmJNoeoumjMrEeaIoXt
 keMDm7Pv55bgmHHwOT76/Mj/H9jpfb5r85BNu1+03AoNYnoTKgIRSH5uH6b8FzckcX0
 lXWX0FxPLQjQQTnCUqI7kQ6sicDy11jyUnJ+t5/0=
Received: by mx.zohomail.com with SMTPS id 1746045749756451.6561705597459;
 Wed, 30 Apr 2025 13:42:29 -0700 (PDT)
Message-ID: <ef6d541b-6ff5-4783-a05a-5d8962ad8e3d@collabora.com>
Date: Wed, 30 Apr 2025 23:42:24 +0300
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
 <33ae8cd5-cc5c-4bfd-9c0b-dd71b80dfc0b@collabora.com>
 <87ikmm2bgt.fsf@draig.linaro.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87ikmm2bgt.fsf@draig.linaro.org>
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

On 4/30/25 13:24, Alex Bennée wrote:
>> On 4/30/25 00:19, Alex Bennée wrote:
>>>> This change makes QEMU to crash.
>>> What is your command line to cause the crash?
>> I applied this patch on top of native context v11, ran AMD nctx and
>> got a crash on SDDM startup.
> Did you also include the pre-cursor patch which splits MemoryRegion out
> of the container struct. The aim here is to allow MemoryRegion counting
> to be handled without worrying about other structure lifetimes.

Very good catch, I indeed missed that other patch. Reapplied all the
patches and QEMU doesn't crash anymore. Now the code changes look sane
to me.

Will be great if Akihiko Odaki could comment too.

-- 
Best regards,
Dmitry

