Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18244FCD0C1
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 06:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2kTu-0005cj-1d; Wed, 18 Mar 2026 02:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2kTr-0005cQ-79
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 02:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2kTp-00088S-Vc
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 02:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773815649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DF2ZYICOIpBxRZ3y49CRf6yo4609ITpUBm0TZHro7WY=;
 b=ho7xSFm5gYEL4mg6Ck2327pXDIeG7Ykg3ZDh6L2R7zxyjo9ZonwPc7SBlIG4GbbKLdRXrb
 S01hsjcESX0dxbrZc/U7S9Z/EumvmW3U25My/mg3pte5ePyjxLFOQMWtagGsKhf+UbGw2t
 gzElzQ+ybe836jehW0H6XmIDauJfbbQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-E0bcqTzDP_KJObVOq9K6cg-1; Wed,
 18 Mar 2026 02:34:05 -0400
X-MC-Unique: E0bcqTzDP_KJObVOq9K6cg-1
X-Mimecast-MFC-AGG-ID: E0bcqTzDP_KJObVOq9K6cg_1773815644
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CC2F180058A; Wed, 18 Mar 2026 06:34:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD41F1800763; Wed, 18 Mar 2026 06:34:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7289F21E6937; Wed, 18 Mar 2026 07:34:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  berrange@redhat.com,
 mst@redhat.com,  pbonzini@redhat.com
Subject: Re: [PATCH v2 2/2] hw/qdev: Remove qdev_get_human_name()
In-Reply-To: <87bjglsl3z.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 18 Mar 2026 07:33:04 +0100")
References: <20260311215003.664815-1-alessandro@0x65c.net>
 <20260311215003.664815-3-alessandro@0x65c.net>
 <87h5qflyqe.fsf@pond.sub.org>
 <CAKiXHKd15rFWk3qM+f_X2JXr29u1ygTumCcGrm9iDLEtwALQNQ@mail.gmail.com>
 <87bjglsl3z.fsf@pond.sub.org>
Date: Wed, 18 Mar 2026 07:34:01 +0100
Message-ID: <87341xsl2e.fsf@pond.sub.org>
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

Ignore this one, butterfingers.  Complete reply coming.


