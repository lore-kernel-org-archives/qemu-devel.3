Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC74C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsNb-0003nc-RO; Wed, 06 Mar 2024 09:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhsNZ-0003nM-4V
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:36:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhsNV-0000Ir-2a
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709735772;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Gru3gzw3VMJogQbW2Ua9aC4l1yvDtjSIVPunGTtv2DM=;
 b=b9ssCNDNFrxp9jLo8/hWWmkdl28QRcJGx4s3x7dAKhmfuwjOat9XCa9RrPTZ0sxHROVOOQ
 1aPyJGqSM+sGgQzGTq4aHew2FvkHRZbrjJtSrSCuRkV/pb6YWscvij4aMDZD7pqyezdieQ
 wYvk94B36jxaxhIrjml/4axhfi9w0aE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-IUNsR5iTOUamxhHoREpBJA-1; Wed, 06 Mar 2024 09:36:10 -0500
X-MC-Unique: IUNsR5iTOUamxhHoREpBJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D023185A786;
 Wed,  6 Mar 2024 14:36:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1085E111DD02;
 Wed,  6 Mar 2024 14:36:09 +0000 (UTC)
Date: Wed, 6 Mar 2024 14:36:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Chun Feng Wu <wucf@cn.ibm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: Does "-object" support structured options now?
Message-ID: <Zeh_WFMQU3eehD0N@redhat.com>
References: <PH7PR15MB6503236A69BD173E62FC6791F7232@PH7PR15MB6503.namprd15.prod.outlook.com>
 <ZeWA8VrzgjKjETXh@redhat.com>
 <PH7PR15MB6503A217E33561AB9E193FA5F7212@PH7PR15MB6503.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR15MB6503A217E33561AB9E193FA5F7212@PH7PR15MB6503.namprd15.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 06, 2024 at 02:33:05PM +0000, Chun Feng Wu wrote:
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

You have made a mistake somewhere in invoking it ?

The first command line you show above works fine when i test it myself.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


