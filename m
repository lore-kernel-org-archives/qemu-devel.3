Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4AEC52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsE6-0004GT-TT; Fri, 02 Aug 2024 09:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZsDl-00033G-6i
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sZsDj-0002lo-Ln
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722604881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZtWMul2/VEOhNTkdkl9SidPcnbfJN9l8hvPyRJRUJi8=;
 b=RhCpL4COt1GuGOOwKqxoPzWyDJOgtOpsO2YZctwasng0jKfzKjCo+MVIAWG+LMD3ZMTzO4
 hsysi1ypLYflZIwb2THyzIaCLisiL2XMp0bjLE1p9ygheWjYYQNTiQ+chCWhERCLXZ90bj
 lzfNWarZs/chQpWdbWEdewUUW/9YXQA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-E_jQbnAUNG6QEH5OrG9-fw-1; Fri,
 02 Aug 2024 09:21:18 -0400
X-MC-Unique: E_jQbnAUNG6QEH5OrG9-fw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 777AF1955F43; Fri,  2 Aug 2024 13:21:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42CFF1955D42; Fri,  2 Aug 2024 13:21:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5468821E668B; Fri,  2 Aug 2024 15:21:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Josh Junon <junon@oro.sh>
Cc: qemu-devel@nongnu.org,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathi?=
 =?utf-8?Q?eu-Daud=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qmp: Fix higher half vaddrs for [p]memsave
In-Reply-To: <ZqzK/Wja59qAjbCY@DESKTOP-TBGODF1.localdomain> (Josh Junon's
 message of "Fri, 2 Aug 2024 14:03:09 +0200")
References: <20240731135031.11260-1-junon@oro.sh> <87bk2b2ly4.fsf@pond.sub.org>
 <ZqzK/Wja59qAjbCY@DESKTOP-TBGODF1.localdomain>
Date: Fri, 02 Aug 2024 15:21:13 +0200
Message-ID: <87sevn12nq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Josh Junon <junon@oro.sh> writes:

> On Fri, Aug 02, 2024 at 01:39:15PM +0200, Markus Armbruster wrote:

[...]

>> I'd go for a much smaller solution: change the QMP commands to unsigned,
>> keep the HMP commands signed, with a silent conversion just like
>> hmp_memory_dump() & friends.
>> 
>
> Sounds good to me, thanks for the review!

You're welcome!  Looking forward to v2.


