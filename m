Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8EFC83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 14:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZVh6-0002sG-Da; Wed, 09 Jul 2025 10:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uZVh4-0002s1-N4
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 10:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uZVh1-00023Q-RF
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 10:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752070957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SEITzHpEBaF4s4VWmM41Jy0yaDUzwwaQ8v87JCXNQQ4=;
 b=DXFP+cTxVn8a54WpQ5BisZA+UjXn6q440okX8D3qgYB5wHYmW+LXncQ7A0dOENTzuWtiPV
 LyY9a5bDLJwjcpkTuPnNV+8XEwCfvJoUd6UXewlt4BVgfiKAs+wy3BiAOzxnaCZT9eRuw/
 QsUfDYtEmqqQZCnkfnoQ0zv+jGzR1Bk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-yRkT9EnQN9GIwi3dXgQCgg-1; Wed,
 09 Jul 2025 10:22:33 -0400
X-MC-Unique: yRkT9EnQN9GIwi3dXgQCgg-1
X-Mimecast-MFC-AGG-ID: yRkT9EnQN9GIwi3dXgQCgg_1752070952
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7015C1955ECF; Wed,  9 Jul 2025 14:22:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.100])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04A311955E85; Wed,  9 Jul 2025 14:22:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 61DE618000B2; Wed, 09 Jul 2025 16:22:28 +0200 (CEST)
Date: Wed, 9 Jul 2025 16:22:28 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 roy.hopkins@randomman.co.uk
Subject: Re: [PATCH] igvm: add initial support for non-cc firmware in igvm
 format
Message-ID: <s2rxrnff3dhpq3y4735zwysm6g3o4fumydf6r7rpecndz4fof6@rlezrxeu2wy5>
References: <20250709123007.1039675-1-kraxel@redhat.com>
 <1c4e3024-3ba4-4ab6-a8ce-f5ab24ffe1d4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c4e3024-3ba4-4ab6-a8ce-f5ab24ffe1d4@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jul 09, 2025 at 03:34:20PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Gerd,
> 
> On 9/7/25 14:30, Gerd Hoffmann wrote:
> > Implement a ConfidentialGuestSupportClass for non-confidential VMs.
> > This allows the igvm support code work without sev/tdx.
> 
> Is this something we only want in non-KVM builds due to security
> boundary concerns?

Hmm, not sure what exactly you have in mind.  This is not about
emulating sev or something.  The IGVM format can also be used to
package native, non-confidential firmware, seabios for example.

take care,
  Gerd


