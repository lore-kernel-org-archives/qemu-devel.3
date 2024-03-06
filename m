Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A413C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsRT-0006Wg-LI; Wed, 06 Mar 2024 09:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rhsRP-0006WA-Ls
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rhsRO-0001AL-7A
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709736017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=giVr0uN5B+wsUImoh4c6PHnlOzh/h4/ezMiPhUn9ahU=;
 b=OHtBHTEY8KRvthKDdou8qadX7VT29vkwU8DvmtCSCWgCEf6yA3CMR8qgXGK92Nfl6tBWpK
 nz+0WzIMDiKESGXpVPrBt75+wH87djRjz4iTeQdi0938Bk66PEaceRgeOHAnPWlCuJZZGD
 O6EQOPdcY3VeQ5Cdj7A06ChEDX+DuW4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-PcV3m4ndM2KjdM2Zb8dxfw-1; Wed,
 06 Mar 2024 09:40:15 -0500
X-MC-Unique: PcV3m4ndM2KjdM2Zb8dxfw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 800172823F6E;
 Wed,  6 Mar 2024 14:40:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E38440C6CB7;
 Wed,  6 Mar 2024 14:40:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4953E21E6A24; Wed,  6 Mar 2024 15:40:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Chun Feng Wu <wucf@cn.ibm.com>
Cc: Daniel Berrange <berrange@redhat.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: Does "-object" support structured options now?
In-Reply-To: <PH7PR15MB6503A217E33561AB9E193FA5F7212@PH7PR15MB6503.namprd15.prod.outlook.com>
 (Chun Feng Wu's message of "Wed, 6 Mar 2024 14:33:05 +0000")
References: <PH7PR15MB6503236A69BD173E62FC6791F7232@PH7PR15MB6503.namprd15.prod.outlook.com>
 <ZeWA8VrzgjKjETXh@redhat.com>
 <PH7PR15MB6503A217E33561AB9E193FA5F7212@PH7PR15MB6503.namprd15.prod.outlook.com>
Date: Wed, 06 Mar 2024 15:40:14 +0100
Message-ID: <871q8nxw35.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Chun Feng Wu <wucf@cn.ibm.com> writes:

> Thanks Daniel for your response!
>
> I tried it with the following cmd
>
> qemu-system-x86_64 [other options...] \
>   -object '{"qom-type":"throttle-group","id":"limits0","limits":{"iops-total":200}}'
>
> And I got error:
> qemu-system-x86_64: -object {"qom-type":"throttle-group","id":"limits0","limits":{"iops-total":200}}: Parameter 'id' is missing
>
> Do you know why such error happens?

Can't reproduce the error.


