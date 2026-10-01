Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EADBCA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCDJx-00060S-QI; Thu, 01 Oct 2026 05:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJt-0005zz-Lu
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJs-0003Nj-4A
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790847795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LN6FMrb+RdP+/Lhsx3lzg1zUVQVHLuS0IIaLiZWc0yk=;
 b=bcbCoMibyDMsGKl0o3dmq8mT00+zVSyagAwFz+bONdGbiAbv7Sjj03CrtzHS0ILSOfHkZW
 k8xq9BM4v5mffEBd6k5KJbmCCIk2BElOgx8Y+VmWoIYYrFp4A17E//IAEQNMNHvtXRoTCK
 BYK1CcxOH0w5MWvi4vwnVv8CU3qljqc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-2-21JjrAMwmK8r6LeUjdAg-1; Thu,
 01 Oct 2026 05:43:09 -0400
X-MC-Unique: 2-21JjrAMwmK8r6LeUjdAg-1
X-Mimecast-MFC-AGG-ID: 2-21JjrAMwmK8r6LeUjdAg_1790847788
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82CA11944D1D; Thu,  1 Oct 2026 09:43:07 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 532271956089; Thu,  1 Oct 2026 09:43:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 08/11] qemu-option: Use qemu_opts_parse_list_noisily
 where appropriate
From: marcandre.lureau@redhat.com
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Lukas Straub <lukasstraub2@web.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20260930221105.2262063-9-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
 <20260930221105.2262063-9-farosas@suse.de>
Date: Thu, 01 Oct 2026 13:42:36 +0400
Message-Id: <179084775656.2086187.14578467344159719504.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=467;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=i2rcbCW5rN3+H8T8HWTcONNAh49QFC9/1GLFlwGDNOY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvisPgYtIn01ng4moYVrfuJfC8vJPSZpImzmci
 eYIYC/l3Q6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar4rDwAKCRDa6OEJdZac
 5bkCD/0Yb8EkgHyj/UzA1Bkopw23xdm2csKlHPoa+kEslgEFXZlUqncfQef7BxNMwioJfBXKPXn
 rqzGXOsFey/R3VEB3NmQ2CJVwCvSbsXEiWoRrh2PyqSknOGkvDJ8ZVs3SdX4pxqAmSf/Eax/E4z
 dDR0pxP291imhybcmR7tIOESogPEUeOHs9M80QrHQEfNO7KRMkV+t5EVJv5XOOIpFM0Aa+pcrzK
 g9iSDYQXYN2YV2MfYJm5mRTGbc0xYdwlTcYQYdTJGYFL2D7D5p1aprM7VAjgfjVnRiFV++ilGIW
 7kWiiry7h/Tm9RBPx5fBlNm75iGkpE9UTZ94fm6bKAUUHK+z6QwDFifCCNOW7LA5bCZ0UjvHLyr
 KpzH8vZePJJLn+JqRPYWPVAels3IOFDfLR+t3FVjJSutI4lAUMcMz1jR94A20jMS/tOOLnQgD+f
 u2qUWyUmY2dGoSeaHczKm4zRSlMkTHUvVrbV48QqE+Oi+T/d6KDQya9a9KyQNHLK1pr4tvoftqW
 UoIb7qeNRAZMWodBr7QKMVRg/Fy0Hj7zKaDTwOGyBP787P04pVjaN8mhuX+s3lZSor7FT0PcGfe
 beA246OpYIfud6GTenYGut2X98ihiXLBYNcO2r3poFBxFsRdC67+0f05aQYnLwJUosk09jjdcMX
 KES6/Gv0McSY2Nw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Wed, 30 Sep 2026 19:11:02 -0300, Fabiano Rosas <farosas@suse.de> wrote:
> Change the callers of qemu_opts_parse_noisily() that currently take a
> QemuOptsList pointer to call qemu_opts_parse_list_noisily().
> 
> This is done to free up the qemu_opts_parse_noisily() version to be
> used to take the group name instead.
> 
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


