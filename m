Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0A0C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsHN-0002Jb-9A; Thu, 10 Jul 2025 10:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uZsCP-0005Q7-Ts
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:24:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uZsCL-0000FD-K8
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752157464;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z/J3LSYvzdW9R3rZIIFR/JOq86H3ZYURpWNK81iMeCA=;
 b=bbKyFeBe7vWT/7VE4aFIsxjd2ZUGbFRGRInPk6vG2lshhGhNAGsA1FklgLIbBsW6Dt+66M
 znaHkLmRi/J2PeMz8J7WhaJNqy8l/SjJ0VtRx5UQapmio1bd/4/07mqR31GstvYLYOaXlj
 3Ek0Bd7ezIiyC1sXbNhnuwyvhZ7mRlY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-GNoqnZa6N9mb3nLwZ90A5w-1; Thu,
 10 Jul 2025 10:24:20 -0400
X-MC-Unique: GNoqnZa6N9mb3nLwZ90A5w-1
X-Mimecast-MFC-AGG-ID: GNoqnZa6N9mb3nLwZ90A5w_1752157459
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF1041801210; Thu, 10 Jul 2025 14:24:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.76])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03F0E1977000; Thu, 10 Jul 2025 14:24:16 +0000 (UTC)
Date: Thu, 10 Jul 2025 15:24:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 chao.p.peng@intel.com
Subject: Re: [PATCH] i386/tdx: Fix the report of gpa in QAPI
Message-ID: <aG_NDaRJxyz_O1yj@redhat.com>
References: <20250710035538.303136-1-zhenzhong.duan@intel.com>
 <3b6c0344-0694-4a56-99dd-c7d437e43428@intel.com>
 <efbbe5f4-6f0c-4470-9968-c389cb206088@intel.com>
 <aG_KLeTIIblKbrY9@redhat.com>
 <42650134-1e4f-4d10-afb3-46f98fa0a57a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42650134-1e4f-4d10-afb3-46f98fa0a57a@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 10, 2025 at 10:21:12PM +0800, Xiaoyao Li wrote:
> On 7/10/2025 10:11 PM, Daniel P. Berrangé wrote:
> > On Thu, Jul 10, 2025 at 10:06:10PM +0800, Xiaoyao Li wrote:
> > > My original patch used (gpa == -1) as the indicator for whether gpa is
> > > valid, this needs to be cleaned up. I will send the cleanup patch.
> > 
> > The value you assign to 'gpa' doesn't matter when 'has_gpa' is false,
> > as it'll never get into the JSON event, so having it be '-1' is not
> > significantly different from leaving it on 0.
> 
> I meant cleanup the QEMU internal logic in qemu_system_guest_panicked()
> 
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -690,7 +690,7 @@ void qemu_system_guest_panicked(GuestPanicInformation
> *info)
>                            " error code: 0x%" PRIx32 " error
> message:\"%s\"\n",
>                            info->u.tdx.error_code, message);
>              g_free(message);
> -            if (info->u.tdx.gpa != -1ull) {
> +            if (info->u.tdx.has_gpa) {
>                  qemu_log_mask(LOG_GUEST_ERROR, "Additional error
> information "
>                                "can be found at gpa page: 0x%" PRIx64 "\n",
>                                info->u.tdx.gpa);

Yes, that would be better


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


