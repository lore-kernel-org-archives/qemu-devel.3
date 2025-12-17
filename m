Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3472D6554E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 11:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVpl6-0007Bs-3I; Wed, 17 Dec 2025 06:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vVpl3-0007BS-Tj
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 06:31:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vVpl2-0002nh-Fe
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 06:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765971110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=utlboXMWFbKjJ4Ja62RPro+KLr0GKtroK9EXHjy18B4=;
 b=Vf9NFeUnUxbGs/0RfwWZmosXGzUi2ML39uAiyUNc+k/DvMkZhGp71hu14dS6EtHD3CxOM2
 X/+goupAFJMBjWZiz/vBXfxyOA3qQAgTmS3nRxq8XO8lrtvUyxUX6WL4AVGB+s//aqp+RC
 4fLO+eEAdE39f5Jry95C//e1WFCosOs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-TBiTx8LmO3C6ritlfnkt5g-1; Wed,
 17 Dec 2025 06:31:49 -0500
X-MC-Unique: TBiTx8LmO3C6ritlfnkt5g-1
X-Mimecast-MFC-AGG-ID: TBiTx8LmO3C6ritlfnkt5g_1765971108
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0291E1800654; Wed, 17 Dec 2025 11:31:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.156])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD43330001A2; Wed, 17 Dec 2025 11:31:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4C5A31800869; Wed, 17 Dec 2025 12:31:45 +0100 (CET)
Date: Wed, 17 Dec 2025 12:31:45 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, vkuznets@redhat.com, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v1 10/28] accel/kvm: Add notifier to inform that the KVM
 VM file fd is about to be changed
Message-ID: <5x475itwwdwvhclkebegp65gaqxx6lsezi3xhpg7zkwjogcyxa@zuqq6e2ar2ji>
References: <20251212150359.548787-1-anisinha@redhat.com>
 <20251212150359.548787-11-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212150359.548787-11-anisinha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Dec 12, 2025 at 08:33:38PM +0530, Ani Sinha wrote:
> Various subsystems might need to take some steps before the KVM file descriptor
> for a virtual machine is changed. So a new notifier is added to inform them that
> kvm VM file descriptor is about to change.
> 
> Subsequent patches will add callback implementations for specific components
> that need this notification.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  accel/kvm/kvm-all.c    | 25 +++++++++++++++++++++++++
>  accel/stubs/kvm-stub.c |  8 ++++++++
>  include/system/kvm.h   | 15 +++++++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 679cf04375..5b854c9866 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -127,6 +127,9 @@ static NotifierList kvm_irqchip_change_notifiers =
>  static NotifierWithReturnList register_vmfd_changed_notifiers =
>      NOTIFIER_WITH_RETURN_LIST_INITIALIZER(register_vmfd_changed_notifiers);
>  
> +static NotifierWithReturnList register_vmfd_pre_change_notifiers =
> +    NOTIFIER_WITH_RETURN_LIST_INITIALIZER(register_vmfd_pre_change_notifiers);

I'm wondering whenever it is better to have only one vmfd change
notifier list and pass the callback type (pre/post) as argument?

Less boilerplate.  Also I suspect there is significant overlap between
the users which must do some pre-change cleanups and post-change
re-initialization.

take care,
  Gerd


