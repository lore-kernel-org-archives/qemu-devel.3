Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D53AF33806
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 07:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2OXd-0003V9-UG; Tue, 17 Mar 2026 03:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2OXb-0003Ub-Gx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 03:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2OXZ-0003E8-E5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 03:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773731311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4D74xfK6NlrVIH9KPxrbCJcarQ4coinPVQW2Pvqbdb4=;
 b=iIkzdu+YZ65jyC1m4MsHvrowVP8mcS7TjoSFAquBBeFff55Dya/Q3j03+NvY+YxUu+F0YS
 Ka2DiE+OJOAUzN8Wb1CxFPol5RqurJ6kv8LGB8lnNfsfATVIWsadJULCL/yN9GVz8S+khh
 8C4V/mPN6YLShJUwPIZnXoy+BG53RPk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-F1cSvxEMPiCPJdfEaVZjQw-1; Tue,
 17 Mar 2026 03:08:29 -0400
X-MC-Unique: F1cSvxEMPiCPJdfEaVZjQw-1
X-Mimecast-MFC-AGG-ID: F1cSvxEMPiCPJdfEaVZjQw_1773731308
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AD1F18005B4; Tue, 17 Mar 2026 07:08:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E2A71800361; Tue, 17 Mar 2026 07:08:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 23C1921E6937; Tue, 17 Mar 2026 08:08:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  berrange@redhat.com,
 mst@redhat.com,  pbonzini@redhat.com
Subject: Re: [PATCH v2 2/2] hw/qdev: Remove qdev_get_human_name()
In-Reply-To: <20260311215003.664815-3-alessandro@0x65c.net> (Alessandro
 Ratti's message of "Wed, 11 Mar 2026 22:50:03 +0100")
References: <20260311215003.664815-1-alessandro@0x65c.net>
 <20260311215003.664815-3-alessandro@0x65c.net>
Date: Tue, 17 Mar 2026 08:08:25 +0100
Message-ID: <87h5qflyqe.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Alessandro Ratti <alessandro@0x65c.net> writes:

> Remove qdev_get_human_name() and switch its two callers in
> hw/block/block.c to qdev_get_printable_name().
>
> qdev_get_printable_name() subsumes qdev_get_human_name(): both
> return the device ID when set and fall back to the canonical QOM
> path, but qdev_get_printable_name() also tries the bus-specific
> device path first, providing more informative output.
>
> Narrow the scope of dev_id in blk_check_size_and_read_all() to the
> blocks where it is actually used.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>

This replaces two ways to describe a device to the user by one.  Good.

One half of the uses is unchanged.  Good.

The other half can now show a bus-specific device path instead of the
canonical QOM path.  This path can be difficult to interpret: we have
some twenty .get_dev_path() methods, and each of them can format however
it wants.  I need to guess the format to make sense of the value.  I'm
inclined to call this a regression.

To address this, please insert another patch before this one that
changes

        device <dev-path>

  to

        <bus> device <dev-path>

This removes the guesswork, and actually satisfies the claim "more
informative output".

If you have reasons to do it in a follow-up patch instead, explain them
briefly.

qdev_get_human_name() is a better name than qdev_get_printable_name().
Please consider renaming the function so we keep the better name.


