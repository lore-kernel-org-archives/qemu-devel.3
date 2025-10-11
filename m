Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28A2CCD183
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 04:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7RSo-0000bn-CD; Sat, 11 Oct 2025 00:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v7RSm-0000bc-NV
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 00:44:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v7RSk-0001LF-0T
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 00:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760157844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h4DTwhvXjqw8MBUCQCAAzGh7ddJ72oJQP6qmTB0us5Y=;
 b=i8B2yajBcjZHdtbihnEwYK+D0uv6FbTKP6WU6EDrcMFvJnAJWr0XoREBtvs8TCSZINXdpt
 +6zeo/WHzn7HfjQCpUqIYLuNG1PQB9DiSeSX4AM49BffX6eXCStAbpf4Y+GrIsUyvtdM1y
 rNaOe7mE/YpWOMn/OIr1op9rVSHU4fc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-IBSYyxapOi6-_MtNVpfgTA-1; Sat,
 11 Oct 2025 00:44:00 -0400
X-MC-Unique: IBSYyxapOi6-_MtNVpfgTA-1
X-Mimecast-MFC-AGG-ID: IBSYyxapOi6-_MtNVpfgTA_1760157839
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 815431800452; Sat, 11 Oct 2025 04:43:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D83F1955F42; Sat, 11 Oct 2025 04:43:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9136C21E6A27; Sat, 11 Oct 2025 06:43:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>,  qemu-devel@nongnu.org,  Paolo
 Bonzini <pbonzini@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Fabiano Rosas
 <farosas@suse.de>,  Eric Blake <eblake@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3] hw/uefi: add "info firmware-log" +
 "query-firmware-log" monitor commands
In-Reply-To: <aOlrRNIUijmj1V4Q@gallifrey> (David Alan Gilbert's message of
 "Fri, 10 Oct 2025 20:23:32 +0000")
References: <20251010071008.2555267-1-kraxel@redhat.com>
 <87ecrbj85s.fsf@pond.sub.org> <874is6fyl7.fsf@pond.sub.org>
 <aOlrRNIUijmj1V4Q@gallifrey>
Date: Sat, 11 Oct 2025 06:43:54 +0200
Message-ID: <87347qdp4l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

"Dr. David Alan Gilbert" <dave@treblig.org> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:

[...]

>> Moreover, it happily prints control characters even without
>> handle_ovmf_log_range() fixed.
>> 
>> If the log is ASCII (see below), you could use g_strescape().  Copies
>> the string on the heap yet again.  Meh.
>
> That's probably the wrong thing for hmp; you want cr,lf and maybe tabs
> to pass straight through - you want a log to be correctly line formatted;
> you just want to stop nasties getting through.

Use the @exceptions argument.


