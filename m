Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FC1C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7H3b-0005VO-TU; Thu, 17 Sep 2026 14:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7H3Y-0005V0-VT
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7H3W-0003Q1-Vh
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789670517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2cyPmb7kFZiESRgdwaY5bmXjpVignqJ9p6QHloonvDU=;
 b=D4yygrvX3U9Q8RzRywpxK/4OS1prs6dP1MWOcfUMsxcsEXQo7Pri/sjrFxvXK+Ml8Up1lk
 Xm/oWHmbPmHtadwYJn/vczhRnvgBWOCOcZJ7QYVonmCHgaj61bwCpvrEGMUzPl/7XQk71w
 BlSpBYOlB85j5P4CGhZRsYUkaAYWS5s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-XAI1rddyO9-YVd1-UsO_Jg-1; Thu,
 17 Sep 2026 14:41:55 -0400
X-MC-Unique: XAI1rddyO9-YVd1-UsO_Jg-1
X-Mimecast-MFC-AGG-ID: XAI1rddyO9-YVd1-UsO_Jg_1789670514
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A14991944D40; Thu, 17 Sep 2026 18:41:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D9EB30001A2; Thu, 17 Sep 2026 18:41:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A4CEE21E6A04; Thu, 17 Sep 2026 20:41:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,  qemu-devel@nongnu.org,  "Dr . David
 Alan Gilbert" <dave@treblig.org>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 13/20] migration: Use keyval input visitor in HMP set
 command
In-Reply-To: <aqwxSbBEIYUC5Xp_@zhexu-thinkpadt14gen5.rmtcaon.csb> (Peter Xu's
 message of "Thu, 17 Sep 2026 14:28:25 -0400")
References: <20260915000209.3692668-1-farosas@suse.de>
 <20260915000209.3692668-14-farosas@suse.de>
 <87h5jo3zl7.fsf@pond.sub.org>
 <aqwxSbBEIYUC5Xp_@zhexu-thinkpadt14gen5.rmtcaon.csb>
Date: Thu, 17 Sep 2026 20:41:51 +0200
Message-ID: <87tsnnra8g.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Sep 17, 2026 at 01:08:04PM +0200, Markus Armbruster wrote:
>> > +    } else if (g_str_equal(param, "cpr-exec-command")) {
>> >          g_autofree char **strv = NULL;
>> 
>> Not this patch's doing: initialization looks superfluous.
>
> I do see most of such cases in QEMU we initialize it to NULL.  I think it's
> a good pattern for g_autofree lines so we will never try to free garbage.

Actually necessary for g_autofree.  Ignore me :)


