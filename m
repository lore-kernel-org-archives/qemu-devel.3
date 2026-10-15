Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB8CCC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHEUS-0004si-AJ; Thu, 15 Oct 2026 01:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xHEUE-0004RJ-F5
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 01:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xHEU9-0003NX-RG
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 01:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792043917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E04oSt2xWcAhVwrGg4kgJO4kom9aicAhyFCu/pghkgM=;
 b=FArOsy/bSme6jXv7Th1aUl4ZCPhI29da3Zqjy4Cn7jM6Qv3YX9X3g5BMDHbsKjRQYGjmIJ
 9V15DwNua2YbpI2UlT23Lzzx/Ema7HghshZjtSMXFe30/wVAqYZ2vtBklCTq6be0e5czoN
 m64kk6/UbUeEefhpnQ85zk5+mPTqwsk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-G8rDuI_vOqG6zwRIKxSjRg-1; Thu,
 15 Oct 2026 05:58:33 +0000
X-MC-Unique: G8rDuI_vOqG6zwRIKxSjRg-1
X-Mimecast-MFC-AGG-ID: G8rDuI_vOqG6zwRIKxSjRg_1792043912
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8954D180049F; Thu, 15 Oct 2026 05:58:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44E4126C; Thu, 15 Oct 2026 05:58:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A87CF21E6A04; Thu, 15 Oct 2026 07:58:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/8] multi-target: remove qmp_query_cpu_definitions
 duplication
In-Reply-To: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Thu, 15 Oct 2026 00:53:47 +0000")
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 07:58:29 +0200
Message-ID: <87bj8vbj3u.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> This series allows to link multiple targets that define
> qmp_query_cpu_definitions. It simply replaces the duplicated definitions with
> target-specific ones and a single dispatcher. We didn't use yet the dispatcher
> pattern, and it's the first situation where it appears to be a good fit.
>
> A possible alternative would be to introduce this callback directly at
> target-info level, which I think is a less desirable solution, since it would
> ties this API to monitor.

I'm curious... why would such a tie be undesirable?

> If the approach here is accepted, I'll extend this series with
> qmp_query_cpu_model_expansion which follows the same pattern.
> With this, we'll be free to link together almost all the base architectures.

Series
Acked-by: Markus Armbruster <armbru@redhat.com>


