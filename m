Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC813C0218D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 07:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdlpb-0003Cw-Lz; Fri, 31 Jan 2025 02:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tdlpZ-0003Cc-Cn
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 02:52:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tdlpX-00036Q-TL
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 02:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738309966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=krdwjaNue0HJycpy6WgVdfmNnHErZC38/M4PNTarUVA=;
 b=bDbTIHOuXbiphO+Gjc8lzIJlPGo/7EoaZjh/qQ9FBRCKACqGbJ0nqaXS9vaf2DtbCW3zp+
 3zW1cGTtDMiBj88RLntUix2DDp+nRTYWADpHo0n0iqm0uNbcHrIEleTeze/3VBn3jQ2xhq
 dCSbXnHSaZkGpOT8ywLklhk6QvBnFWU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-J_Hce5COPL-rnYEP9WxWGw-1; Fri,
 31 Jan 2025 02:52:39 -0500
X-MC-Unique: J_Hce5COPL-rnYEP9WxWGw-1
X-Mimecast-MFC-AGG-ID: J_Hce5COPL-rnYEP9WxWGw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E776A180035E; Fri, 31 Jan 2025 07:52:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.71])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 557B51800975; Fri, 31 Jan 2025 07:52:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5781421E6A28; Fri, 31 Jan 2025 08:52:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-block@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Bin Meng
 <bmeng.cn@gmail.com>,  Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH 10/11] hw/sd: Remove unused legacy functions, stop
 killing mammoths
In-Reply-To: <20250128104519.3981448-11-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 28 Jan 2025 10:45:18 +0000")
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-11-peter.maydell@linaro.org>
Date: Fri, 31 Jan 2025 08:52:34 +0100
Message-ID: <87o6zno1x9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The sdcard_legacy.h header defines function prototypes for the "legacy"
> SD card API, which was used by non-qdevified SD controller models.
> We've now converted the only remaining non-qdev SD controller, so
> we can drop the legacy API.
>
> Entirely unused functions:
>   sd_init(), sd_set_cb(), sd_enable()
>
> Functions which now become static inside sd.c (they are the
> underlying implementations of methods on SDCardClass):
>   sd_do_command(), sd_write_byte(), sd_read_byte()
>
> Removal of sd_init() means that we can also remove the
> me_no_qdev_me_kill_mammoth_with_rocks flag, the codepaths that were
> only reachable when it was set, and the inserted_cb and readonly_cb
> qemu_irq lines that went with that.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Very much appreciated!

Reviewed-by: Markus Armbruster <armbru@redhat.com>


