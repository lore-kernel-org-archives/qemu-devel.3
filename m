Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EBDE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 06:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVlg1-0005QP-8Q; Thu, 09 Jan 2025 01:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVlfz-0005QD-Lj
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:05:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVlfx-0006Yo-38
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736402744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jjFwD84w9TKLHPWBSC8awmF0Q/QKZj/IX0azJO1E2tg=;
 b=hf3buvo+NtCx0G2+oxOlLflSe9AQqPRMxQMf7+okghzTHgbaXd/Whah7ftWeCUX1SwuuUf
 YJIxecPShTnwBlhL0l8vubySSHeOGEZ4Bnc6DtwbwaViWY0n6LTt1lwoEe123CaWlOExIF
 Tb2Z5F1gdwP+c9kQM3dsZYk4Uc5EtDw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-OThFrfeQN06MvsZa7sGlgg-1; Thu,
 09 Jan 2025 01:05:39 -0500
X-MC-Unique: OThFrfeQN06MvsZa7sGlgg-1
X-Mimecast-MFC-AGG-ID: OThFrfeQN06MvsZa7sGlgg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 506D519560B8; Thu,  9 Jan 2025 06:05:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B5B519560AB; Thu,  9 Jan 2025 06:05:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0949E21E6924; Thu, 09 Jan 2025 07:05:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Jason Wang
 <jasowang@redhat.com>,  Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,  Luigi Rizzo
 <rizzo@iet.unipi.it>,  Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,  Andrew Melnychenko
 <andrew@daynix.com>,  Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/3] virtio: Convert feature properties to OnOffAuto
In-Reply-To: <20250108135204-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Wed, 8 Jan 2025 13:53:00 -0500")
References: <20250104-virtio-v3-0-63ef70e9ddf3@daynix.com>
 <20250108135204-mutt-send-email-mst@kernel.org>
Date: Thu, 09 Jan 2025 07:05:34 +0100
Message-ID: <87cygwv7wx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Sat, Jan 04, 2025 at 04:36:04PM +0900, Akihiko Odaki wrote:
>> This series was spun off from:
>> "[PATCH 0/3] virtio-net: Convert feature properties to OnOffAuto"
>> (https://patchew.org/QEMU/20240714-auto-v3-0-e27401aabab3@daynix.com/)
>> 
>> Some features are not always available with vhost. Legacy features are
>> not available with vp_vdpa in particular. virtio devices used to disable
>> them when not available even if the corresponding properties were
>> explicitly set to "on".
>> 
>> QEMU already has OnOffAuto type, which includes the "auto" value to let
>> it automatically decide the effective value. Convert feature properties
>> to OnOffAuto and set them "auto" by default to utilize it. This allows
>> QEMU to report an error if they are set "on" and the corresponding
>> features are not available.
>> 
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> Changes in v3:
>> - Rebased.
>> - Link to v2: https://lore.kernel.org/r/20241022-virtio-v2-0-b2394236e053@daynix.com
>> 
>> Changes in v2:
>> - Expanded the message of patch "qdev-properties: Accept bool for
>>   OnOffAuto".
>> - Link to v1: https://lore.kernel.org/r/20241014-virtio-v1-0-e9ddf7a81891@daynix.com
>
>
> Markus I think you had feedback on previous versions of this?

I'll reply to v4.  Thanks!


